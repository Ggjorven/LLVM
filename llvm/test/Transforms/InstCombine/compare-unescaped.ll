; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

@gp = global ptr null, align 8

declare noalias ptr @malloc(i64) allockind("alloc,uninitialized") allocsize(0)

define i1 @compare_global_trivialeq() {
; CHECK-LABEL: @compare_global_trivialeq(
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 4)
  %lgp = load ptr, ptr @gp, align 8
  %cmp = icmp eq ptr %m, %lgp
  ret i1 %cmp
}

define i1 @compare_global_trivialne() {
; CHECK-LABEL: @compare_global_trivialne(
; CHECK-NEXT:    ret i1 true
;
  %m = call ptr @malloc(i64 4)
  %lgp = load ptr, ptr @gp, align 8
  %cmp = icmp ne ptr %m, %lgp
  ret i1 %cmp
}


; Although the %m is marked nocapture in the deopt operand in call to function f,
; we cannot remove the alloc site: call to malloc
; The comparison should fold to false irrespective of whether the call to malloc can be elided or not
declare void @f()
define i1 @compare_and_call_with_deopt() {
; CHECK-LABEL: @compare_and_call_with_deopt(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(24) ptr @malloc(i64 24)
; CHECK-NEXT:    tail call void @f() [ "deopt"(ptr [[M]]) ]
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 24)
  %lgp = load ptr, ptr @gp, align 8, !nonnull !0
  %cmp = icmp eq ptr %lgp, %m
  tail call void @f() [ "deopt"(ptr %m) ]
  ret i1 %cmp
}

; Same functon as above with deopt operand in function f, but comparison is NE
define i1 @compare_ne_and_call_with_deopt() {
; CHECK-LABEL: @compare_ne_and_call_with_deopt(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(24) ptr @malloc(i64 24)
; CHECK-NEXT:    tail call void @f() [ "deopt"(ptr [[M]]) ]
; CHECK-NEXT:    ret i1 true
;
  %m = call ptr @malloc(i64 24)
  %lgp = load ptr, ptr @gp, align 8, !nonnull !0
  %cmp = icmp ne ptr %lgp, %m
  tail call void @f() [ "deopt"(ptr %m) ]
  ret i1 %cmp
}

; Same function as above, but global not marked nonnull, and we cannot fold the comparison
define i1 @compare_ne_global_maybe_null() {
; CHECK-LABEL: @compare_ne_global_maybe_null(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(24) ptr @malloc(i64 24)
; CHECK-NEXT:    [[LGP:%.*]] = load ptr, ptr @gp, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne ptr [[LGP]], [[M]]
; CHECK-NEXT:    tail call void @f() [ "deopt"(ptr [[M]]) ]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %m = call ptr @malloc(i64 24)
  %lgp = load ptr, ptr @gp
  %cmp = icmp ne ptr %lgp, %m
  tail call void @f() [ "deopt"(ptr %m) ]
  ret i1 %cmp
}

; FIXME: The comparison should fold to false since %m escapes (call to function escape)
; after the comparison.
declare void @escape(ptr)
define i1 @compare_and_call_after() {
; CHECK-LABEL: @compare_and_call_after(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(24) ptr @malloc(i64 24)
; CHECK-NEXT:    [[LGP:%.*]] = load ptr, ptr @gp, align 8, !nonnull !0
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[M]], [[LGP]]
; CHECK-NEXT:    br i1 [[CMP]], label [[ESCAPE_CALL:%.*]], label [[JUST_RETURN:%.*]]
; CHECK:       escape_call:
; CHECK-NEXT:    call void @escape(ptr [[M]])
; CHECK-NEXT:    ret i1 true
; CHECK:       just_return:
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 24)
  %lgp = load ptr, ptr @gp, align 8, !nonnull !0
  %cmp = icmp eq ptr %m, %lgp
  br i1 %cmp, label %escape_call, label %just_return

escape_call:
  call void @escape(ptr %m)
  ret i1 true

just_return:
  ret i1 %cmp
}

define i1 @compare_distinct_mallocs() {
; CHECK-LABEL: @compare_distinct_mallocs(
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 4)
  %n = call ptr @malloc(i64 4)
  %cmp = icmp eq ptr %m, %n
  ret i1 %cmp
}

; the compare is folded to true since the folding compare looks through bitcasts.
; call to malloc and the bitcast instructions are elided after that since there are no uses of the malloc
define i1 @compare_samepointer_under_bitcast() {
; CHECK-LABEL: @compare_samepointer_under_bitcast(
; CHECK-NEXT:    ret i1 true
;
  %m = call ptr @malloc(i64 4)
  %cmp = icmp eq ptr %m, %m
  ret i1 %cmp
}

; the compare is folded to true since the folding compare looks through bitcasts.
; The malloc call for %m cannot be elided since it is used in the call to function f.
define i1 @compare_samepointer_escaped() {
; CHECK-LABEL: @compare_samepointer_escaped(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    call void @f() [ "deopt"(ptr [[M]]) ]
; CHECK-NEXT:    ret i1 true
;
  %m = call ptr @malloc(i64 4)
  %cmp = icmp eq ptr %m, %m
  call void @f() [ "deopt"(ptr %m) ]
  ret i1 %cmp
}

; Technically, we can fold the %cmp2 comparison, even though %m escapes through
; the ret statement since `ret` terminates the function and we cannot reach from
; the ret to cmp.
; FIXME: Folding this %cmp2 when %m escapes through ret could be an issue with
; cross-threading data dependencies since we do not make the distinction between
; atomic and non-atomic loads in capture tracking.
define ptr @compare_ret_escape(ptr %c) {
; CHECK-LABEL: @compare_ret_escape(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[N:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[N]], [[C:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[RETST:%.*]], label [[CHK:%.*]]
; CHECK:       retst:
; CHECK-NEXT:    ret ptr [[M]]
; CHECK:       chk:
; CHECK-NEXT:    [[LGP:%.*]] = load ptr, ptr @gp, align 8, !nonnull !0
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq ptr [[M]], [[LGP]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[RETST]], label [[CHK2:%.*]]
; CHECK:       chk2:
; CHECK-NEXT:    ret ptr [[N]]
;
  %m = call ptr @malloc(i64 4)
  %n = call ptr @malloc(i64 4)
  %cmp = icmp eq ptr %n, %c
  br i1 %cmp, label %retst, label %chk

retst:
  ret ptr %m

chk:
  %lgp = load ptr, ptr @gp, align 8, !nonnull !0
  %cmp2 = icmp eq ptr %m, %lgp
  br i1 %cmp2, label %retst,  label %chk2

chk2:
  ret ptr %n
}

; The malloc call for %m cannot be elided since it is used in the call to function f.
; However, the cmp can be folded to true as %n doesnt escape and %m, %n are distinct allocations
define i1 @compare_distinct_pointer_escape() {
; CHECK-LABEL: @compare_distinct_pointer_escape(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    tail call void @f() [ "deopt"(ptr [[M]]) ]
; CHECK-NEXT:    ret i1 true
;
  %m = call ptr @malloc(i64 4)
  %n = call ptr @malloc(i64 4)
  tail call void @f() [ "deopt"(ptr %m) ]
  %cmp = icmp ne ptr %m, %n
  ret i1 %cmp
}

; The next block of tests demonstrate a very subtle correctness requirement.
; We can generally assume any *single* heap layout we chose for the result of
; a malloc call, but we can't simultanious assume two different ones.  As a
; result, we must make sure that we only fold conditions if we can ensure that
; we fold *all* potentially address capturing compares the same.  This is
; the same point that applies to allocas, applied to noaiias/malloc.

; These two functions represents either a) forging a pointer via inttoptr or
; b) indexing off an adjacent allocation.  In either case, the operation is
; obscured by an uninlined helper and not visible to instcombine.
declare ptr @hidden_inttoptr()
declare ptr @hidden_offset(ptr %other)

; FIXME: Missed oppurtunity
define i1 @ptrtoint_single_cmp() {
; CHECK-LABEL: @ptrtoint_single_cmp(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[M]], inttoptr (i64 2048 to ptr)
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %m = call ptr @malloc(i64 4)
  %rhs = inttoptr i64 2048 to ptr
  %cmp = icmp eq ptr %m, %rhs
  ret i1 %cmp
}

define i1 @offset_single_cmp() {
; CHECK-LABEL: @offset_single_cmp(
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 4)
  %n = call ptr @malloc(i64 4)
  %rhs = getelementptr i8, ptr %n, i32 4
  %cmp = icmp eq ptr %m, %rhs
  ret i1 %cmp
}

declare void @witness(i1, i1)

define void @neg_consistent_fold1() {
; CHECK-LABEL: @neg_consistent_fold1(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[RHS2:%.*]] = call ptr @hidden_inttoptr()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq ptr [[M]], inttoptr (i64 2048 to ptr)
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq ptr [[M]], [[RHS2]]
; CHECK-NEXT:    call void @witness(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %m = call ptr @malloc(i64 4)
  %rhs = inttoptr i64 2048 to ptr
  %rhs2 = call ptr @hidden_inttoptr()
  %cmp1 = icmp eq ptr %m, %rhs
  %cmp2 = icmp eq ptr %m, %rhs2
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

define void @neg_consistent_fold2() {
; CHECK-LABEL: @neg_consistent_fold2(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[N:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[RHS:%.*]] = getelementptr i8, ptr [[N]], i64 4
; CHECK-NEXT:    [[RHS2:%.*]] = call ptr @hidden_offset(ptr [[N]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq ptr [[M]], [[RHS]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq ptr [[M]], [[RHS2]]
; CHECK-NEXT:    call void @witness(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %m = call ptr @malloc(i64 4)
  %n = call ptr @malloc(i64 4)
  %rhs = getelementptr i8, ptr %n, i32 4
  %rhs2 = call ptr @hidden_offset(ptr %n)
  %cmp1 = icmp eq ptr %m, %rhs
  %cmp2 = icmp eq ptr %m, %rhs2
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

define void @neg_consistent_fold3() {
; CHECK-LABEL: @neg_consistent_fold3(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[LGP:%.*]] = load ptr, ptr @gp, align 8
; CHECK-NEXT:    [[RHS2:%.*]] = call ptr @hidden_inttoptr()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq ptr [[M]], [[LGP]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq ptr [[M]], [[RHS2]]
; CHECK-NEXT:    call void @witness(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %m = call ptr @malloc(i64 4)
  %lgp = load ptr, ptr @gp, align 8
  %rhs2 = call ptr @hidden_inttoptr()
  %cmp1 = icmp eq ptr %m, %lgp
  %cmp2 = icmp eq ptr %m, %rhs2
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

; FIXME: This appears correct, but the current implementation relies
; on visiting both cmps in the same pass.  We may have an simplification order
; under which one is missed, and that would be a bug.
define void @neg_consistent_fold4() {
; CHECK-LABEL: @neg_consistent_fold4(
; CHECK-NEXT:    call void @witness(i1 false, i1 false)
; CHECK-NEXT:    ret void
;
  %m = call ptr @malloc(i64 4)
  %lgp = load ptr, ptr @gp, align 8
  %cmp1 = icmp eq ptr %m, %lgp
  %cmp2 = icmp eq ptr %m, %lgp
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

declare void @unknown(ptr)

; Points out that a nocapture call can't cause a consistent result issue
; as it is (by assumption) not able to contain a comparison which might
; capture the address.

define i1 @consistent_nocapture_inttoptr() {
; CHECK-LABEL: @consistent_nocapture_inttoptr(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    call void @unknown(ptr nocapture [[M]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[M]], inttoptr (i64 2048 to ptr)
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %m = call ptr @malloc(i64 4)
  call void @unknown(ptr nocapture %m)
  %rhs = inttoptr i64 2048 to ptr
  %cmp = icmp eq ptr %m, %rhs
  ret i1 %cmp
}

define i1 @consistent_nocapture_offset() {
; CHECK-LABEL: @consistent_nocapture_offset(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    call void @unknown(ptr nocapture [[M]])
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 4)
  call void @unknown(ptr nocapture %m)
  %n = call ptr @malloc(i64 4)
  %rhs = getelementptr i8, ptr %n, i32 4
  %cmp = icmp eq ptr %m, %rhs
  ret i1 %cmp
}

define i1 @consistent_nocapture_through_global() {
; CHECK-LABEL: @consistent_nocapture_through_global(
; CHECK-NEXT:    [[M:%.*]] = call dereferenceable_or_null(4) ptr @malloc(i64 4)
; CHECK-NEXT:    call void @unknown(ptr nocapture [[M]])
; CHECK-NEXT:    ret i1 false
;
  %m = call ptr @malloc(i64 4)
  call void @unknown(ptr nocapture %m)
  %lgp = load ptr, ptr @gp, align 8, !nonnull !0
  %cmp = icmp eq ptr %m, %lgp
  ret i1 %cmp
}

; End consistent heap layout tests

; We can fold this by assuming a single heap layout
define i1 @two_nonnull_mallocs() {
; CHECK-LABEL: @two_nonnull_mallocs(
; CHECK-NEXT:    ret i1 false
;
  %m = call nonnull ptr @malloc(i64 4)
  %n = call nonnull ptr @malloc(i64 4)
  %cmp = icmp eq ptr %m, %n
  ret i1 %cmp
}

; The address of %n is captured, but %m can be arranged to make
; the comparison non-equal.
define i1 @two_nonnull_mallocs2() {
; CHECK-LABEL: @two_nonnull_mallocs2(
; CHECK-NEXT:    [[N:%.*]] = call nonnull dereferenceable(4) ptr @malloc(i64 4)
; CHECK-NEXT:    call void @unknown(ptr nonnull [[N]])
; CHECK-NEXT:    ret i1 false
;
  %m = call nonnull ptr @malloc(i64 4)
  %n = call nonnull ptr @malloc(i64 4)
  call void @unknown(ptr %n)
  %cmp = icmp eq ptr %m, %n
  ret i1 %cmp
}

; TODO: We can fold this, but don't with the current scheme.
define i1 @two_nonnull_mallocs_hidden() {
; CHECK-LABEL: @two_nonnull_mallocs_hidden(
; CHECK-NEXT:    [[M:%.*]] = call nonnull dereferenceable(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[N:%.*]] = call nonnull dereferenceable(4) ptr @malloc(i64 4)
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i8, ptr [[M]], i64 1
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds i8, ptr [[N]], i64 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[GEP1]], [[GEP2]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %m = call nonnull ptr @malloc(i64 4)
  %n = call nonnull ptr @malloc(i64 4)
  %gep1 = getelementptr i8, ptr %m, i32 1
  %gep2 = getelementptr i8, ptr %n, i32 2
  %cmp = icmp eq ptr %gep1, %gep2
  ret i1 %cmp
}


!0 = !{}



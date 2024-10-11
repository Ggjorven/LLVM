; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1  -S | FileCheck %s

define void @test1(i1 %C, ptr %BP) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[C:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %C, label %T, label %F
T:
  store i1 %C, ptr %BP
  unreachable
F:
  ret void
}

define void @test2() personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @test2() #[[ATTR4:[0-9]+]]
; CHECK-NEXT:    ret void
;
entry:
  invoke void @test2( )
  to label %N unwind label %U
U:
  %res = landingpad { ptr }
  cleanup
  unreachable
N:
  ret void
}

declare i32 @__gxx_personality_v0(...)

define i32 @test3(i32 %v) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[V:%.*]], 2
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[COND]], i32 2, i32 1
; CHECK-NEXT:    ret i32 [[SPEC_SELECT]]
;
entry:
  switch i32 %v, label %default [
  i32 1, label %U
  i32 2, label %T
  ]
default:
  ret i32 1
U:
  unreachable
T:
  ret i32 2
}


;; We can either convert the following control-flow to a select or remove the
;; unreachable control flow because of the undef store of null. Make sure we do
;; the latter.

define void @test5(i1 %cond, ptr %ptr) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[COND:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    store i8 2, ptr [[PTR:%.*]], align 8
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cond, label %bb1, label %bb3

bb3:
  br label %bb2

bb1:
  br label %bb2

bb2:
  %ptr.2 = phi ptr [ %ptr, %bb3 ], [ null, %bb1 ]
  store i8 2, ptr %ptr.2, align 8
  ret void
}

declare void @llvm.assume(i1)
declare i1 @llvm.type.test(ptr, metadata) nounwind readnone

;; Same as the above test but make sure the unreachable control flow is still
;; removed in the presence of a type test / assume sequence.

define void @test5_type_test_assume(i1 %cond, ptr %ptr, ptr %vtable) {
; CHECK-LABEL: @test5_type_test_assume(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[COND:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[P:%.*]] = call i1 @llvm.type.test(ptr [[VTABLE:%.*]], metadata !"foo")
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[P]])
; CHECK-NEXT:    store i8 2, ptr [[PTR:%.*]], align 8
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cond, label %bb1, label %bb3

bb3:
  br label %bb2

bb1:
  br label %bb2

bb2:
  %ptr.2 = phi ptr [ %ptr, %bb3 ], [ null, %bb1 ]
  %p = call i1 @llvm.type.test(ptr %vtable, metadata !"foo")
  tail call void @llvm.assume(i1 %p)
  store i8 2, ptr %ptr.2, align 8
  ret void
}

define void @test5_no_null_opt(i1 %cond, ptr %ptr) #0 {
; CHECK-LABEL: @test5_no_null_opt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTPTR:%.*]] = select i1 [[COND:%.*]], ptr null, ptr [[PTR:%.*]]
; CHECK-NEXT:    store i8 2, ptr [[DOTPTR]], align 8
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cond, label %bb1, label %bb3

bb3:
  br label %bb2

bb1:
  br label %bb2

bb2:
  %ptr.2 = phi ptr [ %ptr, %bb3 ], [ null, %bb1 ]
  store i8 2, ptr %ptr.2, align 8
  ret void
}

define void @test6(i1 %cond, ptr %ptr) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[COND:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    store i8 2, ptr [[PTR:%.*]], align 8
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cond, label %bb1, label %bb2

bb1:
  br label %bb2

bb2:
  %ptr.2 = phi ptr [ %ptr, %entry ], [ null, %bb1 ]
  store i8 2, ptr %ptr.2, align 8
  ret void
}

define void @test6_no_null_opt(i1 %cond, ptr %ptr) #0 {
; CHECK-LABEL: @test6_no_null_opt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[COND:%.*]], ptr null, ptr [[PTR:%.*]]
; CHECK-NEXT:    store i8 2, ptr [[SPEC_SELECT]], align 8
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cond, label %bb1, label %bb2

bb1:
  br label %bb2

bb2:
  %ptr.2 = phi ptr [ %ptr, %entry ], [ null, %bb1 ]
  store i8 2, ptr %ptr.2, align 8
  ret void
}


define i32 @test7(i1 %X) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    ret i32 0
;
entry:
  br i1 %X, label %if, label %else

if:
  call void undef()
  br label %else

else:
  %phi = phi i32 [ 0, %entry ], [ 1, %if ]
  ret i32 %phi
}

define void @test8(i1 %X, ptr %Y) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    call void [[Y:%.*]]()
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call void %phi()
  ret void
}

define void @test8_no_null_opt(i1 %X, ptr %Y) #0 {
; CHECK-LABEL: @test8_no_null_opt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    call void [[SPEC_SELECT]]()
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call void %phi()
  ret void
}

declare ptr @fn_nonnull_noundef_arg(ptr nonnull noundef %p)
declare ptr @fn_nonnull_deref_arg(ptr nonnull dereferenceable(4) %p)
declare ptr @fn_nonnull_deref_or_null_arg(ptr nonnull dereferenceable_or_null(4) %p)
declare ptr @fn_nonnull_arg(ptr nonnull %p)
declare ptr @fn_noundef_arg(ptr noundef %p)
declare ptr @fn_ptr_arg(ptr)
declare ptr @fn_ptr_arg_nounwind_willreturn(ptr) nounwind willreturn

define void @test9(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_noundef_arg(ptr %phi)
  ret void
}

; Optimizing this code should produce assume.
define void @test9_deref(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_deref(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_deref_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_deref_arg(ptr %phi)
  ret void
}

; Optimizing this code should produce assume.
define void @test9_deref_or_null(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_deref_or_null(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_deref_or_null_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_deref_or_null_arg(ptr %phi)
  ret void
}

define void @test9_undef(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_undef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_noundef_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ undef, %if ]
  call ptr @fn_noundef_arg(ptr %phi)
  ret void
}

define void @test9_undef_null_defined(i1 %X, ptr %Y) #0 {
; CHECK-LABEL: @test9_undef_null_defined(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_noundef_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ undef, %if ]
  call ptr @fn_noundef_arg(ptr %phi)
  ret void
}

define void @test9_null_callsite(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_null_callsite(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_arg(ptr noundef nonnull [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_arg(ptr nonnull noundef %phi)
  ret void
}

define void @test9_gep_mismatch(i1 %X, ptr %Y,  ptr %P) {
; CHECK-LABEL: @test9_gep_mismatch(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[P:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_noundef_arg(ptr %P)
  ret void
}

define void @test9_gep_zero(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_gep_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_noundef_arg(ptr %phi)
  ret void
}

define void @test9_gep_bitcast(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_gep_bitcast(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[Y:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_noundef_arg(ptr %phi)
  ret void
}

define void @test9_gep_nonzero(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_gep_nonzero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[SPEC_SELECT]], i64 12
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr i8, ptr %phi, i64 12
  call ptr @fn_nonnull_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_inbounds_nonzero(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_gep_inbounds_nonzero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i8, ptr [[Y:%.*]], i64 12
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr inbounds i8, ptr %phi, i64 12
  call ptr @fn_nonnull_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_inbounds_nonzero_null_defined(i1 %X, ptr %Y) #0 {
; CHECK-LABEL: @test9_gep_inbounds_nonzero_null_defined(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i8, ptr [[SPEC_SELECT]], i64 12
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr inbounds i8, ptr %phi, i64 12
  call ptr @fn_nonnull_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_inbounds_unknown_null(i1 %X, ptr %Y, i64 %I) {
; CHECK-LABEL: @test9_gep_inbounds_unknown_null(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i8, ptr [[Y:%.*]], i64 [[I:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr inbounds i8, ptr %phi, i64 %I
  call ptr @fn_nonnull_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_inbounds_unknown_null_defined(i1 %X, ptr %Y, i64 %I) #0 {
; CHECK-LABEL: @test9_gep_inbounds_unknown_null_defined(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i8, ptr [[SPEC_SELECT]], i64 [[I:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr inbounds i8, ptr %phi, i64 %I
  call ptr @fn_nonnull_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_inbounds_unknown_null_call_noundef(i1 %X, ptr %Y, i64 %I) {
; CHECK-LABEL: @test9_gep_inbounds_unknown_null_call_noundef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i8, ptr [[SPEC_SELECT]], i64 [[I:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr inbounds i8, ptr %phi, i64 %I
  call ptr @fn_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_unknown_null(i1 %X, ptr %Y, i64 %I) {
; CHECK-LABEL: @test9_gep_unknown_null(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[SPEC_SELECT]], i64 [[I:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  %gep = getelementptr i8, ptr %phi, i64 %I
  call ptr @fn_nonnull_noundef_arg(ptr %gep)
  ret void
}

define void @test9_gep_unknown_undef(i1 %X, ptr %Y, i64 %I) {
; CHECK-LABEL: @test9_gep_unknown_undef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[Y:%.*]], i64 [[I:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_noundef_arg(ptr [[GEP]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ undef, %if ]
  %gep = getelementptr i8, ptr %phi, i64 %I
  call ptr @fn_noundef_arg(ptr %gep)
  ret void
}

define void @test9_missing_noundef(i1 %X, ptr %Y) {
; CHECK-LABEL: @test9_missing_noundef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_arg(ptr [[SPEC_SELECT]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_arg(ptr %phi)
  ret void
}

define void @test9_null_defined(i1 %X, ptr %Y) #0 {
; CHECK-LABEL: @test9_null_defined(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[X:%.*]], ptr null, ptr [[Y:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @fn_nonnull_noundef_arg(ptr [[SPEC_SELECT]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %X, label %if, label %else

if:
  br label %else

else:
  %phi = phi ptr [ %Y, %entry ], [ null, %if ]
  call ptr @fn_nonnull_noundef_arg(ptr %phi)
  ret void
}

define i32 @test_assume_false(i32 %cond) {
; CHECK-LABEL: @test_assume_false(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[COND:%.*]], label [[DEFAULT:%.*]] [
; CHECK-NEXT:      i32 0, label [[EXIT:%.*]]
; CHECK-NEXT:      i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:      i32 2, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       case1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       default:
; CHECK-NEXT:    unreachable
; CHECK:       exit:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 2, [[CASE1]] ], [ 3, [[CASE2]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    call void @llvm.assume(i1 true)
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  switch i32 %cond, label %default [
  i32 0, label %case0
  i32 1, label %case1
  i32 2, label %case2
  ]

case0:
  br label %exit

case1:
  br label %exit

case2:
  br label %exit

default:
  br label %exit

exit:
  %bool = phi i1 [ false, %default ], [ true, %case0 ], [ true, %case1 ], [ true, %case2 ]
  %res = phi i32 [ 0, %default ], [ 1, %case0 ], [ 2, %case1 ], [ 3, %case2 ]
  call void @llvm.assume(i1 %bool)
  ret i32 %res
}

define i32 @test_assume_undef(i32 %cond) {
; CHECK-LABEL: @test_assume_undef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[COND:%.*]], label [[DEFAULT:%.*]] [
; CHECK-NEXT:      i32 0, label [[EXIT:%.*]]
; CHECK-NEXT:      i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:      i32 2, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       case1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       default:
; CHECK-NEXT:    unreachable
; CHECK:       exit:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 2, [[CASE1]] ], [ 3, [[CASE2]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    call void @llvm.assume(i1 true)
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  switch i32 %cond, label %default [
  i32 0, label %case0
  i32 1, label %case1
  i32 2, label %case2
  ]

case0:
  br label %exit

case1:
  br label %exit

case2:
  br label %exit

default:
  br label %exit

exit:
  %bool = phi i1 [ undef, %default ], [ true, %case0 ], [ true, %case1 ], [ true, %case2 ]
  %res = phi i32 [ 0, %default ], [ 1, %case0 ], [ 2, %case1 ], [ 3, %case2 ]
  call void @llvm.assume(i1 %bool)
  ret i32 %res
}

define i32 @test_assume_var(i32 %cond, i1 %var) {
; CHECK-LABEL: @test_assume_var(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[COND:%.*]], label [[DEFAULT:%.*]] [
; CHECK-NEXT:      i32 0, label [[EXIT:%.*]]
; CHECK-NEXT:      i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:      i32 2, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       case1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       default:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[BOOL:%.*]] = phi i1 [ [[VAR:%.*]], [[DEFAULT]] ], [ true, [[CASE1]] ], [ true, [[CASE2]] ], [ true, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 0, [[DEFAULT]] ], [ 2, [[CASE1]] ], [ 3, [[CASE2]] ], [ 1, [[ENTRY]] ]
; CHECK-NEXT:    call void @llvm.assume(i1 [[BOOL]])
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  switch i32 %cond, label %default [
  i32 0, label %case0
  i32 1, label %case1
  i32 2, label %case2
  ]

case0:
  br label %exit

case1:
  br label %exit

case2:
  br label %exit

default:
  br label %exit

exit:
  %bool = phi i1 [ %var, %default ], [ true, %case0 ], [ true, %case1 ], [ true, %case2 ]
  %res = phi i32 [ 0, %default ], [ 1, %case0 ], [ 2, %case1 ], [ 3, %case2 ]
  call void @llvm.assume(i1 %bool)
  ret i32 %res
}

define i32 @test_assume_bundle_nonnull(i32 %cond, ptr nonnull %p) {
; CHECK-LABEL: @test_assume_bundle_nonnull(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[COND:%.*]], label [[DEFAULT:%.*]] [
; CHECK-NEXT:      i32 0, label [[EXIT:%.*]]
; CHECK-NEXT:      i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:      i32 2, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       case1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       default:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[PTR:%.*]] = phi ptr [ null, [[DEFAULT]] ], [ [[P:%.*]], [[CASE1]] ], [ [[P]], [[CASE2]] ], [ [[P]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 0, [[DEFAULT]] ], [ 2, [[CASE1]] ], [ 3, [[CASE2]] ], [ 1, [[ENTRY]] ]
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "nonnull"(ptr [[PTR]]) ]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  switch i32 %cond, label %default [
  i32 0, label %case0
  i32 1, label %case1
  i32 2, label %case2
  ]

case0:
  br label %exit

case1:
  br label %exit

case2:
  br label %exit

default:
  br label %exit

exit:
  %ptr = phi ptr [ null, %default ], [ %p, %case0 ], [ %p, %case1 ], [ %p, %case2 ]
  %res = phi i32 [ 0, %default ], [ 1, %case0 ], [ 2, %case1 ], [ 3, %case2 ]
  call void @llvm.assume(i1 true) [ "nonnull"(ptr %ptr) ]
  ret i32 %res
}

define i32 @test_assume_bundle_align(i32 %cond, ptr nonnull %p) {
; CHECK-LABEL: @test_assume_bundle_align(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[COND:%.*]], label [[DEFAULT:%.*]] [
; CHECK-NEXT:      i32 0, label [[EXIT:%.*]]
; CHECK-NEXT:      i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:      i32 2, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       case1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       default:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[PTR:%.*]] = phi ptr [ null, [[DEFAULT]] ], [ [[P:%.*]], [[CASE1]] ], [ [[P]], [[CASE2]] ], [ [[P]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 0, [[DEFAULT]] ], [ 2, [[CASE1]] ], [ 3, [[CASE2]] ], [ 1, [[ENTRY]] ]
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[PTR]], i32 8) ]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  switch i32 %cond, label %default [
  i32 0, label %case0
  i32 1, label %case1
  i32 2, label %case2
  ]

case0:
  br label %exit

case1:
  br label %exit

case2:
  br label %exit

default:
  br label %exit

exit:
  %ptr = phi ptr [ null, %default ], [ %p, %case0 ], [ %p, %case1 ], [ %p, %case2 ]
  %res = phi i32 [ 0, %default ], [ 1, %case0 ], [ 2, %case1 ], [ 3, %case2 ]
  call void @llvm.assume(i1 true) [ "align"(ptr %ptr, i32 8) ]
  ret i32 %res
}

; From bb to bb5 is UB.
define i32 @test9_null_user_order_1(ptr %arg, i1 %arg1, ptr %arg2) {
; CHECK-LABEL: @test9_null_user_order_1(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[ARG1:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[I:%.*]] = load ptr, ptr [[ARG:%.*]], align 8
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i8, ptr [[I]], i64 1
; CHECK-NEXT:    store ptr [[I4]], ptr [[ARG]], align 8
; CHECK-NEXT:    [[I7:%.*]] = load i32, ptr [[I]], align 4
; CHECK-NEXT:    [[I8:%.*]] = icmp ne ptr [[I]], [[ARG2:%.*]]
; CHECK-NEXT:    call void @fn_ptr_arg(i1 [[I8]])
; CHECK-NEXT:    ret i32 [[I7]]
;
bb:
  br i1 %arg1, label %bb5, label %bb3

bb3:                                              ; preds = %bb
  %i = load ptr, ptr %arg, align 8
  %i4 = getelementptr inbounds i8, ptr %i, i64 1
  store ptr %i4, ptr %arg, align 8
  br label %bb5

bb5:                                              ; preds = %bb3, %bb
  %i6 = phi ptr [ %i, %bb3 ], [ null, %bb ]
  %i7 = load i32, ptr %i6, align 4
  %i8 = icmp ne ptr %i6, %arg2
  call void @fn_ptr_arg(i1 %i8)
  ret i32 %i7
}

define i32 @test9_null_user_order_2(ptr %arg, i1 %arg1, ptr %arg2) {
; CHECK-LABEL: @test9_null_user_order_2(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[ARG1:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    [[I:%.*]] = load ptr, ptr [[ARG:%.*]], align 8
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i8, ptr [[I]], i64 1
; CHECK-NEXT:    store ptr [[I4]], ptr [[ARG]], align 8
; CHECK-NEXT:    [[I8:%.*]] = icmp ne ptr [[I]], [[ARG2:%.*]]
; CHECK-NEXT:    call void @fn_ptr_arg_nounwind_willreturn(i1 [[I8]])
; CHECK-NEXT:    [[I7:%.*]] = load i32, ptr [[I]], align 4
; CHECK-NEXT:    ret i32 [[I7]]
;
bb:
  br i1 %arg1, label %bb5, label %bb3

bb3:                                              ; preds = %bb
  %i = load ptr, ptr %arg, align 8
  %i4 = getelementptr inbounds i8, ptr %i, i64 1
  store ptr %i4, ptr %arg, align 8
  br label %bb5

bb5:                                              ; preds = %bb3, %bb
  %i6 = phi ptr [ %i, %bb3 ], [ null, %bb ]
  %i8 = icmp ne ptr %i6, %arg2
  call void @fn_ptr_arg_nounwind_willreturn(i1 %i8)
  %i7 = load i32, ptr %i6, align 4
  ret i32 %i7
}

declare void @side.effect()
declare i8 @get.i8()

define i8 @udiv_by_zero(i8 %x, i8 %i, i8 %v) {
; CHECK-LABEL: @udiv_by_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[I:%.*]], label [[SW_DEFAULT:%.*]] [
; CHECK-NEXT:      i8 9, label [[SW_BB2:%.*]]
; CHECK-NEXT:      i8 2, label [[RETURN:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb2:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.default:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[Y:%.*]] = phi i8 [ 9, [[SW_BB2]] ], [ [[V:%.*]], [[SW_DEFAULT]] ], [ 2, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[R:%.*]] = udiv i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  switch i8 %i, label %sw.default [
  i8 0, label %sw.bb0
  i8 2, label %sw.bb1
  i8 9, label %sw.bb2
  ]

sw.bb0:
  br label %return

sw.bb1:
  br label %return
sw.bb2:
  br label %return
sw.default:
  br label %return

return:
  %y = phi i8 [ 0, %sw.bb0 ], [ 2, %sw.bb1 ], [ 9, %sw.bb2 ], [ %v, %sw.default ]
  %r = udiv i8 %x, %y
  ret i8 %r
}

define i8 @urem_by_zero(i8 %x, i8 %i, i8 %v) {
; CHECK-LABEL: @urem_by_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[I:%.*]], label [[SW_DEFAULT:%.*]] [
; CHECK-NEXT:      i8 0, label [[RETURN:%.*]]
; CHECK-NEXT:      i8 2, label [[SW_BB1:%.*]]
; CHECK-NEXT:      i8 9, label [[SW_BB2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb1:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.bb2:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.default:
; CHECK-NEXT:    unreachable
; CHECK:       return:
; CHECK-NEXT:    [[Y:%.*]] = phi i8 [ 2, [[SW_BB1]] ], [ 9, [[SW_BB2]] ], [ [[V:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[R:%.*]] = urem i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  switch i8 %i, label %sw.default [
  i8 0, label %sw.bb0
  i8 2, label %sw.bb1
  i8 9, label %sw.bb2
  ]

sw.bb0:
  br label %return

sw.bb1:
  br label %return
sw.bb2:
  br label %return
sw.default:
  br label %return

return:
  %y = phi i8 [ %v, %sw.bb0 ], [ 2, %sw.bb1 ], [ 9, %sw.bb2 ], [ 0, %sw.default ]
  %r = urem i8 %x, %y
  ret i8 %r
}

define i8 @udiv_of_zero_okay(i8 %x, i8 %i, i8 %v) {
; CHECK-LABEL: @udiv_of_zero_okay(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[I:%.*]], label [[SW_DEFAULT:%.*]] [
; CHECK-NEXT:      i8 0, label [[RETURN:%.*]]
; CHECK-NEXT:      i8 2, label [[SW_BB1:%.*]]
; CHECK-NEXT:      i8 9, label [[SW_BB2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb1:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.bb2:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.default:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[Y:%.*]] = phi i8 [ 2, [[SW_BB1]] ], [ 9, [[SW_BB2]] ], [ [[V:%.*]], [[SW_DEFAULT]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[R:%.*]] = udiv i8 [[Y]], [[X:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  switch i8 %i, label %sw.default [
  i8 0, label %sw.bb0
  i8 2, label %sw.bb1
  i8 9, label %sw.bb2
  ]

sw.bb0:
  br label %return

sw.bb1:
  br label %return
sw.bb2:
  br label %return
sw.default:
  br label %return

return:
  %y = phi i8 [ 0, %sw.bb0 ], [ 2, %sw.bb1 ], [ 9, %sw.bb2 ], [ %v, %sw.default ]
  %r = udiv i8 %y, %x
  ret i8 %r
}

define i8 @srem_by_zero(i8 %x, i8 %i) {
; CHECK-LABEL: @srem_by_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I:%.*]], 9
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @side.effect()
; CHECK-NEXT:    unreachable
; CHECK:       if.else:
; CHECK-NEXT:    [[V:%.*]] = call i8 @get.i8()
; CHECK-NEXT:    [[R:%.*]] = srem i8 [[X:%.*]], [[V]]
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  %cmp = icmp ult i8 %i, 9
  br i1 %cmp, label %if.then, label %if.else

if.then:
  call void @side.effect()
  br label %if.end

if.else:
  %v = call i8 @get.i8()
  br label %if.end

if.end:
  %y = phi i8 [ 0, %if.then ], [ %v, %if.else ]
  %r = srem i8 %x, %y
  ret i8 %r
}

define i8 @srem_no_overflow_okay(i8 %i) {
; CHECK-LABEL: @srem_no_overflow_okay(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I:%.*]], 9
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @side.effect()
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[V:%.*]] = call i8 @get.i8()
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[Y:%.*]] = phi i8 [ -1, [[IF_THEN]] ], [ [[V]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[R:%.*]] = srem i8 [[Y]], -128
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  %cmp = icmp ult i8 %i, 9
  br i1 %cmp, label %if.then, label %if.else

if.then:
  call void @side.effect()
  br label %if.end

if.else:
  %v = call i8 @get.i8()
  br label %if.end

if.end:
  %y = phi i8 [ -1, %if.then ], [ %v, %if.else ]
  %r = srem i8 %y, 128
  ret i8 %r
}

define i8 @sdiv_overflow_ub(i8 %i) {
; CHECK-LABEL: @sdiv_overflow_ub(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[I:%.*]], label [[SW_DEFAULT:%.*]] [
; CHECK-NEXT:      i8 0, label [[RETURN:%.*]]
; CHECK-NEXT:      i8 2, label [[SW_BB1:%.*]]
; CHECK-NEXT:      i8 9, label [[SW_BB2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb1:
; CHECK-NEXT:    [[V:%.*]] = call i8 @get.i8()
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.bb2:
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.default:
; CHECK-NEXT:    unreachable
; CHECK:       return:
; CHECK-NEXT:    [[Y:%.*]] = phi i8 [ [[V]], [[SW_BB1]] ], [ -1, [[SW_BB2]] ], [ 4, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[R:%.*]] = sdiv i8 -128, [[Y]]
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  switch i8 %i, label %sw.default [
  i8 0, label %sw.bb0
  i8 2, label %sw.bb1
  i8 9, label %sw.bb2
  ]

sw.bb0:
  br label %return
sw.bb1:
  %v = call i8 @get.i8()
  br label %return
sw.bb2:
  br label %return
sw.default:
  unreachable

return:
  %y = phi i8 [ 4, %sw.bb0 ], [ %v, %sw.bb1 ], [ -1, %sw.bb2 ]
  %r = sdiv i8 128, %y
  ret i8 %r
}

define i8 @sdiv_overflow_ub_2x(i8 %i) {
; CHECK-LABEL: @sdiv_overflow_ub_2x(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[I:%.*]], label [[SW_DEFAULT:%.*]] [
; CHECK-NEXT:      i8 9, label [[RETURN:%.*]]
; CHECK-NEXT:      i8 2, label [[SW_BB1:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb1:
; CHECK-NEXT:    [[V:%.*]] = call i8 @get.i8()
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       sw.default:
; CHECK-NEXT:    unreachable
; CHECK:       return:
; CHECK-NEXT:    [[Y:%.*]] = phi i8 [ [[V]], [[SW_BB1]] ], [ -1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[R:%.*]] = sdiv i8 -128, [[Y]]
; CHECK-NEXT:    ret i8 [[R]]
;
entry:
  switch i8 %i, label %sw.default [
  i8 0, label %sw.bb0
  i8 2, label %sw.bb1
  i8 9, label %sw.bb2
  ]

sw.bb0:
  br label %return
sw.bb1:
  %v = call i8 @get.i8()
  br label %return
sw.bb2:
  br label %return
sw.default:
  unreachable

return:
  %y = phi i8 [ 0, %sw.bb0 ], [ %v, %sw.bb1 ], [ -1, %sw.bb2 ]
  %r = sdiv i8 128, %y
  ret i8 %r
}

attributes #0 = { null_pointer_is_valid }
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { null_pointer_is_valid }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { nounwind willreturn }
; CHECK: attributes #[[ATTR4]] = { nounwind }
;.

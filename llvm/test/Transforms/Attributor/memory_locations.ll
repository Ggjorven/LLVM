; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

@G = external dso_local global i32, align 4

declare noalias ptr @malloc(i64) inaccessiblememonly

;.
; CHECK: @G = external dso_local global i32, align 4
;.
define dso_local ptr @internal_only(i32 %arg) {
; CHECK: Function Attrs: memory(inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_only
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[ARG]] to i64
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @malloc(i64 [[CONV]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %conv = sext i32 %arg to i64
  %call = call ptr @malloc(i64 %conv)
  ret ptr %call
}

define dso_local ptr @internal_only_rec(i32 %arg) {
; CHECK: Function Attrs: memory(inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_only_rec
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REM:%.*]] = srem i32 [[ARG]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[REM]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[ARG]], 2
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @internal_only_rec(i32 [[DIV]])
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[ARG]] to i64
; CHECK-NEXT:    [[CALL1:%.*]] = call noalias ptr @malloc(i64 [[CONV]])
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ [[CALL]], [[IF_THEN]] ], [ [[CALL1]], [[IF_END]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  %rem = srem i32 %arg, 2
  %cmp = icmp eq i32 %rem, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %div = sdiv i32 %arg, 2
  %call = call ptr @internal_only_rec(i32 %div)
  br label %return

if.end:                                           ; preds = %entry
  %conv = sext i32 %arg to i64
  %call1 = call ptr @malloc(i64 %conv)
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi ptr [ %call, %if.then ], [ %call1, %if.end ]
  ret ptr %retval.0
}

define dso_local ptr @internal_only_rec_static_helper(i32 %arg) {
; CHECK: Function Attrs: memory(inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_only_rec_static_helper
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_only_rec_static(i32 [[ARG]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = call ptr @internal_only_rec_static(i32 %arg)
  ret ptr %call
}

define internal ptr @internal_only_rec_static(i32 %arg) {
; CHECK: Function Attrs: memory(inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_only_rec_static
; CHECK-SAME: (i32 [[ARG:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REM:%.*]] = srem i32 [[ARG]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[REM]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[ARG]], 2
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_only_rec(i32 [[DIV]])
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[ARG]] to i64
; CHECK-NEXT:    [[CALL1:%.*]] = call noalias ptr @malloc(i64 [[CONV]])
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ [[CALL]], [[IF_THEN]] ], [ [[CALL1]], [[IF_END]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  %rem = srem i32 %arg, 2
  %cmp = icmp eq i32 %rem, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %div = sdiv i32 %arg, 2
  %call = call ptr @internal_only_rec(i32 %div)
  br label %return

if.end:                                           ; preds = %entry
  %conv = sext i32 %arg to i64
  %call1 = call ptr @malloc(i64 %conv)
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi ptr [ %call, %if.then ], [ %call1, %if.end ]
  ret ptr %retval.0
}

define dso_local ptr @internal_only_rec_static_helper_malloc_noescape(i32 %arg) {
; FIXME: This is actually inaccessiblememonly because the malloced memory does not escape
; CHECK-LABEL: define {{[^@]+}}@internal_only_rec_static_helper_malloc_noescape
; CHECK-SAME: (i32 [[ARG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_only_rec_static_malloc_noescape(i32 [[ARG]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = call ptr @internal_only_rec_static_malloc_noescape(i32 %arg)
  ret ptr %call
}

define internal ptr @internal_only_rec_static_malloc_noescape(i32 %arg) {
; FIXME: This is actually inaccessiblememonly because the malloced memory does not escape
; CHECK-LABEL: define {{[^@]+}}@internal_only_rec_static_malloc_noescape
; CHECK-SAME: (i32 [[ARG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REM:%.*]] = srem i32 [[ARG]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[REM]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[ARG]], 2
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_only_rec(i32 [[DIV]])
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[ARG]] to i64
; CHECK-NEXT:    [[CALL1:%.*]] = call noalias ptr @malloc(i64 [[CONV]])
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ [[CALL]], [[IF_THEN]] ], [ null, [[IF_END]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  %rem = srem i32 %arg, 2
  %cmp = icmp eq i32 %rem, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %div = sdiv i32 %arg, 2
  %call = call ptr @internal_only_rec(i32 %div)
  br label %return

if.end:                                           ; preds = %entry
  %conv = sext i32 %arg to i64
  %call1 = call ptr @malloc(i64 %conv)
  store i8 0, ptr %call1
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi ptr [ %call, %if.then ], [ null, %if.end ]
  ret ptr %retval.0
}

define dso_local ptr @internal_argmem_only_read(ptr %arg) {
; CHECK: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_argmem_only_read
; CHECK-SAME: (ptr nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[ARG:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = load i32, ptr [[ARG]], align 4
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[TMP]] to i64
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @malloc(i64 [[CONV]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %tmp = load i32, ptr %arg, align 4
  %conv = sext i32 %tmp to i64
  %call = call ptr @malloc(i64 %conv)
  ret ptr %call
}

define dso_local ptr @internal_argmem_only_write(ptr %arg) {
; CHECK: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_argmem_only_write
; CHECK-SAME: (ptr nocapture nofree noundef nonnull writeonly align 4 dereferenceable(4) [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 10, ptr [[ARG]], align 4
; CHECK-NEXT:    [[CALL:%.*]] = call noalias noundef dereferenceable_or_null(10) ptr @malloc(i64 noundef 10)
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  store i32 10, ptr %arg, align 4
  %call = call dereferenceable_or_null(10) ptr @malloc(i64 10)
  ret ptr %call
}

define dso_local ptr @internal_argmem_only_rec(ptr %arg) {
; TUNIT: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; TUNIT-LABEL: define {{[^@]+}}@internal_argmem_only_rec
; TUNIT-SAME: (ptr nocapture nofree [[ARG:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_argmem_only_rec_1(ptr nocapture nofree noundef align 4 [[ARG]])
; TUNIT-NEXT:    ret ptr [[CALL]]
;
; CGSCC: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; CGSCC-LABEL: define {{[^@]+}}@internal_argmem_only_rec
; CGSCC-SAME: (ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[ARG:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_argmem_only_rec_1(ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[ARG]])
; CGSCC-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = call ptr @internal_argmem_only_rec_1(ptr %arg)
  ret ptr %call
}

define internal ptr @internal_argmem_only_rec_1(ptr %arg) {
; CHECK: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_argmem_only_rec_1
; CHECK-SAME: (ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = load i32, ptr [[ARG]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARG]], align 4
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[TMP1]], 1
; CHECK-NEXT:    br i1 [[CMP1]], label [[IF_THEN2:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then2:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[ARG]], i64 -1
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_argmem_only_rec_2(ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[ADD_PTR]])
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARG]], align 4
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[TMP2]] to i64
; CHECK-NEXT:    [[CALL4:%.*]] = call noalias ptr @malloc(i64 [[CONV]])
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ null, [[IF_THEN]] ], [ [[CALL]], [[IF_THEN2]] ], [ [[CALL4]], [[IF_END3]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  %tmp = load i32, ptr %arg, align 4
  %cmp = icmp eq i32 %tmp, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %return

if.end:                                           ; preds = %entry
  %tmp1 = load i32, ptr %arg, align 4
  %cmp1 = icmp eq i32 %tmp1, 1
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  %add.ptr = getelementptr inbounds i32, ptr %arg, i64 -1
  %call = call ptr @internal_argmem_only_rec_2(ptr nonnull %add.ptr)
  br label %return

if.end3:                                          ; preds = %if.end
  %tmp2 = load i32, ptr %arg, align 4
  %conv = sext i32 %tmp2 to i64
  %call4 = call ptr @malloc(i64 %conv)
  br label %return

return:                                           ; preds = %if.end3, %if.then2, %if.then
  %retval.0 = phi ptr [ null, %if.then ], [ %call, %if.then2 ], [ %call4, %if.end3 ]
  ret ptr %retval.0
}

define internal ptr @internal_argmem_only_rec_2(ptr %arg) {
; CHECK: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@internal_argmem_only_rec_2
; CHECK-SAME: (ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 0, ptr [[ARG]], align 4
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[ARG]], i64 -1
; CHECK-NEXT:    [[CALL:%.*]] = call noalias ptr @internal_argmem_only_rec_1(ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[ADD_PTR]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  store i32 0, ptr %arg, align 4
  %add.ptr = getelementptr inbounds i32, ptr %arg, i64 -1
  %call = call ptr @internal_argmem_only_rec_1(ptr nonnull %add.ptr)
  ret ptr %call
}

declare ptr @unknown_ptr() readnone
declare ptr @argmem_only(ptr %arg) argmemonly
declare ptr @inaccesible_argmem_only_decl(ptr %arg) inaccessiblemem_or_argmemonly
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) nounwind argmemonly willreturn

define void @callerA1(ptr %arg) {
; CHECK: Function Attrs: memory(argmem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@callerA1
; CHECK-SAME: (ptr [[ARG:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @argmem_only(ptr [[ARG]])
; CHECK-NEXT:    ret void
;
  call ptr @argmem_only(ptr %arg)
  ret void
}
define void @callerA2(ptr %arg) {
; CHECK: Function Attrs: memory(argmem: readwrite, inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@callerA2
; CHECK-SAME: (ptr [[ARG:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @inaccesible_argmem_only_decl(ptr [[ARG]])
; CHECK-NEXT:    ret void
;
  call ptr @inaccesible_argmem_only_decl(ptr %arg)
  ret void
}
define void @callerB1() {
; CHECK: Function Attrs: memory(none)
; CHECK-LABEL: define {{[^@]+}}@callerB1
; CHECK-SAME: () #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:    [[STACK:%.*]] = alloca i8, align 1
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @argmem_only(ptr noundef nonnull dereferenceable(1) [[STACK]])
; CHECK-NEXT:    ret void
;
  %stack = alloca i8
  call ptr @argmem_only(ptr %stack)
  ret void
}
define void @callerB2() {
; CHECK: Function Attrs: memory(inaccessiblemem: readwrite)
; CHECK-LABEL: define {{[^@]+}}@callerB2
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    [[STACK:%.*]] = alloca i8, align 1
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @inaccesible_argmem_only_decl(ptr noundef nonnull dereferenceable(1) [[STACK]])
; CHECK-NEXT:    ret void
;
  %stack = alloca i8
  call ptr @inaccesible_argmem_only_decl(ptr %stack)
  ret void
}
define void @callerC1() {
; CHECK-LABEL: define {{[^@]+}}@callerC1() {
; CHECK-NEXT:    [[UNKNOWN:%.*]] = call ptr @unknown_ptr()
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @argmem_only(ptr [[UNKNOWN]])
; CHECK-NEXT:    ret void
;
  %unknown = call ptr @unknown_ptr()
  call ptr @argmem_only(ptr %unknown)
  ret void
}
define void @callerC2() {
; CHECK-LABEL: define {{[^@]+}}@callerC2() {
; CHECK-NEXT:    [[UNKNOWN:%.*]] = call ptr @unknown_ptr()
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @inaccesible_argmem_only_decl(ptr [[UNKNOWN]])
; CHECK-NEXT:    ret void
;
  %unknown = call ptr @unknown_ptr()
  call ptr @inaccesible_argmem_only_decl(ptr %unknown)
  ret void
}
define void @callerD1() {
; CHECK-LABEL: define {{[^@]+}}@callerD1() {
; CHECK-NEXT:    [[UNKNOWN:%.*]] = call ptr @argmem_only(ptr noundef align 4294967296 null)
; CHECK-NEXT:    store i8 0, ptr [[UNKNOWN]], align 1
; CHECK-NEXT:    ret void
;
  %unknown = call ptr @argmem_only(ptr null)
  store i8 0, ptr %unknown
  ret void
}
define void @callerD2() {
; CHECK-LABEL: define {{[^@]+}}@callerD2() {
; CHECK-NEXT:    [[UNKNOWN:%.*]] = call ptr @inaccesible_argmem_only_decl(ptr noundef align 4294967296 null)
; CHECK-NEXT:    store i8 0, ptr [[UNKNOWN]], align 1
; CHECK-NEXT:    ret void
;
  %unknown = call ptr @inaccesible_argmem_only_decl(ptr null)
  store i8 0, ptr %unknown
  ret void
}

define void @callerE(ptr %arg) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@callerE
; CHECK-SAME: (ptr nocapture nofree readnone [[ARG:%.*]]) #[[ATTR5:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  call void @llvm.lifetime.start.p0(i64 4, ptr %arg)
  ret void
}


define void @write_global() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; CHECK-LABEL: define {{[^@]+}}@write_global
; CHECK-SAME: () #[[ATTR6:[0-9]+]] {
; CHECK-NEXT:    store i32 0, ptr @G, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr @G, align 4
  ret void
}
define void @write_global_via_arg(ptr %GPtr) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; CHECK-LABEL: define {{[^@]+}}@write_global_via_arg
; CHECK-SAME: (ptr nocapture nofree noundef nonnull writeonly align 4 dereferenceable(4) [[GPTR:%.*]]) #[[ATTR7:[0-9]+]] {
; CHECK-NEXT:    store i32 0, ptr [[GPTR]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %GPtr, align 4
  ret void
}
define internal void @write_global_via_arg_internal(ptr %GPtr) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none)
; CHECK-LABEL: define {{[^@]+}}@write_global_via_arg_internal
; CHECK-SAME: () #[[ATTR8:[0-9]+]] {
; CHECK-NEXT:    store i32 0, ptr @G, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %GPtr, align 4
  ret void
}

define void @writeonly_global() {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; TUNIT-LABEL: define {{[^@]+}}@writeonly_global
; TUNIT-SAME: () #[[ATTR6]] {
; TUNIT-NEXT:    call void @write_global() #[[ATTR12:[0-9]+]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(write)
; CGSCC-LABEL: define {{[^@]+}}@writeonly_global
; CGSCC-SAME: () #[[ATTR9:[0-9]+]] {
; CGSCC-NEXT:    call void @write_global() #[[ATTR13:[0-9]+]]
; CGSCC-NEXT:    ret void
;
  call void @write_global()
  ret void
}
define void @writeonly_global_via_arg() {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; TUNIT-LABEL: define {{[^@]+}}@writeonly_global_via_arg
; TUNIT-SAME: () #[[ATTR6]] {
; TUNIT-NEXT:    call void @write_global_via_arg(ptr nocapture nofree noundef nonnull writeonly align 4 dereferenceable(4) @G) #[[ATTR12]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(write)
; CGSCC-LABEL: define {{[^@]+}}@writeonly_global_via_arg
; CGSCC-SAME: () #[[ATTR9]] {
; CGSCC-NEXT:    call void @write_global_via_arg(ptr nocapture nofree noundef nonnull writeonly align 4 dereferenceable(4) @G) #[[ATTR13]]
; CGSCC-NEXT:    ret void
;
  call void @write_global_via_arg(ptr @G)
  ret void
}

define void @writeonly_global_via_arg_internal() {
;
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; TUNIT-LABEL: define {{[^@]+}}@writeonly_global_via_arg_internal
; TUNIT-SAME: () #[[ATTR6]] {
; TUNIT-NEXT:    call void @write_global_via_arg_internal() #[[ATTR12]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(write)
; CGSCC-LABEL: define {{[^@]+}}@writeonly_global_via_arg_internal
; CGSCC-SAME: () #[[ATTR9]] {
; CGSCC-NEXT:    call void @write_global_via_arg_internal() #[[ATTR13]]
; CGSCC-NEXT:    ret void
;
  call void @write_global_via_arg_internal(ptr @G)
  ret void
}

define i8 @recursive_not_readnone(ptr %ptr, i1 %c) {
; TUNIT: Function Attrs: nofree nosync nounwind memory(argmem: write)
; TUNIT-LABEL: define {{[^@]+}}@recursive_not_readnone
; TUNIT-SAME: (ptr nocapture nofree writeonly [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR9:[0-9]+]] {
; TUNIT-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       t:
; TUNIT-NEXT:    [[TMP1:%.*]] = call i8 @recursive_not_readnone(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR13:[0-9]+]]
; TUNIT-NEXT:    ret i8 1
; TUNIT:       f:
; TUNIT-NEXT:    store i8 1, ptr [[PTR]], align 1
; TUNIT-NEXT:    ret i8 0
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(argmem: write)
; CGSCC-LABEL: define {{[^@]+}}@recursive_not_readnone
; CGSCC-SAME: (ptr nocapture nofree writeonly [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR10:[0-9]+]] {
; CGSCC-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       t:
; CGSCC-NEXT:    [[TMP1:%.*]] = call i8 @recursive_not_readnone(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR14:[0-9]+]]
; CGSCC-NEXT:    ret i8 1
; CGSCC:       f:
; CGSCC-NEXT:    store i8 1, ptr [[PTR]], align 1
; CGSCC-NEXT:    ret i8 0
;
  %alloc = alloca i8
  br i1 %c, label %t, label %f
t:
  call i8 @recursive_not_readnone(ptr %alloc, i1 false)
  %r = load i8, ptr %alloc
  ret i8 %r
f:
  store i8 1, ptr %ptr
  ret i8 0
}

define internal i8 @recursive_not_readnone_internal(ptr %ptr, i1 %c) {
; TUNIT: Function Attrs: nofree nosync nounwind memory(argmem: write)
; TUNIT-LABEL: define {{[^@]+}}@recursive_not_readnone_internal
; TUNIT-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR9]] {
; TUNIT-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       t:
; TUNIT-NEXT:    [[TMP1:%.*]] = call i8 @recursive_not_readnone_internal(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR13]]
; TUNIT-NEXT:    ret i8 1
; TUNIT:       f:
; TUNIT-NEXT:    store i8 1, ptr [[PTR]], align 1
; TUNIT-NEXT:    ret i8 0
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(argmem: write)
; CGSCC-LABEL: define {{[^@]+}}@recursive_not_readnone_internal
; CGSCC-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR10]] {
; CGSCC-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       t:
; CGSCC-NEXT:    [[TMP1:%.*]] = call i8 @recursive_not_readnone_internal(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR14]]
; CGSCC-NEXT:    ret i8 1
; CGSCC:       f:
; CGSCC-NEXT:    store i8 1, ptr [[PTR]], align 1
; CGSCC-NEXT:    ret i8 0
;
  %alloc = alloca i8
  br i1 %c, label %t, label %f
t:
  call i8 @recursive_not_readnone_internal(ptr %alloc, i1 false)
  %r = load i8, ptr %alloc
  ret i8 %r
f:
  store i8 1, ptr %ptr
  ret i8 0
}

define i8 @readnone_caller(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind memory(none)
; TUNIT-LABEL: define {{[^@]+}}@readnone_caller
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR10:[0-9]+]] {
; TUNIT-NEXT:    [[A:%.*]] = alloca i8, align 1
; TUNIT-NEXT:    [[R:%.*]] = call i8 @recursive_not_readnone_internal(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[A]], i1 noundef [[C]]) #[[ATTR13]]
; TUNIT-NEXT:    ret i8 [[R]]
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(none)
; CGSCC-LABEL: define {{[^@]+}}@readnone_caller
; CGSCC-SAME: (i1 noundef [[C:%.*]]) #[[ATTR11:[0-9]+]] {
; CGSCC-NEXT:    [[A:%.*]] = alloca i8, align 1
; CGSCC-NEXT:    [[R:%.*]] = call i8 @recursive_not_readnone_internal(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[A]], i1 noundef [[C]]) #[[ATTR15:[0-9]+]]
; CGSCC-NEXT:    ret i8 [[R]]
;
  %a = alloca i8
  %r = call i8 @recursive_not_readnone_internal(ptr %a, i1 %c)
  ret i8 %r
}

define internal i8 @recursive_readnone_internal2(ptr %ptr, i1 %c) {
; TUNIT: Function Attrs: nofree nosync nounwind memory(argmem: write)
; TUNIT-LABEL: define {{[^@]+}}@recursive_readnone_internal2
; TUNIT-SAME: (ptr noalias nocapture nofree writeonly [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR9]] {
; TUNIT-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       t:
; TUNIT-NEXT:    [[TMP1:%.*]] = call i8 @recursive_readnone_internal2(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR13]]
; TUNIT-NEXT:    ret i8 1
; TUNIT:       f:
; TUNIT-NEXT:    store i8 1, ptr [[PTR]], align 1
; TUNIT-NEXT:    ret i8 0
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(argmem: write)
; CGSCC-LABEL: define {{[^@]+}}@recursive_readnone_internal2
; CGSCC-SAME: (ptr noalias nocapture nofree writeonly [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR10]] {
; CGSCC-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       t:
; CGSCC-NEXT:    [[TMP1:%.*]] = call i8 @recursive_readnone_internal2(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR14]]
; CGSCC-NEXT:    ret i8 1
; CGSCC:       f:
; CGSCC-NEXT:    store i8 1, ptr [[PTR]], align 1
; CGSCC-NEXT:    ret i8 0
;
  %alloc = alloca i8
  br i1 %c, label %t, label %f
t:
  call i8 @recursive_readnone_internal2(ptr %alloc, i1 false)
  %r = load i8, ptr %alloc
  ret i8 %r
f:
  store i8 1, ptr %ptr
  ret i8 0
}

define i8 @readnone_caller2(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind memory(none)
; TUNIT-LABEL: define {{[^@]+}}@readnone_caller2
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR10]] {
; TUNIT-NEXT:    [[R:%.*]] = call i8 @recursive_readnone_internal2(ptr undef, i1 noundef [[C]]) #[[ATTR13]]
; TUNIT-NEXT:    ret i8 [[R]]
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(none)
; CGSCC-LABEL: define {{[^@]+}}@readnone_caller2
; CGSCC-SAME: (i1 noundef [[C:%.*]]) #[[ATTR11]] {
; CGSCC-NEXT:    [[R:%.*]] = call i8 @recursive_readnone_internal2(ptr nofree undef, i1 noundef [[C]]) #[[ATTR15]]
; CGSCC-NEXT:    ret i8 [[R]]
;
  %r = call i8 @recursive_readnone_internal2(ptr undef, i1 %c)
  ret i8 %r
}

define internal i8 @recursive_not_readnone_internal3(ptr %ptr, i1 %c) {
; TUNIT: Function Attrs: nofree nosync nounwind memory(argmem: write)
; TUNIT-LABEL: define {{[^@]+}}@recursive_not_readnone_internal3
; TUNIT-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR9]] {
; TUNIT-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       t:
; TUNIT-NEXT:    [[TMP1:%.*]] = call i8 @recursive_not_readnone_internal3(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR13]]
; TUNIT-NEXT:    ret i8 1
; TUNIT:       f:
; TUNIT-NEXT:    store i8 1, ptr [[PTR]], align 1
; TUNIT-NEXT:    ret i8 0
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(argmem: write)
; CGSCC-LABEL: define {{[^@]+}}@recursive_not_readnone_internal3
; CGSCC-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[PTR:%.*]], i1 noundef [[C:%.*]]) #[[ATTR10]] {
; CGSCC-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       t:
; CGSCC-NEXT:    [[TMP1:%.*]] = call i8 @recursive_not_readnone_internal3(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef false) #[[ATTR14]]
; CGSCC-NEXT:    ret i8 1
; CGSCC:       f:
; CGSCC-NEXT:    store i8 1, ptr [[PTR]], align 1
; CGSCC-NEXT:    ret i8 0
;
  %alloc = alloca i8
  br i1 %c, label %t, label %f
t:
  call i8 @recursive_not_readnone_internal3(ptr %alloc, i1 false)
  %r = load i8, ptr %alloc
  ret i8 %r
f:
  store i8 1, ptr %ptr
  ret i8 0
}

define i8 @readnone_caller3(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind memory(none)
; TUNIT-LABEL: define {{[^@]+}}@readnone_caller3
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR10]] {
; TUNIT-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; TUNIT-NEXT:    [[R:%.*]] = call i8 @recursive_not_readnone_internal3(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef [[C]]) #[[ATTR13]]
; TUNIT-NEXT:    ret i8 [[R]]
;
; CGSCC: Function Attrs: nofree nosync nounwind memory(none)
; CGSCC-LABEL: define {{[^@]+}}@readnone_caller3
; CGSCC-SAME: (i1 noundef [[C:%.*]]) #[[ATTR11]] {
; CGSCC-NEXT:    [[ALLOC:%.*]] = alloca i8, align 1
; CGSCC-NEXT:    [[R:%.*]] = call i8 @recursive_not_readnone_internal3(ptr noalias nocapture nofree noundef nonnull writeonly dereferenceable(1) [[ALLOC]], i1 noundef [[C]]) #[[ATTR15]]
; CGSCC-NEXT:    ret i8 [[R]]
;
  %alloc = alloca i8
  %r = call i8 @recursive_not_readnone_internal3(ptr %alloc, i1 %c)
  ret i8 %r
}

define internal void @argmemonly_before_ipconstprop(ptr %p) argmemonly {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none)
; CHECK-LABEL: define {{[^@]+}}@argmemonly_before_ipconstprop
; CHECK-SAME: () #[[ATTR8]] {
; CHECK-NEXT:    store i32 0, ptr @G, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %p
  ret void
}

define void @argmemonly_caller() {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; TUNIT-LABEL: define {{[^@]+}}@argmemonly_caller
; TUNIT-SAME: () #[[ATTR6]] {
; TUNIT-NEXT:    call void @argmemonly_before_ipconstprop() #[[ATTR12]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(write)
; CGSCC-LABEL: define {{[^@]+}}@argmemonly_caller
; CGSCC-SAME: () #[[ATTR9]] {
; CGSCC-NEXT:    call void @argmemonly_before_ipconstprop() #[[ATTR13]]
; CGSCC-NEXT:    ret void
;
  call void @argmemonly_before_ipconstprop(ptr @G)
  ret void
}

declare ptr @no_mem_unknown_ptr(ptr %arg) memory(none)

define void @argmem_and_unknown(i1 %c, ptr %arg) memory(argmem: readwrite) {
; TUNIT: Function Attrs: nosync memory(argmem: write)
; TUNIT-LABEL: define {{[^@]+}}@argmem_and_unknown
; TUNIT-SAME: (i1 noundef [[C:%.*]], ptr writeonly [[ARG:%.*]]) #[[ATTR11:[0-9]+]] {
; TUNIT-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; TUNIT:       t:
; TUNIT-NEXT:    [[P:%.*]] = call ptr @no_mem_unknown_ptr(ptr noalias readnone [[ARG]]) #[[ATTR14:[0-9]+]]
; TUNIT-NEXT:    store i32 0, ptr [[P]], align 4
; TUNIT-NEXT:    br label [[F]]
; TUNIT:       f:
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync memory(argmem: write)
; CGSCC-LABEL: define {{[^@]+}}@argmem_and_unknown
; CGSCC-SAME: (i1 noundef [[C:%.*]], ptr writeonly [[ARG:%.*]]) #[[ATTR12:[0-9]+]] {
; CGSCC-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CGSCC:       t:
; CGSCC-NEXT:    [[P:%.*]] = call ptr @no_mem_unknown_ptr(ptr noalias readnone [[ARG]]) #[[ATTR16:[0-9]+]]
; CGSCC-NEXT:    store i32 0, ptr [[P]], align 4
; CGSCC-NEXT:    br label [[F]]
; CGSCC:       f:
; CGSCC-NEXT:    ret void
;
  br i1 %c, label %t, label %f
t:
  %p = call ptr @no_mem_unknown_ptr(ptr %arg)
  store i32 0, ptr %p
  br label %f
f:
  ret void
}
;.
; TUNIT: attributes #[[ATTR0]] = { memory(inaccessiblemem: readwrite) }
; TUNIT: attributes #[[ATTR1]] = { memory(argmem: readwrite, inaccessiblemem: readwrite) }
; TUNIT: attributes #[[ATTR2]] = { memory(none) }
; TUNIT: attributes #[[ATTR3]] = { memory(argmem: readwrite) }
; TUNIT: attributes #[[ATTR4:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
; TUNIT: attributes #[[ATTR5]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; TUNIT: attributes #[[ATTR6]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write) }
; TUNIT: attributes #[[ATTR7]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) }
; TUNIT: attributes #[[ATTR8]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none) }
; TUNIT: attributes #[[ATTR9]] = { nofree nosync nounwind memory(argmem: write) }
; TUNIT: attributes #[[ATTR10]] = { nofree norecurse nosync nounwind memory(none) }
; TUNIT: attributes #[[ATTR11]] = { nosync memory(argmem: write) }
; TUNIT: attributes #[[ATTR12]] = { nofree nosync nounwind willreturn memory(write) }
; TUNIT: attributes #[[ATTR13]] = { nofree nosync nounwind memory(write) }
; TUNIT: attributes #[[ATTR14]] = { nosync }
;.
; CGSCC: attributes #[[ATTR0]] = { memory(inaccessiblemem: readwrite) }
; CGSCC: attributes #[[ATTR1]] = { memory(argmem: readwrite, inaccessiblemem: readwrite) }
; CGSCC: attributes #[[ATTR2]] = { memory(none) }
; CGSCC: attributes #[[ATTR3]] = { memory(argmem: readwrite) }
; CGSCC: attributes #[[ATTR4:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
; CGSCC: attributes #[[ATTR5]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR6]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write) }
; CGSCC: attributes #[[ATTR7]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) }
; CGSCC: attributes #[[ATTR8]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none) }
; CGSCC: attributes #[[ATTR9]] = { mustprogress nofree nosync nounwind willreturn memory(write) }
; CGSCC: attributes #[[ATTR10]] = { nofree nosync nounwind memory(argmem: write) }
; CGSCC: attributes #[[ATTR11]] = { nofree nosync nounwind memory(none) }
; CGSCC: attributes #[[ATTR12]] = { nosync memory(argmem: write) }
; CGSCC: attributes #[[ATTR13]] = { nofree nounwind willreturn memory(write) }
; CGSCC: attributes #[[ATTR14]] = { nofree nosync nounwind memory(write) }
; CGSCC: attributes #[[ATTR15]] = { nofree nounwind memory(write) }
; CGSCC: attributes #[[ATTR16]] = { nosync }
;.

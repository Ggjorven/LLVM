; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=wasm32-unknown-unknown -S --passes=expand-variadics --expand-variadics-override=optimize < %s | FileCheck %s -check-prefixes=OPT
; RUN: opt -mtriple=wasm32-unknown-unknown -S --passes=expand-variadics --expand-variadics-override=lowering < %s | FileCheck %s -check-prefixes=ABI
; REQUIRES: webassembly-registered-target

; CHECK: @sink
declare void @sink(...)


define void @pass_byval(ptr byval(i32) %b) {
; OPT-LABEL: @pass_byval(
; OPT-NEXT:  entry:
; OPT-NEXT:    tail call void (...) @sink(ptr byval(i32) [[B:%.*]])
; OPT-NEXT:    ret void
;
; ABI-LABEL: @pass_byval(
; ABI-NEXT:  entry:
; ABI-NEXT:    [[VARARG_BUFFER:%.*]] = alloca [[PASS_BYVAL_VARARG:%.*]], align 16
; ABI-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    [[TMP0:%.*]] = getelementptr inbounds nuw [[PASS_BYVAL_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 0
; ABI-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[TMP0]], ptr [[B:%.*]], i64 4, i1 false)
; ABI-NEXT:    call void @sink(ptr [[VARARG_BUFFER]])
; ABI-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    ret void
;
entry:
  tail call void (...) @sink(ptr byval(i32) %b)
  ret void
}

%struct.libcS = type { i8, i16, i32, i32, float, double }

define void @i32_libcS_byval(i32 %x, ptr noundef byval(%struct.libcS) align 8 %y) {
; OPT-LABEL: @i32_libcS_byval(
; OPT-NEXT:  entry:
; OPT-NEXT:    tail call void (...) @sink(i32 [[X:%.*]], ptr byval([[STRUCT_LIBCS:%.*]]) align 8 [[Y:%.*]])
; OPT-NEXT:    ret void
;
; ABI-LABEL: @i32_libcS_byval(
; ABI-NEXT:  entry:
; ABI-NEXT:    [[INDIRECTALLOCA:%.*]] = alloca [[STRUCT_LIBCS:%.*]], align 8
; ABI-NEXT:    [[VARARG_BUFFER:%.*]] = alloca [[I32_LIBCS_BYVAL_VARARG:%.*]], align 16
; ABI-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[INDIRECTALLOCA]], ptr [[Y:%.*]], i64 24, i1 false)
; ABI-NEXT:    call void @llvm.lifetime.start.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    [[TMP0:%.*]] = getelementptr inbounds nuw [[I32_LIBCS_BYVAL_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 0
; ABI-NEXT:    store i32 [[X:%.*]], ptr [[TMP0]], align 4
; ABI-NEXT:    [[TMP1:%.*]] = getelementptr inbounds nuw [[I32_LIBCS_BYVAL_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 1
; ABI-NEXT:    store ptr [[INDIRECTALLOCA]], ptr [[TMP1]], align 4
; ABI-NEXT:    call void @sink(ptr [[VARARG_BUFFER]])
; ABI-NEXT:    call void @llvm.lifetime.end.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    ret void
;
entry:
  tail call void (...) @sink(i32 %x, ptr byval(%struct.libcS) align 8 %y)
  ret void
}

define void @libcS_i32_byval(ptr byval(%struct.libcS) align 8 %x, i32 %y) {
; OPT-LABEL: @libcS_i32_byval(
; OPT-NEXT:  entry:
; OPT-NEXT:    tail call void (...) @sink(ptr byval([[STRUCT_LIBCS:%.*]]) align 8 [[X:%.*]], i32 [[Y:%.*]])
; OPT-NEXT:    ret void
;
; ABI-LABEL: @libcS_i32_byval(
; ABI-NEXT:  entry:
; ABI-NEXT:    [[INDIRECTALLOCA:%.*]] = alloca [[STRUCT_LIBCS:%.*]], align 8
; ABI-NEXT:    [[VARARG_BUFFER:%.*]] = alloca [[LIBCS_I32_BYVAL_VARARG:%.*]], align 16
; ABI-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[INDIRECTALLOCA]], ptr [[X:%.*]], i64 24, i1 false)
; ABI-NEXT:    call void @llvm.lifetime.start.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    [[TMP0:%.*]] = getelementptr inbounds nuw [[LIBCS_I32_BYVAL_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 0
; ABI-NEXT:    store ptr [[INDIRECTALLOCA]], ptr [[TMP0]], align 4
; ABI-NEXT:    [[TMP1:%.*]] = getelementptr inbounds nuw [[LIBCS_I32_BYVAL_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 1
; ABI-NEXT:    store i32 [[Y:%.*]], ptr [[TMP1]], align 4
; ABI-NEXT:    call void @sink(ptr [[VARARG_BUFFER]])
; ABI-NEXT:    call void @llvm.lifetime.end.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    ret void
;
entry:
  tail call void (...) @sink(ptr byval(%struct.libcS) align 8 %x, i32 %y)
  ret void
}


define void @pass_byref(ptr byref(i32) %b) {
; OPT-LABEL: @pass_byref(
; OPT-NEXT:  entry:
; OPT-NEXT:    tail call void (...) @sink(ptr byref(i32) [[B:%.*]])
; OPT-NEXT:    ret void
;
; ABI-LABEL: @pass_byref(
; ABI-NEXT:  entry:
; ABI-NEXT:    [[VARARG_BUFFER:%.*]] = alloca [[PASS_BYREF_VARARG:%.*]], align 16
; ABI-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    [[TMP0:%.*]] = getelementptr inbounds nuw [[PASS_BYREF_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 0
; ABI-NEXT:    store ptr [[B:%.*]], ptr [[TMP0]], align 4
; ABI-NEXT:    call void @sink(ptr [[VARARG_BUFFER]])
; ABI-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    ret void
;
entry:
  tail call void (...) @sink(ptr byref(i32) %b)
  ret void
}

define void @i32_libcS_byref(i32 %x, ptr noundef byref(%struct.libcS) align 8 %y) {
; OPT-LABEL: @i32_libcS_byref(
; OPT-NEXT:  entry:
; OPT-NEXT:    tail call void (...) @sink(i32 [[X:%.*]], ptr byref([[STRUCT_LIBCS:%.*]]) align 8 [[Y:%.*]])
; OPT-NEXT:    ret void
;
; ABI-LABEL: @i32_libcS_byref(
; ABI-NEXT:  entry:
; ABI-NEXT:    [[INDIRECTALLOCA:%.*]] = alloca [[STRUCT_LIBCS:%.*]], align 8
; ABI-NEXT:    [[VARARG_BUFFER:%.*]] = alloca [[I32_LIBCS_BYREF_VARARG:%.*]], align 16
; ABI-NEXT:    store ptr [[Y:%.*]], ptr [[INDIRECTALLOCA]], align 4
; ABI-NEXT:    call void @llvm.lifetime.start.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    [[TMP0:%.*]] = getelementptr inbounds nuw [[I32_LIBCS_BYREF_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 0
; ABI-NEXT:    store i32 [[X:%.*]], ptr [[TMP0]], align 4
; ABI-NEXT:    [[TMP1:%.*]] = getelementptr inbounds nuw [[I32_LIBCS_BYREF_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 1
; ABI-NEXT:    store ptr [[INDIRECTALLOCA]], ptr [[TMP1]], align 4
; ABI-NEXT:    call void @sink(ptr [[VARARG_BUFFER]])
; ABI-NEXT:    call void @llvm.lifetime.end.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    ret void
;
entry:
  tail call void (...) @sink(i32 %x, ptr byref(%struct.libcS) align 8 %y)
  ret void
}

define void @libcS_i32_byref(ptr byref(%struct.libcS) align 8 %x, i32 %y) {
; OPT-LABEL: @libcS_i32_byref(
; OPT-NEXT:  entry:
; OPT-NEXT:    tail call void (...) @sink(ptr byref([[STRUCT_LIBCS:%.*]]) align 8 [[X:%.*]], i32 [[Y:%.*]])
; OPT-NEXT:    ret void
;
; ABI-LABEL: @libcS_i32_byref(
; ABI-NEXT:  entry:
; ABI-NEXT:    [[INDIRECTALLOCA:%.*]] = alloca [[STRUCT_LIBCS:%.*]], align 8
; ABI-NEXT:    [[VARARG_BUFFER:%.*]] = alloca [[LIBCS_I32_BYREF_VARARG:%.*]], align 16
; ABI-NEXT:    store ptr [[X:%.*]], ptr [[INDIRECTALLOCA]], align 4
; ABI-NEXT:    call void @llvm.lifetime.start.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    [[TMP0:%.*]] = getelementptr inbounds nuw [[LIBCS_I32_BYREF_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 0
; ABI-NEXT:    store ptr [[INDIRECTALLOCA]], ptr [[TMP0]], align 4
; ABI-NEXT:    [[TMP1:%.*]] = getelementptr inbounds nuw [[LIBCS_I32_BYREF_VARARG]], ptr [[VARARG_BUFFER]], i32 0, i32 1
; ABI-NEXT:    store i32 [[Y:%.*]], ptr [[TMP1]], align 4
; ABI-NEXT:    call void @sink(ptr [[VARARG_BUFFER]])
; ABI-NEXT:    call void @llvm.lifetime.end.p0(i64 8, ptr [[VARARG_BUFFER]])
; ABI-NEXT:    ret void
;
entry:
  tail call void (...) @sink(ptr byref(%struct.libcS) align 8 %x, i32 %y)
  ret void
}

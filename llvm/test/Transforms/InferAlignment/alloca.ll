; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=infer-alignment -S | FileCheck %s

; ------------------------------------------------------------------------------
; Scalar type
; ------------------------------------------------------------------------------

define void @alloca_local(i8 %x, i32 %y) {
; CHECK-LABEL: define void @alloca_local
; CHECK-SAME: (i8 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[ALLOCA:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[LOAD_I8:%.*]] = load i8, ptr [[ALLOCA]], align 4
; CHECK-NEXT:    [[LOAD_I32:%.*]] = load i32, ptr [[ALLOCA]], align 4
; CHECK-NEXT:    store i8 [[X]], ptr [[ALLOCA]], align 4
; CHECK-NEXT:    store i32 [[Y]], ptr [[ALLOCA]], align 4
; CHECK-NEXT:    ret void
;
  %alloca = alloca i32, align 1

  %load.i8 = load i8, ptr %alloca, align 1
  %load.i32 = load i32, ptr %alloca, align 1

  store i8 %x, ptr %alloca, align 1
  store i32 %y, ptr %alloca, align 1

  ret void
}

; ------------------------------------------------------------------------------
; Struct type
; ------------------------------------------------------------------------------

%struct.pair = type { { i32, i32 }, { i32, i32 } }

define void @alloca_struct(i32 %x) {
; CHECK-LABEL: define void @alloca_struct
; CHECK-SAME: (i32 [[X:%.*]]) {
; CHECK-NEXT:    [[ALLOCA_STRUCT:%.*]] = alloca [[STRUCT_PAIR:%.*]], align 8
; CHECK-NEXT:    [[GEP_0:%.*]] = getelementptr [[STRUCT_PAIR]], ptr [[ALLOCA_STRUCT]], i64 0, i32 1
; CHECK-NEXT:    [[GEP_1:%.*]] = getelementptr { i32, i32 }, ptr [[GEP_0]], i64 0, i32 1
; CHECK-NEXT:    [[LOAD_2:%.*]] = load i32, ptr [[GEP_0]], align 8
; CHECK-NEXT:    store i32 0, ptr [[GEP_0]], align 8
; CHECK-NEXT:    [[LOAD_1:%.*]] = load i32, ptr [[GEP_1]], align 4
; CHECK-NEXT:    store i32 0, ptr [[GEP_1]], align 4
; CHECK-NEXT:    ret void
;
  %alloca.struct = alloca %struct.pair

  %gep.0 = getelementptr %struct.pair, ptr %alloca.struct, i64 0, i32 1
  %gep.1 = getelementptr { i32, i32 }, ptr %gep.0, i64 0, i32 1

  %load.2 = load i32, ptr %gep.0, align 1
  store i32 0, ptr %gep.0, align 1

  %load.1 = load i32, ptr %gep.1, align 1
  store i32 0, ptr %gep.1, align 1

  ret void
}

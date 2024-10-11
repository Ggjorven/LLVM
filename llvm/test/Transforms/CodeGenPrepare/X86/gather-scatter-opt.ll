; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' < %s | FileCheck %s

target datalayout =
"e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128"
target triple = "x86_64-unknown-linux-gnu"

%struct.a = type { i32, i32 }
@c = external dso_local global %struct.a, align 4
@glob_array = internal unnamed_addr constant [16 x i32] [i32 1, i32 1, i32 2, i32 3, i32 5, i32 8, i32 13, i32 21, i32 34, i32 55, i32 89, i32 144, i32 233, i32 377, i32 610, i32 987], align 16

define <4 x i32> @splat_base(ptr %base, <4 x i64> %index) {
; CHECK-LABEL: @splat_base(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[BASE:%.*]], <4 x i64> [[INDEX:%.*]]
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[TMP1]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %broadcast.splatinsert = insertelement <4 x ptr> undef, ptr %base, i32 0
  %broadcast.splat = shufflevector <4 x ptr> %broadcast.splatinsert, <4 x ptr> undef, <4 x i32> zeroinitializer
  %gep = getelementptr i32, <4 x ptr> %broadcast.splat, <4 x i64> %index
  %res = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %gep, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  ret <4 x i32> %res
}

define <4 x i32> @splat_struct(ptr %base) {
; CHECK-LABEL: @splat_struct(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [[STRUCT_A:%.*]], ptr [[BASE:%.*]], i64 0, i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, ptr [[TMP1]], <4 x i64> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[TMP2]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %gep = getelementptr %struct.a, ptr %base, <4 x i64> zeroinitializer, i32 1
  %res = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %gep, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  ret <4 x i32> %res
}

define <4 x i32> @scalar_index(ptr %base, i64 %index) {
; CHECK-LABEL: @scalar_index(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[BASE:%.*]], i64 [[INDEX:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, ptr [[TMP1]], <4 x i64> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[TMP2]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %broadcast.splatinsert = insertelement <4 x ptr> undef, ptr %base, i32 0
  %broadcast.splat = shufflevector <4 x ptr> %broadcast.splatinsert, <4 x ptr> undef, <4 x i32> zeroinitializer
  %gep = getelementptr i32, <4 x ptr> %broadcast.splat, i64 %index
  %res = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %gep, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  ret <4 x i32> %res
}

define <4 x i32> @splat_index(ptr %base, i64 %index) {
; CHECK-LABEL: @splat_index(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[BASE:%.*]], i64 [[INDEX:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, ptr [[TMP1]], <4 x i64> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[TMP2]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %gep = getelementptr i32, ptr %base, <4 x i64> %broadcast.splat
  %res = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %gep, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  ret <4 x i32> %res
}

define <4 x i32> @test_global_array(<4 x i64> %indxs) {
; CHECK-LABEL: @test_global_array(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr @glob_array, <4 x i64> [[INDXS:%.*]]
; CHECK-NEXT:    [[G:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[TMP1]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[G]]
;
  %p = getelementptr inbounds [16 x i32], ptr @glob_array, i64 0, <4 x i64> %indxs
  %g = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %p, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  ret <4 x i32> %g
}

define <4 x i32> @global_struct_splat() {
; CHECK-LABEL: @global_struct_splat(
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> <ptr getelementptr ([[STRUCT_A:%.*]], ptr @c, i64 0, i32 1), ptr getelementptr ([[STRUCT_A]], ptr @c, i64 0, i32 1), ptr getelementptr ([[STRUCT_A]], ptr @c, i64 0, i32 1), ptr getelementptr ([[STRUCT_A]], ptr @c, i64 0, i32 1)>, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[TMP1]]
;
  %1 = insertelement <4 x ptr> undef, ptr @c, i32 0
  %2 = shufflevector <4 x ptr> %1, <4 x ptr> undef, <4 x i32> zeroinitializer
  %3 = getelementptr %struct.a, <4 x ptr> %2, <4 x i64> zeroinitializer, i32 1
  %4 = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %3, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
  ret <4 x i32> %4
}

define <4 x i32> @splat_ptr_gather(ptr %ptr, <4 x i1> %mask, <4 x i32> %passthru) {
; CHECK-LABEL: @splat_ptr_gather(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[PTR:%.*]], <4 x i64> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[TMP1]], i32 4, <4 x i1> [[MASK:%.*]], <4 x i32> [[PASSTHRU:%.*]])
; CHECK-NEXT:    ret <4 x i32> [[TMP2]]
;
  %1 = insertelement <4 x ptr> undef, ptr %ptr, i32 0
  %2 = shufflevector <4 x ptr> %1, <4 x ptr> undef, <4 x i32> zeroinitializer
  %3 = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %2, i32 4, <4 x i1> %mask, <4 x i32> %passthru)
  ret <4 x i32> %3
}

define void @splat_ptr_scatter(ptr %ptr, <4 x i1> %mask, <4 x i32> %val) {
; CHECK-LABEL: @splat_ptr_scatter(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, ptr [[PTR:%.*]], <4 x i64> zeroinitializer
; CHECK-NEXT:    call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> [[VAL:%.*]], <4 x ptr> [[TMP1]], i32 4, <4 x i1> [[MASK:%.*]])
; CHECK-NEXT:    ret void
;
  %1 = insertelement <4 x ptr> undef, ptr %ptr, i32 0
  %2 = shufflevector <4 x ptr> %1, <4 x ptr> undef, <4 x i32> zeroinitializer
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> %val, <4 x ptr> %2, i32 4, <4 x i1> %mask)
  ret void
}

declare <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr>, i32, <4 x i1>, <4 x i32>)
declare void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>, <4 x ptr>, i32, <4 x i1>)

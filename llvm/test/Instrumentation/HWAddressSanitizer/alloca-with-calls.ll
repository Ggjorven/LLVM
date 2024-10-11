; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; Test alloca instrumentation when tags are generated by HWASan function.
;
; RUN: opt < %s -passes=hwasan -hwasan-generate-tags-with-calls -S | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-android"

declare void @use32(ptr)

define void @test_alloca() sanitize_hwaddress {
; CHECK-LABEL: define void @test_alloca
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @llvm.thread.pointer()
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i8, ptr [[TMP0]], i32 48
; CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr [[TMP1]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = ashr i64 [[TMP2]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.read_register.i64(metadata [[META1:![0-9]+]])
; CHECK-NEXT:    [[TMP5:%.*]] = call ptr @llvm.frameaddress.p0(i32 0)
; CHECK-NEXT:    [[TMP6:%.*]] = ptrtoint ptr [[TMP5]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = shl i64 [[TMP6]], 44
; CHECK-NEXT:    [[TMP8:%.*]] = or i64 [[TMP4]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = inttoptr i64 [[TMP2]] to ptr
; CHECK-NEXT:    store i64 [[TMP8]], ptr [[TMP9]], align 8
; CHECK-NEXT:    [[TMP10:%.*]] = ashr i64 [[TMP2]], 56
; CHECK-NEXT:    [[TMP11:%.*]] = shl nuw nsw i64 [[TMP10]], 12
; CHECK-NEXT:    [[TMP12:%.*]] = xor i64 [[TMP11]], -1
; CHECK-NEXT:    [[TMP13:%.*]] = add i64 [[TMP2]], 8
; CHECK-NEXT:    [[TMP14:%.*]] = and i64 [[TMP13]], [[TMP12]]
; CHECK-NEXT:    store i64 [[TMP14]], ptr [[TMP1]], align 8
; CHECK-NEXT:    [[TMP15:%.*]] = or i64 [[TMP2]], 4294967295
; CHECK-NEXT:    [[HWASAN_SHADOW:%.*]] = add i64 [[TMP15]], 1
; CHECK-NEXT:    [[TMP16:%.*]] = inttoptr i64 [[HWASAN_SHADOW]] to ptr
; CHECK-NEXT:    [[HWASAN_UAR_TAG:%.*]] = lshr i64 [[TMP6]], 56
; CHECK-NEXT:    [[X:%.*]] = alloca { i32, [12 x i8] }, align 16
; CHECK-NEXT:    [[TMP17:%.*]] = call i8 @__hwasan_generate_tag()
; CHECK-NEXT:    [[TMP18:%.*]] = zext i8 [[TMP17]] to i64
; CHECK-NEXT:    [[TMP19:%.*]] = ptrtoint ptr [[X]] to i64
; CHECK-NEXT:    [[TMP20:%.*]] = and i64 [[TMP19]], 72057594037927935
; CHECK-NEXT:    [[TMP21:%.*]] = shl i64 [[TMP18]], 56
; CHECK-NEXT:    [[TMP22:%.*]] = or i64 [[TMP20]], [[TMP21]]
; CHECK-NEXT:    [[X_HWASAN:%.*]] = inttoptr i64 [[TMP22]] to ptr
; CHECK-NEXT:    [[TMP23:%.*]] = trunc i64 [[TMP18]] to i8
; CHECK-NEXT:    [[TMP24:%.*]] = ptrtoint ptr [[X]] to i64
; CHECK-NEXT:    [[TMP25:%.*]] = and i64 [[TMP24]], 72057594037927935
; CHECK-NEXT:    [[TMP26:%.*]] = lshr i64 [[TMP25]], 4
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr i8, ptr [[TMP16]], i64 [[TMP26]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[TMP27]], i8 [[TMP23]], i64 1, i1 false)
; CHECK-NEXT:    call void @use32(ptr nonnull [[X_HWASAN]])
; CHECK-NEXT:    [[TMP28:%.*]] = trunc i64 [[HWASAN_UAR_TAG]] to i8
; CHECK-NEXT:    [[TMP29:%.*]] = ptrtoint ptr [[X]] to i64
; CHECK-NEXT:    [[TMP30:%.*]] = and i64 [[TMP29]], 72057594037927935
; CHECK-NEXT:    [[TMP31:%.*]] = lshr i64 [[TMP30]], 4
; CHECK-NEXT:    [[TMP32:%.*]] = getelementptr i8, ptr [[TMP16]], i64 [[TMP31]]
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[TMP32]], i8 [[TMP28]], i64 1, i1 false)
; CHECK-NEXT:    ret void
;

entry:
  %x = alloca i32, align 4
  call void @use32(ptr nonnull %x)
  ret void
}

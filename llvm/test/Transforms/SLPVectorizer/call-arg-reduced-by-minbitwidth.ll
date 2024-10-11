; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: %if x86-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=x86_64-pc-windows-msvc19.34.0 < %s | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s %}

define void @test(ptr %0, i8 %1, i1 %cmp12.i) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr [[TMP0:%.*]], i8 [[TMP1:%.*]], i1 [[CMP12_I:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <8 x i1> poison, i1 [[CMP12_I]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i1> [[TMP2]], <8 x i1> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <8 x i8> poison, i8 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <8 x i8> [[TMP4]], <8 x i8> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    br label [[PRE:%.*]]
; CHECK:       pre:
; CHECK-NEXT:    [[TMP8:%.*]] = call <8 x i8> @llvm.umax.v8i8(<8 x i8> [[TMP5]], <8 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>)
; CHECK-NEXT:    [[TMP9:%.*]] = add <8 x i8> [[TMP8]], <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP10:%.*]] = select <8 x i1> [[TMP3]], <8 x i8> [[TMP9]], <8 x i8> [[TMP5]]
; CHECK-NEXT:    store <8 x i8> [[TMP10]], ptr [[TMP0]], align 1
; CHECK-NEXT:    br label [[PRE]]
;
entry:
  %idx11 = getelementptr i8, ptr %0, i64 1
  %idx22 = getelementptr i8, ptr %0, i64 2
  %idx33 = getelementptr i8, ptr %0, i64 3
  %idx44 = getelementptr i8, ptr %0, i64 4
  %idx55 = getelementptr i8, ptr %0, i64 5
  %idx66 = getelementptr i8, ptr %0, i64 6
  %idx77 = getelementptr i8, ptr %0, i64 7
  br label %pre

pre:
  %conv.i = zext i8 %1 to i32
  %2 = tail call i32 @llvm.umax.i32(i32 %conv.i, i32 1)
  %.sroa.speculated.i = add i32 %2, 1
  %intensity.0.i = select i1 %cmp12.i, i32 %.sroa.speculated.i, i32 %conv.i
  %conv14.i = trunc i32 %intensity.0.i to i8
  store i8 %conv14.i, ptr %0, align 1
  %conv.i.1 = zext i8 %1 to i32
  %3 = tail call i32 @llvm.umax.i32(i32 %conv.i.1, i32 1)
  %ss1 = add i32 %3, 1
  %ii1 = select i1 %cmp12.i, i32 %ss1, i32 %conv.i.1
  %conv14.i.1 = trunc i32 %ii1 to i8
  store i8 %conv14.i.1, ptr %idx11, align 1
  %conv.i.2 = zext i8 %1 to i32
  %4 = tail call i32 @llvm.umax.i32(i32 %conv.i.2, i32 1)
  %ss2 = add i32 %4, 1
  %ii2 = select i1 %cmp12.i, i32 %ss2, i32 %conv.i.2
  %conv14.i.2 = trunc i32 %ii2 to i8
  store i8 %conv14.i.2, ptr %idx22, align 1
  %conv.i.3 = zext i8 %1 to i32
  %5 = tail call i32 @llvm.umax.i32(i32 %conv.i.3, i32 1)
  %ss3 = add i32 %5, 1
  %ii3 = select i1 %cmp12.i, i32 %ss3, i32 %conv.i.3
  %conv14.i.3 = trunc i32 %ii3 to i8
  store i8 %conv14.i.3, ptr %idx33, align 1
  %conv.i.4 = zext i8 %1 to i32
  %6 = tail call i32 @llvm.umax.i32(i32 %conv.i.4, i32 1)
  %ss4 = add i32 %6, 1
  %ii4 = select i1 %cmp12.i, i32 %ss4, i32 %conv.i.4
  %conv14.i.4 = trunc i32 %ii4 to i8
  store i8 %conv14.i.4, ptr %idx44, align 1
  %conv.i.5 = zext i8 %1 to i32
  %7 = tail call i32 @llvm.umax.i32(i32 %conv.i.5, i32 1)
  %ss5 = add i32 %7, 1
  %ii5 = select i1 %cmp12.i, i32 %ss5, i32 %conv.i.5
  %conv14.i.5 = trunc i32 %ii5 to i8
  store i8 %conv14.i.5, ptr %idx55, align 1
  %conv.i.6 = zext i8 %1 to i32
  %8 = tail call i32 @llvm.umax.i32(i32 %conv.i.6, i32 1)
  %ss6 = add i32 %8, 1
  %ii6 = select i1 %cmp12.i, i32 %ss6, i32 %conv.i.6
  %conv14.i.6 = trunc i32 %ii6 to i8
  store i8 %conv14.i.6, ptr %idx66, align 1
  %conv.i.7 = zext i8 %1 to i32
  %9 = tail call i32 @llvm.umax.i32(i32 %conv.i.7, i32 1)
  %ss7 = add i32 %9, 1
  %ii7 = select i1 %cmp12.i, i32 %ss7, i32 %conv.i.7
  %conv14.i.7 = trunc i32 %ii7 to i8
  store i8 %conv14.i.7, ptr %idx77, align 1
  br label %pre
}

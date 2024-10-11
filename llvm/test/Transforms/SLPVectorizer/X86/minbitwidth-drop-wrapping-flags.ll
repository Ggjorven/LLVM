; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define i32 @test() {
; CHECK-LABEL: define i32 @test() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i8, ptr null, align 1
; CHECK-NEXT:    [[TMP10:%.*]] = or i8 [[A_PROMOTED]], 0
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x i8> poison, i8 [[A_PROMOTED]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i8> [[TMP0]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = add <4 x i8> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = or <4 x i8> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <4 x i8> [[TMP2]], <4 x i8> [[TMP3]], <4 x i32> <i32 0, i32 1, i32 6, i32 7>
; CHECK-NEXT:    [[TMP5:%.*]] = zext <4 x i8> [[TMP4]] to <4 x i16>
; CHECK-NEXT:    [[TMP6:%.*]] = add <4 x i16> [[TMP5]], <i16 0, i16 -1, i16 0, i16 0>
; CHECK-NEXT:    [[TMP7:%.*]] = call i16 @llvm.vector.reduce.or.v4i16(<4 x i16> [[TMP6]])
; CHECK-NEXT:    [[TMP8:%.*]] = zext i16 [[TMP7]] to i32
; CHECK-NEXT:    [[TMP9:%.*]] = and i32 [[TMP8]], 65535
; CHECK-NEXT:    store i8 [[TMP10]], ptr null, align 1
; CHECK-NEXT:    [[CALL3:%.*]] = tail call i32 (ptr, ...) null(ptr null, i32 [[TMP9]])
; CHECK-NEXT:    ret i32 0
;
entry:
  %a.promoted = load i8, ptr null, align 1
  %dec.4 = add i8 %a.promoted, 0
  %conv.i.4 = zext i8 %dec.4 to i32
  %sub.i.4 = add nuw nsw i32 %conv.i.4, 0
  %dec.5 = add i8 %a.promoted, 0
  %conv.i.5 = zext i8 %dec.5 to i32
  %sub.i.5 = add nuw nsw i32 %conv.i.5, 65535
  %0 = or i32 %sub.i.4, %sub.i.5
  %dec.6 = or i8 %a.promoted, 0
  %conv.i.6 = zext i8 %dec.6 to i32
  %sub.i.6 = add nuw nsw i32 %conv.i.6, 0
  %1 = or i32 %0, %sub.i.6
  %dec.7 = or i8 %a.promoted, 0
  %conv.i.7 = zext i8 %dec.7 to i32
  %sub.i.7 = add nuw nsw i32 %conv.i.7, 0
  %2 = or i32 %1, %sub.i.7
  %3 = and i32 %2, 65535
  store i8 %dec.7, ptr null, align 1
  %call3 = tail call i32 (ptr, ...) null(ptr null, i32 %3)
  ret i32 0
}

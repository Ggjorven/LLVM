; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: %if x86-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s %}

@e = global i8 0
@c = global i16 0
@d = global i32 0

define i8 @test() {
; CHECK-LABEL: define i8 @test() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr @e, align 1
; CHECK-NEXT:    [[CONV:%.*]] = sext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = load i16, ptr @c, align 2
; CHECK-NEXT:    [[CONV1:%.*]] = zext i16 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP13:%.*]] = or i32 [[CONV]], 32769
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <8 x i32> poison, i32 [[CONV]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP2]], <8 x i32> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = or <8 x i32> [[TMP3]], <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 32769>
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <8 x i32> poison, i32 [[CONV1]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <8 x i32> [[TMP6]], <8 x i32> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <8 x i32> [[TMP4]], [[TMP7]]
; CHECK-NEXT:    [[TMP11:%.*]] = call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> [[TMP8]])
; CHECK-NEXT:    [[CONV4_30:%.*]] = trunc i32 [[TMP11]] to i8
; CHECK-NEXT:    [[XOR_31:%.*]] = and i32 [[TMP13]], -2
; CHECK-NEXT:    store i32 [[XOR_31]], ptr @d, align 4
; CHECK-NEXT:    ret i8 [[CONV4_30]]
;
entry:
  %0 = load i8, ptr @e, align 1
  %conv = sext i8 %0 to i32
  %1 = load i16, ptr @c, align 2
  %conv1 = zext i16 %1 to i32
  %or.16 = or i32 %conv, 1
  %add.16 = add nsw i32 %or.16, %conv1
  %or.18 = or i32 %conv, 1
  %add.18 = add nsw i32 %or.18, %conv1
  %conv4.181 = or i32 %add.16, %add.18
  %or.20 = or i32 %conv, 1
  %add.20 = add nsw i32 %or.20, %conv1
  %conv4.202 = or i32 %conv4.181, %add.20
  %or.22 = or i32 %conv, 1
  %add.22 = add nsw i32 %or.22, %conv1
  %conv4.223 = or i32 %conv4.202, %add.22
  %or.24 = or i32 %conv, 1
  %add.24 = add nsw i32 %or.24, %conv1
  %conv4.244 = or i32 %conv4.223, %add.24
  %or.26 = or i32 %conv, 1
  %add.26 = add nsw i32 %or.26, %conv1
  %conv4.265 = or i32 %conv4.244, %add.26
  %or.28 = or i32 %conv, 1
  %add.28 = add nsw i32 %or.28, %conv1
  %conv4.286 = or i32 %conv4.265, %add.28
  %or.30 = or i32 %conv, 32769
  %add.30 = add nsw i32 %or.30, %conv1
  %conv4.307 = or i32 %conv4.286, %add.30
  %conv4.30 = trunc i32 %conv4.307 to i8
  %xor.31 = and i32 %or.30, -2
  store i32 %xor.31, ptr @d, align 4
  ret i8 %conv4.30
}

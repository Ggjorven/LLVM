; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

define i32 @test(ptr %f, i16 %0) {
; CHECK-LABEL: define i32 @test(
; CHECK-SAME: ptr [[F:%.*]], i16 [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load i16, ptr [[F]], align 2
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i16> <i16 poison, i16 0, i16 0, i16 0>, i16 [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i16> <i16 poison, i16 0, i16 0, i16 0>, i16 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = zext <4 x i16> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    [[TMP7:%.*]] = sext <4 x i16> [[TMP2]] to <4 x i32>
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ule <4 x i32> [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> [[TMP4]])
; CHECK-NEXT:    [[ZEXT_4:%.*]] = zext i1 [[TMP5]] to i32
; CHECK-NEXT:    ret i32 [[ZEXT_4]]
;
entry:
  %1 = load i16, ptr %f, align 2

  %zext.0 = zext i16 %1 to i32
  %sext.0 = sext i16 %0 to i32

  %zext.1 = zext i16 0 to i32
  %sext.1 = sext i16 0 to i32
  %zext.2 = zext i16 0 to i32
  %sext.2 = sext i16 0 to i32
  %zext.3 = zext i16 0 to i32
  %sext.3 = sext i16 0 to i32

  %cmp.0 = icmp ule i32 %zext.0, %sext.0
  %cmp.1 = icmp ule i32 %zext.1, %sext.1
  %cmp.2 = icmp ule i32 %zext.2, %sext.2
  %cmp.3 = icmp ule i32 %zext.3, %sext.3

  %and.0 = and i1 %cmp.0, %cmp.1
  %and.1 = and i1 %and.0, %cmp.2
  %and.2 = and i1 %and.1, %cmp.3

  %zext.4 = zext i1 %and.2 to i32

  ret i32 %zext.4
}

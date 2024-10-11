; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: %if x86-registered-target %{ opt < %s -passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -S | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt < %s -passes=slp-vectorizer -mtriple=aarch64-unknown-linux-gnu -S | FileCheck %s %}

define <3 x i64> @ahyes(i64 %position, i64 %value) {
; CHECK-LABEL: define <3 x i64> @ahyes(
; CHECK-SAME: i64 [[POSITION:%.*]], i64 [[VALUE:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x i64> poison, i64 [[VALUE]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <2 x i64> [[TMP0]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = add <2 x i64> [[TMP1]], <i64 1, i64 2>
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <3 x i64> poison, i64 [[VALUE]], i64 [[POSITION]]
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x i64> [[TMP2]], <2 x i64> poison, <3 x i32> <i32 0, i32 1, i32 poison>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <3 x i64> [[TMP3]], <3 x i64> [[TMP4]], <3 x i32> <i32 3, i32 4, i32 2>
; CHECK-NEXT:    ret <3 x i64> [[TMP5]]
;
entry:
  %0 = add i64 %value, 1
  %1 = add i64 %value, 2
  %2 = insertelement <3 x i64> poison, i64 %value, i64 %position
  %3 = insertelement <3 x i64> %2, i64 %0, i64 0
  %4 = insertelement <3 x i64> %3, i64 %1, i64 1
  ret <3 x i64> %4
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=slp-vectorizer -mtriple=x86_64 -mattr=+avx2 -S < %s | FileCheck %s

; Test case for issue #69670.

; #69392 uncovered a problem with delayed gather nodes emission, specifically
; when the node is a PHI operand, which depends on another gathered node,
; also an operand of a PHI (in another block).

define void @test() {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTPRE_PRE:%.*]] = load float, ptr poison, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x float> <float poison, float undef>, float [[DOTPRE_PRE]], i32 0
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP1:%.*]] = phi <2 x float> [ [[TMP0]], [[ENTRY:%.*]] ], [ [[TMP10:%.*]], [[BB2:%.*]] ]
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP2:%.*]] = phi <2 x float> [ [[TMP1]], [[BB1]] ], [ [[TMP9:%.*]], [[BB2]] ]
; CHECK-NEXT:    [[I1:%.*]] = load float, ptr poison, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <2 x i32> <i32 1, i32 poison>
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x float> [[TMP3]], float [[I1]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = fdiv <2 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x float> [[TMP5]], i32 1
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[TMP6]], [[TMP7]]
; CHECK-NEXT:    tail call void @foo(float [[MUL]])
; CHECK-NEXT:    [[I2:%.*]] = load float, ptr poison, align 4
; CHECK-NEXT:    [[TOBOOL:%.*]] = fcmp une float [[I2]], 0.000000e+00
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <2 x float> [[TMP5]], <2 x float> poison, <2 x i32> <i32 poison, i32 0>
; CHECK-NEXT:    [[TMP9]] = insertelement <2 x float> [[TMP8]], float [[I2]], i32 0
; CHECK-NEXT:    [[TMP10]] = shufflevector <2 x float> [[TMP9]], <2 x float> [[TMP2]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[BB1]], label [[BB2]]
;
entry:
  %.pre.pre = load float, ptr poison, align 4
  br label %bb1

bb1:                                              ; preds = %bb2, %entry
  %.pre = phi float [ %.pre.pre, %entry ], [ %i2, %bb2 ]
  %foxtrot.0 = phi float [ undef, %entry ], [ %gulf.0, %bb2 ]
  br label %bb2

bb2:                                              ; preds = %bb2, %bb1
  %i = phi float [ %.pre, %bb1 ], [ %i2, %bb2 ]
  %gulf.0 = phi float [ %foxtrot.0, %bb1 ], [ %div, %bb2 ]
  %div = fdiv float %i, %gulf.0
  %i1 = load float, ptr poison, align 4
  %div1 = fdiv float %gulf.0, %i1
  %mul = fmul float %div, %div1
  tail call void @foo(float %mul)
  %i2 = load float, ptr poison, align 4
  %tobool = fcmp une float %i2, 0.000000e+00
  br i1 %tobool, label %bb1, label %bb2
}

declare void @foo(float)

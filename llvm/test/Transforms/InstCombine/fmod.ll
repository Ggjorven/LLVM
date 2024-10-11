; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

define float @test_inf_const(float %f) {
; CHECK-LABEL: define float @test_inf_const(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ABS:%.*]] = tail call float @llvm.fabs.f32(float [[F]])
; CHECK-NEXT:    [[ISINF:%.*]] = fcmp oeq float [[ABS]], 0x7FF0000000000000
; CHECK-NEXT:    br i1 [[ISINF]], label [[RETURN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CALL:%.*]] = frem nnan float [[F]], 2.000000e+00
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       return:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %abs = tail call float @llvm.fabs.f32(float %f)
  %isinf = fcmp oeq float %abs, 0x7FF0000000000000
  br i1 %isinf, label %return, label %if.end

if.end:
  %call = tail call float @fmodf(float %f, float 2.0)
  ret float %call

return:
  ret float 0.0
}

define float @test_const_zero(float %f) {
; CHECK-LABEL: define float @test_const_zero(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ISZERO:%.*]] = fcmp oeq float [[F]], 0.000000e+00
; CHECK-NEXT:    br i1 [[ISZERO]], label [[RETURN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CALL:%.*]] = frem nnan float 2.000000e+00, [[F]]
; CHECK-NEXT:    ret float [[CALL]]
; CHECK:       return:
; CHECK-NEXT:    ret float 0.000000e+00
;
entry:
  %iszero = fcmp oeq float %f, 0.0
  br i1 %iszero, label %return, label %if.end

if.end:
  %call = tail call float @fmodf(float 2.0, float %f)
  ret float %call

return:
  ret float 0.0
}

define float @test_unknown_const(float %f) {
; CHECK-LABEL: define float @test_unknown_const(
; CHECK-SAME: float [[F:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @fmodf(float [[F]], float 2.000000e+00)
; CHECK-NEXT:    ret float [[CALL]]
;
entry:
  %call = tail call float @fmodf(float %f, float 2.000000e+00)
  ret float %call
}

define float @test_noinf_nozero(float nofpclass(inf) %f, float nofpclass(zero) %g) {
; CHECK-LABEL: define float @test_noinf_nozero(
; CHECK-SAME: float nofpclass(inf) [[F:%.*]], float nofpclass(zero) [[G:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = frem nnan float [[F]], [[G]]
; CHECK-NEXT:    ret float [[CALL]]
;
entry:
  %call = tail call float @fmodf(float %f, float %g)
  ret float %call
}

define double @test_double(double nofpclass(inf) %f, double nofpclass(zero) %g) {
; CHECK-LABEL: define double @test_double(
; CHECK-SAME: double nofpclass(inf) [[F:%.*]], double nofpclass(zero) [[G:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = frem nnan double [[F]], [[G]]
; CHECK-NEXT:    ret double [[CALL]]
;
entry:
  %call = tail call double @fmod(double %f, double %g)
  ret double %call
}

define fp128 @test_fp128(fp128 nofpclass(inf) %f, fp128 nofpclass(zero) %g) {
; CHECK-LABEL: define fp128 @test_fp128(
; CHECK-SAME: fp128 nofpclass(inf) [[F:%.*]], fp128 nofpclass(zero) [[G:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = frem nnan fp128 [[F]], [[G]]
; CHECK-NEXT:    ret fp128 [[CALL]]
;
entry:
  %call = tail call fp128 @fmodl(fp128 %f, fp128 %g)
  ret fp128 %call
}

define float @test_noinf_nozero_dazpreservesign(float nofpclass(inf) %f, float nofpclass(zero) %g) "denormal-fp-math"="preserve-sign,preserve-sign" {
; CHECK-LABEL: define float @test_noinf_nozero_dazpreservesign(
; CHECK-SAME: float nofpclass(inf) [[F:%.*]], float nofpclass(zero) [[G:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @fmodf(float [[F]], float [[G]])
; CHECK-NEXT:    ret float [[CALL]]
;
entry:
  %call = tail call float @fmodf(float %f, float %g)
  ret float %call
}

define float @test_noinf_nozero_dazdynamic(float nofpclass(inf) %f, float nofpclass(zero) %g) "denormal-fp-math"="dynamic,dynamic" {
; CHECK-LABEL: define float @test_noinf_nozero_dazdynamic(
; CHECK-SAME: float nofpclass(inf) [[F:%.*]], float nofpclass(zero) [[G:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call float @fmodf(float [[F]], float [[G]])
; CHECK-NEXT:    ret float [[CALL]]
;
entry:
  %call = tail call float @fmodf(float %f, float %g)
  ret float %call
}

define float @test_nnan(float %f, float %g) {
; CHECK-LABEL: define float @test_nnan(
; CHECK-SAME: float [[F:%.*]], float [[G:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = frem nnan float [[F]], [[G]]
; CHECK-NEXT:    ret float [[CALL]]
;
entry:
  %call = tail call nnan float @fmodf(float %f, float %g)
  ret float %call
}

declare float @fmodf(float, float)
declare double @fmod(double, double)
declare fp128 @fmodl(fp128, fp128)

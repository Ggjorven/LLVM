; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

define double @fdiv_sin_cos(double %a) {
; CHECK-LABEL: @fdiv_sin_cos(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.sin.f64(double [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.cos.f64(double [[A]])
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret double [[DIV]]
;
  %1 = call double @llvm.sin.f64(double %a)
  %2 = call double @llvm.cos.f64(double %a)
  %div = fdiv double %1, %2
  ret double %div
}

define double @fdiv_strict_sin_strict_cos_reassoc(double %a) {
; CHECK-LABEL: @fdiv_strict_sin_strict_cos_reassoc(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.sin.f64(double [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call reassoc double @llvm.cos.f64(double [[A]])
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret double [[DIV]]
;
  %1 = call double @llvm.sin.f64(double %a)
  %2 = call reassoc double @llvm.cos.f64(double %a)
  %div = fdiv double %1, %2
  ret double %div
}

define double @fdiv_reassoc_sin_strict_cos_strict(double %a, ptr dereferenceable(2) %dummy) {
; CHECK-LABEL: @fdiv_reassoc_sin_strict_cos_strict(
; CHECK-NEXT:    [[TAN:%.*]] = call reassoc double @tan(double [[A:%.*]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    ret double [[TAN]]
;
  %1 = call double @llvm.sin.f64(double %a)
  %2 = call double @llvm.cos.f64(double %a)
  %div = fdiv reassoc double %1, %2
  ret double %div
}

define double @fdiv_reassoc_sin_reassoc_cos_strict(double %a) {
; CHECK-LABEL: @fdiv_reassoc_sin_reassoc_cos_strict(
; CHECK-NEXT:    [[TAN:%.*]] = call reassoc double @tan(double [[A:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret double [[TAN]]
;
  %1 = call reassoc double @llvm.sin.f64(double %a)
  %2 = call double @llvm.cos.f64(double %a)
  %div = fdiv reassoc double %1, %2
  ret double %div
}

define double @fdiv_sin_cos_reassoc_multiple_uses(double %a) {
; CHECK-LABEL: @fdiv_sin_cos_reassoc_multiple_uses(
; CHECK-NEXT:    [[TMP1:%.*]] = call reassoc double @llvm.sin.f64(double [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call reassoc double @llvm.cos.f64(double [[A]])
; CHECK-NEXT:    [[DIV:%.*]] = fdiv reassoc double [[TMP1]], [[TMP2]]
; CHECK-NEXT:    call void @use(double [[TMP2]])
; CHECK-NEXT:    ret double [[DIV]]
;
  %1 = call reassoc double @llvm.sin.f64(double %a)
  %2 = call reassoc double @llvm.cos.f64(double %a)
  %div = fdiv reassoc double %1, %2
  call void @use(double %2)
  ret double %div
}

define double @fdiv_sin_cos_reassoc(double %a) {
; CHECK-LABEL: @fdiv_sin_cos_reassoc(
; CHECK-NEXT:    [[TAN:%.*]] = call reassoc double @tan(double [[A:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret double [[TAN]]
;
  %1 = call reassoc double @llvm.sin.f64(double %a)
  %2 = call reassoc double @llvm.cos.f64(double %a)
  %div = fdiv reassoc double %1, %2
  ret double %div
}

define float @fdiv_sinf_cosf_reassoc(float %a) {
; CHECK-LABEL: @fdiv_sinf_cosf_reassoc(
; CHECK-NEXT:    [[TANF:%.*]] = call reassoc float @tanf(float [[A:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret float [[TANF]]
;
  %1 = call reassoc float @llvm.sin.f32(float %a)
  %2 = call reassoc float @llvm.cos.f32(float %a)
  %div = fdiv reassoc float %1, %2
  ret float %div
}

define fp128 @fdiv_sinfp128_cosfp128_reassoc(fp128 %a) {
; CHECK-LABEL: @fdiv_sinfp128_cosfp128_reassoc(
; CHECK-NEXT:    [[TANL:%.*]] = call reassoc fp128 @tanl(fp128 [[A:%.*]]) #[[ATTR1]]
; CHECK-NEXT:    ret fp128 [[TANL]]
;
  %1 = call reassoc fp128 @llvm.sin.fp128(fp128 %a)
  %2 = call reassoc fp128 @llvm.cos.fp128(fp128 %a)
  %div = fdiv reassoc fp128 %1, %2
  ret fp128 %div
}

declare double @llvm.sin.f64(double) #1
declare float @llvm.sin.f32(float) #1
declare fp128 @llvm.sin.fp128(fp128) #1

declare double @llvm.cos.f64(double) #1
declare float @llvm.cos.f32(float) #1
declare fp128 @llvm.cos.fp128(fp128) #1

declare void @use(double)

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { nounwind readnone }

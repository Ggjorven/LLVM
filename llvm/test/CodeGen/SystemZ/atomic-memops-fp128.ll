; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z13 | FileCheck %s
;
; Test fpext of atomic loads to fp128 without VectorEnhancements1 (using FP register pairs).

define fp128 @f1(ptr %src) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxeb %f0, 0(%r3)
; CHECK-NEXT:    std %f0, 0(%r2)
; CHECK-NEXT:    std %f2, 8(%r2)
; CHECK-NEXT:    br %r14
  %V  = load atomic float, ptr %src seq_cst, align 4
  %Res = fpext float %V to fp128
  ret fp128 %Res
}

define fp128 @f2(ptr %src) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lxdb %f0, 0(%r3)
; CHECK-NEXT:    std %f0, 0(%r2)
; CHECK-NEXT:    std %f2, 8(%r2)
; CHECK-NEXT:    br %r14
  %V  = load atomic double, ptr %src seq_cst, align 8
  %Res = fpext double %V to fp128
  ret fp128 %Res
}




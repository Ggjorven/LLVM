; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

@empty = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@dec = private unnamed_addr constant [2 x i8] c"1\00", align 1
@hex = private unnamed_addr constant [4 x i8] c"0xf\00", align 1

define double @nan_empty() {
; CHECK-LABEL: define double @nan_empty() {
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %res = call double @nan(ptr @empty)
  ret double %res
}

define double @nan_dec() {
; CHECK-LABEL: define double @nan_dec() {
; CHECK-NEXT:    ret double 0x7FF8000000000001
;
  %res = call double @nan(ptr @dec)
  ret double %res
}

define double @nan_hex() {
; CHECK-LABEL: define double @nan_hex() {
; CHECK-NEXT:    ret double 0x7FF800000000000F
;
  %res = call double @nan(ptr @hex)
  ret double %res
}

define float @nanf_empty() {
; CHECK-LABEL: define float @nanf_empty() {
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %res = call float @nanf(ptr @empty)
  ret float %res
}

; nagative tests

define double @nan_poison() {
; CHECK-LABEL: define double @nan_poison() {
; CHECK-NEXT:    [[RES:%.*]] = call double @nan(ptr poison)
; CHECK-NEXT:    ret double [[RES]]
;
  %res = call double @nan(ptr poison)
  ret double %res
}

define double @nan_undef() {
; CHECK-LABEL: define double @nan_undef() {
; CHECK-NEXT:    [[RES:%.*]] = call double @nan(ptr undef)
; CHECK-NEXT:    ret double [[RES]]
;
  %res = call double @nan(ptr undef)
  ret double %res
}

define double @nan_null() {
; CHECK-LABEL: define double @nan_null() {
; CHECK-NEXT:    [[RES:%.*]] = call double @nan(ptr null)
; CHECK-NEXT:    ret double [[RES]]
;
  %res = call double @nan(ptr null)
  ret double %res
}

define double @nan_non_constant(ptr %x) {
; CHECK-LABEL: define double @nan_non_constant(
; CHECK-SAME: ptr [[X:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = call double @nan(ptr [[X]])
; CHECK-NEXT:    ret double [[RES]]
;
  %res = call double @nan(ptr %x)
  ret double %res
}

declare float @nanf(ptr)
declare double @nan(ptr)

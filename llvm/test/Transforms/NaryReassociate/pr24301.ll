; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=nary-reassociate -S | FileCheck %s
; RUN: opt < %s -passes='nary-reassociate' -S | FileCheck %s

define i32 @foo(i32 %t4) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T13:%.*]] = add i32 [[T4:%.*]], -128
; CHECK-NEXT:    [[T14:%.*]] = add i32 [[T13]], 8
; CHECK-NEXT:    [[T23:%.*]] = add i32 [[T13]], 119
; CHECK-NEXT:    ret i32 [[T23]]
;
entry:
  %t5 = add i32 %t4, 8
  %t13 = add i32 %t4, -128  ; deleted
  %t14 = add i32 %t13, 8    ; => %t5 + -128
  %t21 = add i32 119, %t4
  ; do not rewrite %t23 against %t13 because %t13 is already deleted
  %t23 = add i32 %t21, -128
  ret i32 %t23
}

; This is essentially the same test as the previous one but intermidiate result (t14) has a use.
define i32 @foo2(i32 %t4) {
; CHECK-LABEL: @foo2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T13:%.*]] = add i32 [[T4:%.*]], -128
; CHECK-NEXT:    [[T14:%.*]] = add i32 [[T13]], 8
; CHECK-NEXT:    [[T23:%.*]] = add i32 [[T13]], 119
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[T14]], [[T23]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %t5 = add i32 %t4, 8     ; initially dead
  %t13 = add i32 %t4, -128
  %t14 = add i32 %t13, 8
  %t21 = add i32 119, %t4  ; => dead after reassociation
  %t23 = add i32 %t21, -128; => reassociated to t13 + 119
  %res = add i32 %t14, %t23
  ret i32 %res
}

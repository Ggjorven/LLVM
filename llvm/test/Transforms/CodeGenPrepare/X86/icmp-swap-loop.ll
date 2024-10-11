; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -mtriple=x86_64-- -codegenprepare < %s | FileCheck %s

define i1 @test(i32 %arg) {
; CHECK-LABEL: define i1 @test
; CHECK-SAME: (i32 [[ARG:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[ARG]], [[ARG]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[ARG]], [[ARG]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %cmp = icmp ne i32 %arg, %arg
  %sub = sub i32 %arg, %arg
  ret i1 %cmp
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=move-auto-init < %s | FileCheck %s

define i1 @test(ptr %a, ptr %b) {
; CHECK-LABEL: define i1 @test
; CHECK-SAME: (ptr [[A:%.*]], ptr [[B:%.*]]) {
; CHECK-NEXT:    [[C:%.*]] = icmp uge ptr [[A]], [[B]], !annotation !0
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = icmp uge ptr %a, %b, !annotation !0
  ret i1 %c
}

!0 = !{ !"auto-init" }

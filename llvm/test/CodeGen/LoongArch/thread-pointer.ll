; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mtriple=loongarch32 -mattr=+d | FileCheck %s
; RUN: llc < %s --mtriple=loongarch64 -mattr=+d | FileCheck %s

declare ptr @llvm.thread.pointer()

define ptr @thread_pointer() nounwind {
; CHECK-LABEL: thread_pointer:
; CHECK:       # %bb.0:
; CHECK-NEXT:    move $a0, $tp
; CHECK-NEXT:    ret
  %1 = tail call ptr @llvm.thread.pointer()
  ret ptr %1
}

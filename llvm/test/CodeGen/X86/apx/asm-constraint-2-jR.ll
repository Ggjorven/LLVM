; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: not llc -mtriple=x86_64 %s -o %t 2>&1 | FileCheck %s --check-prefix=ERR
; RUN: llc -mtriple=x86_64 -mattr=+egpr < %s | FileCheck %s
; RUN: llc -mtriple=x86_64 -mattr=+egpr,+inline-asm-use-gpr32 < %s | FileCheck %s
; RUN: not llc -mtriple=x86_64 -mattr=+inline-asm-use-gpr32 %s -o %t 2>&1 | FileCheck %s --check-prefix=ERR

; ERR: error: inline assembly requires more registers than available

define void @constraint_jR_test() nounwind {
; CHECK-LABEL: constraint_jR_test:
; CHECK:    addq %r16, %rax
entry:
  %reg = alloca i64, align 8
  %0 = load i64, ptr %reg, align 8
  call void asm sideeffect "add $0, %rax", "^jR,~{rax},~{rbx},~{rbp},~{rcx},~{rdx},~{rdi},~{rsi},~{r8},~{r9},~{r10},~{r11},~{r12},~{r13},~{r14},~{r15},~{dirflag},~{fpsr},~{flags}"(i64 %0)
  ret void
}

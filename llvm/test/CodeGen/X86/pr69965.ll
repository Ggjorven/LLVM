; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -mtriple=i686-- | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s --check-prefix=X64

define i64 @PR69965(ptr %input_ptrs, ptr %output_ptrs) {
; X86-LABEL: PR69965:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    movzbl (%eax), %eax
; X86-NEXT:    notl %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    shll $8, %edx
; X86-NEXT:    movl (%ecx), %ecx
; X86-NEXT:    addb %al, %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    orl %edx, %eax
; X86-NEXT:    orl $32768, %eax # imm = 0x8000
; X86-NEXT:    movw %ax, (%ecx)
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: PR69965:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq (%rdi), %rax
; X64-NEXT:    movzbl (%rax), %eax
; X64-NEXT:    notl %eax
; X64-NEXT:    leal (%rax,%rax), %ecx
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    shll $8, %eax
; X64-NEXT:    movq (%rsi), %rdx
; X64-NEXT:    movzbl %cl, %ecx
; X64-NEXT:    orl %eax, %ecx
; X64-NEXT:    orl $32768, %ecx # imm = 0x8000
; X64-NEXT:    movw %cx, (%rdx)
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
entry:
  %0 = load ptr, ptr %input_ptrs, align 8
  %.val.i = load i8, ptr %0, align 1
  %1 = and i8 %.val.i, 127
  %2 = xor i8 %1, 127
  %3 = or i8 %2, -128
  %4 = zext i8 %3 to i16
  %5 = load ptr, ptr %output_ptrs, align 8
  %6 = shl nuw i16 %4, 8
  %7 = shl nuw i8 %2, 1
  %8 = zext i8 %7 to i16
  %9 = or i16 %6, %8
  store i16 %9, ptr %5, align 2
  ret i64 0
}

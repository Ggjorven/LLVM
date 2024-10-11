; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=riscv32 | FileCheck %s

define void @foo() {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -2032
; CHECK-NEXT:    .cfi_def_cfa_offset 2032
; CHECK-NEXT:    sw ra, 2028(sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset ra, -4
; CHECK-NEXT:    li a0, -2048
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    .cfi_def_cfa_offset 4294967280
; CHECK-NEXT:    addi a0, sp, 4
; CHECK-NEXT:    call use
; CHECK-NEXT:    li a0, -2048
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    lw ra, 2028(sp) # 4-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 2032
; CHECK-NEXT:    ret
  %1 = alloca [1073741818 x i32], align 4
  call void @use(ptr %1)
  ret void
}

declare void @use(ptr)

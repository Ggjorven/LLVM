; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck %s

@a= external dso_local global i32, code_model "small", align 4

define dso_local signext i32 @local_small() #0 {
; CHECK-LABEL: local_small:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(a)
; CHECK-NEXT:    ld.w $a0, $a0, %pc_lo12(a)
; CHECK-NEXT:    ret
  %1 = load i32, ptr @a, align 4
  ret i32 %1
}

@b= external dso_local global i32, code_model "large", align 4

define dso_local signext i32 @local_large() #0 {
; CHECK-LABEL: local_large:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(b)
; CHECK-NEXT:    addi.d $a1, $zero, %pc_lo12(b)
; CHECK-NEXT:    lu32i.d $a1, %pc64_lo20(b)
; CHECK-NEXT:    lu52i.d $a1, $a1, %pc64_hi12(b)
; CHECK-NEXT:    ldx.w $a0, $a1, $a0
; CHECK-NEXT:    ret
  %1 = load i32, ptr @b, align 4
  ret i32 %1
}

@c= external global i32, code_model "large", align 4

define dso_local signext i32 @non_local_large() #0 {
; CHECK-LABEL: non_local_large:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %got_pc_hi20(c)
; CHECK-NEXT:    ld.d $a0, $a0, %got_pc_lo12(c)
; CHECK-NEXT:    ld.w $a0, $a0, 0
; CHECK-NEXT:    ret
  %1 = load i32, ptr @c, align 4
  ret i32 %1
}

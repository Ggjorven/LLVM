; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck %s --check-prefix=LA64

@addr = dso_local global ptr null

define void @test_blockaddress() nounwind {
; LA32-LABEL: test_blockaddress:
; LA32:       # %bb.0:
; LA32-NEXT:    pcalau12i $a0, %pc_hi20(addr)
; LA32-NEXT:    pcalau12i $a1, %pc_hi20(.Ltmp0)
; LA32-NEXT:    addi.w $a1, $a1, %pc_lo12(.Ltmp0)
; LA32-NEXT:    st.w $a1, $a0, %pc_lo12(addr)
; LA32-NEXT:    ld.w $a0, $a0, %pc_lo12(addr)
; LA32-NEXT:    jr $a0
; LA32-NEXT:  .Ltmp0: # Block address taken
; LA32-NEXT:  .LBB0_1: # %block
; LA32-NEXT:    ret
;
; LA64-LABEL: test_blockaddress:
; LA64:       # %bb.0:
; LA64-NEXT:    pcalau12i $a0, %pc_hi20(addr)
; LA64-NEXT:    pcalau12i $a1, %pc_hi20(.Ltmp0)
; LA64-NEXT:    addi.d $a1, $a1, %pc_lo12(.Ltmp0)
; LA64-NEXT:    st.d $a1, $a0, %pc_lo12(addr)
; LA64-NEXT:    ld.d $a0, $a0, %pc_lo12(addr)
; LA64-NEXT:    jr $a0
; LA64-NEXT:  .Ltmp0: # Block address taken
; LA64-NEXT:  .LBB0_1: # %block
; LA64-NEXT:    ret
  store volatile ptr blockaddress(@test_blockaddress, %block), ptr @addr
  %val = load volatile ptr, ptr @addr
  indirectbr ptr %val, [label %block]

block:
  ret void
}

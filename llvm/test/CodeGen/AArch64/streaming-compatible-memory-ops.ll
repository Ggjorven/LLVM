; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -mattr=+sme2 -verify-machineinstrs < %s | FileCheck %s -check-prefixes=CHECK
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -mattr=+sme2 -verify-machineinstrs -aarch64-lower-to-sme-routines=false < %s | FileCheck %s -check-prefixes=CHECK-NO-SME-ROUTINES
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -mattr=+sme2 -mattr=+mops -verify-machineinstrs < %s | FileCheck %s -check-prefixes=CHECK-MOPS

@dst = global [512 x i8] zeroinitializer, align 1
@src = global [512 x i8] zeroinitializer, align 1

define void @se_memcpy(i64 noundef %n) "aarch64_pstate_sm_enabled" nounwind {
; CHECK-LABEL: se_memcpy:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    adrp x0, :got:dst
; CHECK-NEXT:    adrp x1, :got:src
; CHECK-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NEXT:    bl __arm_sc_memcpy
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
;
; CHECK-NO-SME-ROUTINES-LABEL: se_memcpy:
; CHECK-NO-SME-ROUTINES:       // %bb.0: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    cntd x9
; CHECK-NO-SME-ROUTINES-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    mov x2, x0
; CHECK-NO-SME-ROUTINES-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x0, :got:dst
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x1, :got:src
; CHECK-NO-SME-ROUTINES-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NO-SME-ROUTINES-NEXT:    smstop sm
; CHECK-NO-SME-ROUTINES-NEXT:    bl memcpy
; CHECK-NO-SME-ROUTINES-NEXT:    smstart sm
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ret
;
; CHECK-MOPS-LABEL: se_memcpy:
; CHECK-MOPS:       // %bb.0: // %entry
; CHECK-MOPS-NEXT:    adrp x8, :got:src
; CHECK-MOPS-NEXT:    adrp x9, :got:dst
; CHECK-MOPS-NEXT:    ldr x8, [x8, :got_lo12:src]
; CHECK-MOPS-NEXT:    ldr x9, [x9, :got_lo12:dst]
; CHECK-MOPS-NEXT:    cpyfp [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpyfm [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpyfe [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 @dst, ptr nonnull align 1 @src, i64 %n, i1 false)
  ret void
}

define void @se_memset(i64 noundef %n) "aarch64_pstate_sm_enabled" nounwind {
; CHECK-LABEL: se_memset:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    adrp x0, :got:dst
; CHECK-NEXT:    mov w1, #2 // =0x2
; CHECK-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NEXT:    bl __arm_sc_memset
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
;
; CHECK-NO-SME-ROUTINES-LABEL: se_memset:
; CHECK-NO-SME-ROUTINES:       // %bb.0: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    cntd x9
; CHECK-NO-SME-ROUTINES-NEXT:    mov x2, x0
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x0, :got:dst
; CHECK-NO-SME-ROUTINES-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NO-SME-ROUTINES-NEXT:    smstop sm
; CHECK-NO-SME-ROUTINES-NEXT:    mov w1, #2 // =0x2
; CHECK-NO-SME-ROUTINES-NEXT:    bl memset
; CHECK-NO-SME-ROUTINES-NEXT:    smstart sm
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ret
;
; CHECK-MOPS-LABEL: se_memset:
; CHECK-MOPS:       // %bb.0: // %entry
; CHECK-MOPS-NEXT:    adrp x8, :got:dst
; CHECK-MOPS-NEXT:    mov w9, #2 // =0x2
; CHECK-MOPS-NEXT:    ldr x8, [x8, :got_lo12:dst]
; CHECK-MOPS-NEXT:    setp [x8]!, x0!, x9
; CHECK-MOPS-NEXT:    setm [x8]!, x0!, x9
; CHECK-MOPS-NEXT:    sete [x8]!, x0!, x9
; CHECK-MOPS-NEXT:    ret
entry:
  tail call void @llvm.memset.p0.i64(ptr align 1 @dst, i8 2, i64 %n, i1 false)
  ret void
}

define void @se_memmove(i64 noundef %n) "aarch64_pstate_sm_enabled" nounwind {
; CHECK-LABEL: se_memmove:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    adrp x0, :got:dst
; CHECK-NEXT:    adrp x1, :got:src
; CHECK-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NEXT:    bl __arm_sc_memmove
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
;
; CHECK-NO-SME-ROUTINES-LABEL: se_memmove:
; CHECK-NO-SME-ROUTINES:       // %bb.0: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    cntd x9
; CHECK-NO-SME-ROUTINES-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    mov x2, x0
; CHECK-NO-SME-ROUTINES-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x0, :got:dst
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x1, :got:src
; CHECK-NO-SME-ROUTINES-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NO-SME-ROUTINES-NEXT:    smstop sm
; CHECK-NO-SME-ROUTINES-NEXT:    bl memmove
; CHECK-NO-SME-ROUTINES-NEXT:    smstart sm
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ret
;
; CHECK-MOPS-LABEL: se_memmove:
; CHECK-MOPS:       // %bb.0: // %entry
; CHECK-MOPS-NEXT:    adrp x8, :got:src
; CHECK-MOPS-NEXT:    adrp x9, :got:dst
; CHECK-MOPS-NEXT:    ldr x8, [x8, :got_lo12:src]
; CHECK-MOPS-NEXT:    ldr x9, [x9, :got_lo12:dst]
; CHECK-MOPS-NEXT:    cpyp [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpym [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpye [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    ret
entry:
  tail call void @llvm.memmove.p0.p0.i64(ptr align 1 @dst, ptr nonnull align 1 @src, i64 %n, i1 false)
  ret void
}

define void @sc_memcpy(i64 noundef %n) "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: sc_memcpy:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    adrp x0, :got:dst
; CHECK-NEXT:    adrp x1, :got:src
; CHECK-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NEXT:    bl __arm_sc_memcpy
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
;
; CHECK-NO-SME-ROUTINES-LABEL: sc_memcpy:
; CHECK-NO-SME-ROUTINES:       // %bb.0: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    stp d15, d14, [sp, #-96]! // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    cntd x9
; CHECK-NO-SME-ROUTINES-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    mov x2, x0
; CHECK-NO-SME-ROUTINES-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    str x19, [sp, #80] // 8-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    bl __arm_sme_state
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x8, :got:dst
; CHECK-NO-SME-ROUTINES-NEXT:    and x19, x0, #0x1
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x1, :got:src
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x8, [x8, :got_lo12:dst]
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NO-SME-ROUTINES-NEXT:    tbz w19, #0, .LBB3_2
; CHECK-NO-SME-ROUTINES-NEXT:  // %bb.1: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    smstop sm
; CHECK-NO-SME-ROUTINES-NEXT:  .LBB3_2: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    mov x0, x8
; CHECK-NO-SME-ROUTINES-NEXT:    bl memcpy
; CHECK-NO-SME-ROUTINES-NEXT:    tbz w19, #0, .LBB3_4
; CHECK-NO-SME-ROUTINES-NEXT:  // %bb.3: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    smstart sm
; CHECK-NO-SME-ROUTINES-NEXT:  .LBB3_4: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x19, [sp, #80] // 8-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d15, d14, [sp], #96 // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ret
;
; CHECK-MOPS-LABEL: sc_memcpy:
; CHECK-MOPS:       // %bb.0: // %entry
; CHECK-MOPS-NEXT:    adrp x8, :got:src
; CHECK-MOPS-NEXT:    adrp x9, :got:dst
; CHECK-MOPS-NEXT:    ldr x8, [x8, :got_lo12:src]
; CHECK-MOPS-NEXT:    ldr x9, [x9, :got_lo12:dst]
; CHECK-MOPS-NEXT:    cpyfp [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpyfm [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpyfe [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 @dst, ptr nonnull align 1 @src, i64 %n, i1 false)
  ret void
}

define void @sb_memcpy(i64 noundef %n) "aarch64_pstate_sm_body" nounwind {
; CHECK-LABEL: sb_memcpy:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp d15, d14, [sp, #-96]! // 16-byte Folded Spill
; CHECK-NEXT:    rdsvl x9, #1
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    lsr x9, x9, #3
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    str x9, [sp, #80] // 8-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    adrp x0, :got:dst
; CHECK-NEXT:    adrp x1, :got:src
; CHECK-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NEXT:    bl __arm_sc_memcpy
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #96 // 16-byte Folded Reload
; CHECK-NEXT:    ret
;
; CHECK-NO-SME-ROUTINES-LABEL: sb_memcpy:
; CHECK-NO-SME-ROUTINES:       // %bb.0: // %entry
; CHECK-NO-SME-ROUTINES-NEXT:    stp d15, d14, [sp, #-96]! // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    rdsvl x9, #1
; CHECK-NO-SME-ROUTINES-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    mov x2, x0
; CHECK-NO-SME-ROUTINES-NEXT:    lsr x9, x9, #3
; CHECK-NO-SME-ROUTINES-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    cntd x9
; CHECK-NO-SME-ROUTINES-NEXT:    str x9, [sp, #80] // 8-byte Folded Spill
; CHECK-NO-SME-ROUTINES-NEXT:    smstart sm
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x0, :got:dst
; CHECK-NO-SME-ROUTINES-NEXT:    adrp x1, :got:src
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x0, [x0, :got_lo12:dst]
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x1, [x1, :got_lo12:src]
; CHECK-NO-SME-ROUTINES-NEXT:    smstop sm
; CHECK-NO-SME-ROUTINES-NEXT:    bl memcpy
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ldp d15, d14, [sp], #96 // 16-byte Folded Reload
; CHECK-NO-SME-ROUTINES-NEXT:    ret
;
; CHECK-MOPS-LABEL: sb_memcpy:
; CHECK-MOPS:       // %bb.0: // %entry
; CHECK-MOPS-NEXT:    rdsvl x9, #1
; CHECK-MOPS-NEXT:    lsr x9, x9, #3
; CHECK-MOPS-NEXT:    str x9, [sp, #-80]! // 8-byte Folded Spill
; CHECK-MOPS-NEXT:    cntd x9
; CHECK-MOPS-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-MOPS-NEXT:    str x9, [sp, #8] // 8-byte Folded Spill
; CHECK-MOPS-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-MOPS-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-MOPS-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-MOPS-NEXT:    smstart sm
; CHECK-MOPS-NEXT:    adrp x8, :got:src
; CHECK-MOPS-NEXT:    adrp x9, :got:dst
; CHECK-MOPS-NEXT:    ldr x8, [x8, :got_lo12:src]
; CHECK-MOPS-NEXT:    ldr x9, [x9, :got_lo12:dst]
; CHECK-MOPS-NEXT:    cpyfp [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpyfm [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    cpyfe [x9]!, [x8]!, x0!
; CHECK-MOPS-NEXT:    smstop sm
; CHECK-MOPS-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-MOPS-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-MOPS-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-MOPS-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-MOPS-NEXT:    add sp, sp, #80
; CHECK-MOPS-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 @dst, ptr nonnull align 1 @src, i64 %n, i1 false)
  ret void
}

declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg)
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg)
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg)

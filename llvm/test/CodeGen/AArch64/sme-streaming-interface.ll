; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -mattr=+sme -verify-machineinstrs < %s | FileCheck %s

; This file tests the following combinations related to streaming-enabled functions:
; [ ] N  ->  S    (Normal -> Streaming)
; [ ] S  ->  N    (Streaming -> Normal)
; [ ] S  ->  S    (Streaming -> Streaming)
; [ ] S  ->  SC   (Streaming -> Streaming-compatible)
;
; The following combination is tested in sme-streaming-compatible-interface.ll
; [ ] SC ->  S    (Streaming-compatible -> Streaming)

declare void @normal_callee()
declare void @streaming_callee() "aarch64_pstate_sm_enabled"
declare void @streaming_compatible_callee() "aarch64_pstate_sm_compatible"

; [x] N  ->  S
; [ ] S  ->  N
; [ ] S  ->  S
; [ ] S  ->  SC
define void @normal_caller_streaming_callee() nounwind {
; CHECK-LABEL: normal_caller_streaming_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  call void @streaming_callee()
  ret void;
}

; [ ] N  ->  S
; [x] S  ->  N
; [ ] S  ->  S
; [ ] S  ->  SC
define void @streaming_caller_normal_callee() nounwind "aarch64_pstate_sm_enabled" {
; CHECK-LABEL: streaming_caller_normal_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    bl normal_callee
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  call void @normal_callee()
  ret void;
}

; [ ] N  ->  S
; [ ] S  ->  N
; [x] S  ->  S
; [ ] S  ->  SC
define void @streaming_caller_streaming_callee() nounwind "aarch64_pstate_sm_enabled" {
; CHECK-LABEL: streaming_caller_streaming_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call void @streaming_callee()
  ret void;
}

; [ ] N  ->  S
; [ ] S  ->  N
; [ ] S  ->  S
; [x] S  ->  SC
define void @streaming_caller_streaming_compatible_callee() nounwind "aarch64_pstate_sm_enabled" {
; CHECK-LABEL: streaming_caller_streaming_compatible_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    bl streaming_compatible_callee
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call void @streaming_compatible_callee()
  ret void;
}

;
; Handle special cases here.
;

; Call to function-pointer (with attribute)
define void @call_to_function_pointer_streaming_enabled(ptr %p) nounwind {
; CHECK-LABEL: call_to_function_pointer_streaming_enabled:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    blr x0
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  call void %p() "aarch64_pstate_sm_enabled"
  ret void
}

; Ensure NEON registers are preserved correctly.
define <4 x i32> @smstart_clobber_simdfp(<4 x i32> %x) nounwind {
; CHECK-LABEL: smstart_clobber_simdfp:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #96
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #80] // 16-byte Folded Spill
; CHECK-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #96
; CHECK-NEXT:    ret
  call void @streaming_callee()
  ret <4 x i32> %x;
}

; Ensure SVE registers are preserved correctly.
define <vscale x 4 x i32> @smstart_clobber_sve(<vscale x 4 x i32> %x) nounwind {
; CHECK-LABEL: smstart_clobber_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x29, x30, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    str x9, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-18
; CHECK-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str z0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldr z0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #18
; CHECK-NEXT:    ldp x29, x30, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  call void @streaming_callee()
  ret <vscale x 4 x i32> %x;
}

; Call streaming callee twice; there should be no spills/fills between the two
; calls since the registers should have already been clobbered.
define <vscale x 4 x i32> @smstart_clobber_sve_duplicate(<vscale x 4 x i32> %x) nounwind {
; CHECK-LABEL: smstart_clobber_sve_duplicate:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x29, x30, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    str x9, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-18
; CHECK-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str z0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldr z0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #18
; CHECK-NEXT:    ldp x29, x30, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  call void @streaming_callee()
  call void @streaming_callee()
  ret <vscale x 4 x i32> %x;
}

; Ensure smstart is not removed, because call to llvm.cos is not part of a chain.
define double @call_to_intrinsic_without_chain(double %x) nounwind "aarch64_pstate_sm_enabled" {
; CHECK-LABEL: call_to_intrinsic_without_chain:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #96
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #80] // 16-byte Folded Spill
; CHECK-NEXT:    stp d0, d0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldr d0, [sp] // 8-byte Folded Reload
; CHECK-NEXT:    bl cos
; CHECK-NEXT:    str d0, [sp] // 8-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    ldp d1, d0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    fadd d0, d1, d0
; CHECK-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #96
; CHECK-NEXT:    ret
entry:
  %res = call fast double @llvm.cos.f64(double %x)
  %res.fadd = fadd fast double %res, %x
  ret double %res.fadd
}

declare double @llvm.cos.f64(double)

; Ensure that tail call optimization is disabled when the streaming mode
; doesn't match.
define void @disable_tailcallopt() nounwind {
; CHECK-LABEL: disable_tailcallopt:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  tail call void @streaming_callee()
  ret void;
}

define i8 @call_to_non_streaming_pass_sve_objects(ptr nocapture noundef readnone %ptr) #0 {
; CHECK-LABEL: call_to_non_streaming_pass_sve_objects:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp d15, d14, [sp, #-96]! // 16-byte Folded Spill
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    str x9, [sp, #80] // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-3
; CHECK-NEXT:    rdsvl x3, #1
; CHECK-NEXT:    addvl x0, sp, #2
; CHECK-NEXT:    addvl x1, sp, #1
; CHECK-NEXT:    mov x2, sp
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    bl foo
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [sp, #2, mul vl]
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    addvl sp, sp, #3
; CHECK-NEXT:    ldp x29, x30, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #96 // 16-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %Data1 = alloca <vscale x 16 x i8>, align 16
  %Data2 = alloca <vscale x 16 x i8>, align 16
  %Data3 = alloca <vscale x 16 x i8>, align 16
  %0 = tail call i64 @llvm.aarch64.sme.cntsb()
  call void @foo(ptr noundef nonnull %Data1, ptr noundef nonnull %Data2, ptr noundef nonnull %Data3, i64 noundef %0)
  %1 = load <vscale x 16 x i8>, ptr %Data1, align 16
  %vecext = extractelement <vscale x 16 x i8> %1, i64 0
  ret i8 %vecext
}

define void @call_to_non_streaming_pass_args(ptr nocapture noundef readnone %ptr, i64 %long1, i64 %long2, i32 %int1, i32 %int2, float %float1, float %float2, double %double1, double %double2) #0 {
; CHECK-LABEL: call_to_non_streaming_pass_args:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #112
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    stp d15, d14, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #80] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x9, [sp, #96] // 16-byte Folded Spill
; CHECK-NEXT:    stp d2, d3, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp s0, s1, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:    ldp s0, s1, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d2, d3, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    bl bar
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:    ldp d9, d8, [sp, #80] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #96] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #112
; CHECK-NEXT:    ret
entry:
  call void @bar(ptr noundef nonnull %ptr, i64 %long1, i64 %long2, i32 %int1, i32 %int2, float %float1, float %float2, double %double1, double %double2)
  ret void
}

declare i64 @llvm.aarch64.sme.cntsb()

declare void @foo(ptr noundef, ptr noundef, ptr noundef, i64 noundef)
declare void @bar(ptr noundef, i64 noundef, i64 noundef, i32 noundef, i32 noundef, float noundef, float noundef, double noundef, double noundef)

attributes #0 = { nounwind vscale_range(1,16) "aarch64_pstate_sm_enabled" }

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -global-isel=0 -mtriple=aarch64-unknown-unknown < %s | FileCheck -check-prefixes=CHECK,CVT,SDAG,CVT-SDAG %s
; RUN: llc -global-isel=0 -mtriple=aarch64-unknown-unknown -mattr=+fullfp16 < %s | FileCheck -check-prefixes=CHECK,FP16,SDAG,FP16-SDAG %s
; RUN: llc -global-isel=1 -mtriple=aarch64-unknown-unknown < %s | FileCheck -check-prefixes=CHECK,CVT,GISEL,CVT-GISEL %s
; RUN: llc -global-isel=1 -mtriple=aarch64-unknown-unknown -mattr=+fullfp16 < %s | FileCheck -check-prefixes=CHECK,FP16,GISEL,FP16-GISEL %s

declare half @llvm.exp10.f16(half)
declare <1 x half> @llvm.exp10.v1f16(<1 x half>)
declare <2 x half> @llvm.exp10.v2f16(<2 x half>)
declare <3 x half> @llvm.exp10.v3f16(<3 x half>)
declare <4 x half> @llvm.exp10.v4f16(<4 x half>)
declare float @llvm.exp10.f32(float)
declare <1 x float> @llvm.exp10.v1f32(<1 x float>)
declare <2 x float> @llvm.exp10.v2f32(<2 x float>)
declare <3 x float> @llvm.exp10.v3f32(<3 x float>)
declare <4 x float> @llvm.exp10.v4f32(<4 x float>)
declare double @llvm.exp10.f64(double)
declare <1 x double> @llvm.exp10.v1f64(<1 x double>)
declare <2 x double> @llvm.exp10.v2f64(<2 x double>)
declare <3 x double> @llvm.exp10.v3f64(<3 x double>)
declare <4 x double> @llvm.exp10.v4f64(<4 x double>)

define half @exp10_f16(half %x) {
; CHECK-LABEL: exp10_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    bl exp10f
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %r = call half @llvm.exp10.f16(half %x)
  ret half %r
}

define <1 x half> @exp10_v1f16(<1 x half> %x) {
; CHECK-LABEL: exp10_v1f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    bl exp10f
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %r = call <1 x half> @llvm.exp10.v1f16(<1 x half> %x)
  ret <1 x half> %r
}

define <2 x half> @exp10_v2f16(<2 x half> %x) {
; SDAG-LABEL: exp10_v2f16:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    mov h1, v0.h[1]
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h0, s0
; SDAG-NEXT:    fcvt s1, h1
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    fmov s0, s1
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h2, s0
; SDAG-NEXT:    mov h1, v1.h[2]
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    mov v2.h[1], v1.h[0]
; SDAG-NEXT:    str q2, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h2, s0
; SDAG-NEXT:    mov h1, v1.h[3]
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    mov v1.h[2], v2.h[0]
; SDAG-NEXT:    str q1, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    fcvt h1, s0
; SDAG-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v0.h[3], v1.h[0]
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v2f16:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #32
; GISEL-NEXT:    str d8, [sp, #16] // 8-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #24] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 32
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset b8, -16
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    mov h8, v0.h[1]
; GISEL-NEXT:    fcvt s0, h0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt s1, h8
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s1
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt h1, s0
; GISEL-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    ldr x30, [sp, #24] // 8-byte Folded Reload
; GISEL-NEXT:    ldr d8, [sp, #16] // 8-byte Folded Reload
; GISEL-NEXT:    mov v0.h[1], v1.h[0]
; GISEL-NEXT:    // kill: def $d0 killed $d0 killed $q0
; GISEL-NEXT:    add sp, sp, #32
; GISEL-NEXT:    ret
  %r = call <2 x half> @llvm.exp10.v2f16(<2 x half> %x)
  ret <2 x half> %r
}

define <3 x half> @exp10_v3f16(<3 x half> %x) {
; SDAG-LABEL: exp10_v3f16:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    mov h1, v0.h[1]
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h0, s0
; SDAG-NEXT:    fcvt s1, h1
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    fmov s0, s1
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h2, s0
; SDAG-NEXT:    mov h1, v1.h[2]
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    mov v2.h[1], v1.h[0]
; SDAG-NEXT:    str q2, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h2, s0
; SDAG-NEXT:    mov h1, v1.h[3]
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    mov v1.h[2], v2.h[0]
; SDAG-NEXT:    str q1, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    fcvt h1, s0
; SDAG-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v0.h[3], v1.h[0]
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v3f16:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #64
; GISEL-NEXT:    stp d9, d8, [sp, #32] // 16-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #48] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 64
; GISEL-NEXT:    .cfi_offset w30, -16
; GISEL-NEXT:    .cfi_offset b8, -24
; GISEL-NEXT:    .cfi_offset b9, -32
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    mov h8, v0.h[1]
; GISEL-NEXT:    mov h9, v0.h[2]
; GISEL-NEXT:    fcvt s0, h0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt s1, h8
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s1
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt s1, h9
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s1
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    ldp q2, q1, [sp] // 32-byte Folded Reload
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    ldp d9, d8, [sp, #32] // 16-byte Folded Reload
; GISEL-NEXT:    ldr x30, [sp, #48] // 8-byte Folded Reload
; GISEL-NEXT:    mov v1.h[1], v2.h[0]
; GISEL-NEXT:    mov v1.h[2], v0.h[0]
; GISEL-NEXT:    mov v0.16b, v1.16b
; GISEL-NEXT:    // kill: def $d0 killed $d0 killed $q0
; GISEL-NEXT:    add sp, sp, #64
; GISEL-NEXT:    ret
  %r = call <3 x half> @llvm.exp10.v3f16(<3 x half> %x)
  ret <3 x half> %r
}

define <4 x half> @exp10_v4f16(<4 x half> %x) {
; SDAG-LABEL: exp10_v4f16:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    mov h1, v0.h[1]
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h0, s0
; SDAG-NEXT:    fcvt s1, h1
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    fmov s0, s1
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h2, s0
; SDAG-NEXT:    mov h1, v1.h[2]
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    mov v2.h[1], v1.h[0]
; SDAG-NEXT:    str q2, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    fcvt h2, s0
; SDAG-NEXT:    mov h1, v1.h[3]
; SDAG-NEXT:    fcvt s0, h1
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    mov v1.h[2], v2.h[0]
; SDAG-NEXT:    str q1, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    fcvt h1, s0
; SDAG-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v0.h[3], v1.h[0]
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v4f16:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #80
; GISEL-NEXT:    str d10, [sp, #48] // 8-byte Folded Spill
; GISEL-NEXT:    stp d9, d8, [sp, #56] // 16-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #72] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 80
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset b8, -16
; GISEL-NEXT:    .cfi_offset b9, -24
; GISEL-NEXT:    .cfi_offset b10, -32
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    mov h8, v0.h[1]
; GISEL-NEXT:    mov h9, v0.h[2]
; GISEL-NEXT:    mov h10, v0.h[3]
; GISEL-NEXT:    fcvt s0, h0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt s1, h8
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    str q0, [sp, #32] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s1
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt s1, h9
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s1
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    fcvt s1, h10
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s1
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    ldp q3, q2, [sp] // 32-byte Folded Reload
; GISEL-NEXT:    fcvt h0, s0
; GISEL-NEXT:    ldr q1, [sp, #32] // 16-byte Folded Reload
; GISEL-NEXT:    ldp d9, d8, [sp, #56] // 16-byte Folded Reload
; GISEL-NEXT:    ldr x30, [sp, #72] // 8-byte Folded Reload
; GISEL-NEXT:    ldr d10, [sp, #48] // 8-byte Folded Reload
; GISEL-NEXT:    mov v1.h[1], v3.h[0]
; GISEL-NEXT:    mov v1.h[2], v2.h[0]
; GISEL-NEXT:    mov v1.h[3], v0.h[0]
; GISEL-NEXT:    mov v0.16b, v1.16b
; GISEL-NEXT:    // kill: def $d0 killed $d0 killed $q0
; GISEL-NEXT:    add sp, sp, #80
; GISEL-NEXT:    ret
  %r = call <4 x half> @llvm.exp10.v4f16(<4 x half> %x)
  ret <4 x half> %r
}

define float @exp10_f32(float %x) {
; CHECK-LABEL: exp10_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    b exp10f
  %r = call float @llvm.exp10.f32(float %x)
  ret float %r
}

define <1 x float> @exp10_v1f32(<1 x float> %x) {
; SDAG-LABEL: exp10_v1f32:
; SDAG:       // %bb.0:
; SDAG-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 16
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    // kill: def $s0 killed $s0 killed $q0
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $d0
; SDAG-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v1f32:
; GISEL:       // %bb.0:
; GISEL-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 16
; GISEL-NEXT:    .cfi_offset w30, -16
; GISEL-NEXT:    // kill: def $s0 killed $s0 killed $d0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $d0
; GISEL-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; GISEL-NEXT:    ret
  %r = call <1 x float> @llvm.exp10.v1f32(<1 x float> %x)
  ret <1 x float> %r
}

define <2 x float> @exp10_v2f32(<2 x float> %x) {
; SDAG-LABEL: exp10_v2f32:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    mov s0, v0.s[1]
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 killed $q0
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v0.s[1], v1.s[0]
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v2f32:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #32
; GISEL-NEXT:    str d8, [sp, #16] // 8-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #24] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 32
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset b8, -16
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    mov s8, v0.s[1]
; GISEL-NEXT:    // kill: def $s0 killed $s0 killed $q0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s8
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    ldr x30, [sp, #24] // 8-byte Folded Reload
; GISEL-NEXT:    ldr d8, [sp, #16] // 8-byte Folded Reload
; GISEL-NEXT:    mov v1.s[1], v0.s[0]
; GISEL-NEXT:    fmov d0, d1
; GISEL-NEXT:    add sp, sp, #32
; GISEL-NEXT:    ret
  %r = call <2 x float> @llvm.exp10.v2f32(<2 x float> %x)
  ret <2 x float> %r
}

define <3 x float> @exp10_v3f32(<3 x float> %x) {
; SDAG-LABEL: exp10_v3f32:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    mov s0, v0.s[1]
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 killed $q0
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    mov v0.s[1], v1.s[0]
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    mov s0, v0.s[2]
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v1.s[2], v0.s[0]
; SDAG-NEXT:    mov v0.16b, v1.16b
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v3f32:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #64
; GISEL-NEXT:    stp d9, d8, [sp, #32] // 16-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #48] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 64
; GISEL-NEXT:    .cfi_offset w30, -16
; GISEL-NEXT:    .cfi_offset b8, -24
; GISEL-NEXT:    .cfi_offset b9, -32
; GISEL-NEXT:    mov s8, v0.s[1]
; GISEL-NEXT:    mov s9, v0.s[2]
; GISEL-NEXT:    // kill: def $s0 killed $s0 killed $q0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s8
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s9
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    ldp q2, q1, [sp] // 32-byte Folded Reload
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    ldr x30, [sp, #48] // 8-byte Folded Reload
; GISEL-NEXT:    ldp d9, d8, [sp, #32] // 16-byte Folded Reload
; GISEL-NEXT:    mov v1.s[1], v2.s[0]
; GISEL-NEXT:    mov v1.s[2], v0.s[0]
; GISEL-NEXT:    mov v0.16b, v1.16b
; GISEL-NEXT:    add sp, sp, #64
; GISEL-NEXT:    ret
  %r = call <3 x float> @llvm.exp10.v3f32(<3 x float> %x)
  ret <3 x float> %r
}

define <4 x float> @exp10_v4f32(<4 x float> %x) {
; SDAG-LABEL: exp10_v4f32:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    mov s0, v0.s[1]
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 killed $q0
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    mov v0.s[1], v1.s[0]
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    mov s0, v0.s[2]
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    mov v1.s[2], v0.s[0]
; SDAG-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    mov s0, v0.s[3]
; SDAG-NEXT:    str q1, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10f
; SDAG-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $s0 killed $s0 def $q0
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v1.s[3], v0.s[0]
; SDAG-NEXT:    mov v0.16b, v1.16b
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v4f32:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #80
; GISEL-NEXT:    str d10, [sp, #48] // 8-byte Folded Spill
; GISEL-NEXT:    stp d9, d8, [sp, #56] // 16-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #72] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 80
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset b8, -16
; GISEL-NEXT:    .cfi_offset b9, -24
; GISEL-NEXT:    .cfi_offset b10, -32
; GISEL-NEXT:    mov s8, v0.s[1]
; GISEL-NEXT:    mov s9, v0.s[2]
; GISEL-NEXT:    mov s10, v0.s[3]
; GISEL-NEXT:    // kill: def $s0 killed $s0 killed $q0
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    str q0, [sp, #32] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s8
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s9
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov s0, s10
; GISEL-NEXT:    bl exp10f
; GISEL-NEXT:    ldp q2, q1, [sp, #16] // 32-byte Folded Reload
; GISEL-NEXT:    // kill: def $s0 killed $s0 def $q0
; GISEL-NEXT:    ldr x30, [sp, #72] // 8-byte Folded Reload
; GISEL-NEXT:    ldp d9, d8, [sp, #56] // 16-byte Folded Reload
; GISEL-NEXT:    ldr d10, [sp, #48] // 8-byte Folded Reload
; GISEL-NEXT:    mov v1.s[1], v2.s[0]
; GISEL-NEXT:    ldr q2, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    mov v1.s[2], v2.s[0]
; GISEL-NEXT:    mov v1.s[3], v0.s[0]
; GISEL-NEXT:    mov v0.16b, v1.16b
; GISEL-NEXT:    add sp, sp, #80
; GISEL-NEXT:    ret
  %r = call <4 x float> @llvm.exp10.v4f32(<4 x float> %x)
  ret <4 x float> %r
}

define double @exp10_f64(double %x) {
; CHECK-LABEL: exp10_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    b exp10
  %r = call double @llvm.exp10.f64(double %x)
  ret double %r
}

define <1 x double> @exp10_v1f64(<1 x double> %x) {
; CHECK-LABEL: exp10_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl exp10
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %r = call <1 x double> @llvm.exp10.v1f64(<1 x double> %x)
  ret <1 x double> %r
}

define <2 x double> @exp10_v2f64(<2 x double> %x) {
; SDAG-LABEL: exp10_v2f64:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #48
; SDAG-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 48
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    mov d0, v0.d[1]
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; SDAG-NEXT:    mov v0.d[1], v1.d[0]
; SDAG-NEXT:    add sp, sp, #48
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v2f64:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #32
; GISEL-NEXT:    str d8, [sp, #16] // 8-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #24] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 32
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset b8, -16
; GISEL-NEXT:    mov d8, v0.d[1]
; GISEL-NEXT:    // kill: def $d0 killed $d0 killed $q0
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov d0, d8
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    ldr x30, [sp, #24] // 8-byte Folded Reload
; GISEL-NEXT:    ldr d8, [sp, #16] // 8-byte Folded Reload
; GISEL-NEXT:    mov v1.d[1], v0.d[0]
; GISEL-NEXT:    mov v0.16b, v1.16b
; GISEL-NEXT:    add sp, sp, #32
; GISEL-NEXT:    ret
  %r = call <2 x double> @llvm.exp10.v2f64(<2 x double> %x)
  ret <2 x double> %r
}

define <3 x double> @exp10_v3f64(<3 x double> %x) {
; SDAG-LABEL: exp10_v3f64:
; SDAG:       // %bb.0:
; SDAG-NEXT:    str d10, [sp, #-32]! // 8-byte Folded Spill
; SDAG-NEXT:    stp d9, d8, [sp, #8] // 16-byte Folded Spill
; SDAG-NEXT:    str x30, [sp, #24] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 32
; SDAG-NEXT:    .cfi_offset w30, -8
; SDAG-NEXT:    .cfi_offset b8, -16
; SDAG-NEXT:    .cfi_offset b9, -24
; SDAG-NEXT:    .cfi_offset b10, -32
; SDAG-NEXT:    fmov d8, d2
; SDAG-NEXT:    fmov d9, d1
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    fmov d10, d0
; SDAG-NEXT:    fmov d0, d9
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    fmov d9, d0
; SDAG-NEXT:    fmov d0, d8
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    fmov d1, d9
; SDAG-NEXT:    ldp d9, d8, [sp, #8] // 16-byte Folded Reload
; SDAG-NEXT:    ldr x30, [sp, #24] // 8-byte Folded Reload
; SDAG-NEXT:    fmov d2, d0
; SDAG-NEXT:    fmov d0, d10
; SDAG-NEXT:    ldr d10, [sp], #32 // 8-byte Folded Reload
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v3f64:
; GISEL:       // %bb.0:
; GISEL-NEXT:    str d10, [sp, #-32]! // 8-byte Folded Spill
; GISEL-NEXT:    stp d9, d8, [sp, #8] // 16-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #24] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 32
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset b8, -16
; GISEL-NEXT:    .cfi_offset b9, -24
; GISEL-NEXT:    .cfi_offset b10, -32
; GISEL-NEXT:    fmov d8, d1
; GISEL-NEXT:    fmov d9, d2
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    fmov d10, d0
; GISEL-NEXT:    fmov d0, d8
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    fmov d8, d0
; GISEL-NEXT:    fmov d0, d9
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    fmov d1, d8
; GISEL-NEXT:    ldp d9, d8, [sp, #8] // 16-byte Folded Reload
; GISEL-NEXT:    ldr x30, [sp, #24] // 8-byte Folded Reload
; GISEL-NEXT:    fmov d2, d0
; GISEL-NEXT:    fmov d0, d10
; GISEL-NEXT:    ldr d10, [sp], #32 // 8-byte Folded Reload
; GISEL-NEXT:    ret
  %r = call <3 x double> @llvm.exp10.v3f64(<3 x double> %x)
  ret <3 x double> %r
}

define <4 x double> @exp10_v4f64(<4 x double> %x) {
; SDAG-LABEL: exp10_v4f64:
; SDAG:       // %bb.0:
; SDAG-NEXT:    sub sp, sp, #64
; SDAG-NEXT:    str x30, [sp, #48] // 8-byte Folded Spill
; SDAG-NEXT:    .cfi_def_cfa_offset 64
; SDAG-NEXT:    .cfi_offset w30, -16
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    mov d0, v0.d[1]
; SDAG-NEXT:    str q1, [sp, #32] // 16-byte Folded Spill
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    mov v0.d[1], v1.d[0]
; SDAG-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp, #32] // 16-byte Folded Reload
; SDAG-NEXT:    mov d0, v0.d[1]
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    // kill: def $d0 killed $d0 def $q0
; SDAG-NEXT:    str q0, [sp] // 16-byte Folded Spill
; SDAG-NEXT:    ldr q0, [sp, #32] // 16-byte Folded Reload
; SDAG-NEXT:    // kill: def $d0 killed $d0 killed $q0
; SDAG-NEXT:    bl exp10
; SDAG-NEXT:    fmov d1, d0
; SDAG-NEXT:    ldp q2, q0, [sp] // 32-byte Folded Reload
; SDAG-NEXT:    ldr x30, [sp, #48] // 8-byte Folded Reload
; SDAG-NEXT:    mov v1.d[1], v2.d[0]
; SDAG-NEXT:    add sp, sp, #64
; SDAG-NEXT:    ret
;
; GISEL-LABEL: exp10_v4f64:
; GISEL:       // %bb.0:
; GISEL-NEXT:    sub sp, sp, #80
; GISEL-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; GISEL-NEXT:    str x30, [sp, #64] // 8-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 80
; GISEL-NEXT:    .cfi_offset w30, -16
; GISEL-NEXT:    .cfi_offset b8, -24
; GISEL-NEXT:    .cfi_offset b9, -32
; GISEL-NEXT:    str q1, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    mov d8, v0.d[1]
; GISEL-NEXT:    mov d9, v1.d[1]
; GISEL-NEXT:    // kill: def $d0 killed $d0 killed $q0
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    str q0, [sp, #32] // 16-byte Folded Spill
; GISEL-NEXT:    fmov d0, d8
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; GISEL-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    // kill: def $d0 killed $d0 killed $q0
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:    fmov d0, d9
; GISEL-NEXT:    bl exp10
; GISEL-NEXT:    ldp q1, q2, [sp, #16] // 32-byte Folded Reload
; GISEL-NEXT:    // kill: def $d0 killed $d0 def $q0
; GISEL-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; GISEL-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; GISEL-NEXT:    mov v2.d[1], v1.d[0]
; GISEL-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    mov v1.d[1], v0.d[0]
; GISEL-NEXT:    mov v0.16b, v2.16b
; GISEL-NEXT:    add sp, sp, #80
; GISEL-NEXT:    ret
  %r = call <4 x double> @llvm.exp10.v4f64(<4 x double> %x)
  ret <4 x double> %r
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CVT: {{.*}}
; CVT-GISEL: {{.*}}
; CVT-SDAG: {{.*}}
; FP16: {{.*}}
; FP16-GISEL: {{.*}}
; FP16-SDAG: {{.*}}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s | FileCheck %s

define <vscale x 2 x i8> @test_compress_nxv2i8(<vscale x 2 x i8> %vec, <vscale x 2 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    ret
    %out = call <vscale x 2 x i8> @llvm.experimental.vector.compress(<vscale x 2 x i8> %vec, <vscale x 2 x i1> %mask, <vscale x 2 x i8> undef)
    ret <vscale x 2 x i8> %out
}

define <vscale x 2 x i16> @test_compress_nxv2i16(<vscale x 2 x i16> %vec, <vscale x 2 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    ret
    %out = call <vscale x 2 x i16> @llvm.experimental.vector.compress(<vscale x 2 x i16> %vec, <vscale x 2 x i1> %mask, <vscale x 2 x i16> undef)
    ret <vscale x 2 x i16> %out
}

define <vscale x 2 x i32> @test_compress_nxv2i32(<vscale x 2 x i32> %vec, <vscale x 2 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    ret
    %out = call <vscale x 2 x i32> @llvm.experimental.vector.compress(<vscale x 2 x i32> %vec, <vscale x 2 x i1> %mask, <vscale x 2 x i32> undef)
    ret <vscale x 2 x i32> %out
}

define <vscale x 2 x i64> @test_compress_nxv2i64(<vscale x 2 x i64> %vec, <vscale x 2 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    ret
    %out = call <vscale x 2 x i64> @llvm.experimental.vector.compress(<vscale x 2 x i64> %vec, <vscale x 2 x i1> %mask, <vscale x 2 x i64> undef)
    ret <vscale x 2 x i64> %out
}

define <vscale x 2 x float> @test_compress_nxv2f32(<vscale x 2 x float> %vec, <vscale x 2 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    ret
    %out = call <vscale x 2 x float> @llvm.experimental.vector.compress(<vscale x 2 x float> %vec, <vscale x 2 x i1> %mask, <vscale x 2 x float> undef)
    ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @test_compress_nxv2f64(<vscale x 2 x double> %vec, <vscale x 2 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    ret
    %out = call <vscale x 2 x double> @llvm.experimental.vector.compress(<vscale x 2 x double> %vec, <vscale x 2 x i1> %mask, <vscale x 2 x double> undef)
    ret <vscale x 2 x double> %out
}

define <vscale x 4 x i8> @test_compress_nxv4i8(<vscale x 4 x i8> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i8> @llvm.experimental.vector.compress(<vscale x 4 x i8> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i8> undef)
    ret <vscale x 4 x i8> %out
}

define <vscale x 4 x i16> @test_compress_nxv4i16(<vscale x 4 x i16> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i16> @llvm.experimental.vector.compress(<vscale x 4 x i16> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i16> undef)
    ret <vscale x 4 x i16> %out
}

define <vscale x 4 x i32> @test_compress_nxv4i32(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
    ret <vscale x 4 x i32> %out
}

define <vscale x 4 x float> @test_compress_nxv4f32(<vscale x 4 x float> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x float> @llvm.experimental.vector.compress(<vscale x 4 x float> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x float> undef)
    ret <vscale x 4 x float> %out
}

define <vscale x 4 x i4> @test_compress_illegal_element_type(<vscale x 4 x i4> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_illegal_element_type:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i4> @llvm.experimental.vector.compress(<vscale x 4 x i4> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i4> undef)
    ret <vscale x 4 x i4> %out
}

define <vscale x 8 x i32> @test_compress_large(<vscale x 8 x i32> %vec, <vscale x 8 x i1> %mask) {
; CHECK-LABEL: test_compress_large:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    punpklo p2.h, p0.b
; CHECK-NEXT:    cnth x9
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    sub x9, x9, #1
; CHECK-NEXT:    punpkhi p0.h, p0.b
; CHECK-NEXT:    compact z0.s, p2, z0.s
; CHECK-NEXT:    cntp x8, p1, p2.s
; CHECK-NEXT:    compact z1.s, p0, z1.s
; CHECK-NEXT:    st1w { z0.s }, p1, [sp]
; CHECK-NEXT:    mov w8, w8
; CHECK-NEXT:    cmp x8, x9
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1w { z1.s }, p1, [x9, x8, lsl #2]
; CHECK-NEXT:    ld1w { z0.s }, p1/z, [sp]
; CHECK-NEXT:    ld1w { z1.s }, p1/z, [sp, #1, mul vl]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %out = call <vscale x 8 x i32> @llvm.experimental.vector.compress(<vscale x 8 x i32> %vec, <vscale x 8 x i1> %mask, <vscale x 8 x i32> undef)
    ret <vscale x 8 x i32> %out
}

; We pass a placeholder value for the const_mask* tests to check that they are converted to a no-op by simply copying
; the second vector input register to the ret register or doing nothing.
define <vscale x 4 x i32> @test_compress_const_splat1_mask(<vscale x 4 x i32> %ignore, <vscale x 4 x i32> %vec) {
; CHECK-LABEL: test_compress_const_splat1_mask:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> splat (i1 -1), <vscale x 4 x i32> undef)
    ret <vscale x 4 x i32> %out
}
define <vscale x 4 x i32> @test_compress_const_splat0_mask(<vscale x 4 x i32> %ignore, <vscale x 4 x i32> %vec) {
; CHECK-LABEL: test_compress_const_splat0_mask:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> splat (i1 0), <vscale x 4 x i32> undef)
    ret <vscale x 4 x i32> %out
}
define <vscale x 4 x i32> @test_compress_undef_mask(<vscale x 4 x i32> %ignore, <vscale x 4 x i32> %vec) {
; CHECK-LABEL: test_compress_undef_mask:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
    ret <vscale x 4 x i32> %out
}

define <4 x i32> @test_compress_v4i32_with_sve(<4 x i32> %vec, <4 x i1> %mask) {
; CHECK-LABEL: test_compress_v4i32_with_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v1.4s, v1.4h, #0
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    shl v1.4s, v1.4s, #31
; CHECK-NEXT:    cmlt v1.4s, v1.4s, #0
; CHECK-NEXT:    and z1.s, z1.s, #0x1
; CHECK-NEXT:    cmpne p0.s, p0/z, z1.s, #0
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
    %out = call <4 x i32> @llvm.experimental.vector.compress(<4 x i32> %vec, <4 x i1> %mask, <4 x i32> undef)
    ret <4 x i32> %out
}

define <1 x i32> @test_compress_v1i32_with_sve(<1 x i32> %vec, <1 x i1> %mask) {
; CHECK-LABEL: test_compress_v1i32_with_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2d, #0000000000000000
; CHECK-NEXT:    sbfx w8, w0, #0, #1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    mov v1.s[0], w8
; CHECK-NEXT:    ushll v1.2d, v1.2s, #0
; CHECK-NEXT:    and z1.d, z1.d, #0x1
; CHECK-NEXT:    cmpne p0.d, p0/z, z1.d, #0
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    ret
    %out = call <1 x i32> @llvm.experimental.vector.compress(<1 x i32> %vec, <1 x i1> %mask, <1 x i32> undef)
    ret <1 x i32> %out
}

define <4 x double> @test_compress_v4f64_with_sve(<4 x double> %vec, <4 x i1> %mask) {
; CHECK-LABEL: test_compress_v4f64_with_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    ushll v2.4s, v2.4h, #0
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    ushll v3.2d, v2.2s, #0
; CHECK-NEXT:    ushll2 v4.2d, v2.4s, #0
; CHECK-NEXT:    fmov x8, d2
; CHECK-NEXT:    shl v3.2d, v3.2d, #63
; CHECK-NEXT:    shl v4.2d, v4.2d, #63
; CHECK-NEXT:    lsr x9, x8, #32
; CHECK-NEXT:    eor w8, w8, w9
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    cmlt v3.2d, v3.2d, #0
; CHECK-NEXT:    cmlt v4.2d, v4.2d, #0
; CHECK-NEXT:    and x8, x8, #0x3
; CHECK-NEXT:    lsl x8, x8, #3
; CHECK-NEXT:    and z3.d, z3.d, #0x1
; CHECK-NEXT:    and z4.d, z4.d, #0x1
; CHECK-NEXT:    cmpne p1.d, p0/z, z3.d, #0
; CHECK-NEXT:    cmpne p0.d, p0/z, z4.d, #0
; CHECK-NEXT:    compact z0.d, p1, z0.d
; CHECK-NEXT:    compact z1.d, p0, z1.d
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    str q1, [x9, x8]
; CHECK-NEXT:    ldp q0, q1, [sp], #32
; CHECK-NEXT:    ret
    %out = call <4 x double> @llvm.experimental.vector.compress(<4 x double> %vec, <4 x i1> %mask, <4 x double> undef)
    ret <4 x double> %out
}

define <2 x i16> @test_compress_v2i16_with_sve(<2 x i16> %vec, <2 x i1> %mask) {
; CHECK-LABEL: test_compress_v2i16_with_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v1.2d, v1.2s, #0
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    and z1.d, z1.d, #0x1
; CHECK-NEXT:    cmpne p0.d, p0/z, z1.d, #0
; CHECK-NEXT:    compact z0.d, p0, z0.d
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    ret
    %out = call <2 x i16> @llvm.experimental.vector.compress(<2 x i16> %vec, <2 x i1> %mask, <2 x i16> undef)
    ret <2 x i16> %out
}


define <vscale x 4 x i32> @test_compress_nxv4i32_with_passthru(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i32> %passthru) {
; CHECK-LABEL: test_compress_nxv4i32_with_passthru:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntp x8, p0, p0.s
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    whilelo p0.s, xzr, x8
; CHECK-NEXT:    sel z0.s, p0, z0.s, z1.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i32> %passthru)
    ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @test_compress_nxv4i32_with_zero_passthru(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv4i32_with_zero_passthru:
; CHECK:       // %bb.0:
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i32> splat(i32 0))
    ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @test_compress_nxv4i32_with_const_passthru(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: test_compress_nxv4i32_with_const_passthru:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cntp x8, p0, p0.s
; CHECK-NEXT:    compact z0.s, p0, z0.s
; CHECK-NEXT:    mov z1.s, #5 // =0x5
; CHECK-NEXT:    whilelo p0.s, xzr, x8
; CHECK-NEXT:    sel z0.s, p0, z0.s, z1.s
; CHECK-NEXT:    ret
    %out = call <vscale x 4 x i32> @llvm.experimental.vector.compress(<vscale x 4 x i32> %vec, <vscale x 4 x i1> %mask, <vscale x 4 x i32> splat(i32 5))
    ret <vscale x 4 x i32> %out
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s --check-prefixes=SDAG
; RUN: llc < %s -mtriple=aarch64-unknown-unknown -global-isel | FileCheck %s --check-prefixes=GISEL

; These tests are taken from the combine-udiv.ll in X86.
define <8 x i16> @combine_vec_udiv_uniform(<8 x i16> %x) {
; SDAG-LABEL: combine_vec_udiv_uniform:
; SDAG:       // %bb.0:
; SDAG-NEXT:    mov w8, #25645 // =0x642d
; SDAG-NEXT:    dup v1.8h, w8
; SDAG-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; SDAG-NEXT:    umull v1.4s, v0.4h, v1.4h
; SDAG-NEXT:    uzp2 v1.8h, v1.8h, v2.8h
; SDAG-NEXT:    sub v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    usra v1.8h, v0.8h, #1
; SDAG-NEXT:    ushr v0.8h, v1.8h, #4
; SDAG-NEXT:    ret
;
; GISEL-LABEL: combine_vec_udiv_uniform:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI0_0
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI0_0]
; GISEL-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; GISEL-NEXT:    umull v1.4s, v0.4h, v1.4h
; GISEL-NEXT:    uzp2 v1.8h, v1.8h, v2.8h
; GISEL-NEXT:    sub v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    usra v1.8h, v0.8h, #1
; GISEL-NEXT:    ushr v0.8h, v1.8h, #4
; GISEL-NEXT:    ret
  %1 = udiv <8 x i16> %x, <i16 23, i16 23, i16 23, i16 23, i16 23, i16 23, i16 23, i16 23>
  ret <8 x i16> %1
}

define <8 x i16> @combine_vec_udiv_nonuniform(<8 x i16> %x) {
; SDAG-LABEL: combine_vec_udiv_nonuniform:
; SDAG:       // %bb.0:
; SDAG-NEXT:    adrp x8, .LCPI1_0
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI1_0]
; SDAG-NEXT:    adrp x8, .LCPI1_1
; SDAG-NEXT:    ldr q2, [x8, :lo12:.LCPI1_1]
; SDAG-NEXT:    adrp x8, .LCPI1_2
; SDAG-NEXT:    ushl v1.8h, v0.8h, v1.8h
; SDAG-NEXT:    umull2 v3.4s, v1.8h, v2.8h
; SDAG-NEXT:    umull v1.4s, v1.4h, v2.4h
; SDAG-NEXT:    ldr q2, [x8, :lo12:.LCPI1_2]
; SDAG-NEXT:    adrp x8, .LCPI1_3
; SDAG-NEXT:    uzp2 v1.8h, v1.8h, v3.8h
; SDAG-NEXT:    sub v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    umull2 v3.4s, v0.8h, v2.8h
; SDAG-NEXT:    umull v0.4s, v0.4h, v2.4h
; SDAG-NEXT:    uzp2 v0.8h, v0.8h, v3.8h
; SDAG-NEXT:    add v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI1_3]
; SDAG-NEXT:    ushl v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    ret
;
; GISEL-LABEL: combine_vec_udiv_nonuniform:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI1_3
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI1_3]
; GISEL-NEXT:    adrp x8, .LCPI1_2
; GISEL-NEXT:    ldr q2, [x8, :lo12:.LCPI1_2]
; GISEL-NEXT:    adrp x8, .LCPI1_1
; GISEL-NEXT:    neg v1.8h, v1.8h
; GISEL-NEXT:    ushl v1.8h, v0.8h, v1.8h
; GISEL-NEXT:    umull2 v3.4s, v1.8h, v2.8h
; GISEL-NEXT:    umull v1.4s, v1.4h, v2.4h
; GISEL-NEXT:    ldr q2, [x8, :lo12:.LCPI1_1]
; GISEL-NEXT:    adrp x8, .LCPI1_0
; GISEL-NEXT:    uzp2 v1.8h, v1.8h, v3.8h
; GISEL-NEXT:    sub v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    umull2 v3.4s, v0.8h, v2.8h
; GISEL-NEXT:    umull v0.4s, v0.4h, v2.4h
; GISEL-NEXT:    ldr q2, [x8, :lo12:.LCPI1_0]
; GISEL-NEXT:    uzp2 v0.8h, v0.8h, v3.8h
; GISEL-NEXT:    add v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    neg v1.8h, v2.8h
; GISEL-NEXT:    ushl v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    ret
  %1 = udiv <8 x i16> %x, <i16 23, i16 34, i16 -23, i16 56, i16 128, i16 -1, i16 -256, i16 -32768>
  ret <8 x i16> %1
}

define <8 x i16> @combine_vec_udiv_nonuniform2(<8 x i16> %x) {
; SDAG-LABEL: combine_vec_udiv_nonuniform2:
; SDAG:       // %bb.0:
; SDAG-NEXT:    adrp x8, .LCPI2_0
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI2_0]
; SDAG-NEXT:    adrp x8, .LCPI2_1
; SDAG-NEXT:    ushl v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI2_1]
; SDAG-NEXT:    adrp x8, .LCPI2_2
; SDAG-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; SDAG-NEXT:    umull v0.4s, v0.4h, v1.4h
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI2_2]
; SDAG-NEXT:    uzp2 v0.8h, v0.8h, v2.8h
; SDAG-NEXT:    ushl v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    ret
;
; GISEL-LABEL: combine_vec_udiv_nonuniform2:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI2_2
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI2_2]
; GISEL-NEXT:    adrp x8, .LCPI2_1
; GISEL-NEXT:    neg v1.8h, v1.8h
; GISEL-NEXT:    ushl v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI2_1]
; GISEL-NEXT:    adrp x8, .LCPI2_0
; GISEL-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; GISEL-NEXT:    umull v0.4s, v0.4h, v1.4h
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI2_0]
; GISEL-NEXT:    neg v1.8h, v1.8h
; GISEL-NEXT:    uzp2 v0.8h, v0.8h, v2.8h
; GISEL-NEXT:    ushl v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    ret
  %1 = udiv <8 x i16> %x, <i16 -34, i16 35, i16 36, i16 -37, i16 38, i16 -39, i16 40, i16 -41>
  ret <8 x i16> %1
}

define <8 x i16> @combine_vec_udiv_nonuniform3(<8 x i16> %x) {
; SDAG-LABEL: combine_vec_udiv_nonuniform3:
; SDAG:       // %bb.0:
; SDAG-NEXT:    adrp x8, .LCPI3_0
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI3_0]
; SDAG-NEXT:    adrp x8, .LCPI3_1
; SDAG-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; SDAG-NEXT:    umull v1.4s, v0.4h, v1.4h
; SDAG-NEXT:    uzp2 v1.8h, v1.8h, v2.8h
; SDAG-NEXT:    sub v0.8h, v0.8h, v1.8h
; SDAG-NEXT:    usra v1.8h, v0.8h, #1
; SDAG-NEXT:    ldr q0, [x8, :lo12:.LCPI3_1]
; SDAG-NEXT:    ushl v0.8h, v1.8h, v0.8h
; SDAG-NEXT:    ret
;
; GISEL-LABEL: combine_vec_udiv_nonuniform3:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI3_1
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI3_1]
; GISEL-NEXT:    adrp x8, .LCPI3_0
; GISEL-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; GISEL-NEXT:    umull v1.4s, v0.4h, v1.4h
; GISEL-NEXT:    uzp2 v1.8h, v1.8h, v2.8h
; GISEL-NEXT:    ldr q2, [x8, :lo12:.LCPI3_0]
; GISEL-NEXT:    sub v0.8h, v0.8h, v1.8h
; GISEL-NEXT:    usra v1.8h, v0.8h, #1
; GISEL-NEXT:    neg v0.8h, v2.8h
; GISEL-NEXT:    ushl v0.8h, v1.8h, v0.8h
; GISEL-NEXT:    ret
  %1 = udiv <8 x i16> %x, <i16 7, i16 23, i16 25, i16 27, i16 31, i16 47, i16 63, i16 127>
  ret <8 x i16> %1
}

define <16 x i8> @combine_vec_udiv_nonuniform4(<16 x i8> %x) {
; SDAG-LABEL: combine_vec_udiv_nonuniform4:
; SDAG:       // %bb.0:
; SDAG-NEXT:    movi v1.16b, #171
; SDAG-NEXT:    adrp x8, .LCPI4_0
; SDAG-NEXT:    adrp x9, .LCPI4_1
; SDAG-NEXT:    ldr q3, [x9, :lo12:.LCPI4_1]
; SDAG-NEXT:    umull2 v2.8h, v0.16b, v1.16b
; SDAG-NEXT:    umull v1.8h, v0.8b, v1.8b
; SDAG-NEXT:    and v0.16b, v0.16b, v3.16b
; SDAG-NEXT:    uzp2 v1.16b, v1.16b, v2.16b
; SDAG-NEXT:    ldr q2, [x8, :lo12:.LCPI4_0]
; SDAG-NEXT:    ushr v1.16b, v1.16b, #7
; SDAG-NEXT:    and v1.16b, v1.16b, v2.16b
; SDAG-NEXT:    orr v0.16b, v0.16b, v1.16b
; SDAG-NEXT:    ret
;
; GISEL-LABEL: combine_vec_udiv_nonuniform4:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI4_2
; GISEL-NEXT:    adrp x9, .LCPI4_0
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI4_2]
; GISEL-NEXT:    adrp x8, .LCPI4_1
; GISEL-NEXT:    ldr q4, [x9, :lo12:.LCPI4_0]
; GISEL-NEXT:    ldr q3, [x8, :lo12:.LCPI4_1]
; GISEL-NEXT:    umull2 v2.8h, v0.16b, v1.16b
; GISEL-NEXT:    umull v1.8h, v0.8b, v1.8b
; GISEL-NEXT:    uzp2 v1.16b, v1.16b, v2.16b
; GISEL-NEXT:    neg v2.16b, v3.16b
; GISEL-NEXT:    shl v3.16b, v4.16b, #7
; GISEL-NEXT:    ushl v1.16b, v1.16b, v2.16b
; GISEL-NEXT:    sshr v2.16b, v3.16b, #7
; GISEL-NEXT:    bif v0.16b, v1.16b, v2.16b
; GISEL-NEXT:    ret
  %div = udiv <16 x i8> %x, <i8 -64, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  ret <16 x i8> %div
}

define <8 x i16> @pr38477(<8 x i16> %a0) {
; SDAG-LABEL: pr38477:
; SDAG:       // %bb.0:
; SDAG-NEXT:    adrp x8, .LCPI5_0
; SDAG-NEXT:    adrp x9, .LCPI5_4
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI5_0]
; SDAG-NEXT:    adrp x8, .LCPI5_1
; SDAG-NEXT:    ldr q3, [x8, :lo12:.LCPI5_1]
; SDAG-NEXT:    adrp x8, .LCPI5_2
; SDAG-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; SDAG-NEXT:    umull v1.4s, v0.4h, v1.4h
; SDAG-NEXT:    uzp2 v1.8h, v1.8h, v2.8h
; SDAG-NEXT:    sub v2.8h, v0.8h, v1.8h
; SDAG-NEXT:    umull2 v4.4s, v2.8h, v3.8h
; SDAG-NEXT:    umull v2.4s, v2.4h, v3.4h
; SDAG-NEXT:    ldr q3, [x9, :lo12:.LCPI5_4]
; SDAG-NEXT:    and v0.16b, v0.16b, v3.16b
; SDAG-NEXT:    uzp2 v2.8h, v2.8h, v4.8h
; SDAG-NEXT:    add v1.8h, v2.8h, v1.8h
; SDAG-NEXT:    ldr q2, [x8, :lo12:.LCPI5_2]
; SDAG-NEXT:    adrp x8, .LCPI5_3
; SDAG-NEXT:    ushl v1.8h, v1.8h, v2.8h
; SDAG-NEXT:    ldr q2, [x8, :lo12:.LCPI5_3]
; SDAG-NEXT:    and v1.16b, v1.16b, v2.16b
; SDAG-NEXT:    orr v0.16b, v0.16b, v1.16b
; SDAG-NEXT:    ret
;
; GISEL-LABEL: pr38477:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI5_3
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI5_3]
; GISEL-NEXT:    adrp x8, .LCPI5_2
; GISEL-NEXT:    ldr q3, [x8, :lo12:.LCPI5_2]
; GISEL-NEXT:    adrp x8, .LCPI5_0
; GISEL-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; GISEL-NEXT:    umull v1.4s, v0.4h, v1.4h
; GISEL-NEXT:    uzp2 v1.8h, v1.8h, v2.8h
; GISEL-NEXT:    sub v2.8h, v0.8h, v1.8h
; GISEL-NEXT:    umull2 v4.4s, v2.8h, v3.8h
; GISEL-NEXT:    umull v2.4s, v2.4h, v3.4h
; GISEL-NEXT:    ldr d3, [x8, :lo12:.LCPI5_0]
; GISEL-NEXT:    adrp x8, .LCPI5_1
; GISEL-NEXT:    ushll v3.8h, v3.8b, #0
; GISEL-NEXT:    uzp2 v2.8h, v2.8h, v4.8h
; GISEL-NEXT:    ldr q4, [x8, :lo12:.LCPI5_1]
; GISEL-NEXT:    shl v3.8h, v3.8h, #15
; GISEL-NEXT:    add v1.8h, v2.8h, v1.8h
; GISEL-NEXT:    neg v2.8h, v4.8h
; GISEL-NEXT:    ushl v1.8h, v1.8h, v2.8h
; GISEL-NEXT:    sshr v2.8h, v3.8h, #15
; GISEL-NEXT:    bif v0.16b, v1.16b, v2.16b
; GISEL-NEXT:    ret
  %1 = udiv <8 x i16> %a0, <i16 1, i16 119, i16 73, i16 -111, i16 -3, i16 118, i16 32, i16 31>
  ret <8 x i16> %1
}

define i32 @udiv_div_by_180(i32 %x)
; SDAG-LABEL: udiv_div_by_180:
; SDAG:       // %bb.0:
; SDAG-NEXT:    mov w8, #5826 // =0x16c2
; SDAG-NEXT:    and w9, w0, #0xff
; SDAG-NEXT:    movk w8, #364, lsl #16
; SDAG-NEXT:    umull x8, w9, w8
; SDAG-NEXT:    lsr x0, x8, #32
; SDAG-NEXT:    // kill: def $w0 killed $w0 killed $x0
; SDAG-NEXT:    ret
;
; GISEL-LABEL: udiv_div_by_180:
; GISEL:       // %bb.0:
; GISEL-NEXT:    mov w8, #5826 // =0x16c2
; GISEL-NEXT:    and w9, w0, #0xff
; GISEL-NEXT:    movk w8, #364, lsl #16
; GISEL-NEXT:    umull x8, w9, w8
; GISEL-NEXT:    lsr x0, x8, #32
; GISEL-NEXT:    // kill: def $w0 killed $w0 killed $x0
; GISEL-NEXT:    ret
{
  %truncate = and i32 %x, 255
  %udiv = udiv i32 %truncate, 180
  ret i32 %udiv
}

define i32 @udiv_div_by_180_exact(i32 %x)
; SDAG-LABEL: udiv_div_by_180_exact:
; SDAG:       // %bb.0:
; SDAG-NEXT:    lsr w8, w0, #2
; SDAG-NEXT:    mov w9, #20389 // =0x4fa5
; SDAG-NEXT:    movk w9, #42234, lsl #16
; SDAG-NEXT:    mul w0, w8, w9
; SDAG-NEXT:    ret
;
; GISEL-LABEL: udiv_div_by_180_exact:
; GISEL:       // %bb.0:
; GISEL-NEXT:    lsr w8, w0, #2
; GISEL-NEXT:    mov w9, #20389 // =0x4fa5
; GISEL-NEXT:    movk w9, #42234, lsl #16
; GISEL-NEXT:    mul w0, w8, w9
; GISEL-NEXT:    ret
{
  %udiv = udiv exact i32 %x, 180
  ret i32 %udiv
}

define <4 x i32> @udiv_div_by_104_exact(<4 x i32> %x)
; SDAG-LABEL: udiv_div_by_104_exact:
; SDAG:       // %bb.0:
; SDAG-NEXT:    adrp x8, .LCPI8_0
; SDAG-NEXT:    ushr v0.4s, v0.4s, #3
; SDAG-NEXT:    ldr q1, [x8, :lo12:.LCPI8_0]
; SDAG-NEXT:    mul v0.4s, v0.4s, v1.4s
; SDAG-NEXT:    ret
;
; GISEL-LABEL: udiv_div_by_104_exact:
; GISEL:       // %bb.0:
; GISEL-NEXT:    adrp x8, .LCPI8_0
; GISEL-NEXT:    ushr v0.4s, v0.4s, #3
; GISEL-NEXT:    ldr q1, [x8, :lo12:.LCPI8_0]
; GISEL-NEXT:    mul v0.4s, v0.4s, v1.4s
; GISEL-NEXT:    ret
{
  %udiv = udiv exact <4 x i32> %x, <i32 104, i32 72, i32 104, i32 72>
  ret <4 x i32> %udiv
}

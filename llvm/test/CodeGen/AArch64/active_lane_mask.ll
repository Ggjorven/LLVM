; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; == Scalable ==

define <vscale x 16 x i1> @lane_mask_nxv16i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_nxv16i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, w0, w1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i32(i32 %index, i32 %TC)
  ret <vscale x 16 x i1> %active.lane.mask
}

define <vscale x 8 x i1> @lane_mask_nxv8i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_nxv8i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.h, w0, w1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i32(i32 %index, i32 %TC)
  ret <vscale x 8 x i1> %active.lane.mask
}

define <vscale x 4 x i1> @lane_mask_nxv4i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_nxv4i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, w0, w1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32 %index, i32 %TC)
  ret <vscale x 4 x i1> %active.lane.mask
}

define <vscale x 2 x i1> @lane_mask_nxv2i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_nxv2i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.d, w0, w1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i32(i32 %index, i32 %TC)
  ret <vscale x 2 x i1> %active.lane.mask
}

define <vscale x 16 x i1> @lane_mask_nxv16i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_nxv16i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, x0, x1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %index, i64 %TC)
  ret <vscale x 16 x i1> %active.lane.mask
}

define <vscale x 8 x i1> @lane_mask_nxv8i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_nxv8i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.h, x0, x1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i64(i64 %index, i64 %TC)
  ret <vscale x 8 x i1> %active.lane.mask
}

define <vscale x 4 x i1> @lane_mask_nxv4i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_nxv4i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, x0, x1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 %index, i64 %TC)
  ret <vscale x 4 x i1> %active.lane.mask
}

define <vscale x 2 x i1> @lane_mask_nxv2i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_nxv2i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.d, x0, x1
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 %index, i64 %TC)
  ret <vscale x 2 x i1> %active.lane.mask
}

define <vscale x 16 x i1> @lane_mask_nxv16i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_nxv16i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, #0, #1
; CHECK-NEXT:    mov z1.b, w0
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    uqadd z0.b, z0.b, z1.b
; CHECK-NEXT:    mov z1.b, w1
; CHECK-NEXT:    cmphi p0.b, p0/z, z1.b, z0.b
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i8(i8 %index, i8 %TC)
  ret <vscale x 16 x i1> %active.lane.mask
}

define <vscale x 8 x i1> @lane_mask_nxv8i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_nxv8i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, #0, #1
; CHECK-NEXT:    mov z1.h, w0
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    and z1.h, z1.h, #0xff
; CHECK-NEXT:    and z0.h, z0.h, #0xff
; CHECK-NEXT:    add z0.h, z0.h, z1.h
; CHECK-NEXT:    mov z1.h, w1
; CHECK-NEXT:    umin z0.h, z0.h, #255
; CHECK-NEXT:    and z1.h, z1.h, #0xff
; CHECK-NEXT:    cmphi p0.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i8(i8 %index, i8 %TC)
  ret <vscale x 8 x i1> %active.lane.mask
}

define <vscale x 4 x i1> @lane_mask_nxv4i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_nxv4i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    and w8, w1, #0xff
; CHECK-NEXT:    and z0.s, z0.s, #0xff
; CHECK-NEXT:    add z0.s, z0.s, z1.s
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    umin z0.s, z0.s, #255
; CHECK-NEXT:    cmphi p0.s, p0/z, z1.s, z0.s
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i8(i8 %index, i8 %TC)
  ret <vscale x 4 x i1> %active.lane.mask
}

define <vscale x 2 x i1> @lane_mask_nxv2i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_nxv2i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.d, #0, #1
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    and x8, x0, #0xff
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    and x8, x1, #0xff
; CHECK-NEXT:    and z0.d, z0.d, #0xff
; CHECK-NEXT:    add z0.d, z0.d, z1.d
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    umin z0.d, z0.d, #255
; CHECK-NEXT:    cmphi p0.d, p0/z, z1.d, z0.d
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i8(i8 %index, i8 %TC)
  ret <vscale x 2 x i1> %active.lane.mask
}


; Illegal types

define <vscale x 32 x i1> @lane_mask_nxv32i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_nxv32i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p7, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 8 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    mov z1.s, w0
; CHECK-NEXT:    mov z25.s, w1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    uqadd z6.s, z0.s, z1.s
; CHECK-NEXT:    incw z0.s, all, mul #4
; CHECK-NEXT:    incw z2.s
; CHECK-NEXT:    incw z3.s, all, mul #2
; CHECK-NEXT:    uqadd z0.s, z0.s, z1.s
; CHECK-NEXT:    cmphi p2.s, p0/z, z25.s, z6.s
; CHECK-NEXT:    mov z4.d, z2.d
; CHECK-NEXT:    uqadd z5.s, z2.s, z1.s
; CHECK-NEXT:    uqadd z7.s, z3.s, z1.s
; CHECK-NEXT:    incw z2.s, all, mul #4
; CHECK-NEXT:    incw z3.s, all, mul #4
; CHECK-NEXT:    cmphi p5.s, p0/z, z25.s, z0.s
; CHECK-NEXT:    incw z4.s, all, mul #2
; CHECK-NEXT:    uqadd z2.s, z2.s, z1.s
; CHECK-NEXT:    uqadd z3.s, z3.s, z1.s
; CHECK-NEXT:    cmphi p1.s, p0/z, z25.s, z5.s
; CHECK-NEXT:    cmphi p3.s, p0/z, z25.s, z7.s
; CHECK-NEXT:    uqadd z24.s, z4.s, z1.s
; CHECK-NEXT:    incw z4.s, all, mul #4
; CHECK-NEXT:    cmphi p6.s, p0/z, z25.s, z2.s
; CHECK-NEXT:    cmphi p7.s, p0/z, z25.s, z3.s
; CHECK-NEXT:    uzp1 p1.h, p2.h, p1.h
; CHECK-NEXT:    uqadd z1.s, z4.s, z1.s
; CHECK-NEXT:    cmphi p4.s, p0/z, z25.s, z24.s
; CHECK-NEXT:    cmphi p0.s, p0/z, z25.s, z1.s
; CHECK-NEXT:    uzp1 p2.h, p3.h, p4.h
; CHECK-NEXT:    uzp1 p3.h, p5.h, p6.h
; CHECK-NEXT:    ldr p6, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p4.h, p7.h, p0.h
; CHECK-NEXT:    ldr p7, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p0.b, p1.b, p2.b
; CHECK-NEXT:    uzp1 p1.b, p3.b, p4.b
; CHECK-NEXT:    ldr p4, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i32(i32 %index, i32 %TC)
  ret <vscale x 32 x i1> %active.lane.mask
}

define <vscale x 32 x i1> @lane_mask_nxv32i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_nxv32i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    str p9, [sp, #2, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #3, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #1, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; CHECK-NEXT:    index z5.d, #0, #1
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    mov z3.d, x1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z2.d, z5.d
; CHECK-NEXT:    mov z1.d, z5.d
; CHECK-NEXT:    mov z4.d, z5.d
; CHECK-NEXT:    uqadd z25.d, z5.d, z0.d
; CHECK-NEXT:    incd z5.d, all, mul #8
; CHECK-NEXT:    incd z2.d
; CHECK-NEXT:    incd z1.d, all, mul #2
; CHECK-NEXT:    incd z4.d, all, mul #4
; CHECK-NEXT:    uqadd z5.d, z5.d, z0.d
; CHECK-NEXT:    cmphi p3.d, p0/z, z3.d, z25.d
; CHECK-NEXT:    mov z6.d, z2.d
; CHECK-NEXT:    mov z7.d, z2.d
; CHECK-NEXT:    mov z24.d, z1.d
; CHECK-NEXT:    uqadd z26.d, z2.d, z0.d
; CHECK-NEXT:    uqadd z27.d, z1.d, z0.d
; CHECK-NEXT:    uqadd z28.d, z4.d, z0.d
; CHECK-NEXT:    incd z2.d, all, mul #8
; CHECK-NEXT:    incd z1.d, all, mul #8
; CHECK-NEXT:    incd z4.d, all, mul #8
; CHECK-NEXT:    incd z6.d, all, mul #2
; CHECK-NEXT:    incd z7.d, all, mul #4
; CHECK-NEXT:    incd z24.d, all, mul #4
; CHECK-NEXT:    cmphi p4.d, p0/z, z3.d, z26.d
; CHECK-NEXT:    cmphi p2.d, p0/z, z3.d, z27.d
; CHECK-NEXT:    cmphi p1.d, p0/z, z3.d, z28.d
; CHECK-NEXT:    mov z31.d, z6.d
; CHECK-NEXT:    uqadd z29.d, z6.d, z0.d
; CHECK-NEXT:    uqadd z30.d, z7.d, z0.d
; CHECK-NEXT:    uqadd z8.d, z24.d, z0.d
; CHECK-NEXT:    incd z6.d, all, mul #8
; CHECK-NEXT:    incd z7.d, all, mul #8
; CHECK-NEXT:    incd z24.d, all, mul #8
; CHECK-NEXT:    uqadd z2.d, z2.d, z0.d
; CHECK-NEXT:    uqadd z1.d, z1.d, z0.d
; CHECK-NEXT:    incd z31.d, all, mul #4
; CHECK-NEXT:    uqadd z4.d, z4.d, z0.d
; CHECK-NEXT:    uzp1 p3.s, p3.s, p4.s
; CHECK-NEXT:    cmphi p5.d, p0/z, z3.d, z29.d
; CHECK-NEXT:    cmphi p7.d, p0/z, z3.d, z30.d
; CHECK-NEXT:    uqadd z6.d, z6.d, z0.d
; CHECK-NEXT:    cmphi p6.d, p0/z, z3.d, z8.d
; CHECK-NEXT:    ldr z8, [sp, #1, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    uqadd z7.d, z7.d, z0.d
; CHECK-NEXT:    uqadd z25.d, z31.d, z0.d
; CHECK-NEXT:    incd z31.d, all, mul #8
; CHECK-NEXT:    uqadd z24.d, z24.d, z0.d
; CHECK-NEXT:    cmphi p4.d, p0/z, z3.d, z5.d
; CHECK-NEXT:    uzp1 p2.s, p2.s, p5.s
; CHECK-NEXT:    cmphi p5.d, p0/z, z3.d, z2.d
; CHECK-NEXT:    cmphi p9.d, p0/z, z3.d, z6.d
; CHECK-NEXT:    uqadd z0.d, z31.d, z0.d
; CHECK-NEXT:    uzp1 p1.s, p1.s, p7.s
; CHECK-NEXT:    cmphi p7.d, p0/z, z3.d, z1.d
; CHECK-NEXT:    cmphi p8.d, p0/z, z3.d, z25.d
; CHECK-NEXT:    uzp1 p2.h, p3.h, p2.h
; CHECK-NEXT:    cmphi p3.d, p0/z, z3.d, z7.d
; CHECK-NEXT:    uzp1 p4.s, p4.s, p5.s
; CHECK-NEXT:    uzp1 p5.s, p7.s, p9.s
; CHECK-NEXT:    ldr p9, [sp, #2, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p6.s, p6.s, p8.s
; CHECK-NEXT:    cmphi p8.d, p0/z, z3.d, z4.d
; CHECK-NEXT:    ldr p7, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p4.h, p4.h, p5.h
; CHECK-NEXT:    ldr p5, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p1.h, p1.h, p6.h
; CHECK-NEXT:    cmphi p6.d, p0/z, z3.d, z24.d
; CHECK-NEXT:    cmphi p0.d, p0/z, z3.d, z0.d
; CHECK-NEXT:    uzp1 p3.s, p8.s, p3.s
; CHECK-NEXT:    ldr p8, [sp, #3, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p0.s, p6.s, p0.s
; CHECK-NEXT:    ldr p6, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    uzp1 p3.h, p3.h, p0.h
; CHECK-NEXT:    uzp1 p0.b, p2.b, p1.b
; CHECK-NEXT:    uzp1 p1.b, p4.b, p3.b
; CHECK-NEXT:    ldr p4, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i64(i64 %index, i64 %TC)
  ret <vscale x 32 x i1> %active.lane.mask
}

define <vscale x 32 x i1> @lane_mask_nxv32i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_nxv32i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, #0, #1
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov z2.b, w0
; CHECK-NEXT:    mov z1.b, w8
; CHECK-NEXT:    ptrue p1.b
; CHECK-NEXT:    add z1.b, z0.b, z1.b
; CHECK-NEXT:    uqadd z0.b, z0.b, z2.b
; CHECK-NEXT:    uqadd z1.b, z1.b, z2.b
; CHECK-NEXT:    mov z2.b, w1
; CHECK-NEXT:    cmphi p0.b, p1/z, z2.b, z0.b
; CHECK-NEXT:    cmphi p1.b, p1/z, z2.b, z1.b
; CHECK-NEXT:    ret
  %active.lane.mask = call <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i8(i8 %index, i8 %TC)
  ret <vscale x 32 x i1> %active.lane.mask
}

; UTC_ARGS: --disable
; This test exists to protect against a compiler crash caused by an attempt to
; convert (via changeVectorElementType) an MVT into an EVT, which is impossible.
; The test's output is large and not relevant so check lines have been disabled.
define <vscale x 64 x i1> @lane_mask_nxv64i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_nxv64i1_i64:
  %active.lane.mask = call <vscale x 64 x i1> @llvm.get.active.lane.mask.nxv64i1.i64(i64 %index, i64 %TC)
  ret <vscale x 64 x i1> %active.lane.mask
}
; UTC_ARGS: --enable

; == Fixed width ==

define <16 x i1> @lane_mask_v16i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_v16i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, w0, w1
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 %index, i32 %TC)
  ret <16 x i1> %active.lane.mask
}

define <8 x i1> @lane_mask_v8i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_v8i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, w0, w1
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 %index, i32 %TC)
  ret <8 x i1> %active.lane.mask
}

define <4 x i1> @lane_mask_v4i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_v4i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.h, w0, w1
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index, i32 %TC)
  ret <4 x i1> %active.lane.mask
}

define <2 x i1> @lane_mask_v2i1_i32(i32 %index, i32 %TC) {
; CHECK-LABEL: lane_mask_v2i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, w0, w1
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 %index, i32 %TC)
  ret <2 x i1> %active.lane.mask
}

define <16 x i1> @lane_mask_v16i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_v16i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, x0, x1
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64 %index, i64 %TC)
  ret <16 x i1> %active.lane.mask
}

define <8 x i1> @lane_mask_v8i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_v8i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, x0, x1
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64 %index, i64 %TC)
  ret <8 x i1> %active.lane.mask
}

define <4 x i1> @lane_mask_v4i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_v4i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.h, x0, x1
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64 %index, i64 %TC)
  ret <4 x i1> %active.lane.mask
}

define <2 x i1> @lane_mask_v2i1_i64(i64 %index, i64 %TC) {
; CHECK-LABEL: lane_mask_v2i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, x0, x1
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %active.lane.mask = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64 %index, i64 %TC)
  ret <2 x i1> %active.lane.mask
}

define <16 x i1> @lane_mask_v16i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_v16i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI24_0
; CHECK-NEXT:    dup v0.16b, w0
; CHECK-NEXT:    ldr q1, [x8, :lo12:.LCPI24_0]
; CHECK-NEXT:    uqadd v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    dup v1.16b, w1
; CHECK-NEXT:    cmhi v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %active.lane.mask = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i8(i8 %index, i8 %TC)
  ret <16 x i1> %active.lane.mask
}

define <8 x i1> @lane_mask_v8i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_v8i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8b, w0
; CHECK-NEXT:    adrp x8, .LCPI25_0
; CHECK-NEXT:    ldr d1, [x8, :lo12:.LCPI25_0]
; CHECK-NEXT:    uqadd v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    dup v1.8b, w1
; CHECK-NEXT:    cmhi v0.8b, v1.8b, v0.8b
; CHECK-NEXT:    ret
  %active.lane.mask = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i8(i8 %index, i8 %TC)
  ret <8 x i1> %active.lane.mask
}

define <4 x i1> @lane_mask_v4i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_v4i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.4h, w0
; CHECK-NEXT:    adrp x8, .LCPI26_0
; CHECK-NEXT:    movi d2, #0xff00ff00ff00ff
; CHECK-NEXT:    ldr d1, [x8, :lo12:.LCPI26_0]
; CHECK-NEXT:    dup v3.4h, w1
; CHECK-NEXT:    bic v0.4h, #255, lsl #8
; CHECK-NEXT:    bic v3.4h, #255, lsl #8
; CHECK-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    umin v0.4h, v0.4h, v2.4h
; CHECK-NEXT:    cmhi v0.4h, v3.4h, v0.4h
; CHECK-NEXT:    ret
  %active.lane.mask = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i8(i8 %index, i8 %TC)
  ret <4 x i1> %active.lane.mask
}

define <2 x i1> @lane_mask_v2i1_i8(i8 %index, i8 %TC) {
; CHECK-LABEL: lane_mask_v2i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0x0000ff000000ff
; CHECK-NEXT:    dup v1.2s, w0
; CHECK-NEXT:    adrp x8, .LCPI27_0
; CHECK-NEXT:    ldr d2, [x8, :lo12:.LCPI27_0]
; CHECK-NEXT:    dup v3.2s, w1
; CHECK-NEXT:    and v1.8b, v1.8b, v0.8b
; CHECK-NEXT:    add v1.2s, v1.2s, v2.2s
; CHECK-NEXT:    and v2.8b, v3.8b, v0.8b
; CHECK-NEXT:    umin v0.2s, v1.2s, v0.2s
; CHECK-NEXT:    cmhi v0.2s, v2.2s, v0.2s
; CHECK-NEXT:    ret
  %active.lane.mask = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i8(i8 %index, i8 %TC)
  ret <2 x i1> %active.lane.mask
}

define <vscale x 4 x i1> @lane_mask_nxv4i1_imm3() {
; CHECK-LABEL: lane_mask_nxv4i1_imm3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.s, vl3
; CHECK-NEXT:    ret
entry:
  %active.lane.mask = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 0, i64 3)
  ret <vscale x 4 x i1> %active.lane.mask
}

define <vscale x 4 x i1> @lane_mask_nxv4i1_imm5() {
; CHECK-LABEL: lane_mask_nxv4i1_imm5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #5 // =0x5
; CHECK-NEXT:    whilelo p0.s, xzr, x8
; CHECK-NEXT:    ret
entry:
  %active.lane.mask = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 0, i64 5)
  ret <vscale x 4 x i1> %active.lane.mask
}

define <vscale x 4 x i1> @lane_mask_nxv4i1_imm4() {
; CHECK-LABEL: lane_mask_nxv4i1_imm4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ret
entry:
  %active.lane.mask = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 10, i64 14)
  ret <vscale x 4 x i1> %active.lane.mask
}

define <vscale x 16 x i1> @lane_mask_nxv16i1_imm10() {
; CHECK-LABEL: lane_mask_nxv16i1_imm10:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #10 // =0xa
; CHECK-NEXT:    whilelo p0.b, xzr, x8
; CHECK-NEXT:    ret
entry:
  %active.lane.mask = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 0, i64 10)
  ret <vscale x 16 x i1> %active.lane.mask
}

define <vscale x 16 x i1> @lane_mask_nxv16i1_imm256() vscale_range(16, 16) {
; CHECK-LABEL: lane_mask_nxv16i1_imm256:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.b, vl256
; CHECK-NEXT:    ret
entry:
  %active.lane.mask = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 0, i64 256)
  ret <vscale x 16 x i1> %active.lane.mask
}


declare <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i32(i32, i32)
declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i32(i32, i32)
declare <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i32(i32, i32)
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32, i32)
declare <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i32(i32, i32)

declare <vscale x 64 x i1> @llvm.get.active.lane.mask.nxv64i1.i64(i64, i64)
declare <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i64(i64, i64)
declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64, i64)
declare <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64, i64)
declare <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64, i64)

declare <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i8(i8, i8)
declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i8(i8, i8)
declare <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i8(i8, i8)
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i8(i8, i8)
declare <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i8(i8, i8)


declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32, i32)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32, i32)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32, i32)

declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64, i64)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64, i64)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64, i64)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64, i64)

declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i8(i8, i8)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i8(i8, i8)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i8(i8, i8)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i8(i8, i8)

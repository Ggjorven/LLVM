; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define i8 @scmp.8.8(i8 %x, i8 %y) nounwind {
; CHECK-SD-LABEL: scmp.8.8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    sxtb w8, w0
; CHECK-SD-NEXT:    cmp w8, w1, sxtb
; CHECK-SD-NEXT:    cset w8, gt
; CHECK-SD-NEXT:    csinv w0, w8, wzr, ge
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: scmp.8.8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    sxtb w8, w0
; CHECK-GI-NEXT:    sxtb w9, w1
; CHECK-GI-NEXT:    cmp w8, w9
; CHECK-GI-NEXT:    cset w8, gt
; CHECK-GI-NEXT:    csinv w0, w8, wzr, ge
; CHECK-GI-NEXT:    ret
  %1 = call i8 @llvm.scmp(i8 %x, i8 %y)
  ret i8 %1
}

define i8 @scmp.8.16(i16 %x, i16 %y) nounwind {
; CHECK-SD-LABEL: scmp.8.16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    sxth w8, w0
; CHECK-SD-NEXT:    cmp w8, w1, sxth
; CHECK-SD-NEXT:    cset w8, gt
; CHECK-SD-NEXT:    csinv w0, w8, wzr, ge
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: scmp.8.16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    sxth w8, w0
; CHECK-GI-NEXT:    sxth w9, w1
; CHECK-GI-NEXT:    cmp w8, w9
; CHECK-GI-NEXT:    cset w8, gt
; CHECK-GI-NEXT:    csinv w0, w8, wzr, ge
; CHECK-GI-NEXT:    ret
  %1 = call i8 @llvm.scmp(i16 %x, i16 %y)
  ret i8 %1
}

define i8 @scmp.8.32(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: scmp.8.32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, w1
; CHECK-NEXT:    cset w8, gt
; CHECK-NEXT:    csinv w0, w8, wzr, ge
; CHECK-NEXT:    ret
  %1 = call i8 @llvm.scmp(i32 %x, i32 %y)
  ret i8 %1
}

define i8 @scmp.8.64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scmp.8.64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp x0, x1
; CHECK-NEXT:    cset w8, gt
; CHECK-NEXT:    csinv w0, w8, wzr, ge
; CHECK-NEXT:    ret
  %1 = call i8 @llvm.scmp(i64 %x, i64 %y)
  ret i8 %1
}

define i8 @scmp.8.128(i128 %x, i128 %y) nounwind {
; CHECK-SD-LABEL: scmp.8.128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    cmp x2, x0
; CHECK-SD-NEXT:    sbcs xzr, x3, x1
; CHECK-SD-NEXT:    cset w8, lt
; CHECK-SD-NEXT:    cmp x0, x2
; CHECK-SD-NEXT:    sbcs xzr, x1, x3
; CHECK-SD-NEXT:    csinv w0, w8, wzr, ge
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: scmp.8.128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    cmp x1, x3
; CHECK-GI-NEXT:    cset w8, gt
; CHECK-GI-NEXT:    cmp x0, x2
; CHECK-GI-NEXT:    cset w9, hi
; CHECK-GI-NEXT:    cmp x1, x3
; CHECK-GI-NEXT:    csel w8, w9, w8, eq
; CHECK-GI-NEXT:    tst w8, #0x1
; CHECK-GI-NEXT:    cset w8, ne
; CHECK-GI-NEXT:    cmp x1, x3
; CHECK-GI-NEXT:    cset w9, lt
; CHECK-GI-NEXT:    cmp x0, x2
; CHECK-GI-NEXT:    cset w10, lo
; CHECK-GI-NEXT:    cmp x1, x3
; CHECK-GI-NEXT:    csel w9, w10, w9, eq
; CHECK-GI-NEXT:    tst w9, #0x1
; CHECK-GI-NEXT:    csinv w0, w8, wzr, eq
; CHECK-GI-NEXT:    ret
  %1 = call i8 @llvm.scmp(i128 %x, i128 %y)
  ret i8 %1
}

define i32 @scmp.32.32(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: scmp.32.32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, w1
; CHECK-NEXT:    cset w8, gt
; CHECK-NEXT:    csinv w0, w8, wzr, ge
; CHECK-NEXT:    ret
  %1 = call i32 @llvm.scmp(i32 %x, i32 %y)
  ret i32 %1
}

define i32 @scmp.32.64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scmp.32.64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp x0, x1
; CHECK-NEXT:    cset w8, gt
; CHECK-NEXT:    csinv w0, w8, wzr, ge
; CHECK-NEXT:    ret
  %1 = call i32 @llvm.scmp(i64 %x, i64 %y)
  ret i32 %1
}

define i64 @scmp.64.64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scmp.64.64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp x0, x1
; CHECK-NEXT:    cset x8, gt
; CHECK-NEXT:    csinv x0, x8, xzr, ge
; CHECK-NEXT:    ret
  %1 = call i64 @llvm.scmp(i64 %x, i64 %y)
  ret i64 %1
}

define <8 x i8> @s_v8i8(<8 x i8> %a, <8 x i8> %b) {
; CHECK-SD-LABEL: s_v8i8:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.8b, v0.8b, v1.8b
; CHECK-SD-NEXT:    cmgt v0.8b, v1.8b, v0.8b
; CHECK-SD-NEXT:    sub v0.8b, v0.8b, v2.8b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v8i8:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.8b, #1
; CHECK-GI-NEXT:    cmgt v3.8b, v0.8b, v1.8b
; CHECK-GI-NEXT:    movi d4, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.8b, v1.8b, v0.8b
; CHECK-GI-NEXT:    and v2.8b, v2.8b, v3.8b
; CHECK-GI-NEXT:    bsl v0.8b, v4.8b, v2.8b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <8 x i8> @llvm.scmp(<8 x i8> %a, <8 x i8> %b)
  ret <8 x i8> %c
}

define <16 x i8> @s_v16i8(<16 x i8> %a, <16 x i8> %b) {
; CHECK-SD-LABEL: s_v16i8:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.16b, v0.16b, v1.16b
; CHECK-SD-NEXT:    cmgt v0.16b, v1.16b, v0.16b
; CHECK-SD-NEXT:    sub v0.16b, v0.16b, v2.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v16i8:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.16b, #1
; CHECK-GI-NEXT:    cmgt v3.16b, v0.16b, v1.16b
; CHECK-GI-NEXT:    movi v4.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.16b, v1.16b, v0.16b
; CHECK-GI-NEXT:    and v2.16b, v2.16b, v3.16b
; CHECK-GI-NEXT:    bsl v0.16b, v4.16b, v2.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <16 x i8> @llvm.scmp(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %c
}

define <4 x i16> @s_v4i16(<4 x i16> %a, <4 x i16> %b) {
; CHECK-SD-LABEL: s_v4i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    cmgt v0.4h, v1.4h, v0.4h
; CHECK-SD-NEXT:    sub v0.4h, v0.4h, v2.4h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v4i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.4h, #1
; CHECK-GI-NEXT:    cmgt v3.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    movi d4, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.4h, v1.4h, v0.4h
; CHECK-GI-NEXT:    and v2.8b, v2.8b, v3.8b
; CHECK-GI-NEXT:    bsl v0.8b, v4.8b, v2.8b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <4 x i16> @llvm.scmp(<4 x i16> %a, <4 x i16> %b)
  ret <4 x i16> %c
}

define <8 x i16> @s_v8i16(<8 x i16> %a, <8 x i16> %b) {
; CHECK-SD-LABEL: s_v8i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.8h, v0.8h, v1.8h
; CHECK-SD-NEXT:    cmgt v0.8h, v1.8h, v0.8h
; CHECK-SD-NEXT:    sub v0.8h, v0.8h, v2.8h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v8i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.8h, #1
; CHECK-GI-NEXT:    cmgt v3.8h, v0.8h, v1.8h
; CHECK-GI-NEXT:    movi v4.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.8h, v1.8h, v0.8h
; CHECK-GI-NEXT:    and v2.16b, v2.16b, v3.16b
; CHECK-GI-NEXT:    bsl v0.16b, v4.16b, v2.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <8 x i16> @llvm.scmp(<8 x i16> %a, <8 x i16> %b)
  ret <8 x i16> %c
}

define <16 x i16> @s_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-SD-LABEL: s_v16i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v4.8h, v1.8h, v3.8h
; CHECK-SD-NEXT:    cmgt v5.8h, v0.8h, v2.8h
; CHECK-SD-NEXT:    cmgt v0.8h, v2.8h, v0.8h
; CHECK-SD-NEXT:    cmgt v1.8h, v3.8h, v1.8h
; CHECK-SD-NEXT:    sub v0.8h, v0.8h, v5.8h
; CHECK-SD-NEXT:    sub v1.8h, v1.8h, v4.8h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v16i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v4.8h, #1
; CHECK-GI-NEXT:    cmgt v5.8h, v0.8h, v2.8h
; CHECK-GI-NEXT:    cmgt v6.8h, v1.8h, v3.8h
; CHECK-GI-NEXT:    movi v7.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.8h, v2.8h, v0.8h
; CHECK-GI-NEXT:    cmgt v1.8h, v3.8h, v1.8h
; CHECK-GI-NEXT:    and v5.16b, v4.16b, v5.16b
; CHECK-GI-NEXT:    and v4.16b, v4.16b, v6.16b
; CHECK-GI-NEXT:    bsl v0.16b, v7.16b, v5.16b
; CHECK-GI-NEXT:    bsl v1.16b, v7.16b, v4.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <16 x i16> @llvm.scmp(<16 x i16> %a, <16 x i16> %b)
  ret <16 x i16> %c
}

define <2 x i32> @s_v2i32(<2 x i32> %a, <2 x i32> %b) {
; CHECK-SD-LABEL: s_v2i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    cmgt v0.2s, v1.2s, v0.2s
; CHECK-SD-NEXT:    sub v0.2s, v0.2s, v2.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v2i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.2s, #1
; CHECK-GI-NEXT:    cmgt v3.2s, v0.2s, v1.2s
; CHECK-GI-NEXT:    movi d4, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.2s, v1.2s, v0.2s
; CHECK-GI-NEXT:    and v2.8b, v2.8b, v3.8b
; CHECK-GI-NEXT:    bsl v0.8b, v4.8b, v2.8b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <2 x i32> @llvm.scmp(<2 x i32> %a, <2 x i32> %b)
  ret <2 x i32> %c
}

define <4 x i32> @s_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-SD-LABEL: s_v4i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.4s, v0.4s, v1.4s
; CHECK-SD-NEXT:    cmgt v0.4s, v1.4s, v0.4s
; CHECK-SD-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v4i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.4s, #1
; CHECK-GI-NEXT:    cmgt v3.4s, v0.4s, v1.4s
; CHECK-GI-NEXT:    movi v4.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.4s, v1.4s, v0.4s
; CHECK-GI-NEXT:    and v2.16b, v2.16b, v3.16b
; CHECK-GI-NEXT:    bsl v0.16b, v4.16b, v2.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <4 x i32> @llvm.scmp(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %c
}

define <8 x i32> @s_v8i32(<8 x i32> %a, <8 x i32> %b) {
; CHECK-SD-LABEL: s_v8i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v4.4s, v1.4s, v3.4s
; CHECK-SD-NEXT:    cmgt v5.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    cmgt v0.4s, v2.4s, v0.4s
; CHECK-SD-NEXT:    cmgt v1.4s, v3.4s, v1.4s
; CHECK-SD-NEXT:    sub v0.4s, v0.4s, v5.4s
; CHECK-SD-NEXT:    sub v1.4s, v1.4s, v4.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v8i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v4.4s, #1
; CHECK-GI-NEXT:    cmgt v5.4s, v0.4s, v2.4s
; CHECK-GI-NEXT:    cmgt v6.4s, v1.4s, v3.4s
; CHECK-GI-NEXT:    movi v7.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.4s, v2.4s, v0.4s
; CHECK-GI-NEXT:    cmgt v1.4s, v3.4s, v1.4s
; CHECK-GI-NEXT:    and v5.16b, v4.16b, v5.16b
; CHECK-GI-NEXT:    and v4.16b, v4.16b, v6.16b
; CHECK-GI-NEXT:    bsl v0.16b, v7.16b, v5.16b
; CHECK-GI-NEXT:    bsl v1.16b, v7.16b, v4.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <8 x i32> @llvm.scmp(<8 x i32> %a, <8 x i32> %b)
  ret <8 x i32> %c
}

define <2 x i64> @s_v2i64(<2 x i64> %a, <2 x i64> %b) {
; CHECK-SD-LABEL: s_v2i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v2.2d, v0.2d, v1.2d
; CHECK-SD-NEXT:    cmgt v0.2d, v1.2d, v0.2d
; CHECK-SD-NEXT:    sub v0.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v2i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    adrp x8, .LCPI16_0
; CHECK-GI-NEXT:    cmgt v2.2d, v0.2d, v1.2d
; CHECK-GI-NEXT:    movi v4.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    ldr q3, [x8, :lo12:.LCPI16_0]
; CHECK-GI-NEXT:    cmgt v0.2d, v1.2d, v0.2d
; CHECK-GI-NEXT:    and v2.16b, v3.16b, v2.16b
; CHECK-GI-NEXT:    bsl v0.16b, v4.16b, v2.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <2 x i64> @llvm.scmp(<2 x i64> %a, <2 x i64> %b)
  ret <2 x i64> %c
}

define <4 x i64> @s_v4i64(<4 x i64> %a, <4 x i64> %b) {
; CHECK-SD-LABEL: s_v4i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v4.2d, v1.2d, v3.2d
; CHECK-SD-NEXT:    cmgt v5.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    cmgt v0.2d, v2.2d, v0.2d
; CHECK-SD-NEXT:    cmgt v1.2d, v3.2d, v1.2d
; CHECK-SD-NEXT:    sub v0.2d, v0.2d, v5.2d
; CHECK-SD-NEXT:    sub v1.2d, v1.2d, v4.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: s_v4i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    adrp x8, .LCPI17_0
; CHECK-GI-NEXT:    cmgt v4.2d, v0.2d, v2.2d
; CHECK-GI-NEXT:    cmgt v6.2d, v1.2d, v3.2d
; CHECK-GI-NEXT:    ldr q5, [x8, :lo12:.LCPI17_0]
; CHECK-GI-NEXT:    movi v7.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    cmgt v0.2d, v2.2d, v0.2d
; CHECK-GI-NEXT:    cmgt v1.2d, v3.2d, v1.2d
; CHECK-GI-NEXT:    and v4.16b, v5.16b, v4.16b
; CHECK-GI-NEXT:    and v5.16b, v5.16b, v6.16b
; CHECK-GI-NEXT:    bsl v0.16b, v7.16b, v4.16b
; CHECK-GI-NEXT:    bsl v1.16b, v7.16b, v5.16b
; CHECK-GI-NEXT:    ret
entry:
  %c = call <4 x i64> @llvm.scmp(<4 x i64> %a, <4 x i64> %b)
  ret <4 x i64> %c
}

define <16 x i8> @signOf_neon_scmp(<8 x i16> %s0_lo, <8 x i16> %s0_hi, <8 x i16> %s1_lo, <8 x i16> %s1_hi) {
; CHECK-SD-LABEL: signOf_neon_scmp:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    cmgt v4.8h, v1.8h, v3.8h
; CHECK-SD-NEXT:    cmgt v1.8h, v3.8h, v1.8h
; CHECK-SD-NEXT:    cmgt v3.8h, v0.8h, v2.8h
; CHECK-SD-NEXT:    cmgt v0.8h, v2.8h, v0.8h
; CHECK-SD-NEXT:    sub v1.8h, v1.8h, v4.8h
; CHECK-SD-NEXT:    sub v0.8h, v0.8h, v3.8h
; CHECK-SD-NEXT:    uzp1 v0.16b, v0.16b, v1.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: signOf_neon_scmp:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    cmgt v4.8h, v0.8h, v2.8h
; CHECK-GI-NEXT:    cmgt v5.8h, v1.8h, v3.8h
; CHECK-GI-NEXT:    cmgt v0.8h, v2.8h, v0.8h
; CHECK-GI-NEXT:    cmgt v1.8h, v3.8h, v1.8h
; CHECK-GI-NEXT:    movi v2.16b, #1
; CHECK-GI-NEXT:    movi v3.2d, #0xffffffffffffffff
; CHECK-GI-NEXT:    uzp1 v4.16b, v4.16b, v5.16b
; CHECK-GI-NEXT:    uzp1 v0.16b, v0.16b, v1.16b
; CHECK-GI-NEXT:    shl v1.16b, v4.16b, #7
; CHECK-GI-NEXT:    shl v0.16b, v0.16b, #7
; CHECK-GI-NEXT:    sshr v1.16b, v1.16b, #7
; CHECK-GI-NEXT:    sshr v0.16b, v0.16b, #7
; CHECK-GI-NEXT:    and v1.16b, v2.16b, v1.16b
; CHECK-GI-NEXT:    bsl v0.16b, v3.16b, v1.16b
; CHECK-GI-NEXT:    ret
entry:
  %0 = shufflevector <8 x i16> %s0_lo, <8 x i16> %s0_hi, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %1 = shufflevector <8 x i16> %s1_lo, <8 x i16> %s1_hi, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %or.i = tail call <16 x i8> @llvm.scmp.v16i8.v16i16(<16 x i16> %0, <16 x i16> %1)
  ret <16 x i8> %or.i
}

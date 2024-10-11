; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc --mtriple=loongarch64 --mattr=+lasx %s -o - | FileCheck %s

;; xvshuf.b
define <32 x i8> @shufflevector_v32i8(<32 x i8> %a, <32 x i8> %b) {
; CHECK-LABEL: shufflevector_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI0_0)
; CHECK-NEXT:    xvld $xr2, $a0, %pc_lo12(.LCPI0_0)
; CHECK-NEXT:    xvshuf.b $xr0, $xr1, $xr0, $xr2
; CHECK-NEXT:    ret
    %c = shufflevector <32 x i8> %a, <32 x i8> %b, <32 x i32> <i32 1, i32 3, i32 5, i32 7, i32 8, i32 10, i32 12, i32 15, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39,
                                                               i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55>
    ret <32 x i8> %c
}

;; xvshuf.h
define <16 x i16> @shufflevector_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: shufflevector_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI1_0)
; CHECK-NEXT:    xvld $xr2, $a0, %pc_lo12(.LCPI1_0)
; CHECK-NEXT:    xvpermi.d $xr0, $xr0, 78
; CHECK-NEXT:    xvpermi.d $xr1, $xr1, 78
; CHECK-NEXT:    xvshuf.h $xr2, $xr1, $xr0
; CHECK-NEXT:    xvori.b $xr0, $xr2, 0
; CHECK-NEXT:    ret
    %c = shufflevector <16 x i16> %a, <16 x i16> %b, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 27, i32 26, i32 25, i32 24,
                                                                 i32 16, i32 17, i32 18, i32 19, i32 0, i32 1, i32 2, i32 3>
    ret <16 x i16> %c
}

;; xvshuf.w
define <8 x i32> @shufflevector_v8i32(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: shufflevector_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI2_0)
; CHECK-NEXT:    xvld $xr2, $a0, %pc_lo12(.LCPI2_0)
; CHECK-NEXT:    xvpermi.d $xr0, $xr0, 68
; CHECK-NEXT:    xvpermi.d $xr1, $xr1, 68
; CHECK-NEXT:    xvshuf.w $xr2, $xr1, $xr0
; CHECK-NEXT:    xvori.b $xr0, $xr2, 0
; CHECK-NEXT:    ret
    %c = shufflevector <8 x i32> %a, <8 x i32> %b, <8 x i32> <i32 8, i32 9, i32 3, i32 2, i32 8, i32 9, i32 3, i32 2>
    ret <8 x i32> %c
}

;; xvshuf.d
define <4 x i64> @shufflevector_v4i64(<4 x i64> %a, <4 x i64> %b) {
; CHECK-LABEL: shufflevector_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI3_0)
; CHECK-NEXT:    xvld $xr2, $a0, %pc_lo12(.LCPI3_0)
; CHECK-NEXT:    xvpermi.d $xr0, $xr0, 238
; CHECK-NEXT:    xvpermi.d $xr1, $xr1, 238
; CHECK-NEXT:    xvshuf.d $xr2, $xr1, $xr0
; CHECK-NEXT:    xvori.b $xr0, $xr2, 0
; CHECK-NEXT:    ret
    %c = shufflevector <4 x i64> %a, <4 x i64> %b, <4 x i32> <i32 2, i32 3, i32 6, i32 7>
    ret <4 x i64> %c
}

;; xvshuf.w
define <8 x float> @shufflevector_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: shufflevector_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI4_0)
; CHECK-NEXT:    xvld $xr2, $a0, %pc_lo12(.LCPI4_0)
; CHECK-NEXT:    xvshuf.w $xr2, $xr1, $xr0
; CHECK-NEXT:    xvori.b $xr0, $xr2, 0
; CHECK-NEXT:    ret
    %c = shufflevector <8 x float> %a, <8 x float> %b, <8 x i32> <i32 2, i32 0, i32 10, i32 9, i32 4, i32 5, i32 12, i32 13>
    ret <8 x float> %c
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mattr=+sve                          < %s | FileCheck %s --check-prefixes=CHECK,NOBF16
; RUN: llc -mattr=+sve --enable-no-nans-fp-math < %s | FileCheck %s --check-prefixes=CHECK,NOBF16NNAN
; RUN: llc -mattr=+sve,+bf16                    < %s | FileCheck %s --check-prefixes=CHECK,BF16
; RUN: llc -mattr=+sme -force-streaming         < %s | FileCheck %s --check-prefixes=CHECK,BF16

target triple = "aarch64-unknown-linux-gnu"

; NOTE: "fptrunc <# x double> to <# x bfloat>" is not supported because SVE
; lacks a down convert that rounds to odd. Such IR will trigger the usual
; failure (crash) when attempting to unroll a scalable vector.

define <vscale x 2 x float> @fpext_nxv2bf16_to_nxv2f32(<vscale x 2 x bfloat> %a) {
; CHECK-LABEL: fpext_nxv2bf16_to_nxv2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl z0.s, z0.s, #16
; CHECK-NEXT:    ret
  %res = fpext <vscale x 2 x bfloat> %a to <vscale x 2 x float>
  ret <vscale x 2 x float> %res
}

define <vscale x 4 x float> @fpext_nxv4bf16_to_nxv4f32(<vscale x 4 x bfloat> %a) {
; CHECK-LABEL: fpext_nxv4bf16_to_nxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl z0.s, z0.s, #16
; CHECK-NEXT:    ret
  %res = fpext <vscale x 4 x bfloat> %a to <vscale x 4 x float>
  ret <vscale x 4 x float> %res
}

define <vscale x 8 x float> @fpext_nxv8bf16_to_nxv8f32(<vscale x 8 x bfloat> %a) {
; CHECK-LABEL: fpext_nxv8bf16_to_nxv8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z1.s, z0.h
; CHECK-NEXT:    uunpkhi z2.s, z0.h
; CHECK-NEXT:    lsl z0.s, z1.s, #16
; CHECK-NEXT:    lsl z1.s, z2.s, #16
; CHECK-NEXT:    ret
  %res = fpext <vscale x 8 x bfloat> %a to <vscale x 8 x float>
  ret <vscale x 8 x float> %res
}

define <vscale x 2 x double> @fpext_nxv2bf16_to_nxv2f64(<vscale x 2 x bfloat> %a) {
; CHECK-LABEL: fpext_nxv2bf16_to_nxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl z0.s, z0.s, #16
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fcvt z0.d, p0/m, z0.s
; CHECK-NEXT:    ret
  %res = fpext <vscale x 2 x bfloat> %a to <vscale x 2 x double>
  ret <vscale x 2 x double> %res
}

define <vscale x 4 x double> @fpext_nxv4bf16_to_nxv4f64(<vscale x 4 x bfloat> %a) {
; CHECK-LABEL: fpext_nxv4bf16_to_nxv4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z1.d, z0.s
; CHECK-NEXT:    uunpkhi z0.d, z0.s
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    lsl z1.s, z1.s, #16
; CHECK-NEXT:    lsl z2.s, z0.s, #16
; CHECK-NEXT:    movprfx z0, z1
; CHECK-NEXT:    fcvt z0.d, p0/m, z1.s
; CHECK-NEXT:    movprfx z1, z2
; CHECK-NEXT:    fcvt z1.d, p0/m, z2.s
; CHECK-NEXT:    ret
  %res = fpext <vscale x 4 x bfloat> %a to <vscale x 4 x double>
  ret <vscale x 4 x double> %res
}

define <vscale x 8 x double> @fpext_nxv8bf16_to_nxv8f64(<vscale x 8 x bfloat> %a) {
; CHECK-LABEL: fpext_nxv8bf16_to_nxv8f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z1.s, z0.h
; CHECK-NEXT:    uunpkhi z0.s, z0.h
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    uunpklo z2.d, z1.s
; CHECK-NEXT:    uunpkhi z1.d, z1.s
; CHECK-NEXT:    uunpklo z3.d, z0.s
; CHECK-NEXT:    uunpkhi z0.d, z0.s
; CHECK-NEXT:    lsl z1.s, z1.s, #16
; CHECK-NEXT:    lsl z2.s, z2.s, #16
; CHECK-NEXT:    lsl z3.s, z3.s, #16
; CHECK-NEXT:    lsl z4.s, z0.s, #16
; CHECK-NEXT:    fcvt z1.d, p0/m, z1.s
; CHECK-NEXT:    movprfx z0, z2
; CHECK-NEXT:    fcvt z0.d, p0/m, z2.s
; CHECK-NEXT:    movprfx z2, z3
; CHECK-NEXT:    fcvt z2.d, p0/m, z3.s
; CHECK-NEXT:    movprfx z3, z4
; CHECK-NEXT:    fcvt z3.d, p0/m, z4.s
; CHECK-NEXT:    ret
  %res = fpext <vscale x 8 x bfloat> %a to <vscale x 8 x double>
  ret <vscale x 8 x double> %res
}

define <vscale x 2 x bfloat> @fptrunc_nxv2f32_to_nxv2bf16(<vscale x 2 x float> %a) {
; NOBF16-LABEL: fptrunc_nxv2f32_to_nxv2bf16:
; NOBF16:       // %bb.0:
; NOBF16-NEXT:    mov z1.s, #32767 // =0x7fff
; NOBF16-NEXT:    lsr z2.s, z0.s, #16
; NOBF16-NEXT:    ptrue p0.d
; NOBF16-NEXT:    fcmuo p0.s, p0/z, z0.s, z0.s
; NOBF16-NEXT:    and z2.s, z2.s, #0x1
; NOBF16-NEXT:    add z1.s, z0.s, z1.s
; NOBF16-NEXT:    orr z0.s, z0.s, #0x400000
; NOBF16-NEXT:    add z1.s, z2.s, z1.s
; NOBF16-NEXT:    sel z0.s, p0, z0.s, z1.s
; NOBF16-NEXT:    lsr z0.s, z0.s, #16
; NOBF16-NEXT:    ret
;
; NOBF16NNAN-LABEL: fptrunc_nxv2f32_to_nxv2bf16:
; NOBF16NNAN:       // %bb.0:
; NOBF16NNAN-NEXT:    mov z1.s, #32767 // =0x7fff
; NOBF16NNAN-NEXT:    lsr z2.s, z0.s, #16
; NOBF16NNAN-NEXT:    and z2.s, z2.s, #0x1
; NOBF16NNAN-NEXT:    add z0.s, z0.s, z1.s
; NOBF16NNAN-NEXT:    add z0.s, z2.s, z0.s
; NOBF16NNAN-NEXT:    lsr z0.s, z0.s, #16
; NOBF16NNAN-NEXT:    ret
;
; BF16-LABEL: fptrunc_nxv2f32_to_nxv2bf16:
; BF16:       // %bb.0:
; BF16-NEXT:    ptrue p0.d
; BF16-NEXT:    bfcvt z0.h, p0/m, z0.s
; BF16-NEXT:    ret
  %res = fptrunc <vscale x 2 x float> %a to <vscale x 2 x bfloat>
  ret <vscale x 2 x bfloat> %res
}

define <vscale x 4 x bfloat> @fptrunc_nxv4f32_to_nxv4bf16(<vscale x 4 x float> %a) {
; NOBF16-LABEL: fptrunc_nxv4f32_to_nxv4bf16:
; NOBF16:       // %bb.0:
; NOBF16-NEXT:    mov z1.s, #32767 // =0x7fff
; NOBF16-NEXT:    lsr z2.s, z0.s, #16
; NOBF16-NEXT:    ptrue p0.s
; NOBF16-NEXT:    fcmuo p0.s, p0/z, z0.s, z0.s
; NOBF16-NEXT:    and z2.s, z2.s, #0x1
; NOBF16-NEXT:    add z1.s, z0.s, z1.s
; NOBF16-NEXT:    orr z0.s, z0.s, #0x400000
; NOBF16-NEXT:    add z1.s, z2.s, z1.s
; NOBF16-NEXT:    sel z0.s, p0, z0.s, z1.s
; NOBF16-NEXT:    lsr z0.s, z0.s, #16
; NOBF16-NEXT:    ret
;
; NOBF16NNAN-LABEL: fptrunc_nxv4f32_to_nxv4bf16:
; NOBF16NNAN:       // %bb.0:
; NOBF16NNAN-NEXT:    mov z1.s, #32767 // =0x7fff
; NOBF16NNAN-NEXT:    lsr z2.s, z0.s, #16
; NOBF16NNAN-NEXT:    and z2.s, z2.s, #0x1
; NOBF16NNAN-NEXT:    add z0.s, z0.s, z1.s
; NOBF16NNAN-NEXT:    add z0.s, z2.s, z0.s
; NOBF16NNAN-NEXT:    lsr z0.s, z0.s, #16
; NOBF16NNAN-NEXT:    ret
;
; BF16-LABEL: fptrunc_nxv4f32_to_nxv4bf16:
; BF16:       // %bb.0:
; BF16-NEXT:    ptrue p0.s
; BF16-NEXT:    bfcvt z0.h, p0/m, z0.s
; BF16-NEXT:    ret
  %res = fptrunc <vscale x 4 x float> %a to <vscale x 4 x bfloat>
  ret <vscale x 4 x bfloat> %res
}

define <vscale x 8 x bfloat> @fptrunc_nxv8f32_to_nxv8bf16(<vscale x 8 x float> %a) {
; NOBF16-LABEL: fptrunc_nxv8f32_to_nxv8bf16:
; NOBF16:       // %bb.0:
; NOBF16-NEXT:    mov z2.s, #32767 // =0x7fff
; NOBF16-NEXT:    lsr z3.s, z1.s, #16
; NOBF16-NEXT:    lsr z4.s, z0.s, #16
; NOBF16-NEXT:    ptrue p0.s
; NOBF16-NEXT:    and z3.s, z3.s, #0x1
; NOBF16-NEXT:    and z4.s, z4.s, #0x1
; NOBF16-NEXT:    fcmuo p1.s, p0/z, z1.s, z1.s
; NOBF16-NEXT:    add z5.s, z1.s, z2.s
; NOBF16-NEXT:    add z2.s, z0.s, z2.s
; NOBF16-NEXT:    fcmuo p0.s, p0/z, z0.s, z0.s
; NOBF16-NEXT:    orr z1.s, z1.s, #0x400000
; NOBF16-NEXT:    orr z0.s, z0.s, #0x400000
; NOBF16-NEXT:    add z3.s, z3.s, z5.s
; NOBF16-NEXT:    add z2.s, z4.s, z2.s
; NOBF16-NEXT:    sel z1.s, p1, z1.s, z3.s
; NOBF16-NEXT:    sel z0.s, p0, z0.s, z2.s
; NOBF16-NEXT:    lsr z1.s, z1.s, #16
; NOBF16-NEXT:    lsr z0.s, z0.s, #16
; NOBF16-NEXT:    uzp1 z0.h, z0.h, z1.h
; NOBF16-NEXT:    ret
;
; NOBF16NNAN-LABEL: fptrunc_nxv8f32_to_nxv8bf16:
; NOBF16NNAN:       // %bb.0:
; NOBF16NNAN-NEXT:    mov z2.s, #32767 // =0x7fff
; NOBF16NNAN-NEXT:    lsr z3.s, z1.s, #16
; NOBF16NNAN-NEXT:    lsr z4.s, z0.s, #16
; NOBF16NNAN-NEXT:    and z3.s, z3.s, #0x1
; NOBF16NNAN-NEXT:    and z4.s, z4.s, #0x1
; NOBF16NNAN-NEXT:    add z1.s, z1.s, z2.s
; NOBF16NNAN-NEXT:    add z0.s, z0.s, z2.s
; NOBF16NNAN-NEXT:    add z1.s, z3.s, z1.s
; NOBF16NNAN-NEXT:    add z0.s, z4.s, z0.s
; NOBF16NNAN-NEXT:    lsr z1.s, z1.s, #16
; NOBF16NNAN-NEXT:    lsr z0.s, z0.s, #16
; NOBF16NNAN-NEXT:    uzp1 z0.h, z0.h, z1.h
; NOBF16NNAN-NEXT:    ret
;
; BF16-LABEL: fptrunc_nxv8f32_to_nxv8bf16:
; BF16:       // %bb.0:
; BF16-NEXT:    ptrue p0.s
; BF16-NEXT:    bfcvt z1.h, p0/m, z1.s
; BF16-NEXT:    bfcvt z0.h, p0/m, z0.s
; BF16-NEXT:    uzp1 z0.h, z0.h, z1.h
; BF16-NEXT:    ret
  %res = fptrunc <vscale x 8 x float> %a to <vscale x 8 x bfloat>
  ret <vscale x 8 x bfloat> %res
}

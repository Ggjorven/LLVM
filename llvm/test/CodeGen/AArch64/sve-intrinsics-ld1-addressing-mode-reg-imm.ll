; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; LD1B
;

define <vscale x 16 x i8> @ld1b_upper_bound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_upper_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 16 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1.nxv16i8(<vscale x 16 x i1> %pg, ptr %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ld1b_inbound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 16 x i8>, ptr %a, i64 1
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1.nxv16i8(<vscale x 16 x i1> %pg, ptr %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 4 x i32> @ld1b_s_inbound(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 4 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 4 x i8> @llvm.aarch64.sve.ld1.nxv4i8(<vscale x 4 x i1> %pg, ptr %base_scalar)
  %res = zext <vscale x 4 x i8> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ld1sb_s_inbound(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1sb_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1sb { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 4 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 4 x i8> @llvm.aarch64.sve.ld1.nxv4i8(<vscale x 4 x i1> %pg, ptr %base_scalar)
  %res = sext <vscale x 4 x i8> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 16 x i8> @ld1b_lower_bound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_lower_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, #-8, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 16 x i8>, ptr %a, i64 -8
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1.nxv16i8(<vscale x 16 x i1> %pg, ptr %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ld1b_out_of_upper_bound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_out_of_upper_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #8
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 16 x i8>, ptr %a, i64 8
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1.nxv16i8(<vscale x 16 x i1> %pg, ptr %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ld1b_out_of_lower_bound(<vscale x 16 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_out_of_lower_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #-9
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 16 x i8>, ptr %a, i64 -9
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ld1.nxv16i8(<vscale x 16 x i1> %pg, ptr %base_scalar)
  ret <vscale x 16 x i8> %load
}

;
; LD1H
;

define <vscale x 8 x i16> @ld1b_h_inbound(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_h_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.h }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 8 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 8 x i8> @llvm.aarch64.sve.ld1.nxv8i8(<vscale x 8 x i1> %pg, ptr %base_scalar)
  %res = zext <vscale x 8 x i8> %load to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @ld1sb_h_inbound(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1sb_h_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1sb { z0.h }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 8 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 8 x i8> @llvm.aarch64.sve.ld1.nxv8i8(<vscale x 8 x i1> %pg, ptr %base_scalar)
  %res = sext <vscale x 8 x i8> %load to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @ld1h_inbound(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1h_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 8 x i16>, ptr %a, i64 1
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 8 x i16> @llvm.aarch64.sve.ld1.nxv8i16(<vscale x 8 x i1> %pg, ptr %base_scalar)
  ret <vscale x 8 x i16> %load
}

define <vscale x 4 x i32> @ld1h_s_inbound(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1h_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 4 x i16>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 4 x i16> @llvm.aarch64.sve.ld1.nxv4i16(<vscale x 4 x i1> %pg, ptr %base_scalar)
  %res = zext <vscale x 4 x i16> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ld1sh_s_inbound(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1sh_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1sh { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 4 x i16>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 4 x i16> @llvm.aarch64.sve.ld1.nxv4i16(<vscale x 4 x i1> %pg, ptr %base_scalar)
  %res = sext <vscale x 4 x i16> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @ld1b_d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1b_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i8> @llvm.aarch64.sve.ld1.nxv2i8(<vscale x 2 x i1> %pg, ptr %base_scalar)
  %res = zext <vscale x 2 x i8> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ld1sb_d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1sb_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1sb { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i8>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i8> @llvm.aarch64.sve.ld1.nxv2i8(<vscale x 2 x i1> %pg, ptr %base_scalar)
  %res = sext <vscale x 2 x i8> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ld1h_d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1h_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i16>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i16> @llvm.aarch64.sve.ld1.nxv2i16(<vscale x 2 x i1> %pg, ptr %base_scalar)
  %res = zext <vscale x 2 x i16> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ld1sh_d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1sh_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1sh { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i16>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i16> @llvm.aarch64.sve.ld1.nxv2i16(<vscale x 2 x i1> %pg, ptr %base_scalar)
  %res = sext <vscale x 2 x i16> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 8 x half> @ld1h_f16_inbound(<vscale x 8 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1h_f16_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 8 x half>, ptr %a, i64 1
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 8 x half> @llvm.aarch64.sve.ld1.nxv8f16(<vscale x 8 x i1> %pg, ptr %base_scalar)
  ret <vscale x 8 x half> %load
}

define <vscale x 8 x bfloat> @ld1h_bf16_inbound(<vscale x 8 x i1> %pg, ptr %a) #0 {
; CHECK-LABEL: ld1h_bf16_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 8 x bfloat>, ptr %a, i64 1
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 8 x bfloat> @llvm.aarch64.sve.ld1.nxv8bf16(<vscale x 8 x i1> %pg, ptr %base_scalar)
  ret <vscale x 8 x bfloat> %load
}

;
; LD1W
;

define <vscale x 4 x i32> @ld1w_inbound(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1w_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 4 x i32>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 4 x i32> @llvm.aarch64.sve.ld1.nxv4i32(<vscale x 4 x i1> %pg, ptr %base_scalar)
  ret <vscale x 4 x i32> %load
}

define <vscale x 4 x float> @ld1w_f32_inbound(<vscale x 4 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1w_f32_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 4 x float>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 4 x float> @llvm.aarch64.sve.ld1.nxv4f32(<vscale x 4 x i1> %pg, ptr %base_scalar)
  ret <vscale x 4 x float> %load
}

;
; LD1D
;

define <vscale x 2 x i64> @ld1d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i64>, ptr %a, i64 1
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i64> @llvm.aarch64.sve.ld1.nxv2i64(<vscale x 2 x i1> %pg, ptr %base_scalar)
  ret <vscale x 2 x i64> %load
}

define <vscale x 2 x i64> @ld1w_d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1w_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i32>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i32> @llvm.aarch64.sve.ld1.nxv2i32(<vscale x 2 x i1> %pg, ptr %base_scalar)
  %res = zext <vscale x 2 x i32> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ld1sw_d_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1sw_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1sw { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x i32>, ptr %a, i64 7
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x i32> @llvm.aarch64.sve.ld1.nxv2i32(<vscale x 2 x i1> %pg, ptr %base_scalar)
  %res = sext <vscale x 2 x i32> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x double> @ld1d_f64_inbound(<vscale x 2 x i1> %pg, ptr %a) {
; CHECK-LABEL: ld1d_f64_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base = getelementptr <vscale x 2 x double>, ptr %a, i64 1
  %base_scalar = bitcast ptr %base to ptr
  %load = call <vscale x 2 x double> @llvm.aarch64.sve.ld1.nxv2f64(<vscale x 2 x i1> %pg, ptr %base_scalar)
  ret <vscale x 2 x double> %load
}

declare <vscale x 16 x i8> @llvm.aarch64.sve.ld1.nxv16i8(<vscale x 16 x i1>, ptr)

declare <vscale x 8 x i8> @llvm.aarch64.sve.ld1.nxv8i8(<vscale x 8 x i1>, ptr)
declare <vscale x 8 x i16> @llvm.aarch64.sve.ld1.nxv8i16(<vscale x 8 x i1>, ptr)
declare <vscale x 8 x half> @llvm.aarch64.sve.ld1.nxv8f16(<vscale x 8 x i1>, ptr)
declare <vscale x 8 x bfloat> @llvm.aarch64.sve.ld1.nxv8bf16(<vscale x 8 x i1>, ptr)

declare <vscale x 4 x i8> @llvm.aarch64.sve.ld1.nxv4i8(<vscale x 4 x i1>, ptr)
declare <vscale x 4 x i16> @llvm.aarch64.sve.ld1.nxv4i16(<vscale x 4 x i1>, ptr)
declare <vscale x 4 x i32> @llvm.aarch64.sve.ld1.nxv4i32(<vscale x 4 x i1>, ptr)
declare <vscale x 4 x float> @llvm.aarch64.sve.ld1.nxv4f32(<vscale x 4 x i1>, ptr)

declare <vscale x 2 x i8> @llvm.aarch64.sve.ld1.nxv2i8(<vscale x 2 x i1>, ptr)
declare <vscale x 2 x i16> @llvm.aarch64.sve.ld1.nxv2i16(<vscale x 2 x i1>, ptr)
declare <vscale x 2 x i32> @llvm.aarch64.sve.ld1.nxv2i32(<vscale x 2 x i1>, ptr)
declare <vscale x 2 x i64> @llvm.aarch64.sve.ld1.nxv2i64(<vscale x 2 x i1>, ptr)
declare <vscale x 2 x double> @llvm.aarch64.sve.ld1.nxv2f64(<vscale x 2 x i1>, ptr)

; +bf16 is required for the bfloat version.
attributes #0 = { "target-features"="+sve,+bf16" }

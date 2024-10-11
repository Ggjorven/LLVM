; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64-linux -mattr=+neon,+fp8 < %s | FileCheck %s


define <4 x half> @test_fscale_f16(<4 x half> %vn, <4 x i16> %vm) {
; CHECK-LABEL: test_fscale_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fscale v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %res = tail call <4 x half> @llvm.aarch64.neon.fp8.fscale.v4f16(<4 x half> %vn, <4 x i16> %vm)
  ret <4 x half> %res
}

define <8 x half> @test_fscaleq_f16(<8 x half> %vn, <8 x i16> %vm) {
; CHECK-LABEL: test_fscaleq_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fscale v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %res = tail call <8 x half> @llvm.aarch64.neon.fp8.fscale.v8f16(<8 x half> %vn, <8 x i16> %vm)
  ret <8 x half> %res
}

define <2 x float> @test_fscale_f32(<2 x float> %vn, <2 x i32> %vm) {
; CHECK-LABEL: test_fscale_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fscale v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %res = tail call <2 x float> @llvm.aarch64.neon.fp8.fscale.v2f32(<2 x float> %vn, <2 x i32> %vm)
  ret <2 x float> %res
}

define <4 x float> @test_fscaleq_f32(<4 x float> %vn, <4 x i32> %vm) {
; CHECK-LABEL: test_fscaleq_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fscale v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %res = tail call <4 x float> @llvm.aarch64.neon.fp8.fscale.v4f32(<4 x float> %vn, <4 x i32> %vm)
  ret <4 x float> %res
}

define <2 x double> @test_fscaleq_f64(<2 x double> %vn, <2 x i64> %vm) {
; CHECK-LABEL: test_fscaleq_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fscale v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
  %res = tail call <2 x double> @llvm.aarch64.neon.fp8.fscale.v2f64(<2 x double> %vn, <2 x i64> %vm)
  ret <2 x double> %res
}

declare <4 x half> @llvm.aarch64.neon.fp8.fscale.v4f16(<4 x half>, <4 x i16>)
declare <8 x half> @llvm.aarch64.neon.fp8.fscale.v8f16(<8 x half>, <8 x i16>)
declare <2 x float> @llvm.aarch64.neon.fp8.fscale.v2f32(<2 x float>, <2 x i32>)
declare <4 x float> @llvm.aarch64.neon.fp8.fscale.v4f32(<4 x float>, <4 x i32>)
declare <2 x double> @llvm.aarch64.neon.fp8.fscale.v2f64(<2 x double>, <2 x i64>)

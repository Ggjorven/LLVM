; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1 < %s | FileCheck %s

define <vscale x 16 x i1> @test_pmov_to_pred_i8(<vscale x 16 x i8> %zn) {
; CHECK-LABEL: test_pmov_to_pred_i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    pmov	p0.b, z0
; CHECK-NEXT:    ret
  entry:
  %res = call <vscale x 16 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv16i8(<vscale x 16 x i8> %zn, i32 0)
  ret <vscale x 16 x i1> %res
}

define <vscale x 8 x i1> @test_pmov_to_pred_i16(<vscale x 8 x i16> %zn) {
; CHECK-LABEL: test_pmov_to_pred_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue	p0.h
; CHECK-NEXT:    pmov	p1.h, z0[0]
; CHECK-NEXT:    pmov	p2.h, z0[1]
; CHECK-NEXT:    eor	p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ret
  entry:
  %res1 = call <vscale x 8 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv8i16(<vscale x 8 x i16> %zn, i32 0)
  %res2 = call <vscale x 8 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv8i16(<vscale x 8 x i16> %zn, i32 1)

  %res = add <vscale x 8 x i1> %res1, %res2
  ret <vscale x 8 x i1> %res
}

define <vscale x 4 x i1> @test_pmov_to_pred_i32(<vscale x 4 x i32> %zn) {
; CHECK-LABEL: test_pmov_to_pred_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue	p0.s
; CHECK-NEXT:    pmov	p1.s, z0[0]
; CHECK-NEXT:    pmov	p2.s, z0[3]
; CHECK-NEXT:    eor	p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ret
  entry:
  %res1 = call <vscale x 4 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv4i32(<vscale x 4 x i32> %zn, i32 0)
  %res2 = call <vscale x 4 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv4i32(<vscale x 4 x i32> %zn, i32 3)

  %res = add <vscale x 4 x i1> %res1, %res2
  ret <vscale x 4 x i1> %res
}

define <vscale x 2 x i1> @test_pmov_to_pred_i64(<vscale x 2 x i64> %zn) {
; CHECK-LABEL: test_pmov_to_pred_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue	p0.d
; CHECK-NEXT:    pmov	p1.d, z0[0]
; CHECK-NEXT:    pmov	p2.d, z0[7]
; CHECK-NEXT:    eor	p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ret
  entry:
  %res1 = call <vscale x 2 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv2i64(<vscale x 2 x i64> %zn, i32 0)
  %res2 = call <vscale x 2 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv2i64(<vscale x 2 x i64> %zn, i32 7)

  %res = add <vscale x 2 x i1> %res1, %res2
  ret <vscale x 2 x i1> %res
}

declare <vscale x 16 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv16i8(<vscale x 16 x i8>, i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv8i16(<vscale x 8 x i16>, i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv4i32(<vscale x 4 x i32>, i32)
declare <vscale x 2 x i1> @llvm.aarch64.sve.pmov.to.pred.lane.nxv2i64(<vscale x 2 x i64>, i32)

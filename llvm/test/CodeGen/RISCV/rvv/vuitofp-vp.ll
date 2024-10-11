; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+zvfh,+zvfbfmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+zvfh,+zvfbfmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+zvfhmin,+zvfbfmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+zvfhmin,+zvfbfmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i7(<vscale x 2 x i7> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 127
; CHECK-NEXT:    vsetvli a2, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vand.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v9, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i7(<vscale x 2 x i7> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v9, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v9
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v9, v8, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v9, v8
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vuitofp_nxv2bf16_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2bf16_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.uitofp.nxv2bf16.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i7(<vscale x 2 x i7>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i7(<vscale x 2 x i7> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i7:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    li a1, 127
; ZVFH-NEXT:    vsetvli a2, zero, e8, mf4, ta, ma
; ZVFH-NEXT:    vand.vx v9, v8, a1
; ZVFH-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; ZVFH-NEXT:    vfwcvt.f.xu.v v8, v9, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i7:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    li a1, 127
; ZVFHMIN-NEXT:    vsetvli a2, zero, e8, mf4, ta, ma
; ZVFHMIN-NEXT:    vand.vx v8, v8, a1
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vzext.vf2 v9, v8, v0.t
; ZVFHMIN-NEXT:    vfwcvt.f.xu.v v10, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i7(<vscale x 2 x i7> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i8:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; ZVFH-NEXT:    vfwcvt.f.xu.v v9, v8, v0.t
; ZVFH-NEXT:    vmv1r.v v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i8:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vzext.vf2 v9, v8, v0.t
; ZVFHMIN-NEXT:    vfwcvt.f.xu.v v10, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i8_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; ZVFH-NEXT:    vfwcvt.f.xu.v v9, v8
; ZVFH-NEXT:    vmv1r.v v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i8_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vzext.vf2 v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.xu.v v10, v9
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.xu.v v9, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfcvt.f.xu.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.xu.v v9, v8
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i32:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfncvt.f.xu.w v9, v8, v0.t
; ZVFH-NEXT:    vmv1r.v v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfcvt.f.xu.v v9, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i32_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfncvt.f.xu.w v9, v8
; ZVFH-NEXT:    vmv1r.v v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i32_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfcvt.f.xu.v v9, v8
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i64:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFH-NEXT:    vfncvt.f.xu.w v10, v8, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfncvt.f.f.w v8, v10, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.xu.w v10, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv2f16_nxv2i64_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFH-NEXT:    vfncvt.f.xu.w v10, v8
; ZVFH-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfncvt.f.f.w v8, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv2f16_nxv2i64_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.xu.w v10, v8
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v8, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v8
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 32 x half> @llvm.vp.uitofp.nxv32f16.nxv32i32(<vscale x 32 x i32>, <vscale x 32 x i1>, i32)

define <vscale x 32 x half> @vuitofp_nxv32f16_nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vuitofp_nxv32f16_nxv32i32:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    addi sp, sp, -16
; ZVFH-NEXT:    .cfi_def_cfa_offset 16
; ZVFH-NEXT:    csrr a1, vlenb
; ZVFH-NEXT:    slli a1, a1, 3
; ZVFH-NEXT:    sub sp, sp, a1
; ZVFH-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; ZVFH-NEXT:    vmv1r.v v7, v0
; ZVFH-NEXT:    addi a1, sp, 16
; ZVFH-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; ZVFH-NEXT:    csrr a1, vlenb
; ZVFH-NEXT:    srli a2, a1, 2
; ZVFH-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; ZVFH-NEXT:    vslidedown.vx v0, v0, a2
; ZVFH-NEXT:    slli a1, a1, 1
; ZVFH-NEXT:    sub a2, a0, a1
; ZVFH-NEXT:    sltu a3, a0, a2
; ZVFH-NEXT:    addi a3, a3, -1
; ZVFH-NEXT:    and a2, a3, a2
; ZVFH-NEXT:    addi a3, sp, 16
; ZVFH-NEXT:    vl8r.v v24, (a3) # Unknown-size Folded Reload
; ZVFH-NEXT:    vsetvli zero, a2, e16, m4, ta, ma
; ZVFH-NEXT:    vfncvt.f.xu.w v20, v24, v0.t
; ZVFH-NEXT:    bltu a0, a1, .LBB34_2
; ZVFH-NEXT:  # %bb.1:
; ZVFH-NEXT:    mv a0, a1
; ZVFH-NEXT:  .LBB34_2:
; ZVFH-NEXT:    vmv1r.v v0, v7
; ZVFH-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFH-NEXT:    vfncvt.f.xu.w v16, v8, v0.t
; ZVFH-NEXT:    vmv8r.v v8, v16
; ZVFH-NEXT:    csrr a0, vlenb
; ZVFH-NEXT:    slli a0, a0, 3
; ZVFH-NEXT:    add sp, sp, a0
; ZVFH-NEXT:    addi sp, sp, 16
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vuitofp_nxv32f16_nxv32i32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vmv1r.v v7, v0
; ZVFHMIN-NEXT:    csrr a1, vlenb
; ZVFHMIN-NEXT:    srli a2, a1, 2
; ZVFHMIN-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v0, a2
; ZVFHMIN-NEXT:    slli a1, a1, 1
; ZVFHMIN-NEXT:    sub a2, a0, a1
; ZVFHMIN-NEXT:    sltu a3, a0, a2
; ZVFHMIN-NEXT:    addi a3, a3, -1
; ZVFHMIN-NEXT:    and a2, a3, a2
; ZVFHMIN-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfcvt.f.xu.v v24, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v20, v24
; ZVFHMIN-NEXT:    bltu a0, a1, .LBB34_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a0, a1
; ZVFHMIN-NEXT:  .LBB34_2:
; ZVFHMIN-NEXT:    vmv1r.v v0, v7
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v16, v8
; ZVFHMIN-NEXT:    vmv8r.v v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.vp.uitofp.nxv32f16.nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x half> %v
}

declare <vscale x 32 x float> @llvm.vp.uitofp.nxv32f32.nxv32i32(<vscale x 32 x i32>, <vscale x 32 x i1>, i32)

define <vscale x 32 x float> @vuitofp_nxv32f32_nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv32f32_nxv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 2
; CHECK-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v16, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB35_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB35_2:
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x float> @llvm.vp.uitofp.nxv32f32.nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x float> %v
}

define <vscale x 32 x float> @vuitofp_nxv32f32_nxv32i32_unmasked(<vscale x 32 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv32f32_nxv32i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v16, v16
; CHECK-NEXT:    bltu a0, a1, .LBB36_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB36_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x float> @llvm.vp.uitofp.nxv32f32.nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 32 x float> %v
}

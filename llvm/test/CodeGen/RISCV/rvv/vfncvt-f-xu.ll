; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v,+zfh,+zvfh \
; RUN:   -verify-machineinstrs -target-abi=ilp32d | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh \
; RUN:   -verify-machineinstrs -target-abi=lp64d | FileCheck %s

declare <vscale x 1 x half> @llvm.riscv.vfncvt.f.xu.w.nxv1f16.nxv1i32(
  <vscale x 1 x half>,
  <vscale x 1 x i32>,
  iXLen, iXLen);

define <vscale x 1 x half> @intrinsic_vfncvt_f.xu.w_nxv1f16_nxv1i32(<vscale x 1 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv1f16_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v9, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfncvt.f.xu.w.nxv1f16.nxv1i32(
    <vscale x 1 x half> undef,
    <vscale x 1 x i32> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 1 x half> %a
}

declare <vscale x 1 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv1f16.nxv1i32(
  <vscale x 1 x half>,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 1 x half> @intrinsic_vfncvt_mask_f.xu.w_nxv1f16_nxv1i32(<vscale x 1 x half> %0, <vscale x 1 x i32> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv1f16_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v9, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv1f16.nxv1i32(
    <vscale x 1 x half> %0,
    <vscale x 1 x i32> %1,
    <vscale x 1 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 1 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfncvt.f.xu.w.nxv2f16.nxv2i32(
  <vscale x 2 x half>,
  <vscale x 2 x i32>,
  iXLen, iXLen);

define <vscale x 2 x half> @intrinsic_vfncvt_f.xu.w_nxv2f16_nxv2i32(<vscale x 2 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv2f16_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v9, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfncvt.f.xu.w.nxv2f16.nxv2i32(
    <vscale x 2 x half> undef,
    <vscale x 2 x i32> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 2 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv2f16.nxv2i32(
  <vscale x 2 x half>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 2 x half> @intrinsic_vfncvt_mask_f.xu.w_nxv2f16_nxv2i32(<vscale x 2 x half> %0, <vscale x 2 x i32> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv2f16_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v9, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv2f16.nxv2i32(
    <vscale x 2 x half> %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 2 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfncvt.f.xu.w.nxv4f16.nxv4i32(
  <vscale x 4 x half>,
  <vscale x 4 x i32>,
  iXLen, iXLen);

define <vscale x 4 x half> @intrinsic_vfncvt_f.xu.w_nxv4f16_nxv4i32(<vscale x 4 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv4f16_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfncvt.f.xu.w.nxv4f16.nxv4i32(
    <vscale x 4 x half> undef,
    <vscale x 4 x i32> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 4 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv4f16.nxv4i32(
  <vscale x 4 x half>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 4 x half> @intrinsic_vfncvt_mask_f.xu.w_nxv4f16_nxv4i32(<vscale x 4 x half> %0, <vscale x 4 x i32> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv4f16_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v10, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv4f16.nxv4i32(
    <vscale x 4 x half> %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 4 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfncvt.f.xu.w.nxv8f16.nxv8i32(
  <vscale x 8 x half>,
  <vscale x 8 x i32>,
  iXLen, iXLen);

define <vscale x 8 x half> @intrinsic_vfncvt_f.xu.w_nxv8f16_nxv8i32(<vscale x 8 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv8f16_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v12, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfncvt.f.xu.w.nxv8f16.nxv8i32(
    <vscale x 8 x half> undef,
    <vscale x 8 x i32> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 8 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv8f16.nxv8i32(
  <vscale x 8 x half>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 8 x half> @intrinsic_vfncvt_mask_f.xu.w_nxv8f16_nxv8i32(<vscale x 8 x half> %0, <vscale x 8 x i32> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv8f16_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v12, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv8f16.nxv8i32(
    <vscale x 8 x half> %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 8 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfncvt.f.xu.w.nxv16f16.nxv16i32(
  <vscale x 16 x half>,
  <vscale x 16 x i32>,
  iXLen, iXLen);

define <vscale x 16 x half> @intrinsic_vfncvt_f.xu.w_nxv16f16_nxv16i32(<vscale x 16 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv16f16_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v16, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfncvt.f.xu.w.nxv16f16.nxv16i32(
    <vscale x 16 x half> undef,
    <vscale x 16 x i32> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 16 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv16f16.nxv16i32(
  <vscale x 16 x half>,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 16 x half> @intrinsic_vfncvt_mask_f.xu.w_nxv16f16_nxv16i32(<vscale x 16 x half> %0, <vscale x 16 x i32> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv16f16_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v16, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfncvt.f.xu.w.mask.nxv16f16.nxv16i32(
    <vscale x 16 x half> %0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 16 x half> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfncvt.f.xu.w.nxv1f32.nxv1i64(
  <vscale x 1 x float>,
  <vscale x 1 x i64>,
  iXLen, iXLen);

define <vscale x 1 x float> @intrinsic_vfncvt_f.xu.w_nxv1f32_nxv1i64(<vscale x 1 x i64> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv1f32_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v9, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfncvt.f.xu.w.nxv1f32.nxv1i64(
    <vscale x 1 x float> undef,
    <vscale x 1 x i64> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 1 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv1f32.nxv1i64(
  <vscale x 1 x float>,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 1 x float> @intrinsic_vfncvt_mask_f.xu.w_nxv1f32_nxv1i64(<vscale x 1 x float> %0, <vscale x 1 x i64> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv1f32_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v9, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv1f32.nxv1i64(
    <vscale x 1 x float> %0,
    <vscale x 1 x i64> %1,
    <vscale x 1 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfncvt.f.xu.w.nxv2f32.nxv2i64(
  <vscale x 2 x float>,
  <vscale x 2 x i64>,
  iXLen, iXLen);

define <vscale x 2 x float> @intrinsic_vfncvt_f.xu.w_nxv2f32_nxv2i64(<vscale x 2 x i64> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv2f32_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfncvt.f.xu.w.nxv2f32.nxv2i64(
    <vscale x 2 x float> undef,
    <vscale x 2 x i64> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv2f32.nxv2i64(
  <vscale x 2 x float>,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 2 x float> @intrinsic_vfncvt_mask_f.xu.w_nxv2f32_nxv2i64(<vscale x 2 x float> %0, <vscale x 2 x i64> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv2f32_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v10, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv2f32.nxv2i64(
    <vscale x 2 x float> %0,
    <vscale x 2 x i64> %1,
    <vscale x 2 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfncvt.f.xu.w.nxv4f32.nxv4i64(
  <vscale x 4 x float>,
  <vscale x 4 x i64>,
  iXLen, iXLen);

define <vscale x 4 x float> @intrinsic_vfncvt_f.xu.w_nxv4f32_nxv4i64(<vscale x 4 x i64> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv4f32_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v12, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfncvt.f.xu.w.nxv4f32.nxv4i64(
    <vscale x 4 x float> undef,
    <vscale x 4 x i64> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv4f32.nxv4i64(
  <vscale x 4 x float>,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 4 x float> @intrinsic_vfncvt_mask_f.xu.w_nxv4f32_nxv4i64(<vscale x 4 x float> %0, <vscale x 4 x i64> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv4f32_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v12, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv4f32.nxv4i64(
    <vscale x 4 x float> %0,
    <vscale x 4 x i64> %1,
    <vscale x 4 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfncvt.f.xu.w.nxv8f32.nxv8i64(
  <vscale x 8 x float>,
  <vscale x 8 x i64>,
  iXLen, iXLen);

define <vscale x 8 x float> @intrinsic_vfncvt_f.xu.w_nxv8f32_nxv8i64(<vscale x 8 x i64> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_f.xu.w_nxv8f32_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v16, v8
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfncvt.f.xu.w.nxv8f32.nxv8i64(
    <vscale x 8 x float> undef,
    <vscale x 8 x i64> %0,
    iXLen 0, iXLen %1)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv8f32.nxv8i64(
  <vscale x 8 x float>,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  iXLen, iXLen, iXLen);

define <vscale x 8 x float> @intrinsic_vfncvt_mask_f.xu.w_nxv8f32_nxv8i64(<vscale x 8 x float> %0, <vscale x 8 x i64> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vfncvt_mask_f.xu.w_nxv8f32_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fsrmi a1, 0
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, mu
; CHECK-NEXT:    vfncvt.f.xu.w v8, v16, v0.t
; CHECK-NEXT:    fsrm a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfncvt.f.xu.w.mask.nxv8f32.nxv8i64(
    <vscale x 8 x float> %0,
    <vscale x 8 x i64> %1,
    <vscale x 8 x i1> %2,
    iXLen 0, iXLen %3, iXLen 1)

  ret <vscale x 8 x float> %a
}

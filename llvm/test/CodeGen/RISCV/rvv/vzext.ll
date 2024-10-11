; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK

declare <vscale x 1 x i64> @llvm.riscv.vzext.nxv1i64.nxv1i8(
  <vscale x 1 x i64>,
  <vscale x 1 x i8>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vzext_vf8_nxv1i64(<vscale x 1 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf8_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vzext.vf8 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vzext.nxv1i64.nxv1i8(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i8> %0,
    iXLen %1)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vzext.mask.nxv1i64.nxv1i8(
  <vscale x 1 x i64>,
  <vscale x 1 x i8>,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vzext_mask_vf8_nxv1i64(<vscale x 1 x i1> %0, <vscale x 1 x i64> %1, <vscale x 1 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf8_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, mu
; CHECK-NEXT:    vzext.vf8 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vzext.mask.nxv1i64.nxv1i8(
    <vscale x 1 x i64> %1,
    <vscale x 1 x i8> %2,
    <vscale x 1 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vzext.nxv2i64.nxv2i8(
  <vscale x 2 x i64>,
  <vscale x 2 x i8>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vzext_vf8_nxv2i64(<vscale x 2 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf8_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf8 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vzext.nxv2i64.nxv2i8(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i8> %0,
    iXLen %1)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vzext.mask.nxv2i64.nxv2i8(
  <vscale x 2 x i64>,
  <vscale x 2 x i8>,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vzext_mask_vf8_nxv2i64(<vscale x 2 x i1> %0, <vscale x 2 x i64> %1, <vscale x 2 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf8_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, mu
; CHECK-NEXT:    vzext.vf8 v8, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vzext.mask.nxv2i64.nxv2i8(
    <vscale x 2 x i64> %1,
    <vscale x 2 x i8> %2,
    <vscale x 2 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vzext.nxv4i64.nxv4i8(
  <vscale x 4 x i64>,
  <vscale x 4 x i8>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vzext_vf8_nxv4i64(<vscale x 4 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf8_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vzext.vf8 v12, v8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vzext.nxv4i64.nxv4i8(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i8> %0,
    iXLen %1)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vzext.mask.nxv4i64.nxv4i8(
  <vscale x 4 x i64>,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vzext_mask_vf8_nxv4i64(<vscale x 4 x i1> %0, <vscale x 4 x i64> %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf8_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, mu
; CHECK-NEXT:    vzext.vf8 v8, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vzext.mask.nxv4i64.nxv4i8(
    <vscale x 4 x i64> %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vzext.nxv8i64.nxv8i8(
  <vscale x 8 x i64>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vzext_vf8_nxv8i64(<vscale x 8 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf8_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf8 v16, v8
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vzext.nxv8i64.nxv8i8(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i8> %0,
    iXLen %1)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vzext.mask.nxv8i64.nxv8i8(
  <vscale x 8 x i64>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vzext_mask_vf8_nxv8i64(<vscale x 8 x i1> %0, <vscale x 8 x i64> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf8_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, mu
; CHECK-NEXT:    vzext.vf8 v8, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vzext.mask.nxv8i64.nxv8i8(
    <vscale x 8 x i64> %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vzext.nxv1i64.nxv1i16(
  <vscale x 1 x i64>,
  <vscale x 1 x i16>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vzext_vf4_nxv1i64(<vscale x 1 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vzext.nxv1i64.nxv1i16(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i16> %0,
    iXLen %1)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vzext.mask.nxv1i64.nxv1i16(
  <vscale x 1 x i64>,
  <vscale x 1 x i16>,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vzext_mask_vf4_nxv1i64(<vscale x 1 x i1> %0, <vscale x 1 x i64> %1, <vscale x 1 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vzext.mask.nxv1i64.nxv1i16(
    <vscale x 1 x i64> %1,
    <vscale x 1 x i16> %2,
    <vscale x 1 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vzext.nxv2i64.nxv2i16(
  <vscale x 2 x i64>,
  <vscale x 2 x i16>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vzext_vf4_nxv2i64(<vscale x 2 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vzext.nxv2i64.nxv2i16(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i16> %0,
    iXLen %1)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vzext.mask.nxv2i64.nxv2i16(
  <vscale x 2 x i64>,
  <vscale x 2 x i16>,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vzext_mask_vf4_nxv2i64(<vscale x 2 x i1> %0, <vscale x 2 x i64> %1, <vscale x 2 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vzext.mask.nxv2i64.nxv2i16(
    <vscale x 2 x i64> %1,
    <vscale x 2 x i16> %2,
    <vscale x 2 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vzext.nxv4i64.nxv4i16(
  <vscale x 4 x i64>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vzext_vf4_nxv4i64(<vscale x 4 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vzext.vf4 v12, v8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vzext.nxv4i64.nxv4i16(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i16> %0,
    iXLen %1)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vzext.mask.nxv4i64.nxv4i16(
  <vscale x 4 x i64>,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vzext_mask_vf4_nxv4i64(<vscale x 4 x i1> %0, <vscale x 4 x i64> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vzext.mask.nxv4i64.nxv4i16(
    <vscale x 4 x i64> %1,
    <vscale x 4 x i16> %2,
    <vscale x 4 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vzext.nxv8i64.nxv8i16(
  <vscale x 8 x i64>,
  <vscale x 8 x i16>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vzext_vf4_nxv8i64(<vscale x 8 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf4 v16, v8
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vzext.nxv8i64.nxv8i16(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i16> %0,
    iXLen %1)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vzext.mask.nxv8i64.nxv8i16(
  <vscale x 8 x i64>,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vzext_mask_vf4_nxv8i64(<vscale x 8 x i1> %0, <vscale x 8 x i64> %1, <vscale x 8 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vzext.mask.nxv8i64.nxv8i16(
    <vscale x 8 x i64> %1,
    <vscale x 8 x i16> %2,
    <vscale x 8 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vzext.nxv1i32.nxv1i8(
  <vscale x 1 x i32>,
  <vscale x 1 x i8>,
  iXLen);

define <vscale x 1 x i32> @intrinsic_vzext_vf4_nxv1i32(<vscale x 1 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vzext.vf4 v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vzext.nxv1i32.nxv1i8(
    <vscale x 1 x i32> undef,
    <vscale x 1 x i8> %0,
    iXLen %1)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vzext.mask.nxv1i32.nxv1i8(
  <vscale x 1 x i32>,
  <vscale x 1 x i8>,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x i32> @intrinsic_vzext_mask_vf4_nxv1i32(<vscale x 1 x i1> %0, <vscale x 1 x i32> %1, <vscale x 1 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vzext.mask.nxv1i32.nxv1i8(
    <vscale x 1 x i32> %1,
    <vscale x 1 x i8> %2,
    <vscale x 1 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vzext.nxv2i32.nxv2i8(
  <vscale x 2 x i32>,
  <vscale x 2 x i8>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vzext_vf4_nxv2i32(<vscale x 2 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vzext.nxv2i32.nxv2i8(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i8> %0,
    iXLen %1)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vzext.mask.nxv2i32.nxv2i8(
  <vscale x 2 x i32>,
  <vscale x 2 x i8>,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vzext_mask_vf4_nxv2i32(<vscale x 2 x i1> %0, <vscale x 2 x i32> %1, <vscale x 2 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vzext.mask.nxv2i32.nxv2i8(
    <vscale x 2 x i32> %1,
    <vscale x 2 x i8> %2,
    <vscale x 2 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vzext.nxv4i32.nxv4i8(
  <vscale x 4 x i32>,
  <vscale x 4 x i8>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vzext_vf4_nxv4i32(<vscale x 4 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vzext.nxv4i32.nxv4i8(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i8> %0,
    iXLen %1)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vzext.mask.nxv4i32.nxv4i8(
  <vscale x 4 x i32>,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vzext_mask_vf4_nxv4i32(<vscale x 4 x i1> %0, <vscale x 4 x i32> %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vzext.mask.nxv4i32.nxv4i8(
    <vscale x 4 x i32> %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vzext.nxv8i32.nxv8i8(
  <vscale x 8 x i32>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vzext_vf4_nxv8i32(<vscale x 8 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vzext.vf4 v12, v8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vzext.nxv8i32.nxv8i8(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i8> %0,
    iXLen %1)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vzext.mask.nxv8i32.nxv8i8(
  <vscale x 8 x i32>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vzext_mask_vf4_nxv8i32(<vscale x 8 x i1> %0, <vscale x 8 x i32> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vzext.mask.nxv8i32.nxv8i8(
    <vscale x 8 x i32> %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vzext.nxv16i32.nxv16i8(
  <vscale x 16 x i32>,
  <vscale x 16 x i8>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vzext_vf4_nxv16i32(<vscale x 16 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf4_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vzext.vf4 v16, v8
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vzext.nxv16i32.nxv16i8(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i8> %0,
    iXLen %1)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vzext.mask.nxv16i32.nxv16i8(
  <vscale x 16 x i32>,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vzext_mask_vf4_nxv16i32(<vscale x 16 x i1> %0, <vscale x 16 x i32> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf4_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, mu
; CHECK-NEXT:    vzext.vf4 v8, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vzext.mask.nxv16i32.nxv16i8(
    <vscale x 16 x i32> %1,
    <vscale x 16 x i8> %2,
    <vscale x 16 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vzext.nxv1i64.nxv1i32(
  <vscale x 1 x i64>,
  <vscale x 1 x i32>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vzext_vf2_nxv1i64(<vscale x 1 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vzext.nxv1i64.nxv1i32(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i32> %0,
    iXLen %1)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vzext.mask.nxv1i64.nxv1i32(
  <vscale x 1 x i64>,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vzext_mask_vf2_nxv1i64(<vscale x 1 x i1> %0, <vscale x 1 x i64> %1, <vscale x 1 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vzext.mask.nxv1i64.nxv1i32(
    <vscale x 1 x i64> %1,
    <vscale x 1 x i32> %2,
    <vscale x 1 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vzext.nxv2i64.nxv2i32(
  <vscale x 2 x i64>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vzext_vf2_nxv2i64(<vscale x 2 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vzext.nxv2i64.nxv2i32(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i32> %0,
    iXLen %1)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vzext.mask.nxv2i64.nxv2i32(
  <vscale x 2 x i64>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vzext_mask_vf2_nxv2i64(<vscale x 2 x i1> %0, <vscale x 2 x i64> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vzext.mask.nxv2i64.nxv2i32(
    <vscale x 2 x i64> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vzext.nxv4i64.nxv4i32(
  <vscale x 4 x i64>,
  <vscale x 4 x i32>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vzext_vf2_nxv4i64(<vscale x 4 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vzext.vf2 v12, v8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vzext.nxv4i64.nxv4i32(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i32> %0,
    iXLen %1)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vzext.mask.nxv4i64.nxv4i32(
  <vscale x 4 x i64>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vzext_mask_vf2_nxv4i64(<vscale x 4 x i1> %0, <vscale x 4 x i64> %1, <vscale x 4 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vzext.mask.nxv4i64.nxv4i32(
    <vscale x 4 x i64> %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vzext.nxv8i64.nxv8i32(
  <vscale x 8 x i64>,
  <vscale x 8 x i32>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vzext_vf2_nxv8i64(<vscale x 8 x i32> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v16, v8
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vzext.nxv8i64.nxv8i32(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i32> %0,
    iXLen %1)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vzext.mask.nxv8i64.nxv8i32(
  <vscale x 8 x i64>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vzext_mask_vf2_nxv8i64(<vscale x 8 x i1> %0, <vscale x 8 x i64> %1, <vscale x 8 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vzext.mask.nxv8i64.nxv8i32(
    <vscale x 8 x i64> %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vzext.nxv1i32.nxv1i16(
  <vscale x 1 x i32>,
  <vscale x 1 x i16>,
  iXLen);

define <vscale x 1 x i32> @intrinsic_vzext_vf2_nxv1i32(<vscale x 1 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vzext.nxv1i32.nxv1i16(
    <vscale x 1 x i32> undef,
    <vscale x 1 x i16> %0,
    iXLen %1)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vzext.mask.nxv1i32.nxv1i16(
  <vscale x 1 x i32>,
  <vscale x 1 x i16>,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x i32> @intrinsic_vzext_mask_vf2_nxv1i32(<vscale x 1 x i1> %0, <vscale x 1 x i32> %1, <vscale x 1 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vzext.mask.nxv1i32.nxv1i16(
    <vscale x 1 x i32> %1,
    <vscale x 1 x i16> %2,
    <vscale x 1 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vzext.nxv2i32.nxv2i16(
  <vscale x 2 x i32>,
  <vscale x 2 x i16>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vzext_vf2_nxv2i32(<vscale x 2 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vzext.nxv2i32.nxv2i16(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i16> %0,
    iXLen %1)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vzext.mask.nxv2i32.nxv2i16(
  <vscale x 2 x i32>,
  <vscale x 2 x i16>,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vzext_mask_vf2_nxv2i32(<vscale x 2 x i1> %0, <vscale x 2 x i32> %1, <vscale x 2 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vzext.mask.nxv2i32.nxv2i16(
    <vscale x 2 x i32> %1,
    <vscale x 2 x i16> %2,
    <vscale x 2 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vzext.nxv4i32.nxv4i16(
  <vscale x 4 x i32>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vzext_vf2_nxv4i32(<vscale x 4 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vzext.nxv4i32.nxv4i16(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i16> %0,
    iXLen %1)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vzext.mask.nxv4i32.nxv4i16(
  <vscale x 4 x i32>,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vzext_mask_vf2_nxv4i32(<vscale x 4 x i1> %0, <vscale x 4 x i32> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vzext.mask.nxv4i32.nxv4i16(
    <vscale x 4 x i32> %1,
    <vscale x 4 x i16> %2,
    <vscale x 4 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vzext.nxv8i32.nxv8i16(
  <vscale x 8 x i32>,
  <vscale x 8 x i16>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vzext_vf2_nxv8i32(<vscale x 8 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vzext.vf2 v12, v8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vzext.nxv8i32.nxv8i16(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i16> %0,
    iXLen %1)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vzext.mask.nxv8i32.nxv8i16(
  <vscale x 8 x i32>,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vzext_mask_vf2_nxv8i32(<vscale x 8 x i1> %0, <vscale x 8 x i32> %1, <vscale x 8 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vzext.mask.nxv8i32.nxv8i16(
    <vscale x 8 x i32> %1,
    <vscale x 8 x i16> %2,
    <vscale x 8 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vzext.nxv16i32.nxv16i16(
  <vscale x 16 x i32>,
  <vscale x 16 x i16>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vzext_vf2_nxv16i32(<vscale x 16 x i16> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v16, v8
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vzext.nxv16i32.nxv16i16(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i16> %0,
    iXLen %1)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vzext.mask.nxv16i32.nxv16i16(
  <vscale x 16 x i32>,
  <vscale x 16 x i16>,
  <vscale x 16 x i1>,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vzext_mask_vf2_nxv16i32(<vscale x 16 x i1> %0, <vscale x 16 x i32> %1, <vscale x 16 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vzext.mask.nxv16i32.nxv16i16(
    <vscale x 16 x i32> %1,
    <vscale x 16 x i16> %2,
    <vscale x 16 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vzext.nxv1i16.nxv1i8(
  <vscale x 1 x i16>,
  <vscale x 1 x i8>,
  iXLen);

define <vscale x 1 x i16> @intrinsic_vzext_vf2_nxv1i16(<vscale x 1 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vzext.nxv1i16.nxv1i8(
    <vscale x 1 x i16> undef,
    <vscale x 1 x i8> %0,
    iXLen %1)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vzext.mask.nxv1i16.nxv1i8(
  <vscale x 1 x i16>,
  <vscale x 1 x i8>,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x i16> @intrinsic_vzext_mask_vf2_nxv1i16(<vscale x 1 x i1> %0, <vscale x 1 x i16> %1, <vscale x 1 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vzext.mask.nxv1i16.nxv1i8(
    <vscale x 1 x i16> %1,
    <vscale x 1 x i8> %2,
    <vscale x 1 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vzext.nxv2i16.nxv2i8(
  <vscale x 2 x i16>,
  <vscale x 2 x i8>,
  iXLen);

define <vscale x 2 x i16> @intrinsic_vzext_vf2_nxv2i16(<vscale x 2 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vzext.nxv2i16.nxv2i8(
    <vscale x 2 x i16> undef,
    <vscale x 2 x i8> %0,
    iXLen %1)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vzext.mask.nxv2i16.nxv2i8(
  <vscale x 2 x i16>,
  <vscale x 2 x i8>,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x i16> @intrinsic_vzext_mask_vf2_nxv2i16(<vscale x 2 x i1> %0, <vscale x 2 x i16> %1, <vscale x 2 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vzext.mask.nxv2i16.nxv2i8(
    <vscale x 2 x i16> %1,
    <vscale x 2 x i8> %2,
    <vscale x 2 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vzext.nxv4i16.nxv4i8(
  <vscale x 4 x i16>,
  <vscale x 4 x i8>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vzext_vf2_nxv4i16(<vscale x 4 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vzext.nxv4i16.nxv4i8(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i8> %0,
    iXLen %1)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vzext.mask.nxv4i16.nxv4i8(
  <vscale x 4 x i16>,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vzext_mask_vf2_nxv4i16(<vscale x 4 x i1> %0, <vscale x 4 x i16> %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vzext.mask.nxv4i16.nxv4i8(
    <vscale x 4 x i16> %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vzext.nxv8i16.nxv8i8(
  <vscale x 8 x i16>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_vzext_vf2_nxv8i16(<vscale x 8 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vzext.nxv8i16.nxv8i8(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i8> %0,
    iXLen %1)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vzext.mask.nxv8i16.nxv8i8(
  <vscale x 8 x i16>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x i16> @intrinsic_vzext_mask_vf2_nxv8i16(<vscale x 8 x i1> %0, <vscale x 8 x i16> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vzext.mask.nxv8i16.nxv8i8(
    <vscale x 8 x i16> %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vzext.nxv16i16.nxv16i8(
  <vscale x 16 x i16>,
  <vscale x 16 x i8>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_vzext_vf2_nxv16i16(<vscale x 16 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vzext.vf2 v12, v8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vzext.nxv16i16.nxv16i8(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i8> %0,
    iXLen %1)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vzext.mask.nxv16i16.nxv16i8(
  <vscale x 16 x i16>,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen,
  iXLen);

define <vscale x 16 x i16> @intrinsic_vzext_mask_vf2_nxv16i16(<vscale x 16 x i1> %0, <vscale x 16 x i16> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vzext.mask.nxv16i16.nxv16i8(
    <vscale x 16 x i16> %1,
    <vscale x 16 x i8> %2,
    <vscale x 16 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vzext.nxv32i16.nxv32i8(
  <vscale x 32 x i16>,
  <vscale x 32 x i8>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_vzext_vf2_nxv32i16(<vscale x 32 x i8> %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_vzext_vf2_nxv32i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v16, v8
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vzext.nxv32i16.nxv32i8(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i8> %0,
    iXLen %1)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vzext.mask.nxv32i16.nxv32i8(
  <vscale x 32 x i16>,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  iXLen,
  iXLen);

define <vscale x 32 x i16> @intrinsic_vzext_mask_vf2_nxv32i16(<vscale x 32 x i1> %0, <vscale x 32 x i16> %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vzext_mask_vf2_nxv32i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, mu
; CHECK-NEXT:    vzext.vf2 v8, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vzext.mask.nxv32i16.nxv32i8(
    <vscale x 32 x i16> %1,
    <vscale x 32 x i8> %2,
    <vscale x 32 x i1> %0,
    iXLen %3, iXLen 1)

  ret <vscale x 32 x i16> %a
}

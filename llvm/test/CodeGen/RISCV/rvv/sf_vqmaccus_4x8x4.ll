; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v,+xsfvqmaccqoq \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v,+xsfvqmaccqoq \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK

declare <vscale x 2 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv2i32.nxv8i8.nxv8i8(
  <vscale x 2 x i32>,
  <vscale x 8 x i8>,
  <vscale x 4 x i8>,
  iXLen, iXLen);

define <vscale x 2 x i32> @intrinsic_vqmaccus_4x8x4_tu_i32m1(<vscale x 2 x i32> %0, <vscale x 8 x i8> %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_tu_i32m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv2i32.nxv8i8.nxv8i8(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 4 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 2 x i32> %a
}

define <vscale x 2 x i32> @intrinsic_vqmaccus_4x8x4_ta_i32m1(<vscale x 2 x i32> %0, <vscale x 8 x i8> %1, <vscale x 4 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_ta_i32m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv2i32.nxv8i8.nxv8i8(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 4 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv4i32.nxv8i8.nxv16i8(
  <vscale x 4 x i32>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  iXLen, iXLen);

define <vscale x 4 x i32> @intrinsic_vqmaccus_4x8x4_tu_i32m2(<vscale x 4 x i32> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_tu_i32m2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, tu, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v10, v11
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv4i32.nxv8i8.nxv16i8(
    <vscale x 4 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 4 x i32> %a
}

define <vscale x 4 x i32> @intrinsic_vqmaccus_4x8x4_ta_i32m2(<vscale x 4 x i32> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_ta_i32m2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v10, v11
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv4i32.nxv8i8.nxv16i8(
    <vscale x 4 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv8i32.nxv8i8.nxv32i8(
  <vscale x 8 x i32>,
  <vscale x 8 x i8>,
  <vscale x 16 x i8>,
  iXLen, iXLen);

define <vscale x 8 x i32> @intrinsic_vqmaccus_4x8x4_tu_i32m4(<vscale x 8 x i32> %0, <vscale x 8 x i8> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_tu_i32m4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, tu, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v12, v14
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv8i32.nxv8i8.nxv32i8(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 16 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 8 x i32> %a
}

define <vscale x 8 x i32> @intrinsic_vqmaccus_4x8x4_ta_i32m4(<vscale x 8 x i32> %0, <vscale x 8 x i8> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_ta_i32m4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v12, v14
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv8i32.nxv8i8.nxv32i8(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 16 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv16i32.nxv8i8.nxv64i8(
  <vscale x 16 x i32>,
  <vscale x 8 x i8>,
  <vscale x 32 x i8>,
  iXLen, iXLen);

define <vscale x 16 x i32> @intrinsic_vqmaccus_4x8x4_tu_i32m8(<vscale x 16 x i32> %0, <vscale x 8 x i8> %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_tu_i32m8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, tu, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v16, v20
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv16i32.nxv8i8.nxv64i8(
    <vscale x 16 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 32 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 16 x i32> %a
}

define <vscale x 16 x i32> @intrinsic_vqmaccus_4x8x4_ta_i32m8(<vscale x 16 x i32> %0, <vscale x 8 x i8> %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccus_4x8x4_ta_i32m8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    sf.vqmaccus.4x8x4 v8, v16, v20
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.sf.vqmaccus.4x8x4.nxv16i32.nxv8i8.nxv64i8(
    <vscale x 16 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 32 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 16 x i32> %a
}

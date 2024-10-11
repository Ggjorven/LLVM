; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v,+zfh,+zvfhmin,+zvfbfmin \
; RUN:   -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfhmin,+zvfbfmin \
; RUN:   -verify-machineinstrs | FileCheck %s

declare <vscale x 1 x i8> @llvm.riscv.vcompress.nxv1i8(
  <vscale x 1 x i8>,
  <vscale x 1 x i8>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i8> @intrinsic_vcompress_vm_nxv1i8_nxv1i8(<vscale x 1 x i8> %0, <vscale x 1 x i8> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1i8_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i8> @llvm.riscv.vcompress.nxv1i8(
    <vscale x 1 x i8> %0,
    <vscale x 1 x i8> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x i8> %a
}

declare <vscale x 2 x i8> @llvm.riscv.vcompress.nxv2i8(
  <vscale x 2 x i8>,
  <vscale x 2 x i8>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i8> @intrinsic_vcompress_vm_nxv2i8_nxv2i8(<vscale x 2 x i8> %0, <vscale x 2 x i8> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2i8_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i8> @llvm.riscv.vcompress.nxv2i8(
    <vscale x 2 x i8> %0,
    <vscale x 2 x i8> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x i8> %a
}

declare <vscale x 4 x i8> @llvm.riscv.vcompress.nxv4i8(
  <vscale x 4 x i8>,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i8> @intrinsic_vcompress_vm_nxv4i8_nxv4i8(<vscale x 4 x i8> %0, <vscale x 4 x i8> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i8> @llvm.riscv.vcompress.nxv4i8(
    <vscale x 4 x i8> %0,
    <vscale x 4 x i8> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vcompress.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vcompress_vm_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vcompress.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.vcompress.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i8> @intrinsic_vcompress_vm_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv16i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.vcompress.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8> %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.vcompress.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i8> @intrinsic_vcompress_vm_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8> %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv32i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.vcompress.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8> %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.vcompress.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>,
  <vscale x 64 x i1>,
  iXLen);

define <vscale x 64 x i8> @intrinsic_vcompress_vm_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8> %1, <vscale x 64 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv64i8_nxv64i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.vcompress.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8> %1,
    <vscale x 64 x i1> %2,
    iXLen %3)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vcompress.nxv1i16(
  <vscale x 1 x i16>,
  <vscale x 1 x i16>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i16> @intrinsic_vcompress_vm_nxv1i16_nxv1i16(<vscale x 1 x i16> %0, <vscale x 1 x i16> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1i16_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vcompress.nxv1i16(
    <vscale x 1 x i16> %0,
    <vscale x 1 x i16> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vcompress.nxv2i16(
  <vscale x 2 x i16>,
  <vscale x 2 x i16>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i16> @intrinsic_vcompress_vm_nxv2i16_nxv2i16(<vscale x 2 x i16> %0, <vscale x 2 x i16> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2i16_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vcompress.nxv2i16(
    <vscale x 2 x i16> %0,
    <vscale x 2 x i16> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vcompress.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vcompress_vm_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vcompress.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vcompress.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_vcompress_vm_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8i16_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vcompress.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vcompress.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_vcompress_vm_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv16i16_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vcompress.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16> %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vcompress.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_vcompress_vm_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16> %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv32i16_nxv32i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vcompress.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16> %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vcompress.nxv1i32(
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i32> @intrinsic_vcompress_vm_nxv1i32_nxv1i32(<vscale x 1 x i32> %0, <vscale x 1 x i32> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1i32_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vcompress.nxv1i32(
    <vscale x 1 x i32> %0,
    <vscale x 1 x i32> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vcompress.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vcompress_vm_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vcompress.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vcompress.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vcompress_vm_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4i32_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vcompress.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vcompress.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vcompress_vm_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8i32_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vcompress.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vcompress.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vcompress_vm_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv16i32_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vcompress.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vcompress.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vcompress_vm_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vcompress.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vcompress.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vcompress_vm_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2i64_nxv2i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vcompress.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vcompress.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vcompress_vm_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4i64_nxv4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vcompress.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vcompress.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vcompress_vm_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8i64_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vcompress.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x half> @llvm.riscv.vcompress.nxv1f16(
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x half> @intrinsic_vcompress_vm_nxv1f16_nxv1f16(<vscale x 1 x half> %0, <vscale x 1 x half> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vcompress.nxv1f16(
    <vscale x 1 x half> %0,
    <vscale x 1 x half> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vcompress.nxv2f16(
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x half> @intrinsic_vcompress_vm_nxv2f16_nxv2f16(<vscale x 2 x half> %0, <vscale x 2 x half> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vcompress.nxv2f16(
    <vscale x 2 x half> %0,
    <vscale x 2 x half> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vcompress.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x half> @intrinsic_vcompress_vm_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vcompress.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vcompress.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x half> @intrinsic_vcompress_vm_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vcompress.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vcompress.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x half> @intrinsic_vcompress_vm_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv16f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vcompress.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half> %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret <vscale x 16 x half> %a
}

declare <vscale x 32 x half> @llvm.riscv.vcompress.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x half> @intrinsic_vcompress_vm_nxv32f16_nxv32f16(<vscale x 32 x half> %0, <vscale x 32 x half> %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv32f16_nxv32f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x half> @llvm.riscv.vcompress.nxv32f16(
    <vscale x 32 x half> %0,
    <vscale x 32 x half> %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret <vscale x 32 x half> %a
}

declare <vscale x 1 x float> @llvm.riscv.vcompress.nxv1f32(
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x float> @intrinsic_vcompress_vm_nxv1f32_nxv1f32(<vscale x 1 x float> %0, <vscale x 1 x float> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1f32_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vcompress.nxv1f32(
    <vscale x 1 x float> %0,
    <vscale x 1 x float> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vcompress.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x float> @intrinsic_vcompress_vm_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2f32_nxv2f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vcompress.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vcompress.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x float> @intrinsic_vcompress_vm_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4f32_nxv4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vcompress.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vcompress.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x float> @intrinsic_vcompress_vm_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8f32_nxv8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vcompress.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vcompress.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x float> @intrinsic_vcompress_vm_nxv16f32_nxv16f32(<vscale x 16 x float> %0, <vscale x 16 x float> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv16f32_nxv16f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vcompress.nxv16f32(
    <vscale x 16 x float> %0,
    <vscale x 16 x float> %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret <vscale x 16 x float> %a
}

declare <vscale x 1 x double> @llvm.riscv.vcompress.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x double> @intrinsic_vcompress_vm_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1f64_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vcompress.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vcompress.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x double> @intrinsic_vcompress_vm_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2f64_nxv2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vcompress.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vcompress.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x double> @intrinsic_vcompress_vm_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4f64_nxv4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vcompress.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.vcompress.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x double> @intrinsic_vcompress_vm_nxv8f64_nxv8f64(<vscale x 8 x double> %0, <vscale x 8 x double> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8f64_nxv8f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x double> @llvm.riscv.vcompress.nxv8f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x double> %a
}

declare <vscale x 1 x bfloat> @llvm.riscv.vcompress.nxv1bf16(
  <vscale x 1 x bfloat>,
  <vscale x 1 x bfloat>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x bfloat> @intrinsic_vcompress_vm_nxv1bf16(<vscale x 1 x bfloat> %0, <vscale x 1 x bfloat> %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv1bf16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x bfloat> @llvm.riscv.vcompress.nxv1bf16(
    <vscale x 1 x bfloat> %0,
    <vscale x 1 x bfloat> %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret <vscale x 1 x bfloat> %a
}

declare <vscale x 2 x bfloat> @llvm.riscv.vcompress.nxv2bf16(
  <vscale x 2 x bfloat>,
  <vscale x 2 x bfloat>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x bfloat> @intrinsic_vcompress_vm_nxv2bf16(<vscale x 2 x bfloat> %0, <vscale x 2 x bfloat> %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv2bf16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x bfloat> @llvm.riscv.vcompress.nxv2bf16(
    <vscale x 2 x bfloat> %0,
    <vscale x 2 x bfloat> %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret <vscale x 2 x bfloat> %a
}

declare <vscale x 4 x bfloat> @llvm.riscv.vcompress.nxv4bf16(
  <vscale x 4 x bfloat>,
  <vscale x 4 x bfloat>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x bfloat> @intrinsic_vcompress_vm_nxv4bf16(<vscale x 4 x bfloat> %0, <vscale x 4 x bfloat> %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv4bf16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v9, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x bfloat> @llvm.riscv.vcompress.nxv4bf16(
    <vscale x 4 x bfloat> %0,
    <vscale x 4 x bfloat> %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret <vscale x 4 x bfloat> %a
}

declare <vscale x 8 x bfloat> @llvm.riscv.vcompress.nxv8bf16(
  <vscale x 8 x bfloat>,
  <vscale x 8 x bfloat>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x bfloat> @intrinsic_vcompress_vm_nxv8bf16(<vscale x 8 x bfloat> %0, <vscale x 8 x bfloat> %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv8bf16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v10, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x bfloat> @llvm.riscv.vcompress.nxv8bf16(
    <vscale x 8 x bfloat> %0,
    <vscale x 8 x bfloat> %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret <vscale x 8 x bfloat> %a
}

declare <vscale x 16 x bfloat> @llvm.riscv.vcompress.nxv16bf16(
  <vscale x 16 x bfloat>,
  <vscale x 16 x bfloat>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x bfloat> @intrinsic_vcompress_vm_nxv16bf16(<vscale x 16 x bfloat> %0, <vscale x 16 x bfloat> %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv16bf16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v12, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x bfloat> @llvm.riscv.vcompress.nxv16bf16(
    <vscale x 16 x bfloat> %0,
    <vscale x 16 x bfloat> %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret <vscale x 16 x bfloat> %a
}

declare <vscale x 32 x bfloat> @llvm.riscv.vcompress.nxv32bf16(
  <vscale x 32 x bfloat>,
  <vscale x 32 x bfloat>,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x bfloat> @intrinsic_vcompress_vm_nxv32bf16(<vscale x 32 x bfloat> %0, <vscale x 32 x bfloat> %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vcompress_vm_nxv32bf16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, tu, ma
; CHECK-NEXT:    vcompress.vm v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x bfloat> @llvm.riscv.vcompress.nxv32bf16(
    <vscale x 32 x bfloat> %0,
    <vscale x 32 x bfloat> %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret <vscale x 32 x bfloat> %a
}


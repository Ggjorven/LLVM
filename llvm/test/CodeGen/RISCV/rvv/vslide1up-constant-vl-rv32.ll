; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs \
; RUN:   < %s | FileCheck %s --check-prefixes=CHECK,CHECK-128-65536

; RUN: llc -mtriple=riscv32 -riscv-v-vector-bits-max=512 \
; RUN:   -mattr=+v,+zvl512b -verify-machineinstrs \
; RUN:   < %s | FileCheck %s --check-prefixes=CHECK,CHECK-512

; RUN: llc -mtriple=riscv32 -riscv-v-vector-bits-max=64 \
; RUN:   -mattr=+zve64x,+zvl64b -verify-machineinstrs \
; RUN:   < %s | FileCheck %s --check-prefixes=CHECK,CHECK-64

declare <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  i64,
  i32)

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl1(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 1)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 2)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl3(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl3:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetivli a2, 3, e64, m1, ta, ma
; CHECK-128-65536-NEXT:    slli a2, a2, 1
; CHECK-128-65536-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl3:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli zero, 6, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl3:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 3)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl8(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl8:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetivli a2, 8, e64, m1, ta, ma
; CHECK-128-65536-NEXT:    slli a2, a2, 1
; CHECK-128-65536-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl8:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli zero, 16, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl8:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 8)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl9(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl9:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetivli a2, 9, e64, m1, ta, ma
; CHECK-128-65536-NEXT:    slli a2, a2, 1
; CHECK-128-65536-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl9:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli a2, 9, e64, m1, ta, ma
; CHECK-512-NEXT:    slli a2, a2, 1
; CHECK-512-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl9:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 9)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl15(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl15:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetivli a2, 15, e64, m1, ta, ma
; CHECK-128-65536-NEXT:    slli a2, a2, 1
; CHECK-128-65536-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl15:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli a2, 15, e64, m1, ta, ma
; CHECK-512-NEXT:    slli a2, a2, 1
; CHECK-512-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl15:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 15)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl16(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl16:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetivli a2, 16, e64, m1, ta, ma
; CHECK-128-65536-NEXT:    slli a2, a2, 1
; CHECK-128-65536-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl16:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli zero, 16, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl16:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 16)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2047(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2047:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    li a2, 2047
; CHECK-128-65536-NEXT:    vsetvli a2, a2, e64, m1, ta, ma
; CHECK-128-65536-NEXT:    slli a2, a2, 1
; CHECK-128-65536-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2047:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli zero, 16, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2047:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 2047)

  ret <vscale x 1 x i64> %a
}

define <vscale x 1 x i64> @intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2048(<vscale x 1 x i64> %0, i64 %1) nounwind {
; CHECK-128-65536-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2048:
; CHECK-128-65536:       # %bb.0: # %entry
; CHECK-128-65536-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-128-65536-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-128-65536-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-128-65536-NEXT:    ret
;
; CHECK-512-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2048:
; CHECK-512:       # %bb.0: # %entry
; CHECK-512-NEXT:    vsetivli zero, 16, e32, m1, ta, ma
; CHECK-512-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-512-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-512-NEXT:    ret
;
; CHECK-64-LABEL: intrinsic_vslide1up_vx_nxv1i64_nxv1i64_i64_vl2048:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-64-NEXT:    vslide1up.vx v9, v8, a1
; CHECK-64-NEXT:    vslide1up.vx v8, v9, a0
; CHECK-64-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1up.nxv1i64.i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 2048)

  ret <vscale x 1 x i64> %a
}

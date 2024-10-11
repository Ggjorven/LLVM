; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i8> @insertelt_nxv1i8_0(<vscale x 1 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv1i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i8> %v, i8 %elt, i32 0
  ret <vscale x 1 x i8> %r
}

define <vscale x 1 x i8> @insertelt_nxv1i8_imm(<vscale x 1 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv1i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf8, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i8> %v, i8 %elt, i32 3
  ret <vscale x 1 x i8> %r
}

define <vscale x 1 x i8> @insertelt_nxv1i8_idx(<vscale x 1 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv1i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 1 x i8> %r
}

define <vscale x 2 x i8> @insertelt_nxv2i8_0(<vscale x 2 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv2i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i8> %v, i8 %elt, i32 0
  ret <vscale x 2 x i8> %r
}

define <vscale x 2 x i8> @insertelt_nxv2i8_imm(<vscale x 2 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv2i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i8> %v, i8 %elt, i32 3
  ret <vscale x 2 x i8> %r
}

define <vscale x 2 x i8> @insertelt_nxv2i8_idx(<vscale x 2 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv2i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, mf4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 2 x i8> %r
}

define <vscale x 4 x i8> @insertelt_nxv4i8_0(<vscale x 4 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv4i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i8> %v, i8 %elt, i32 0
  ret <vscale x 4 x i8> %r
}

define <vscale x 4 x i8> @insertelt_nxv4i8_imm(<vscale x 4 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv4i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i8> %v, i8 %elt, i32 3
  ret <vscale x 4 x i8> %r
}

define <vscale x 4 x i8> @insertelt_nxv4i8_idx(<vscale x 4 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv4i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 4 x i8> %r
}

define <vscale x 8 x i8> @insertelt_nxv8i8_0(<vscale x 8 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv8i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i8> %v, i8 %elt, i32 0
  ret <vscale x 8 x i8> %r
}

define <vscale x 8 x i8> @insertelt_nxv8i8_imm(<vscale x 8 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv8i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i8> %v, i8 %elt, i32 3
  ret <vscale x 8 x i8> %r
}

define <vscale x 8 x i8> @insertelt_nxv8i8_idx(<vscale x 8 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv8i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e8, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 8 x i8> %r
}

define <vscale x 16 x i8> @insertelt_nxv16i8_0(<vscale x 16 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv16i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i8> %v, i8 %elt, i32 0
  ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i8> @insertelt_nxv16i8_imm(<vscale x 16 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv16i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i8> %v, i8 %elt, i32 3
  ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i8> @insertelt_nxv16i8_idx(<vscale x 16 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv16i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 16 x i8> %r
}

define <vscale x 32 x i8> @insertelt_nxv32i8_0(<vscale x 32 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv32i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x i8> %v, i8 %elt, i32 0
  ret <vscale x 32 x i8> %r
}

define <vscale x 32 x i8> @insertelt_nxv32i8_imm(<vscale x 32 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv32i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x i8> %v, i8 %elt, i32 3
  ret <vscale x 32 x i8> %r
}

define <vscale x 32 x i8> @insertelt_nxv32i8_idx(<vscale x 32 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv32i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 32 x i8> %r
}

define <vscale x 64 x i8> @insertelt_nxv64i8_0(<vscale x 64 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv64i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 64 x i8> %v, i8 %elt, i32 0
  ret <vscale x 64 x i8> %r
}

define <vscale x 64 x i8> @insertelt_nxv64i8_imm(<vscale x 64 x i8> %v, i8 signext %elt) {
; CHECK-LABEL: insertelt_nxv64i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 64 x i8> %v, i8 %elt, i32 3
  ret <vscale x 64 x i8> %r
}

define <vscale x 64 x i8> @insertelt_nxv64i8_idx(<vscale x 64 x i8> %v, i8 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv64i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 64 x i8> %v, i8 %elt, i32 %idx
  ret <vscale x 64 x i8> %r
}

define <vscale x 1 x i16> @insertelt_nxv1i16_0(<vscale x 1 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv1i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i16> %v, i16 %elt, i32 0
  ret <vscale x 1 x i16> %r
}

define <vscale x 1 x i16> @insertelt_nxv1i16_imm(<vscale x 1 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv1i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf4, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i16> %v, i16 %elt, i32 3
  ret <vscale x 1 x i16> %r
}

define <vscale x 1 x i16> @insertelt_nxv1i16_idx(<vscale x 1 x i16> %v, i16 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv1i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i16> %v, i16 %elt, i32 %idx
  ret <vscale x 1 x i16> %r
}

define <vscale x 2 x i16> @insertelt_nxv2i16_0(<vscale x 2 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv2i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i16> %v, i16 %elt, i32 0
  ret <vscale x 2 x i16> %r
}

define <vscale x 2 x i16> @insertelt_nxv2i16_imm(<vscale x 2 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv2i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i16> %v, i16 %elt, i32 3
  ret <vscale x 2 x i16> %r
}

define <vscale x 2 x i16> @insertelt_nxv2i16_idx(<vscale x 2 x i16> %v, i16 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv2i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i16> %v, i16 %elt, i32 %idx
  ret <vscale x 2 x i16> %r
}

define <vscale x 4 x i16> @insertelt_nxv4i16_0(<vscale x 4 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv4i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i16> %v, i16 %elt, i32 0
  ret <vscale x 4 x i16> %r
}

define <vscale x 4 x i16> @insertelt_nxv4i16_imm(<vscale x 4 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv4i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i16> %v, i16 %elt, i32 3
  ret <vscale x 4 x i16> %r
}

define <vscale x 4 x i16> @insertelt_nxv4i16_idx(<vscale x 4 x i16> %v, i16 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv4i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i16> %v, i16 %elt, i32 %idx
  ret <vscale x 4 x i16> %r
}

define <vscale x 8 x i16> @insertelt_nxv8i16_0(<vscale x 8 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv8i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i16> %v, i16 %elt, i32 0
  ret <vscale x 8 x i16> %r
}

define <vscale x 8 x i16> @insertelt_nxv8i16_imm(<vscale x 8 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv8i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i16> %v, i16 %elt, i32 3
  ret <vscale x 8 x i16> %r
}

define <vscale x 8 x i16> @insertelt_nxv8i16_idx(<vscale x 8 x i16> %v, i16 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv8i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i16> %v, i16 %elt, i32 %idx
  ret <vscale x 8 x i16> %r
}

define <vscale x 16 x i16> @insertelt_nxv16i16_0(<vscale x 16 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv16i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i16> %v, i16 %elt, i32 0
  ret <vscale x 16 x i16> %r
}

define <vscale x 16 x i16> @insertelt_nxv16i16_imm(<vscale x 16 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv16i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i16> %v, i16 %elt, i32 3
  ret <vscale x 16 x i16> %r
}

define <vscale x 16 x i16> @insertelt_nxv16i16_idx(<vscale x 16 x i16> %v, i16 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv16i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i16> %v, i16 %elt, i32 %idx
  ret <vscale x 16 x i16> %r
}

define <vscale x 32 x i16> @insertelt_nxv32i16_0(<vscale x 32 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv32i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x i16> %v, i16 %elt, i32 0
  ret <vscale x 32 x i16> %r
}

define <vscale x 32 x i16> @insertelt_nxv32i16_imm(<vscale x 32 x i16> %v, i16 signext %elt) {
; CHECK-LABEL: insertelt_nxv32i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x i16> %v, i16 %elt, i32 3
  ret <vscale x 32 x i16> %r
}

define <vscale x 32 x i16> @insertelt_nxv32i16_idx(<vscale x 32 x i16> %v, i16 signext %elt, i32 signext %idx) {
; CHECK-LABEL: insertelt_nxv32i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x i16> %v, i16 %elt, i32 %idx
  ret <vscale x 32 x i16> %r
}

define <vscale x 1 x i32> @insertelt_nxv1i32_0(<vscale x 1 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv1i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i32> %v, i32 %elt, i32 0
  ret <vscale x 1 x i32> %r
}

define <vscale x 1 x i32> @insertelt_nxv1i32_imm(<vscale x 1 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv1i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, mf2, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i32> %v, i32 %elt, i32 3
  ret <vscale x 1 x i32> %r
}

define <vscale x 1 x i32> @insertelt_nxv1i32_idx(<vscale x 1 x i32> %v, i32 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv1i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i32> %v, i32 %elt, i32 %idx
  ret <vscale x 1 x i32> %r
}

define <vscale x 2 x i32> @insertelt_nxv2i32_0(<vscale x 2 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i32> %v, i32 %elt, i32 0
  ret <vscale x 2 x i32> %r
}

define <vscale x 2 x i32> @insertelt_nxv2i32_imm(<vscale x 2 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv2i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i32> %v, i32 %elt, i32 3
  ret <vscale x 2 x i32> %r
}

define <vscale x 2 x i32> @insertelt_nxv2i32_idx(<vscale x 2 x i32> %v, i32 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv2i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i32> %v, i32 %elt, i32 %idx
  ret <vscale x 2 x i32> %r
}

define <vscale x 4 x i32> @insertelt_nxv4i32_0(<vscale x 4 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i32> %v, i32 %elt, i32 0
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @insertelt_nxv4i32_imm(<vscale x 4 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv4i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i32> %v, i32 %elt, i32 3
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @insertelt_nxv4i32_idx(<vscale x 4 x i32> %v, i32 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv4i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i32> %v, i32 %elt, i32 %idx
  ret <vscale x 4 x i32> %r
}

define <vscale x 8 x i32> @insertelt_nxv8i32_0(<vscale x 8 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv8i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i32> %v, i32 %elt, i32 0
  ret <vscale x 8 x i32> %r
}

define <vscale x 8 x i32> @insertelt_nxv8i32_imm(<vscale x 8 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv8i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i32> %v, i32 %elt, i32 3
  ret <vscale x 8 x i32> %r
}

define <vscale x 8 x i32> @insertelt_nxv8i32_idx(<vscale x 8 x i32> %v, i32 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv8i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i32> %v, i32 %elt, i32 %idx
  ret <vscale x 8 x i32> %r
}

define <vscale x 16 x i32> @insertelt_nxv16i32_0(<vscale x 16 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv16i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i32> %v, i32 %elt, i32 0
  ret <vscale x 16 x i32> %r
}

define <vscale x 16 x i32> @insertelt_nxv16i32_imm(<vscale x 16 x i32> %v, i32 %elt) {
; CHECK-LABEL: insertelt_nxv16i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i32> %v, i32 %elt, i32 3
  ret <vscale x 16 x i32> %r
}

define <vscale x 16 x i32> @insertelt_nxv16i32_idx(<vscale x 16 x i32> %v, i32 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv16i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    addi a0, a1, 1
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x i32> %v, i32 %elt, i32 %idx
  ret <vscale x 16 x i32> %r
}

define <vscale x 1 x i64> @insertelt_nxv1i64_0(<vscale x 1 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv1i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i64> %v, i64 %elt, i32 0
  ret <vscale x 1 x i64> %r
}

define <vscale x 1 x i64> @insertelt_nxv1i64_imm(<vscale x 1 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv1i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-NEXT:    vslide1down.vx v9, v8, a0
; CHECK-NEXT:    vslide1down.vx v9, v9, a1
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i64> %v, i64 %elt, i32 3
  ret <vscale x 1 x i64> %r
}

define <vscale x 1 x i64> @insertelt_nxv1i64_idx(<vscale x 1 x i64> %v, i64 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv1i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-NEXT:    vslide1down.vx v9, v8, a0
; CHECK-NEXT:    vslide1down.vx v9, v9, a1
; CHECK-NEXT:    addi a0, a2, 1
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a2
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x i64> %v, i64 %elt, i32 %idx
  ret <vscale x 1 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_0(<vscale x 2 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv2i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 %elt, i32 0
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_imm(<vscale x 2 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv2i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m2, ta, ma
; CHECK-NEXT:    vslide1down.vx v10, v8, a0
; CHECK-NEXT:    vslide1down.vx v10, v10, a1
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 %elt, i32 3
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_idx(<vscale x 2 x i64> %v, i64 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv2i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m2, ta, ma
; CHECK-NEXT:    vslide1down.vx v10, v8, a0
; CHECK-NEXT:    vslide1down.vx v10, v10, a1
; CHECK-NEXT:    addi a0, a2, 1
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a2
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 %elt, i32 %idx
  ret <vscale x 2 x i64> %r
}

define <vscale x 4 x i64> @insertelt_nxv4i64_0(<vscale x 4 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv4i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i64> %v, i64 %elt, i32 0
  ret <vscale x 4 x i64> %r
}

define <vscale x 4 x i64> @insertelt_nxv4i64_imm(<vscale x 4 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv4i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m2, ta, ma
; CHECK-NEXT:    vslide1down.vx v12, v8, a0
; CHECK-NEXT:    vslide1down.vx v12, v12, a1
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i64> %v, i64 %elt, i32 3
  ret <vscale x 4 x i64> %r
}

define <vscale x 4 x i64> @insertelt_nxv4i64_idx(<vscale x 4 x i64> %v, i64 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv4i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m4, ta, ma
; CHECK-NEXT:    vslide1down.vx v12, v8, a0
; CHECK-NEXT:    vslide1down.vx v12, v12, a1
; CHECK-NEXT:    addi a0, a2, 1
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a2
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x i64> %v, i64 %elt, i32 %idx
  ret <vscale x 4 x i64> %r
}

define <vscale x 8 x i64> @insertelt_nxv8i64_0(<vscale x 8 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv8i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i64> %v, i64 %elt, i32 0
  ret <vscale x 8 x i64> %r
}

define <vscale x 8 x i64> @insertelt_nxv8i64_imm(<vscale x 8 x i64> %v, i64 %elt) {
; CHECK-LABEL: insertelt_nxv8i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m2, ta, ma
; CHECK-NEXT:    vslide1down.vx v16, v8, a0
; CHECK-NEXT:    vslide1down.vx v16, v16, a1
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i64> %v, i64 %elt, i32 3
  ret <vscale x 8 x i64> %r
}

define <vscale x 8 x i64> @insertelt_nxv8i64_idx(<vscale x 8 x i64> %v, i64 %elt, i32 %idx) {
; CHECK-LABEL: insertelt_nxv8i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m8, ta, ma
; CHECK-NEXT:    vslide1down.vx v16, v8, a0
; CHECK-NEXT:    vslide1down.vx v16, v16, a1
; CHECK-NEXT:    addi a0, a2, 1
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a2
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x i64> %v, i64 %elt, i32 %idx
  ret <vscale x 8 x i64> %r
}

; Extra tests to check lowering of constant values
define <vscale x 2 x i64> @insertelt_nxv2i64_0_c10(<vscale x 2 x i64> %v) {
; CHECK-LABEL: insertelt_nxv2i64_0_c10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 10
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 10, i32 0
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_imm_c10(<vscale x 2 x i64> %v) {
; CHECK-LABEL: insertelt_nxv2i64_imm_c10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 10
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 10, i32 3
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_idx_c10(<vscale x 2 x i64> %v, i32 %idx) {
; CHECK-LABEL: insertelt_nxv2i64_idx_c10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 10
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 10, i32 %idx
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_0_cn1(<vscale x 2 x i64> %v) {
; CHECK-LABEL: insertelt_nxv2i64_0_cn1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, tu, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 -1, i32 0
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_imm_cn1(<vscale x 2 x i64> %v) {
; CHECK-LABEL: insertelt_nxv2i64_imm_cn1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, -1
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 -1, i32 3
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @insertelt_nxv2i64_idx_cn1(<vscale x 2 x i64> %v, i32 %idx) {
; CHECK-LABEL: insertelt_nxv2i64_idx_cn1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, -1
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x i64> %v, i64 -1, i32 %idx
  ret <vscale x 2 x i64> %r
}

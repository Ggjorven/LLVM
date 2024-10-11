; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64

declare <vscale x 1 x i8> @llvm.usub.sat.nxv1i8(<vscale x 1 x i8>, <vscale x 1 x i8>)

define <vscale x 1 x i8> @usub_nxv1i8_vv(<vscale x 1 x i8> %va, <vscale x 1 x i8> %b) {
; CHECK-LABEL: usub_nxv1i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i8> @llvm.usub.sat.nxv1i8(<vscale x 1 x i8> %va, <vscale x 1 x i8> %b)
  ret <vscale x 1 x i8> %v
}

define <vscale x 1 x i8> @usub_nxv1i8_vx(<vscale x 1 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv1i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 1 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 1 x i8> %elt.head, <vscale x 1 x i8> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i8> @llvm.usub.sat.nxv1i8(<vscale x 1 x i8> %va, <vscale x 1 x i8> %vb)
  ret <vscale x 1 x i8> %v
}

define <vscale x 1 x i8> @usub_nxv1i8_vi(<vscale x 1 x i8> %va) {
; CHECK-LABEL: usub_nxv1i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i8> @llvm.usub.sat.nxv1i8(<vscale x 1 x i8> %va, <vscale x 1 x i8> splat (i8 2))
  ret <vscale x 1 x i8> %v
}

declare <vscale x 2 x i8> @llvm.usub.sat.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i8>)

define <vscale x 2 x i8> @usub_nxv2i8_vv(<vscale x 2 x i8> %va, <vscale x 2 x i8> %b) {
; CHECK-LABEL: usub_nxv2i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.usub.sat.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i8> %b)
  ret <vscale x 2 x i8> %v
}

define <vscale x 2 x i8> @usub_nxv2i8_vx(<vscale x 2 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv2i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 2 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 2 x i8> %elt.head, <vscale x 2 x i8> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i8> @llvm.usub.sat.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i8> %vb)
  ret <vscale x 2 x i8> %v
}

define <vscale x 2 x i8> @usub_nxv2i8_vi(<vscale x 2 x i8> %va) {
; CHECK-LABEL: usub_nxv2i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.usub.sat.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i8> splat (i8 2))
  ret <vscale x 2 x i8> %v
}

declare <vscale x 4 x i8> @llvm.usub.sat.nxv4i8(<vscale x 4 x i8>, <vscale x 4 x i8>)

define <vscale x 4 x i8> @usub_nxv4i8_vv(<vscale x 4 x i8> %va, <vscale x 4 x i8> %b) {
; CHECK-LABEL: usub_nxv4i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.usub.sat.nxv4i8(<vscale x 4 x i8> %va, <vscale x 4 x i8> %b)
  ret <vscale x 4 x i8> %v
}

define <vscale x 4 x i8> @usub_nxv4i8_vx(<vscale x 4 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv4i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 4 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 4 x i8> %elt.head, <vscale x 4 x i8> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i8> @llvm.usub.sat.nxv4i8(<vscale x 4 x i8> %va, <vscale x 4 x i8> %vb)
  ret <vscale x 4 x i8> %v
}

define <vscale x 4 x i8> @usub_nxv4i8_vi(<vscale x 4 x i8> %va) {
; CHECK-LABEL: usub_nxv4i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.usub.sat.nxv4i8(<vscale x 4 x i8> %va, <vscale x 4 x i8> splat (i8 2))
  ret <vscale x 4 x i8> %v
}

declare <vscale x 8 x i8> @llvm.usub.sat.nxv8i8(<vscale x 8 x i8>, <vscale x 8 x i8>)

define <vscale x 8 x i8> @usub_nxv8i8_vv(<vscale x 8 x i8> %va, <vscale x 8 x i8> %b) {
; CHECK-LABEL: usub_nxv8i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i8> @llvm.usub.sat.nxv8i8(<vscale x 8 x i8> %va, <vscale x 8 x i8> %b)
  ret <vscale x 8 x i8> %v
}

define <vscale x 8 x i8> @usub_nxv8i8_vx(<vscale x 8 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv8i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 8 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 8 x i8> %elt.head, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i8> @llvm.usub.sat.nxv8i8(<vscale x 8 x i8> %va, <vscale x 8 x i8> %vb)
  ret <vscale x 8 x i8> %v
}

define <vscale x 8 x i8> @usub_nxv8i8_vi(<vscale x 8 x i8> %va) {
; CHECK-LABEL: usub_nxv8i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i8> @llvm.usub.sat.nxv8i8(<vscale x 8 x i8> %va, <vscale x 8 x i8> splat (i8 2))
  ret <vscale x 8 x i8> %v
}

declare <vscale x 16 x i8> @llvm.usub.sat.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)

define <vscale x 16 x i8> @usub_nxv16i8_vv(<vscale x 16 x i8> %va, <vscale x 16 x i8> %b) {
; CHECK-LABEL: usub_nxv16i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.usub.sat.nxv16i8(<vscale x 16 x i8> %va, <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @usub_nxv16i8_vx(<vscale x 16 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv16i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 16 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 16 x i8> %elt.head, <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i8> @llvm.usub.sat.nxv16i8(<vscale x 16 x i8> %va, <vscale x 16 x i8> %vb)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @usub_nxv16i8_vi(<vscale x 16 x i8> %va) {
; CHECK-LABEL: usub_nxv16i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.usub.sat.nxv16i8(<vscale x 16 x i8> %va, <vscale x 16 x i8> splat (i8 2))
  ret <vscale x 16 x i8> %v
}

declare <vscale x 32 x i8> @llvm.usub.sat.nxv32i8(<vscale x 32 x i8>, <vscale x 32 x i8>)

define <vscale x 32 x i8> @usub_nxv32i8_vv(<vscale x 32 x i8> %va, <vscale x 32 x i8> %b) {
; CHECK-LABEL: usub_nxv32i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i8> @llvm.usub.sat.nxv32i8(<vscale x 32 x i8> %va, <vscale x 32 x i8> %b)
  ret <vscale x 32 x i8> %v
}

define <vscale x 32 x i8> @usub_nxv32i8_vx(<vscale x 32 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv32i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 32 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 32 x i8> %elt.head, <vscale x 32 x i8> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x i8> @llvm.usub.sat.nxv32i8(<vscale x 32 x i8> %va, <vscale x 32 x i8> %vb)
  ret <vscale x 32 x i8> %v
}

define <vscale x 32 x i8> @usub_nxv32i8_vi(<vscale x 32 x i8> %va) {
; CHECK-LABEL: usub_nxv32i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i8> @llvm.usub.sat.nxv32i8(<vscale x 32 x i8> %va, <vscale x 32 x i8> splat (i8 2))
  ret <vscale x 32 x i8> %v
}

declare <vscale x 64 x i8> @llvm.usub.sat.nxv64i8(<vscale x 64 x i8>, <vscale x 64 x i8>)

define <vscale x 64 x i8> @usub_nxv64i8_vv(<vscale x 64 x i8> %va, <vscale x 64 x i8> %b) {
; CHECK-LABEL: usub_nxv64i8_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i8> @llvm.usub.sat.nxv64i8(<vscale x 64 x i8> %va, <vscale x 64 x i8> %b)
  ret <vscale x 64 x i8> %v
}

define <vscale x 64 x i8> @usub_nxv64i8_vx(<vscale x 64 x i8> %va, i8 %b) {
; CHECK-LABEL: usub_nxv64i8_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 64 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <vscale x 64 x i8> %elt.head, <vscale x 64 x i8> poison, <vscale x 64 x i32> zeroinitializer
  %v = call <vscale x 64 x i8> @llvm.usub.sat.nxv64i8(<vscale x 64 x i8> %va, <vscale x 64 x i8> %vb)
  ret <vscale x 64 x i8> %v
}

define <vscale x 64 x i8> @usub_nxv64i8_vi(<vscale x 64 x i8> %va) {
; CHECK-LABEL: usub_nxv64i8_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i8> @llvm.usub.sat.nxv64i8(<vscale x 64 x i8> %va, <vscale x 64 x i8> splat (i8 2))
  ret <vscale x 64 x i8> %v
}

declare <vscale x 1 x i16> @llvm.usub.sat.nxv1i16(<vscale x 1 x i16>, <vscale x 1 x i16>)

define <vscale x 1 x i16> @usub_nxv1i16_vv(<vscale x 1 x i16> %va, <vscale x 1 x i16> %b) {
; CHECK-LABEL: usub_nxv1i16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i16> @llvm.usub.sat.nxv1i16(<vscale x 1 x i16> %va, <vscale x 1 x i16> %b)
  ret <vscale x 1 x i16> %v
}

define <vscale x 1 x i16> @usub_nxv1i16_vx(<vscale x 1 x i16> %va, i16 %b) {
; CHECK-LABEL: usub_nxv1i16_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 1 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <vscale x 1 x i16> %elt.head, <vscale x 1 x i16> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i16> @llvm.usub.sat.nxv1i16(<vscale x 1 x i16> %va, <vscale x 1 x i16> %vb)
  ret <vscale x 1 x i16> %v
}

define <vscale x 1 x i16> @usub_nxv1i16_vi(<vscale x 1 x i16> %va) {
; CHECK-LABEL: usub_nxv1i16_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i16> @llvm.usub.sat.nxv1i16(<vscale x 1 x i16> %va, <vscale x 1 x i16> splat (i16 2))
  ret <vscale x 1 x i16> %v
}

declare <vscale x 2 x i16> @llvm.usub.sat.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i16>)

define <vscale x 2 x i16> @usub_nxv2i16_vv(<vscale x 2 x i16> %va, <vscale x 2 x i16> %b) {
; CHECK-LABEL: usub_nxv2i16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.usub.sat.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i16> %b)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @usub_nxv2i16_vx(<vscale x 2 x i16> %va, i16 %b) {
; CHECK-LABEL: usub_nxv2i16_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 2 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <vscale x 2 x i16> %elt.head, <vscale x 2 x i16> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i16> @llvm.usub.sat.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i16> %vb)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @usub_nxv2i16_vi(<vscale x 2 x i16> %va) {
; CHECK-LABEL: usub_nxv2i16_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.usub.sat.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i16> splat (i16 2))
  ret <vscale x 2 x i16> %v
}

declare <vscale x 4 x i16> @llvm.usub.sat.nxv4i16(<vscale x 4 x i16>, <vscale x 4 x i16>)

define <vscale x 4 x i16> @usub_nxv4i16_vv(<vscale x 4 x i16> %va, <vscale x 4 x i16> %b) {
; CHECK-LABEL: usub_nxv4i16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i16> @llvm.usub.sat.nxv4i16(<vscale x 4 x i16> %va, <vscale x 4 x i16> %b)
  ret <vscale x 4 x i16> %v
}

define <vscale x 4 x i16> @usub_nxv4i16_vx(<vscale x 4 x i16> %va, i16 %b) {
; CHECK-LABEL: usub_nxv4i16_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 4 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <vscale x 4 x i16> %elt.head, <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i16> @llvm.usub.sat.nxv4i16(<vscale x 4 x i16> %va, <vscale x 4 x i16> %vb)
  ret <vscale x 4 x i16> %v
}

define <vscale x 4 x i16> @usub_nxv4i16_vi(<vscale x 4 x i16> %va) {
; CHECK-LABEL: usub_nxv4i16_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i16> @llvm.usub.sat.nxv4i16(<vscale x 4 x i16> %va, <vscale x 4 x i16> splat (i16 2))
  ret <vscale x 4 x i16> %v
}

declare <vscale x 8 x i16> @llvm.usub.sat.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)

define <vscale x 8 x i16> @usub_nxv8i16_vv(<vscale x 8 x i16> %va, <vscale x 8 x i16> %b) {
; CHECK-LABEL: usub_nxv8i16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i16> @llvm.usub.sat.nxv8i16(<vscale x 8 x i16> %va, <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %v
}

define <vscale x 8 x i16> @usub_nxv8i16_vx(<vscale x 8 x i16> %va, i16 %b) {
; CHECK-LABEL: usub_nxv8i16_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 8 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <vscale x 8 x i16> %elt.head, <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i16> @llvm.usub.sat.nxv8i16(<vscale x 8 x i16> %va, <vscale x 8 x i16> %vb)
  ret <vscale x 8 x i16> %v
}

define <vscale x 8 x i16> @usub_nxv8i16_vi(<vscale x 8 x i16> %va) {
; CHECK-LABEL: usub_nxv8i16_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i16> @llvm.usub.sat.nxv8i16(<vscale x 8 x i16> %va, <vscale x 8 x i16> splat (i16 2))
  ret <vscale x 8 x i16> %v
}

declare <vscale x 16 x i16> @llvm.usub.sat.nxv16i16(<vscale x 16 x i16>, <vscale x 16 x i16>)

define <vscale x 16 x i16> @usub_nxv16i16_vv(<vscale x 16 x i16> %va, <vscale x 16 x i16> %b) {
; CHECK-LABEL: usub_nxv16i16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i16> @llvm.usub.sat.nxv16i16(<vscale x 16 x i16> %va, <vscale x 16 x i16> %b)
  ret <vscale x 16 x i16> %v
}

define <vscale x 16 x i16> @usub_nxv16i16_vx(<vscale x 16 x i16> %va, i16 %b) {
; CHECK-LABEL: usub_nxv16i16_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 16 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <vscale x 16 x i16> %elt.head, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i16> @llvm.usub.sat.nxv16i16(<vscale x 16 x i16> %va, <vscale x 16 x i16> %vb)
  ret <vscale x 16 x i16> %v
}

define <vscale x 16 x i16> @usub_nxv16i16_vi(<vscale x 16 x i16> %va) {
; CHECK-LABEL: usub_nxv16i16_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i16> @llvm.usub.sat.nxv16i16(<vscale x 16 x i16> %va, <vscale x 16 x i16> splat (i16 2))
  ret <vscale x 16 x i16> %v
}

declare <vscale x 32 x i16> @llvm.usub.sat.nxv32i16(<vscale x 32 x i16>, <vscale x 32 x i16>)

define <vscale x 32 x i16> @usub_nxv32i16_vv(<vscale x 32 x i16> %va, <vscale x 32 x i16> %b) {
; CHECK-LABEL: usub_nxv32i16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.usub.sat.nxv32i16(<vscale x 32 x i16> %va, <vscale x 32 x i16> %b)
  ret <vscale x 32 x i16> %v
}

define <vscale x 32 x i16> @usub_nxv32i16_vx(<vscale x 32 x i16> %va, i16 %b) {
; CHECK-LABEL: usub_nxv32i16_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 32 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <vscale x 32 x i16> %elt.head, <vscale x 32 x i16> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x i16> @llvm.usub.sat.nxv32i16(<vscale x 32 x i16> %va, <vscale x 32 x i16> %vb)
  ret <vscale x 32 x i16> %v
}

define <vscale x 32 x i16> @usub_nxv32i16_vi(<vscale x 32 x i16> %va) {
; CHECK-LABEL: usub_nxv32i16_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e16, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.usub.sat.nxv32i16(<vscale x 32 x i16> %va, <vscale x 32 x i16> splat (i16 2))
  ret <vscale x 32 x i16> %v
}

declare <vscale x 1 x i32> @llvm.usub.sat.nxv1i32(<vscale x 1 x i32>, <vscale x 1 x i32>)

define <vscale x 1 x i32> @usub_nxv1i32_vv(<vscale x 1 x i32> %va, <vscale x 1 x i32> %b) {
; CHECK-LABEL: usub_nxv1i32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i32> @llvm.usub.sat.nxv1i32(<vscale x 1 x i32> %va, <vscale x 1 x i32> %b)
  ret <vscale x 1 x i32> %v
}

define <vscale x 1 x i32> @usub_nxv1i32_vx(<vscale x 1 x i32> %va, i32 %b) {
; CHECK-LABEL: usub_nxv1i32_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 1 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <vscale x 1 x i32> %elt.head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i32> @llvm.usub.sat.nxv1i32(<vscale x 1 x i32> %va, <vscale x 1 x i32> %vb)
  ret <vscale x 1 x i32> %v
}

define <vscale x 1 x i32> @usub_nxv1i32_vi(<vscale x 1 x i32> %va) {
; CHECK-LABEL: usub_nxv1i32_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i32> @llvm.usub.sat.nxv1i32(<vscale x 1 x i32> %va, <vscale x 1 x i32> splat (i32 2))
  ret <vscale x 1 x i32> %v
}

declare <vscale x 2 x i32> @llvm.usub.sat.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i32>)

define <vscale x 2 x i32> @usub_nxv2i32_vv(<vscale x 2 x i32> %va, <vscale x 2 x i32> %b) {
; CHECK-LABEL: usub_nxv2i32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.usub.sat.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i32> %b)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @usub_nxv2i32_vx(<vscale x 2 x i32> %va, i32 %b) {
; CHECK-LABEL: usub_nxv2i32_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 2 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <vscale x 2 x i32> %elt.head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i32> @llvm.usub.sat.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i32> %vb)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @usub_nxv2i32_vi(<vscale x 2 x i32> %va) {
; CHECK-LABEL: usub_nxv2i32_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.usub.sat.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i32> splat (i32 2))
  ret <vscale x 2 x i32> %v
}

declare <vscale x 4 x i32> @llvm.usub.sat.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)

define <vscale x 4 x i32> @usub_nxv4i32_vv(<vscale x 4 x i32> %va, <vscale x 4 x i32> %b) {
; CHECK-LABEL: usub_nxv4i32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.usub.sat.nxv4i32(<vscale x 4 x i32> %va, <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %v
}

define <vscale x 4 x i32> @usub_nxv4i32_vx(<vscale x 4 x i32> %va, i32 %b) {
; CHECK-LABEL: usub_nxv4i32_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 4 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <vscale x 4 x i32> %elt.head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i32> @llvm.usub.sat.nxv4i32(<vscale x 4 x i32> %va, <vscale x 4 x i32> %vb)
  ret <vscale x 4 x i32> %v
}

define <vscale x 4 x i32> @usub_nxv4i32_vi(<vscale x 4 x i32> %va) {
; CHECK-LABEL: usub_nxv4i32_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.usub.sat.nxv4i32(<vscale x 4 x i32> %va, <vscale x 4 x i32> splat (i32 2))
  ret <vscale x 4 x i32> %v
}

declare <vscale x 8 x i32> @llvm.usub.sat.nxv8i32(<vscale x 8 x i32>, <vscale x 8 x i32>)

define <vscale x 8 x i32> @usub_nxv8i32_vv(<vscale x 8 x i32> %va, <vscale x 8 x i32> %b) {
; CHECK-LABEL: usub_nxv8i32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.usub.sat.nxv8i32(<vscale x 8 x i32> %va, <vscale x 8 x i32> %b)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @usub_nxv8i32_vx(<vscale x 8 x i32> %va, i32 %b) {
; CHECK-LABEL: usub_nxv8i32_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 8 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <vscale x 8 x i32> %elt.head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i32> @llvm.usub.sat.nxv8i32(<vscale x 8 x i32> %va, <vscale x 8 x i32> %vb)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @usub_nxv8i32_vi(<vscale x 8 x i32> %va) {
; CHECK-LABEL: usub_nxv8i32_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.usub.sat.nxv8i32(<vscale x 8 x i32> %va, <vscale x 8 x i32> splat (i32 2))
  ret <vscale x 8 x i32> %v
}

declare <vscale x 16 x i32> @llvm.usub.sat.nxv16i32(<vscale x 16 x i32>, <vscale x 16 x i32>)

define <vscale x 16 x i32> @usub_nxv16i32_vv(<vscale x 16 x i32> %va, <vscale x 16 x i32> %b) {
; CHECK-LABEL: usub_nxv16i32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.usub.sat.nxv16i32(<vscale x 16 x i32> %va, <vscale x 16 x i32> %b)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @usub_nxv16i32_vx(<vscale x 16 x i32> %va, i32 %b) {
; CHECK-LABEL: usub_nxv16i32_vx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <vscale x 16 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <vscale x 16 x i32> %elt.head, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i32> @llvm.usub.sat.nxv16i32(<vscale x 16 x i32> %va, <vscale x 16 x i32> %vb)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @usub_nxv16i32_vi(<vscale x 16 x i32> %va) {
; CHECK-LABEL: usub_nxv16i32_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e32, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.usub.sat.nxv16i32(<vscale x 16 x i32> %va, <vscale x 16 x i32> splat (i32 2))
  ret <vscale x 16 x i32> %v
}

declare <vscale x 1 x i64> @llvm.usub.sat.nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>)

define <vscale x 1 x i64> @usub_nxv1i64_vv(<vscale x 1 x i64> %va, <vscale x 1 x i64> %b) {
; CHECK-LABEL: usub_nxv1i64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.usub.sat.nxv1i64(<vscale x 1 x i64> %va, <vscale x 1 x i64> %b)
  ret <vscale x 1 x i64> %v
}

define <vscale x 1 x i64> @usub_nxv1i64_vx(<vscale x 1 x i64> %va, i64 %b) {
; RV32-LABEL: usub_nxv1i64_vx:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV32-NEXT:    vlse64.v v9, (a0), zero
; RV32-NEXT:    vssubu.vv v8, v8, v9
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: usub_nxv1i64_vx:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV64-NEXT:    vssubu.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <vscale x 1 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <vscale x 1 x i64> %elt.head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i64> @llvm.usub.sat.nxv1i64(<vscale x 1 x i64> %va, <vscale x 1 x i64> %vb)
  ret <vscale x 1 x i64> %v
}

define <vscale x 1 x i64> @usub_nxv1i64_vi(<vscale x 1 x i64> %va) {
; CHECK-LABEL: usub_nxv1i64_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.usub.sat.nxv1i64(<vscale x 1 x i64> %va, <vscale x 1 x i64> splat (i64 2))
  ret <vscale x 1 x i64> %v
}

declare <vscale x 2 x i64> @llvm.usub.sat.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

define <vscale x 2 x i64> @usub_nxv2i64_vv(<vscale x 2 x i64> %va, <vscale x 2 x i64> %b) {
; CHECK-LABEL: usub_nxv2i64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.usub.sat.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @usub_nxv2i64_vx(<vscale x 2 x i64> %va, i64 %b) {
; RV32-LABEL: usub_nxv2i64_vx:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV32-NEXT:    vlse64.v v10, (a0), zero
; RV32-NEXT:    vssubu.vv v8, v8, v10
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: usub_nxv2i64_vx:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV64-NEXT:    vssubu.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <vscale x 2 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <vscale x 2 x i64> %elt.head, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i64> @llvm.usub.sat.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i64> %vb)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @usub_nxv2i64_vi(<vscale x 2 x i64> %va) {
; CHECK-LABEL: usub_nxv2i64_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.usub.sat.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i64> splat (i64 2))
  ret <vscale x 2 x i64> %v
}

declare <vscale x 4 x i64> @llvm.usub.sat.nxv4i64(<vscale x 4 x i64>, <vscale x 4 x i64>)

define <vscale x 4 x i64> @usub_nxv4i64_vv(<vscale x 4 x i64> %va, <vscale x 4 x i64> %b) {
; CHECK-LABEL: usub_nxv4i64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i64> @llvm.usub.sat.nxv4i64(<vscale x 4 x i64> %va, <vscale x 4 x i64> %b)
  ret <vscale x 4 x i64> %v
}

define <vscale x 4 x i64> @usub_nxv4i64_vx(<vscale x 4 x i64> %va, i64 %b) {
; RV32-LABEL: usub_nxv4i64_vx:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v12, (a0), zero
; RV32-NEXT:    vssubu.vv v8, v8, v12
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: usub_nxv4i64_vx:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV64-NEXT:    vssubu.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <vscale x 4 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <vscale x 4 x i64> %elt.head, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i64> @llvm.usub.sat.nxv4i64(<vscale x 4 x i64> %va, <vscale x 4 x i64> %vb)
  ret <vscale x 4 x i64> %v
}

define <vscale x 4 x i64> @usub_nxv4i64_vi(<vscale x 4 x i64> %va) {
; CHECK-LABEL: usub_nxv4i64_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i64> @llvm.usub.sat.nxv4i64(<vscale x 4 x i64> %va, <vscale x 4 x i64> splat (i64 2))
  ret <vscale x 4 x i64> %v
}

declare <vscale x 8 x i64> @llvm.usub.sat.nxv8i64(<vscale x 8 x i64>, <vscale x 8 x i64>)

define <vscale x 8 x i64> @usub_nxv8i64_vv(<vscale x 8 x i64> %va, <vscale x 8 x i64> %b) {
; CHECK-LABEL: usub_nxv8i64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vssubu.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i64> @llvm.usub.sat.nxv8i64(<vscale x 8 x i64> %va, <vscale x 8 x i64> %b)
  ret <vscale x 8 x i64> %v
}

define <vscale x 8 x i64> @usub_nxv8i64_vx(<vscale x 8 x i64> %va, i64 %b) {
; RV32-LABEL: usub_nxv8i64_vx:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vssubu.vv v8, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: usub_nxv8i64_vx:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vssubu.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <vscale x 8 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <vscale x 8 x i64> %elt.head, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i64> @llvm.usub.sat.nxv8i64(<vscale x 8 x i64> %va, <vscale x 8 x i64> %vb)
  ret <vscale x 8 x i64> %v
}

define <vscale x 8 x i64> @usub_nxv8i64_vi(<vscale x 8 x i64> %va) {
; CHECK-LABEL: usub_nxv8i64_vi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; CHECK-NEXT:    vssubu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i64> @llvm.usub.sat.nxv8i64(<vscale x 8 x i64> %va, <vscale x 8 x i64> splat (i64 2))
  ret <vscale x 8 x i64> %v
}

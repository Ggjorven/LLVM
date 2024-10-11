; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64

declare <8 x i7> @llvm.vp.sdiv.v8i7(<8 x i7>, <8 x i7>, <8 x i1>, i32)

define <8 x i7> @vdiv_vv_v8i7(<8 x i7> %va, <8 x i7> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vsll.vi v9, v9, 1, v0.t
; CHECK-NEXT:    vsra.vi v9, v9, 1, v0.t
; CHECK-NEXT:    vsll.vi v8, v8, 1, v0.t
; CHECK-NEXT:    vsra.vi v8, v8, 1, v0.t
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x i7> @llvm.vp.sdiv.v8i7(<8 x i7> %va, <8 x i7> %b, <8 x i1> %m, i32 %evl)
  ret <8 x i7> %v
}

declare <2 x i8> @llvm.vp.sdiv.v2i8(<2 x i8>, <2 x i8>, <2 x i1>, i32)

define <2 x i8> @vdiv_vv_v2i8(<2 x i8> %va, <2 x i8> %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.sdiv.v2i8(<2 x i8> %va, <2 x i8> %b, <2 x i1> %m, i32 %evl)
  ret <2 x i8> %v
}

define <2 x i8> @vdiv_vv_v2i8_unmasked(<2 x i8> %va, <2 x i8> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.sdiv.v2i8(<2 x i8> %va, <2 x i8> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i8> %v
}

define <2 x i8> @vdiv_vx_v2i8(<2 x i8> %va, i8 %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <2 x i8> %elt.head, <2 x i8> poison, <2 x i32> zeroinitializer
  %v = call <2 x i8> @llvm.vp.sdiv.v2i8(<2 x i8> %va, <2 x i8> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x i8> %v
}

define <2 x i8> @vdiv_vx_v2i8_unmasked(<2 x i8> %va, i8 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <2 x i8> %elt.head, <2 x i8> poison, <2 x i32> zeroinitializer
  %v = call <2 x i8> @llvm.vp.sdiv.v2i8(<2 x i8> %va, <2 x i8> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i8> %v
}

declare <4 x i8> @llvm.vp.sdiv.v4i8(<4 x i8>, <4 x i8>, <4 x i1>, i32)

define <4 x i8> @vdiv_vv_v4i8(<4 x i8> %va, <4 x i8> %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.vp.sdiv.v4i8(<4 x i8> %va, <4 x i8> %b, <4 x i1> %m, i32 %evl)
  ret <4 x i8> %v
}

define <4 x i8> @vdiv_vv_v4i8_unmasked(<4 x i8> %va, <4 x i8> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.vp.sdiv.v4i8(<4 x i8> %va, <4 x i8> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i8> %v
}

define <4 x i8> @vdiv_vx_v4i8(<4 x i8> %va, i8 %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <4 x i8> %elt.head, <4 x i8> poison, <4 x i32> zeroinitializer
  %v = call <4 x i8> @llvm.vp.sdiv.v4i8(<4 x i8> %va, <4 x i8> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x i8> %v
}

define <4 x i8> @vdiv_vx_v4i8_unmasked(<4 x i8> %va, i8 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v4i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <4 x i8> %elt.head, <4 x i8> poison, <4 x i32> zeroinitializer
  %v = call <4 x i8> @llvm.vp.sdiv.v4i8(<4 x i8> %va, <4 x i8> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i8> %v
}

declare <6 x i8> @llvm.vp.sdiv.v6i8(<6 x i8>, <6 x i8>, <6 x i1>, i32)

define <6 x i8> @vdiv_vv_v6i8(<6 x i8> %va, <6 x i8> %b, <6 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v6i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <6 x i8> @llvm.vp.sdiv.v6i8(<6 x i8> %va, <6 x i8> %b, <6 x i1> %m, i32 %evl)
  ret <6 x i8> %v
}

declare <8 x i8> @llvm.vp.sdiv.v8i8(<8 x i8>, <8 x i8>, <8 x i1>, i32)

define <8 x i8> @vdiv_vv_v8i8(<8 x i8> %va, <8 x i8> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x i8> @llvm.vp.sdiv.v8i8(<8 x i8> %va, <8 x i8> %b, <8 x i1> %m, i32 %evl)
  ret <8 x i8> %v
}

define <8 x i8> @vdiv_vv_v8i8_unmasked(<8 x i8> %va, <8 x i8> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <8 x i8> @llvm.vp.sdiv.v8i8(<8 x i8> %va, <8 x i8> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i8> %v
}

define <8 x i8> @vdiv_vx_v8i8(<8 x i8> %va, i8 %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <8 x i8> %elt.head, <8 x i8> poison, <8 x i32> zeroinitializer
  %v = call <8 x i8> @llvm.vp.sdiv.v8i8(<8 x i8> %va, <8 x i8> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x i8> %v
}

define <8 x i8> @vdiv_vx_v8i8_unmasked(<8 x i8> %va, i8 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v8i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <8 x i8> %elt.head, <8 x i8> poison, <8 x i32> zeroinitializer
  %v = call <8 x i8> @llvm.vp.sdiv.v8i8(<8 x i8> %va, <8 x i8> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i8> %v
}

declare <16 x i8> @llvm.vp.sdiv.v16i8(<16 x i8>, <16 x i8>, <16 x i1>, i32)

define <16 x i8> @vdiv_vv_v16i8(<16 x i8> %va, <16 x i8> %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x i8> @llvm.vp.sdiv.v16i8(<16 x i8> %va, <16 x i8> %b, <16 x i1> %m, i32 %evl)
  ret <16 x i8> %v
}

define <16 x i8> @vdiv_vv_v16i8_unmasked(<16 x i8> %va, <16 x i8> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <16 x i8> @llvm.vp.sdiv.v16i8(<16 x i8> %va, <16 x i8> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i8> %v
}

define <16 x i8> @vdiv_vx_v16i8(<16 x i8> %va, i8 %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <16 x i8> %elt.head, <16 x i8> poison, <16 x i32> zeroinitializer
  %v = call <16 x i8> @llvm.vp.sdiv.v16i8(<16 x i8> %va, <16 x i8> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x i8> %v
}

define <16 x i8> @vdiv_vx_v16i8_unmasked(<16 x i8> %va, i8 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v16i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x i8> poison, i8 %b, i32 0
  %vb = shufflevector <16 x i8> %elt.head, <16 x i8> poison, <16 x i32> zeroinitializer
  %v = call <16 x i8> @llvm.vp.sdiv.v16i8(<16 x i8> %va, <16 x i8> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i8> %v
}

declare <2 x i16> @llvm.vp.sdiv.v2i16(<2 x i16>, <2 x i16>, <2 x i1>, i32)

define <2 x i16> @vdiv_vv_v2i16(<2 x i16> %va, <2 x i16> %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.sdiv.v2i16(<2 x i16> %va, <2 x i16> %b, <2 x i1> %m, i32 %evl)
  ret <2 x i16> %v
}

define <2 x i16> @vdiv_vv_v2i16_unmasked(<2 x i16> %va, <2 x i16> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.sdiv.v2i16(<2 x i16> %va, <2 x i16> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i16> %v
}

define <2 x i16> @vdiv_vx_v2i16(<2 x i16> %va, i16 %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <2 x i16> %elt.head, <2 x i16> poison, <2 x i32> zeroinitializer
  %v = call <2 x i16> @llvm.vp.sdiv.v2i16(<2 x i16> %va, <2 x i16> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x i16> %v
}

define <2 x i16> @vdiv_vx_v2i16_unmasked(<2 x i16> %va, i16 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <2 x i16> %elt.head, <2 x i16> poison, <2 x i32> zeroinitializer
  %v = call <2 x i16> @llvm.vp.sdiv.v2i16(<2 x i16> %va, <2 x i16> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i16> %v
}

declare <4 x i16> @llvm.vp.sdiv.v4i16(<4 x i16>, <4 x i16>, <4 x i1>, i32)

define <4 x i16> @vdiv_vv_v4i16(<4 x i16> %va, <4 x i16> %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.sdiv.v4i16(<4 x i16> %va, <4 x i16> %b, <4 x i1> %m, i32 %evl)
  ret <4 x i16> %v
}

define <4 x i16> @vdiv_vv_v4i16_unmasked(<4 x i16> %va, <4 x i16> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.sdiv.v4i16(<4 x i16> %va, <4 x i16> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i16> %v
}

define <4 x i16> @vdiv_vx_v4i16(<4 x i16> %va, i16 %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <4 x i16> %elt.head, <4 x i16> poison, <4 x i32> zeroinitializer
  %v = call <4 x i16> @llvm.vp.sdiv.v4i16(<4 x i16> %va, <4 x i16> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x i16> %v
}

define <4 x i16> @vdiv_vx_v4i16_unmasked(<4 x i16> %va, i16 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v4i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <4 x i16> %elt.head, <4 x i16> poison, <4 x i32> zeroinitializer
  %v = call <4 x i16> @llvm.vp.sdiv.v4i16(<4 x i16> %va, <4 x i16> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i16> %v
}

declare <8 x i16> @llvm.vp.sdiv.v8i16(<8 x i16>, <8 x i16>, <8 x i1>, i32)

define <8 x i16> @vdiv_vv_v8i16(<8 x i16> %va, <8 x i16> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x i16> @llvm.vp.sdiv.v8i16(<8 x i16> %va, <8 x i16> %b, <8 x i1> %m, i32 %evl)
  ret <8 x i16> %v
}

define <8 x i16> @vdiv_vv_v8i16_unmasked(<8 x i16> %va, <8 x i16> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <8 x i16> @llvm.vp.sdiv.v8i16(<8 x i16> %va, <8 x i16> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i16> %v
}

define <8 x i16> @vdiv_vx_v8i16(<8 x i16> %va, i16 %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <8 x i16> %elt.head, <8 x i16> poison, <8 x i32> zeroinitializer
  %v = call <8 x i16> @llvm.vp.sdiv.v8i16(<8 x i16> %va, <8 x i16> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x i16> %v
}

define <8 x i16> @vdiv_vx_v8i16_unmasked(<8 x i16> %va, i16 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v8i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <8 x i16> %elt.head, <8 x i16> poison, <8 x i32> zeroinitializer
  %v = call <8 x i16> @llvm.vp.sdiv.v8i16(<8 x i16> %va, <8 x i16> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i16> %v
}

declare <16 x i16> @llvm.vp.sdiv.v16i16(<16 x i16>, <16 x i16>, <16 x i1>, i32)

define <16 x i16> @vdiv_vv_v16i16(<16 x i16> %va, <16 x i16> %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x i16> @llvm.vp.sdiv.v16i16(<16 x i16> %va, <16 x i16> %b, <16 x i1> %m, i32 %evl)
  ret <16 x i16> %v
}

define <16 x i16> @vdiv_vv_v16i16_unmasked(<16 x i16> %va, <16 x i16> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <16 x i16> @llvm.vp.sdiv.v16i16(<16 x i16> %va, <16 x i16> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i16> %v
}

define <16 x i16> @vdiv_vx_v16i16(<16 x i16> %va, i16 %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <16 x i16> %elt.head, <16 x i16> poison, <16 x i32> zeroinitializer
  %v = call <16 x i16> @llvm.vp.sdiv.v16i16(<16 x i16> %va, <16 x i16> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x i16> %v
}

define <16 x i16> @vdiv_vx_v16i16_unmasked(<16 x i16> %va, i16 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v16i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x i16> poison, i16 %b, i32 0
  %vb = shufflevector <16 x i16> %elt.head, <16 x i16> poison, <16 x i32> zeroinitializer
  %v = call <16 x i16> @llvm.vp.sdiv.v16i16(<16 x i16> %va, <16 x i16> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i16> %v
}

declare <2 x i32> @llvm.vp.sdiv.v2i32(<2 x i32>, <2 x i32>, <2 x i1>, i32)

define <2 x i32> @vdiv_vv_v2i32(<2 x i32> %va, <2 x i32> %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.vp.sdiv.v2i32(<2 x i32> %va, <2 x i32> %b, <2 x i1> %m, i32 %evl)
  ret <2 x i32> %v
}

define <2 x i32> @vdiv_vv_v2i32_unmasked(<2 x i32> %va, <2 x i32> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.vp.sdiv.v2i32(<2 x i32> %va, <2 x i32> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i32> %v
}

define <2 x i32> @vdiv_vx_v2i32(<2 x i32> %va, i32 %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <2 x i32> %elt.head, <2 x i32> poison, <2 x i32> zeroinitializer
  %v = call <2 x i32> @llvm.vp.sdiv.v2i32(<2 x i32> %va, <2 x i32> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x i32> %v
}

define <2 x i32> @vdiv_vx_v2i32_unmasked(<2 x i32> %va, i32 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <2 x i32> %elt.head, <2 x i32> poison, <2 x i32> zeroinitializer
  %v = call <2 x i32> @llvm.vp.sdiv.v2i32(<2 x i32> %va, <2 x i32> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i32> %v
}

declare <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vdiv_vv_v4i32(<4 x i32> %va, <4 x i32> %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32> %va, <4 x i32> %b, <4 x i1> %m, i32 %evl)
  ret <4 x i32> %v
}

define <4 x i32> @vdiv_vv_v4i32_unmasked(<4 x i32> %va, <4 x i32> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32> %va, <4 x i32> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i32> %v
}

define <4 x i32> @vdiv_vx_v4i32(<4 x i32> %va, i32 %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <4 x i32> %elt.head, <4 x i32> poison, <4 x i32> zeroinitializer
  %v = call <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x i32> %v
}

define <4 x i32> @vdiv_vx_v4i32_unmasked(<4 x i32> %va, i32 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v4i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <4 x i32> %elt.head, <4 x i32> poison, <4 x i32> zeroinitializer
  %v = call <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i32> %v
}

declare <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32>, <8 x i32>, <8 x i1>, i32)

define <8 x i32> @vdiv_vv_v8i32(<8 x i32> %va, <8 x i32> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32> %va, <8 x i32> %b, <8 x i1> %m, i32 %evl)
  ret <8 x i32> %v
}

define <8 x i32> @vdiv_vv_v8i32_unmasked(<8 x i32> %va, <8 x i32> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32> %va, <8 x i32> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i32> %v
}

define <8 x i32> @vdiv_vx_v8i32(<8 x i32> %va, i32 %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <8 x i32> %elt.head, <8 x i32> poison, <8 x i32> zeroinitializer
  %v = call <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32> %va, <8 x i32> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x i32> %v
}

define <8 x i32> @vdiv_vx_v8i32_unmasked(<8 x i32> %va, i32 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v8i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <8 x i32> %elt.head, <8 x i32> poison, <8 x i32> zeroinitializer
  %v = call <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32> %va, <8 x i32> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i32> %v
}

declare <16 x i32> @llvm.vp.sdiv.v16i32(<16 x i32>, <16 x i32>, <16 x i1>, i32)

define <16 x i32> @vdiv_vv_v16i32(<16 x i32> %va, <16 x i32> %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x i32> @llvm.vp.sdiv.v16i32(<16 x i32> %va, <16 x i32> %b, <16 x i1> %m, i32 %evl)
  ret <16 x i32> %v
}

define <16 x i32> @vdiv_vv_v16i32_unmasked(<16 x i32> %va, <16 x i32> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <16 x i32> @llvm.vp.sdiv.v16i32(<16 x i32> %va, <16 x i32> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i32> %v
}

define <16 x i32> @vdiv_vx_v16i32(<16 x i32> %va, i32 %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0, v0.t
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <16 x i32> %elt.head, <16 x i32> poison, <16 x i32> zeroinitializer
  %v = call <16 x i32> @llvm.vp.sdiv.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x i32> %v
}

define <16 x i32> @vdiv_vx_v16i32_unmasked(<16 x i32> %va, i32 %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vx_v16i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vdiv.vx v8, v8, a0
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x i32> poison, i32 %b, i32 0
  %vb = shufflevector <16 x i32> %elt.head, <16 x i32> poison, <16 x i32> zeroinitializer
  %v = call <16 x i32> @llvm.vp.sdiv.v16i32(<16 x i32> %va, <16 x i32> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i32> %v
}

declare <2 x i64> @llvm.vp.sdiv.v2i64(<2 x i64>, <2 x i64>, <2 x i1>, i32)

define <2 x i64> @vdiv_vv_v2i64(<2 x i64> %va, <2 x i64> %b, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i64> @llvm.vp.sdiv.v2i64(<2 x i64> %va, <2 x i64> %b, <2 x i1> %m, i32 %evl)
  ret <2 x i64> %v
}

define <2 x i64> @vdiv_vv_v2i64_unmasked(<2 x i64> %va, <2 x i64> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x i64> @llvm.vp.sdiv.v2i64(<2 x i64> %va, <2 x i64> %b, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i64> %v
}

define <2 x i64> @vdiv_vx_v2i64(<2 x i64> %va, i64 %b, <2 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vlse64.v v9, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m1, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v9, v0.t
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0, v0.t
; RV64-NEXT:    ret
  %elt.head = insertelement <2 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <2 x i64> %elt.head, <2 x i64> poison, <2 x i32> zeroinitializer
  %v = call <2 x i64> @llvm.vp.sdiv.v2i64(<2 x i64> %va, <2 x i64> %vb, <2 x i1> %m, i32 %evl)
  ret <2 x i64> %v
}

define <2 x i64> @vdiv_vx_v2i64_unmasked(<2 x i64> %va, i64 %b, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v2i64_unmasked:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vlse64.v v9, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m1, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v9
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v2i64_unmasked:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <2 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <2 x i64> %elt.head, <2 x i64> poison, <2 x i32> zeroinitializer
  %v = call <2 x i64> @llvm.vp.sdiv.v2i64(<2 x i64> %va, <2 x i64> %vb, <2 x i1> splat (i1 true), i32 %evl)
  ret <2 x i64> %v
}

declare <4 x i64> @llvm.vp.sdiv.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32)

define <4 x i64> @vdiv_vv_v4i64(<4 x i64> %va, <4 x i64> %b, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.sdiv.v4i64(<4 x i64> %va, <4 x i64> %b, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vdiv_vv_v4i64_unmasked(<4 x i64> %va, <4 x i64> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v4i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.sdiv.v4i64(<4 x i64> %va, <4 x i64> %b, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vdiv_vx_v4i64(<4 x i64> %va, i64 %b, <4 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    vlse64.v v10, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v10, v0.t
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m2, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0, v0.t
; RV64-NEXT:    ret
  %elt.head = insertelement <4 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <4 x i64> %elt.head, <4 x i64> poison, <4 x i32> zeroinitializer
  %v = call <4 x i64> @llvm.vp.sdiv.v4i64(<4 x i64> %va, <4 x i64> %vb, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vdiv_vx_v4i64_unmasked(<4 x i64> %va, i64 %b, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v4i64_unmasked:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    vlse64.v v10, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v10
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v4i64_unmasked:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m2, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <4 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <4 x i64> %elt.head, <4 x i64> poison, <4 x i32> zeroinitializer
  %v = call <4 x i64> @llvm.vp.sdiv.v4i64(<4 x i64> %va, <4 x i64> %vb, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i64> %v
}

declare <8 x i64> @llvm.vp.sdiv.v8i64(<8 x i64>, <8 x i64>, <8 x i1>, i32)

define <8 x i64> @vdiv_vv_v8i64(<8 x i64> %va, <8 x i64> %b, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x i64> @llvm.vp.sdiv.v8i64(<8 x i64> %va, <8 x i64> %b, <8 x i1> %m, i32 %evl)
  ret <8 x i64> %v
}

define <8 x i64> @vdiv_vv_v8i64_unmasked(<8 x i64> %va, <8 x i64> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v8i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <8 x i64> @llvm.vp.sdiv.v8i64(<8 x i64> %va, <8 x i64> %b, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i64> %v
}

define <8 x i64> @vdiv_vx_v8i64(<8 x i64> %va, i64 %b, <8 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v12, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m4, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v12, v0.t
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0, v0.t
; RV64-NEXT:    ret
  %elt.head = insertelement <8 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <8 x i64> %elt.head, <8 x i64> poison, <8 x i32> zeroinitializer
  %v = call <8 x i64> @llvm.vp.sdiv.v8i64(<8 x i64> %va, <8 x i64> %vb, <8 x i1> %m, i32 %evl)
  ret <8 x i64> %v
}

define <8 x i64> @vdiv_vx_v8i64_unmasked(<8 x i64> %va, i64 %b, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v8i64_unmasked:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v12, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m4, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v12
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v8i64_unmasked:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <8 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <8 x i64> %elt.head, <8 x i64> poison, <8 x i32> zeroinitializer
  %v = call <8 x i64> @llvm.vp.sdiv.v8i64(<8 x i64> %va, <8 x i64> %vb, <8 x i1> splat (i1 true), i32 %evl)
  ret <8 x i64> %v
}

declare <16 x i64> @llvm.vp.sdiv.v16i64(<16 x i64>, <16 x i64>, <16 x i1>, i32)

define <16 x i64> @vdiv_vv_v16i64(<16 x i64> %va, <16 x i64> %b, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x i64> @llvm.vp.sdiv.v16i64(<16 x i64> %va, <16 x i64> %b, <16 x i1> %m, i32 %evl)
  ret <16 x i64> %v
}

define <16 x i64> @vdiv_vv_v16i64_unmasked(<16 x i64> %va, <16 x i64> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v16i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <16 x i64> @llvm.vp.sdiv.v16i64(<16 x i64> %va, <16 x i64> %b, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i64> %v
}

define <16 x i64> @vdiv_vx_v16i64(<16 x i64> %va, i64 %b, <16 x i1> %m, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v16i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v16, v0.t
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v16i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0, v0.t
; RV64-NEXT:    ret
  %elt.head = insertelement <16 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <16 x i64> %elt.head, <16 x i64> poison, <16 x i32> zeroinitializer
  %v = call <16 x i64> @llvm.vp.sdiv.v16i64(<16 x i64> %va, <16 x i64> %vb, <16 x i1> %m, i32 %evl)
  ret <16 x i64> %v
}

define <16 x i64> @vdiv_vx_v16i64_unmasked(<16 x i64> %va, i64 %b, i32 zeroext %evl) {
; RV32-LABEL: vdiv_vx_v16i64_unmasked:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; RV32-NEXT:    vdiv.vv v8, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vdiv_vx_v16i64_unmasked:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; RV64-NEXT:    vdiv.vx v8, v8, a0
; RV64-NEXT:    ret
  %elt.head = insertelement <16 x i64> poison, i64 %b, i32 0
  %vb = shufflevector <16 x i64> %elt.head, <16 x i64> poison, <16 x i32> zeroinitializer
  %v = call <16 x i64> @llvm.vp.sdiv.v16i64(<16 x i64> %va, <16 x i64> %vb, <16 x i1> splat (i1 true), i32 %evl)
  ret <16 x i64> %v
}


declare <3 x i8> @llvm.vp.sdiv.v3i8(<3 x i8>, <3 x i8>, <3 x i1>, i32)

define <3 x i8> @vdiv_vv_v3i8_unmasked(<3 x i8> %va, <3 x i8> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v3i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <3 x i8> @llvm.vp.sdiv.v3i8(<3 x i8> %va, <3 x i8> %b, <3 x i1> splat (i1 true), i32 %evl)
  ret <3 x i8> %v
}

define <3 x i8> @vdiv_vv_v3i8_unmasked_avl3(<3 x i8> %va, <3 x i8> %b) {
; CHECK-LABEL: vdiv_vv_v3i8_unmasked_avl3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 3, e8, mf4, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <3 x i8> @llvm.vp.sdiv.v3i8(<3 x i8> %va, <3 x i8> %b, <3 x i1> splat (i1 true), i32 3)
  ret <3 x i8> %v
}

declare <7 x i8> @llvm.vp.sdiv.v7i8(<7 x i8>, <7 x i8>, <7 x i1>, i32)

define <7 x i8> @vdiv_vv_v7i8_unmasked(<7 x i8> %va, <7 x i8> %b, i32 zeroext %evl) {
; CHECK-LABEL: vdiv_vv_v7i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <7 x i8> @llvm.vp.sdiv.v7i8(<7 x i8> %va, <7 x i8> %b, <7 x i1> splat (i1 true), i32 %evl)
  ret <7 x i8> %v
}

define <7 x i8> @vdiv_vv_v7i8_unmasked_avl7(<7 x i8> %va, <7 x i8> %b) {
; CHECK-LABEL: vdiv_vv_v7i8_unmasked_avl7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 7, e8, mf2, ta, ma
; CHECK-NEXT:    vdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <7 x i8> @llvm.vp.sdiv.v7i8(<7 x i8> %va, <7 x i8> %b, <7 x i1> splat (i1 true), i32 7)
  ret <7 x i8> %v
}

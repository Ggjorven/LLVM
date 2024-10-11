; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFHMIN

define <vscale x 1 x bfloat> @vfmax_nxv1bf16_vv(<vscale x 1 x bfloat> %a, <vscale x 1 x bfloat> %b) {
; CHECK-LABEL: vfmax_nxv1bf16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v9
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmax.vv v9, v9, v10
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x bfloat> @llvm.maxnum.nxv1bf16(<vscale x 1 x bfloat> %a, <vscale x 1 x bfloat> %b)
  ret <vscale x 1 x bfloat> %v
}

define <vscale x 1 x bfloat> @vfmax_nxv1bf16_vf(<vscale x 1 x bfloat> %a, bfloat %b) {
; CHECK-LABEL: vfmax_nxv1bf16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a0, fa0
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a0
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vfwcvtbf16.f.f.v v8, v9
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmax.vv v9, v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x bfloat> poison, bfloat %b, i32 0
  %splat = shufflevector <vscale x 1 x bfloat> %head, <vscale x 1 x bfloat> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x bfloat> @llvm.maxnum.nxv1bf16(<vscale x 1 x bfloat> %a, <vscale x 1 x bfloat> %splat)
  ret <vscale x 1 x bfloat> %v
}

declare <vscale x 2 x bfloat> @llvm.maxnum.nxv2bf16(<vscale x 2 x bfloat>, <vscale x 2 x bfloat>)

define <vscale x 2 x bfloat> @vfmax_nxv2bf16_vv(<vscale x 2 x bfloat> %a, <vscale x 2 x bfloat> %b) {
; CHECK-LABEL: vfmax_nxv2bf16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v9
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmax.vv v9, v9, v10
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.maxnum.nxv2bf16(<vscale x 2 x bfloat> %a, <vscale x 2 x bfloat> %b)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vfmax_nxv2bf16_vf(<vscale x 2 x bfloat> %a, bfloat %b) {
; CHECK-LABEL: vfmax_nxv2bf16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a0, fa0
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a0
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vfwcvtbf16.f.f.v v8, v9
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmax.vv v9, v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x bfloat> poison, bfloat %b, i32 0
  %splat = shufflevector <vscale x 2 x bfloat> %head, <vscale x 2 x bfloat> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x bfloat> @llvm.maxnum.nxv2bf16(<vscale x 2 x bfloat> %a, <vscale x 2 x bfloat> %splat)
  ret <vscale x 2 x bfloat> %v
}

declare <vscale x 4 x bfloat> @llvm.maxnum.nxv4bf16(<vscale x 4 x bfloat>, <vscale x 4 x bfloat>)

define <vscale x 4 x bfloat> @vfmax_nxv4bf16_vv(<vscale x 4 x bfloat> %a, <vscale x 4 x bfloat> %b) {
; CHECK-LABEL: vfmax_nxv4bf16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v9
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmax.vv v10, v12, v10
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x bfloat> @llvm.maxnum.nxv4bf16(<vscale x 4 x bfloat> %a, <vscale x 4 x bfloat> %b)
  ret <vscale x 4 x bfloat> %v
}

define <vscale x 4 x bfloat> @vfmax_nxv4bf16_vf(<vscale x 4 x bfloat> %a, bfloat %b) {
; CHECK-LABEL: vfmax_nxv4bf16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a0, fa0
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a0
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v9
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmax.vv v10, v10, v12
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x bfloat> poison, bfloat %b, i32 0
  %splat = shufflevector <vscale x 4 x bfloat> %head, <vscale x 4 x bfloat> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x bfloat> @llvm.maxnum.nxv4bf16(<vscale x 4 x bfloat> %a, <vscale x 4 x bfloat> %splat)
  ret <vscale x 4 x bfloat> %v
}

declare <vscale x 8 x bfloat> @llvm.maxnum.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x bfloat>)

define <vscale x 8 x bfloat> @vfmax_nxv8bf16_vv(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b) {
; CHECK-LABEL: vfmax_nxv8bf16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v10
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmax.vv v12, v16, v12
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x bfloat> @llvm.maxnum.nxv8bf16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %v
}

define <vscale x 8 x bfloat> @vfmax_nxv8bf16_vf(<vscale x 8 x bfloat> %a, bfloat %b) {
; CHECK-LABEL: vfmax_nxv8bf16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a0, fa0
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v10
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmax.vv v12, v12, v16
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x bfloat> poison, bfloat %b, i32 0
  %splat = shufflevector <vscale x 8 x bfloat> %head, <vscale x 8 x bfloat> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x bfloat> @llvm.maxnum.nxv8bf16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %splat)
  ret <vscale x 8 x bfloat> %v
}

declare <vscale x 16 x bfloat> @llvm.maxnum.nxv16bf16(<vscale x 16 x bfloat>, <vscale x 16 x bfloat>)

define <vscale x 16 x bfloat> @vfmax_nxv16bf16_vv(<vscale x 16 x bfloat> %a, <vscale x 16 x bfloat> %b) {
; CHECK-LABEL: vfmax_nxv16bf16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v12
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v16, v24, v16
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x bfloat> @llvm.maxnum.nxv16bf16(<vscale x 16 x bfloat> %a, <vscale x 16 x bfloat> %b)
  ret <vscale x 16 x bfloat> %v
}

define <vscale x 16 x bfloat> @vfmax_nxv16bf16_vf(<vscale x 16 x bfloat> %a, bfloat %b) {
; CHECK-LABEL: vfmax_nxv16bf16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a0, fa0
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v12
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v16, v16, v24
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x bfloat> poison, bfloat %b, i32 0
  %splat = shufflevector <vscale x 16 x bfloat> %head, <vscale x 16 x bfloat> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x bfloat> @llvm.maxnum.nxv16bf16(<vscale x 16 x bfloat> %a, <vscale x 16 x bfloat> %splat)
  ret <vscale x 16 x bfloat> %v
}

declare <vscale x 32 x bfloat> @llvm.maxnum.nxv32bf16(<vscale x 32 x bfloat>, <vscale x 32 x bfloat>)

define <vscale x 32 x bfloat> @vfmax_nxv32bf16_vv(<vscale x 32 x bfloat> %a, <vscale x 32 x bfloat> %b) {
; CHECK-LABEL: vfmax_nxv32bf16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v16
; CHECK-NEXT:    vfwcvtbf16.f.f.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v24, v0, v24
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v24
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v20
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v12
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v16, v16, v24
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v12, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x bfloat> @llvm.maxnum.nxv32bf16(<vscale x 32 x bfloat> %a, <vscale x 32 x bfloat> %b)
  ret <vscale x 32 x bfloat> %v
}

define <vscale x 32 x bfloat> @vfmax_nxv32bf16_vf(<vscale x 32 x bfloat> %a, bfloat %b) {
; CHECK-LABEL: vfmax_nxv32bf16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a0, fa0
; CHECK-NEXT:    vsetvli a1, zero, e16, m8, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v8
; CHECK-NEXT:    vfwcvtbf16.f.f.v v0, v16
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v24, v24, v0
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v24
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v12
; CHECK-NEXT:    vfwcvtbf16.f.f.v v0, v20
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v16, v24, v0
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v12, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x bfloat> poison, bfloat %b, i32 0
  %splat = shufflevector <vscale x 32 x bfloat> %head, <vscale x 32 x bfloat> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x bfloat> @llvm.maxnum.nxv32bf16(<vscale x 32 x bfloat> %a, <vscale x 32 x bfloat> %splat)
  ret <vscale x 32 x bfloat> %v
}

declare <vscale x 1 x half> @llvm.maxnum.nxv1f16(<vscale x 1 x half>, <vscale x 1 x half>)

define <vscale x 1 x half> @vfmax_nxv1f16_vv(<vscale x 1 x half> %a, <vscale x 1 x half> %b) {
; ZVFH-LABEL: vfmax_nxv1f16_vv:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmax.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv1f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 1 x half> @llvm.maxnum.nxv1f16(<vscale x 1 x half> %a, <vscale x 1 x half> %b)
  ret <vscale x 1 x half> %v
}

define <vscale x 1 x half> @vfmax_nxv1f16_vf(<vscale x 1 x half> %a, half %b) {
; ZVFH-LABEL: vfmax_nxv1f16_vf:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmax.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv1f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.h a0, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v9, a0
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v9, v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 1 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 1 x half> %head, <vscale x 1 x half> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x half> @llvm.maxnum.nxv1f16(<vscale x 1 x half> %a, <vscale x 1 x half> %splat)
  ret <vscale x 1 x half> %v
}

declare <vscale x 2 x half> @llvm.maxnum.nxv2f16(<vscale x 2 x half>, <vscale x 2 x half>)

define <vscale x 2 x half> @vfmax_nxv2f16_vv(<vscale x 2 x half> %a, <vscale x 2 x half> %b) {
; ZVFH-LABEL: vfmax_nxv2f16_vv:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmax.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv2f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.maxnum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> %b)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vfmax_nxv2f16_vf(<vscale x 2 x half> %a, half %b) {
; ZVFH-LABEL: vfmax_nxv2f16_vf:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmax.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv2f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.h a0, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v9, a0
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v9, v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 2 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 2 x half> %head, <vscale x 2 x half> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x half> @llvm.maxnum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> %splat)
  ret <vscale x 2 x half> %v
}

declare <vscale x 4 x half> @llvm.maxnum.nxv4f16(<vscale x 4 x half>, <vscale x 4 x half>)

define <vscale x 4 x half> @vfmax_nxv4f16_vv(<vscale x 4 x half> %a, <vscale x 4 x half> %b) {
; ZVFH-LABEL: vfmax_nxv4f16_vv:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfmax.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv4f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v10, v12, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 4 x half> @llvm.maxnum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> %b)
  ret <vscale x 4 x half> %v
}

define <vscale x 4 x half> @vfmax_nxv4f16_vf(<vscale x 4 x half> %a, half %b) {
; ZVFH-LABEL: vfmax_nxv4f16_vf:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfmax.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv4f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.h a0, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v9, a0
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v10, v10, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 4 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 4 x half> %head, <vscale x 4 x half> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x half> @llvm.maxnum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> %splat)
  ret <vscale x 4 x half> %v
}

declare <vscale x 8 x half> @llvm.maxnum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>)

define <vscale x 8 x half> @vfmax_nxv8f16_vv(<vscale x 8 x half> %a, <vscale x 8 x half> %b) {
; ZVFH-LABEL: vfmax_nxv8f16_vv:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfmax.vv v8, v8, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv8f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v12, v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 8 x half> @llvm.maxnum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> %b)
  ret <vscale x 8 x half> %v
}

define <vscale x 8 x half> @vfmax_nxv8f16_vf(<vscale x 8 x half> %a, half %b) {
; ZVFH-LABEL: vfmax_nxv8f16_vf:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfmax.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv8f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.h a0, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v10, a0
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v12, v12, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 8 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 8 x half> %head, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x half> @llvm.maxnum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> %splat)
  ret <vscale x 8 x half> %v
}

declare <vscale x 16 x half> @llvm.maxnum.nxv16f16(<vscale x 16 x half>, <vscale x 16 x half>)

define <vscale x 16 x half> @vfmax_nxv16f16_vv(<vscale x 16 x half> %a, <vscale x 16 x half> %b) {
; ZVFH-LABEL: vfmax_nxv16f16_vv:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfmax.vv v8, v8, v12
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv16f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v16, v24, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 16 x half> @llvm.maxnum.nxv16f16(<vscale x 16 x half> %a, <vscale x 16 x half> %b)
  ret <vscale x 16 x half> %v
}

define <vscale x 16 x half> @vfmax_nxv16f16_vf(<vscale x 16 x half> %a, half %b) {
; ZVFH-LABEL: vfmax_nxv16f16_vf:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfmax.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv16f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.h a0, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v12, a0
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v16, v16, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 16 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 16 x half> %head, <vscale x 16 x half> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x half> @llvm.maxnum.nxv16f16(<vscale x 16 x half> %a, <vscale x 16 x half> %splat)
  ret <vscale x 16 x half> %v
}

declare <vscale x 32 x half> @llvm.maxnum.nxv32f16(<vscale x 32 x half>, <vscale x 32 x half>)

define <vscale x 32 x half> @vfmax_nxv32f16_vv(<vscale x 32 x half> %a, <vscale x 32 x half> %b) {
; ZVFH-LABEL: vfmax_nxv32f16_vv:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfmax.vv v8, v8, v16
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv32f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v24, v0, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v24
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v20
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v16, v16, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.maxnum.nxv32f16(<vscale x 32 x half> %a, <vscale x 32 x half> %b)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @vfmax_nxv32f16_vf(<vscale x 32 x half> %a, half %b) {
; ZVFH-LABEL: vfmax_nxv32f16_vf:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfmax.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmax_nxv32f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fmv.x.h a0, fa0
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m8, ta, ma
; ZVFHMIN-NEXT:    vmv.v.x v16, a0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v24, v24, v0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v24
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v20
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmax.vv v16, v24, v0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 32 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 32 x half> %head, <vscale x 32 x half> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x half> @llvm.maxnum.nxv32f16(<vscale x 32 x half> %a, <vscale x 32 x half> %splat)
  ret <vscale x 32 x half> %v
}

declare <vscale x 1 x float> @llvm.maxnum.nxv1f32(<vscale x 1 x float>, <vscale x 1 x float>)

define <vscale x 1 x float> @vfmax_nxv1f32_vv(<vscale x 1 x float> %a, <vscale x 1 x float> %b) {
; CHECK-LABEL: vfmax_nxv1f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x float> @llvm.maxnum.nxv1f32(<vscale x 1 x float> %a, <vscale x 1 x float> %b)
  ret <vscale x 1 x float> %v
}

define <vscale x 1 x float> @vfmax_nxv1f32_vf(<vscale x 1 x float> %a, float %b) {
; CHECK-LABEL: vfmax_nxv1f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 1 x float> %head, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x float> @llvm.maxnum.nxv1f32(<vscale x 1 x float> %a, <vscale x 1 x float> %splat)
  ret <vscale x 1 x float> %v
}

declare <vscale x 2 x float> @llvm.maxnum.nxv2f32(<vscale x 2 x float>, <vscale x 2 x float>)

define <vscale x 2 x float> @vfmax_nxv2f32_vv(<vscale x 2 x float> %a, <vscale x 2 x float> %b) {
; CHECK-LABEL: vfmax_nxv2f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.maxnum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> %b)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vfmax_nxv2f32_vf(<vscale x 2 x float> %a, float %b) {
; CHECK-LABEL: vfmax_nxv2f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 2 x float> %head, <vscale x 2 x float> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x float> @llvm.maxnum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> %splat)
  ret <vscale x 2 x float> %v
}

declare <vscale x 4 x float> @llvm.maxnum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)

define <vscale x 4 x float> @vfmax_nxv4f32_vv(<vscale x 4 x float> %a, <vscale x 4 x float> %b) {
; CHECK-LABEL: vfmax_nxv4f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.maxnum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> %b)
  ret <vscale x 4 x float> %v
}

define <vscale x 4 x float> @vfmax_nxv4f32_vf(<vscale x 4 x float> %a, float %b) {
; CHECK-LABEL: vfmax_nxv4f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 4 x float> %head, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x float> @llvm.maxnum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> %splat)
  ret <vscale x 4 x float> %v
}

declare <vscale x 8 x float> @llvm.maxnum.nxv8f32(<vscale x 8 x float>, <vscale x 8 x float>)

define <vscale x 8 x float> @vfmax_nxv8f32_vv(<vscale x 8 x float> %a, <vscale x 8 x float> %b) {
; CHECK-LABEL: vfmax_nxv8f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x float> @llvm.maxnum.nxv8f32(<vscale x 8 x float> %a, <vscale x 8 x float> %b)
  ret <vscale x 8 x float> %v
}

define <vscale x 8 x float> @vfmax_nxv8f32_vf(<vscale x 8 x float> %a, float %b) {
; CHECK-LABEL: vfmax_nxv8f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x float> @llvm.maxnum.nxv8f32(<vscale x 8 x float> %a, <vscale x 8 x float> %splat)
  ret <vscale x 8 x float> %v
}

declare <vscale x 16 x float> @llvm.maxnum.nxv16f32(<vscale x 16 x float>, <vscale x 16 x float>)

define <vscale x 16 x float> @vfmax_nxv16f32_vv(<vscale x 16 x float> %a, <vscale x 16 x float> %b) {
; CHECK-LABEL: vfmax_nxv16f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x float> @llvm.maxnum.nxv16f32(<vscale x 16 x float> %a, <vscale x 16 x float> %b)
  ret <vscale x 16 x float> %v
}

define <vscale x 16 x float> @vfmax_nxv16f32_vf(<vscale x 16 x float> %a, float %b) {
; CHECK-LABEL: vfmax_nxv16f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 16 x float> %head, <vscale x 16 x float> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x float> @llvm.maxnum.nxv16f32(<vscale x 16 x float> %a, <vscale x 16 x float> %splat)
  ret <vscale x 16 x float> %v
}

declare <vscale x 1 x double> @llvm.maxnum.nxv1f64(<vscale x 1 x double>, <vscale x 1 x double>)

define <vscale x 1 x double> @vfmax_nxv1f64_vv(<vscale x 1 x double> %a, <vscale x 1 x double> %b) {
; CHECK-LABEL: vfmax_nxv1f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x double> @llvm.maxnum.nxv1f64(<vscale x 1 x double> %a, <vscale x 1 x double> %b)
  ret <vscale x 1 x double> %v
}

define <vscale x 1 x double> @vfmax_nxv1f64_vf(<vscale x 1 x double> %a, double %b) {
; CHECK-LABEL: vfmax_nxv1f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 1 x double> %head, <vscale x 1 x double> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x double> @llvm.maxnum.nxv1f64(<vscale x 1 x double> %a, <vscale x 1 x double> %splat)
  ret <vscale x 1 x double> %v
}

declare <vscale x 2 x double> @llvm.maxnum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)

define <vscale x 2 x double> @vfmax_nxv2f64_vv(<vscale x 2 x double> %a, <vscale x 2 x double> %b) {
; CHECK-LABEL: vfmax_nxv2f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.maxnum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> %b)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vfmax_nxv2f64_vf(<vscale x 2 x double> %a, double %b) {
; CHECK-LABEL: vfmax_nxv2f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 2 x double> %head, <vscale x 2 x double> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x double> @llvm.maxnum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> %splat)
  ret <vscale x 2 x double> %v
}

declare <vscale x 4 x double> @llvm.maxnum.nxv4f64(<vscale x 4 x double>, <vscale x 4 x double>)

define <vscale x 4 x double> @vfmax_nxv4f64_vv(<vscale x 4 x double> %a, <vscale x 4 x double> %b) {
; CHECK-LABEL: vfmax_nxv4f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x double> @llvm.maxnum.nxv4f64(<vscale x 4 x double> %a, <vscale x 4 x double> %b)
  ret <vscale x 4 x double> %v
}

define <vscale x 4 x double> @vfmax_nxv4f64_vf(<vscale x 4 x double> %a, double %b) {
; CHECK-LABEL: vfmax_nxv4f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 4 x double> %head, <vscale x 4 x double> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x double> @llvm.maxnum.nxv4f64(<vscale x 4 x double> %a, <vscale x 4 x double> %splat)
  ret <vscale x 4 x double> %v
}

declare <vscale x 8 x double> @llvm.maxnum.nxv8f64(<vscale x 8 x double>, <vscale x 8 x double>)

define <vscale x 8 x double> @vfmax_nxv8f64_vv(<vscale x 8 x double> %a, <vscale x 8 x double> %b) {
; CHECK-LABEL: vfmax_nxv8f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x double> @llvm.maxnum.nxv8f64(<vscale x 8 x double> %a, <vscale x 8 x double> %b)
  ret <vscale x 8 x double> %v
}

define <vscale x 8 x double> @vfmax_nxv8f64_vf(<vscale x 8 x double> %a, double %b) {
; CHECK-LABEL: vfmax_nxv8f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 8 x double> %head, <vscale x 8 x double> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x double> @llvm.maxnum.nxv8f64(<vscale x 8 x double> %a, <vscale x 8 x double> %splat)
  ret <vscale x 8 x double> %v
}

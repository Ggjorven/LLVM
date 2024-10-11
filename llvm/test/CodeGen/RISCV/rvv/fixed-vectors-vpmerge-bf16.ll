; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+v,+m,+zfbfmin,+zvfbfmin -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+v,+m,+zfbfmin,+zvfbfmin -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+d,+v,+zvfh,+m,+zfbfmin,+zvfbfmin -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+v,+m,+zvfh,+zfbfmin,+zvfbfmin -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s

declare <2 x bfloat> @llvm.vp.merge.v2bf16(<2 x i1>, <2 x bfloat>, <2 x bfloat>, i32)

define <2 x bfloat> @vpmerge_vv_v2bf16(<2 x bfloat> %va, <2 x bfloat> %vb, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vv_v2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, tu, ma
; CHECK-NEXT:    vmerge.vvm v9, v9, v8, v0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x bfloat> @llvm.vp.merge.v2bf16(<2 x i1> %m, <2 x bfloat> %va, <2 x bfloat> %vb, i32 %evl)
  ret <2 x bfloat> %v
}

define <2 x bfloat> @vpmerge_vf_v2bf16(bfloat %a, <2 x bfloat> %vb, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vf_v2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a1, fa0
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a1
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, tu, ma
; CHECK-NEXT:    vmerge.vvm v8, v8, v9, v0
; CHECK-NEXT:    ret
  %elt.head = insertelement <2 x bfloat> poison, bfloat %a, i32 0
  %va = shufflevector <2 x bfloat> %elt.head, <2 x bfloat> poison, <2 x i32> zeroinitializer
  %v = call <2 x bfloat> @llvm.vp.merge.v2bf16(<2 x i1> %m, <2 x bfloat> %va, <2 x bfloat> %vb, i32 %evl)
  ret <2 x bfloat> %v
}

declare <4 x bfloat> @llvm.vp.merge.v4bf16(<4 x i1>, <4 x bfloat>, <4 x bfloat>, i32)

define <4 x bfloat> @vpmerge_vv_v4bf16(<4 x bfloat> %va, <4 x bfloat> %vb, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vv_v4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, tu, ma
; CHECK-NEXT:    vmerge.vvm v9, v9, v8, v0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x bfloat> @llvm.vp.merge.v4bf16(<4 x i1> %m, <4 x bfloat> %va, <4 x bfloat> %vb, i32 %evl)
  ret <4 x bfloat> %v
}

define <4 x bfloat> @vpmerge_vf_v4bf16(bfloat %a, <4 x bfloat> %vb, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vf_v4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a1, fa0
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a1
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, tu, ma
; CHECK-NEXT:    vmerge.vvm v8, v8, v9, v0
; CHECK-NEXT:    ret
  %elt.head = insertelement <4 x bfloat> poison, bfloat %a, i32 0
  %va = shufflevector <4 x bfloat> %elt.head, <4 x bfloat> poison, <4 x i32> zeroinitializer
  %v = call <4 x bfloat> @llvm.vp.merge.v4bf16(<4 x i1> %m, <4 x bfloat> %va, <4 x bfloat> %vb, i32 %evl)
  ret <4 x bfloat> %v
}

declare <8 x bfloat> @llvm.vp.merge.v8bf16(<8 x i1>, <8 x bfloat>, <8 x bfloat>, i32)

define <8 x bfloat> @vpmerge_vv_v8bf16(<8 x bfloat> %va, <8 x bfloat> %vb, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vv_v8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, tu, ma
; CHECK-NEXT:    vmerge.vvm v9, v9, v8, v0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <8 x bfloat> @llvm.vp.merge.v8bf16(<8 x i1> %m, <8 x bfloat> %va, <8 x bfloat> %vb, i32 %evl)
  ret <8 x bfloat> %v
}

define <8 x bfloat> @vpmerge_vf_v8bf16(bfloat %a, <8 x bfloat> %vb, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vf_v8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a1, fa0
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a1
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, tu, ma
; CHECK-NEXT:    vmerge.vvm v8, v8, v9, v0
; CHECK-NEXT:    ret
  %elt.head = insertelement <8 x bfloat> poison, bfloat %a, i32 0
  %va = shufflevector <8 x bfloat> %elt.head, <8 x bfloat> poison, <8 x i32> zeroinitializer
  %v = call <8 x bfloat> @llvm.vp.merge.v8bf16(<8 x i1> %m, <8 x bfloat> %va, <8 x bfloat> %vb, i32 %evl)
  ret <8 x bfloat> %v
}

declare <16 x bfloat> @llvm.vp.merge.v16bf16(<16 x i1>, <16 x bfloat>, <16 x bfloat>, i32)

define <16 x bfloat> @vpmerge_vv_v16bf16(<16 x bfloat> %va, <16 x bfloat> %vb, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vv_v16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vmerge.vvm v10, v10, v8, v0
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <16 x bfloat> @llvm.vp.merge.v16bf16(<16 x i1> %m, <16 x bfloat> %va, <16 x bfloat> %vb, i32 %evl)
  ret <16 x bfloat> %v
}

define <16 x bfloat> @vpmerge_vf_v16bf16(bfloat %a, <16 x bfloat> %vb, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpmerge_vf_v16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.x.h a1, fa0
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a1
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vmerge.vvm v8, v8, v10, v0
; CHECK-NEXT:    ret
  %elt.head = insertelement <16 x bfloat> poison, bfloat %a, i32 0
  %va = shufflevector <16 x bfloat> %elt.head, <16 x bfloat> poison, <16 x i32> zeroinitializer
  %v = call <16 x bfloat> @llvm.vp.merge.v16bf16(<16 x i1> %m, <16 x bfloat> %va, <16 x bfloat> %vb, i32 %evl)
  ret <16 x bfloat> %v
}

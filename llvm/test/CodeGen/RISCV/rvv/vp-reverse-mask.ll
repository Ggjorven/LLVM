; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i1> @test_vp_reverse_nxv1i1_masked(<vscale x 1 x i1> %src, <vscale x 1 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv1i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v10, v0.t
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vrsub.vx v10, v10, a0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v11, v9, v10, v0.t
; CHECK-NEXT:    vmsne.vi v0, v11, 0, v0.t
; CHECK-NEXT:    ret
  %dst = call <vscale x 1 x i1> @llvm.experimental.vp.reverse.nxv1i1(<vscale x 1 x i1> %src, <vscale x 1 x i1> %mask, i32 %evl)
  ret <vscale x 1 x i1> %dst
}

define <vscale x 1 x i1> @test_vp_reverse_nxv1i1(<vscale x 1 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vrgatherei16.vv v10, v9, v8
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 1 x i1> @llvm.experimental.vp.reverse.nxv1i1(<vscale x 1 x i1> %src, <vscale x 1 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 1 x i1> %dst
}

define <vscale x 2 x i1> @test_vp_reverse_nxv2i1_masked(<vscale x 2 x i1> %src, <vscale x 2 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv2i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v10, v0.t
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vrsub.vx v10, v10, a0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v11, v9, v10, v0.t
; CHECK-NEXT:    vmsne.vi v0, v11, 0, v0.t
; CHECK-NEXT:    ret
  %dst = call <vscale x 2 x i1> @llvm.experimental.vp.reverse.nxv2i1(<vscale x 2 x i1> %src, <vscale x 2 x i1> %mask, i32 %evl)
  ret <vscale x 2 x i1> %dst
}

define <vscale x 2 x i1> @test_vp_reverse_nxv2i1(<vscale x 2 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vrgatherei16.vv v10, v9, v8
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 2 x i1> @llvm.experimental.vp.reverse.nxv2i1(<vscale x 2 x i1> %src, <vscale x 2 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 2 x i1> %dst
}

define <vscale x 4 x i1> @test_vp_reverse_nxv4i1_masked(<vscale x 4 x i1> %src, <vscale x 4 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv4i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v10, v0.t
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vrsub.vx v10, v10, a0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v11, v9, v10, v0.t
; CHECK-NEXT:    vmsne.vi v0, v11, 0, v0.t
; CHECK-NEXT:    ret
  %dst = call <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1> %src, <vscale x 4 x i1> %mask, i32 %evl)
  ret <vscale x 4 x i1> %dst
}

define <vscale x 4 x i1> @test_vp_reverse_nxv4i1(<vscale x 4 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vrgatherei16.vv v10, v9, v8
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1> %src, <vscale x 4 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 4 x i1> %dst
}

define <vscale x 8 x i1> @test_vp_reverse_nxv8i1_masked(<vscale x 8 x i1> %src, <vscale x 8 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv8i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v10, v0.t
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vrsub.vx v10, v10, a0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v12, v9, v10, v0.t
; CHECK-NEXT:    vmsne.vi v0, v12, 0, v0.t
; CHECK-NEXT:    ret
  %dst = call <vscale x 8 x i1> @llvm.experimental.vp.reverse.nxv8i1(<vscale x 8 x i1> %src, <vscale x 8 x i1> %mask, i32 %evl)
  ret <vscale x 8 x i1> %dst
}

define <vscale x 8 x i1> @test_vp_reverse_nxv8i1(<vscale x 8 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmerge.vim v10, v10, 1, v0
; CHECK-NEXT:    vrgatherei16.vv v11, v10, v8
; CHECK-NEXT:    vmsne.vi v0, v11, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 8 x i1> @llvm.experimental.vp.reverse.nxv8i1(<vscale x 8 x i1> %src, <vscale x 8 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 8 x i1> %dst
}

define <vscale x 16 x i1> @test_vp_reverse_nxv16i1_masked(<vscale x 16 x i1> %src, <vscale x 16 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv16i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmerge.vim v10, v10, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vid.v v12, v0.t
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vrsub.vx v12, v12, a0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, m2, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v16, v10, v12, v0.t
; CHECK-NEXT:    vmsne.vi v8, v16, 0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    ret
  %dst = call <vscale x 16 x i1> @llvm.experimental.vp.reverse.nxv16i1(<vscale x 16 x i1> %src, <vscale x 16 x i1> %mask, i32 %evl)
  ret <vscale x 16 x i1> %dst
}

define <vscale x 16 x i1> @test_vp_reverse_nxv16i1(<vscale x 16 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v12, 0
; CHECK-NEXT:    vmerge.vim v12, v12, 1, v0
; CHECK-NEXT:    vrgatherei16.vv v14, v12, v8
; CHECK-NEXT:    vmsne.vi v0, v14, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 16 x i1> @llvm.experimental.vp.reverse.nxv16i1(<vscale x 16 x i1> %src, <vscale x 16 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 16 x i1> %dst
}

define <vscale x 32 x i1> @test_vp_reverse_nxv32i1_masked(<vscale x 32 x i1> %src, <vscale x 32 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv32i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.i v12, 0
; CHECK-NEXT:    vmerge.vim v12, v12, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, m8, ta, ma
; CHECK-NEXT:    vid.v v16, v0.t
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vrsub.vx v16, v16, a0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, m4, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v24, v12, v16, v0.t
; CHECK-NEXT:    vmsne.vi v8, v24, 0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    ret
  %dst = call <vscale x 32 x i1> @llvm.experimental.vp.reverse.nxv32i1(<vscale x 32 x i1> %src, <vscale x 32 x i1> %mask, i32 %evl)
  ret <vscale x 32 x i1> %dst
}

define <vscale x 32 x i1> @test_vp_reverse_nxv32i1(<vscale x 32 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v8, v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.i v16, 0
; CHECK-NEXT:    vmerge.vim v16, v16, 1, v0
; CHECK-NEXT:    vrgatherei16.vv v20, v16, v8
; CHECK-NEXT:    vmsne.vi v0, v20, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 32 x i1> @llvm.experimental.vp.reverse.nxv32i1(<vscale x 32 x i1> %src, <vscale x 32 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 32 x i1> %dst
}

define <vscale x 64 x i1> @test_vp_reverse_nxv64i1_masked(<vscale x 64 x i1> %src, <vscale x 64 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv64i1_masked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vmv.v.i v16, 0
; CHECK-NEXT:    vmerge.vim v24, v16, 1, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    addi a2, a1, -1
; CHECK-NEXT:    vsetvli a3, zero, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vrsub.vx v10, v10, a2
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v23, v24, v10
; CHECK-NEXT:    vrgatherei16.vv v22, v25, v10
; CHECK-NEXT:    vrgatherei16.vv v21, v26, v10
; CHECK-NEXT:    vrgatherei16.vv v20, v27, v10
; CHECK-NEXT:    vrgatherei16.vv v19, v28, v10
; CHECK-NEXT:    vrgatherei16.vv v18, v29, v10
; CHECK-NEXT:    vrgatherei16.vv v17, v30, v10
; CHECK-NEXT:    vrgatherei16.vv v16, v31, v10
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub a1, a1, a0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v16, v16, a1, v0.t
; CHECK-NEXT:    vmsne.vi v8, v16, 0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    ret
  %dst = call <vscale x 64 x i1> @llvm.experimental.vp.reverse.nxv64i1(<vscale x 64 x i1> %src, <vscale x 64 x i1> %mask, i32 %evl)
  ret <vscale x 64 x i1> %dst
}

define <vscale x 64 x i1> @test_vp_reverse_nxv64i1(<vscale x 64 x i1> %src, i32 zeroext %evl) {
; CHECK-LABEL: test_vp_reverse_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, 1, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    addi a2, a1, -1
; CHECK-NEXT:    vsetvli a3, zero, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vrsub.vx v24, v8, a2
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v15, v16, v24
; CHECK-NEXT:    vrgatherei16.vv v14, v17, v24
; CHECK-NEXT:    vrgatherei16.vv v13, v18, v24
; CHECK-NEXT:    vrgatherei16.vv v12, v19, v24
; CHECK-NEXT:    vrgatherei16.vv v11, v20, v24
; CHECK-NEXT:    vrgatherei16.vv v10, v21, v24
; CHECK-NEXT:    vrgatherei16.vv v9, v22, v24
; CHECK-NEXT:    vrgatherei16.vv v8, v23, v24
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub a1, a1, a0
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret

  %dst = call <vscale x 64 x i1> @llvm.experimental.vp.reverse.nxv64i1(<vscale x 64 x i1> %src, <vscale x 64 x i1> splat (i1 1), i32 %evl)
  ret <vscale x 64 x i1> %dst
}

declare <vscale x 1 x i1> @llvm.experimental.vp.reverse.nxv1i1(<vscale x 1 x i1>,<vscale x 1 x i1>,i32)
declare <vscale x 2 x i1> @llvm.experimental.vp.reverse.nxv2i1(<vscale x 2 x i1>,<vscale x 2 x i1>,i32)
declare <vscale x 4 x i1> @llvm.experimental.vp.reverse.nxv4i1(<vscale x 4 x i1>,<vscale x 4 x i1>,i32)
declare <vscale x 8 x i1> @llvm.experimental.vp.reverse.nxv8i1(<vscale x 8 x i1>,<vscale x 8 x i1>,i32)
declare <vscale x 16 x i1> @llvm.experimental.vp.reverse.nxv16i1(<vscale x 16 x i1>,<vscale x 16 x i1>,i32)
declare <vscale x 32 x i1> @llvm.experimental.vp.reverse.nxv32i1(<vscale x 32 x i1>,<vscale x 32 x i1>,i32)
declare <vscale x 64 x i1> @llvm.experimental.vp.reverse.nxv64i1(<vscale x 64 x i1>,<vscale x 64 x i1>,i32)

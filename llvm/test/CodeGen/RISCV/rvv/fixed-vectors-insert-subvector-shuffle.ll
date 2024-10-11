; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mattr=+v -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mattr=+v -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s

define <4 x i32> @insert_subvector_load_v4i32_v4i32(<4 x i32> %v1, ptr %p) {
; CHECK-LABEL: insert_subvector_load_v4i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    ret
  %v2 = load <4 x i32>, ptr %p
  %v3 = shufflevector <4 x i32> %v2, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v3
}

declare <4 x i32> @llvm.vp.load.v4i32(ptr, <4 x i1>, i32)
define <4 x i32> @insert_subvector_vp_load_v4i32_v4i32(<4 x i32> %v1, ptr %p, <4 x i1> %mask) {
; CHECK-LABEL: insert_subvector_vp_load_v4i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, mu
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %v2 = call <4 x i32> @llvm.vp.load.v4i32(ptr %p, <4 x i1> %mask, i32 4)
  %v3 = shufflevector <4 x i32> %v2, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v3
}

; Can't fold this in because the load has a non-undef passthru that isn't equal to the vmv.v.v passtrhu
declare <4 x i32> @llvm.masked.load.v4i32.p0(ptr, i32, <4 x i1>, <4 x i32>)
define <4 x i32> @insert_subvector_load_unfoldable_passthru_v4i32_v4i32(<4 x i32> %v1, ptr %p, <4 x i1> %mask, <4 x i32> %passthru) {
; CHECK-LABEL: insert_subvector_load_unfoldable_passthru_v4i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, ta, mu
; CHECK-NEXT:    vle32.v v9, (a0), v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v2 = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr %p, i32 4, <4 x i1> %mask, <4 x i32> %passthru)
  %v3 = shufflevector <4 x i32> %v2, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v3
}

; Can fold this in because the load has a non-undef passthru, but it's equal to the vmv.v.v passtrhu
define <4 x i32> @insert_subvector_load_foldable_passthru_v4i32_v4i32(<4 x i32> %v1, ptr %p, <4 x i1> %mask) {
; CHECK-LABEL: insert_subvector_load_foldable_passthru_v4i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, mu
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %v2 = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr %p, i32 4, <4 x i1> %mask, <4 x i32> %v1)
  %v3 = shufflevector <4 x i32> %v2, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v3
}

define <4 x i32> @insert_subvector_add_v4i32_v4i32(<4 x i32> %v1, <4 x i32> %v2) {
; CHECK-LABEL: insert_subvector_add_v4i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vadd.vv v8, v9, v10
; CHECK-NEXT:    ret
  %v3 = add <4 x i32> %v2, <i32 0, i32 1, i32 2, i32 3>
  %v4 = shufflevector <4 x i32> %v3, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v4
}

declare <4 x i32> @llvm.vp.add.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)
define <4 x i32> @insert_subvector_vp_add_v4i32_v4i32(<4 x i32> %v1, <4 x i32> %v2, <4 x i1> %mask) {
; CHECK-LABEL: insert_subvector_vp_add_v4i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, mu
; CHECK-NEXT:    vadd.vi v8, v9, 1, v0.t
; CHECK-NEXT:    ret
  %v3 = call <4 x i32> @llvm.vp.add.v4i32(<4 x i32> %v2, <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i1> %mask, i32 4)
  %v4 = shufflevector <4 x i32> %v3, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v4
}

define <4 x i32> @insert_subvector_load_v4i32_v2i32(<4 x i32> %v1, ptr %p) {
; CHECK-LABEL: insert_subvector_load_v4i32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v2 = load <2 x i32>, ptr %p
  %v3 = shufflevector <2 x i32> %v2, <2 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v4 = shufflevector <4 x i32> %v3, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v4
}

declare <2 x i32> @llvm.vp.load.v2i32(ptr, <2 x i1>, i32)
define <4 x i32> @insert_subvector_vp_load_v4i32_v2i32(<4 x i32> %v1, ptr %p, <2 x i1> %mask) {
; CHECK-LABEL: insert_subvector_vp_load_v4i32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0), v0.t
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v2 = call <2 x i32> @llvm.vp.load.v2i32(ptr %p, <2 x i1> %mask, i32 2)
  %v3 = shufflevector <2 x i32> %v2, <2 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v4 = shufflevector <4 x i32> %v3, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v4
}

define <4 x i32> @insert_subvector_add_v4i32_v2i32(<4 x i32> %v1, <2 x i32> %v2) {
; CHECK-LABEL: insert_subvector_add_v4i32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vadd.vv v9, v9, v10
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v3 = add <2 x i32> %v2, <i32 0, i32 1>
  %v4 = shufflevector <2 x i32> %v3, <2 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v5 = shufflevector <4 x i32> %v4, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v5
}

declare <2 x i32> @llvm.vp.add.v2i32(<2 x i32>, <2 x i32>, <2 x i1>, i32)
define <4 x i32> @insert_subvector_vp_add_v4i32_v2i32(<4 x i32> %v1, <2 x i32> %v2, <2 x i1> %mask) {
; CHECK-LABEL: insert_subvector_vp_add_v4i32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v9, v9, 1, v0.t
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v3 = call <2 x i32> @llvm.vp.add.v2i32(<2 x i32> %v2, <2 x i32> <i32 1, i32 1>, <2 x i1> %mask, i32 2)
  %v4 = shufflevector <2 x i32> %v3, <2 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v5 = shufflevector <4 x i32> %v4, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v5
}

define <4 x i32> @insert_subvector_load_v4i32_v8i32(<4 x i32> %v1, ptr %p) {
; CHECK-LABEL: insert_subvector_load_v4i32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    ret
  %v2 = load <8 x i32>, ptr %p
  %v3 = shufflevector <8 x i32> %v2, <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v4 = shufflevector <4 x i32> %v3, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v4
}

declare <8 x i32> @llvm.vp.load.v8i32(ptr, <8 x i1>, i32)
define <4 x i32> @insert_subvector_vp_load_v4i32_v8i32(<4 x i32> %v1, ptr %p, <8 x i1> %mask) {
; CHECK-LABEL: insert_subvector_vp_load_v4i32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0), v0.t
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v2 = call <8 x i32> @llvm.vp.load.v8i32(ptr %p, <8 x i1> %mask, i32 8)
  %v3 = shufflevector <8 x i32> %v2, <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v4 = shufflevector <4 x i32> %v3, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v4
}

define <4 x i32> @insert_subvector_add_v4i32_v8i32(<4 x i32> %v1, <8 x i32> %v2) {
; CHECK-LABEL: insert_subvector_add_v4i32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vadd.vv v8, v10, v9
; CHECK-NEXT:    ret
  %v3 = add <8 x i32> %v2, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %v4 = shufflevector <8 x i32> %v3, <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v5 = shufflevector <4 x i32> %v4, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v5
}

declare <8 x i32> @llvm.vp.add.v8i32(<8 x i32>, <8 x i32>, <8 x i1>, i32)
define <4 x i32> @insert_subvector_vp_add_v4i32_v8i32(<4 x i32> %v1, <8 x i32> %v2, <8 x i1> %mask) {
; CHECK-LABEL: insert_subvector_vp_add_v4i32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vi v10, v10, 1, v0.t
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v3 = call <8 x i32> @llvm.vp.add.v8i32(<8 x i32> %v2, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, <8 x i1> %mask, i32 8)
  %v4 = shufflevector <8 x i32> %v3, <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %v5 = shufflevector <4 x i32> %v4, <4 x i32> %v1, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v5
}

; %v2 depends on the chain of %v1, so make sure the peephole optimisation
; doesn't introduce a loop in the DAG
define <4 x i32> @insert_subvector_dag_loop(ptr %p, ptr %q) {
; CHECK-LABEL: insert_subvector_dag_loop:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v1 = load volatile <4 x i32>, ptr %p
  %v2 = load volatile <4 x i32>, ptr %q
  %v3 = shufflevector <4 x i32> %v1, <4 x i32> %v2, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  ret <4 x i32> %v3
}

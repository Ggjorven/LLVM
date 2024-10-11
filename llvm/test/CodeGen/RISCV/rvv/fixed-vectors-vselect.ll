; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s -check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s -check-prefixes=CHECK,RV64

define void @vselect_vv_v6i32(ptr %a, ptr %b, ptr %cc, ptr %z) {
; RV32-LABEL: vselect_vv_v6i32:
; RV32:       # %bb.0:
; RV32-NEXT:    lbu a2, 0(a2)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vle32.v v8, (a1)
; RV32-NEXT:    slli a1, a2, 30
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    andi a4, a2, 1
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a4
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 29
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 28
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 27
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    srli a2, a2, 5
; RV32-NEXT:    vslide1down.vx v10, v10, a2
; RV32-NEXT:    vslidedown.vi v10, v10, 2
; RV32-NEXT:    vand.vi v10, v10, 1
; RV32-NEXT:    vmsne.vi v0, v10, 0
; RV32-NEXT:    vsetivli zero, 6, e32, m2, tu, mu
; RV32-NEXT:    vle32.v v8, (a0), v0.t
; RV32-NEXT:    vse32.v v8, (a3)
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_vv_v6i32:
; RV64:       # %bb.0:
; RV64-NEXT:    lbu a2, 0(a2)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vle32.v v8, (a1)
; RV64-NEXT:    slli a1, a2, 62
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    andi a4, a2, 1
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v10, a4
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 61
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 60
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 59
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    srli a2, a2, 5
; RV64-NEXT:    vslide1down.vx v10, v10, a2
; RV64-NEXT:    vslidedown.vi v10, v10, 2
; RV64-NEXT:    vand.vi v10, v10, 1
; RV64-NEXT:    vmsne.vi v0, v10, 0
; RV64-NEXT:    vsetivli zero, 6, e32, m2, tu, mu
; RV64-NEXT:    vle32.v v8, (a0), v0.t
; RV64-NEXT:    vse32.v v8, (a3)
; RV64-NEXT:    ret
  %va = load <6 x i32>, ptr %a
  %vb = load <6 x i32>, ptr %b
  %vcc = load <6 x i1>, ptr %cc
  %vsel = select <6 x i1> %vcc, <6 x i32> %va, <6 x i32> %vb
  store <6 x i32> %vsel, ptr %z
  ret void
}

define void @vselect_vx_v6i32(i32 %a, ptr %b, ptr %cc, ptr %z) {
; RV32-LABEL: vselect_vx_v6i32:
; RV32:       # %bb.0:
; RV32-NEXT:    lbu a2, 0(a2)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vle32.v v8, (a1)
; RV32-NEXT:    slli a1, a2, 30
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    andi a4, a2, 1
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a4
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 29
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 28
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 27
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    srli a2, a2, 5
; RV32-NEXT:    vslide1down.vx v10, v10, a2
; RV32-NEXT:    vslidedown.vi v10, v10, 2
; RV32-NEXT:    vand.vi v10, v10, 1
; RV32-NEXT:    vmsne.vi v0, v10, 0
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vmerge.vxm v8, v8, a0, v0
; RV32-NEXT:    vse32.v v8, (a3)
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_vx_v6i32:
; RV64:       # %bb.0:
; RV64-NEXT:    lbu a2, 0(a2)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vle32.v v8, (a1)
; RV64-NEXT:    slli a1, a2, 62
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    andi a4, a2, 1
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v10, a4
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 61
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 60
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 59
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    srli a2, a2, 5
; RV64-NEXT:    vslide1down.vx v10, v10, a2
; RV64-NEXT:    vslidedown.vi v10, v10, 2
; RV64-NEXT:    vand.vi v10, v10, 1
; RV64-NEXT:    vmsne.vi v0, v10, 0
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vmerge.vxm v8, v8, a0, v0
; RV64-NEXT:    vse32.v v8, (a3)
; RV64-NEXT:    ret
  %vb = load <6 x i32>, ptr %b
  %ahead = insertelement <6 x i32> poison, i32 %a, i32 0
  %va = shufflevector <6 x i32> %ahead, <6 x i32> poison, <6 x i32> zeroinitializer
  %vcc = load <6 x i1>, ptr %cc
  %vsel = select <6 x i1> %vcc, <6 x i32> %va, <6 x i32> %vb
  store <6 x i32> %vsel, ptr %z
  ret void
}

define void @vselect_vi_v6i32(ptr %b, ptr %cc, ptr %z) {
; RV32-LABEL: vselect_vi_v6i32:
; RV32:       # %bb.0:
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vle32.v v8, (a0)
; RV32-NEXT:    slli a0, a1, 30
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    andi a3, a1, 1
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a3
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 29
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 28
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 27
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    srli a1, a1, 5
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    vslidedown.vi v10, v10, 2
; RV32-NEXT:    vand.vi v10, v10, 1
; RV32-NEXT:    vmsne.vi v0, v10, 0
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vmerge.vim v8, v8, -1, v0
; RV32-NEXT:    vse32.v v8, (a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_vi_v6i32:
; RV64:       # %bb.0:
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vle32.v v8, (a0)
; RV64-NEXT:    slli a0, a1, 62
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    andi a3, a1, 1
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v10, a3
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 61
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 60
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 59
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    srli a1, a1, 5
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    vslidedown.vi v10, v10, 2
; RV64-NEXT:    vand.vi v10, v10, 1
; RV64-NEXT:    vmsne.vi v0, v10, 0
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vmerge.vim v8, v8, -1, v0
; RV64-NEXT:    vse32.v v8, (a2)
; RV64-NEXT:    ret
  %vb = load <6 x i32>, ptr %b
  %vcc = load <6 x i1>, ptr %cc
  %vsel = select <6 x i1> %vcc, <6 x i32> splat (i32 -1), <6 x i32> %vb
  store <6 x i32> %vsel, ptr %z
  ret void
}


define void @vselect_vv_v6f32(ptr %a, ptr %b, ptr %cc, ptr %z) {
; RV32-LABEL: vselect_vv_v6f32:
; RV32:       # %bb.0:
; RV32-NEXT:    lbu a2, 0(a2)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vle32.v v8, (a1)
; RV32-NEXT:    slli a1, a2, 30
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    andi a4, a2, 1
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a4
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 29
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 28
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    slli a1, a2, 27
; RV32-NEXT:    srli a1, a1, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    srli a2, a2, 5
; RV32-NEXT:    vslide1down.vx v10, v10, a2
; RV32-NEXT:    vslidedown.vi v10, v10, 2
; RV32-NEXT:    vand.vi v10, v10, 1
; RV32-NEXT:    vmsne.vi v0, v10, 0
; RV32-NEXT:    vsetivli zero, 6, e32, m2, tu, mu
; RV32-NEXT:    vle32.v v8, (a0), v0.t
; RV32-NEXT:    vse32.v v8, (a3)
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_vv_v6f32:
; RV64:       # %bb.0:
; RV64-NEXT:    lbu a2, 0(a2)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vle32.v v8, (a1)
; RV64-NEXT:    slli a1, a2, 62
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    andi a4, a2, 1
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v10, a4
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 61
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 60
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    slli a1, a2, 59
; RV64-NEXT:    srli a1, a1, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    srli a2, a2, 5
; RV64-NEXT:    vslide1down.vx v10, v10, a2
; RV64-NEXT:    vslidedown.vi v10, v10, 2
; RV64-NEXT:    vand.vi v10, v10, 1
; RV64-NEXT:    vmsne.vi v0, v10, 0
; RV64-NEXT:    vsetivli zero, 6, e32, m2, tu, mu
; RV64-NEXT:    vle32.v v8, (a0), v0.t
; RV64-NEXT:    vse32.v v8, (a3)
; RV64-NEXT:    ret
  %va = load <6 x float>, ptr %a
  %vb = load <6 x float>, ptr %b
  %vcc = load <6 x i1>, ptr %cc
  %vsel = select <6 x i1> %vcc, <6 x float> %va, <6 x float> %vb
  store <6 x float> %vsel, ptr %z
  ret void
}

define void @vselect_vx_v6f32(float %a, ptr %b, ptr %cc, ptr %z) {
; RV32-LABEL: vselect_vx_v6f32:
; RV32:       # %bb.0:
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vle32.v v8, (a0)
; RV32-NEXT:    slli a0, a1, 30
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    andi a3, a1, 1
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a3
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 29
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 28
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 27
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    srli a1, a1, 5
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    vslidedown.vi v10, v10, 2
; RV32-NEXT:    vand.vi v10, v10, 1
; RV32-NEXT:    vmsne.vi v0, v10, 0
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; RV32-NEXT:    vse32.v v8, (a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_vx_v6f32:
; RV64:       # %bb.0:
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vle32.v v8, (a0)
; RV64-NEXT:    slli a0, a1, 62
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    andi a3, a1, 1
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v10, a3
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 61
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 60
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 59
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    srli a1, a1, 5
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    vslidedown.vi v10, v10, 2
; RV64-NEXT:    vand.vi v10, v10, 1
; RV64-NEXT:    vmsne.vi v0, v10, 0
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; RV64-NEXT:    vse32.v v8, (a2)
; RV64-NEXT:    ret
  %vb = load <6 x float>, ptr %b
  %ahead = insertelement <6 x float> poison, float %a, i32 0
  %va = shufflevector <6 x float> %ahead, <6 x float> poison, <6 x i32> zeroinitializer
  %vcc = load <6 x i1>, ptr %cc
  %vsel = select <6 x i1> %vcc, <6 x float> %va, <6 x float> %vb
  store <6 x float> %vsel, ptr %z
  ret void
}

define void @vselect_vfpzero_v6f32(ptr %b, ptr %cc, ptr %z) {
; RV32-LABEL: vselect_vfpzero_v6f32:
; RV32:       # %bb.0:
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vle32.v v8, (a0)
; RV32-NEXT:    slli a0, a1, 30
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    andi a3, a1, 1
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a3
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 29
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 28
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    slli a0, a1, 27
; RV32-NEXT:    srli a0, a0, 31
; RV32-NEXT:    vslide1down.vx v10, v10, a0
; RV32-NEXT:    srli a1, a1, 5
; RV32-NEXT:    vslide1down.vx v10, v10, a1
; RV32-NEXT:    vslidedown.vi v10, v10, 2
; RV32-NEXT:    vand.vi v10, v10, 1
; RV32-NEXT:    vmsne.vi v0, v10, 0
; RV32-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV32-NEXT:    vmerge.vim v8, v8, 0, v0
; RV32-NEXT:    vse32.v v8, (a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: vselect_vfpzero_v6f32:
; RV64:       # %bb.0:
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vle32.v v8, (a0)
; RV64-NEXT:    slli a0, a1, 62
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    andi a3, a1, 1
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v10, a3
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 61
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 60
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    slli a0, a1, 59
; RV64-NEXT:    srli a0, a0, 63
; RV64-NEXT:    vslide1down.vx v10, v10, a0
; RV64-NEXT:    srli a1, a1, 5
; RV64-NEXT:    vslide1down.vx v10, v10, a1
; RV64-NEXT:    vslidedown.vi v10, v10, 2
; RV64-NEXT:    vand.vi v10, v10, 1
; RV64-NEXT:    vmsne.vi v0, v10, 0
; RV64-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; RV64-NEXT:    vmerge.vim v8, v8, 0, v0
; RV64-NEXT:    vse32.v v8, (a2)
; RV64-NEXT:    ret
  %vb = load <6 x float>, ptr %b
  %vcc = load <6 x i1>, ptr %cc
  %vsel = select <6 x i1> %vcc, <6 x float> splat (float 0.0), <6 x float> %vb
  store <6 x float> %vsel, ptr %z
  ret void
}

define void @vselect_vv_v8i32(ptr %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vv_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    vlm.v v0, (a2)
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    vse32.v v8, (a3)
; CHECK-NEXT:    ret
  %va = load <8 x i32>, ptr %a
  %vb = load <8 x i32>, ptr %b
  %vcc = load <8 x i1>, ptr %cc
  %vsel = select <8 x i1> %vcc, <8 x i32> %va, <8 x i32> %vb
  store <8 x i32> %vsel, ptr %z
  ret void
}

define void @vselect_vx_v8i32(i32 %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vx_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a2)
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    vmerge.vxm v8, v8, a0, v0
; CHECK-NEXT:    vse32.v v8, (a3)
; CHECK-NEXT:    ret
  %vb = load <8 x i32>, ptr %b
  %ahead = insertelement <8 x i32> poison, i32 %a, i32 0
  %va = shufflevector <8 x i32> %ahead, <8 x i32> poison, <8 x i32> zeroinitializer
  %vcc = load <8 x i1>, ptr %cc
  %vsel = select <8 x i1> %vcc, <8 x i32> %va, <8 x i32> %vb
  store <8 x i32> %vsel, ptr %z
  ret void
}

define void @vselect_vi_v8i32(ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vi_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a1)
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    ret
  %vb = load <8 x i32>, ptr %b
  %vcc = load <8 x i1>, ptr %cc
  %vsel = select <8 x i1> %vcc, <8 x i32> splat (i32 -1), <8 x i32> %vb
  store <8 x i32> %vsel, ptr %z
  ret void
}

define void @vselect_vv_v8f32(ptr %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vv_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    vlm.v v0, (a2)
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    vse32.v v8, (a3)
; CHECK-NEXT:    ret
  %va = load <8 x float>, ptr %a
  %vb = load <8 x float>, ptr %b
  %vcc = load <8 x i1>, ptr %cc
  %vsel = select <8 x i1> %vcc, <8 x float> %va, <8 x float> %vb
  store <8 x float> %vsel, ptr %z
  ret void
}

define void @vselect_vx_v8f32(float %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vx_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a1)
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    ret
  %vb = load <8 x float>, ptr %b
  %ahead = insertelement <8 x float> poison, float %a, i32 0
  %va = shufflevector <8 x float> %ahead, <8 x float> poison, <8 x i32> zeroinitializer
  %vcc = load <8 x i1>, ptr %cc
  %vsel = select <8 x i1> %vcc, <8 x float> %va, <8 x float> %vb
  store <8 x float> %vsel, ptr %z
  ret void
}

define void @vselect_vfpzero_v8f32(ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vfpzero_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a1)
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse32.v v8, (a2)
; CHECK-NEXT:    ret
  %vb = load <8 x float>, ptr %b
  %vcc = load <8 x i1>, ptr %cc
  %vsel = select <8 x i1> %vcc, <8 x float> splat (float 0.0), <8 x float> %vb
  store <8 x float> %vsel, ptr %z
  ret void
}

define void @vselect_vv_v16i16(ptr %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vv_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, mu
; CHECK-NEXT:    vlm.v v0, (a2)
; CHECK-NEXT:    vle16.v v8, (a1)
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    vse16.v v8, (a3)
; CHECK-NEXT:    ret
  %va = load <16 x i16>, ptr %a
  %vb = load <16 x i16>, ptr %b
  %vcc = load <16 x i1>, ptr %cc
  %vsel = select <16 x i1> %vcc, <16 x i16> %va, <16 x i16> %vb
  store <16 x i16> %vsel, ptr %z
  ret void
}

define void @vselect_vx_v16i16(i16 signext %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vx_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a2)
; CHECK-NEXT:    vle16.v v8, (a1)
; CHECK-NEXT:    vmerge.vxm v8, v8, a0, v0
; CHECK-NEXT:    vse16.v v8, (a3)
; CHECK-NEXT:    ret
  %vb = load <16 x i16>, ptr %b
  %ahead = insertelement <16 x i16> poison, i16 %a, i32 0
  %va = shufflevector <16 x i16> %ahead, <16 x i16> poison, <16 x i32> zeroinitializer
  %vcc = load <16 x i1>, ptr %cc
  %vsel = select <16 x i1> %vcc, <16 x i16> %va, <16 x i16> %vb
  store <16 x i16> %vsel, ptr %z
  ret void
}

define void @vselect_vi_v16i16(ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vi_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a1)
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vmerge.vim v8, v8, 4, v0
; CHECK-NEXT:    vse16.v v8, (a2)
; CHECK-NEXT:    ret
  %vb = load <16 x i16>, ptr %b
  %vcc = load <16 x i1>, ptr %cc
  %vsel = select <16 x i1> %vcc, <16 x i16> splat (i16 4), <16 x i16> %vb
  store <16 x i16> %vsel, ptr %z
  ret void
}

define void @vselect_vv_v32f16(ptr %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vv_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a4, 32
; CHECK-NEXT:    vsetvli zero, a4, e16, m4, ta, mu
; CHECK-NEXT:    vlm.v v0, (a2)
; CHECK-NEXT:    vle16.v v8, (a1)
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    vse16.v v8, (a3)
; CHECK-NEXT:    ret
  %va = load <32 x half>, ptr %a
  %vb = load <32 x half>, ptr %b
  %vcc = load <32 x i1>, ptr %cc
  %vsel = select <32 x i1> %vcc, <32 x half> %va, <32 x half> %vb
  store <32 x half> %vsel, ptr %z
  ret void
}

define void @vselect_vx_v32f16(half %a, ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vx_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e16, m4, ta, ma
; CHECK-NEXT:    vlm.v v0, (a1)
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    vse16.v v8, (a2)
; CHECK-NEXT:    ret
  %vb = load <32 x half>, ptr %b
  %ahead = insertelement <32 x half> poison, half %a, i32 0
  %va = shufflevector <32 x half> %ahead, <32 x half> poison, <32 x i32> zeroinitializer
  %vcc = load <32 x i1>, ptr %cc
  %vsel = select <32 x i1> %vcc, <32 x half> %va, <32 x half> %vb
  store <32 x half> %vsel, ptr %z
  ret void
}

define void @vselect_vfpzero_v32f16(ptr %b, ptr %cc, ptr %z) {
; CHECK-LABEL: vselect_vfpzero_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e16, m4, ta, ma
; CHECK-NEXT:    vlm.v v0, (a1)
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse16.v v8, (a2)
; CHECK-NEXT:    ret
  %vb = load <32 x half>, ptr %b
  %vcc = load <32 x i1>, ptr %cc
  %vsel = select <32 x i1> %vcc, <32 x half> splat (half 0.0), <32 x half> %vb
  store <32 x half> %vsel, ptr %z
  ret void
}

define <2 x i1> @vselect_v2i1(<2 x i1> %a, <2 x i1> %b, <2 x i1> %cc) {
; CHECK-LABEL: vselect_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmandn.mm v8, v8, v9
; CHECK-NEXT:    vmand.mm v9, v0, v9
; CHECK-NEXT:    vmor.mm v0, v9, v8
; CHECK-NEXT:    ret
  %v = select <2 x i1> %cc, <2 x i1> %a, <2 x i1> %b
  ret <2 x i1> %v
}

define <4 x i1> @vselect_v4i1(<4 x i1> %a, <4 x i1> %b, <4 x i1> %cc) {
; CHECK-LABEL: vselect_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmandn.mm v8, v8, v9
; CHECK-NEXT:    vmand.mm v9, v0, v9
; CHECK-NEXT:    vmor.mm v0, v9, v8
; CHECK-NEXT:    ret
  %v = select <4 x i1> %cc, <4 x i1> %a, <4 x i1> %b
  ret <4 x i1> %v
}

define <8 x i1> @vselect_v8i1(<8 x i1> %a, <8 x i1> %b, <8 x i1> %cc) {
; CHECK-LABEL: vselect_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmandn.mm v8, v8, v9
; CHECK-NEXT:    vmand.mm v9, v0, v9
; CHECK-NEXT:    vmor.mm v0, v9, v8
; CHECK-NEXT:    ret
  %v = select <8 x i1> %cc, <8 x i1> %a, <8 x i1> %b
  ret <8 x i1> %v
}

define <16 x i1> @vselect_v16i1(<16 x i1> %a, <16 x i1> %b, <16 x i1> %cc) {
; CHECK-LABEL: vselect_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vmandn.mm v8, v8, v9
; CHECK-NEXT:    vmand.mm v9, v0, v9
; CHECK-NEXT:    vmor.mm v0, v9, v8
; CHECK-NEXT:    ret
  %v = select <16 x i1> %cc, <16 x i1> %a, <16 x i1> %b
  ret <16 x i1> %v
}

define <32 x i1> @vselect_v32i1(<32 x i1> %a, <32 x i1> %b, <32 x i1> %cc) {
; CHECK-LABEL: vselect_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmandn.mm v8, v8, v9
; CHECK-NEXT:    vmand.mm v9, v0, v9
; CHECK-NEXT:    vmor.mm v0, v9, v8
; CHECK-NEXT:    ret
  %v = select <32 x i1> %cc, <32 x i1> %a, <32 x i1> %b
  ret <32 x i1> %v
}

define <64 x i1> @vselect_v64i1(<64 x i1> %a, <64 x i1> %b, <64 x i1> %cc) {
; CHECK-LABEL: vselect_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 64
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vmandn.mm v8, v8, v9
; CHECK-NEXT:    vmand.mm v9, v0, v9
; CHECK-NEXT:    vmor.mm v0, v9, v8
; CHECK-NEXT:    ret
  %v = select <64 x i1> %cc, <64 x i1> %a, <64 x i1> %b
  ret <64 x i1> %v
}

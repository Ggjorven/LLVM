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

define <vscale x 2 x i1> @isnan_nxv2bf16(<vscale x 2 x bfloat> %x) {
; CHECK-LABEL: isnan_nxv2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 8
; CHECK-NEXT:    addi a1, a0, -1
; CHECK-NEXT:    vsetvli a2, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vand.vx v8, v8, a1
; CHECK-NEXT:    addi a0, a0, -128
; CHECK-NEXT:    vmsgt.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <vscale x 2 x i1> @llvm.is.fpclass.nxv2bf16(<vscale x 2 x bfloat> %x, i32 3)  ; nan
  ret <vscale x 2 x i1> %1
}

define <vscale x 2 x i1> @isnan_nxv2f16(<vscale x 2 x half> %x) {
; ZVFH-LABEL: isnan_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfclass.v v8, v8
; ZVFH-NEXT:    li a0, 768
; ZVFH-NEXT:    vand.vx v8, v8, a0
; ZVFH-NEXT:    vmsne.vi v0, v8, 0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: isnan_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    lui a0, 8
; ZVFHMIN-NEXT:    addi a0, a0, -1
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vand.vx v8, v8, a0
; ZVFHMIN-NEXT:    li a0, 31
; ZVFHMIN-NEXT:    slli a0, a0, 10
; ZVFHMIN-NEXT:    vmsgt.vx v0, v8, a0
; ZVFHMIN-NEXT:    ret
  %1 = call <vscale x 2 x i1> @llvm.is.fpclass.nxv2f16(<vscale x 2 x half> %x, i32 3)  ; nan
  ret <vscale x 2 x i1> %1
}

define <vscale x 2 x i1> @isnan_nxv2f32(<vscale x 2 x float> %x) {
; CHECK-LABEL: isnan_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 927
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 2 x i1> @llvm.is.fpclass.nxv2f32(<vscale x 2 x float> %x, i32 639)
  ret <vscale x 2 x i1> %1
}


define <vscale x 4 x i1> @isnan_nxv4f32(<vscale x 4 x float> %x) {
; CHECK-LABEL: isnan_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 768
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 4 x i1> @llvm.is.fpclass.nxv4f32(<vscale x 4 x float> %x, i32 3)  ; nan
  ret <vscale x 4 x i1> %1
}

define <vscale x 8 x i1> @isnan_nxv8f32(<vscale x 8 x float> %x) {
; CHECK-LABEL: isnan_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 512
; CHECK-NEXT:    vmseq.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <vscale x 8 x i1> @llvm.is.fpclass.nxv8f32(<vscale x 8 x float> %x, i32 2)
  ret <vscale x 8 x i1> %1
}

define <vscale x 16 x i1> @isnan_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: isnan_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 256
; CHECK-NEXT:    vmseq.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <vscale x 16 x i1> @llvm.is.fpclass.nxv16f32(<vscale x 16 x float> %x, i32 1)
  ret <vscale x 16 x i1> %1
}

define <vscale x 2 x i1> @isnormal_nxv2f64(<vscale x 2 x double> %x) {
; CHECK-LABEL: isnormal_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 129
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 2 x i1> @llvm.is.fpclass.nxv2f64(<vscale x 2 x double> %x, i32 516) ; 0x204 = "inf"
  ret <vscale x 2 x i1> %1
}

define <vscale x 4 x i1> @isposinf_nxv4f64(<vscale x 4 x double> %x) {
; CHECK-LABEL: isposinf_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 128
; CHECK-NEXT:    vmseq.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double> %x, i32 512) ; 0x200 = "+inf"
  ret <vscale x 4 x i1> %1
}

define <vscale x 8 x i1> @isneginf_nxv8f64(<vscale x 8 x double> %x) {
; CHECK-LABEL: isneginf_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    vmseq.vi v0, v8, 1
; CHECK-NEXT:    ret
  %1 = call <vscale x 8 x i1> @llvm.is.fpclass.nxv8f64(<vscale x 8 x double> %x, i32 4) ; "-inf"
  ret <vscale x 8 x i1> %1
}

define <vscale x 16 x i1> @isfinite_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: isfinite_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 126
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 16 x i1> @llvm.is.fpclass.nxv16f32(<vscale x 16 x float> %x, i32 504) ; 0x1f8 = "finite"
  ret <vscale x 16 x i1> %1
}

define <vscale x 16 x i1> @isposfinite_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: isposfinite_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 112
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 16 x i1> @llvm.is.fpclass.nxv16f32(<vscale x 16 x float> %x, i32 448) ; 0x1c0 = "+finite"
  ret <vscale x 16 x i1> %1
}

define <vscale x 16 x i1> @isnegfinite_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: isnegfinite_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    vand.vi v8, v8, 14
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 16 x i1> @llvm.is.fpclass.nxv16f32(<vscale x 16 x float> %x, i32 56) ; 0x38 = "-finite"
  ret <vscale x 16 x i1> %1
}

define <vscale x 16 x i1> @isnotfinite_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: isnotfinite_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 897
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <vscale x 16 x i1> @llvm.is.fpclass.nxv16f32(<vscale x 16 x float> %x, i32 519) ; 0x207 = "inf|nan"
  ret <vscale x 16 x i1> %1
}

declare <vscale x 2 x i1> @llvm.is.fpclass.nxv2f16(<vscale x 2 x half>, i32)
declare <vscale x 2 x i1> @llvm.is.fpclass.nxv2f32(<vscale x 2 x float>, i32)
declare <vscale x 4 x i1> @llvm.is.fpclass.nxv4f32(<vscale x 4 x float>, i32)
declare <vscale x 8 x i1> @llvm.is.fpclass.nxv8f32(<vscale x 8 x float>, i32)
declare <vscale x 16 x i1> @llvm.is.fpclass.nxv16f32(<vscale x 16 x float>, i32)
declare <vscale x 2 x i1> @llvm.is.fpclass.nxv2f64(<vscale x 2 x double>, i32)
declare <vscale x 4 x i1> @llvm.is.fpclass.nxv4f64(<vscale x 4 x double>, i32)
declare <vscale x 8 x i1> @llvm.is.fpclass.nxv8f64(<vscale x 8 x double>, i32)

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+zfh,+zvfh,+m | FileCheck --check-prefixes=CHECK,RV32 %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+m | FileCheck --check-prefixes=CHECK,RV64 %s

; Integers

define {<vscale x 16 x i1>, <vscale x 16 x i1>} @vector_deinterleave_load_nxv16i1_nxv32i1(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv16i1_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vlm.v v8, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v8, a0
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmerge.vim v14, v10, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v12, v10, 1, v0
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    vnsrl.wi v10, v12, 8
; CHECK-NEXT:    vmsne.vi v8, v10, 0
; CHECK-NEXT:    ret
  %vec = load <vscale x 32 x i1>, ptr %p
  %retval = call {<vscale x 16 x i1>, <vscale x 16 x i1>} @llvm.vector.deinterleave2.nxv32i1(<vscale x 32 x i1> %vec)
  ret {<vscale x 16 x i1>, <vscale x 16 x i1>} %retval
}

define {<vscale x 16 x i8>, <vscale x 16 x i8>} @vector_deinterleave_load_nxv16i8_nxv32i8(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv16i8_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vlseg2e8.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 32 x i8>, ptr %p
  %retval = call {<vscale x 16 x i8>, <vscale x 16 x i8>} @llvm.vector.deinterleave2.nxv32i8(<vscale x 32 x i8> %vec)
  ret {<vscale x 16 x i8>, <vscale x 16 x i8>} %retval
}

; Shouldn't be lowered to vlseg because it's unaligned
define {<vscale x 8 x i16>, <vscale x 8 x i16>} @vector_deinterleave_load_nxv8i16_nxv16i16_align1(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv8i16_nxv16i16_align1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl4r.v v12, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vnsrl.wi v10, v12, 16
; CHECK-NEXT:    ret
  %vec = load <vscale x 16 x i16>, ptr %p, align 1
  %retval = call {<vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.vector.deinterleave2.nxv16i16(<vscale x 16 x i16> %vec)
  ret {<vscale x 8 x i16>, <vscale x 8 x i16>} %retval
}

define {<vscale x 8 x i16>, <vscale x 8 x i16>} @vector_deinterleave_load_nxv8i16_nxv16i16(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv8i16_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vlseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 16 x i16>, ptr %p
  %retval = call {<vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.vector.deinterleave2.nxv16i16(<vscale x 16 x i16> %vec)
  ret {<vscale x 8 x i16>, <vscale x 8 x i16>} %retval
}

define {<vscale x 4 x i32>, <vscale x 4 x i32>} @vector_deinterleave_load_nxv4i32_nxvv8i32(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv4i32_nxvv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vlseg2e32.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x i32>, ptr %p
  %retval = call {<vscale x 4 x i32>, <vscale x 4 x i32>} @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %vec)
  ret {<vscale x 4 x i32>, <vscale x 4 x i32>} %retval
}

define {<vscale x 2 x i64>, <vscale x 2 x i64>} @vector_deinterleave_load_nxv2i64_nxv4i64(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv2i64_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vlseg2e64.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x i64>, ptr %p
  %retval = call {<vscale x 2 x i64>, <vscale x 2 x i64>} @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64> %vec)
  ret {<vscale x 2 x i64>, <vscale x 2 x i64>} %retval
}

define {<vscale x 4 x i64>, <vscale x 4 x i64>} @vector_deinterleave_load_nxv4i64_nxv8i64(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv4i64_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vlseg2e64.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x i64>, ptr %p
  %retval = call {<vscale x 4 x i64>, <vscale x 4 x i64>} @llvm.vector.deinterleave2.nxv8i64(<vscale x 8 x i64> %vec)
  ret {<vscale x 4 x i64>, <vscale x 4 x i64>} %retval
}

; This shouldn't be lowered to a vlseg because EMUL * NFIELDS >= 8
define {<vscale x 8 x i64>, <vscale x 8 x i64>} @vector_deinterleave_load_nxv8i64_nxv16i64(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv8i64_nxv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 5
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 32 * vlenb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vl8re64.v v8, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a2, 24
; CHECK-NEXT:    mul a0, a0, a2
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vl8re64.v v0, (a1)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v16, v8, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v24, v8, v16
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vrgather.vv v8, v0, v16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vadd.vi v8, v16, 1
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v0, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v16, v0, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v0, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v24, v0, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v28, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v20, v8
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %vec = load <vscale x 16 x i64>, ptr %p
  %retval = call {<vscale x 8 x i64>, <vscale x 8 x i64>} @llvm.vector.deinterleave2.nxv16i64(<vscale x 16 x i64> %vec)
  ret {<vscale x 8 x i64>, <vscale x 8 x i64>} %retval
}

declare {<vscale x 16 x i1>, <vscale x 16 x i1>} @llvm.vector.deinterleave2.nxv32i1(<vscale x 32 x i1>)
declare {<vscale x 16 x i8>, <vscale x 16 x i8>} @llvm.vector.deinterleave2.nxv32i8(<vscale x 32 x i8>)
declare {<vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.vector.deinterleave2.nxv16i16(<vscale x 16 x i16>)
declare {<vscale x 4 x i32>, <vscale x 4 x i32>} @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32>)
declare {<vscale x 2 x i64>, <vscale x 2 x i64>} @llvm.vector.deinterleave2.nxv4i64(<vscale x 4 x i64>)
declare {<vscale x 4 x i64>, <vscale x 4 x i64>} @llvm.vector.deinterleave2.nxv8i64(<vscale x 8 x i64>)
declare {<vscale x 8 x i64>, <vscale x 8 x i64>} @llvm.vector.deinterleave2.nxv16i64(<vscale x 16 x i64>)

; Floats

define {<vscale x 2 x half>, <vscale x 2 x half>} @vector_deinterleave_load_nxv2f16_nxv4f16(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv2f16_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vlseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x half>, ptr %p
  %retval = call {<vscale x 2 x half>, <vscale x 2 x half>} @llvm.vector.deinterleave2.nxv4f16(<vscale x 4 x half> %vec)
  ret {<vscale x 2 x half>, <vscale x 2 x half>} %retval
}

define {<vscale x 4 x half>, <vscale x 4 x half>} @vector_deinterleave_load_nxv4f16_nxv8f16(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv4f16_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vlseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x half>, ptr %p
  %retval = call {<vscale x 4 x half>, <vscale x 4 x half>} @llvm.vector.deinterleave2.nxv8f16(<vscale x 8 x half> %vec)
  ret {<vscale x 4 x half>, <vscale x 4 x half>} %retval
}

define {<vscale x 2 x float>, <vscale x 2 x float>} @vector_deinterleave_load_nxv2f32_nxv4f32(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv2f32_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vlseg2e32.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x float>, ptr %p
  %retval = call {<vscale x 2 x float>, <vscale x 2 x float>} @llvm.vector.deinterleave2.nxv4f32(<vscale x 4 x float> %vec)
  ret {<vscale x 2 x float>, <vscale x 2 x float>} %retval
}

define {<vscale x 8 x half>, <vscale x 8 x half>} @vector_deinterleave_load_nxv8f16_nxv16f16(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv8f16_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vlseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 16 x half>, ptr %p
  %retval = call {<vscale x 8 x half>, <vscale x 8 x half>} @llvm.vector.deinterleave2.nxv16f16(<vscale x 16 x half> %vec)
  ret {<vscale x 8 x half>, <vscale x 8 x half>} %retval
}

define {<vscale x 4 x float>, <vscale x 4 x float>} @vector_deinterleave_load_nxv4f32_nxv8f32(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv4f32_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vlseg2e32.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x float>, ptr %p
  %retval = call {<vscale x 4 x float>, <vscale x 4 x float>} @llvm.vector.deinterleave2.nxv8f32(<vscale x 8 x float> %vec)
  ret  {<vscale x 4 x float>, <vscale x 4 x float>} %retval
}

define {<vscale x 2 x double>, <vscale x 2 x double>} @vector_deinterleave_load_nxv2f64_nxv4f64(ptr %p) {
; CHECK-LABEL: vector_deinterleave_load_nxv2f64_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vlseg2e64.v v8, (a0)
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x double>, ptr %p
  %retval = call {<vscale x 2 x double>, <vscale x 2 x double>} @llvm.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %vec)
  ret {<vscale x 2 x double>, <vscale x 2 x double>} %retval
}

define {<vscale x 2 x ptr>, <vscale x 2 x ptr>} @vector_deinterleave_load_nxv2p0_nxv4p0(ptr %p) {
; RV32-LABEL: vector_deinterleave_load_nxv2p0_nxv4p0:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; RV32-NEXT:    vlseg2e32.v v8, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: vector_deinterleave_load_nxv2p0_nxv4p0:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV64-NEXT:    vlseg2e64.v v8, (a0)
; RV64-NEXT:    ret
  %vec = load <vscale x 4 x ptr>, ptr %p
  %retval = call {<vscale x 2 x ptr>, <vscale x 2 x ptr>} @llvm.vector.deinterleave2.nxv4p0(<vscale x 4 x ptr> %vec)
  ret {<vscale x 2 x ptr>, <vscale x 2 x ptr>} %retval
}

declare {<vscale x 2 x half>,<vscale x 2 x half>} @llvm.vector.deinterleave2.nxv4f16(<vscale x 4 x half>)
declare {<vscale x 4 x half>, <vscale x 4 x half>} @llvm.vector.deinterleave2.nxv8f16(<vscale x 8 x half>)
declare {<vscale x 2 x float>, <vscale x 2 x float>} @llvm.vector.deinterleave2.nxv4f32(<vscale x 4 x float>)
declare {<vscale x 8 x half>, <vscale x 8 x half>} @llvm.vector.deinterleave2.nxv16f16(<vscale x 16 x half>)
declare {<vscale x 4 x float>, <vscale x 4 x float>} @llvm.vector.deinterleave2.nxv8f32(<vscale x 8 x float>)
declare {<vscale x 2 x double>, <vscale x 2 x double>} @llvm.vector.deinterleave2.nxv4f64(<vscale x 4 x double>)
declare {<vscale x 2 x ptr>, <vscale x 2 x ptr>} @llvm.vector.deinterleave2.nxv4p0(<vscale x 4 x ptr>)

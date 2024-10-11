; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64

define fastcc <vscale x 4 x i8> @ret_nxv4i8(ptr %p) {
; CHECK-LABEL: ret_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 4 x i8>, ptr %p
  ret <vscale x 4 x i8> %v
}

define fastcc <vscale x 4 x i32> @ret_nxv4i32(ptr %p) {
; CHECK-LABEL: ret_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl2re32.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 4 x i32>, ptr %p
  ret <vscale x 4 x i32> %v
}

define fastcc <vscale x 8 x i32> @ret_nxv8i32(ptr %p) {
; CHECK-LABEL: ret_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl4re32.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 8 x i32>, ptr %p
  ret <vscale x 8 x i32> %v
}

define fastcc <vscale x 16 x i64> @ret_nxv16i64(ptr %p) {
; CHECK-LABEL: ret_nxv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vl8re64.v v16, (a1)
; CHECK-NEXT:    vl8re64.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 16 x i64>, ptr %p
  ret <vscale x 16 x i64> %v
}

define fastcc <vscale x 8 x i1> @ret_mask_nxv8i1(ptr %p) {
; CHECK-LABEL: ret_mask_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vlm.v v0, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 8 x i1>, ptr %p
  ret <vscale x 8 x i1> %v
}

define fastcc <vscale x 32 x i1> @ret_mask_nxv32i1(ptr %p) {
; CHECK-LABEL: ret_mask_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vlm.v v0, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 32 x i1>, ptr %p
  ret <vscale x 32 x i1> %v
}

; Return the vector via registers v8-v23
define fastcc <vscale x 64 x i32> @ret_split_nxv64i32(ptr %x) {
; CHECK-LABEL: ret_split_nxv64i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a3, a2, 3
; CHECK-NEXT:    slli a4, a2, 5
; CHECK-NEXT:    sub a4, a4, a3
; CHECK-NEXT:    add a5, a1, a4
; CHECK-NEXT:    vl8re32.v v8, (a5)
; CHECK-NEXT:    add a5, a1, a3
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    vl8re32.v v16, (a1)
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    vl8re32.v v24, (a1)
; CHECK-NEXT:    vl8re32.v v0, (a5)
; CHECK-NEXT:    vs8r.v v16, (a0)
; CHECK-NEXT:    add a2, a0, a2
; CHECK-NEXT:    vs8r.v v24, (a2)
; CHECK-NEXT:    add a3, a0, a3
; CHECK-NEXT:    vs8r.v v0, (a3)
; CHECK-NEXT:    add a0, a0, a4
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <vscale x 64 x i32>, ptr %x
  ret <vscale x 64 x i32> %v
}

; Return the vector fully via the stack
define fastcc <vscale x 128 x i32> @ret_split_nxv128i32(ptr %x) {
; CHECK-LABEL: ret_split_nxv128i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 5
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 32 * vlenb
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a3, a2, 3
; CHECK-NEXT:    slli a4, a2, 5
; CHECK-NEXT:    sub a5, a4, a3
; CHECK-NEXT:    add a6, a1, a5
; CHECK-NEXT:    vl8re32.v v8, (a6)
; CHECK-NEXT:    csrr a6, vlenb
; CHECK-NEXT:    li a7, 24
; CHECK-NEXT:    mul a6, a6, a7
; CHECK-NEXT:    add a6, sp, a6
; CHECK-NEXT:    addi a6, a6, 16
; CHECK-NEXT:    vs8r.v v8, (a6) # Unknown-size Folded Spill
; CHECK-NEXT:    slli a6, a2, 4
; CHECK-NEXT:    slli a7, a2, 6
; CHECK-NEXT:    sub t0, a7, a6
; CHECK-NEXT:    add t1, a1, t0
; CHECK-NEXT:    vl8re32.v v8, (t1)
; CHECK-NEXT:    csrr t1, vlenb
; CHECK-NEXT:    slli t1, t1, 4
; CHECK-NEXT:    add t1, sp, t1
; CHECK-NEXT:    addi t1, t1, 16
; CHECK-NEXT:    vs8r.v v8, (t1) # Unknown-size Folded Spill
; CHECK-NEXT:    sub a7, a7, a3
; CHECK-NEXT:    add t1, a1, a7
; CHECK-NEXT:    vl8re32.v v8, (t1)
; CHECK-NEXT:    csrr t1, vlenb
; CHECK-NEXT:    slli t1, t1, 3
; CHECK-NEXT:    add t1, sp, t1
; CHECK-NEXT:    addi t1, t1, 16
; CHECK-NEXT:    vs8r.v v8, (t1) # Unknown-size Folded Spill
; CHECK-NEXT:    add t1, a1, a3
; CHECK-NEXT:    vl8re32.v v8, (t1)
; CHECK-NEXT:    addi t1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (t1) # Unknown-size Folded Spill
; CHECK-NEXT:    add t1, a1, a6
; CHECK-NEXT:    add t2, a1, a4
; CHECK-NEXT:    li t3, 40
; CHECK-NEXT:    mul a2, a2, t3
; CHECK-NEXT:    add t3, a1, a2
; CHECK-NEXT:    vl8re32.v v8, (a1)
; CHECK-NEXT:    vl8re32.v v0, (t1)
; CHECK-NEXT:    vl8re32.v v16, (t3)
; CHECK-NEXT:    vl8re32.v v24, (t2)
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    add a2, a0, a2
; CHECK-NEXT:    vs8r.v v16, (a2)
; CHECK-NEXT:    add a4, a0, a4
; CHECK-NEXT:    vs8r.v v24, (a4)
; CHECK-NEXT:    add a6, a0, a6
; CHECK-NEXT:    vs8r.v v0, (a6)
; CHECK-NEXT:    add a3, a0, a3
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vl8r.v v8, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vs8r.v v8, (a3)
; CHECK-NEXT:    add a7, a0, a7
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8r.v v8, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vs8r.v v8, (a7)
; CHECK-NEXT:    add t0, a0, t0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8r.v v8, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vs8r.v v8, (t0)
; CHECK-NEXT:    add a0, a0, a5
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a2, 24
; CHECK-NEXT:    mul a1, a1, a2
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8r.v v8, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = load <vscale x 128 x i32>, ptr %x
  ret <vscale x 128 x i32> %v
}

define fastcc <vscale x 4 x i8> @ret_nxv4i8_param_nxv4i8_nxv4i8(<vscale x 4 x i8> %v, <vscale x 4 x i8> %w) {
; CHECK-LABEL: ret_nxv4i8_param_nxv4i8_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v9
; CHECK-NEXT:    ret
  %r = add <vscale x 4 x i8> %v, %w
  ret <vscale x 4 x i8> %r
}

define fastcc <vscale x 4 x i64> @ret_nxv4i64_param_nxv4i64_nxv4i64(<vscale x 4 x i64> %v, <vscale x 4 x i64> %w) {
; CHECK-LABEL: ret_nxv4i64_param_nxv4i64_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v12
; CHECK-NEXT:    ret
  %r = add <vscale x 4 x i64> %v, %w
  ret <vscale x 4 x i64> %r
}

define fastcc <vscale x 8 x i1> @ret_nxv8i1_param_nxv8i1_nxv8i1(<vscale x 8 x i1> %v, <vscale x 8 x i1> %w) {
; CHECK-LABEL: ret_nxv8i1_param_nxv8i1_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmxor.mm v0, v0, v8
; CHECK-NEXT:    ret
  %r = xor <vscale x 8 x i1> %v, %w
  ret <vscale x 8 x i1> %r
}

define fastcc <vscale x 32 x i1> @ret_nxv32i1_param_nxv32i1_nxv32i1(<vscale x 32 x i1> %v, <vscale x 32 x i1> %w) {
; CHECK-LABEL: ret_nxv32i1_param_nxv32i1_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vmand.mm v0, v0, v8
; CHECK-NEXT:    ret
  %r = and <vscale x 32 x i1> %v, %w
  ret <vscale x 32 x i1> %r
}

define fastcc <vscale x 32 x i32> @ret_nxv32i32_param_nxv32i32_nxv32i32_nxv32i32_i32(<vscale x 32 x i32> %x, <vscale x 32 x i32> %y, <vscale x 32 x i32> %z, i32 %w) {
; CHECK-LABEL: ret_nxv32i32_param_nxv32i32_nxv32i32_nxv32i32_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a3, a2, a1
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vl8re32.v v24, (a0)
; CHECK-NEXT:    vl8re32.v v0, (a1)
; CHECK-NEXT:    vl8re32.v v16, (a3)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vl8re32.v v16, (a2)
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vv v24, v8, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vadd.vv v0, v8, v0
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vadd.vv v8, v0, v8
; CHECK-NEXT:    vadd.vv v24, v24, v16
; CHECK-NEXT:    vadd.vx v16, v8, a4
; CHECK-NEXT:    vadd.vx v8, v24, a4
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %r = add <vscale x 32 x i32> %x, %y
  %s = add <vscale x 32 x i32> %r, %z
  %head = insertelement <vscale x 32 x i32> poison, i32 %w, i32 0
  %splat = shufflevector <vscale x 32 x i32> %head, <vscale x 32 x i32> poison, <vscale x 32 x i32> zeroinitializer
  %t = add <vscale x 32 x i32> %s, %splat
  ret <vscale x 32 x i32> %t
}

declare <vscale x 32 x i32> @ext2(<vscale x 32 x i32>, <vscale x 32 x i32>, i32, i32)
declare <vscale x 32 x i32> @ext3(<vscale x 32 x i32>, <vscale x 32 x i32>, <vscale x 32 x i32>, i32, i32)

define fastcc <vscale x 32 x i32> @ret_nxv32i32_call_nxv32i32_nxv32i32_i32(<vscale x 32 x i32> %x, <vscale x 32 x i32> %y, i32 %w) {
; RV32-LABEL: ret_nxv32i32_call_nxv32i32_nxv32i32_i32:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -144
; RV32-NEXT:    .cfi_def_cfa_offset 144
; RV32-NEXT:    sw ra, 140(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 136(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 144
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    csrr a1, vlenb
; RV32-NEXT:    slli a1, a1, 4
; RV32-NEXT:    sub sp, sp, a1
; RV32-NEXT:    andi sp, sp, -128
; RV32-NEXT:    csrr a1, vlenb
; RV32-NEXT:    slli a1, a1, 3
; RV32-NEXT:    add a3, a0, a1
; RV32-NEXT:    vl8re32.v v24, (a3)
; RV32-NEXT:    vl8re32.v v0, (a0)
; RV32-NEXT:    addi a0, sp, 128
; RV32-NEXT:    vs8r.v v8, (a0)
; RV32-NEXT:    add a1, a0, a1
; RV32-NEXT:    addi a0, sp, 128
; RV32-NEXT:    li a3, 2
; RV32-NEXT:    vs8r.v v16, (a1)
; RV32-NEXT:    vmv8r.v v8, v0
; RV32-NEXT:    vmv8r.v v16, v24
; RV32-NEXT:    call ext2
; RV32-NEXT:    addi sp, s0, -144
; RV32-NEXT:    lw ra, 140(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 136(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 144
; RV32-NEXT:    ret
;
; RV64-LABEL: ret_nxv32i32_call_nxv32i32_nxv32i32_i32:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -144
; RV64-NEXT:    .cfi_def_cfa_offset 144
; RV64-NEXT:    sd ra, 136(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 128(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 144
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    csrr a1, vlenb
; RV64-NEXT:    slli a1, a1, 4
; RV64-NEXT:    sub sp, sp, a1
; RV64-NEXT:    andi sp, sp, -128
; RV64-NEXT:    csrr a1, vlenb
; RV64-NEXT:    slli a1, a1, 3
; RV64-NEXT:    add a3, a0, a1
; RV64-NEXT:    vl8re32.v v24, (a3)
; RV64-NEXT:    vl8re32.v v0, (a0)
; RV64-NEXT:    addi a0, sp, 128
; RV64-NEXT:    vs8r.v v8, (a0)
; RV64-NEXT:    add a1, a0, a1
; RV64-NEXT:    addi a0, sp, 128
; RV64-NEXT:    li a3, 2
; RV64-NEXT:    vs8r.v v16, (a1)
; RV64-NEXT:    vmv8r.v v8, v0
; RV64-NEXT:    vmv8r.v v16, v24
; RV64-NEXT:    call ext2
; RV64-NEXT:    addi sp, s0, -144
; RV64-NEXT:    ld ra, 136(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 128(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 144
; RV64-NEXT:    ret
  %t = call fastcc <vscale x 32 x i32> @ext2(<vscale x 32 x i32> %y, <vscale x 32 x i32> %x, i32 %w, i32 2)
  ret <vscale x 32 x i32> %t
}

define fastcc <vscale x 32 x i32> @ret_nxv32i32_call_nxv32i32_nxv32i32_nxv32i32_i32(<vscale x 32 x i32> %x, <vscale x 32 x i32> %y, <vscale x 32 x i32> %z, i32 %w) {
; RV32-LABEL: ret_nxv32i32_call_nxv32i32_nxv32i32_nxv32i32_i32:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -144
; RV32-NEXT:    .cfi_def_cfa_offset 144
; RV32-NEXT:    sw ra, 140(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 136(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 144
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    csrr a1, vlenb
; RV32-NEXT:    li a3, 48
; RV32-NEXT:    mul a1, a1, a3
; RV32-NEXT:    sub sp, sp, a1
; RV32-NEXT:    andi sp, sp, -128
; RV32-NEXT:    csrr a1, vlenb
; RV32-NEXT:    slli a1, a1, 3
; RV32-NEXT:    add a3, a2, a1
; RV32-NEXT:    vl8re32.v v24, (a3)
; RV32-NEXT:    csrr a3, vlenb
; RV32-NEXT:    slli a3, a3, 3
; RV32-NEXT:    add a3, sp, a3
; RV32-NEXT:    addi a3, a3, 128
; RV32-NEXT:    vs8r.v v24, (a3) # Unknown-size Folded Spill
; RV32-NEXT:    add a3, a0, a1
; RV32-NEXT:    vl8re32.v v24, (a3)
; RV32-NEXT:    addi a3, sp, 128
; RV32-NEXT:    vs8r.v v24, (a3) # Unknown-size Folded Spill
; RV32-NEXT:    vl8re32.v v0, (a2)
; RV32-NEXT:    vl8re32.v v24, (a0)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 4
; RV32-NEXT:    add a0, sp, a0
; RV32-NEXT:    addi a0, a0, 128
; RV32-NEXT:    vs8r.v v8, (a0)
; RV32-NEXT:    csrr a2, vlenb
; RV32-NEXT:    slli a2, a2, 5
; RV32-NEXT:    add a2, sp, a2
; RV32-NEXT:    addi a2, a2, 128
; RV32-NEXT:    vs8r.v v24, (a2)
; RV32-NEXT:    add a0, a0, a1
; RV32-NEXT:    vs8r.v v16, (a0)
; RV32-NEXT:    add a1, a2, a1
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 5
; RV32-NEXT:    add a0, sp, a0
; RV32-NEXT:    addi a0, a0, 128
; RV32-NEXT:    csrr a2, vlenb
; RV32-NEXT:    slli a2, a2, 4
; RV32-NEXT:    add a2, sp, a2
; RV32-NEXT:    addi a2, a2, 128
; RV32-NEXT:    li a5, 42
; RV32-NEXT:    addi a3, sp, 128
; RV32-NEXT:    vl8r.v v8, (a3) # Unknown-size Folded Reload
; RV32-NEXT:    vs8r.v v8, (a1)
; RV32-NEXT:    vmv8r.v v8, v0
; RV32-NEXT:    csrr a1, vlenb
; RV32-NEXT:    slli a1, a1, 3
; RV32-NEXT:    add a1, sp, a1
; RV32-NEXT:    addi a1, a1, 128
; RV32-NEXT:    vl8r.v v16, (a1) # Unknown-size Folded Reload
; RV32-NEXT:    call ext3
; RV32-NEXT:    addi sp, s0, -144
; RV32-NEXT:    lw ra, 140(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 136(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 144
; RV32-NEXT:    ret
;
; RV64-LABEL: ret_nxv32i32_call_nxv32i32_nxv32i32_nxv32i32_i32:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -144
; RV64-NEXT:    .cfi_def_cfa_offset 144
; RV64-NEXT:    sd ra, 136(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 128(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 144
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    csrr a1, vlenb
; RV64-NEXT:    li a3, 48
; RV64-NEXT:    mul a1, a1, a3
; RV64-NEXT:    sub sp, sp, a1
; RV64-NEXT:    andi sp, sp, -128
; RV64-NEXT:    csrr a1, vlenb
; RV64-NEXT:    slli a1, a1, 3
; RV64-NEXT:    add a3, a2, a1
; RV64-NEXT:    vl8re32.v v24, (a3)
; RV64-NEXT:    csrr a3, vlenb
; RV64-NEXT:    slli a3, a3, 3
; RV64-NEXT:    add a3, sp, a3
; RV64-NEXT:    addi a3, a3, 128
; RV64-NEXT:    vs8r.v v24, (a3) # Unknown-size Folded Spill
; RV64-NEXT:    add a3, a0, a1
; RV64-NEXT:    vl8re32.v v24, (a3)
; RV64-NEXT:    addi a3, sp, 128
; RV64-NEXT:    vs8r.v v24, (a3) # Unknown-size Folded Spill
; RV64-NEXT:    vl8re32.v v0, (a2)
; RV64-NEXT:    vl8re32.v v24, (a0)
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 4
; RV64-NEXT:    add a0, sp, a0
; RV64-NEXT:    addi a0, a0, 128
; RV64-NEXT:    vs8r.v v8, (a0)
; RV64-NEXT:    csrr a2, vlenb
; RV64-NEXT:    slli a2, a2, 5
; RV64-NEXT:    add a2, sp, a2
; RV64-NEXT:    addi a2, a2, 128
; RV64-NEXT:    vs8r.v v24, (a2)
; RV64-NEXT:    add a0, a0, a1
; RV64-NEXT:    vs8r.v v16, (a0)
; RV64-NEXT:    add a1, a2, a1
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 5
; RV64-NEXT:    add a0, sp, a0
; RV64-NEXT:    addi a0, a0, 128
; RV64-NEXT:    csrr a2, vlenb
; RV64-NEXT:    slli a2, a2, 4
; RV64-NEXT:    add a2, sp, a2
; RV64-NEXT:    addi a2, a2, 128
; RV64-NEXT:    li a5, 42
; RV64-NEXT:    addi a3, sp, 128
; RV64-NEXT:    vl8r.v v8, (a3) # Unknown-size Folded Reload
; RV64-NEXT:    vs8r.v v8, (a1)
; RV64-NEXT:    vmv8r.v v8, v0
; RV64-NEXT:    csrr a1, vlenb
; RV64-NEXT:    slli a1, a1, 3
; RV64-NEXT:    add a1, sp, a1
; RV64-NEXT:    addi a1, a1, 128
; RV64-NEXT:    vl8r.v v16, (a1) # Unknown-size Folded Reload
; RV64-NEXT:    call ext3
; RV64-NEXT:    addi sp, s0, -144
; RV64-NEXT:    ld ra, 136(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 128(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 144
; RV64-NEXT:    ret
  %t = call fastcc <vscale x 32 x i32> @ext3(<vscale x 32 x i32> %z, <vscale x 32 x i32> %y, <vscale x 32 x i32> %x, i32 %w, i32 42)
  ret <vscale x 32 x i32> %t
}

; A test case where the normal calling convention would pass directly via the
; stack, but with fastcc can pass indirectly with the extra GPR registers
; allowed.
define fastcc <vscale x 32 x i32> @vector_arg_indirect_stack(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, <vscale x 32 x i32> %x, <vscale x 32 x i32> %y, <vscale x 32 x i32> %z, i32 %8) {
; CHECK-LABEL: vector_arg_indirect_stack:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, t5, a0
; CHECK-NEXT:    vl8re32.v v24, (t5)
; CHECK-NEXT:    vl8re32.v v0, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v24
; CHECK-NEXT:    vadd.vv v16, v16, v0
; CHECK-NEXT:    ret
  %s = add <vscale x 32 x i32> %x, %z
  ret <vscale x 32 x i32> %s
}

; Calling the function above. Ensure we pass the arguments correctly.
define fastcc <vscale x 32 x i32> @pass_vector_arg_indirect_stack(<vscale x 32 x i32> %x, <vscale x 32 x i32> %y, <vscale x 32 x i32> %z) {
; RV32-LABEL: pass_vector_arg_indirect_stack:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -144
; RV32-NEXT:    .cfi_def_cfa_offset 144
; RV32-NEXT:    sw ra, 140(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 136(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s1, 132(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    .cfi_offset s1, -12
; RV32-NEXT:    addi s0, sp, 144
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 5
; RV32-NEXT:    sub sp, sp, a0
; RV32-NEXT:    andi sp, sp, -128
; RV32-NEXT:    mv s1, sp
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 3
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    vsetvli a1, zero, e32, m8, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    addi a1, s1, 128
; RV32-NEXT:    vs8r.v v8, (a1)
; RV32-NEXT:    csrr a2, vlenb
; RV32-NEXT:    slli a2, a2, 4
; RV32-NEXT:    add a2, s1, a2
; RV32-NEXT:    addi a2, a2, 128
; RV32-NEXT:    vs8r.v v8, (a2)
; RV32-NEXT:    li a3, 8
; RV32-NEXT:    sw a3, 0(sp)
; RV32-NEXT:    add a1, a1, a0
; RV32-NEXT:    vs8r.v v8, (a1)
; RV32-NEXT:    add a0, a2, a0
; RV32-NEXT:    li a1, 1
; RV32-NEXT:    li a2, 2
; RV32-NEXT:    li a3, 3
; RV32-NEXT:    li a4, 4
; RV32-NEXT:    li a5, 5
; RV32-NEXT:    li a6, 6
; RV32-NEXT:    li a7, 7
; RV32-NEXT:    csrr t3, vlenb
; RV32-NEXT:    slli t3, t3, 4
; RV32-NEXT:    add t3, s1, t3
; RV32-NEXT:    addi t3, t3, 128
; RV32-NEXT:    addi t5, s1, 128
; RV32-NEXT:    vs8r.v v8, (a0)
; RV32-NEXT:    li a0, 0
; RV32-NEXT:    vmv.v.i v16, 0
; RV32-NEXT:    call vector_arg_indirect_stack
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    addi sp, s0, -144
; RV32-NEXT:    lw ra, 140(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 136(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s1, 132(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 144
; RV32-NEXT:    ret
;
; RV64-LABEL: pass_vector_arg_indirect_stack:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -160
; RV64-NEXT:    .cfi_def_cfa_offset 160
; RV64-NEXT:    sd ra, 152(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 144(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s1, 136(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    .cfi_offset s1, -24
; RV64-NEXT:    addi s0, sp, 160
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 5
; RV64-NEXT:    sub sp, sp, a0
; RV64-NEXT:    andi sp, sp, -128
; RV64-NEXT:    mv s1, sp
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 3
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    vsetvli a1, zero, e32, m8, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    addi a1, s1, 128
; RV64-NEXT:    vs8r.v v8, (a1)
; RV64-NEXT:    csrr a2, vlenb
; RV64-NEXT:    slli a2, a2, 4
; RV64-NEXT:    add a2, s1, a2
; RV64-NEXT:    addi a2, a2, 128
; RV64-NEXT:    vs8r.v v8, (a2)
; RV64-NEXT:    li a3, 8
; RV64-NEXT:    sd a3, 0(sp)
; RV64-NEXT:    add a1, a1, a0
; RV64-NEXT:    vs8r.v v8, (a1)
; RV64-NEXT:    add a0, a2, a0
; RV64-NEXT:    li a1, 1
; RV64-NEXT:    li a2, 2
; RV64-NEXT:    li a3, 3
; RV64-NEXT:    li a4, 4
; RV64-NEXT:    li a5, 5
; RV64-NEXT:    li a6, 6
; RV64-NEXT:    li a7, 7
; RV64-NEXT:    csrr t3, vlenb
; RV64-NEXT:    slli t3, t3, 4
; RV64-NEXT:    add t3, s1, t3
; RV64-NEXT:    addi t3, t3, 128
; RV64-NEXT:    addi t5, s1, 128
; RV64-NEXT:    vs8r.v v8, (a0)
; RV64-NEXT:    li a0, 0
; RV64-NEXT:    vmv.v.i v16, 0
; RV64-NEXT:    call vector_arg_indirect_stack
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    addi sp, s0, -160
; RV64-NEXT:    ld ra, 152(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 144(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s1, 136(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 160
; RV64-NEXT:    ret
  %s = call fastcc <vscale x 32 x i32> @vector_arg_indirect_stack(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, <vscale x 32 x i32> zeroinitializer, <vscale x 32 x i32> zeroinitializer, <vscale x 32 x i32> zeroinitializer, i32 8)
  ret <vscale x 32 x i32> %s
}

; Test case where we are out of registers for the vector and all GPRs are used.
define fastcc <vscale x 16 x i32> @vector_arg_indirect_stack_no_gpr(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, <vscale x 16 x i32> %x, <vscale x 16 x i32> %y, <vscale x 16 x i32> %z) {
; RV32-LABEL: vector_arg_indirect_stack_no_gpr:
; RV32:       # %bb.0:
; RV32-NEXT:    lw a0, 0(sp)
; RV32-NEXT:    vl8re32.v v16, (a0)
; RV32-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV32-NEXT:    vadd.vv v8, v8, v16
; RV32-NEXT:    ret
;
; RV64-LABEL: vector_arg_indirect_stack_no_gpr:
; RV64:       # %bb.0:
; RV64-NEXT:    ld a0, 0(sp)
; RV64-NEXT:    vl8re32.v v16, (a0)
; RV64-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV64-NEXT:    vadd.vv v8, v8, v16
; RV64-NEXT:    ret
  %s = add <vscale x 16 x i32> %x, %z
  ret <vscale x 16 x i32> %s
}

; Calling the function above. Ensure we pass the arguments correctly.
define fastcc <vscale x 16 x i32> @pass_vector_arg_indirect_stack_no_gpr(<vscale x 16 x i32> %x, <vscale x 16 x i32> %y, <vscale x 16 x i32> %z) {
; RV32-LABEL: pass_vector_arg_indirect_stack_no_gpr:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -80
; RV32-NEXT:    .cfi_def_cfa_offset 80
; RV32-NEXT:    sw ra, 76(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 72(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s1, 68(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    .cfi_offset s1, -12
; RV32-NEXT:    addi s0, sp, 80
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 3
; RV32-NEXT:    sub sp, sp, a0
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    mv s1, sp
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    addi a0, s1, 64
; RV32-NEXT:    vs8r.v v8, (a0)
; RV32-NEXT:    li a1, 1
; RV32-NEXT:    li a2, 2
; RV32-NEXT:    li a3, 3
; RV32-NEXT:    li a4, 4
; RV32-NEXT:    li a5, 5
; RV32-NEXT:    li a6, 6
; RV32-NEXT:    li a7, 7
; RV32-NEXT:    li t3, 8
; RV32-NEXT:    li t4, 9
; RV32-NEXT:    li t5, 10
; RV32-NEXT:    li t6, 11
; RV32-NEXT:    sw a0, 0(sp)
; RV32-NEXT:    li a0, 0
; RV32-NEXT:    vmv.v.i v16, 0
; RV32-NEXT:    call vector_arg_indirect_stack_no_gpr
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    addi sp, s0, -80
; RV32-NEXT:    lw ra, 76(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 72(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s1, 68(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 80
; RV32-NEXT:    ret
;
; RV64-LABEL: pass_vector_arg_indirect_stack_no_gpr:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -96
; RV64-NEXT:    .cfi_def_cfa_offset 96
; RV64-NEXT:    sd ra, 88(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 80(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s1, 72(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    .cfi_offset s1, -24
; RV64-NEXT:    addi s0, sp, 96
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 3
; RV64-NEXT:    sub sp, sp, a0
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    mv s1, sp
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    addi a0, s1, 64
; RV64-NEXT:    vs8r.v v8, (a0)
; RV64-NEXT:    li a1, 1
; RV64-NEXT:    li a2, 2
; RV64-NEXT:    li a3, 3
; RV64-NEXT:    li a4, 4
; RV64-NEXT:    li a5, 5
; RV64-NEXT:    li a6, 6
; RV64-NEXT:    li a7, 7
; RV64-NEXT:    li t3, 8
; RV64-NEXT:    li t4, 9
; RV64-NEXT:    li t5, 10
; RV64-NEXT:    li t6, 11
; RV64-NEXT:    sd a0, 0(sp)
; RV64-NEXT:    li a0, 0
; RV64-NEXT:    vmv.v.i v16, 0
; RV64-NEXT:    call vector_arg_indirect_stack_no_gpr
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    addi sp, s0, -96
; RV64-NEXT:    ld ra, 88(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 80(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s1, 72(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 96
; RV64-NEXT:    ret
  %s = call fastcc <vscale x 16 x i32> @vector_arg_indirect_stack_no_gpr(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32> zeroinitializer)
  ret <vscale x 16 x i32> %s
}

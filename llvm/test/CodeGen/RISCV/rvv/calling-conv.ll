; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+v < %s | FileCheck %s --check-prefixes=CHECK,RV64

; Check that we correctly scale the split part indirect offsets by VSCALE.
define <vscale x 32 x i32> @callee_scalable_vector_split_indirect(<vscale x 32 x i32> %x, <vscale x 32 x i32> %y) {
; CHECK-LABEL: callee_scalable_vector_split_indirect:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vl8re32.v v24, (a0)
; CHECK-NEXT:    vl8re32.v v0, (a1)
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v24
; CHECK-NEXT:    vadd.vv v16, v16, v0
; CHECK-NEXT:    ret
  %a = add <vscale x 32 x i32> %x, %y
  ret <vscale x 32 x i32> %a
}

; Call the function above. Check that we set the arguments correctly.
define <vscale x 32 x i32> @caller_scalable_vector_split_indirect(<vscale x 32 x i32> %x) {
; RV32-LABEL: caller_scalable_vector_split_indirect:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -144
; RV32-NEXT:    .cfi_def_cfa_offset 144
; RV32-NEXT:    sw ra, 140(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 136(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 144
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 4
; RV32-NEXT:    sub sp, sp, a0
; RV32-NEXT:    andi sp, sp, -128
; RV32-NEXT:    addi a0, sp, 128
; RV32-NEXT:    vs8r.v v8, (a0)
; RV32-NEXT:    csrr a1, vlenb
; RV32-NEXT:    slli a1, a1, 3
; RV32-NEXT:    add a1, a0, a1
; RV32-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    addi a0, sp, 128
; RV32-NEXT:    vs8r.v v16, (a1)
; RV32-NEXT:    vmv.v.i v16, 0
; RV32-NEXT:    call callee_scalable_vector_split_indirect
; RV32-NEXT:    addi sp, s0, -144
; RV32-NEXT:    lw ra, 140(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 136(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 144
; RV32-NEXT:    ret
;
; RV64-LABEL: caller_scalable_vector_split_indirect:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -144
; RV64-NEXT:    .cfi_def_cfa_offset 144
; RV64-NEXT:    sd ra, 136(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 128(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 144
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 4
; RV64-NEXT:    sub sp, sp, a0
; RV64-NEXT:    andi sp, sp, -128
; RV64-NEXT:    addi a0, sp, 128
; RV64-NEXT:    vs8r.v v8, (a0)
; RV64-NEXT:    csrr a1, vlenb
; RV64-NEXT:    slli a1, a1, 3
; RV64-NEXT:    add a1, a0, a1
; RV64-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    addi a0, sp, 128
; RV64-NEXT:    vs8r.v v16, (a1)
; RV64-NEXT:    vmv.v.i v16, 0
; RV64-NEXT:    call callee_scalable_vector_split_indirect
; RV64-NEXT:    addi sp, s0, -144
; RV64-NEXT:    ld ra, 136(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 128(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 144
; RV64-NEXT:    ret
  %c = alloca i64
  %a = call <vscale x 32 x i32> @callee_scalable_vector_split_indirect(<vscale x 32 x i32> zeroinitializer, <vscale x 32 x i32> %x)
  ret <vscale x 32 x i32> %a
}

define {<vscale x 4 x i32>, <vscale x 4 x i32>} @caller_tuple_return() {
; RV32-LABEL: caller_tuple_return:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    call callee_tuple_return
; RV32-NEXT:    vmv2r.v v12, v8
; RV32-NEXT:    vmv2r.v v8, v10
; RV32-NEXT:    vmv2r.v v10, v12
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: caller_tuple_return:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    call callee_tuple_return
; RV64-NEXT:    vmv2r.v v12, v8
; RV64-NEXT:    vmv2r.v v8, v10
; RV64-NEXT:    vmv2r.v v10, v12
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
  %a = call {<vscale x 4 x i32>, <vscale x 4 x i32>} @callee_tuple_return()
  %b = extractvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} %a, 0
  %c = extractvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} %a, 1
  %d = insertvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} poison, <vscale x 4 x i32> %c, 0
  %e = insertvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} %d, <vscale x 4 x i32> %b, 1
  ret {<vscale x 4 x i32>, <vscale x 4 x i32>} %e
}

declare {<vscale x 4 x i32>, <vscale x 4 x i32>} @callee_tuple_return()

define void @caller_tuple_argument({<vscale x 4 x i32>, <vscale x 4 x i32>} %x) {
; RV32-LABEL: caller_tuple_argument:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    vmv2r.v v12, v8
; RV32-NEXT:    vmv2r.v v8, v10
; RV32-NEXT:    vmv2r.v v10, v12
; RV32-NEXT:    call callee_tuple_argument
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: caller_tuple_argument:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    vmv2r.v v12, v8
; RV64-NEXT:    vmv2r.v v8, v10
; RV64-NEXT:    vmv2r.v v10, v12
; RV64-NEXT:    call callee_tuple_argument
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
  %a = extractvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} %x, 0
  %b = extractvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} %x, 1
  %c = insertvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} poison, <vscale x 4 x i32> %b, 0
  %d = insertvalue {<vscale x 4 x i32>, <vscale x 4 x i32>} %c, <vscale x 4 x i32> %a, 1
  call void @callee_tuple_argument({<vscale x 4 x i32>, <vscale x 4 x i32>} %d)
  ret void
}

declare void @callee_tuple_argument({<vscale x 4 x i32>, <vscale x 4 x i32>})

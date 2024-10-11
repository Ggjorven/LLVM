; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256 < %s | FileCheck %s

target triple = "aarch64"

;
; NOTE: SVE lowering for the BSP pseudoinst is not currently implemented, so we
;       don't currently expect the code below to lower to BSL/BIT/BIF. Once
;       this is implemented, this test will be fleshed out.
;

define void @fixed_bitselect_v8i32(ptr %pre_cond_ptr, ptr %left_ptr, ptr %right_ptr, ptr %result_ptr) #0 {
; CHECK-LABEL: fixed_bitselect_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    mov z1.s, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x1]
; CHECK-NEXT:    ld1w { z3.s }, p0/z, [x2]
; CHECK-NEXT:    add z1.s, z0.s, z1.s
; CHECK-NEXT:    subr z0.s, z0.s, #0 // =0x0
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    and z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z1.d, z0.d
; CHECK-NEXT:    st1w { z0.s }, p0, [x3]
; CHECK-NEXT:    ret
  %pre_cond = load <8 x i32>, ptr %pre_cond_ptr
  %left = load <8 x i32>, ptr %left_ptr
  %right = load <8 x i32>, ptr %right_ptr

  %neg_cond = sub <8 x i32> zeroinitializer, %pre_cond
  %min_cond = add <8 x i32> %pre_cond, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %left_bits_0 = and <8 x i32> %neg_cond, %left
  %right_bits_0 = and <8 x i32> %min_cond, %right
  %bsl0000 = or <8 x i32> %right_bits_0, %left_bits_0
  store <8 x i32> %bsl0000, ptr %result_ptr
  ret void
}

attributes #0 = { "target-features"="+sve" }

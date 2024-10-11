; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+v | FileCheck %s

define <vscale x 4 x i16> @test_mulhs_promote(<vscale x 4 x i16> %broadcast.splatinsert, <vscale x 4 x i1> %0, <vscale x 4 x i1> %1) {
; CHECK-LABEL: test_mulhs_promote:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 0
; CHECK-NEXT:    lui a0, 5
; CHECK-NEXT:    addi a0, a0, 1366
; CHECK-NEXT:    vmulh.vx v8, v9, a0
; CHECK-NEXT:    vsrl.vi v10, v8, 15
; CHECK-NEXT:    vadd.vv v8, v8, v10
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vnmsub.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %broadcast.splat = shufflevector <vscale x 4 x i16> %broadcast.splatinsert, <vscale x 4 x i16> zeroinitializer, <vscale x 4 x i32> zeroinitializer
  %2 = srem <vscale x 4 x i16> %broadcast.splat, shufflevector (<vscale x 4 x i16> insertelement (<vscale x 4 x i16> poison, i16 3, i64 0), <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer)
 ret <vscale x 4 x i16> %2
}

define <vscale x 4 x i16> @test_mulhu_promote(<vscale x 4 x i16> %broadcast.splatinsert, <vscale x 4 x i1> %0, <vscale x 4 x i1> %1) {
; CHECK-LABEL: test_mulhu_promote:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 0
; CHECK-NEXT:    lui a0, 1048571
; CHECK-NEXT:    addi a0, a0, -1365
; CHECK-NEXT:    vmulhu.vx v8, v9, a0
; CHECK-NEXT:    vsrl.vi v8, v8, 1
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vnmsub.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %broadcast.splat = shufflevector <vscale x 4 x i16> %broadcast.splatinsert, <vscale x 4 x i16> zeroinitializer, <vscale x 4 x i32> zeroinitializer
  %2 = urem <vscale x 4 x i16> %broadcast.splat, shufflevector (<vscale x 4 x i16> insertelement (<vscale x 4 x i16> poison, i16 3, i64 0), <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer)
 ret <vscale x 4 x i16> %2
}

define <vscale x 4 x i64> @test_mulhs_expand(<vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i1> %0, <vscale x 4 x i1> %1) {
; CHECK-LABEL: test_mulhs_expand:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    lui a0, 349525
; CHECK-NEXT:    addi a1, a0, 1365
; CHECK-NEXT:    sw a1, 12(sp)
; CHECK-NEXT:    addi a0, a0, 1366
; CHECK-NEXT:    sw a0, 8(sp)
; CHECK-NEXT:    addi a0, sp, 8
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vlse64.v v12, (a0), zero
; CHECK-NEXT:    vrgather.vi v16, v8, 0
; CHECK-NEXT:    vmulh.vv v8, v16, v12
; CHECK-NEXT:    li a0, 63
; CHECK-NEXT:    vsrl.vx v12, v8, a0
; CHECK-NEXT:    vadd.vv v8, v8, v12
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vnmsub.vx v8, a0, v16
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
entry:
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> zeroinitializer, <vscale x 4 x i32> zeroinitializer
  %2 = srem <vscale x 4 x i64> %broadcast.splat, shufflevector (<vscale x 4 x i64> insertelement (<vscale x 4 x i64> poison, i64 3, i64 0), <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer)
 ret <vscale x 4 x i64> %2
}

define <vscale x 4 x i64> @test_mulhu_expand(<vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i1> %0, <vscale x 4 x i1> %1) {
; CHECK-LABEL: test_mulhu_expand:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    lui a0, 699051
; CHECK-NEXT:    addi a1, a0, -1366
; CHECK-NEXT:    sw a1, 12(sp)
; CHECK-NEXT:    addi a0, a0, -1365
; CHECK-NEXT:    sw a0, 8(sp)
; CHECK-NEXT:    addi a0, sp, 8
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vlse64.v v12, (a0), zero
; CHECK-NEXT:    vrgather.vi v16, v8, 0
; CHECK-NEXT:    vmulhu.vv v8, v16, v12
; CHECK-NEXT:    vsrl.vi v8, v8, 1
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vnmsub.vx v8, a0, v16
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
entry:
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> zeroinitializer, <vscale x 4 x i32> zeroinitializer
  %2 = urem <vscale x 4 x i64> %broadcast.splat, shufflevector (<vscale x 4 x i64> insertelement (<vscale x 4 x i64> poison, i64 3, i64 0), <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer)
 ret <vscale x 4 x i64> %2
}

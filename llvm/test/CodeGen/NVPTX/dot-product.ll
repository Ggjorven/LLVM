; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -march=nvptx -mcpu=sm_61 | FileCheck %s
; RUN: llc < %s -march=nvptx64 -mcpu=sm_61 | FileCheck %s

target triple = "nvptx-nvidia-cuda"

declare i32 @llvm.nvvm.idp4a.s.s(i32, i32, i32)
declare i32 @llvm.nvvm.idp4a.s.u(i32, i32, i32)
declare i32 @llvm.nvvm.idp4a.u.s(i32, i32, i32)
declare i32 @llvm.nvvm.idp4a.u.u(i32, i32, i32)

define i32 @test_dp4a_u32_u32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp4a_u32_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp4a_u32_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp4a_u32_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp4a_u32_u32_param_2];
; CHECK-NEXT:    dp4a.u32.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp4a.u.u(i32 %a, i32 %b, i32 %c)
  ret i32 %call
}

define i32 @test_dp4a_u32imm_u32imm(i32 %c) {
; CHECK-LABEL: test_dp4a_u32imm_u32imm(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp4a_u32imm_u32imm_param_0];
; CHECK-NEXT:    mov.b32 %r2, 0;
; CHECK-NEXT:    dp4a.u32.u32 %r3, %r2, %r2, %r1;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r3;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp4a.u.u(i32 0, i32 0, i32 %c)
  ret i32 %call
}

define i32 @test_dp4a_u32_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp4a_u32_s32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp4a_u32_s32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp4a_u32_s32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp4a_u32_s32_param_2];
; CHECK-NEXT:    dp4a.u32.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp4a.u.s(i32 %a, i32 %b, i32 %c)
  ret i32 %call
}

define i32 @test_dp4a_s32_u32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp4a_s32_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp4a_s32_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp4a_s32_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp4a_s32_u32_param_2];
; CHECK-NEXT:    dp4a.s32.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp4a.s.u(i32 %a, i32 %b, i32 %c)
  ret i32 %call
}

define i32 @test_dp4a_s32_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp4a_s32_s32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp4a_s32_s32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp4a_s32_s32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp4a_s32_s32_param_2];
; CHECK-NEXT:    dp4a.s32.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp4a.s.s(i32 %a, i32 %b, i32 %c)
  ret i32 %call
}

declare i32 @llvm.nvvm.idp2a.s.s(i32, i32, i1 immarg, i32)
declare i32 @llvm.nvvm.idp2a.s.u(i32, i32, i1 immarg, i32)
declare i32 @llvm.nvvm.idp2a.u.s(i32, i32, i1 immarg, i32)
declare i32 @llvm.nvvm.idp2a.u.u(i32, i32, i1 immarg, i32)

define i32 @test_dp2a_lo_u32_u32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_lo_u32_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_lo_u32_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_lo_u32_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_lo_u32_u32_param_2];
; CHECK-NEXT:    dp2a.lo.u32.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.u.u(i32 %a, i32 %b, i1 0, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_lo_u32_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_lo_u32_s32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_lo_u32_s32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_lo_u32_s32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_lo_u32_s32_param_2];
; CHECK-NEXT:    dp2a.lo.u32.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.u.s(i32 %a, i32 %b, i1 0, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_lo_s32_u32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_lo_s32_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_lo_s32_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_lo_s32_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_lo_s32_u32_param_2];
; CHECK-NEXT:    dp2a.lo.s32.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.s.u(i32 %a, i32 %b, i1 0, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_lo_s32_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_lo_s32_s32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_lo_s32_s32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_lo_s32_s32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_lo_s32_s32_param_2];
; CHECK-NEXT:    dp2a.lo.s32.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.s.s(i32 %a, i32 %b, i1 0, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_hi_u32_u32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_hi_u32_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_hi_u32_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_hi_u32_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_hi_u32_u32_param_2];
; CHECK-NEXT:    dp2a.hi.u32.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.u.u(i32 %a, i32 %b, i1 1, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_hi_u32_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_hi_u32_s32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_hi_u32_s32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_hi_u32_s32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_hi_u32_s32_param_2];
; CHECK-NEXT:    dp2a.hi.u32.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.u.s(i32 %a, i32 %b, i1 1, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_hi_s32_u32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_hi_s32_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_hi_s32_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_hi_s32_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_hi_s32_u32_param_2];
; CHECK-NEXT:    dp2a.hi.s32.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.s.u(i32 %a, i32 %b, i1 1, i32 %c)
  ret i32 %call
}

define i32 @test_dp2a_hi_s32_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_dp2a_hi_s32_s32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_dp2a_hi_s32_s32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_dp2a_hi_s32_s32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_dp2a_hi_s32_s32_param_2];
; CHECK-NEXT:    dp2a.hi.s32.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %call = call i32 @llvm.nvvm.idp2a.s.s(i32 %a, i32 %b, i1 1, i32 %c)
  ret i32 %call
}

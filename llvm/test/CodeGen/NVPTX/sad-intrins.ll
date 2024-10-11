; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_50 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_50 | %ptxas-verify %}

define i16 @test_sad_i16(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: test_sad_i16(
; CHECK:       {
; CHECK-NEXT:    .reg .b16 %rs<5>;
; CHECK-NEXT:    .reg .b32 %r<2>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u16 %rs1, [test_sad_i16_param_0];
; CHECK-NEXT:    ld.param.u16 %rs2, [test_sad_i16_param_1];
; CHECK-NEXT:    ld.param.u16 %rs3, [test_sad_i16_param_2];
; CHECK-NEXT:    sad.s16 %rs4, %rs1, %rs2, %rs3;
; CHECK-NEXT:    cvt.u32.u16 %r1, %rs4;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r1;
; CHECK-NEXT:    ret;
  %1 = call i16 @llvm.nvvm.sad.s(i16 %x, i16 %y, i16 %z)
  ret i16 %1
}

define i16 @test_sad_u16(i16 %x, i16 %y, i16 %z) {
; CHECK-LABEL: test_sad_u16(
; CHECK:       {
; CHECK-NEXT:    .reg .b16 %rs<5>;
; CHECK-NEXT:    .reg .b32 %r<2>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u16 %rs1, [test_sad_u16_param_0];
; CHECK-NEXT:    ld.param.u16 %rs2, [test_sad_u16_param_1];
; CHECK-NEXT:    ld.param.u16 %rs3, [test_sad_u16_param_2];
; CHECK-NEXT:    sad.u16 %rs4, %rs1, %rs2, %rs3;
; CHECK-NEXT:    cvt.u32.u16 %r1, %rs4;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r1;
; CHECK-NEXT:    ret;
  %1 = call i16 @llvm.nvvm.sad.us(i16 %x, i16 %y, i16 %z)
  ret i16 %1
}

define i32 @test_sad_i32(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: test_sad_i32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_sad_i32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_sad_i32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_sad_i32_param_2];
; CHECK-NEXT:    sad.s32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %1 = call i32 @llvm.nvvm.sad.i(i32 %x, i32 %y, i32 %z)
  ret i32 %1
}

define i32 @test_sad_u32(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: test_sad_u32(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u32 %r1, [test_sad_u32_param_0];
; CHECK-NEXT:    ld.param.u32 %r2, [test_sad_u32_param_1];
; CHECK-NEXT:    ld.param.u32 %r3, [test_sad_u32_param_2];
; CHECK-NEXT:    sad.u32 %r4, %r1, %r2, %r3;
; CHECK-NEXT:    st.param.b32 [func_retval0+0], %r4;
; CHECK-NEXT:    ret;
  %1 = call i32 @llvm.nvvm.sad.ui(i32 %x, i32 %y, i32 %z)
  ret i32 %1
}

define i64 @test_sad_i64(i64 %x, i64 %y, i64 %z) {
; CHECK-LABEL: test_sad_i64(
; CHECK:       {
; CHECK-NEXT:    .reg .b64 %rd<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [test_sad_i64_param_0];
; CHECK-NEXT:    ld.param.u64 %rd2, [test_sad_i64_param_1];
; CHECK-NEXT:    ld.param.u64 %rd3, [test_sad_i64_param_2];
; CHECK-NEXT:    sad.s64 %rd4, %rd1, %rd2, %rd3;
; CHECK-NEXT:    st.param.b64 [func_retval0+0], %rd4;
; CHECK-NEXT:    ret;
  %1 = call i64 @llvm.nvvm.sad.ll(i64 %x, i64 %y, i64 %z)
  ret i64 %1
}

define i64 @test_sad_u64(i64 %x, i64 %y, i64 %z) {
; CHECK-LABEL: test_sad_u64(
; CHECK:       {
; CHECK-NEXT:    .reg .b64 %rd<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [test_sad_u64_param_0];
; CHECK-NEXT:    ld.param.u64 %rd2, [test_sad_u64_param_1];
; CHECK-NEXT:    ld.param.u64 %rd3, [test_sad_u64_param_2];
; CHECK-NEXT:    sad.u64 %rd4, %rd1, %rd2, %rd3;
; CHECK-NEXT:    st.param.b64 [func_retval0+0], %rd4;
; CHECK-NEXT:    ret;
  %1 = call i64 @llvm.nvvm.sad.ull(i64 %x, i64 %y, i64 %z)
  ret i64 %1
}

declare i16 @llvm.nvvm.sad.s(i16, i16, i16)
declare i16 @llvm.nvvm.sad.us(i16, i16, i16)
declare i32 @llvm.nvvm.sad.i(i32, i32, i32)
declare i32 @llvm.nvvm.sad.ui(i32, i32, i32)
declare i64 @llvm.nvvm.sad.ll(i64, i64, i64)
declare i64 @llvm.nvvm.sad.ull(i64, i64, i64)

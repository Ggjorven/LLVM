; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64 -mattr=+v,+f,+d,+zfh,+zvfh -riscv-v-fixed-length-vector-lmul-max=1 < %s | FileCheck %s
; Check that we don't crash querying costs when vectors are not enabled.
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64

define i32 @masked_scatter() {
; CHECK-LABEL: 'masked_scatter'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8f64.v8p0(<8 x double> undef, <8 x ptr> undef, i32 8, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4f64.v4p0(<4 x double> undef, <4 x ptr> undef, i32 8, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2f64.v2p0(<2 x double> undef, <2 x ptr> undef, i32 8, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1f64.v1p0(<1 x double> undef, <1 x ptr> undef, i32 8, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> undef, <16 x ptr> undef, i32 4, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8f32.v8p0(<8 x float> undef, <8 x ptr> undef, i32 4, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4f32.v4p0(<4 x float> undef, <4 x ptr> undef, i32 4, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2f32.v2p0(<2 x float> undef, <2 x ptr> undef, i32 4, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1f32.v1p0(<1 x float> undef, <1 x ptr> undef, i32 4, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: call void @llvm.masked.scatter.v32f16.v32p0(<32 x half> undef, <32 x ptr> undef, i32 2, <32 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v16f16.v16p0(<16 x half> undef, <16 x ptr> undef, i32 2, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8f16.v8p0(<8 x half> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4f16.v4p0(<4 x half> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2f16.v2p0(<2 x half> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1f16.v1p0(<1 x half> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8i64.v8p0(<8 x i64> undef, <8 x ptr> undef, i32 8, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4i64.v4p0(<4 x i64> undef, <4 x ptr> undef, i32 8, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2i64.v2p0(<2 x i64> undef, <2 x ptr> undef, i32 8, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1i64.v1p0(<1 x i64> undef, <1 x ptr> undef, i32 8, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v16i32.v16p0(<16 x i32> undef, <16 x ptr> undef, i32 4, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8i32.v8p0(<8 x i32> undef, <8 x ptr> undef, i32 4, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> undef, <4 x ptr> undef, i32 4, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> undef, <2 x ptr> undef, i32 4, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1i32.v1p0(<1 x i32> undef, <1 x ptr> undef, i32 4, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: call void @llvm.masked.scatter.v32i16.v32p0(<32 x i16> undef, <32 x ptr> undef, i32 2, <32 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v16i16.v16p0(<16 x i16> undef, <16 x ptr> undef, i32 2, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8i16.v8p0(<8 x i16> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4i16.v4p0(<4 x i16> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2i16.v2p0(<2 x i16> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1i16.v1p0(<1 x i16> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: call void @llvm.masked.scatter.v64i8.v64p0(<64 x i8> undef, <64 x ptr> undef, i32 1, <64 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: call void @llvm.masked.scatter.v32i8.v32p0(<32 x i8> undef, <32 x ptr> undef, i32 1, <32 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v16i8.v16p0(<16 x i8> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v8i8.v8p0(<8 x i8> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: call void @llvm.masked.scatter.v4i8.v4p0(<4 x i8> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: call void @llvm.masked.scatter.v2i8.v2p0(<2 x i8> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: call void @llvm.masked.scatter.v1i8.v1p0(<1 x i8> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: call void @llvm.masked.scatter.v8f64.v8p0(<8 x double> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v4f64.v4p0(<4 x double> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v2f64.v2p0(<2 x double> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: call void @llvm.masked.scatter.v1f64.v1p0(<1 x double> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 68 for instruction: call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> undef, <16 x ptr> undef, i32 2, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: call void @llvm.masked.scatter.v8f32.v8p0(<8 x float> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: call void @llvm.masked.scatter.v4f32.v4p0(<4 x float> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v2f32.v2p0(<2 x float> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: call void @llvm.masked.scatter.v1f32.v1p0(<1 x float> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 140 for instruction: call void @llvm.masked.scatter.v32f16.v32p0(<32 x half> undef, <32 x ptr> undef, i32 1, <32 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 70 for instruction: call void @llvm.masked.scatter.v16f16.v16p0(<16 x half> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 35 for instruction: call void @llvm.masked.scatter.v8f16.v8p0(<8 x half> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: call void @llvm.masked.scatter.v4f16.v4p0(<4 x half> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v2f16.v2p0(<2 x half> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: call void @llvm.masked.scatter.v1f16.v1p0(<1 x half> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: call void @llvm.masked.scatter.v8i64.v8p0(<8 x i64> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: call void @llvm.masked.scatter.v4i64.v4p0(<4 x i64> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v2i64.v2p0(<2 x i64> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: call void @llvm.masked.scatter.v1i64.v1p0(<1 x i64> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 68 for instruction: call void @llvm.masked.scatter.v16i32.v16p0(<16 x i32> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: call void @llvm.masked.scatter.v8i32.v8p0(<8 x i32> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: call void @llvm.masked.scatter.v1i32.v1p0(<1 x i32> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 140 for instruction: call void @llvm.masked.scatter.v32i16.v32p0(<32 x i16> undef, <32 x ptr> undef, i32 1, <32 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 70 for instruction: call void @llvm.masked.scatter.v16i16.v16p0(<16 x i16> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 35 for instruction: call void @llvm.masked.scatter.v8i16.v8p0(<8 x i16> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: call void @llvm.masked.scatter.v4i16.v4p0(<4 x i16> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: call void @llvm.masked.scatter.v2i16.v2p0(<2 x i16> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: call void @llvm.masked.scatter.v1i16.v1p0(<1 x i16> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 0
;
  call void @llvm.masked.scatter.v8f64.v8p0(<8 x double> undef, <8 x ptr> undef, i32 8, <8 x i1> undef)
  call void @llvm.masked.scatter.v4f64.v4p0(<4 x double> undef, <4 x ptr> undef, i32 8, <4 x i1> undef)
  call void @llvm.masked.scatter.v2f64.v2p0(<2 x double> undef, <2 x ptr> undef, i32 8, <2 x i1> undef)
  call void @llvm.masked.scatter.v1f64.v1p0(<1 x double> undef, <1 x ptr> undef, i32 8, <1 x i1> undef)

  call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> undef, <16 x ptr> undef, i32 4, <16 x i1> undef)
  call void @llvm.masked.scatter.v8f32.v8p0(<8 x float> undef, <8 x ptr> undef, i32 4, <8 x i1> undef)
  call void @llvm.masked.scatter.v4f32.v4p0(<4 x float> undef, <4 x ptr> undef, i32 4, <4 x i1> undef)
  call void @llvm.masked.scatter.v2f32.v2p0(<2 x float> undef, <2 x ptr> undef, i32 4, <2 x i1> undef)
  call void @llvm.masked.scatter.v1f32.v1p0(<1 x float> undef, <1 x ptr> undef, i32 4, <1 x i1> undef)

  call void @llvm.masked.scatter.v32f16.v32p0(<32 x half> undef, <32 x ptr> undef, i32 2, <32 x i1> undef)
  call void @llvm.masked.scatter.v16f16.v16p0(<16 x half> undef, <16 x ptr> undef, i32 2, <16 x i1> undef)
  call void @llvm.masked.scatter.v8f16.v8p0(<8 x half> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
  call void @llvm.masked.scatter.v4f16.v4p0(<4 x half> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
  call void @llvm.masked.scatter.v2f16.v2p0(<2 x half> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
  call void @llvm.masked.scatter.v1f16.v1p0(<1 x half> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)

  call void @llvm.masked.scatter.v8i64.v8p0(<8 x i64> undef, <8 x ptr> undef, i32 8, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i64.v4p0(<4 x i64> undef, <4 x ptr> undef, i32 8, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i64.v2p0(<2 x i64> undef, <2 x ptr> undef, i32 8, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i64.v1p0(<1 x i64> undef, <1 x ptr> undef, i32 8, <1 x i1> undef)

  call void @llvm.masked.scatter.v16i32.v16p0(<16 x i32> undef, <16 x ptr> undef, i32 4, <16 x i1> undef)
  call void @llvm.masked.scatter.v8i32.v8p0(<8 x i32> undef, <8 x ptr> undef, i32 4, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> undef, <4 x ptr> undef, i32 4, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> undef, <2 x ptr> undef, i32 4, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i32.v1p0(<1 x i32> undef, <1 x ptr> undef, i32 4, <1 x i1> undef)

  call void @llvm.masked.scatter.v32i16.v32p0(<32 x i16> undef, <32 x ptr> undef, i32 2, <32 x i1> undef)
  call void @llvm.masked.scatter.v16i16.v16p0(<16 x i16> undef, <16 x ptr> undef, i32 2, <16 x i1> undef)
  call void @llvm.masked.scatter.v8i16.v8p0(<8 x i16> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i16.v4p0(<4 x i16> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i16.v2p0(<2 x i16> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i16.v1p0(<1 x i16> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)

  call void @llvm.masked.scatter.v64i8.v64p0(<64 x i8> undef, <64 x ptr> undef, i32 1, <64 x i1> undef)
  call void @llvm.masked.scatter.v32i8.v32p0(<32 x i8> undef, <32 x ptr> undef, i32 1, <32 x i1> undef)
  call void @llvm.masked.scatter.v16i8.v16p0(<16 x i8> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
  call void @llvm.masked.scatter.v8i8.v8p0(<8 x i8> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i8.v4p0(<4 x i8> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i8.v2p0(<2 x i8> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i8.v1p0(<1 x i8> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)

  ; Test unaligned scatters
  call void @llvm.masked.scatter.v8f64.v8p0(<8 x double> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
  call void @llvm.masked.scatter.v4f64.v4p0(<4 x double> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
  call void @llvm.masked.scatter.v2f64.v2p0(<2 x double> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
  call void @llvm.masked.scatter.v1f64.v1p0(<1 x double> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)

  call void @llvm.masked.scatter.v16f32.v16p0(<16 x float> undef, <16 x ptr> undef, i32 2, <16 x i1> undef)
  call void @llvm.masked.scatter.v8f32.v8p0(<8 x float> undef, <8 x ptr> undef, i32 2, <8 x i1> undef)
  call void @llvm.masked.scatter.v4f32.v4p0(<4 x float> undef, <4 x ptr> undef, i32 2, <4 x i1> undef)
  call void @llvm.masked.scatter.v2f32.v2p0(<2 x float> undef, <2 x ptr> undef, i32 2, <2 x i1> undef)
  call void @llvm.masked.scatter.v1f32.v1p0(<1 x float> undef, <1 x ptr> undef, i32 2, <1 x i1> undef)

  call void @llvm.masked.scatter.v32f16.v32p0(<32 x half> undef, <32 x ptr> undef, i32 1, <32 x i1> undef)
  call void @llvm.masked.scatter.v16f16.v16p0(<16 x half> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
  call void @llvm.masked.scatter.v8f16.v8p0(<8 x half> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
  call void @llvm.masked.scatter.v4f16.v4p0(<4 x half> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
  call void @llvm.masked.scatter.v2f16.v2p0(<2 x half> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
  call void @llvm.masked.scatter.v1f16.v1p0(<1 x half> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)

  call void @llvm.masked.scatter.v8i64.v8p0(<8 x i64> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i64.v4p0(<4 x i64> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i64.v2p0(<2 x i64> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i64.v1p0(<1 x i64> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)

  call void @llvm.masked.scatter.v16i32.v16p0(<16 x i32> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
  call void @llvm.masked.scatter.v8i32.v8p0(<8 x i32> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i32.v1p0(<1 x i32> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)

  call void @llvm.masked.scatter.v32i16.v32p0(<32 x i16> undef, <32 x ptr> undef, i32 1, <32 x i1> undef)
  call void @llvm.masked.scatter.v16i16.v16p0(<16 x i16> undef, <16 x ptr> undef, i32 1, <16 x i1> undef)
  call void @llvm.masked.scatter.v8i16.v8p0(<8 x i16> undef, <8 x ptr> undef, i32 1, <8 x i1> undef)
  call void @llvm.masked.scatter.v4i16.v4p0(<4 x i16> undef, <4 x ptr> undef, i32 1, <4 x i1> undef)
  call void @llvm.masked.scatter.v2i16.v2p0(<2 x i16> undef, <2 x ptr> undef, i32 1, <2 x i1> undef)
  call void @llvm.masked.scatter.v1i16.v1p0(<1 x i16> undef, <1 x ptr> undef, i32 1, <1 x i1> undef)

  ret i32 0
}

declare void @llvm.masked.scatter.v8f64.v8p0(<8 x double>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4f64.v4p0(<4 x double>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2f64.v2p0(<2 x double>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1f64.v1p0(<1 x double>, <1 x ptr>, i32, <1 x i1>)

declare void @llvm.masked.scatter.v16f32.v16p0(<16 x float>, <16 x ptr>, i32, <16 x i1>)
declare void @llvm.masked.scatter.v8f32.v8p0(<8 x float>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4f32.v4p0(<4 x float>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2f32.v2p0(<2 x float>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1f32.v1p0(<1 x float>, <1 x ptr>, i32, <1 x i1>)

declare void @llvm.masked.scatter.v32f16.v32p0(<32 x half>, <32 x ptr>, i32, <32 x i1>)
declare void @llvm.masked.scatter.v16f16.v16p0(<16 x half>, <16 x ptr>, i32, <16 x i1>)
declare void @llvm.masked.scatter.v8f16.v8p0(<8 x half>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4f16.v4p0(<4 x half>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2f16.v2p0(<2 x half>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1f16.v1p0(<1 x half>, <1 x ptr>, i32, <1 x i1>)

declare void @llvm.masked.scatter.v8i64.v8p0(<8 x i64>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4i64.v4p0(<4 x i64>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2i64.v2p0(<2 x i64>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1i64.v1p0(<1 x i64>, <1 x ptr>, i32, <1 x i1>)

declare void @llvm.masked.scatter.v16i32.v16p0(<16 x i32>, <16 x ptr>, i32, <16 x i1>)
declare void @llvm.masked.scatter.v8i32.v8p0(<8 x i32>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2i32.v2p0(<2 x i32>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1i32.v1p0(<1 x i32>, <1 x ptr>, i32, <1 x i1>)

declare void @llvm.masked.scatter.v32i16.v32p0(<32 x i16>, <32 x ptr>, i32, <32 x i1>)
declare void @llvm.masked.scatter.v16i16.v16p0(<16 x i16>, <16 x ptr>, i32, <16 x i1>)
declare void @llvm.masked.scatter.v8i16.v8p0(<8 x i16>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4i16.v4p0(<4 x i16>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2i16.v2p0(<2 x i16>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1i16.v1p0(<1 x i16>, <1 x ptr>, i32, <1 x i1>)

declare void @llvm.masked.scatter.v64i8.v64p0(<64 x i8>, <64 x ptr>, i32, <64 x i1>)
declare void @llvm.masked.scatter.v32i8.v32p0(<32 x i8>, <32 x ptr>, i32, <32 x i1>)
declare void @llvm.masked.scatter.v16i8.v16p0(<16 x i8>, <16 x ptr>, i32, <16 x i1>)
declare void @llvm.masked.scatter.v8i8.v8p0(<8 x i8>, <8 x ptr>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v4i8.v4p0(<4 x i8>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v2i8.v2p0(<2 x i8>, <2 x ptr>, i32, <2 x i1>)
declare void @llvm.masked.scatter.v1i8.v1p0(<1 x i8>, <1 x ptr>, i32, <1 x i1>)

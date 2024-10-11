; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa < %s | FileCheck -check-prefixes=ALL-SIZE %s

define void @arithmetic_fence_f16() {
; ALL-LABEL: 'arithmetic_fence_f16'
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %f16 = call half @llvm.arithmetic.fence.f16(half undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2f16 = call <2 x half> @llvm.arithmetic.fence.v2f16(<2 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3f16 = call <3 x half> @llvm.arithmetic.fence.v3f16(<3 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4f16 = call <4 x half> @llvm.arithmetic.fence.v4f16(<4 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5f16 = call <5 x half> @llvm.arithmetic.fence.v5f16(<5 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8f16 = call <8 x half> @llvm.arithmetic.fence.v8f16(<8 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16f16 = call <16 x half> @llvm.arithmetic.fence.v16f16(<16 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17f16 = call <17 x half> @llvm.arithmetic.fence.v17f16(<17 x half> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; ALL-SIZE-LABEL: 'arithmetic_fence_f16'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %f16 = call half @llvm.arithmetic.fence.f16(half undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2f16 = call <2 x half> @llvm.arithmetic.fence.v2f16(<2 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3f16 = call <3 x half> @llvm.arithmetic.fence.v3f16(<3 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4f16 = call <4 x half> @llvm.arithmetic.fence.v4f16(<4 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5f16 = call <5 x half> @llvm.arithmetic.fence.v5f16(<5 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8f16 = call <8 x half> @llvm.arithmetic.fence.v8f16(<8 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16f16 = call <16 x half> @llvm.arithmetic.fence.v16f16(<16 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17f16 = call <17 x half> @llvm.arithmetic.fence.v17f16(<17 x half> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %f16 = call half @llvm.arithmetic.fence.f16(half undef)
  %v2f16 = call <2 x half> @llvm.arithmetic.fence.v2f16(<2 x half> undef)
  %v3f16 = call <3 x half> @llvm.arithmetic.fence.v3f16(<3 x half> undef)
  %v4f16 = call <4 x half> @llvm.arithmetic.fence.v4f16(<4 x half> undef)
  %v5f16 = call <5 x half> @llvm.arithmetic.fence.v5f16(<5 x half> undef)
  %v8f16 = call <8 x half> @llvm.arithmetic.fence.v8f16(<8 x half> undef)
  %v16f16 = call <16 x half> @llvm.arithmetic.fence.v16f16(<16 x half> undef)
  %v17f16 = call <17 x half> @llvm.arithmetic.fence.v17f16(<17 x half> undef)
  ret void
}

define void @arithmetic_fence_bf16() {
; ALL-LABEL: 'arithmetic_fence_bf16'
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %bf16 = call bfloat @llvm.arithmetic.fence.bf16(bfloat undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2bf16 = call <2 x bfloat> @llvm.arithmetic.fence.v2bf16(<2 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3bf16 = call <3 x bfloat> @llvm.arithmetic.fence.v3bf16(<3 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4bf16 = call <4 x bfloat> @llvm.arithmetic.fence.v4bf16(<4 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5bf16 = call <5 x bfloat> @llvm.arithmetic.fence.v5bf16(<5 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8bf16 = call <8 x bfloat> @llvm.arithmetic.fence.v8bf16(<8 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16bf16 = call <16 x bfloat> @llvm.arithmetic.fence.v16bf16(<16 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17bf16 = call <17 x bfloat> @llvm.arithmetic.fence.v17bf16(<17 x bfloat> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; ALL-SIZE-LABEL: 'arithmetic_fence_bf16'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %bf16 = call bfloat @llvm.arithmetic.fence.bf16(bfloat undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2bf16 = call <2 x bfloat> @llvm.arithmetic.fence.v2bf16(<2 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3bf16 = call <3 x bfloat> @llvm.arithmetic.fence.v3bf16(<3 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4bf16 = call <4 x bfloat> @llvm.arithmetic.fence.v4bf16(<4 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5bf16 = call <5 x bfloat> @llvm.arithmetic.fence.v5bf16(<5 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8bf16 = call <8 x bfloat> @llvm.arithmetic.fence.v8bf16(<8 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16bf16 = call <16 x bfloat> @llvm.arithmetic.fence.v16bf16(<16 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17bf16 = call <17 x bfloat> @llvm.arithmetic.fence.v17bf16(<17 x bfloat> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %bf16 = call bfloat @llvm.arithmetic.fence.bf16(bfloat undef)
  %v2bf16 = call <2 x bfloat> @llvm.arithmetic.fence.v2bf16(<2 x bfloat> undef)
  %v3bf16 = call <3 x bfloat> @llvm.arithmetic.fence.v3bf16(<3 x bfloat> undef)
  %v4bf16 = call <4 x bfloat> @llvm.arithmetic.fence.v4bf16(<4 x bfloat> undef)
  %v5bf16 = call <5 x bfloat> @llvm.arithmetic.fence.v5bf16(<5 x bfloat> undef)
  %v8bf16 = call <8 x bfloat> @llvm.arithmetic.fence.v8bf16(<8 x bfloat> undef)
  %v16bf16 = call <16 x bfloat> @llvm.arithmetic.fence.v16bf16(<16 x bfloat> undef)
  %v17bf16 = call <17 x bfloat> @llvm.arithmetic.fence.v17bf16(<17 x bfloat> undef)
  ret void
}

define void @arithmetic_fence_f32() {
; ALL-LABEL: 'arithmetic_fence_f32'
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %f32 = call float @llvm.arithmetic.fence.f32(float undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2f32 = call <2 x float> @llvm.arithmetic.fence.v2f32(<2 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3f32 = call <3 x float> @llvm.arithmetic.fence.v3f32(<3 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4f32 = call <4 x float> @llvm.arithmetic.fence.v4f32(<4 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5f32 = call <5 x float> @llvm.arithmetic.fence.v5f32(<5 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8f32 = call <8 x float> @llvm.arithmetic.fence.v8f32(<8 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16f32 = call <16 x float> @llvm.arithmetic.fence.v16f32(<16 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17f32 = call <17 x float> @llvm.arithmetic.fence.v17f32(<17 x float> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; ALL-SIZE-LABEL: 'arithmetic_fence_f32'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %f32 = call float @llvm.arithmetic.fence.f32(float undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2f32 = call <2 x float> @llvm.arithmetic.fence.v2f32(<2 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3f32 = call <3 x float> @llvm.arithmetic.fence.v3f32(<3 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4f32 = call <4 x float> @llvm.arithmetic.fence.v4f32(<4 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5f32 = call <5 x float> @llvm.arithmetic.fence.v5f32(<5 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8f32 = call <8 x float> @llvm.arithmetic.fence.v8f32(<8 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16f32 = call <16 x float> @llvm.arithmetic.fence.v16f32(<16 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17f32 = call <17 x float> @llvm.arithmetic.fence.v17f32(<17 x float> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %f32 = call float @llvm.arithmetic.fence.f32(float undef)
  %v2f32 = call <2 x float> @llvm.arithmetic.fence.v2f32(<2 x float> undef)
  %v3f32 = call <3 x float> @llvm.arithmetic.fence.v3f32(<3 x float> undef)
  %v4f32 = call <4 x float> @llvm.arithmetic.fence.v4f32(<4 x float> undef)
  %v5f32 = call <5 x float> @llvm.arithmetic.fence.v5f32(<5 x float> undef)
  %v8f32 = call <8 x float> @llvm.arithmetic.fence.v8f32(<8 x float> undef)
  %v16f32 = call <16 x float> @llvm.arithmetic.fence.v16f32(<16 x float> undef)
  %v17f32 = call <17 x float> @llvm.arithmetic.fence.v17f32(<17 x float> undef)
  ret void
}

define void @arithmetic_fence_f64() {
; ALL-LABEL: 'arithmetic_fence_f64'
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %f64 = call double @llvm.arithmetic.fence.f64(double undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2f64 = call <2 x double> @llvm.arithmetic.fence.v2f64(<2 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3f64 = call <3 x double> @llvm.arithmetic.fence.v3f64(<3 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4f64 = call <4 x double> @llvm.arithmetic.fence.v4f64(<4 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5f64 = call <5 x double> @llvm.arithmetic.fence.v5f64(<5 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8f64 = call <8 x double> @llvm.arithmetic.fence.v8f64(<8 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16f64 = call <16 x double> @llvm.arithmetic.fence.v16f64(<16 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17f64 = call <17 x double> @llvm.arithmetic.fence.v17f64(<17 x double> undef)
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; ALL-SIZE-LABEL: 'arithmetic_fence_f64'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %f64 = call double @llvm.arithmetic.fence.f64(double undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v2f64 = call <2 x double> @llvm.arithmetic.fence.v2f64(<2 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v3f64 = call <3 x double> @llvm.arithmetic.fence.v3f64(<3 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v4f64 = call <4 x double> @llvm.arithmetic.fence.v4f64(<4 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v5f64 = call <5 x double> @llvm.arithmetic.fence.v5f64(<5 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v8f64 = call <8 x double> @llvm.arithmetic.fence.v8f64(<8 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v16f64 = call <16 x double> @llvm.arithmetic.fence.v16f64(<16 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %v17f64 = call <17 x double> @llvm.arithmetic.fence.v17f64(<17 x double> undef)
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %f64 = call double @llvm.arithmetic.fence.f64(double undef)
  %v2f64 = call <2 x double> @llvm.arithmetic.fence.v2f64(<2 x double> undef)
  %v3f64 = call <3 x double> @llvm.arithmetic.fence.v3f64(<3 x double> undef)
  %v4f64 = call <4 x double> @llvm.arithmetic.fence.v4f64(<4 x double> undef)
  %v5f64 = call <5 x double> @llvm.arithmetic.fence.v5f64(<5 x double> undef)
  %v8f64 = call <8 x double> @llvm.arithmetic.fence.v8f64(<8 x double> undef)
  %v16f64 = call <16 x double> @llvm.arithmetic.fence.v16f64(<16 x double> undef)
  %v17f64 = call <17 x double> @llvm.arithmetic.fence.v17f64(<17 x double> undef)
  ret void
}

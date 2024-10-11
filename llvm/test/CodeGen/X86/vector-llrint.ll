; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=avx | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=avx512f | FileCheck %s --check-prefixes=AVX,AVX512
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=avx512dq,avx512vl | FileCheck %s --check-prefixes=AVX512DQ

define <1 x i64> @llrint_v1i64_v1f32(<1 x float> %x) {
; SSE-LABEL: llrint_v1i64_v1f32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtss2si %xmm0, %rax
; SSE-NEXT:    retq
;
; AVX-LABEL: llrint_v1i64_v1f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtss2si %xmm0, %rax
; AVX-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v1i64_v1f32:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtss2si %xmm0, %rax
; AVX512DQ-NEXT:    retq
  %a = call <1 x i64> @llvm.llrint.v1i64.v1f32(<1 x float> %x)
  ret <1 x i64> %a
}
declare <1 x i64> @llvm.llrint.v1i64.v1f32(<1 x float>)

define <2 x i64> @llrint_v2i64_v2f32(<2 x float> %x) {
; SSE-LABEL: llrint_v2i64_v2f32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtss2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm1
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE-NEXT:    cvtss2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: llrint_v2i64_v2f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtss2si %xmm0, %rax
; AVX-NEXT:    vmovq %rax, %xmm1
; AVX-NEXT:    vmovshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX-NEXT:    vcvtss2si %xmm0, %rax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v2i64_v2f32:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtps2qq %xmm0, %xmm0
; AVX512DQ-NEXT:    retq
  %a = call <2 x i64> @llvm.llrint.v2i64.v2f32(<2 x float> %x)
  ret <2 x i64> %a
}
declare <2 x i64> @llvm.llrint.v2i64.v2f32(<2 x float>)

define <4 x i64> @llrint_v4i64_v4f32(<4 x float> %x) {
; SSE-LABEL: llrint_v4i64_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtss2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm2
; SSE-NEXT:    movaps %xmm0, %xmm1
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE-NEXT:    cvtss2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm1
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm1[0]
; SSE-NEXT:    movaps %xmm0, %xmm1
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[3,3],xmm0[3,3]
; SSE-NEXT:    cvtss2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm3
; SSE-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    cvtss2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm1
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm3[0]
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: llrint_v4i64_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vshufps {{.*#+}} xmm1 = xmm0[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; AVX1-NEXT:    vcvtss2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX1-NEXT:    vcvtss2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX512-LABEL: llrint_v4i64_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vshufps {{.*#+}} xmm1 = xmm0[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm1
; AVX512-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; AVX512-NEXT:    vcvtss2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm0
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; AVX512-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v4i64_v4f32:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtps2qq %xmm0, %ymm0
; AVX512DQ-NEXT:    retq
  %a = call <4 x i64> @llvm.llrint.v4i64.v4f32(<4 x float> %x)
  ret <4 x i64> %a
}
declare <4 x i64> @llvm.llrint.v4i64.v4f32(<4 x float>)

define <8 x i64> @llrint_v8i64_v8f32(<8 x float> %x) {
; SSE-LABEL: llrint_v8i64_v8f32:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps %xmm0, %xmm2
; SSE-NEXT:    cvtss2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    movaps %xmm2, %xmm3
; SSE-NEXT:    shufps {{.*#+}} xmm3 = xmm3[1,1],xmm2[1,1]
; SSE-NEXT:    cvtss2si %xmm3, %rax
; SSE-NEXT:    movq %rax, %xmm3
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm3[0]
; SSE-NEXT:    movaps %xmm2, %xmm3
; SSE-NEXT:    shufps {{.*#+}} xmm3 = xmm3[3,3],xmm2[3,3]
; SSE-NEXT:    cvtss2si %xmm3, %rax
; SSE-NEXT:    movq %rax, %xmm3
; SSE-NEXT:    movhlps {{.*#+}} xmm2 = xmm2[1,1]
; SSE-NEXT:    cvtss2si %xmm2, %rax
; SSE-NEXT:    movq %rax, %xmm4
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm4 = xmm4[0],xmm3[0]
; SSE-NEXT:    cvtss2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm2
; SSE-NEXT:    movaps %xmm1, %xmm3
; SSE-NEXT:    shufps {{.*#+}} xmm3 = xmm3[1,1],xmm1[1,1]
; SSE-NEXT:    cvtss2si %xmm3, %rax
; SSE-NEXT:    movq %rax, %xmm3
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm3[0]
; SSE-NEXT:    movaps %xmm1, %xmm3
; SSE-NEXT:    shufps {{.*#+}} xmm3 = xmm3[3,3],xmm1[3,3]
; SSE-NEXT:    cvtss2si %xmm3, %rax
; SSE-NEXT:    movq %rax, %xmm5
; SSE-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    cvtss2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm3
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm5[0]
; SSE-NEXT:    movdqa %xmm4, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: llrint_v8i64_v8f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vshufps {{.*#+}} xmm1 = xmm0[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; AVX1-NEXT:    vcvtss2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX1-NEXT:    vcvtss2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm3 = xmm0[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm3, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm3[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm2, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm0
; AVX1-NEXT:    vshufps {{.*#+}} xmm1 = xmm0[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vshufpd {{.*#+}} xmm3 = xmm0[1,0]
; AVX1-NEXT:    vcvtss2si %xmm3, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm3[0],xmm1[0]
; AVX1-NEXT:    vcvtss2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm3[0],xmm0[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm1
; AVX1-NEXT:    vmovaps %ymm2, %ymm0
; AVX1-NEXT:    retq
;
; AVX512-LABEL: llrint_v8i64_v8f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm2 = xmm1[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm3 = xmm1[1,0]
; AVX512-NEXT:    vcvtss2si %xmm3, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm1
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm3[0],xmm1[0]
; AVX512-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm2 = xmm0[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm3 = xmm0[1,0]
; AVX512-NEXT:    vcvtss2si %xmm3, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm0
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm3[0],xmm0[0]
; AVX512-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm0
; AVX512-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; AVX512-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v8i64_v8f32:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtps2qq %ymm0, %zmm0
; AVX512DQ-NEXT:    retq
  %a = call <8 x i64> @llvm.llrint.v8i64.v8f32(<8 x float> %x)
  ret <8 x i64> %a
}
declare <8 x i64> @llvm.llrint.v8i64.v8f32(<8 x float>)

define <16 x i64> @llrint_v16i64_v16f32(<16 x float> %x) {
; SSE-LABEL: llrint_v16i64_v16f32:
; SSE:       # %bb.0:
; SSE-NEXT:    movq %rdi, %rax
; SSE-NEXT:    cvtss2si %xmm0, %rcx
; SSE-NEXT:    movq %rcx, %xmm4
; SSE-NEXT:    movaps %xmm0, %xmm5
; SSE-NEXT:    shufps {{.*#+}} xmm5 = xmm5[1,1],xmm0[1,1]
; SSE-NEXT:    cvtss2si %xmm5, %rcx
; SSE-NEXT:    movq %rcx, %xmm5
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm4 = xmm4[0],xmm5[0]
; SSE-NEXT:    movaps %xmm0, %xmm5
; SSE-NEXT:    shufps {{.*#+}} xmm5 = xmm5[3,3],xmm0[3,3]
; SSE-NEXT:    cvtss2si %xmm5, %rcx
; SSE-NEXT:    movq %rcx, %xmm5
; SSE-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    cvtss2si %xmm0, %rcx
; SSE-NEXT:    movq %rcx, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm5[0]
; SSE-NEXT:    cvtss2si %xmm1, %rcx
; SSE-NEXT:    movq %rcx, %xmm5
; SSE-NEXT:    movaps %xmm1, %xmm6
; SSE-NEXT:    shufps {{.*#+}} xmm6 = xmm6[1,1],xmm1[1,1]
; SSE-NEXT:    cvtss2si %xmm6, %rcx
; SSE-NEXT:    movq %rcx, %xmm6
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm5 = xmm5[0],xmm6[0]
; SSE-NEXT:    movaps %xmm1, %xmm6
; SSE-NEXT:    shufps {{.*#+}} xmm6 = xmm6[3,3],xmm1[3,3]
; SSE-NEXT:    cvtss2si %xmm6, %rcx
; SSE-NEXT:    movq %rcx, %xmm6
; SSE-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    cvtss2si %xmm1, %rcx
; SSE-NEXT:    movq %rcx, %xmm1
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm6[0]
; SSE-NEXT:    cvtss2si %xmm2, %rcx
; SSE-NEXT:    movq %rcx, %xmm6
; SSE-NEXT:    movaps %xmm2, %xmm7
; SSE-NEXT:    shufps {{.*#+}} xmm7 = xmm7[1,1],xmm2[1,1]
; SSE-NEXT:    cvtss2si %xmm7, %rcx
; SSE-NEXT:    movq %rcx, %xmm7
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm6 = xmm6[0],xmm7[0]
; SSE-NEXT:    movaps %xmm2, %xmm7
; SSE-NEXT:    shufps {{.*#+}} xmm7 = xmm7[3,3],xmm2[3,3]
; SSE-NEXT:    cvtss2si %xmm7, %rcx
; SSE-NEXT:    movq %rcx, %xmm7
; SSE-NEXT:    movhlps {{.*#+}} xmm2 = xmm2[1,1]
; SSE-NEXT:    cvtss2si %xmm2, %rcx
; SSE-NEXT:    movq %rcx, %xmm2
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm7[0]
; SSE-NEXT:    cvtss2si %xmm3, %rcx
; SSE-NEXT:    movq %rcx, %xmm7
; SSE-NEXT:    movaps %xmm3, %xmm8
; SSE-NEXT:    shufps {{.*#+}} xmm8 = xmm8[1,1],xmm3[1,1]
; SSE-NEXT:    cvtss2si %xmm8, %rcx
; SSE-NEXT:    movq %rcx, %xmm8
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm7 = xmm7[0],xmm8[0]
; SSE-NEXT:    movaps %xmm3, %xmm8
; SSE-NEXT:    shufps {{.*#+}} xmm8 = xmm8[3,3],xmm3[3,3]
; SSE-NEXT:    cvtss2si %xmm8, %rcx
; SSE-NEXT:    movq %rcx, %xmm8
; SSE-NEXT:    movhlps {{.*#+}} xmm3 = xmm3[1,1]
; SSE-NEXT:    cvtss2si %xmm3, %rcx
; SSE-NEXT:    movq %rcx, %xmm3
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm8[0]
; SSE-NEXT:    movdqa %xmm3, 112(%rdi)
; SSE-NEXT:    movdqa %xmm7, 96(%rdi)
; SSE-NEXT:    movdqa %xmm2, 80(%rdi)
; SSE-NEXT:    movdqa %xmm6, 64(%rdi)
; SSE-NEXT:    movdqa %xmm1, 48(%rdi)
; SSE-NEXT:    movdqa %xmm5, 32(%rdi)
; SSE-NEXT:    movdqa %xmm0, 16(%rdi)
; SSE-NEXT:    movdqa %xmm4, (%rdi)
; SSE-NEXT:    retq
;
; AVX1-LABEL: llrint_v16i64_v16f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovaps %ymm0, %ymm2
; AVX1-NEXT:    vshufps {{.*#+}} xmm0 = xmm2[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm0
; AVX1-NEXT:    vshufpd {{.*#+}} xmm3 = xmm2[1,0]
; AVX1-NEXT:    vcvtss2si %xmm3, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm3[0],xmm0[0]
; AVX1-NEXT:    vcvtss2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm4 = xmm2[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm4, %rax
; AVX1-NEXT:    vmovq %rax, %xmm4
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm4[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm3, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm2, %xmm2
; AVX1-NEXT:    vshufps {{.*#+}} xmm3 = xmm2[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm3, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vshufpd {{.*#+}} xmm4 = xmm2[1,0]
; AVX1-NEXT:    vcvtss2si %xmm4, %rax
; AVX1-NEXT:    vmovq %rax, %xmm4
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm4[0],xmm3[0]
; AVX1-NEXT:    vcvtss2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm4
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm2 = xmm2[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm4[0],xmm2[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm2, %ymm4
; AVX1-NEXT:    vshufps {{.*#+}} xmm2 = xmm1[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vshufpd {{.*#+}} xmm3 = xmm1[1,0]
; AVX1-NEXT:    vcvtss2si %xmm3, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX1-NEXT:    vcvtss2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm5 = xmm1[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm5, %rax
; AVX1-NEXT:    vmovq %rax, %xmm5
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm5[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm3, %ymm2
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm1
; AVX1-NEXT:    vshufps {{.*#+}} xmm3 = xmm1[3,3,3,3]
; AVX1-NEXT:    vcvtss2si %xmm3, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vshufpd {{.*#+}} xmm5 = xmm1[1,0]
; AVX1-NEXT:    vcvtss2si %xmm5, %rax
; AVX1-NEXT:    vmovq %rax, %xmm5
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm5[0],xmm3[0]
; AVX1-NEXT:    vcvtss2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm5
; AVX1-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vcvtss2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm5[0],xmm1[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm1, %ymm3
; AVX1-NEXT:    vmovaps %ymm4, %ymm1
; AVX1-NEXT:    retq
;
; AVX512-LABEL: llrint_v16i64_v16f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm2 = xmm1[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm3 = xmm1[1,0]
; AVX512-NEXT:    vcvtss2si %xmm3, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm1
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm3[0],xmm1[0]
; AVX512-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm2 = xmm0[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm3 = xmm0[1,0]
; AVX512-NEXT:    vcvtss2si %xmm3, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm4 = xmm0[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm4, %rax
; AVX512-NEXT:    vmovq %rax, %xmm4
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm4[0]
; AVX512-NEXT:    vinserti128 $1, %xmm2, %ymm3, %ymm2
; AVX512-NEXT:    vinserti64x4 $1, %ymm1, %zmm2, %zmm2
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm3 = xmm1[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm3, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vshufpd {{.*#+}} xmm4 = xmm1[1,0]
; AVX512-NEXT:    vcvtss2si %xmm4, %rax
; AVX512-NEXT:    vmovq %rax, %xmm4
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm4[0],xmm3[0]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm4
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm1
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm4[0],xmm1[0]
; AVX512-NEXT:    vinserti128 $1, %xmm3, %ymm1, %ymm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm3 = xmm0[3,3,3,3]
; AVX512-NEXT:    vcvtss2si %xmm3, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vshufpd {{.*#+}} xmm4 = xmm0[1,0]
; AVX512-NEXT:    vcvtss2si %xmm4, %rax
; AVX512-NEXT:    vmovq %rax, %xmm4
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm3 = xmm4[0],xmm3[0]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm4
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX512-NEXT:    vcvtss2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm0
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm4[0],xmm0[0]
; AVX512-NEXT:    vinserti128 $1, %xmm3, %ymm0, %ymm0
; AVX512-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm1
; AVX512-NEXT:    vmovdqa64 %zmm2, %zmm0
; AVX512-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v16i64_v16f32:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtps2qq %ymm0, %zmm2
; AVX512DQ-NEXT:    vextractf64x4 $1, %zmm0, %ymm0
; AVX512DQ-NEXT:    vcvtps2qq %ymm0, %zmm1
; AVX512DQ-NEXT:    vmovaps %zmm2, %zmm0
; AVX512DQ-NEXT:    retq
  %a = call <16 x i64> @llvm.llrint.v16i64.v16f32(<16 x float> %x)
  ret <16 x i64> %a
}
declare <16 x i64> @llvm.llrint.v16i64.v16f32(<16 x float>)

define <1 x i64> @llrint_v1i64_v1f64(<1 x double> %x) {
; SSE-LABEL: llrint_v1i64_v1f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    retq
;
; AVX-LABEL: llrint_v1i64_v1f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtsd2si %xmm0, %rax
; AVX-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v1i64_v1f64:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtsd2si %xmm0, %rax
; AVX512DQ-NEXT:    retq
  %a = call <1 x i64> @llvm.llrint.v1i64.v1f64(<1 x double> %x)
  ret <1 x i64> %a
}
declare <1 x i64> @llvm.llrint.v1i64.v1f64(<1 x double>)

define <2 x i64> @llrint_v2i64_v2f64(<2 x double> %x) {
; SSE-LABEL: llrint_v2i64_v2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: llrint_v2i64_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtsd2si %xmm0, %rax
; AVX-NEXT:    vmovq %rax, %xmm1
; AVX-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1,0]
; AVX-NEXT:    vcvtsd2si %xmm0, %rax
; AVX-NEXT:    vmovq %rax, %xmm0
; AVX-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; AVX-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v2i64_v2f64:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtpd2qq %xmm0, %xmm0
; AVX512DQ-NEXT:    retq
  %a = call <2 x i64> @llvm.llrint.v2i64.v2f64(<2 x double> %x)
  ret <2 x i64> %a
}
declare <2 x i64> @llvm.llrint.v2i64.v2f64(<2 x double>)

define <4 x i64> @llrint_v4i64_v4f64(<4 x double> %x) {
; SSE-LABEL: llrint_v4i64_v4f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm2
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm0[0]
; SSE-NEXT:    cvtsd2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm3
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    cvtsd2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm0[0]
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    movdqa %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: llrint_v4i64_v4f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vcvtsd2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vshufpd {{.*#+}} xmm1 = xmm1[1,0]
; AVX1-NEXT:    vcvtsd2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX1-NEXT:    vcvtsd2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1,0]
; AVX1-NEXT:    vcvtsd2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX512-LABEL: llrint_v4i64_v4f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vcvtsd2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm1 = xmm1[1,0]
; AVX512-NEXT:    vcvtsd2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm1
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX512-NEXT:    vcvtsd2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1,0]
; AVX512-NEXT:    vcvtsd2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm0
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; AVX512-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v4i64_v4f64:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtpd2qq %ymm0, %ymm0
; AVX512DQ-NEXT:    retq
  %a = call <4 x i64> @llvm.llrint.v4i64.v4f64(<4 x double> %x)
  ret <4 x i64> %a
}
declare <4 x i64> @llvm.llrint.v4i64.v4f64(<4 x double>)

define <8 x i64> @llrint_v8i64_v8f64(<8 x double> %x) {
; SSE-LABEL: llrint_v8i64_v8f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm4
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1,1]
; SSE-NEXT:    cvtsd2si %xmm0, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm4 = xmm4[0],xmm0[0]
; SSE-NEXT:    cvtsd2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm5
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1,1]
; SSE-NEXT:    cvtsd2si %xmm1, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm5 = xmm5[0],xmm0[0]
; SSE-NEXT:    cvtsd2si %xmm2, %rax
; SSE-NEXT:    movq %rax, %xmm6
; SSE-NEXT:    unpckhpd {{.*#+}} xmm2 = xmm2[1,1]
; SSE-NEXT:    cvtsd2si %xmm2, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm6 = xmm6[0],xmm0[0]
; SSE-NEXT:    cvtsd2si %xmm3, %rax
; SSE-NEXT:    movq %rax, %xmm7
; SSE-NEXT:    unpckhpd {{.*#+}} xmm3 = xmm3[1,1]
; SSE-NEXT:    cvtsd2si %xmm3, %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm7 = xmm7[0],xmm0[0]
; SSE-NEXT:    movdqa %xmm4, %xmm0
; SSE-NEXT:    movdqa %xmm5, %xmm1
; SSE-NEXT:    movdqa %xmm6, %xmm2
; SSE-NEXT:    movdqa %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: llrint_v8i64_v8f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX1-NEXT:    vcvtsd2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vshufpd {{.*#+}} xmm2 = xmm2[1,0]
; AVX1-NEXT:    vcvtsd2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX1-NEXT:    vcvtsd2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1,0]
; AVX1-NEXT:    vcvtsd2si %xmm0, %rax
; AVX1-NEXT:    vmovq %rax, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm3[0],xmm0[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vcvtsd2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vshufpd {{.*#+}} xmm2 = xmm2[1,0]
; AVX1-NEXT:    vcvtsd2si %xmm2, %rax
; AVX1-NEXT:    vmovq %rax, %xmm2
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX1-NEXT:    vcvtsd2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm3
; AVX1-NEXT:    vshufpd {{.*#+}} xmm1 = xmm1[1,0]
; AVX1-NEXT:    vcvtsd2si %xmm1, %rax
; AVX1-NEXT:    vmovq %rax, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm3[0],xmm1[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX512-LABEL: llrint_v8i64_v8f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf32x4 $3, %zmm0, %xmm1
; AVX512-NEXT:    vcvtsd2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vshufpd {{.*#+}} xmm1 = xmm1[1,0]
; AVX512-NEXT:    vcvtsd2si %xmm1, %rax
; AVX512-NEXT:    vmovq %rax, %xmm1
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX512-NEXT:    vextractf32x4 $2, %zmm0, %xmm2
; AVX512-NEXT:    vcvtsd2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vshufpd {{.*#+}} xmm2 = xmm2[1,0]
; AVX512-NEXT:    vcvtsd2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX512-NEXT:    vinserti128 $1, %xmm1, %ymm2, %ymm1
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm2
; AVX512-NEXT:    vcvtsd2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vshufpd {{.*#+}} xmm2 = xmm2[1,0]
; AVX512-NEXT:    vcvtsd2si %xmm2, %rax
; AVX512-NEXT:    vmovq %rax, %xmm2
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm2 = xmm3[0],xmm2[0]
; AVX512-NEXT:    vcvtsd2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm3
; AVX512-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1,0]
; AVX512-NEXT:    vcvtsd2si %xmm0, %rax
; AVX512-NEXT:    vmovq %rax, %xmm0
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm3[0],xmm0[0]
; AVX512-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm0
; AVX512-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; AVX512-NEXT:    retq
;
; AVX512DQ-LABEL: llrint_v8i64_v8f64:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vcvtpd2qq %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
  %a = call <8 x i64> @llvm.llrint.v8i64.v8f64(<8 x double> %x)
  ret <8 x i64> %a
}
declare <8 x i64> @llvm.llrint.v8i64.v8f64(<8 x double>)

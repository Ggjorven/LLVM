; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=icelake-server  | FileCheck %s --check-prefixes=CHECK,CHECK-ICX,CHECK-ICX-NO-BYPASS-DELAY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=icelake-server -mattr=-no-bypass-delay-shuffle | FileCheck %s --check-prefixes=CHECK,CHECK-ICX,CHECK-ICX-BYPASS-DELAY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64-v4  | FileCheck %s --check-prefixes=CHECK,CHECK-V4
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vl,+avx512bw,+avx512dq  | FileCheck %s --check-prefixes=CHECK,CHECK-AVX512
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=znver4  | FileCheck %s --check-prefixes=CHECK,CHECK-ZNVER4
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=znver5  | FileCheck %s --check-prefixes=CHECK,CHECK-ZNVER4

define <16 x float> @transform_VPERMILPSZrr(<16 x float> %a) nounwind {
; CHECK-LABEL: transform_VPERMILPSZrr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vshufps {{.*#+}} zmm0 = zmm0[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    retq
  %shufp = shufflevector <16 x float> %a, <16 x float> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  ret <16 x float> %shufp
}

define <8 x float> @transform_VPERMILPSYrr(<8 x float> %a) nounwind {
; CHECK-LABEL: transform_VPERMILPSYrr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vshufps {{.*#+}} ymm0 = ymm0[3,2,1,0,7,6,5,4]
; CHECK-NEXT:    retq
  %shufp = shufflevector <8 x float> %a, <8 x float> poison, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  ret <8 x float> %shufp
}

define <4 x float> @transform_VPERMILPSrr(<4 x float> %a) nounwind {
; CHECK-LABEL: transform_VPERMILPSrr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[3,2,1,0]
; CHECK-NEXT:    retq
  %shufp = shufflevector <4 x float> %a, <4 x float> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x float> %shufp
}

define <16 x float> @transform_VPERMILPSZrrkz(<16 x float> %a, i16 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSZrrkz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %edi, %k1
; CHECK-NEXT:    vshufps {{.*#+}} zmm0 {%k1} {z} = zmm0[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    retq
  %mask = bitcast i16 %mask_int to <16 x i1>
  %shufp = shufflevector <16 x float> %a, <16 x float> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %res = select <16 x i1> %mask, <16 x float> %shufp, <16 x float> zeroinitializer
  ret <16 x float> %res
}

define <8 x float> @transform_VPERMILPSYrrkz(<8 x float> %a, i8 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSYrrkz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %edi, %k1
; CHECK-NEXT:    vshufps {{.*#+}} ymm0 {%k1} {z} = ymm0[3,2,1,0,7,6,5,4]
; CHECK-NEXT:    retq
  %mask = bitcast i8 %mask_int to <8 x i1>
  %shufp = shufflevector <8 x float> %a, <8 x float> poison, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %res = select <8 x i1> %mask, <8 x float> %shufp, <8 x float> zeroinitializer
  ret <8 x float> %res
}

define <4 x float> @transform_VPERMILPSrrkz(<4 x float> %a, i4 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSrrkz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %edi, %k1
; CHECK-NEXT:    vshufps {{.*#+}} xmm0 {%k1} {z} = xmm0[3,2,1,0]
; CHECK-NEXT:    retq
  %mask = bitcast i4 %mask_int to <4 x i1>
  %shufp = shufflevector <4 x float> %a, <4 x float> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %res = select <4 x i1> %mask, <4 x float> %shufp, <4 x float> zeroinitializer
  ret <4 x float> %res
}

define <16 x float> @transform_VPERMILPSZrrk(<16 x float> %a, <16 x float> %b, i16 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSZrrk:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %edi, %k1
; CHECK-NEXT:    vshufps {{.*#+}} zmm1 {%k1} = zmm0[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    vmovaps %zmm1, %zmm0
; CHECK-NEXT:    retq
  %mask = bitcast i16 %mask_int to <16 x i1>
  %shufp = shufflevector <16 x float> %a, <16 x float> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %res = select <16 x i1> %mask, <16 x float> %shufp, <16 x float> %b
  ret <16 x float> %res
}

define <8 x float> @transform_VPERMILPSYrrk(<8 x float> %a, <8 x float> %b, i8 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSYrrk:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %edi, %k1
; CHECK-NEXT:    vshufps {{.*#+}} ymm1 {%k1} = ymm0[3,2,1,0,7,6,5,4]
; CHECK-NEXT:    vmovaps %ymm1, %ymm0
; CHECK-NEXT:    retq
  %mask = bitcast i8 %mask_int to <8 x i1>
  %shufp = shufflevector <8 x float> %a, <8 x float> poison, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %res = select <8 x i1> %mask, <8 x float> %shufp, <8 x float> %b
  ret <8 x float> %res
}

define <4 x float> @transform_VPERMILPSrrk(<4 x float> %a, <4 x float> %b, i4 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSrrk:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %edi, %k1
; CHECK-NEXT:    vshufps {{.*#+}} xmm1 {%k1} = xmm0[3,2,1,0]
; CHECK-NEXT:    vmovaps %xmm1, %xmm0
; CHECK-NEXT:    retq
  %mask = bitcast i4 %mask_int to <4 x i1>
  %shufp = shufflevector <4 x float> %a, <4 x float> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %res = select <4 x i1> %mask, <4 x float> %shufp, <4 x float> %b
  ret <4 x float> %res
}

define <16 x float> @transform_VPERMILPSZrm(ptr %ap) nounwind {
; CHECK-LABEL: transform_VPERMILPSZrm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpermilps {{.*#+}} zmm0 = mem[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    retq
  %a = load <16 x float>, ptr %ap
  %shufp = shufflevector <16 x float> %a, <16 x float> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  ret <16 x float> %shufp
}

define <8 x float> @transform_VPERMILPSYrm(ptr %ap) nounwind {
; CHECK-ICX-NO-BYPASS-DELAY-LABEL: transform_VPERMILPSYrm:
; CHECK-ICX-NO-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    vpshufd {{.*#+}} ymm0 = mem[3,2,1,0,7,6,5,4]
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    retq
;
; CHECK-ICX-BYPASS-DELAY-LABEL: transform_VPERMILPSYrm:
; CHECK-ICX-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-BYPASS-DELAY-NEXT:    vpermilps {{.*#+}} ymm0 = mem[3,2,1,0,7,6,5,4]
; CHECK-ICX-BYPASS-DELAY-NEXT:    retq
;
; CHECK-V4-LABEL: transform_VPERMILPSYrm:
; CHECK-V4:       # %bb.0:
; CHECK-V4-NEXT:    vpermilps {{.*#+}} ymm0 = mem[3,2,1,0,7,6,5,4]
; CHECK-V4-NEXT:    retq
;
; CHECK-AVX512-LABEL: transform_VPERMILPSYrm:
; CHECK-AVX512:       # %bb.0:
; CHECK-AVX512-NEXT:    vpermilps {{.*#+}} ymm0 = mem[3,2,1,0,7,6,5,4]
; CHECK-AVX512-NEXT:    retq
;
; CHECK-ZNVER4-LABEL: transform_VPERMILPSYrm:
; CHECK-ZNVER4:       # %bb.0:
; CHECK-ZNVER4-NEXT:    vpermilps {{.*#+}} ymm0 = mem[3,2,1,0,7,6,5,4]
; CHECK-ZNVER4-NEXT:    retq
  %a = load <8 x float>, ptr %ap
  %shufp = shufflevector <8 x float> %a, <8 x float> poison, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  ret <8 x float> %shufp
}

define <4 x float> @transform_VPERMILPSrm(ptr %ap) nounwind {
; CHECK-ICX-NO-BYPASS-DELAY-LABEL: transform_VPERMILPSrm:
; CHECK-ICX-NO-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    vpshufd {{.*#+}} xmm0 = mem[3,2,1,0]
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    retq
;
; CHECK-ICX-BYPASS-DELAY-LABEL: transform_VPERMILPSrm:
; CHECK-ICX-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-BYPASS-DELAY-NEXT:    vpermilps {{.*#+}} xmm0 = mem[3,2,1,0]
; CHECK-ICX-BYPASS-DELAY-NEXT:    retq
;
; CHECK-V4-LABEL: transform_VPERMILPSrm:
; CHECK-V4:       # %bb.0:
; CHECK-V4-NEXT:    vpermilps {{.*#+}} xmm0 = mem[3,2,1,0]
; CHECK-V4-NEXT:    retq
;
; CHECK-AVX512-LABEL: transform_VPERMILPSrm:
; CHECK-AVX512:       # %bb.0:
; CHECK-AVX512-NEXT:    vpermilps {{.*#+}} xmm0 = mem[3,2,1,0]
; CHECK-AVX512-NEXT:    retq
;
; CHECK-ZNVER4-LABEL: transform_VPERMILPSrm:
; CHECK-ZNVER4:       # %bb.0:
; CHECK-ZNVER4-NEXT:    vpermilps {{.*#+}} xmm0 = mem[3,2,1,0]
; CHECK-ZNVER4-NEXT:    retq
  %a = load <4 x float>, ptr %ap
  %shufp = shufflevector <4 x float> %a, <4 x float> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x float> %shufp
}

define <16 x float> @transform_VPERMILPSZrmkz(ptr %ap, i16 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSZrmkz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %esi, %k1
; CHECK-NEXT:    vpermilps {{.*#+}} zmm0 {%k1} {z} = mem[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    retq
  %mask = bitcast i16 %mask_int to <16 x i1>
  %a = load <16 x float>, ptr %ap
  %shufp = shufflevector <16 x float> %a, <16 x float> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %res = select <16 x i1> %mask, <16 x float> %shufp, <16 x float> zeroinitializer
  ret <16 x float> %res
}

define <8 x float> @transform_VPERMILPSYrmkz(ptr %ap, i8 %mask_int) nounwind {
; CHECK-ICX-NO-BYPASS-DELAY-LABEL: transform_VPERMILPSYrmkz:
; CHECK-ICX-NO-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    vpshufd {{.*#+}} ymm0 {%k1} {z} = mem[3,2,1,0,7,6,5,4]
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    retq
;
; CHECK-ICX-BYPASS-DELAY-LABEL: transform_VPERMILPSYrmkz:
; CHECK-ICX-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-BYPASS-DELAY-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} {z} = mem[3,2,1,0,7,6,5,4]
; CHECK-ICX-BYPASS-DELAY-NEXT:    retq
;
; CHECK-V4-LABEL: transform_VPERMILPSYrmkz:
; CHECK-V4:       # %bb.0:
; CHECK-V4-NEXT:    kmovd %esi, %k1
; CHECK-V4-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} {z} = mem[3,2,1,0,7,6,5,4]
; CHECK-V4-NEXT:    retq
;
; CHECK-AVX512-LABEL: transform_VPERMILPSYrmkz:
; CHECK-AVX512:       # %bb.0:
; CHECK-AVX512-NEXT:    kmovd %esi, %k1
; CHECK-AVX512-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} {z} = mem[3,2,1,0,7,6,5,4]
; CHECK-AVX512-NEXT:    retq
;
; CHECK-ZNVER4-LABEL: transform_VPERMILPSYrmkz:
; CHECK-ZNVER4:       # %bb.0:
; CHECK-ZNVER4-NEXT:    kmovd %esi, %k1
; CHECK-ZNVER4-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} {z} = mem[3,2,1,0,7,6,5,4]
; CHECK-ZNVER4-NEXT:    retq
  %mask = bitcast i8 %mask_int to <8 x i1>
  %a = load <8 x float>, ptr %ap
  %shufp = shufflevector <8 x float> %a, <8 x float> poison, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %res = select <8 x i1> %mask, <8 x float> %shufp, <8 x float> zeroinitializer
  ret <8 x float> %res
}

define <4 x float> @transform_VPERMILPSrmkz(ptr %ap, i4 %mask_int) nounwind {
; CHECK-ICX-NO-BYPASS-DELAY-LABEL: transform_VPERMILPSrmkz:
; CHECK-ICX-NO-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    vpshufd {{.*#+}} xmm0 {%k1} {z} = mem[3,2,1,0]
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    retq
;
; CHECK-ICX-BYPASS-DELAY-LABEL: transform_VPERMILPSrmkz:
; CHECK-ICX-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-BYPASS-DELAY-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} {z} = mem[3,2,1,0]
; CHECK-ICX-BYPASS-DELAY-NEXT:    retq
;
; CHECK-V4-LABEL: transform_VPERMILPSrmkz:
; CHECK-V4:       # %bb.0:
; CHECK-V4-NEXT:    kmovd %esi, %k1
; CHECK-V4-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} {z} = mem[3,2,1,0]
; CHECK-V4-NEXT:    retq
;
; CHECK-AVX512-LABEL: transform_VPERMILPSrmkz:
; CHECK-AVX512:       # %bb.0:
; CHECK-AVX512-NEXT:    kmovd %esi, %k1
; CHECK-AVX512-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} {z} = mem[3,2,1,0]
; CHECK-AVX512-NEXT:    retq
;
; CHECK-ZNVER4-LABEL: transform_VPERMILPSrmkz:
; CHECK-ZNVER4:       # %bb.0:
; CHECK-ZNVER4-NEXT:    kmovd %esi, %k1
; CHECK-ZNVER4-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} {z} = mem[3,2,1,0]
; CHECK-ZNVER4-NEXT:    retq
  %mask = bitcast i4 %mask_int to <4 x i1>
  %a = load <4 x float>, ptr %ap
  %shufp = shufflevector <4 x float> %a, <4 x float> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %res = select <4 x i1> %mask, <4 x float> %shufp, <4 x float> zeroinitializer
  ret <4 x float> %res
}

define <16 x float> @transform_VPERMILPSZrmk(ptr %ap, <16 x float> %b, i16 %mask_int) nounwind {
; CHECK-LABEL: transform_VPERMILPSZrmk:
; CHECK:       # %bb.0:
; CHECK-NEXT:    kmovd %esi, %k1
; CHECK-NEXT:    vpermilps {{.*#+}} zmm0 {%k1} = mem[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    retq
  %mask = bitcast i16 %mask_int to <16 x i1>
  %a = load <16 x float>, ptr %ap
  %shufp = shufflevector <16 x float> %a, <16 x float> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %res = select <16 x i1> %mask, <16 x float> %shufp, <16 x float> %b
  ret <16 x float> %res
}

define <8 x float> @transform_VPERMILPSYrmk(ptr %ap, <8 x float> %b, i8 %mask_int) nounwind {
; CHECK-ICX-NO-BYPASS-DELAY-LABEL: transform_VPERMILPSYrmk:
; CHECK-ICX-NO-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    vpshufd {{.*#+}} ymm0 {%k1} = mem[3,2,1,0,7,6,5,4]
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    retq
;
; CHECK-ICX-BYPASS-DELAY-LABEL: transform_VPERMILPSYrmk:
; CHECK-ICX-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-BYPASS-DELAY-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} = mem[3,2,1,0,7,6,5,4]
; CHECK-ICX-BYPASS-DELAY-NEXT:    retq
;
; CHECK-V4-LABEL: transform_VPERMILPSYrmk:
; CHECK-V4:       # %bb.0:
; CHECK-V4-NEXT:    kmovd %esi, %k1
; CHECK-V4-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} = mem[3,2,1,0,7,6,5,4]
; CHECK-V4-NEXT:    retq
;
; CHECK-AVX512-LABEL: transform_VPERMILPSYrmk:
; CHECK-AVX512:       # %bb.0:
; CHECK-AVX512-NEXT:    kmovd %esi, %k1
; CHECK-AVX512-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} = mem[3,2,1,0,7,6,5,4]
; CHECK-AVX512-NEXT:    retq
;
; CHECK-ZNVER4-LABEL: transform_VPERMILPSYrmk:
; CHECK-ZNVER4:       # %bb.0:
; CHECK-ZNVER4-NEXT:    kmovd %esi, %k1
; CHECK-ZNVER4-NEXT:    vpermilps {{.*#+}} ymm0 {%k1} = mem[3,2,1,0,7,6,5,4]
; CHECK-ZNVER4-NEXT:    retq
  %mask = bitcast i8 %mask_int to <8 x i1>
  %a = load <8 x float>, ptr %ap
  %shufp = shufflevector <8 x float> %a, <8 x float> poison, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %res = select <8 x i1> %mask, <8 x float> %shufp, <8 x float> %b
  ret <8 x float> %res
}

define <4 x float> @transform_VPERMILPSrmk(ptr %ap, <4 x float> %b, i4 %mask_int) nounwind {
; CHECK-ICX-NO-BYPASS-DELAY-LABEL: transform_VPERMILPSrmk:
; CHECK-ICX-NO-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    vpshufd {{.*#+}} xmm0 {%k1} = mem[3,2,1,0]
; CHECK-ICX-NO-BYPASS-DELAY-NEXT:    retq
;
; CHECK-ICX-BYPASS-DELAY-LABEL: transform_VPERMILPSrmk:
; CHECK-ICX-BYPASS-DELAY:       # %bb.0:
; CHECK-ICX-BYPASS-DELAY-NEXT:    kmovd %esi, %k1
; CHECK-ICX-BYPASS-DELAY-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} = mem[3,2,1,0]
; CHECK-ICX-BYPASS-DELAY-NEXT:    retq
;
; CHECK-V4-LABEL: transform_VPERMILPSrmk:
; CHECK-V4:       # %bb.0:
; CHECK-V4-NEXT:    kmovd %esi, %k1
; CHECK-V4-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} = mem[3,2,1,0]
; CHECK-V4-NEXT:    retq
;
; CHECK-AVX512-LABEL: transform_VPERMILPSrmk:
; CHECK-AVX512:       # %bb.0:
; CHECK-AVX512-NEXT:    kmovd %esi, %k1
; CHECK-AVX512-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} = mem[3,2,1,0]
; CHECK-AVX512-NEXT:    retq
;
; CHECK-ZNVER4-LABEL: transform_VPERMILPSrmk:
; CHECK-ZNVER4:       # %bb.0:
; CHECK-ZNVER4-NEXT:    kmovd %esi, %k1
; CHECK-ZNVER4-NEXT:    vpermilps {{.*#+}} xmm0 {%k1} = mem[3,2,1,0]
; CHECK-ZNVER4-NEXT:    retq
  %mask = bitcast i4 %mask_int to <4 x i1>
  %a = load <4 x float>, ptr %ap
  %shufp = shufflevector <4 x float> %a, <4 x float> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %res = select <4 x i1> %mask, <4 x float> %shufp, <4 x float> %b
  ret <4 x float> %res
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-ICX: {{.*}}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avxifma --show-mc-encoding | FileCheck %s --check-prefix=AVXIFMA
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avxifma --show-mc-encoding | FileCheck %s --check-prefix=AVXIFMA
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avxifma,+avx512ifma,+avx512vl --show-mc-encoding | FileCheck %s --check-prefix=AVX512IFMA
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avxifma,+avx512ifma,+avx512vl --show-mc-encoding | FileCheck %s --check-prefix=AVX512IFMA

declare <2 x i64> @llvm.x86.avx512.vpmadd52h.uq.128(<2 x i64>, <2 x i64>, <2 x i64>)

define <2 x i64>@test_int_x86_avx_vpmadd52h_uq_128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2) {
; AVXIFMA-LABEL: test_int_x86_avx_vpmadd52h_uq_128:
; AVXIFMA:       # %bb.0:
; AVXIFMA-NEXT:    {vex} vpmadd52huq %xmm2, %xmm1, %xmm0 # encoding: [0xc4,0xe2,0xf1,0xb5,0xc2]
; AVXIFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512IFMA-LABEL: test_int_x86_avx_vpmadd52h_uq_128:
; AVX512IFMA:       # %bb.0:
; AVX512IFMA-NEXT:    {vex} vpmadd52huq %xmm2, %xmm1, %xmm0 # EVEX TO VEX Compression encoding: [0xc4,0xe2,0xf1,0xb5,0xc2]
; AVX512IFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.avx512.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2)
  ret <2 x i64> %res
}

declare <4 x i64> @llvm.x86.avx512.vpmadd52h.uq.256(<4 x i64>, <4 x i64>, <4 x i64>)

define <4 x i64>@test_int_x86_avx_vpmadd52h_uq_256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2) {
; AVXIFMA-LABEL: test_int_x86_avx_vpmadd52h_uq_256:
; AVXIFMA:       # %bb.0:
; AVXIFMA-NEXT:    {vex} vpmadd52huq %ymm2, %ymm1, %ymm0 # encoding: [0xc4,0xe2,0xf5,0xb5,0xc2]
; AVXIFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512IFMA-LABEL: test_int_x86_avx_vpmadd52h_uq_256:
; AVX512IFMA:       # %bb.0:
; AVX512IFMA-NEXT:    {vex} vpmadd52huq %ymm2, %ymm1, %ymm0 # EVEX TO VEX Compression encoding: [0xc4,0xe2,0xf5,0xb5,0xc2]
; AVX512IFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %res = call <4 x i64> @llvm.x86.avx512.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2)
  ret <4 x i64> %res
}

declare <2 x i64> @llvm.x86.avx512.vpmadd52l.uq.128(<2 x i64>, <2 x i64>, <2 x i64>)

define <2 x i64>@test_int_x86_avx_vpmadd52l_uq_128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2) {
; AVXIFMA-LABEL: test_int_x86_avx_vpmadd52l_uq_128:
; AVXIFMA:       # %bb.0:
; AVXIFMA-NEXT:    {vex} vpmadd52luq %xmm2, %xmm1, %xmm0 # encoding: [0xc4,0xe2,0xf1,0xb4,0xc2]
; AVXIFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512IFMA-LABEL: test_int_x86_avx_vpmadd52l_uq_128:
; AVX512IFMA:       # %bb.0:
; AVX512IFMA-NEXT:    {vex} vpmadd52luq %xmm2, %xmm1, %xmm0 # EVEX TO VEX Compression encoding: [0xc4,0xe2,0xf1,0xb4,0xc2]
; AVX512IFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %res = call <2 x i64> @llvm.x86.avx512.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2)
  ret <2 x i64> %res
}

declare <4 x i64> @llvm.x86.avx512.vpmadd52l.uq.256(<4 x i64>, <4 x i64>, <4 x i64>)

define <4 x i64>@test_int_x86_avx_vpmadd52l_uq_256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2) {
; AVXIFMA-LABEL: test_int_x86_avx_vpmadd52l_uq_256:
; AVXIFMA:       # %bb.0:
; AVXIFMA-NEXT:    {vex} vpmadd52luq %ymm2, %ymm1, %ymm0 # encoding: [0xc4,0xe2,0xf5,0xb4,0xc2]
; AVXIFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512IFMA-LABEL: test_int_x86_avx_vpmadd52l_uq_256:
; AVX512IFMA:       # %bb.0:
; AVX512IFMA-NEXT:    {vex} vpmadd52luq %ymm2, %ymm1, %ymm0 # EVEX TO VEX Compression encoding: [0xc4,0xe2,0xf5,0xb4,0xc2]
; AVX512IFMA-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %res = call <4 x i64> @llvm.x86.avx512.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2)
  ret <4 x i64> %res
}

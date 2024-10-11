; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+avx512vl -mattr=+avx512dq < %s | FileCheck %s --check-prefix=WIDEN_SKX
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+avx512f < %s | FileCheck %s --check-prefix=WIDEN_KNL
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake < %s | FileCheck %s --check-prefix=WIDEN_AVX2

define <2 x double> @test_gather_v2i32_index(ptr %base, <2 x i32> %ind, <2 x i1> %mask, <2 x double> %src0) {
; WIDEN_SKX-LABEL: test_gather_v2i32_index:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpmovq2m %xmm1, %k0
; WIDEN_SKX-NEXT:    vpbroadcastq %rdi, %xmm1
; WIDEN_SKX-NEXT:    vpmovsxdq %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vpsllq $3, %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; WIDEN_SKX-NEXT:    kmovw %k0, %eax
; WIDEN_SKX-NEXT:    testb $1, %al
; WIDEN_SKX-NEXT:    jne .LBB0_1
; WIDEN_SKX-NEXT:  # %bb.2: # %else
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    jne .LBB0_3
; WIDEN_SKX-NEXT:  .LBB0_4: # %else2
; WIDEN_SKX-NEXT:    vmovaps %xmm2, %xmm0
; WIDEN_SKX-NEXT:    retq
; WIDEN_SKX-NEXT:  .LBB0_1: # %cond.load
; WIDEN_SKX-NEXT:    vmovq %xmm0, %rcx
; WIDEN_SKX-NEXT:    vmovlps {{.*#+}} xmm2 = mem[0,1],xmm2[2,3]
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    je .LBB0_4
; WIDEN_SKX-NEXT:  .LBB0_3: # %cond.load1
; WIDEN_SKX-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_SKX-NEXT:    vmovhps {{.*#+}} xmm2 = xmm2[0,1],mem[0,1]
; WIDEN_SKX-NEXT:    vmovaps %xmm2, %xmm0
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_gather_v2i32_index:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vptestmq %zmm1, %zmm1, %k0
; WIDEN_KNL-NEXT:    vpmovsxdq %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vpsllq $3, %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vmovq %rdi, %xmm1
; WIDEN_KNL-NEXT:    vpbroadcastq %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; WIDEN_KNL-NEXT:    kmovw %k0, %eax
; WIDEN_KNL-NEXT:    testb $1, %al
; WIDEN_KNL-NEXT:    jne .LBB0_1
; WIDEN_KNL-NEXT:  # %bb.2: # %else
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    jne .LBB0_3
; WIDEN_KNL-NEXT:  .LBB0_4: # %else2
; WIDEN_KNL-NEXT:    vmovaps %xmm2, %xmm0
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
; WIDEN_KNL-NEXT:  .LBB0_1: # %cond.load
; WIDEN_KNL-NEXT:    vmovq %xmm0, %rcx
; WIDEN_KNL-NEXT:    vmovlps {{.*#+}} xmm2 = mem[0,1],xmm2[2,3]
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    je .LBB0_4
; WIDEN_KNL-NEXT:  .LBB0_3: # %cond.load1
; WIDEN_KNL-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_KNL-NEXT:    vmovhps {{.*#+}} xmm2 = xmm2[0,1],mem[0,1]
; WIDEN_KNL-NEXT:    vmovaps %xmm2, %xmm0
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_gather_v2i32_index:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vgatherdpd %xmm1, (%rdi,%xmm0,8), %xmm2
; WIDEN_AVX2-NEXT:    vmovapd %xmm2, %xmm0
; WIDEN_AVX2-NEXT:    retq
  %gep.random = getelementptr double, ptr %base, <2 x i32> %ind
  %res = call <2 x double> @llvm.masked.gather.v2f64.v2p0(<2 x ptr> %gep.random, i32 4, <2 x i1> %mask, <2 x double> %src0)
  ret <2 x double> %res
}

define void @test_scatter_v2i32_index(<2 x double> %a1, ptr %base, <2 x i32> %ind, <2 x i1> %mask) {
; WIDEN_SKX-LABEL: test_scatter_v2i32_index:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpmovq2m %xmm2, %k0
; WIDEN_SKX-NEXT:    vpbroadcastq %rdi, %xmm2
; WIDEN_SKX-NEXT:    vpmovsxdq %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpsllq $3, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpaddq %xmm1, %xmm2, %xmm1
; WIDEN_SKX-NEXT:    kmovw %k0, %eax
; WIDEN_SKX-NEXT:    testb $1, %al
; WIDEN_SKX-NEXT:    jne .LBB1_1
; WIDEN_SKX-NEXT:  # %bb.2: # %else
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    jne .LBB1_3
; WIDEN_SKX-NEXT:  .LBB1_4: # %else2
; WIDEN_SKX-NEXT:    retq
; WIDEN_SKX-NEXT:  .LBB1_1: # %cond.store
; WIDEN_SKX-NEXT:    vmovq %xmm1, %rcx
; WIDEN_SKX-NEXT:    vmovlps %xmm0, (%rcx)
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    je .LBB1_4
; WIDEN_SKX-NEXT:  .LBB1_3: # %cond.store1
; WIDEN_SKX-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_SKX-NEXT:    vmovhps %xmm0, (%rax)
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_scatter_v2i32_index:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vptestmq %zmm2, %zmm2, %k0
; WIDEN_KNL-NEXT:    vpmovsxdq %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpsllq $3, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vmovq %rdi, %xmm2
; WIDEN_KNL-NEXT:    vpbroadcastq %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpaddq %xmm1, %xmm2, %xmm1
; WIDEN_KNL-NEXT:    kmovw %k0, %eax
; WIDEN_KNL-NEXT:    testb $1, %al
; WIDEN_KNL-NEXT:    jne .LBB1_1
; WIDEN_KNL-NEXT:  # %bb.2: # %else
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    jne .LBB1_3
; WIDEN_KNL-NEXT:  .LBB1_4: # %else2
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
; WIDEN_KNL-NEXT:  .LBB1_1: # %cond.store
; WIDEN_KNL-NEXT:    vmovq %xmm1, %rcx
; WIDEN_KNL-NEXT:    vmovlps %xmm0, (%rcx)
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    je .LBB1_4
; WIDEN_KNL-NEXT:  .LBB1_3: # %cond.store1
; WIDEN_KNL-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_KNL-NEXT:    vmovhps %xmm0, (%rax)
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_scatter_v2i32_index:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpsllq $3, %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vmovq %rdi, %xmm3
; WIDEN_AVX2-NEXT:    vpbroadcastq %xmm3, %xmm3
; WIDEN_AVX2-NEXT:    vpaddq %xmm1, %xmm3, %xmm1
; WIDEN_AVX2-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_AVX2-NEXT:    vmovmskpd %xmm2, %eax
; WIDEN_AVX2-NEXT:    testb $1, %al
; WIDEN_AVX2-NEXT:    jne .LBB1_1
; WIDEN_AVX2-NEXT:  # %bb.2: # %else
; WIDEN_AVX2-NEXT:    testb $2, %al
; WIDEN_AVX2-NEXT:    jne .LBB1_3
; WIDEN_AVX2-NEXT:  .LBB1_4: # %else2
; WIDEN_AVX2-NEXT:    retq
; WIDEN_AVX2-NEXT:  .LBB1_1: # %cond.store
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rcx
; WIDEN_AVX2-NEXT:    vmovlps %xmm0, (%rcx)
; WIDEN_AVX2-NEXT:    testb $2, %al
; WIDEN_AVX2-NEXT:    je .LBB1_4
; WIDEN_AVX2-NEXT:  .LBB1_3: # %cond.store1
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovhps %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    retq
  %gep = getelementptr double, ptr%base, <2 x i32> %ind
  call void @llvm.masked.scatter.v2f64.v2p0(<2 x double> %a1, <2 x ptr> %gep, i32 4, <2 x i1> %mask)
  ret void
}

define <2 x i32> @test_gather_v2i32_data(<2 x ptr> %ptr, <2 x i1> %mask, <2 x i32> %src0) {
; WIDEN_SKX-LABEL: test_gather_v2i32_data:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpmovq2m %xmm1, %k0
; WIDEN_SKX-NEXT:    kmovw %k0, %eax
; WIDEN_SKX-NEXT:    testb $1, %al
; WIDEN_SKX-NEXT:    jne .LBB2_1
; WIDEN_SKX-NEXT:  # %bb.2: # %else
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    jne .LBB2_3
; WIDEN_SKX-NEXT:  .LBB2_4: # %else2
; WIDEN_SKX-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_SKX-NEXT:    retq
; WIDEN_SKX-NEXT:  .LBB2_1: # %cond.load
; WIDEN_SKX-NEXT:    vmovq %xmm0, %rcx
; WIDEN_SKX-NEXT:    vpinsrd $0, (%rcx), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    je .LBB2_4
; WIDEN_SKX-NEXT:  .LBB2_3: # %cond.load1
; WIDEN_SKX-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_SKX-NEXT:    vpinsrd $1, (%rax), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_gather_v2i32_data:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vptestmq %zmm1, %zmm1, %k0
; WIDEN_KNL-NEXT:    kmovw %k0, %eax
; WIDEN_KNL-NEXT:    testb $1, %al
; WIDEN_KNL-NEXT:    jne .LBB2_1
; WIDEN_KNL-NEXT:  # %bb.2: # %else
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    jne .LBB2_3
; WIDEN_KNL-NEXT:  .LBB2_4: # %else2
; WIDEN_KNL-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
; WIDEN_KNL-NEXT:  .LBB2_1: # %cond.load
; WIDEN_KNL-NEXT:    vmovq %xmm0, %rcx
; WIDEN_KNL-NEXT:    vpinsrd $0, (%rcx), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    je .LBB2_4
; WIDEN_KNL-NEXT:  .LBB2_3: # %cond.load1
; WIDEN_KNL-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_KNL-NEXT:    vpinsrd $1, (%rax), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_gather_v2i32_data:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; WIDEN_AVX2-NEXT:    vpslld $31, %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpgatherqd %xmm1, (,%xmm0), %xmm2
; WIDEN_AVX2-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_AVX2-NEXT:    retq
  %res = call <2 x i32> @llvm.masked.gather.v2i32.v2p0(<2 x ptr> %ptr, i32 4, <2 x i1> %mask, <2 x i32> %src0)
  ret <2 x i32>%res
}

define void @test_scatter_v2i32_data(<2 x i32>%a1, <2 x ptr> %ptr, <2 x i1>%mask) {
; WIDEN_SKX-LABEL: test_scatter_v2i32_data:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpmovq2m %xmm2, %k0
; WIDEN_SKX-NEXT:    kmovw %k0, %eax
; WIDEN_SKX-NEXT:    testb $1, %al
; WIDEN_SKX-NEXT:    jne .LBB3_1
; WIDEN_SKX-NEXT:  # %bb.2: # %else
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    jne .LBB3_3
; WIDEN_SKX-NEXT:  .LBB3_4: # %else2
; WIDEN_SKX-NEXT:    retq
; WIDEN_SKX-NEXT:  .LBB3_1: # %cond.store
; WIDEN_SKX-NEXT:    vmovq %xmm1, %rcx
; WIDEN_SKX-NEXT:    vmovss %xmm0, (%rcx)
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    je .LBB3_4
; WIDEN_SKX-NEXT:  .LBB3_3: # %cond.store1
; WIDEN_SKX-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_SKX-NEXT:    vextractps $1, %xmm0, (%rax)
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_scatter_v2i32_data:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vptestmq %zmm2, %zmm2, %k0
; WIDEN_KNL-NEXT:    kmovw %k0, %eax
; WIDEN_KNL-NEXT:    testb $1, %al
; WIDEN_KNL-NEXT:    jne .LBB3_1
; WIDEN_KNL-NEXT:  # %bb.2: # %else
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    jne .LBB3_3
; WIDEN_KNL-NEXT:  .LBB3_4: # %else2
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
; WIDEN_KNL-NEXT:  .LBB3_1: # %cond.store
; WIDEN_KNL-NEXT:    vmovq %xmm1, %rcx
; WIDEN_KNL-NEXT:    vmovss %xmm0, (%rcx)
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    je .LBB3_4
; WIDEN_KNL-NEXT:  .LBB3_3: # %cond.store1
; WIDEN_KNL-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_KNL-NEXT:    vextractps $1, %xmm0, (%rax)
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_scatter_v2i32_data:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_AVX2-NEXT:    vmovmskpd %xmm2, %eax
; WIDEN_AVX2-NEXT:    testb $1, %al
; WIDEN_AVX2-NEXT:    jne .LBB3_1
; WIDEN_AVX2-NEXT:  # %bb.2: # %else
; WIDEN_AVX2-NEXT:    testb $2, %al
; WIDEN_AVX2-NEXT:    jne .LBB3_3
; WIDEN_AVX2-NEXT:  .LBB3_4: # %else2
; WIDEN_AVX2-NEXT:    retq
; WIDEN_AVX2-NEXT:  .LBB3_1: # %cond.store
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rcx
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rcx)
; WIDEN_AVX2-NEXT:    testb $2, %al
; WIDEN_AVX2-NEXT:    je .LBB3_4
; WIDEN_AVX2-NEXT:  .LBB3_3: # %cond.store1
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vextractps $1, %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    retq
  call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> %a1, <2 x ptr> %ptr, i32 4, <2 x i1> %mask)
  ret void
}

define <2 x i32> @test_gather_v2i32_data_index(ptr %base, <2 x i32> %ind, <2 x i1> %mask, <2 x i32> %src0) {
; WIDEN_SKX-LABEL: test_gather_v2i32_data_index:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpmovq2m %xmm1, %k0
; WIDEN_SKX-NEXT:    vpbroadcastq %rdi, %xmm1
; WIDEN_SKX-NEXT:    vpmovsxdq %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vpsllq $2, %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; WIDEN_SKX-NEXT:    kmovw %k0, %eax
; WIDEN_SKX-NEXT:    testb $1, %al
; WIDEN_SKX-NEXT:    jne .LBB4_1
; WIDEN_SKX-NEXT:  # %bb.2: # %else
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    jne .LBB4_3
; WIDEN_SKX-NEXT:  .LBB4_4: # %else2
; WIDEN_SKX-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_SKX-NEXT:    retq
; WIDEN_SKX-NEXT:  .LBB4_1: # %cond.load
; WIDEN_SKX-NEXT:    vmovq %xmm0, %rcx
; WIDEN_SKX-NEXT:    vpinsrd $0, (%rcx), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    je .LBB4_4
; WIDEN_SKX-NEXT:  .LBB4_3: # %cond.load1
; WIDEN_SKX-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_SKX-NEXT:    vpinsrd $1, (%rax), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_gather_v2i32_data_index:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vpsllq $63, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vptestmq %zmm1, %zmm1, %k0
; WIDEN_KNL-NEXT:    vpmovsxdq %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vpsllq $2, %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vmovq %rdi, %xmm1
; WIDEN_KNL-NEXT:    vpbroadcastq %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; WIDEN_KNL-NEXT:    kmovw %k0, %eax
; WIDEN_KNL-NEXT:    testb $1, %al
; WIDEN_KNL-NEXT:    jne .LBB4_1
; WIDEN_KNL-NEXT:  # %bb.2: # %else
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    jne .LBB4_3
; WIDEN_KNL-NEXT:  .LBB4_4: # %else2
; WIDEN_KNL-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
; WIDEN_KNL-NEXT:  .LBB4_1: # %cond.load
; WIDEN_KNL-NEXT:    vmovq %xmm0, %rcx
; WIDEN_KNL-NEXT:    vpinsrd $0, (%rcx), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    je .LBB4_4
; WIDEN_KNL-NEXT:  .LBB4_3: # %cond.load1
; WIDEN_KNL-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_KNL-NEXT:    vpinsrd $1, (%rax), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_gather_v2i32_data_index:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,2],zero,zero
; WIDEN_AVX2-NEXT:    vpslld $31, %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpgatherdd %xmm1, (%rdi,%xmm0,4), %xmm2
; WIDEN_AVX2-NEXT:    vmovdqa %xmm2, %xmm0
; WIDEN_AVX2-NEXT:    retq
  %gep.random = getelementptr i32, ptr %base, <2 x i32> %ind
  %res = call <2 x i32> @llvm.masked.gather.v2i32.v2p0(<2 x ptr> %gep.random, i32 4, <2 x i1> %mask, <2 x i32> %src0)
  ret <2 x i32> %res
}

define void @test_scatter_v2i32_data_index(<2 x i32> %a1, ptr %base, <2 x i32> %ind, <2 x i1> %mask) {
; WIDEN_SKX-LABEL: test_scatter_v2i32_data_index:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpmovq2m %xmm2, %k0
; WIDEN_SKX-NEXT:    vpbroadcastq %rdi, %xmm2
; WIDEN_SKX-NEXT:    vpmovsxdq %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpsllq $2, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpaddq %xmm1, %xmm2, %xmm1
; WIDEN_SKX-NEXT:    kmovw %k0, %eax
; WIDEN_SKX-NEXT:    testb $1, %al
; WIDEN_SKX-NEXT:    jne .LBB5_1
; WIDEN_SKX-NEXT:  # %bb.2: # %else
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    jne .LBB5_3
; WIDEN_SKX-NEXT:  .LBB5_4: # %else2
; WIDEN_SKX-NEXT:    retq
; WIDEN_SKX-NEXT:  .LBB5_1: # %cond.store
; WIDEN_SKX-NEXT:    vmovq %xmm1, %rcx
; WIDEN_SKX-NEXT:    vmovss %xmm0, (%rcx)
; WIDEN_SKX-NEXT:    testb $2, %al
; WIDEN_SKX-NEXT:    je .LBB5_4
; WIDEN_SKX-NEXT:  .LBB5_3: # %cond.store1
; WIDEN_SKX-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_SKX-NEXT:    vextractps $1, %xmm0, (%rax)
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_scatter_v2i32_data_index:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vptestmq %zmm2, %zmm2, %k0
; WIDEN_KNL-NEXT:    vpmovsxdq %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpsllq $2, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vmovq %rdi, %xmm2
; WIDEN_KNL-NEXT:    vpbroadcastq %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpaddq %xmm1, %xmm2, %xmm1
; WIDEN_KNL-NEXT:    kmovw %k0, %eax
; WIDEN_KNL-NEXT:    testb $1, %al
; WIDEN_KNL-NEXT:    jne .LBB5_1
; WIDEN_KNL-NEXT:  # %bb.2: # %else
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    jne .LBB5_3
; WIDEN_KNL-NEXT:  .LBB5_4: # %else2
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
; WIDEN_KNL-NEXT:  .LBB5_1: # %cond.store
; WIDEN_KNL-NEXT:    vmovq %xmm1, %rcx
; WIDEN_KNL-NEXT:    vmovss %xmm0, (%rcx)
; WIDEN_KNL-NEXT:    testb $2, %al
; WIDEN_KNL-NEXT:    je .LBB5_4
; WIDEN_KNL-NEXT:  .LBB5_3: # %cond.store1
; WIDEN_KNL-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_KNL-NEXT:    vextractps $1, %xmm0, (%rax)
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_scatter_v2i32_data_index:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpsllq $2, %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vmovq %rdi, %xmm3
; WIDEN_AVX2-NEXT:    vpbroadcastq %xmm3, %xmm3
; WIDEN_AVX2-NEXT:    vpaddq %xmm1, %xmm3, %xmm1
; WIDEN_AVX2-NEXT:    vpsllq $63, %xmm2, %xmm2
; WIDEN_AVX2-NEXT:    vmovmskpd %xmm2, %eax
; WIDEN_AVX2-NEXT:    testb $1, %al
; WIDEN_AVX2-NEXT:    jne .LBB5_1
; WIDEN_AVX2-NEXT:  # %bb.2: # %else
; WIDEN_AVX2-NEXT:    testb $2, %al
; WIDEN_AVX2-NEXT:    jne .LBB5_3
; WIDEN_AVX2-NEXT:  .LBB5_4: # %else2
; WIDEN_AVX2-NEXT:    retq
; WIDEN_AVX2-NEXT:  .LBB5_1: # %cond.store
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rcx
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rcx)
; WIDEN_AVX2-NEXT:    testb $2, %al
; WIDEN_AVX2-NEXT:    je .LBB5_4
; WIDEN_AVX2-NEXT:  .LBB5_3: # %cond.store1
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vextractps $1, %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    retq
  %gep = getelementptr i32, ptr%base, <2 x i32> %ind
  call void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> %a1, <2 x ptr> %gep, i32 4, <2 x i1> %mask)
  ret void
}

define void @test_mscatter_v17f32(ptr %base, <17 x i32> %index, <17 x float> %val)
; WIDEN_SKX-LABEL: test_mscatter_v17f32:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; WIDEN_SKX-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; WIDEN_SKX-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0],mem[0],xmm1[2,3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1,2],mem[0]
; WIDEN_SKX-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0],mem[0],xmm2[2,3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1],mem[0],xmm2[3]
; WIDEN_SKX-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1,2],mem[0]
; WIDEN_SKX-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; WIDEN_SKX-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; WIDEN_SKX-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; WIDEN_SKX-NEXT:    vmovd %esi, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $1, %edx, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $2, %ecx, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $3, %r8d, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vmovd %r9d, %xmm3
; WIDEN_SKX-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; WIDEN_SKX-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; WIDEN_SKX-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; WIDEN_SKX-NEXT:    vinserti128 $1, %xmm3, %ymm2, %ymm2
; WIDEN_SKX-NEXT:    vinserti64x4 $1, %ymm1, %zmm2, %zmm1
; WIDEN_SKX-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vmovss {{.*#+}} xmm3 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    kxnorw %k0, %k0, %k1
; WIDEN_SKX-NEXT:    vscatterdps %zmm0, (%rdi,%zmm1,4) {%k1}
; WIDEN_SKX-NEXT:    movw $1, %ax
; WIDEN_SKX-NEXT:    kmovw %eax, %k1
; WIDEN_SKX-NEXT:    vscatterdps %zmm2, (%rdi,%zmm3,4) {%k1}
; WIDEN_SKX-NEXT:    vzeroupper
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_mscatter_v17f32:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; WIDEN_KNL-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; WIDEN_KNL-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0],mem[0],xmm1[2,3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1,2],mem[0]
; WIDEN_KNL-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0],mem[0],xmm2[2,3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1],mem[0],xmm2[3]
; WIDEN_KNL-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1,2],mem[0]
; WIDEN_KNL-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; WIDEN_KNL-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; WIDEN_KNL-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; WIDEN_KNL-NEXT:    vmovd %esi, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $1, %edx, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $2, %ecx, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $3, %r8d, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vmovd %r9d, %xmm3
; WIDEN_KNL-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; WIDEN_KNL-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; WIDEN_KNL-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; WIDEN_KNL-NEXT:    vinserti128 $1, %xmm3, %ymm2, %ymm2
; WIDEN_KNL-NEXT:    vinserti64x4 $1, %ymm1, %zmm2, %zmm1
; WIDEN_KNL-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vmovss {{.*#+}} xmm3 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    kxnorw %k0, %k0, %k1
; WIDEN_KNL-NEXT:    vscatterdps %zmm0, (%rdi,%zmm1,4) {%k1}
; WIDEN_KNL-NEXT:    movw $1, %ax
; WIDEN_KNL-NEXT:    kmovw %eax, %k1
; WIDEN_KNL-NEXT:    vscatterdps %zmm2, (%rdi,%zmm3,4) {%k1}
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_mscatter_v17f32:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vmovq %rdi, %xmm8
; WIDEN_AVX2-NEXT:    vpbroadcastq %xmm8, %ymm8
; WIDEN_AVX2-NEXT:    vmovd %esi, %xmm9
; WIDEN_AVX2-NEXT:    vpinsrd $1, %edx, %xmm9, %xmm9
; WIDEN_AVX2-NEXT:    vpinsrd $2, %ecx, %xmm9, %xmm9
; WIDEN_AVX2-NEXT:    vpinsrd $3, %r8d, %xmm9, %xmm9
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm9, %ymm9
; WIDEN_AVX2-NEXT:    vpsllq $2, %ymm9, %ymm9
; WIDEN_AVX2-NEXT:    vpaddq %ymm9, %ymm8, %ymm9
; WIDEN_AVX2-NEXT:    vmovq %xmm9, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm9, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm1, (%rax)
; WIDEN_AVX2-NEXT:    vextracti128 $1, %ymm9, %xmm0
; WIDEN_AVX2-NEXT:    vmovq %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm2, (%rax)
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm3, (%rax)
; WIDEN_AVX2-NEXT:    vmovd %r9d, %xmm0
; WIDEN_AVX2-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm0, %ymm0
; WIDEN_AVX2-NEXT:    vpsllq $2, %ymm0, %ymm0
; WIDEN_AVX2-NEXT:    vpaddq %ymm0, %ymm8, %ymm0
; WIDEN_AVX2-NEXT:    vmovq %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm4, (%rax)
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm5, (%rax)
; WIDEN_AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm0
; WIDEN_AVX2-NEXT:    vmovq %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm6, (%rax)
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vmovss %xmm7, (%rax)
; WIDEN_AVX2-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm1, %ymm1
; WIDEN_AVX2-NEXT:    vpsllq $2, %ymm1, %ymm1
; WIDEN_AVX2-NEXT:    vpaddq %ymm1, %ymm8, %ymm1
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vextracti128 $1, %ymm1, %xmm1
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vmovss %xmm1, (%rax)
; WIDEN_AVX2-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm1, %ymm1
; WIDEN_AVX2-NEXT:    vpsllq $2, %ymm1, %ymm1
; WIDEN_AVX2-NEXT:    vpaddq %ymm1, %ymm8, %ymm1
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vextracti128 $1, %ymm1, %xmm1
; WIDEN_AVX2-NEXT:    vmovq %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vpextrq $1, %xmm1, %rax
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vmovd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpmovsxdq %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vpsllq $2, %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vpaddq %xmm0, %xmm8, %xmm0
; WIDEN_AVX2-NEXT:    vmovq %xmm0, %rax
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vmovss %xmm0, (%rax)
; WIDEN_AVX2-NEXT:    vzeroupper
; WIDEN_AVX2-NEXT:    retq
{
  %gep = getelementptr float, ptr %base, <17 x i32> %index
  call void @llvm.masked.scatter.v17f32.v17p0(<17 x float> %val, <17 x ptr> %gep, i32 4, <17 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>)
  ret void
}

define <17 x float> @test_mgather_v17f32(ptr %base, <17 x i32> %index)
; WIDEN_SKX-LABEL: test_mgather_v17f32:
; WIDEN_SKX:       # %bb.0:
; WIDEN_SKX-NEXT:    movq %rdi, %rax
; WIDEN_SKX-NEXT:    vmovd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_SKX-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; WIDEN_SKX-NEXT:    vmovd %edx, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $1, %ecx, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $2, %r8d, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vpinsrd $3, %r9d, %xmm1, %xmm1
; WIDEN_SKX-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; WIDEN_SKX-NEXT:    vinserti64x4 $1, %ymm0, %zmm1, %zmm0
; WIDEN_SKX-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_SKX-NEXT:    kxnorw %k0, %k0, %k1
; WIDEN_SKX-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; WIDEN_SKX-NEXT:    vxorps %xmm3, %xmm3, %xmm3
; WIDEN_SKX-NEXT:    vgatherdps (%rsi,%zmm0,4), %zmm3 {%k1}
; WIDEN_SKX-NEXT:    movw $1, %cx
; WIDEN_SKX-NEXT:    kmovw %ecx, %k1
; WIDEN_SKX-NEXT:    vgatherdps (%rsi,%zmm1,4), %zmm2 {%k1}
; WIDEN_SKX-NEXT:    vmovss %xmm2, 64(%rdi)
; WIDEN_SKX-NEXT:    vmovaps %zmm3, (%rdi)
; WIDEN_SKX-NEXT:    vzeroupper
; WIDEN_SKX-NEXT:    retq
;
; WIDEN_KNL-LABEL: test_mgather_v17f32:
; WIDEN_KNL:       # %bb.0:
; WIDEN_KNL-NEXT:    movq %rdi, %rax
; WIDEN_KNL-NEXT:    vmovd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_KNL-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; WIDEN_KNL-NEXT:    vmovd %edx, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $1, %ecx, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $2, %r8d, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vpinsrd $3, %r9d, %xmm1, %xmm1
; WIDEN_KNL-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vinserti128 $1, %xmm2, %ymm1, %ymm1
; WIDEN_KNL-NEXT:    vinserti64x4 $1, %ymm0, %zmm1, %zmm0
; WIDEN_KNL-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_KNL-NEXT:    kxnorw %k0, %k0, %k1
; WIDEN_KNL-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; WIDEN_KNL-NEXT:    vxorps %xmm3, %xmm3, %xmm3
; WIDEN_KNL-NEXT:    vgatherdps (%rsi,%zmm0,4), %zmm3 {%k1}
; WIDEN_KNL-NEXT:    movw $1, %cx
; WIDEN_KNL-NEXT:    kmovw %ecx, %k1
; WIDEN_KNL-NEXT:    vgatherdps (%rsi,%zmm1,4), %zmm2 {%k1}
; WIDEN_KNL-NEXT:    vmovss %xmm2, 64(%rdi)
; WIDEN_KNL-NEXT:    vmovaps %zmm3, (%rdi)
; WIDEN_KNL-NEXT:    vzeroupper
; WIDEN_KNL-NEXT:    retq
;
; WIDEN_AVX2-LABEL: test_mgather_v17f32:
; WIDEN_AVX2:       # %bb.0:
; WIDEN_AVX2-NEXT:    vmovd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    movq %rdi, %rax
; WIDEN_AVX2-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm0, %xmm0
; WIDEN_AVX2-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vmovd %edx, %xmm3
; WIDEN_AVX2-NEXT:    vpinsrd $1, %ecx, %xmm3, %xmm3
; WIDEN_AVX2-NEXT:    vpinsrd $2, %r8d, %xmm3, %xmm3
; WIDEN_AVX2-NEXT:    vpinsrd $3, %r9d, %xmm3, %xmm3
; WIDEN_AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; WIDEN_AVX2-NEXT:    vmovd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; WIDEN_AVX2-NEXT:    vpinsrd $1, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $2, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vpinsrd $3, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm3, %ymm1
; WIDEN_AVX2-NEXT:    vpcmpeqd %ymm3, %ymm3, %ymm3
; WIDEN_AVX2-NEXT:    vxorps %xmm4, %xmm4, %xmm4
; WIDEN_AVX2-NEXT:    vpcmpeqd %ymm5, %ymm5, %ymm5
; WIDEN_AVX2-NEXT:    vxorps %xmm6, %xmm6, %xmm6
; WIDEN_AVX2-NEXT:    vgatherdps %ymm5, (%rsi,%ymm1,4), %ymm6
; WIDEN_AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; WIDEN_AVX2-NEXT:    vgatherdps %ymm3, (%rsi,%ymm0,4), %ymm1
; WIDEN_AVX2-NEXT:    vmovss {{.*#+}} xmm0 = [4294967295,0,0,0]
; WIDEN_AVX2-NEXT:    vgatherdps %ymm0, (%rsi,%ymm2,4), %ymm4
; WIDEN_AVX2-NEXT:    vmovss %xmm4, 64(%rdi)
; WIDEN_AVX2-NEXT:    vmovaps %ymm1, 32(%rdi)
; WIDEN_AVX2-NEXT:    vmovaps %ymm6, (%rdi)
; WIDEN_AVX2-NEXT:    vzeroupper
; WIDEN_AVX2-NEXT:    retq
{
  %gep = getelementptr float, ptr %base, <17 x i32> %index
  %res = call <17 x float> @llvm.masked.gather.v17f32.v17p0(<17 x ptr> %gep, i32 4, <17 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <17 x float> undef)
  ret <17 x float> %res
}

declare <17 x float> @llvm.masked.gather.v17f32.v17p0(<17 x ptr>, i32 immarg, <17 x i1>, <17 x float>)
declare void @llvm.masked.scatter.v17f32.v17p0(<17 x float> , <17 x ptr> , i32 , <17 x i1>)

declare <2 x double> @llvm.masked.gather.v2f64.v2p0(<2 x ptr>, i32, <2 x i1>, <2 x double>)
declare void @llvm.masked.scatter.v2f64.v2p0(<2 x double>, <2 x ptr>, i32, <2 x i1>)
declare <2 x i32> @llvm.masked.gather.v2i32.v2p0(<2 x ptr>, i32, <2 x i1>, <2 x i32>)
declare void @llvm.masked.scatter.v2i32.v2p0(<2 x i32> , <2 x ptr> , i32 , <2 x i1>)

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=avx512f | FileCheck %s

; The alignment of 16 causes type legalization to split this as 3 loads,
; v16f32, v4f32, and v4f32. This loads 24 elements, but the load is aligned
; to 16 bytes so this i safe. There was an issue with type legalization building
; the proper concat_vectors for this because the two v4f32s don't add up to
; v16f32 and require padding.

define <23 x float> @load23(ptr %p) {
; CHECK-LABEL: load23:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    vmovups (%rsi), %zmm0
; CHECK-NEXT:    vmovaps 64(%rsi), %xmm1
; CHECK-NEXT:    vmovdqa 80(%rsi), %xmm2
; CHECK-NEXT:    vextractps $2, %xmm2, 88(%rdi)
; CHECK-NEXT:    vmovq %xmm2, 80(%rdi)
; CHECK-NEXT:    vmovaps %xmm1, 64(%rdi)
; CHECK-NEXT:    vmovaps %zmm0, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = load <23 x float>, ptr %p, align 16
  ret <23 x float> %t0
}

; Same test as above with minimal alignment just to demonstrate the different
; codegen.
define <23 x float> @load23_align_1(ptr %p) {
; CHECK-LABEL: load23_align_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    vmovups (%rsi), %zmm0
; CHECK-NEXT:    vmovups 64(%rsi), %xmm1
; CHECK-NEXT:    movq 80(%rsi), %rcx
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vmovss %xmm2, 88(%rdi)
; CHECK-NEXT:    movq %rcx, 80(%rdi)
; CHECK-NEXT:    vmovaps %xmm1, 64(%rdi)
; CHECK-NEXT:    vmovaps %zmm0, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = load <23 x float>, ptr %p, align 1
  ret <23 x float> %t0
}

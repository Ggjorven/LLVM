; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+avx,fma | FileCheck %s --check-prefix=FMA3
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+avx,fma4 | FileCheck %s --check-prefix=FMA4

define float @test_fneg_fma_subx_y_negz_f32(float %w, float %x, float %y, float %z)  {
; FMA3-LABEL: test_fneg_fma_subx_y_negz_f32:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vsubss %xmm1, %xmm0, %xmm0
; FMA3-NEXT:    vfnmadd213ss {{.*#+}} xmm0 = -(xmm2 * xmm0) + xmm3
; FMA3-NEXT:    retq
;
; FMA4-LABEL: test_fneg_fma_subx_y_negz_f32:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vsubss %xmm1, %xmm0, %xmm0
; FMA4-NEXT:    vfnmaddss {{.*#+}} xmm0 = -(xmm0 * xmm2) + xmm3
; FMA4-NEXT:    retq
entry:
  %subx = fsub nsz float %w, %x
  %negz = fsub float -0.000000e+00, %z
  %0 = tail call nsz float @llvm.fma.f32(float %subx, float %y, float %negz)
  %1 = fsub float -0.000000e+00, %0
  ret float %1
}

define float @test_fneg_fma_x_suby_negz_f32(float %w, float %x, float %y, float %z)  {
; FMA3-LABEL: test_fneg_fma_x_suby_negz_f32:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vsubss %xmm2, %xmm0, %xmm0
; FMA3-NEXT:    vfnmadd213ss {{.*#+}} xmm0 = -(xmm1 * xmm0) + xmm3
; FMA3-NEXT:    retq
;
; FMA4-LABEL: test_fneg_fma_x_suby_negz_f32:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vsubss %xmm2, %xmm0, %xmm0
; FMA4-NEXT:    vfnmaddss {{.*#+}} xmm0 = -(xmm1 * xmm0) + xmm3
; FMA4-NEXT:    retq
entry:
  %suby = fsub nsz float %w, %y
  %negz = fsub float -0.000000e+00, %z
  %0 = tail call nsz float @llvm.fma.f32(float %x, float %suby, float %negz)
  %1 = fsub float -0.000000e+00, %0
  ret float %1
}

define float @test_fneg_fma_subx_suby_negz_f32(float %w, float %x, float %y, float %z)  {
; FMA3-LABEL: test_fneg_fma_subx_suby_negz_f32:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vsubss %xmm1, %xmm0, %xmm1
; FMA3-NEXT:    vsubss %xmm2, %xmm0, %xmm0
; FMA3-NEXT:    vfnmadd213ss {{.*#+}} xmm0 = -(xmm1 * xmm0) + xmm3
; FMA3-NEXT:    retq
;
; FMA4-LABEL: test_fneg_fma_subx_suby_negz_f32:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vsubss %xmm1, %xmm0, %xmm1
; FMA4-NEXT:    vsubss %xmm2, %xmm0, %xmm0
; FMA4-NEXT:    vfnmaddss {{.*#+}} xmm0 = -(xmm1 * xmm0) + xmm3
; FMA4-NEXT:    retq
entry:
  %subx = fsub nsz float %w, %x
  %suby = fsub nsz float %w, %y
  %negz = fsub float -0.000000e+00, %z
  %0 = tail call nsz float @llvm.fma.f32(float %subx, float %suby, float %negz)
  %1 = fsub float -0.000000e+00, %0
  ret float %1
}

define float @test_fneg_fma_subx_negy_negz_f32(float %w, float %x, float %y, float %z)  {
; FMA3-LABEL: test_fneg_fma_subx_negy_negz_f32:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vsubss %xmm1, %xmm0, %xmm0
; FMA3-NEXT:    vfmadd213ss {{.*#+}} xmm0 = (xmm2 * xmm0) + xmm3
; FMA3-NEXT:    retq
;
; FMA4-LABEL: test_fneg_fma_subx_negy_negz_f32:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vsubss %xmm1, %xmm0, %xmm0
; FMA4-NEXT:    vfmaddss {{.*#+}} xmm0 = (xmm0 * xmm2) + xmm3
; FMA4-NEXT:    retq
entry:
  %subx = fsub nsz float %w, %x
  %negy = fsub float -0.000000e+00, %y
  %negz = fsub float -0.000000e+00, %z
  %0 = tail call nsz float @llvm.fma.f32(float %subx, float %negy, float %negz)
  %1 = fsub float -0.000000e+00, %0
  ret float %1
}

define <4 x float> @test_fma_rcp_fneg_v4f32(<4 x float> %x, <4 x float> %y, <4 x float> %z)  {
; FMA3-LABEL: test_fma_rcp_fneg_v4f32:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vrcpps %xmm2, %xmm2
; FMA3-NEXT:    vfmsub213ps {{.*#+}} xmm0 = (xmm1 * xmm0) - xmm2
; FMA3-NEXT:    retq
;
; FMA4-LABEL: test_fma_rcp_fneg_v4f32:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vrcpps %xmm2, %xmm2
; FMA4-NEXT:    vfmsubps {{.*#+}} xmm0 = (xmm0 * xmm1) - xmm2
; FMA4-NEXT:    retq
entry:
  %0 = fneg <4 x float> %z
  %1 = tail call <4 x float> @llvm.x86.sse.rcp.ps(<4 x float> %0)
  %2 = tail call nsz <4 x float> @llvm.fma.v4f32(<4 x float> %x, <4 x float> %y, <4 x float> %1)
  ret <4 x float> %2
}
declare <4 x float> @llvm.x86.sse.rcp.ps(<4 x float>)

; This would crash while trying getNegatedExpression().

define float @negated_constant(float %x) {
; FMA3-LABEL: negated_constant:
; FMA3:       # %bb.0:
; FMA3-NEXT:    vmulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; FMA3-NEXT:    vfnmsub132ss {{.*#+}} xmm0 = -(xmm0 * mem) - xmm1
; FMA3-NEXT:    retq
;
; FMA4-LABEL: negated_constant:
; FMA4:       # %bb.0:
; FMA4-NEXT:    vmulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; FMA4-NEXT:    vfnmsubss {{.*#+}} xmm0 = -(xmm0 * mem) - xmm1
; FMA4-NEXT:    retq
  %m = fmul float %x, 42.0
  %fma = call nsz float @llvm.fma.f32(float %x, float -42.0, float %m)
  %nfma = fneg float %fma
  ret float %nfma
}

define <4 x double> @negated_constant_v4f64(<4 x double> %a) {
; FMA3-LABEL: negated_constant_v4f64:
; FMA3:       # %bb.0:
; FMA3-NEXT:    vmovapd {{.*#+}} ymm1 = [-5.0E-1,-2.5E-1,-1.25E-1,-6.25E-2]
; FMA3-NEXT:    vfnmadd213pd {{.*#+}} ymm0 = -(ymm1 * ymm0) + ymm1
; FMA3-NEXT:    retq
;
; FMA4-LABEL: negated_constant_v4f64:
; FMA4:       # %bb.0:
; FMA4-NEXT:    vmovapd {{.*#+}} ymm1 = [-5.0E-1,-2.5E-1,-1.25E-1,-6.25E-2]
; FMA4-NEXT:    vfnmaddpd {{.*#+}} ymm0 = -(ymm0 * ymm1) + ymm1
; FMA4-NEXT:    retq
  %t = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %a, <4 x double> <double 5.000000e-01, double 2.5000000e-01, double 1.25000000e-01, double 0.62500000e-01>, <4 x double> <double -5.000000e-01, double -2.5000000e-01, double -1.25000000e-01, double -0.62500000e-01>)
  ret <4 x double> %t
}

define <4 x double> @negated_constant_v4f64_2fmas(<4 x double> %a, <4 x double> %b) {
; FMA3-LABEL: negated_constant_v4f64_2fmas:
; FMA3:       # %bb.0:
; FMA3-NEXT:    vmovapd {{.*#+}} ymm2 = [-5.0E-1,u,-2.5E+0,-4.5E+0]
; FMA3-NEXT:    vmovapd %ymm2, %ymm3
; FMA3-NEXT:    vfmadd213pd {{.*#+}} ymm3 = (ymm0 * ymm3) + ymm1
; FMA3-NEXT:    vfnmadd213pd {{.*#+}} ymm2 = -(ymm0 * ymm2) + ymm1
; FMA3-NEXT:    vaddpd %ymm2, %ymm3, %ymm0
; FMA3-NEXT:    retq
;
; FMA4-LABEL: negated_constant_v4f64_2fmas:
; FMA4:       # %bb.0:
; FMA4-NEXT:    vmovapd {{.*#+}} ymm2 = [-5.0E-1,u,-2.5E+0,-4.5E+0]
; FMA4-NEXT:    vfmaddpd {{.*#+}} ymm3 = (ymm0 * ymm2) + ymm1
; FMA4-NEXT:    vfnmaddpd {{.*#+}} ymm0 = -(ymm0 * ymm2) + ymm1
; FMA4-NEXT:    vaddpd %ymm0, %ymm3, %ymm0
; FMA4-NEXT:    retq
  %t0 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %a, <4 x double> <double -5.000000e-01, double undef, double -25.000000e-01, double -45.000000e-01>, <4 x double> %b)
  %t1 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %a, <4 x double> <double 5.000000e-01, double undef, double 25.000000e-01, double 45.000000e-01>, <4 x double> %b)
  %t2 = fadd <4 x double> %t0, %t1
  ret <4 x double> %t2
}

define <4 x double> @negated_constant_v4f64_fadd(<4 x double> %a) {
; FMA3-LABEL: negated_constant_v4f64_fadd:
; FMA3:       # %bb.0:
; FMA3-NEXT:    vbroadcastf128 {{.*#+}} ymm1 = [1.5E+0,1.25E-1,1.5E+0,1.25E-1]
; FMA3-NEXT:    # ymm1 = mem[0,1,0,1]
; FMA3-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; FMA3-NEXT:    vfmsub213pd {{.*#+}} ymm0 = (ymm1 * ymm0) - ymm1
; FMA3-NEXT:    retq
;
; FMA4-LABEL: negated_constant_v4f64_fadd:
; FMA4:       # %bb.0:
; FMA4-NEXT:    vbroadcastf128 {{.*#+}} ymm1 = [1.5E+0,1.25E-1,1.5E+0,1.25E-1]
; FMA4-NEXT:    # ymm1 = mem[0,1,0,1]
; FMA4-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; FMA4-NEXT:    vfmsubpd {{.*#+}} ymm0 = (ymm0 * ymm1) - ymm1
; FMA4-NEXT:    retq
  %t0 = fadd <4 x double> %a, <double 15.000000e-01, double 1.25000000e-01, double 15.000000e-01, double 1.25000000e-01>
  %t1 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %t0, <4 x double> <double 15.000000e-01, double 1.25000000e-01, double 15.000000e-01, double 1.25000000e-01>, <4 x double> <double -15.000000e-01, double -1.25000000e-01, double -15.000000e-01, double -1.25000000e-01>)
  ret <4 x double> %t1
}

define <4 x double> @negated_constant_v4f64_2fma_undefs(<4 x double> %a, <4 x double> %b) {
; FMA3-LABEL: negated_constant_v4f64_2fma_undefs:
; FMA3:       # %bb.0:
; FMA3-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
; FMA3-NEXT:    vfnmadd213pd {{.*#+}} ymm0 = -(ymm2 * ymm0) + mem
; FMA3-NEXT:    vfmadd132pd {{.*#+}} ymm1 = (ymm1 * mem) + ymm2
; FMA3-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; FMA3-NEXT:    retq
;
; FMA4-LABEL: negated_constant_v4f64_2fma_undefs:
; FMA4:       # %bb.0:
; FMA4-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
; FMA4-NEXT:    vfnmaddpd {{.*#+}} ymm0 = -(ymm0 * ymm2) + mem
; FMA4-NEXT:    vfmaddpd {{.*#+}} ymm1 = (ymm1 * mem) + ymm2
; FMA4-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; FMA4-NEXT:    retq
  %t0 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %a, <4 x double> <double 5.000000e-01, double 5.000000e-01, double 5.000000e-01, double 5.000000e-01>, <4 x double> <double -5.000000e-01, double undef, double -5.000000e-01, double -5.000000e-01>)
  %t1 = tail call <4 x double> @llvm.fma.v4f64(<4 x double> %b, <4 x double> <double undef, double 5.000000e-01, double 5.000000e-01, double 5.000000e-01>, <4 x double> <double -5.000000e-01, double -5.000000e-01, double -5.000000e-01, double -5.000000e-01>)
  %t2 = fadd <4 x double> %t0, %t1
  ret <4 x double> %t2
}

declare float @llvm.fma.f32(float, float, float)
declare <4 x float> @llvm.fma.v4f32(<4 x float>, <4 x float>, <4 x float>)
declare <4 x double> @llvm.fma.v4f64(<4 x double>, <4 x double>, <4 x double>)

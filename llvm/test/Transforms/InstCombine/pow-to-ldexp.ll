; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=instcombine %s | FileCheck -check-prefixes=CHECK,LDEXP,LDEXP-EXP2 %s
; RUN: opt -S -passes=instcombine -disable-builtin=exp2f -disable-builtin=exp2 -disable-builtin=exp2l %s | FileCheck -check-prefixes=CHECK,LDEXP,LDEXP-NOEXP2 %s
; RUN: opt -S -passes=instcombine -disable-builtin=ldexpf -disable-builtin=ldexp -disable-builtin=ldexpl %s | FileCheck -check-prefixes=CHECK,NOLDEXP %s


define float @pow_sitofp_f32_const_base_2(i32 %x) {
; CHECK-LABEL: define float @pow_sitofp_f32_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call float @llvm.ldexp.f32.i32(float 1.000000e+00, i32 [[X]])
; CHECK-NEXT:    ret float [[EXP2]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call float @llvm.pow.f32(float 2.000000e+00, float %itofp)
  ret float %pow
}

define float @pow_sitofp_f32_const_base_2__flags(i32 %x) {
; CHECK-LABEL: define float @pow_sitofp_f32_const_base_2__flags(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call nnan nsz float @llvm.ldexp.f32.i32(float 1.000000e+00, i32 [[X]])
; CHECK-NEXT:    ret float [[EXP2]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call nsz nnan float @llvm.pow.f32(float 2.000000e+00, float %itofp)
  ret float %pow
}

define float @pow_uitofp_f32_const_base_2(i32 %x) {
; LDEXP-EXP2-LABEL: define float @pow_uitofp_f32_const_base_2(
; LDEXP-EXP2-SAME: i32 [[X:%.*]]) {
; LDEXP-EXP2-NEXT:    [[ITOFP:%.*]] = uitofp i32 [[X]] to float
; LDEXP-EXP2-NEXT:    [[EXP2:%.*]] = tail call float @llvm.exp2.f32(float [[ITOFP]])
; LDEXP-EXP2-NEXT:    ret float [[EXP2]]
;
; LDEXP-NOEXP2-LABEL: define float @pow_uitofp_f32_const_base_2(
; LDEXP-NOEXP2-SAME: i32 [[X:%.*]]) {
; LDEXP-NOEXP2-NEXT:    [[ITOFP:%.*]] = uitofp i32 [[X]] to float
; LDEXP-NOEXP2-NEXT:    [[POW:%.*]] = tail call float @llvm.pow.f32(float 2.000000e+00, float [[ITOFP]])
; LDEXP-NOEXP2-NEXT:    ret float [[POW]]
;
; NOLDEXP-LABEL: define float @pow_uitofp_f32_const_base_2(
; NOLDEXP-SAME: i32 [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = uitofp i32 [[X]] to float
; NOLDEXP-NEXT:    [[EXP2:%.*]] = tail call float @llvm.exp2.f32(float [[ITOFP]])
; NOLDEXP-NEXT:    ret float [[EXP2]]
;
  %itofp = uitofp i32 %x to float
  %pow = tail call float @llvm.pow.f32(float 2.000000e+00, float %itofp)
  ret float %pow
}

define float @pow_sitofp_f32_const_base_4(i32 %x) {
; LDEXP-EXP2-LABEL: define float @pow_sitofp_f32_const_base_4(
; LDEXP-EXP2-SAME: i32 [[X:%.*]]) {
; LDEXP-EXP2-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; LDEXP-EXP2-NEXT:    [[MUL:%.*]] = fmul float [[ITOFP]], 2.000000e+00
; LDEXP-EXP2-NEXT:    [[EXP2:%.*]] = tail call float @llvm.exp2.f32(float [[MUL]])
; LDEXP-EXP2-NEXT:    ret float [[EXP2]]
;
; LDEXP-NOEXP2-LABEL: define float @pow_sitofp_f32_const_base_4(
; LDEXP-NOEXP2-SAME: i32 [[X:%.*]]) {
; LDEXP-NOEXP2-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; LDEXP-NOEXP2-NEXT:    [[POW:%.*]] = tail call float @llvm.pow.f32(float 4.000000e+00, float [[ITOFP]])
; LDEXP-NOEXP2-NEXT:    ret float [[POW]]
;
; NOLDEXP-LABEL: define float @pow_sitofp_f32_const_base_4(
; NOLDEXP-SAME: i32 [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; NOLDEXP-NEXT:    [[MUL:%.*]] = fmul float [[ITOFP]], 2.000000e+00
; NOLDEXP-NEXT:    [[EXP2:%.*]] = tail call float @llvm.exp2.f32(float [[MUL]])
; NOLDEXP-NEXT:    ret float [[EXP2]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call float @llvm.pow.f32(float 4.000000e+00, float %itofp)
  ret float %pow
}

define float @pow_sitofp_f32_const_base_16(i32 %x) {
; LDEXP-EXP2-LABEL: define float @pow_sitofp_f32_const_base_16(
; LDEXP-EXP2-SAME: i32 [[X:%.*]]) {
; LDEXP-EXP2-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; LDEXP-EXP2-NEXT:    [[MUL:%.*]] = fmul float [[ITOFP]], 4.000000e+00
; LDEXP-EXP2-NEXT:    [[EXP2:%.*]] = tail call float @llvm.exp2.f32(float [[MUL]])
; LDEXP-EXP2-NEXT:    ret float [[EXP2]]
;
; LDEXP-NOEXP2-LABEL: define float @pow_sitofp_f32_const_base_16(
; LDEXP-NOEXP2-SAME: i32 [[X:%.*]]) {
; LDEXP-NOEXP2-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; LDEXP-NOEXP2-NEXT:    [[POW:%.*]] = tail call float @llvm.pow.f32(float 1.600000e+01, float [[ITOFP]])
; LDEXP-NOEXP2-NEXT:    ret float [[POW]]
;
; NOLDEXP-LABEL: define float @pow_sitofp_f32_const_base_16(
; NOLDEXP-SAME: i32 [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; NOLDEXP-NEXT:    [[MUL:%.*]] = fmul float [[ITOFP]], 4.000000e+00
; NOLDEXP-NEXT:    [[EXP2:%.*]] = tail call float @llvm.exp2.f32(float [[MUL]])
; NOLDEXP-NEXT:    ret float [[EXP2]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call float @llvm.pow.f32(float 16.000000e+00, float %itofp)
  ret float %pow
}

define double @pow_sitofp_f64_const_base_2(i32 %x) {
; CHECK-LABEL: define double @pow_sitofp_f64_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call double @llvm.ldexp.f64.i32(double 1.000000e+00, i32 [[X]])
; CHECK-NEXT:    ret double [[EXP2]]
;
  %itofp = sitofp i32 %x to double
  %pow = tail call double @llvm.pow.f64(double 2.000000e+00, double %itofp)
  ret double %pow
}

define half @pow_sitofp_f16_const_base_2(i32 %x) {
; CHECK-LABEL: define half @pow_sitofp_f16_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[POW:%.*]] = tail call half @llvm.ldexp.f16.i32(half 0xH3C00, i32 [[X]])
; CHECK-NEXT:    ret half [[POW]]
;
  %itofp = sitofp i32 %x to half
  %pow = tail call half @llvm.pow.f16(half 2.000000e+00, half %itofp)
  ret half %pow
}

define <2 x float> @pow_sitofp_v2f32_const_base_2(<2 x i32> %x) {
; CHECK-LABEL: define <2 x float> @pow_sitofp_v2f32_const_base_2(
; CHECK-SAME: <2 x i32> [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call <2 x float> @llvm.ldexp.v2f32.v2i32(<2 x float> <float 1.000000e+00, float 1.000000e+00>, <2 x i32> [[X]])
; CHECK-NEXT:    ret <2 x float> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x float>
  %pow = tail call <2 x float> @llvm.pow.v2f32(<2 x float> <float 2.000000e+00, float 2.000000e+00>, <2 x float> %itofp)
  ret <2 x float> %pow
}

define <2 x float> @pow_sitofp_v2f32_const_base_8(<2 x i32> %x) {
; LDEXP-EXP2-LABEL: define <2 x float> @pow_sitofp_v2f32_const_base_8(
; LDEXP-EXP2-SAME: <2 x i32> [[X:%.*]]) {
; LDEXP-EXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x float>
; LDEXP-EXP2-NEXT:    [[MUL:%.*]] = fmul <2 x float> [[ITOFP]], <float 3.000000e+00, float 3.000000e+00>
; LDEXP-EXP2-NEXT:    [[EXP2:%.*]] = tail call <2 x float> @llvm.exp2.v2f32(<2 x float> [[MUL]])
; LDEXP-EXP2-NEXT:    ret <2 x float> [[EXP2]]
;
; LDEXP-NOEXP2-LABEL: define <2 x float> @pow_sitofp_v2f32_const_base_8(
; LDEXP-NOEXP2-SAME: <2 x i32> [[X:%.*]]) {
; LDEXP-NOEXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x float>
; LDEXP-NOEXP2-NEXT:    [[POW:%.*]] = tail call <2 x float> @llvm.pow.v2f32(<2 x float> <float 8.000000e+00, float 8.000000e+00>, <2 x float> [[ITOFP]])
; LDEXP-NOEXP2-NEXT:    ret <2 x float> [[POW]]
;
; NOLDEXP-LABEL: define <2 x float> @pow_sitofp_v2f32_const_base_8(
; NOLDEXP-SAME: <2 x i32> [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x float>
; NOLDEXP-NEXT:    [[MUL:%.*]] = fmul <2 x float> [[ITOFP]], <float 3.000000e+00, float 3.000000e+00>
; NOLDEXP-NEXT:    [[EXP2:%.*]] = tail call <2 x float> @llvm.exp2.v2f32(<2 x float> [[MUL]])
; NOLDEXP-NEXT:    ret <2 x float> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x float>
  %pow = tail call <2 x float> @llvm.pow.v2f32(<2 x float> <float 8.000000e+00, float 8.000000e+00>, <2 x float> %itofp)
  ret <2 x float> %pow
}

define <2 x float> @pow_sitofp_v2f32_const_base_mixed_2(<2 x i32> %x) {
; CHECK-LABEL: define <2 x float> @pow_sitofp_v2f32_const_base_mixed_2(
; CHECK-SAME: <2 x i32> [[X:%.*]]) {
; CHECK-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x float>
; CHECK-NEXT:    [[POW:%.*]] = tail call <2 x float> @llvm.pow.v2f32(<2 x float> <float 2.000000e+00, float 4.000000e+00>, <2 x float> [[ITOFP]])
; CHECK-NEXT:    ret <2 x float> [[POW]]
;
  %itofp = sitofp <2 x i32> %x to <2 x float>
  %pow = tail call <2 x float> @llvm.pow.v2f32(<2 x float> <float 2.000000e+00, float 4.000000e+00>, <2 x float> %itofp)
  ret <2 x float> %pow
}

define <2 x float> @pow_sitofp_v2f32_const_base_2__flags(<2 x i32> %x) {
; CHECK-LABEL: define <2 x float> @pow_sitofp_v2f32_const_base_2__flags(
; CHECK-SAME: <2 x i32> [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call nsz afn <2 x float> @llvm.ldexp.v2f32.v2i32(<2 x float> <float 1.000000e+00, float 1.000000e+00>, <2 x i32> [[X]])
; CHECK-NEXT:    ret <2 x float> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x float>
  %pow = tail call nsz afn <2 x float> @llvm.pow.v2f32(<2 x float> <float 2.000000e+00, float 2.000000e+00>, <2 x float> %itofp)
  ret <2 x float> %pow
}

define <vscale x 4 x float> @pow_sitofp_nxv4f32_const_base_2(<vscale x 4 x i32> %x) {
; CHECK-LABEL: define <vscale x 4 x float> @pow_sitofp_nxv4f32_const_base_2(
; CHECK-SAME: <vscale x 4 x i32> [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call <vscale x 4 x float> @llvm.ldexp.nxv4f32.nxv4i32(<vscale x 4 x float> shufflevector (<vscale x 4 x float> insertelement (<vscale x 4 x float> poison, float 1.000000e+00, i64 0), <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer), <vscale x 4 x i32> [[X]])
; CHECK-NEXT:    ret <vscale x 4 x float> [[EXP2]]
;
  %itofp = sitofp <vscale x 4 x i32> %x to <vscale x 4 x float>
  %pow = tail call <vscale x 4 x float> @llvm.pow.nxv4f32(<vscale x 4 x float> splat (float 2.0), <vscale x 4 x float> %itofp)
  ret <vscale x 4 x float> %pow
}

define <2 x half> @pow_sitofp_v2f16_const_base_2(<2 x i32> %x) {
; CHECK-LABEL: define <2 x half> @pow_sitofp_v2f16_const_base_2(
; CHECK-SAME: <2 x i32> [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call <2 x half> @llvm.ldexp.v2f16.v2i32(<2 x half> <half 0xH3C00, half 0xH3C00>, <2 x i32> [[X]])
; CHECK-NEXT:    ret <2 x half> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x half>
  %pow = tail call <2 x half> @llvm.pow.v2f16(<2 x half> <half 2.000000e+00, half 2.000000e+00>, <2 x half> %itofp)
  ret <2 x half> %pow
}

define <2 x double> @pow_sitofp_v2f64_const_base_2(<2 x i32> %x) {
; CHECK-LABEL: define <2 x double> @pow_sitofp_v2f64_const_base_2(
; CHECK-SAME: <2 x i32> [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call <2 x double> @llvm.ldexp.v2f64.v2i32(<2 x double> <double 1.000000e+00, double 1.000000e+00>, <2 x i32> [[X]])
; CHECK-NEXT:    ret <2 x double> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x double>
  %pow = tail call <2 x double> @llvm.pow.v2f64(<2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double> %itofp)
  ret <2 x double> %pow
}

define <2 x half> @pow_sitofp_v2f16_const_base_8(<2 x i32> %x) {
; EXP2-LABEL: define <2 x half> @pow_sitofp_v2f16_const_base_8(
; EXP2-SAME: <2 x i32> [[X:%.*]]) {
; EXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x half>
; EXP2-NEXT:    [[MUL:%.*]] = fmul <2 x half> [[ITOFP]], <half 0xH4200, half 0xH4200>
; EXP2-NEXT:    [[EXP2:%.*]] = tail call <2 x half> @llvm.exp2.v2f16(<2 x half> [[MUL]])
; EXP2-NEXT:    ret <2 x half> [[EXP2]]
;
; LDEXP-EXP2-LABEL: define <2 x half> @pow_sitofp_v2f16_const_base_8(
; LDEXP-EXP2-SAME: <2 x i32> [[X:%.*]]) {
; LDEXP-EXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x half>
; LDEXP-EXP2-NEXT:    [[MUL:%.*]] = fmul <2 x half> [[ITOFP]], <half 0xH4200, half 0xH4200>
; LDEXP-EXP2-NEXT:    [[EXP2:%.*]] = tail call <2 x half> @llvm.exp2.v2f16(<2 x half> [[MUL]])
; LDEXP-EXP2-NEXT:    ret <2 x half> [[EXP2]]
;
; LDEXP-NOEXP2-LABEL: define <2 x half> @pow_sitofp_v2f16_const_base_8(
; LDEXP-NOEXP2-SAME: <2 x i32> [[X:%.*]]) {
; LDEXP-NOEXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x half>
; LDEXP-NOEXP2-NEXT:    [[POW:%.*]] = tail call <2 x half> @llvm.pow.v2f16(<2 x half> <half 0xH4800, half 0xH4800>, <2 x half> [[ITOFP]])
; LDEXP-NOEXP2-NEXT:    ret <2 x half> [[POW]]
;
; NOLDEXP-LABEL: define <2 x half> @pow_sitofp_v2f16_const_base_8(
; NOLDEXP-SAME: <2 x i32> [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x half>
; NOLDEXP-NEXT:    [[MUL:%.*]] = fmul <2 x half> [[ITOFP]], <half 0xH4200, half 0xH4200>
; NOLDEXP-NEXT:    [[EXP2:%.*]] = tail call <2 x half> @llvm.exp2.v2f16(<2 x half> [[MUL]])
; NOLDEXP-NEXT:    ret <2 x half> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x half>
  %pow = tail call <2 x half> @llvm.pow.v2f16(<2 x half> <half 8.000000e+00, half 8.000000e+00>, <2 x half> %itofp)
  ret <2 x half> %pow
}

define <2 x double> @pow_sitofp_v2f64_const_base_8(<2 x i32> %x) {
; EXP2-LABEL: define <2 x double> @pow_sitofp_v2f64_const_base_8(
; EXP2-SAME: <2 x i32> [[X:%.*]]) {
; EXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x double>
; EXP2-NEXT:    [[MUL:%.*]] = fmul <2 x double> [[ITOFP]], <double 3.000000e+00, double 3.000000e+00>
; EXP2-NEXT:    [[EXP2:%.*]] = tail call <2 x double> @llvm.exp2.v2f64(<2 x double> [[MUL]])
; EXP2-NEXT:    ret <2 x double> [[EXP2]]
;
; LDEXP-EXP2-LABEL: define <2 x double> @pow_sitofp_v2f64_const_base_8(
; LDEXP-EXP2-SAME: <2 x i32> [[X:%.*]]) {
; LDEXP-EXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x double>
; LDEXP-EXP2-NEXT:    [[MUL:%.*]] = fmul <2 x double> [[ITOFP]], <double 3.000000e+00, double 3.000000e+00>
; LDEXP-EXP2-NEXT:    [[EXP2:%.*]] = tail call <2 x double> @llvm.exp2.v2f64(<2 x double> [[MUL]])
; LDEXP-EXP2-NEXT:    ret <2 x double> [[EXP2]]
;
; LDEXP-NOEXP2-LABEL: define <2 x double> @pow_sitofp_v2f64_const_base_8(
; LDEXP-NOEXP2-SAME: <2 x i32> [[X:%.*]]) {
; LDEXP-NOEXP2-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x double>
; LDEXP-NOEXP2-NEXT:    [[POW:%.*]] = tail call <2 x double> @llvm.pow.v2f64(<2 x double> <double 8.000000e+00, double 8.000000e+00>, <2 x double> [[ITOFP]])
; LDEXP-NOEXP2-NEXT:    ret <2 x double> [[POW]]
;
; NOLDEXP-LABEL: define <2 x double> @pow_sitofp_v2f64_const_base_8(
; NOLDEXP-SAME: <2 x i32> [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp <2 x i32> [[X]] to <2 x double>
; NOLDEXP-NEXT:    [[MUL:%.*]] = fmul <2 x double> [[ITOFP]], <double 3.000000e+00, double 3.000000e+00>
; NOLDEXP-NEXT:    [[EXP2:%.*]] = tail call <2 x double> @llvm.exp2.v2f64(<2 x double> [[MUL]])
; NOLDEXP-NEXT:    ret <2 x double> [[EXP2]]
;
  %itofp = sitofp <2 x i32> %x to <2 x double>
  %pow = tail call <2 x double> @llvm.pow.v2f64(<2 x double> <double 8.000000e+00, double 8.000000e+00>, <2 x double> %itofp)
  ret <2 x double> %pow
}

define fp128 @pow_sitofp_fp128_const_base_2(i32 %x) {
; CHECK-LABEL: define fp128 @pow_sitofp_fp128_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call fp128 @llvm.ldexp.f128.i32(fp128 0xL00000000000000003FFF000000000000, i32 [[X]])
; CHECK-NEXT:    ret fp128 [[EXP2]]
;
  %itofp = sitofp i32 %x to fp128
  %pow = tail call fp128 @llvm.pow.fp128(fp128 0xL00000000000000004000000000000000, fp128 %itofp)
  ret fp128 %pow
}

; FIXME: This asserts
; define bfloat @pow_sitofp_bf16_const_base_2(i32 %x) {
;   %itofp = sitofp i32 %x to bfloat
;   %pow = tail call bfloat @llvm.pow.bf16(bfloat 2.000000e+00, bfloat %itofp)
;   ret bfloat %pow
; }

; FIXME: This asserts
; define x86_fp80 @pow_sitofp_x86_fp80_const_base_2(i32 %x) {
;   %itofp = sitofp i32 %x to x86_fp80
;   %fp2 = fpext float 2.0 to x86_fp80
;   %pow = tail call x86_fp80 @llvm.pow.f80(x86_fp80 %fp2, x86_fp80 %itofp)
;   ret x86_fp80 %pow
; }

; FIXME: This asserts
; define ppc_fp128 @pow_sitofp_ppc_fp128_const_base_2(i32 %x) {
;   %itofp = sitofp i32 %x to ppc_fp128
;   %fp2 = fpext float 2.0 to ppc_fp128
;   %pow = tail call ppc_fp128 @llvm.pow.ppcf128(ppc_fp128 %fp2, ppc_fp128 %itofp)
;   ret ppc_fp128 %pow
; }


declare float @powf(float, float)
declare double @pow(double, double)
declare fp128 @powl(fp128, fp128)

define float @libcall_powf_sitofp_f32_const_base_2(i32 %x) {
; LDEXP-LABEL: define float @libcall_powf_sitofp_f32_const_base_2(
; LDEXP-SAME: i32 [[X:%.*]]) {
; LDEXP-NEXT:    [[LDEXPF:%.*]] = tail call float @ldexpf(float 1.000000e+00, i32 [[X]])
; LDEXP-NEXT:    ret float [[LDEXPF]]
;
; NOLDEXP-LABEL: define float @libcall_powf_sitofp_f32_const_base_2(
; NOLDEXP-SAME: i32 [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; NOLDEXP-NEXT:    [[EXP2F:%.*]] = tail call float @exp2f(float [[ITOFP]])
; NOLDEXP-NEXT:    ret float [[EXP2F]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call float @powf(float 2.000000e+00, float %itofp)
  ret float %pow
}

define float @libcall_powf_sitofp_f32_const_base_2__flags(i32 %x) {
; LDEXP-LABEL: define float @libcall_powf_sitofp_f32_const_base_2__flags(
; LDEXP-SAME: i32 [[X:%.*]]) {
; LDEXP-NEXT:    [[LDEXPF:%.*]] = tail call nnan nsz float @ldexpf(float 1.000000e+00, i32 [[X]])
; LDEXP-NEXT:    ret float [[LDEXPF]]
;
; NOLDEXP-LABEL: define float @libcall_powf_sitofp_f32_const_base_2__flags(
; NOLDEXP-SAME: i32 [[X:%.*]]) {
; NOLDEXP-NEXT:    [[ITOFP:%.*]] = sitofp i32 [[X]] to float
; NOLDEXP-NEXT:    [[EXP2F:%.*]] = tail call nnan nsz float @exp2f(float [[ITOFP]])
; NOLDEXP-NEXT:    ret float [[EXP2F]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call nnan nsz float @powf(float 2.000000e+00, float %itofp)
  ret float %pow
}

define float @readnone_libcall_powf_sitofp_f32_const_base_2(i32 %x) {
; CHECK-LABEL: define float @readnone_libcall_powf_sitofp_f32_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call float @llvm.ldexp.f32.i32(float 1.000000e+00, i32 [[X]])
; CHECK-NEXT:    ret float [[EXP2]]
;
  %itofp = sitofp i32 %x to float
  %pow = tail call float @powf(float 2.000000e+00, float %itofp) memory(none)
  ret float %pow
}

define double @readnone_libcall_pow_sitofp_f32_const_base_2(i32 %x) {
; CHECK-LABEL: define double @readnone_libcall_pow_sitofp_f32_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call double @llvm.ldexp.f64.i32(double 1.000000e+00, i32 [[X]])
; CHECK-NEXT:    ret double [[EXP2]]
;
  %itofp = sitofp i32 %x to double
  %pow = tail call double @pow(double 2.000000e+00, double %itofp) memory(none)
  ret double %pow
}

define fp128 @readnone_libcall_powl_sitofp_fp128_const_base_2(i32 %x) {
; CHECK-LABEL: define fp128 @readnone_libcall_powl_sitofp_fp128_const_base_2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:    [[EXP2:%.*]] = tail call fp128 @llvm.ldexp.f128.i32(fp128 0xL00000000000000003FFF000000000000, i32 [[X]])
; CHECK-NEXT:    ret fp128 [[EXP2]]
;
  %itofp = sitofp i32 %x to fp128
  %pow = tail call fp128 @powl(fp128 0xL00000000000000004000000000000000, fp128 %itofp) memory(none)
  ret fp128 %pow
}

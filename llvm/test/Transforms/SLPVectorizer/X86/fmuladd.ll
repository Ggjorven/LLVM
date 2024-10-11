; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=bdver1 -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX,AVX256
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX,AVX256
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=skylake-avx512 -mattr=-prefer-256-bit -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX,AVX512
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=skylake-avx512 -mattr=+prefer-256-bit -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX,AVX256

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

@srcA64 = common global [8 x double] zeroinitializer, align 64
@srcB64 = common global [8 x double] zeroinitializer, align 64
@srcC64 = common global [8 x double] zeroinitializer, align 64
@srcA32 = common global [16 x float] zeroinitializer, align 64
@srcB32 = common global [16 x float] zeroinitializer, align 64
@srcC32 = common global [16 x float] zeroinitializer, align 64
@dst64 = common global [8 x double] zeroinitializer, align 64
@dst32 = common global [16 x float] zeroinitializer, align 64

declare float @llvm.fmuladd.f32(float, float, float)
declare double @llvm.fmuladd.f64(double, double, double)

;
; fmuladd
;

define void @fmuladd_2f64() #0 {
; CHECK-LABEL: @fmuladd_2f64(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr @srcA64, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, ptr @srcB64, align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x double>, ptr @srcC64, align 8
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP1]], <2 x double> [[TMP2]], <2 x double> [[TMP3]])
; CHECK-NEXT:    store <2 x double> [[TMP4]], ptr @dst64, align 8
; CHECK-NEXT:    ret void
;
  %a0 = load double, ptr @srcA64, align 8
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 1), align 8
  %b0 = load double, ptr @srcB64, align 8
  %b1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 1), align 8
  %c0 = load double, ptr @srcC64, align 8
  %c1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 1), align 8
  %fmuladd0 = call double @llvm.fmuladd.f64(double %a0, double %b0, double %c0)
  %fmuladd1 = call double @llvm.fmuladd.f64(double %a1, double %b1, double %c1)
  store double %fmuladd0, ptr @dst64, align 8
  store double %fmuladd1, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 1), align 8
  ret void
}

define void @fmuladd_2f64_freeze() #0 {
; CHECK-LABEL: @fmuladd_2f64_freeze(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr @srcA64, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, ptr @srcB64, align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x double>, ptr @srcC64, align 8
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP1]], <2 x double> [[TMP2]], <2 x double> [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = freeze <2 x double> [[TMP4]]
; CHECK-NEXT:    store <2 x double> [[TMP5]], ptr @dst64, align 8
; CHECK-NEXT:    ret void
;
  %a0 = load double, ptr @srcA64, align 8
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 1), align 8
  %b0 = load double, ptr @srcB64, align 8
  %b1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 1), align 8
  %c0 = load double, ptr @srcC64, align 8
  %c1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 1), align 8
  %fmuladd0 = call double @llvm.fmuladd.f64(double %a0, double %b0, double %c0)
  %fmuladd1 = call double @llvm.fmuladd.f64(double %a1, double %b1, double %c1)
  %freeze0 = freeze double %fmuladd0
  %freeze1 = freeze double %fmuladd1
  store double %freeze0, ptr @dst64, align 8
  store double %freeze1, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 1), align 8
  ret void
}

define void @fmuladd_4f64() #0 {
; SSE-LABEL: @fmuladd_4f64(
; SSE-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr @srcA64, align 8
; SSE-NEXT:    [[TMP2:%.*]] = load <2 x double>, ptr @srcB64, align 8
; SSE-NEXT:    [[TMP3:%.*]] = load <2 x double>, ptr @srcC64, align 8
; SSE-NEXT:    [[TMP4:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP1]], <2 x double> [[TMP2]], <2 x double> [[TMP3]])
; SSE-NEXT:    store <2 x double> [[TMP4]], ptr @dst64, align 8
; SSE-NEXT:    [[TMP5:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 2), align 8
; SSE-NEXT:    [[TMP6:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 2), align 8
; SSE-NEXT:    [[TMP7:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 2), align 8
; SSE-NEXT:    [[TMP8:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP5]], <2 x double> [[TMP6]], <2 x double> [[TMP7]])
; SSE-NEXT:    store <2 x double> [[TMP8]], ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 2), align 8
; SSE-NEXT:    ret void
;
; AVX-LABEL: @fmuladd_4f64(
; AVX-NEXT:    [[TMP1:%.*]] = load <4 x double>, ptr @srcA64, align 8
; AVX-NEXT:    [[TMP2:%.*]] = load <4 x double>, ptr @srcB64, align 8
; AVX-NEXT:    [[TMP3:%.*]] = load <4 x double>, ptr @srcC64, align 8
; AVX-NEXT:    [[TMP4:%.*]] = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> [[TMP1]], <4 x double> [[TMP2]], <4 x double> [[TMP3]])
; AVX-NEXT:    store <4 x double> [[TMP4]], ptr @dst64, align 8
; AVX-NEXT:    ret void
;
  %a0 = load double, ptr @srcA64, align 8
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 1), align 8
  %a2 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 2), align 8
  %a3 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 3), align 8
  %b0 = load double, ptr @srcB64, align 8
  %b1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 1), align 8
  %b2 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 2), align 8
  %b3 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 3), align 8
  %c0 = load double, ptr @srcC64, align 8
  %c1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 1), align 8
  %c2 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 2), align 8
  %c3 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 3), align 8
  %fmuladd0 = call double @llvm.fmuladd.f64(double %a0, double %b0, double %c0)
  %fmuladd1 = call double @llvm.fmuladd.f64(double %a1, double %b1, double %c1)
  %fmuladd2 = call double @llvm.fmuladd.f64(double %a2, double %b2, double %c2)
  %fmuladd3 = call double @llvm.fmuladd.f64(double %a3, double %b3, double %c3)
  store double %fmuladd0, ptr @dst64, align 8
  store double %fmuladd1, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 1), align 8
  store double %fmuladd2, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 2), align 8
  store double %fmuladd3, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 3), align 8
  ret void
}

define void @fmuladd_8f64() #0 {
; SSE-LABEL: @fmuladd_8f64(
; SSE-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr @srcA64, align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <2 x double>, ptr @srcB64, align 4
; SSE-NEXT:    [[TMP3:%.*]] = load <2 x double>, ptr @srcC64, align 4
; SSE-NEXT:    [[TMP4:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP1]], <2 x double> [[TMP2]], <2 x double> [[TMP3]])
; SSE-NEXT:    store <2 x double> [[TMP4]], ptr @dst64, align 4
; SSE-NEXT:    [[TMP5:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 2), align 4
; SSE-NEXT:    [[TMP6:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 2), align 4
; SSE-NEXT:    [[TMP7:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 2), align 4
; SSE-NEXT:    [[TMP8:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP5]], <2 x double> [[TMP6]], <2 x double> [[TMP7]])
; SSE-NEXT:    store <2 x double> [[TMP8]], ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 2), align 4
; SSE-NEXT:    [[TMP9:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP10:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP11:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP12:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP9]], <2 x double> [[TMP10]], <2 x double> [[TMP11]])
; SSE-NEXT:    store <2 x double> [[TMP12]], ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP13:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 6), align 4
; SSE-NEXT:    [[TMP14:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 6), align 4
; SSE-NEXT:    [[TMP15:%.*]] = load <2 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 6), align 4
; SSE-NEXT:    [[TMP16:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[TMP13]], <2 x double> [[TMP14]], <2 x double> [[TMP15]])
; SSE-NEXT:    store <2 x double> [[TMP16]], ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 6), align 4
; SSE-NEXT:    ret void
;
; AVX256-LABEL: @fmuladd_8f64(
; AVX256-NEXT:    [[TMP1:%.*]] = load <4 x double>, ptr @srcA64, align 4
; AVX256-NEXT:    [[TMP2:%.*]] = load <4 x double>, ptr @srcB64, align 4
; AVX256-NEXT:    [[TMP3:%.*]] = load <4 x double>, ptr @srcC64, align 4
; AVX256-NEXT:    [[TMP4:%.*]] = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> [[TMP1]], <4 x double> [[TMP2]], <4 x double> [[TMP3]])
; AVX256-NEXT:    store <4 x double> [[TMP4]], ptr @dst64, align 4
; AVX256-NEXT:    [[TMP5:%.*]] = load <4 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 4), align 4
; AVX256-NEXT:    [[TMP6:%.*]] = load <4 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 4), align 4
; AVX256-NEXT:    [[TMP7:%.*]] = load <4 x double>, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 4), align 4
; AVX256-NEXT:    [[TMP8:%.*]] = call <4 x double> @llvm.fmuladd.v4f64(<4 x double> [[TMP5]], <4 x double> [[TMP6]], <4 x double> [[TMP7]])
; AVX256-NEXT:    store <4 x double> [[TMP8]], ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 4), align 4
; AVX256-NEXT:    ret void
;
; AVX512-LABEL: @fmuladd_8f64(
; AVX512-NEXT:    [[TMP1:%.*]] = load <8 x double>, ptr @srcA64, align 4
; AVX512-NEXT:    [[TMP2:%.*]] = load <8 x double>, ptr @srcB64, align 4
; AVX512-NEXT:    [[TMP3:%.*]] = load <8 x double>, ptr @srcC64, align 4
; AVX512-NEXT:    [[TMP4:%.*]] = call <8 x double> @llvm.fmuladd.v8f64(<8 x double> [[TMP1]], <8 x double> [[TMP2]], <8 x double> [[TMP3]])
; AVX512-NEXT:    store <8 x double> [[TMP4]], ptr @dst64, align 4
; AVX512-NEXT:    ret void
;
  %a0 = load double, ptr @srcA64, align 4
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 1), align 4
  %a2 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 2), align 4
  %a3 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 3), align 4
  %a4 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 4), align 4
  %a5 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 5), align 4
  %a6 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 6), align 4
  %a7 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcA64, i32 0, i64 7), align 4
  %b0 = load double, ptr @srcB64, align 4
  %b1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 1), align 4
  %b2 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 2), align 4
  %b3 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 3), align 4
  %b4 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 4), align 4
  %b5 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 5), align 4
  %b6 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 6), align 4
  %b7 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcB64, i32 0, i64 7), align 4
  %c0 = load double, ptr @srcC64, align 4
  %c1 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 1), align 4
  %c2 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 2), align 4
  %c3 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 3), align 4
  %c4 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 4), align 4
  %c5 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 5), align 4
  %c6 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 6), align 4
  %c7 = load double, ptr getelementptr inbounds ([8 x double], ptr @srcC64, i32 0, i64 7), align 4
  %fmuladd0 = call double @llvm.fmuladd.f64(double %a0, double %b0, double %c0)
  %fmuladd1 = call double @llvm.fmuladd.f64(double %a1, double %b1, double %c1)
  %fmuladd2 = call double @llvm.fmuladd.f64(double %a2, double %b2, double %c2)
  %fmuladd3 = call double @llvm.fmuladd.f64(double %a3, double %b3, double %c3)
  %fmuladd4 = call double @llvm.fmuladd.f64(double %a4, double %b4, double %c4)
  %fmuladd5 = call double @llvm.fmuladd.f64(double %a5, double %b5, double %c5)
  %fmuladd6 = call double @llvm.fmuladd.f64(double %a6, double %b6, double %c6)
  %fmuladd7 = call double @llvm.fmuladd.f64(double %a7, double %b7, double %c7)
  store double %fmuladd0, ptr @dst64, align 4
  store double %fmuladd1, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 1), align 4
  store double %fmuladd2, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 2), align 4
  store double %fmuladd3, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 3), align 4
  store double %fmuladd4, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 4), align 4
  store double %fmuladd5, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 5), align 4
  store double %fmuladd6, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 6), align 4
  store double %fmuladd7, ptr getelementptr inbounds ([8 x double], ptr @dst64, i32 0, i64 7), align 4
  ret void
}

define void @fmuladd_4f32() #0 {
; CHECK-LABEL: @fmuladd_4f32(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x float>, ptr @srcA32, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x float>, ptr @srcB32, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x float>, ptr @srcC32, align 4
; CHECK-NEXT:    [[TMP4:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP1]], <4 x float> [[TMP2]], <4 x float> [[TMP3]])
; CHECK-NEXT:    store <4 x float> [[TMP4]], ptr @dst32, align 4
; CHECK-NEXT:    ret void
;
  %a0 = load float, ptr @srcA32, align 4
  %a1 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 1), align 4
  %a2 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 2), align 4
  %a3 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 3), align 4
  %b0 = load float, ptr @srcB32, align 4
  %b1 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 1), align 4
  %b2 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 2), align 4
  %b3 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 3), align 4
  %c0 = load float, ptr @srcC32, align 4
  %c1 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 1), align 4
  %c2 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 2), align 4
  %c3 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 3), align 4
  %fmuladd0 = call float @llvm.fmuladd.f32(float %a0, float %b0, float %c0)
  %fmuladd1 = call float @llvm.fmuladd.f32(float %a1, float %b1, float %c1)
  %fmuladd2 = call float @llvm.fmuladd.f32(float %a2, float %b2, float %c2)
  %fmuladd3 = call float @llvm.fmuladd.f32(float %a3, float %b3, float %c3)
  store float %fmuladd0, ptr @dst32, align 4
  store float %fmuladd1, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 1), align 4
  store float %fmuladd2, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 2), align 4
  store float %fmuladd3, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 3), align 4
  ret void
}

define void @fmuladd_8f32() #0 {
; SSE-LABEL: @fmuladd_8f32(
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x float>, ptr @srcA32, align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <4 x float>, ptr @srcB32, align 4
; SSE-NEXT:    [[TMP3:%.*]] = load <4 x float>, ptr @srcC32, align 4
; SSE-NEXT:    [[TMP4:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP1]], <4 x float> [[TMP2]], <4 x float> [[TMP3]])
; SSE-NEXT:    store <4 x float> [[TMP4]], ptr @dst32, align 4
; SSE-NEXT:    [[TMP5:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP6:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP7:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP8:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP5]], <4 x float> [[TMP6]], <4 x float> [[TMP7]])
; SSE-NEXT:    store <4 x float> [[TMP8]], ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 4), align 4
; SSE-NEXT:    ret void
;
; AVX-LABEL: @fmuladd_8f32(
; AVX-NEXT:    [[TMP1:%.*]] = load <8 x float>, ptr @srcA32, align 4
; AVX-NEXT:    [[TMP2:%.*]] = load <8 x float>, ptr @srcB32, align 4
; AVX-NEXT:    [[TMP3:%.*]] = load <8 x float>, ptr @srcC32, align 4
; AVX-NEXT:    [[TMP4:%.*]] = call <8 x float> @llvm.fmuladd.v8f32(<8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x float> [[TMP3]])
; AVX-NEXT:    store <8 x float> [[TMP4]], ptr @dst32, align 4
; AVX-NEXT:    ret void
;
  %a0 = load float, ptr @srcA32, align 4
  %a1 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 1), align 4
  %a2 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 2), align 4
  %a3 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 3), align 4
  %a4 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 4), align 4
  %a5 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 5), align 4
  %a6 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 6), align 4
  %a7 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 7), align 4
  %b0 = load float, ptr @srcB32, align 4
  %b1 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 1), align 4
  %b2 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 2), align 4
  %b3 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 3), align 4
  %b4 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 4), align 4
  %b5 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 5), align 4
  %b6 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 6), align 4
  %b7 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 7), align 4
  %c0 = load float, ptr @srcC32, align 4
  %c1 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 1), align 4
  %c2 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 2), align 4
  %c3 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 3), align 4
  %c4 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 4), align 4
  %c5 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 5), align 4
  %c6 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 6), align 4
  %c7 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 7), align 4
  %fmuladd0 = call float @llvm.fmuladd.f32(float %a0, float %b0, float %c0)
  %fmuladd1 = call float @llvm.fmuladd.f32(float %a1, float %b1, float %c1)
  %fmuladd2 = call float @llvm.fmuladd.f32(float %a2, float %b2, float %c2)
  %fmuladd3 = call float @llvm.fmuladd.f32(float %a3, float %b3, float %c3)
  %fmuladd4 = call float @llvm.fmuladd.f32(float %a4, float %b4, float %c4)
  %fmuladd5 = call float @llvm.fmuladd.f32(float %a5, float %b5, float %c5)
  %fmuladd6 = call float @llvm.fmuladd.f32(float %a6, float %b6, float %c6)
  %fmuladd7 = call float @llvm.fmuladd.f32(float %a7, float %b7, float %c7)
  store float %fmuladd0, ptr @dst32, align 4
  store float %fmuladd1, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 1), align 4
  store float %fmuladd2, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 2), align 4
  store float %fmuladd3, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 3), align 4
  store float %fmuladd4, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 4), align 4
  store float %fmuladd5, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 5), align 4
  store float %fmuladd6, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 6), align 4
  store float %fmuladd7, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 7), align 4
  ret void
}

define void @fmuladd_16f32() #0 {
; SSE-LABEL: @fmuladd_16f32(
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x float>, ptr @srcA32, align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <4 x float>, ptr @srcB32, align 4
; SSE-NEXT:    [[TMP3:%.*]] = load <4 x float>, ptr @srcC32, align 4
; SSE-NEXT:    [[TMP4:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP1]], <4 x float> [[TMP2]], <4 x float> [[TMP3]])
; SSE-NEXT:    store <4 x float> [[TMP4]], ptr @dst32, align 4
; SSE-NEXT:    [[TMP5:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP6:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP7:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP8:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP5]], <4 x float> [[TMP6]], <4 x float> [[TMP7]])
; SSE-NEXT:    store <4 x float> [[TMP8]], ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 4), align 4
; SSE-NEXT:    [[TMP9:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 8), align 4
; SSE-NEXT:    [[TMP10:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 8), align 4
; SSE-NEXT:    [[TMP11:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 8), align 4
; SSE-NEXT:    [[TMP12:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP9]], <4 x float> [[TMP10]], <4 x float> [[TMP11]])
; SSE-NEXT:    store <4 x float> [[TMP12]], ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 8), align 4
; SSE-NEXT:    [[TMP13:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 12), align 4
; SSE-NEXT:    [[TMP14:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 12), align 4
; SSE-NEXT:    [[TMP15:%.*]] = load <4 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 12), align 4
; SSE-NEXT:    [[TMP16:%.*]] = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[TMP13]], <4 x float> [[TMP14]], <4 x float> [[TMP15]])
; SSE-NEXT:    store <4 x float> [[TMP16]], ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 12), align 4
; SSE-NEXT:    ret void
;
; AVX256-LABEL: @fmuladd_16f32(
; AVX256-NEXT:    [[TMP1:%.*]] = load <8 x float>, ptr @srcA32, align 4
; AVX256-NEXT:    [[TMP2:%.*]] = load <8 x float>, ptr @srcB32, align 4
; AVX256-NEXT:    [[TMP3:%.*]] = load <8 x float>, ptr @srcC32, align 4
; AVX256-NEXT:    [[TMP4:%.*]] = call <8 x float> @llvm.fmuladd.v8f32(<8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x float> [[TMP3]])
; AVX256-NEXT:    store <8 x float> [[TMP4]], ptr @dst32, align 4
; AVX256-NEXT:    [[TMP5:%.*]] = load <8 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 8), align 4
; AVX256-NEXT:    [[TMP6:%.*]] = load <8 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 8), align 4
; AVX256-NEXT:    [[TMP7:%.*]] = load <8 x float>, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 8), align 4
; AVX256-NEXT:    [[TMP8:%.*]] = call <8 x float> @llvm.fmuladd.v8f32(<8 x float> [[TMP5]], <8 x float> [[TMP6]], <8 x float> [[TMP7]])
; AVX256-NEXT:    store <8 x float> [[TMP8]], ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 8), align 4
; AVX256-NEXT:    ret void
;
; AVX512-LABEL: @fmuladd_16f32(
; AVX512-NEXT:    [[TMP1:%.*]] = load <16 x float>, ptr @srcA32, align 4
; AVX512-NEXT:    [[TMP2:%.*]] = load <16 x float>, ptr @srcB32, align 4
; AVX512-NEXT:    [[TMP3:%.*]] = load <16 x float>, ptr @srcC32, align 4
; AVX512-NEXT:    [[TMP4:%.*]] = call <16 x float> @llvm.fmuladd.v16f32(<16 x float> [[TMP1]], <16 x float> [[TMP2]], <16 x float> [[TMP3]])
; AVX512-NEXT:    store <16 x float> [[TMP4]], ptr @dst32, align 4
; AVX512-NEXT:    ret void
;
  %a0  = load float, ptr @srcA32, align 4
  %a1  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  1), align 4
  %a2  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  2), align 4
  %a3  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  3), align 4
  %a4  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  4), align 4
  %a5  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  5), align 4
  %a6  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  6), align 4
  %a7  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  7), align 4
  %a8  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  8), align 4
  %a9  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64  9), align 4
  %a10 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 10), align 4
  %a11 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 11), align 4
  %a12 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 12), align 4
  %a13 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 13), align 4
  %a14 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 14), align 4
  %a15 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcA32, i32 0, i64 15), align 4
  %b0  = load float, ptr @srcB32, align 4
  %b1  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  1), align 4
  %b2  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  2), align 4
  %b3  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  3), align 4
  %b4  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  4), align 4
  %b5  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  5), align 4
  %b6  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  6), align 4
  %b7  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  7), align 4
  %b8  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  8), align 4
  %b9  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64  9), align 4
  %b10 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 10), align 4
  %b11 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 11), align 4
  %b12 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 12), align 4
  %b13 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 13), align 4
  %b14 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 14), align 4
  %b15 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcB32, i32 0, i64 15), align 4
  %c0  = load float, ptr @srcC32, align 4
  %c1  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  1), align 4
  %c2  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  2), align 4
  %c3  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  3), align 4
  %c4  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  4), align 4
  %c5  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  5), align 4
  %c6  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  6), align 4
  %c7  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  7), align 4
  %c8  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  8), align 4
  %c9  = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64  9), align 4
  %c10 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 10), align 4
  %c11 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 11), align 4
  %c12 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 12), align 4
  %c13 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 13), align 4
  %c14 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 14), align 4
  %c15 = load float, ptr getelementptr inbounds ([16 x float], ptr @srcC32, i32 0, i64 15), align 4
  %fmuladd0  = call float @llvm.fmuladd.f32(float %a0 , float %b0 , float %c0 )
  %fmuladd1  = call float @llvm.fmuladd.f32(float %a1 , float %b1 , float %c1 )
  %fmuladd2  = call float @llvm.fmuladd.f32(float %a2 , float %b2 , float %c2 )
  %fmuladd3  = call float @llvm.fmuladd.f32(float %a3 , float %b3 , float %c3 )
  %fmuladd4  = call float @llvm.fmuladd.f32(float %a4 , float %b4 , float %c4 )
  %fmuladd5  = call float @llvm.fmuladd.f32(float %a5 , float %b5 , float %c5 )
  %fmuladd6  = call float @llvm.fmuladd.f32(float %a6 , float %b6 , float %c6 )
  %fmuladd7  = call float @llvm.fmuladd.f32(float %a7 , float %b7 , float %c7 )
  %fmuladd8  = call float @llvm.fmuladd.f32(float %a8 , float %b8 , float %c8 )
  %fmuladd9  = call float @llvm.fmuladd.f32(float %a9 , float %b9 , float %c9 )
  %fmuladd10 = call float @llvm.fmuladd.f32(float %a10, float %b10, float %c10)
  %fmuladd11 = call float @llvm.fmuladd.f32(float %a11, float %b11, float %c11)
  %fmuladd12 = call float @llvm.fmuladd.f32(float %a12, float %b12, float %c12)
  %fmuladd13 = call float @llvm.fmuladd.f32(float %a13, float %b13, float %c13)
  %fmuladd14 = call float @llvm.fmuladd.f32(float %a14, float %b14, float %c14)
  %fmuladd15 = call float @llvm.fmuladd.f32(float %a15, float %b15, float %c15)
  store float %fmuladd0 , ptr @dst32, align 4
  store float %fmuladd1 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  1), align 4
  store float %fmuladd2 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  2), align 4
  store float %fmuladd3 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  3), align 4
  store float %fmuladd4 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  4), align 4
  store float %fmuladd5 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  5), align 4
  store float %fmuladd6 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  6), align 4
  store float %fmuladd7 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  7), align 4
  store float %fmuladd8 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  8), align 4
  store float %fmuladd9 , ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64  9), align 4
  store float %fmuladd10, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 10), align 4
  store float %fmuladd11, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 11), align 4
  store float %fmuladd12, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 12), align 4
  store float %fmuladd13, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 13), align 4
  store float %fmuladd14, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 14), align 4
  store float %fmuladd15, ptr getelementptr inbounds ([16 x float], ptr @dst32, i32 0, i64 15), align 4
  ret void
}

attributes #0 = { nounwind }

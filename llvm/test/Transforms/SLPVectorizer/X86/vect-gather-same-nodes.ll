; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-pc-windows-msvc19.16.0 < %s | FileCheck %s

define void @test(ptr %a, ptr %b) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RESULT:%.*]] = alloca [4 x [4 x float]], i32 0, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load float, ptr null, align 4
; CHECK-NEXT:    [[ARRAYIDX120:%.*]] = getelementptr [4 x float], ptr [[B:%.*]], i64 0, i64 3
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x float>, ptr [[ARRAYIDX120]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x float> poison, float [[TMP0]], i32 3
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[TMP3:%.*]] = load float, ptr null, align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x float>, ptr [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <4 x float> [[TMP2]], float [[TMP3]], i32 2
; CHECK-NEXT:    [[TMP7:%.*]] = call <4 x float> @llvm.vector.insert.v4f32.v2f32(<4 x float> [[TMP6]], <2 x float> [[TMP1]], i64 0)
; CHECK-NEXT:    [[TMP8:%.*]] = fmul <4 x float> [[TMP5]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x float> [[TMP8]], <4 x float> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
; CHECK-NEXT:    [[TMP10:%.*]] = fmul <4 x float> [[TMP5]], zeroinitializer
; CHECK-NEXT:    [[TMP11:%.*]] = fadd <4 x float> [[TMP9]], [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = fadd <4 x float> [[TMP11]], zeroinitializer
; CHECK-NEXT:    store <4 x float> [[TMP12]], ptr [[RESULT]], align 4
; CHECK-NEXT:    br label [[FOR_BODY]]
;
entry:
  %result = alloca [4 x [4 x float]], i32 0, align 4
  %arrayidx11 = getelementptr [4 x [4 x float]], ptr %b, i64 0, i64 1
  %0 = load float, ptr %arrayidx11, align 4
  %1 = load float, ptr null, align 4
  %arrayidx120 = getelementptr [4 x float], ptr %b, i64 0, i64 3
  %2 = load float, ptr %arrayidx120, align 4
  br label %for.body

for.body:
  %3 = load float, ptr %a, align 4
  %mul = fmul float %3, 0.000000e+00
  %arrayidx9 = getelementptr [4 x [4 x float]], ptr %a, i64 0, i64 0, i64 1
  %4 = load float, ptr %arrayidx9, align 4
  %mul13 = fmul float %4, %0
  %add = fadd float %mul, %mul13
  %add22 = fadd float %add, 0.000000e+00
  store float %add22, ptr %result, align 4
  %5 = load float, ptr null, align 4
  %mul43 = fmul float %3, %5
  %mul51 = fmul float %4, 0.000000e+00
  %add52 = fadd float %mul43, %mul51
  %add61 = fadd float %add52, 0.000000e+00
  %arrayidx74 = getelementptr [4 x [4 x float]], ptr %result, i64 0, i64 0, i64 1
  store float %add61, ptr %arrayidx74, align 4
  %mul82 = fmul float %3, 0.000000e+00
  %mul90 = fmul float %4, %1
  %add91 = fadd float %mul82, %mul90
  %add100 = fadd float %add91, 0.000000e+00
  %arrayidx113 = getelementptr [4 x [4 x float]], ptr %result, i64 0, i64 0, i64 2
  store float %add100, ptr %arrayidx113, align 4
  %mul121 = fmul float %3, %2
  %mul129 = fmul float %4, 0.000000e+00
  %add130 = fadd float %mul121, %mul129
  %add139 = fadd float %add130, 0.000000e+00
  %arrayidx152 = getelementptr [4 x [4 x float]], ptr %result, i64 0, i64 0, i64 3
  store float %add139, ptr %arrayidx152, align 4
  br label %for.body
}

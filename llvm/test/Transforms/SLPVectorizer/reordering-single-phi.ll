; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: %if x86-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux < %s | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=aarch64-unknown-linux < %s | FileCheck %s %}

@a = external global [32000 x float], align 64

define void @test() {
; CHECK-LABEL: define void @test() {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[TMP0:%.*]] = phi float [ 0.000000e+00, %[[ENTRY]] ], [ [[TMP16:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[INDVARS_IV_NEXT:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = add nuw nsw i64 [[INDVARS_IV]], 4
; CHECK-NEXT:    [[ARRAYIDX31:%.*]] = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 [[TMP5]]
; CHECK-NEXT:    [[TMP6:%.*]] = load float, ptr [[ARRAYIDX31]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = load <4 x float>, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <4 x float> [[TMP14]], <4 x float> poison, <4 x i32> <i32 poison, i32 0, i32 1, i32 2>
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x float> [[TMP4]], float [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP15:%.*]] = fmul fast <4 x float> [[TMP11]], [[TMP14]]
; CHECK-NEXT:    store <4 x float> [[TMP15]], ptr [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 5
; CHECK-NEXT:    [[ARRAYIDX41:%.*]] = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 [[INDVARS_IV_NEXT]]
; CHECK-NEXT:    [[TMP16]] = load float, ptr [[ARRAYIDX41]], align 4
; CHECK-NEXT:    [[MUL45:%.*]] = fmul fast float [[TMP16]], [[TMP6]]
; CHECK-NEXT:    store float [[MUL45]], ptr [[ARRAYIDX31]], align 4
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i64 [[INDVARS_IV]], 31990
; CHECK-NEXT:    br i1 [[CMP2]], label %[[FOR_BODY]], label %[[EXIT:.*]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %0 = phi float [ 0.000000e+00, %entry ], [ %9, %for.body ]
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %1 = add nuw nsw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 %1
  %2 = load float, ptr %arrayidx, align 4
  %arrayidx6 = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 %indvars.iv
  %mul = fmul fast float %0, %2
  store float %mul, ptr %arrayidx6, align 4
  %3 = add nuw nsw i64 %indvars.iv, 2
  %arrayidx11 = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 %3
  %4 = load float, ptr %arrayidx11, align 4
  %mul15 = fmul fast float %4, %2
  store float %mul15, ptr %arrayidx, align 4
  %5 = add nuw nsw i64 %indvars.iv, 3
  %arrayidx21 = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 %5
  %6 = load float, ptr %arrayidx21, align 4
  %mul25 = fmul fast float %6, %4
  store float %mul25, ptr %arrayidx11, align 4
  %7 = add nuw nsw i64 %indvars.iv, 4
  %arrayidx31 = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 %7
  %8 = load float, ptr %arrayidx31, align 4
  %mul35 = fmul fast float %8, %6
  store float %mul35, ptr %arrayidx21, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 5
  %arrayidx41 = getelementptr inbounds [32000 x float], ptr @a, i64 0, i64 %indvars.iv.next
  %9 = load float, ptr %arrayidx41, align 4
  %mul45 = fmul fast float %9, %8
  store float %mul45, ptr %arrayidx31, align 4
  %cmp2 = icmp ult i64 %indvars.iv, 31990
  br i1 %cmp2, label %for.body, label %exit

exit:
  ret void
}

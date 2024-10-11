; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize -prefer-predicate-over-epilogue=scalar-epilogue -mtriple aarch64-unknown-linux-gnu \
; RUN:   -mattr=+sve -force-vector-interleave=1 -force-vector-width=4 -prefer-inloop-reductions -S | FileCheck %s

define float @cond_fadd(ptr noalias nocapture readonly %a, ptr noalias nocapture readonly %cond, i64 %N){
; CHECK-LABEL: @cond_fadd(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 4
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 4
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], [[TMP3]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi float [ 1.000000e+00, [[VECTOR_PH]] ], [ [[TMP14:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds float, ptr [[COND:%.*]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds float, ptr [[TMP7]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x float>, ptr [[TMP8]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = fcmp une <vscale x 4 x float> [[WIDE_LOAD]], shufflevector (<vscale x 4 x float> insertelement (<vscale x 4 x float> poison, float 2.000000e+00, i64 0), <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr float, ptr [[A:%.*]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr float, ptr [[TMP10]], i32 0
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 4 x float> @llvm.masked.load.nxv4f32.p0(ptr [[TMP11]], i32 4, <vscale x 4 x i1> [[TMP9]], <vscale x 4 x float> poison)
; CHECK-NEXT:    [[TMP12:%.*]] = select fast <vscale x 4 x i1> [[TMP9]], <vscale x 4 x float> [[WIDE_MASKED_LOAD]], <vscale x 4 x float> zeroinitializer
; CHECK-NEXT:    [[TMP13:%.*]] = call fast float @llvm.vector.reduce.fadd.nxv4f32(float 0.000000e+00, <vscale x 4 x float> [[TMP12]])
; CHECK-NEXT:    [[TMP14]] = fadd fast float [[TMP13]], [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP5]]
; CHECK-NEXT:    [[TMP15:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP15]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ [[TMP14]], [[MIDDLE_BLOCK]] ], [ 1.000000e+00, [[ENTRY]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_NEXT:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[RDX:%.*]] = phi float [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[RES:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[COND]], i64 [[INDVARS]]
; CHECK-NEXT:    [[TMP16:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[TOBOOL:%.*]] = fcmp une float [[TMP16]], 2.000000e+00
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[INDVARS]]
; CHECK-NEXT:    [[TMP17:%.*]] = load float, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[FADD:%.*]] = fadd fast float [[RDX]], [[TMP17]]
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[RES]] = phi float [ [[FADD]], [[IF_THEN]] ], [ [[RDX]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_NEXT]] = add nuw nsw i64 [[INDVARS]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RES_LCSSA:%.*]] = phi float [ [[RES]], [[FOR_INC]] ], [ [[TMP14]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[RES_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %indvars = phi i64 [ 0, %entry ], [ %indvars.next, %for.inc ]
  %rdx = phi float [ 1.000000e+00, %entry ], [ %res, %for.inc ]
  %arrayidx = getelementptr inbounds float, ptr %cond, i64 %indvars
  %0 = load float, ptr %arrayidx
  %tobool = fcmp une float %0, 2.000000e+00
  br i1 %tobool, label %if.then, label %for.inc

if.then:
  %arrayidx2 = getelementptr inbounds float, ptr %a, i64 %indvars
  %1 = load float, ptr %arrayidx2
  %fadd = fadd fast float %rdx, %1
  br label %for.inc

for.inc:
  %res = phi float [ %fadd, %if.then ], [ %rdx, %for.body ]
  %indvars.next = add nuw nsw i64 %indvars, 1
  %exitcond.not = icmp eq i64 %indvars.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %res
}

define float @cond_cmp_sel(ptr noalias %a, ptr noalias %cond, i64 %N) {
; CHECK-LABEL: @cond_cmp_sel(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 4
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 4
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], [[TMP3]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi float [ 1.000000e+00, [[VECTOR_PH]] ], [ [[RDX_MINMAX_SELECT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds float, ptr [[COND:%.*]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds float, ptr [[TMP7]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x float>, ptr [[TMP8]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = fcmp une <vscale x 4 x float> [[WIDE_LOAD]], shufflevector (<vscale x 4 x float> insertelement (<vscale x 4 x float> poison, float 3.000000e+00, i64 0), <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr float, ptr [[A:%.*]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr float, ptr [[TMP10]], i32 0
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 4 x float> @llvm.masked.load.nxv4f32.p0(ptr [[TMP11]], i32 4, <vscale x 4 x i1> [[TMP9]], <vscale x 4 x float> poison)
; CHECK-NEXT:    [[TMP12:%.*]] = select fast <vscale x 4 x i1> [[TMP9]], <vscale x 4 x float> [[WIDE_MASKED_LOAD]], <vscale x 4 x float> shufflevector (<vscale x 4 x float> insertelement (<vscale x 4 x float> poison, float 0x47EFFFFFE0000000, i64 0), <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP13:%.*]] = call fast float @llvm.vector.reduce.fmin.nxv4f32(<vscale x 4 x float> [[TMP12]])
; CHECK-NEXT:    [[RDX_MINMAX_CMP:%.*]] = fcmp fast olt float [[TMP13]], [[VEC_PHI]]
; CHECK-NEXT:    [[RDX_MINMAX_SELECT]] = select fast i1 [[RDX_MINMAX_CMP]], float [[TMP13]], float [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP5]]
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ [[RDX_MINMAX_SELECT]], [[MIDDLE_BLOCK]] ], [ 1.000000e+00, [[ENTRY]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[RDX:%.*]] = phi float [ [[RES:%.*]], [[FOR_INC]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[COND]], i64 [[IV]]
; CHECK-NEXT:    [[TMP15:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[TOBOOL:%.*]] = fcmp une float [[TMP15]], 3.000000e+00
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[IV]]
; CHECK-NEXT:    [[TMP16:%.*]] = load float, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp fast olt float [[RDX]], [[TMP16]]
; CHECK-NEXT:    [[FSEL:%.*]] = select fast i1 [[FCMP]], float [[RDX]], float [[TMP16]]
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[RES]] = phi float [ [[RDX]], [[FOR_BODY]] ], [ [[FSEL]], [[IF_THEN]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RES_LCSSA:%.*]] = phi float [ [[RES]], [[FOR_INC]] ], [ [[RDX_MINMAX_SELECT]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[RES_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %rdx = phi float [ %res, %for.inc ], [ 1.000000e+00, %entry ]
  %arrayidx = getelementptr inbounds float, ptr %cond, i64 %iv
  %0 = load float, ptr %arrayidx
  %tobool = fcmp une float %0, 3.000000e+00
  br i1 %tobool, label %if.then, label %for.inc

if.then:
  %arrayidx2 = getelementptr inbounds float, ptr %a, i64 %iv
  %1 = load float, ptr %arrayidx2
  %fcmp = fcmp fast olt float %rdx, %1
  %fsel = select fast i1 %fcmp, float %rdx, float %1
  br label %for.inc

for.inc:
  %res = phi float [ %rdx, %for.body ], [ %fsel, %if.then ]
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret float %res
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}

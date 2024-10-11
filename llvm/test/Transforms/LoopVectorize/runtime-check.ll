; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -aa-pipeline=basic-aa -passes=loop-vectorize,dce,instcombine -force-vector-interleave=1 -force-vector-width=4  -S | FileCheck %s
; RUN: opt < %s -aa-pipeline= -passes=loop-vectorize -S -pass-remarks-analysis='loop-vectorize' 2>&1 | FileCheck %s -check-prefix=FORCED_OPTSIZE

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

; Make sure we vectorize this loop:
; int foo(float *a, float *b, int n) {
;   for (int i=0; i<n; ++i)
;     a[i] = b[i] * 3;
; }

define i32 @foo(ptr nocapture %a, ptr nocapture %b, i32 %n) nounwind uwtable ssp {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B2:%.*]] = ptrtoint ptr [[B:%.*]] to i64, !dbg [[DBG4:![0-9]+]]
; CHECK-NEXT:    [[A1:%.*]] = ptrtoint ptr [[A:%.*]] to i64, !dbg [[DBG4]]
; CHECK-NEXT:    [[CMP6:%.*]] = icmp sgt i32 [[N:%.*]], 0, !dbg [[DBG4]]
; CHECK-NEXT:    br i1 [[CMP6]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]], !dbg [[DBG4]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext nneg i32 [[N]] to i64, !dbg [[DBG9:![0-9]+]]
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N]], 4, !dbg [[DBG9]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]], !dbg [[DBG9]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP1:%.*]] = sub i64 [[A1]], [[B2]], !dbg [[DBG9]]
; CHECK-NEXT:    [[DIFF_CHECK:%.*]] = icmp ult i64 [[TMP1]], 16, !dbg [[DBG9]]
; CHECK-NEXT:    br i1 [[DIFF_CHECK]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]], !dbg [[DBG9]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[TMP0]], 2147483644, !dbg [[DBG9]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]], !dbg [[DBG9]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ], !dbg [[DBG9]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds float, ptr [[B]], i64 [[INDEX]], !dbg [[DBG9]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, ptr [[TMP2]], align 4, !dbg [[DBG9]]
; CHECK-NEXT:    [[TMP3:%.*]] = fmul <4 x float> [[WIDE_LOAD]], <float 3.000000e+00, float 3.000000e+00, float 3.000000e+00, float 3.000000e+00>, !dbg [[DBG9]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[INDEX]], !dbg [[DBG9]]
; CHECK-NEXT:    store <4 x float> [[TMP3]], ptr [[TMP4]], align 4, !dbg [[DBG9]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4, !dbg [[DBG9]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]], !dbg [[DBG9]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !dbg [[DBG9]], !llvm.loop [[LOOP10:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[TMP0]], !dbg [[DBG9]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END_LOOPEXIT:%.*]], label [[SCALAR_PH]], !dbg [[DBG9]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_PREHEADER]] ], [ 0, [[VECTOR_MEMCHECK]] ], !dbg [[DBG9]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]], !dbg [[DBG9]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], !dbg [[DBG9]]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[B]], i64 [[INDVARS_IV]], !dbg [[DBG9]]
; CHECK-NEXT:    [[TMP6:%.*]] = load float, ptr [[ARRAYIDX]], align 4, !dbg [[DBG9]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[TMP6]], 3.000000e+00, !dbg [[DBG9]]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[INDVARS_IV]], !dbg [[DBG9]]
; CHECK-NEXT:    store float [[MUL]], ptr [[ARRAYIDX2]], align 4, !dbg [[DBG9]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], 1, !dbg [[DBG9]]
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32, !dbg [[DBG9]]
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[N]], [[LFTR_WIDEIV]], !dbg [[DBG9]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END_LOOPEXIT]], label [[FOR_BODY]], !dbg [[DBG9]], !llvm.loop [[LOOP13:![0-9]+]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]], !dbg [[DBG14:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret i32 undef, !dbg [[DBG14]]
;
; FORCED_OPTSIZE-LABEL: @foo(
; FORCED_OPTSIZE-NEXT:  entry:
; FORCED_OPTSIZE-NEXT:    [[CMP6:%.*]] = icmp sgt i32 [[N:%.*]], 0, !dbg [[DBG4:![0-9]+]]
; FORCED_OPTSIZE-NEXT:    br i1 [[CMP6]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]], !dbg [[DBG4]]
; FORCED_OPTSIZE:       for.body.preheader:
; FORCED_OPTSIZE-NEXT:    br label [[FOR_BODY:%.*]], !dbg [[DBG9:![0-9]+]]
; FORCED_OPTSIZE:       for.body:
; FORCED_OPTSIZE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ], !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i64 [[INDVARS_IV]], !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[TMP0:%.*]] = load float, ptr [[ARRAYIDX]], align 4, !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[MUL:%.*]] = fmul float [[TMP0]], 3.000000e+00, !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i64 [[INDVARS_IV]], !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    store float [[MUL]], ptr [[ARRAYIDX2]], align 4, !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], 1, !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32, !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[LFTR_WIDEIV]], [[N]], !dbg [[DBG9]]
; FORCED_OPTSIZE-NEXT:    br i1 [[EXITCOND]], label [[FOR_END_LOOPEXIT:%.*]], label [[FOR_BODY]], !dbg [[DBG9]]
; FORCED_OPTSIZE:       for.end.loopexit:
; FORCED_OPTSIZE-NEXT:    br label [[FOR_END]], !dbg [[DBG10:![0-9]+]]
; FORCED_OPTSIZE:       for.end:
; FORCED_OPTSIZE-NEXT:    ret i32 undef, !dbg [[DBG10]]
;
entry:
  %cmp6 = icmp sgt i32 %n, 0, !dbg !6
  br i1 %cmp6, label %for.body, label %for.end, !dbg !6

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ], !dbg !7
  %arrayidx = getelementptr inbounds float, ptr %b, i64 %indvars.iv, !dbg !7
  %0 = load float, ptr %arrayidx, align 4, !dbg !7
  %mul = fmul float %0, 3.000000e+00, !dbg !7
  %arrayidx2 = getelementptr inbounds float, ptr %a, i64 %indvars.iv, !dbg !7
  store float %mul, ptr %arrayidx2, align 4, !dbg !7
  %indvars.iv.next = add i64 %indvars.iv, 1, !dbg !7
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32, !dbg !7
  %exitcond = icmp eq i32 %lftr.wideiv, %n, !dbg !7
  br i1 %exitcond, label %for.end, label %for.body, !dbg !7

for.end:                                          ; preds = %for.body, %entry
  ret i32 undef, !dbg !8
}

; Make sure that we try to vectorize loops with a runtime check if the
; dependency check fails.

define void @test_runtime_check(ptr %a, float %b, i64 %offset, i64 %offset2, i64 %n) {
; CHECK-LABEL: @test_runtime_check(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP0:%.*]] = shl i64 [[OFFSET:%.*]], 2
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[N]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP1]]
; CHECK-NEXT:    [[SCEVGEP1:%.*]] = getelementptr i8, ptr [[TMP2]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[OFFSET2:%.*]], 2
; CHECK-NEXT:    [[SCEVGEP2:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP3]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr i8, ptr [[A]], i64 [[TMP1]]
; CHECK-NEXT:    [[SCEVGEP3:%.*]] = getelementptr i8, ptr [[TMP4]], i64 [[TMP3]]
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[SCEVGEP]], [[SCEVGEP3]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[SCEVGEP2]], [[SCEVGEP1]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], -4
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x float> poison, float [[B:%.*]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x float> [[BROADCAST_SPLATINSERT]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr float, ptr [[A]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr float, ptr [[TMP5]], i64 [[OFFSET]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, ptr [[TMP6]], align 4, !alias.scope [[META15:![0-9]+]], !noalias [[META18:![0-9]+]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr float, ptr [[A]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr float, ptr [[TMP7]], i64 [[OFFSET2]]
; CHECK-NEXT:    [[WIDE_LOAD4:%.*]] = load <4 x float>, ptr [[TMP8]], align 4, !alias.scope [[META18]]
; CHECK-NEXT:    [[TMP9:%.*]] = fmul fast <4 x float> [[BROADCAST_SPLAT]], [[WIDE_LOAD4]]
; CHECK-NEXT:    [[TMP10:%.*]] = fadd fast <4 x float> [[WIDE_LOAD]], [[TMP9]]
; CHECK-NEXT:    store <4 x float> [[TMP10]], ptr [[TMP6]], align 4, !alias.scope [[META15]], !noalias [[META18]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP20:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr float, ptr [[A]], i64 [[IV]]
; CHECK-NEXT:    [[ARR_IDX:%.*]] = getelementptr float, ptr [[TMP12]], i64 [[OFFSET]]
; CHECK-NEXT:    [[L1:%.*]] = load float, ptr [[ARR_IDX]], align 4
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr float, ptr [[A]], i64 [[IV]]
; CHECK-NEXT:    [[ARR_IDX2:%.*]] = getelementptr float, ptr [[TMP13]], i64 [[OFFSET2]]
; CHECK-NEXT:    [[L2:%.*]] = load float, ptr [[ARR_IDX2]], align 4
; CHECK-NEXT:    [[M:%.*]] = fmul fast float [[B]], [[L2]]
; CHECK-NEXT:    [[AD:%.*]] = fadd fast float [[L1]], [[M]]
; CHECK-NEXT:    store float [[AD]], ptr [[ARR_IDX]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP21:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
; FORCED_OPTSIZE-LABEL: @test_runtime_check(
; FORCED_OPTSIZE-NEXT:  entry:
; FORCED_OPTSIZE-NEXT:    br label [[FOR_BODY:%.*]]
; FORCED_OPTSIZE:       for.body:
; FORCED_OPTSIZE-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; FORCED_OPTSIZE-NEXT:    [[IND_SUM:%.*]] = add i64 [[IV]], [[OFFSET:%.*]]
; FORCED_OPTSIZE-NEXT:    [[ARR_IDX:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i64 [[IND_SUM]]
; FORCED_OPTSIZE-NEXT:    [[L1:%.*]] = load float, ptr [[ARR_IDX]], align 4
; FORCED_OPTSIZE-NEXT:    [[IND_SUM2:%.*]] = add i64 [[IV]], [[OFFSET2:%.*]]
; FORCED_OPTSIZE-NEXT:    [[ARR_IDX2:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[IND_SUM2]]
; FORCED_OPTSIZE-NEXT:    [[L2:%.*]] = load float, ptr [[ARR_IDX2]], align 4
; FORCED_OPTSIZE-NEXT:    [[M:%.*]] = fmul fast float [[B:%.*]], [[L2]]
; FORCED_OPTSIZE-NEXT:    [[AD:%.*]] = fadd fast float [[L1]], [[M]]
; FORCED_OPTSIZE-NEXT:    store float [[AD]], ptr [[ARR_IDX]], align 4
; FORCED_OPTSIZE-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; FORCED_OPTSIZE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; FORCED_OPTSIZE-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT:%.*]], label [[FOR_BODY]]
; FORCED_OPTSIZE:       loopexit:
; FORCED_OPTSIZE-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %ind.sum = add i64 %iv, %offset
  %arr.idx = getelementptr inbounds float, ptr %a, i64 %ind.sum
  %l1 = load float, ptr %arr.idx, align 4
  %ind.sum2 = add i64 %iv, %offset2
  %arr.idx2 = getelementptr inbounds float, ptr %a, i64 %ind.sum2
  %l2 = load float, ptr %arr.idx2, align 4
  %m = fmul fast float %b, %l2
  %ad = fadd fast float %l1, %m
  store float %ad, ptr %arr.idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, %n
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret void
}

; Check we do not generate runtime checks if we found a known dependence preventing
; vectorization. In this case, it is a read of c[i-1] followed by a write of c[i].
; The runtime checks would always fail.

; void test_runtime_check2(float *a, float b, unsigned offset, unsigned offset2, unsigned n, float *c) {
;   for (unsigned i = 1; i < n; i++) {
;     a[i+o1] += a[i+o2] + b;
;     c[i] = c[i-1] + b;
;   }
; }

define void @test_runtime_check2(ptr %a, float %b, i64 %offset, i64 %offset2, i64 %n, ptr %c) {
; CHECK-LABEL: @test_runtime_check2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr float, ptr [[A:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[ARR_IDX:%.*]] = getelementptr float, ptr [[TMP0]], i64 [[OFFSET:%.*]]
; CHECK-NEXT:    [[L1:%.*]] = load float, ptr [[ARR_IDX]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr float, ptr [[A]], i64 [[IV]]
; CHECK-NEXT:    [[ARR_IDX2:%.*]] = getelementptr float, ptr [[TMP1]], i64 [[OFFSET2:%.*]]
; CHECK-NEXT:    [[L2:%.*]] = load float, ptr [[ARR_IDX2]], align 4
; CHECK-NEXT:    [[M:%.*]] = fmul fast float [[B:%.*]], [[L2]]
; CHECK-NEXT:    [[AD:%.*]] = fadd fast float [[L1]], [[M]]
; CHECK-NEXT:    store float [[AD]], ptr [[ARR_IDX]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, ptr [[C:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[C_IDX:%.*]] = getelementptr i8, ptr [[TMP2]], i64 -4
; CHECK-NEXT:    [[LC:%.*]] = load float, ptr [[C_IDX]], align 4
; CHECK-NEXT:    [[VC:%.*]] = fadd float [[LC]], 1.000000e+00
; CHECK-NEXT:    [[C_IDX2:%.*]] = getelementptr inbounds float, ptr [[C]], i64 [[IV]]
; CHECK-NEXT:    store float [[VC]], ptr [[C_IDX2]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT:%.*]], label [[FOR_BODY]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
; FORCED_OPTSIZE-LABEL: @test_runtime_check2(
; FORCED_OPTSIZE-NEXT:  entry:
; FORCED_OPTSIZE-NEXT:    br label [[FOR_BODY:%.*]]
; FORCED_OPTSIZE:       for.body:
; FORCED_OPTSIZE-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; FORCED_OPTSIZE-NEXT:    [[IND_SUM:%.*]] = add i64 [[IV]], [[OFFSET:%.*]]
; FORCED_OPTSIZE-NEXT:    [[ARR_IDX:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i64 [[IND_SUM]]
; FORCED_OPTSIZE-NEXT:    [[L1:%.*]] = load float, ptr [[ARR_IDX]], align 4
; FORCED_OPTSIZE-NEXT:    [[IND_SUM2:%.*]] = add i64 [[IV]], [[OFFSET2:%.*]]
; FORCED_OPTSIZE-NEXT:    [[ARR_IDX2:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[IND_SUM2]]
; FORCED_OPTSIZE-NEXT:    [[L2:%.*]] = load float, ptr [[ARR_IDX2]], align 4
; FORCED_OPTSIZE-NEXT:    [[M:%.*]] = fmul fast float [[B:%.*]], [[L2]]
; FORCED_OPTSIZE-NEXT:    [[AD:%.*]] = fadd fast float [[L1]], [[M]]
; FORCED_OPTSIZE-NEXT:    store float [[AD]], ptr [[ARR_IDX]], align 4
; FORCED_OPTSIZE-NEXT:    [[C_IND:%.*]] = add i64 [[IV]], -1
; FORCED_OPTSIZE-NEXT:    [[C_IDX:%.*]] = getelementptr inbounds float, ptr [[C:%.*]], i64 [[C_IND]]
; FORCED_OPTSIZE-NEXT:    [[LC:%.*]] = load float, ptr [[C_IDX]], align 4
; FORCED_OPTSIZE-NEXT:    [[VC:%.*]] = fadd float [[LC]], 1.000000e+00
; FORCED_OPTSIZE-NEXT:    [[C_IDX2:%.*]] = getelementptr inbounds float, ptr [[C]], i64 [[IV]]
; FORCED_OPTSIZE-NEXT:    store float [[VC]], ptr [[C_IDX2]], align 4
; FORCED_OPTSIZE-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; FORCED_OPTSIZE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; FORCED_OPTSIZE-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT:%.*]], label [[FOR_BODY]]
; FORCED_OPTSIZE:       loopexit:
; FORCED_OPTSIZE-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %ind.sum = add i64 %iv, %offset
  %arr.idx = getelementptr inbounds float, ptr %a, i64 %ind.sum
  %l1 = load float, ptr %arr.idx, align 4
  %ind.sum2 = add i64 %iv, %offset2
  %arr.idx2 = getelementptr inbounds float, ptr %a, i64 %ind.sum2
  %l2 = load float, ptr %arr.idx2, align 4
  %m = fmul fast float %b, %l2
  %ad = fadd fast float %l1, %m
  store float %ad, ptr %arr.idx, align 4
  %c.ind = add i64 %iv, -1
  %c.idx = getelementptr inbounds float, ptr %c, i64 %c.ind
  %lc = load float, ptr %c.idx, align 4
  %vc = fadd float %lc, 1.0
  %c.idx2 = getelementptr inbounds float, ptr %c, i64 %iv
  store float %vc, ptr %c.idx2
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, %n
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret void
}


define dso_local void @forced_optsize(ptr noalias nocapture readonly %x_p, ptr noalias nocapture readonly %y_p, ptr noalias nocapture %z_p) minsize optsize {
; CHECK-LABEL: @forced_optsize(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i64, ptr [[X_P:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x i64>, ptr [[TMP0]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i64, ptr [[Y_P:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <2 x i64>, ptr [[TMP1]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw <2 x i64> [[WIDE_LOAD1]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i64, ptr [[Z_P:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    store <2 x i64> [[TMP2]], ptr [[TMP3]], align 8
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i64 [[INDEX_NEXT]], 128
; CHECK-NEXT:    br i1 [[TMP4]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP22:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP23:![0-9]+]]
;
; FORCED_OPTSIZE-LABEL: @forced_optsize(
; FORCED_OPTSIZE-NEXT:  entry:
; FORCED_OPTSIZE-NEXT:    br label [[FOR_BODY:%.*]]
; FORCED_OPTSIZE:       for.cond.cleanup:
; FORCED_OPTSIZE-NEXT:    ret void
; FORCED_OPTSIZE:       for.body:
; FORCED_OPTSIZE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; FORCED_OPTSIZE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, ptr [[X_P:%.*]], i64 [[INDVARS_IV]]
; FORCED_OPTSIZE-NEXT:    [[TMP0:%.*]] = load i64, ptr [[ARRAYIDX]], align 8
; FORCED_OPTSIZE-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, ptr [[Y_P:%.*]], i64 [[INDVARS_IV]]
; FORCED_OPTSIZE-NEXT:    [[TMP1:%.*]] = load i64, ptr [[ARRAYIDX2]], align 8
; FORCED_OPTSIZE-NEXT:    [[ADD:%.*]] = add nsw i64 [[TMP1]], [[TMP0]]
; FORCED_OPTSIZE-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds i64, ptr [[Z_P:%.*]], i64 [[INDVARS_IV]]
; FORCED_OPTSIZE-NEXT:    store i64 [[ADD]], ptr [[ARRAYIDX4]], align 8
; FORCED_OPTSIZE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; FORCED_OPTSIZE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 128
; FORCED_OPTSIZE-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]], !llvm.loop [[LOOP11:![0-9]+]]
;
entry:
  br label %for.body

for.cond.cleanup:
  ret void

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, ptr %x_p, i64 %indvars.iv
  %0 = load i64, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds i64, ptr %y_p, i64 %indvars.iv
  %1 = load i64, ptr %arrayidx2, align 8
  %add = add nsw i64 %1, %0
  %arrayidx4 = getelementptr inbounds i64, ptr %z_p, i64 %indvars.iv
  store i64 %add, ptr %arrayidx4, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %for.cond.cleanup, label %for.body, !llvm.loop !12
}

; CHECK: !9 = !DILocation(line: 101, column: 1, scope: !{{.*}})

!llvm.module.flags = !{!0, !1}
!llvm.dbg.cu = !{!9}
!0 = !{i32 2, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}

!2 = !{}
!3 = !DISubroutineType(types: !2)
!4 = !DIFile(filename: "test.cpp", directory: "/tmp")
!5 = distinct !DISubprogram(name: "foo", scope: !4, file: !4, line: 99, type: !3, isLocal: false, isDefinition: true, scopeLine: 100, flags: DIFlagPrototyped, isOptimized: false, unit: !9, retainedNodes: !2)
!6 = !DILocation(line: 100, column: 1, scope: !5)
!7 = !DILocation(line: 101, column: 1, scope: !5)
!8 = !DILocation(line: 102, column: 1, scope: !5)
!9 = distinct !DICompileUnit(language: DW_LANG_C99, producer: "clang",
  file: !10,
  isOptimized: true, flags: "-O2",
  splitDebugFilename: "abc.debug", emissionKind: 2)
!10 = !DIFile(filename: "path/to/file", directory: "/path/to/dir")
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = distinct !{!12, !13, !14}
!13 = !{!"llvm.loop.vectorize.width", i32 2}
!14 = !{!"llvm.loop.vectorize.enable", i1 true}

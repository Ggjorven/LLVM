; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-vectorize -mtriple=powerpc64le-unknown-unknown \
; RUN:   -force-target-max-vector-interleave=1 -mcpu=pwr9 < %s | FileCheck %s
define dso_local void @test(ptr %Arr, i32 signext %Len) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 0, [[LEN:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[LEN]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[LEN]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[LEN]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[ARR:%.*]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, ptr [[TMP2]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> [[WIDE_LOAD]])
; CHECK-NEXT:    [[TMP5:%.*]] = sext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 0
; CHECK-NEXT:    store <4 x i32> [[TMP4]], ptr [[TMP7]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[LEN]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_FOR_COND_CLEANUP_CRIT_EDGE:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_LR_PH]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.for.cond.cleanup_crit_edge:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    br label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[IDXPROM:%.*]] = sext i32 [[I_02]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[TMP10:%.*]] = call i32 @llvm.bswap.i32(i32 [[TMP9]])
; CHECK-NEXT:    [[IDXPROM1:%.*]] = sext i32 [[I_02]] to i64
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[IDXPROM1]]
; CHECK-NEXT:    store i32 [[TMP10]], ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nsw i32 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[INC]], [[LEN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_FOR_COND_CLEANUP_CRIT_EDGE]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp slt i32 0, %Len
  br i1 %cmp1, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  br label %for.body

for.cond.for.cond.cleanup_crit_edge:              ; preds = %for.inc
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.for.cond.cleanup_crit_edge, %entry
  br label %for.end

for.body:                                         ; preds = %for.body.lr.ph, %for.inc
  %i.02 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.inc ]
  %idxprom = sext i32 %i.02 to i64
  %arrayidx = getelementptr inbounds i32, ptr %Arr, i64 %idxprom
  %0 = load i32, ptr %arrayidx, align 4
  %1 = call i32 @llvm.bswap.i32(i32 %0)
  %idxprom1 = sext i32 %i.02 to i64
  %arrayidx2 = getelementptr inbounds i32, ptr %Arr, i64 %idxprom1
  store i32 %1, ptr %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.02, 1
  %cmp = icmp slt i32 %inc, %Len
  br i1 %cmp, label %for.body, label %for.cond.for.cond.cleanup_crit_edge

for.end:                                          ; preds = %for.cond.cleanup
  ret void
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32)

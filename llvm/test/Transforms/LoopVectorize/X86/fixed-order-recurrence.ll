; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -S -o - %s  | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc_linux"

define void @firstorderrec(ptr nocapture noundef readonly %x, ptr noalias nocapture noundef writeonly %y, i32 noundef %n) {
; CHECK-LABEL: @firstorderrec(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP18:%.*]] = icmp sgt i32 [[N:%.*]], 1
; CHECK-NEXT:    br i1 [[CMP18]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[DOTPRE:%.*]] = load i8, ptr [[X:%.*]], align 1
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i64 [[WIDE_TRIP_COUNT]], -1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP0]], 32
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 32
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = add i64 1, [[N_VEC]]
; CHECK-NEXT:    [[VECTOR_RECUR_INIT:%.*]] = insertelement <16 x i8> poison, i8 [[DOTPRE]], i32 15
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR:%.*]] = phi <16 x i8> [ [[VECTOR_RECUR_INIT]], [[VECTOR_PH]] ], [ [[WIDE_LOAD1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i64 1, [[INDEX]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[X]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 16
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP5]], align 1
; CHECK-NEXT:    [[WIDE_LOAD1]] = load <16 x i8>, ptr [[TMP6]], align 1
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <16 x i8> [[VECTOR_RECUR]], <16 x i8> [[WIDE_LOAD]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <16 x i8> [[WIDE_LOAD]], <16 x i8> [[WIDE_LOAD1]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP9:%.*]] = add <16 x i8> [[WIDE_LOAD]], [[TMP7]]
; CHECK-NEXT:    [[TMP10:%.*]] = add <16 x i8> [[WIDE_LOAD1]], [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i8, ptr [[Y:%.*]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i32 0
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i32 16
; CHECK-NEXT:    store <16 x i8> [[TMP9]], ptr [[TMP13]], align 1
; CHECK-NEXT:    store <16 x i8> [[TMP10]], ptr [[TMP14]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 32
; CHECK-NEXT:    [[TMP15:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP15]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <16 x i8> [[WIDE_LOAD1]], i32 15
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP0]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 1, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i8 [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ], [ [[DOTPRE]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[TMP16:%.*]] = phi i8 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[TMP17:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds i8, ptr [[X]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP17]] = load i8, ptr [[ARRAYIDX4]], align 1
; CHECK-NEXT:    [[ADD7:%.*]] = add i8 [[TMP17]], [[TMP16]]
; CHECK-NEXT:    [[ARRAYIDX10:%.*]] = getelementptr inbounds i8, ptr [[Y]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i8 [[ADD7]], ptr [[ARRAYIDX10]], align 1
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
;
entry:
  %cmp18 = icmp sgt i32 %n, 1
  br i1 %cmp18, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  %.pre = load i8, ptr %x, align 1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %0 = phi i8 [ %.pre, %for.body.preheader ], [ %1, %for.body ]
  %indvars.iv = phi i64 [ 1, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %arrayidx4 = getelementptr inbounds i8, ptr %x, i64 %indvars.iv
  %1 = load i8, ptr %arrayidx4, align 1
  %add7 = add i8 %1, %0
  %arrayidx10 = getelementptr inbounds i8, ptr %y, i64 %indvars.iv
  store i8 %add7, ptr %arrayidx10, align 1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @thirdorderrec(ptr nocapture noundef readonly %x, ptr noalias nocapture noundef writeonly %y, i32 noundef %n) #0 {
; CHECK-LABEL: @thirdorderrec(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP38:%.*]] = icmp sgt i32 [[N:%.*]], 3
; CHECK-NEXT:    br i1 [[CMP38]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[DOTPRE:%.*]] = load i8, ptr [[X:%.*]], align 1
; CHECK-NEXT:    [[ARRAYIDX5_PHI_TRANS_INSERT:%.*]] = getelementptr inbounds i8, ptr [[X]], i64 1
; CHECK-NEXT:    [[DOTPRE44:%.*]] = load i8, ptr [[ARRAYIDX5_PHI_TRANS_INSERT]], align 1
; CHECK-NEXT:    [[ARRAYIDX12_PHI_TRANS_INSERT:%.*]] = getelementptr inbounds i8, ptr [[X]], i64 2
; CHECK-NEXT:    [[DOTPRE45:%.*]] = load i8, ptr [[ARRAYIDX12_PHI_TRANS_INSERT]], align 1
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i64 [[WIDE_TRIP_COUNT]], -3
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP0]], 32
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 32
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = add i64 3, [[N_VEC]]
; CHECK-NEXT:    [[VECTOR_RECUR_INIT:%.*]] = insertelement <16 x i8> poison, i8 [[DOTPRE45]], i32 15
; CHECK-NEXT:    [[VECTOR_RECUR_INIT1:%.*]] = insertelement <16 x i8> poison, i8 [[DOTPRE44]], i32 15
; CHECK-NEXT:    [[VECTOR_RECUR_INIT3:%.*]] = insertelement <16 x i8> poison, i8 [[DOTPRE]], i32 15
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR:%.*]] = phi <16 x i8> [ [[VECTOR_RECUR_INIT]], [[VECTOR_PH]] ], [ [[WIDE_LOAD5:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR2:%.*]] = phi <16 x i8> [ [[VECTOR_RECUR_INIT1]], [[VECTOR_PH]] ], [ [[TMP8:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR4:%.*]] = phi <16 x i8> [ [[VECTOR_RECUR_INIT3]], [[VECTOR_PH]] ], [ [[TMP10:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i64 3, [[INDEX]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[X]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 16
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP5]], align 1
; CHECK-NEXT:    [[WIDE_LOAD5]] = load <16 x i8>, ptr [[TMP6]], align 1
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <16 x i8> [[VECTOR_RECUR]], <16 x i8> [[WIDE_LOAD]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP8]] = shufflevector <16 x i8> [[WIDE_LOAD]], <16 x i8> [[WIDE_LOAD5]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <16 x i8> [[VECTOR_RECUR2]], <16 x i8> [[TMP7]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP10]] = shufflevector <16 x i8> [[TMP7]], <16 x i8> [[TMP8]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP11:%.*]] = shufflevector <16 x i8> [[VECTOR_RECUR4]], <16 x i8> [[TMP9]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP12:%.*]] = shufflevector <16 x i8> [[TMP9]], <16 x i8> [[TMP10]], <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
; CHECK-NEXT:    [[TMP13:%.*]] = add <16 x i8> [[TMP9]], [[TMP11]]
; CHECK-NEXT:    [[TMP14:%.*]] = add <16 x i8> [[TMP10]], [[TMP12]]
; CHECK-NEXT:    [[TMP15:%.*]] = add <16 x i8> [[TMP13]], [[TMP7]]
; CHECK-NEXT:    [[TMP16:%.*]] = add <16 x i8> [[TMP14]], [[TMP8]]
; CHECK-NEXT:    [[TMP17:%.*]] = add <16 x i8> [[TMP15]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP18:%.*]] = add <16 x i8> [[TMP16]], [[WIDE_LOAD5]]
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i8, ptr [[Y:%.*]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i8, ptr [[TMP19]], i32 0
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds i8, ptr [[TMP19]], i32 16
; CHECK-NEXT:    store <16 x i8> [[TMP17]], ptr [[TMP21]], align 1
; CHECK-NEXT:    store <16 x i8> [[TMP18]], ptr [[TMP22]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 32
; CHECK-NEXT:    [[TMP23:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP23]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <16 x i8> [[WIDE_LOAD5]], i32 15
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT6:%.*]] = extractelement <16 x i8> [[TMP8]], i32 15
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT7:%.*]] = extractelement <16 x i8> [[TMP10]], i32 15
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP0]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 3, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i8 [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ], [ [[DOTPRE45]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT8:%.*]] = phi i8 [ [[VECTOR_RECUR_EXTRACT6]], [[MIDDLE_BLOCK]] ], [ [[DOTPRE44]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT9:%.*]] = phi i8 [ [[VECTOR_RECUR_EXTRACT7]], [[MIDDLE_BLOCK]] ], [ [[DOTPRE]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[TMP24:%.*]] = phi i8 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[TMP27:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP25:%.*]] = phi i8 [ [[SCALAR_RECUR_INIT8]], [[SCALAR_PH]] ], [ [[TMP24]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP26:%.*]] = phi i8 [ [[SCALAR_RECUR_INIT9]], [[SCALAR_PH]] ], [ [[TMP25]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD8:%.*]] = add i8 [[TMP25]], [[TMP26]]
; CHECK-NEXT:    [[ADD15:%.*]] = add i8 [[ADD8]], [[TMP24]]
; CHECK-NEXT:    [[ARRAYIDX18:%.*]] = getelementptr inbounds i8, ptr [[X]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP27]] = load i8, ptr [[ARRAYIDX18]], align 1
; CHECK-NEXT:    [[ADD21:%.*]] = add i8 [[ADD15]], [[TMP27]]
; CHECK-NEXT:    [[ARRAYIDX24:%.*]] = getelementptr inbounds i8, ptr [[Y]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i8 [[ADD21]], ptr [[ARRAYIDX24]], align 1
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
;
entry:
  %cmp38 = icmp sgt i32 %n, 3
  br i1 %cmp38, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  %.pre = load i8, ptr %x, align 1
  %arrayidx5.phi.trans.insert = getelementptr inbounds i8, ptr %x, i64 1
  %.pre44 = load i8, ptr %arrayidx5.phi.trans.insert, align 1
  %arrayidx12.phi.trans.insert = getelementptr inbounds i8, ptr %x, i64 2
  %.pre45 = load i8, ptr %arrayidx12.phi.trans.insert, align 1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %0 = phi i8 [ %.pre45, %for.body.preheader ], [ %3, %for.body ]
  %1 = phi i8 [ %.pre44, %for.body.preheader ], [ %0, %for.body ]
  %2 = phi i8 [ %.pre, %for.body.preheader ], [ %1, %for.body ]
  %indvars.iv = phi i64 [ 3, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %add8 = add i8 %1, %2
  %add15 = add i8 %add8, %0
  %arrayidx18 = getelementptr inbounds i8, ptr %x, i64 %indvars.iv
  %3 = load i8, ptr %arrayidx18, align 1
  %add21 = add i8 %add15, %3
  %arrayidx24 = getelementptr inbounds i8, ptr %y, i64 %indvars.iv
  store i8 %add21, ptr %arrayidx24, align 1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define i64 @test_pr62954_scalar_epilogue_required(ptr %A, ptr noalias %B, ptr %C)  {
; CHECK-LABEL: @test_pr62954_scalar_epilogue_required(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 872
; CHECK-NEXT:    [[REC_START:%.*]] = load i64, ptr [[GEP]], align 8
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[VECTOR_RECUR_INIT:%.*]] = insertelement <2 x i64> poison, i64 [[REC_START]], i32 1
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <2 x i64> [ <i64 1, i64 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VECTOR_RECUR:%.*]] = phi <2 x i64> [ [[VECTOR_RECUR_INIT]], [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[STEP_ADD:%.*]] = add <2 x i64> [[VEC_IND]], <i64 4, i64 4>
; CHECK-NEXT:    [[TMP1]] = sub nsw <2 x i64> zeroinitializer, [[STEP_ADD]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x i64> [[TMP1]], i32 1
; CHECK-NEXT:    store i64 [[TMP2]], ptr [[GEP]], align 8
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <2 x i64> [[STEP_ADD]], <i64 4, i64 4>
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[INDEX_NEXT]], 36
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[VECTOR_RECUR_EXTRACT:%.*]] = extractelement <2 x i64> [[TMP1]], i32 1
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 73, [[MIDDLE_BLOCK]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[SCALAR_RECUR_INIT:%.*]] = phi i64 [ [[VECTOR_RECUR_EXTRACT]], [[MIDDLE_BLOCK]] ], [ [[REC_START]], [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[FOR:%.*]] = phi i64 [ [[SCALAR_RECUR_INIT]], [[SCALAR_PH]] ], [ [[NEG_IV:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr double, ptr [[B:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[L_B:%.*]] = load double, ptr [[GEP_B]], align 8
; CHECK-NEXT:    [[NEG_IV]] = sub nsw i64 0, [[IV]]
; CHECK-NEXT:    store i64 [[NEG_IV]], ptr [[GEP]], align 8
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 2
; CHECK-NEXT:    [[EC:%.*]] = icmp ugt i64 [[IV]], 74
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT:%.*]], label [[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[DOTIN_LCSSA:%.*]] = phi i64 [ [[FOR]], [[LOOP]] ]
; CHECK-NEXT:    [[DOTLCSSA:%.*]] = phi double [ [[L_B]], [[LOOP]] ]
; CHECK-NEXT:    store double [[DOTLCSSA]], ptr [[C:%.*]], align 8
; CHECK-NEXT:    ret i64 [[DOTIN_LCSSA]]
;
entry:
  %gep = getelementptr i8, ptr %A, i64 872
  %rec.start = load i64, ptr  %gep, align 8
  br label %loop

loop:
  %iv = phi i64 [ 1, %entry ], [ %iv.next, %loop ]
  %for = phi i64 [ %rec.start, %entry ], [ %neg.iv, %loop ]
  %gep.B = getelementptr double, ptr  %B, i64 %iv
  %l.B = load double, ptr  %gep.B, align 8
  %neg.iv = sub nsw i64 0, %iv
  store i64 %neg.iv, ptr %gep, align 8
  %iv.next = add nuw nsw i64 %iv, 2
  %ec = icmp ugt i64 %iv, 74
  br i1 %ec, label %exit, label %loop

exit:
  %.in.lcssa = phi i64 [ %for, %loop ]
  %.lcssa = phi double [ %l.B, %loop ]
  store double %.lcssa, ptr %C
  ret i64 %.in.lcssa
}

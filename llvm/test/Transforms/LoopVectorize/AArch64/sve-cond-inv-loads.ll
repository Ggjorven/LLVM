; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize,dce,instcombine -mtriple aarch64-linux-gnu -mattr=+sve \
; RUN:   -prefer-predicate-over-epilogue=scalar-epilogue -S %s -o - | FileCheck %s

define void @cond_inv_load_i32i32i16(ptr noalias nocapture %a, ptr noalias nocapture readonly %cond, ptr noalias nocapture readonly %inv, i64 %n) #0 {
; CHECK-LABEL: @cond_inv_load_i32i32i16(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw nsw i64 [[TMP0]], 2
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[DOTNEG:%.*]] = mul nsw i64 [[TMP2]], -4
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], [[DOTNEG]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP4:%.*]] = shl nuw nsw i64 [[TMP3]], 2
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 4 x ptr> poison, ptr [[INV:%.*]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 4 x ptr> [[BROADCAST_SPLATINSERT]], <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, ptr [[COND:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x i32>, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ne <vscale x 4 x i32> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <vscale x 4 x i16> @llvm.masked.gather.nxv4i16.nxv4p0(<vscale x 4 x ptr> [[BROADCAST_SPLAT]], i32 2, <vscale x 4 x i1> [[TMP6]], <vscale x 4 x i16> poison)
; CHECK-NEXT:    [[TMP7:%.*]] = sext <vscale x 4 x i16> [[WIDE_MASKED_GATHER]] to <vscale x 4 x i32>
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr i32, ptr [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[TMP7]], ptr [[TMP8]], i32 4, <vscale x 4 x i1> [[TMP6]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP4]]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP9]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_07:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_INC:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[COND]], i64 [[I_07]]
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[TMP10]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[FOR_INC]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TMP11:%.*]] = load i16, ptr [[INV]], align 2
; CHECK-NEXT:    [[CONV:%.*]] = sext i16 [[TMP11]] to i32
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[I_07]]
; CHECK-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_07]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.inc
  %i.07 = phi i64 [ %inc, %for.inc ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %cond, i64 %i.07
  %0 = load i32, ptr %arrayidx, align 4
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %for.inc, label %if.then

if.then:                                          ; preds = %for.body
  %1 = load i16, ptr %inv, align 2
  %conv = sext i16 %1 to i32
  %arrayidx1 = getelementptr inbounds i32, ptr %a, i64 %i.07
  store i32 %conv, ptr %arrayidx1, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body, %if.then
  %inc = add nuw nsw i64 %i.07, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !0

exit:                        ; preds = %for.inc
  ret void
}

define void @cond_inv_load_f64f64f64(ptr noalias nocapture %a, ptr noalias nocapture readonly %cond, ptr noalias nocapture readonly %inv, i64 %n) #0 {
; CHECK-LABEL: @cond_inv_load_f64f64f64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw nsw i64 [[TMP0]], 2
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[DOTNEG:%.*]] = mul nsw i64 [[TMP2]], -4
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], [[DOTNEG]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP4:%.*]] = shl nuw nsw i64 [[TMP3]], 2
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 4 x ptr> poison, ptr [[INV:%.*]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 4 x ptr> [[BROADCAST_SPLATINSERT]], <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds double, ptr [[COND:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x double>, ptr [[TMP5]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = fcmp ogt <vscale x 4 x double> [[WIDE_LOAD]], shufflevector (<vscale x 4 x double> insertelement (<vscale x 4 x double> poison, double 4.000000e-01, i64 0), <vscale x 4 x double> poison, <vscale x 4 x i32> zeroinitializer)
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <vscale x 4 x double> @llvm.masked.gather.nxv4f64.nxv4p0(<vscale x 4 x ptr> [[BROADCAST_SPLAT]], i32 8, <vscale x 4 x i1> [[TMP6]], <vscale x 4 x double> poison)
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr double, ptr [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    call void @llvm.masked.store.nxv4f64.p0(<vscale x 4 x double> [[WIDE_MASKED_GATHER]], ptr [[TMP7]], i32 8, <vscale x 4 x i1> [[TMP6]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP4]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_08:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_INC:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[COND]], i64 [[I_08]]
; CHECK-NEXT:    [[TMP9:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CMP1:%.*]] = fcmp ogt double [[TMP9]], 4.000000e-01
; CHECK-NEXT:    br i1 [[CMP1]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TMP10:%.*]] = load double, ptr [[INV]], align 8
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, ptr [[A]], i64 [[I_08]]
; CHECK-NEXT:    store double [[TMP10]], ptr [[ARRAYIDX2]], align 8
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_08]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.inc
  %i.08 = phi i64 [ %inc, %for.inc ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds double, ptr %cond, i64 %i.08
  %0 = load double, ptr %arrayidx, align 8
  %cmp1 = fcmp ogt double %0, 4.000000e-01
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %1 = load double, ptr %inv, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %a, i64 %i.08
  store double %1, ptr %arrayidx2, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body, %if.then
  %inc = add nuw nsw i64 %i.08, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %exit, label %for.body, !llvm.loop !0

exit:                        ; preds = %for.inc
  ret void
}

define void @invariant_load_cond(ptr noalias nocapture %a, ptr nocapture readonly %b, ptr nocapture readonly %cond, i64 %n) #0 {
; CHECK-LABEL: @invariant_load_cond(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw nsw i64 [[TMP0]], 2
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[DOTNEG:%.*]] = mul nsw i64 [[TMP2]], -4
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], [[DOTNEG]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP4:%.*]] = shl nuw nsw i64 [[TMP3]], 2
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i8, ptr [[B:%.*]], i64 168
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <vscale x 4 x ptr> poison, ptr [[TMP5]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <vscale x 4 x ptr> [[BROADCAST_SPLATINSERT]], <vscale x 4 x ptr> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[COND:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 4 x i32>, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ne <vscale x 4 x i32> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr i32, ptr [[B]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr [[TMP8]], i32 4, <vscale x 4 x i1> [[TMP7]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> [[BROADCAST_SPLAT]], i32 4, <vscale x 4 x i1> [[TMP7]], <vscale x 4 x i32> poison)
; CHECK-NEXT:    [[TMP9:%.*]] = add nsw <vscale x 4 x i32> [[WIDE_MASKED_GATHER]], [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr i32, ptr [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> [[TMP9]], ptr [[TMP10]], i32 4, <vscale x 4 x i1> [[TMP7]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP4]]
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[COND]], i64 [[IV]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[TMP12]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[FOR_INC]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 168
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[IV]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr [[ARRAYIDX3]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP14]], [[TMP13]]
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[IV]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[ARRAYIDX4]], align 4
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i64 42
  %arrayidx2 = getelementptr inbounds i32, ptr %cond, i64 %iv
  %0 = load i32, ptr %arrayidx2, align 4
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %for.inc, label %if.then

if.then:
  %arrayidx3 = getelementptr inbounds i32, ptr %b, i64 %iv
  %1 = load i32, ptr %arrayidx3, align 4
  %2 = load i32, ptr %arrayidx1, align 4
  %add = add nsw i32 %2, %1
  %arrayidx4 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %add, ptr %arrayidx4, align 4
  br label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %n
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

attributes #0 = { vscale_range(1, 16) }
!0 = distinct !{!0, !1, !2, !3, !4, !5}
!1 = !{!"llvm.loop.mustprogress"}
!2 = !{!"llvm.loop.vectorize.width", i32 4}
!3 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}
!4 = !{!"llvm.loop.interleave.count", i32 1}
!5 = !{!"llvm.loop.vectorize.enable", i1 true}

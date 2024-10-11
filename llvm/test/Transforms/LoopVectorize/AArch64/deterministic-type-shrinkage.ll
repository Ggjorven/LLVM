; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S < %s -passes=loop-vectorize,instcombine 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64"

;; See https://llvm.org/bugs/show_bug.cgi?id=25490
;; Due to the data structures used, the LLVM IR was not determinisic.
;; This test comes from the PR.

define void @test_pr25490(i32 %n, ptr noalias nocapture %a, ptr noalias nocapture %b, ptr noalias nocapture readonly %c) {
; CHECK-LABEL: define void @test_pr25490
; CHECK-SAME: (i32 [[N:%.*]], ptr noalias nocapture [[A:%.*]], ptr noalias nocapture [[B:%.*]], ptr noalias nocapture readonly [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_28:%.*]] = icmp eq i32 [[N]], 0
; CHECK-NEXT:    br i1 [[CMP_28]], label [[FOR_COND_CLEANUP:%.*]], label [[ITER_CHECK:%.*]]
; CHECK:       iter.check:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    [[MIN_ITERS_CHECK1:%.*]] = icmp ult i32 [[N]], 16
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK1]], label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[TMP0]], 4294967280
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[C]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP1]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <16 x i8>, ptr [[TMP2]], align 1
; CHECK-NEXT:    [[TMP3:%.*]] = zext <16 x i8> [[WIDE_LOAD2]] to <16 x i16>
; CHECK-NEXT:    [[TMP4:%.*]] = zext <16 x i8> [[WIDE_LOAD]] to <16 x i16>
; CHECK-NEXT:    [[TMP5:%.*]] = mul nuw <16 x i16> [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = lshr <16 x i16> [[TMP5]], <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
; CHECK-NEXT:    [[TMP7:%.*]] = trunc nuw <16 x i16> [[TMP6]] to <16 x i8>
; CHECK-NEXT:    store <16 x i8> [[TMP7]], ptr [[TMP2]], align 1
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <16 x i8>, ptr [[TMP8]], align 1
; CHECK-NEXT:    [[TMP9:%.*]] = zext <16 x i8> [[WIDE_LOAD3]] to <16 x i16>
; CHECK-NEXT:    [[TMP10:%.*]] = mul nuw <16 x i16> [[TMP9]], [[TMP4]]
; CHECK-NEXT:    [[TMP11:%.*]] = lshr <16 x i16> [[TMP10]], <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
; CHECK-NEXT:    [[TMP12:%.*]] = trunc nuw <16 x i16> [[TMP11]] to <16 x i8>
; CHECK-NEXT:    store <16 x i8> [[TMP12]], ptr [[TMP8]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP13]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[TMP0]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    [[N_VEC_REMAINING:%.*]] = and i64 [[TMP0]], 8
; CHECK-NEXT:    [[MIN_EPILOG_ITERS_CHECK_NOT_NOT:%.*]] = icmp eq i64 [[N_VEC_REMAINING]], 0
; CHECK-NEXT:    br i1 [[MIN_EPILOG_ITERS_CHECK_NOT_NOT]], label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; CHECK-NEXT:    [[N_VEC5:%.*]] = and i64 [[TMP0]], 4294967288
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX6:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT10:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i8, ptr [[C]], i64 [[INDEX6]]
; CHECK-NEXT:    [[WIDE_LOAD7:%.*]] = load <8 x i8>, ptr [[TMP14]], align 1
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[INDEX6]]
; CHECK-NEXT:    [[WIDE_LOAD8:%.*]] = load <8 x i8>, ptr [[TMP15]], align 1
; CHECK-NEXT:    [[TMP16:%.*]] = zext <8 x i8> [[WIDE_LOAD8]] to <8 x i16>
; CHECK-NEXT:    [[TMP17:%.*]] = zext <8 x i8> [[WIDE_LOAD7]] to <8 x i16>
; CHECK-NEXT:    [[TMP18:%.*]] = mul nuw <8 x i16> [[TMP16]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = lshr <8 x i16> [[TMP18]], <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
; CHECK-NEXT:    [[TMP20:%.*]] = trunc nuw <8 x i16> [[TMP19]] to <8 x i8>
; CHECK-NEXT:    store <8 x i8> [[TMP20]], ptr [[TMP15]], align 1
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[INDEX6]]
; CHECK-NEXT:    [[WIDE_LOAD9:%.*]] = load <8 x i8>, ptr [[TMP21]], align 1
; CHECK-NEXT:    [[TMP22:%.*]] = zext <8 x i8> [[WIDE_LOAD9]] to <8 x i16>
; CHECK-NEXT:    [[TMP23:%.*]] = mul nuw <8 x i16> [[TMP22]], [[TMP17]]
; CHECK-NEXT:    [[TMP24:%.*]] = lshr <8 x i16> [[TMP23]], <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
; CHECK-NEXT:    [[TMP25:%.*]] = trunc nuw <8 x i16> [[TMP24]] to <8 x i8>
; CHECK-NEXT:    store <8 x i8> [[TMP25]], ptr [[TMP21]], align 1
; CHECK-NEXT:    [[INDEX_NEXT10]] = add nuw i64 [[INDEX6]], 8
; CHECK-NEXT:    [[TMP26:%.*]] = icmp eq i64 [[INDEX_NEXT10]], [[N_VEC5]]
; CHECK-NEXT:    br i1 [[TMP26]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    [[CMP_N11:%.*]] = icmp eq i64 [[N_VEC5]], [[TMP0]]
; CHECK-NEXT:    br i1 [[CMP_N11]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC5]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[ITER_CHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[C]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP27:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[TMP27]] to i32
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP28:%.*]] = load i8, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[CONV3:%.*]] = zext i8 [[TMP28]] to i32
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[CONV3]], [[CONV]]
; CHECK-NEXT:    [[SHR_26:%.*]] = lshr i32 [[MUL]], 8
; CHECK-NEXT:    [[CONV4:%.*]] = trunc nuw i32 [[SHR_26]] to i8
; CHECK-NEXT:    store i8 [[CONV4]], ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[ARRAYIDX8:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP29:%.*]] = load i8, ptr [[ARRAYIDX8]], align 1
; CHECK-NEXT:    [[CONV9:%.*]] = zext i8 [[TMP29]] to i32
; CHECK-NEXT:    [[MUL10:%.*]] = mul nuw nsw i32 [[CONV9]], [[CONV]]
; CHECK-NEXT:    [[SHR11_27:%.*]] = lshr i32 [[MUL10]], 8
; CHECK-NEXT:    [[CONV12:%.*]] = trunc nuw i32 [[SHR11_27]] to i8
; CHECK-NEXT:    store i8 [[CONV12]], ptr [[ARRAYIDX8]], align 1
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[N]], [[LFTR_WIDEIV]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
;
entry:
  %cmp.28 = icmp eq i32 %n, 0
  br i1 %cmp.28, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i8, ptr %c, i64 %indvars.iv
  %0 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %0 to i32
  %arrayidx2 = getelementptr inbounds i8, ptr %a, i64 %indvars.iv
  %1 = load i8, ptr %arrayidx2, align 1
  %conv3 = zext i8 %1 to i32
  %mul = mul nuw nsw i32 %conv3, %conv
  %shr.26 = lshr i32 %mul, 8
  %conv4 = trunc i32 %shr.26 to i8
  store i8 %conv4, ptr %arrayidx2, align 1
  %arrayidx8 = getelementptr inbounds i8, ptr %b, i64 %indvars.iv
  %2 = load i8, ptr %arrayidx8, align 1
  %conv9 = zext i8 %2 to i32
  %mul10 = mul nuw nsw i32 %conv9, %conv
  %shr11.27 = lshr i32 %mul10, 8
  %conv12 = trunc i32 %shr11.27 to i8
  store i8 %conv12, ptr %arrayidx8, align 1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}


define void @test_shrink_zext_in_preheader(ptr noalias %src, ptr noalias %dst, i32 %A, i16 %B) {
; CHECK-LABEL: define void @test_shrink_zext_in_preheader
; CHECK-SAME: (ptr noalias [[SRC:%.*]], ptr noalias [[DST:%.*]], i32 [[A:%.*]], i16 [[B:%.*]]) {
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[A]] to i16
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <16 x i16> poison, i16 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <16 x i16> poison, i16 [[B]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = mul <16 x i16> [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[TMP7:%.*]] = lshr <16 x i16> [[TMP5]], <i16 8, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>
; CHECK-NEXT:    [[TMP9:%.*]] = trunc <16 x i16> [[TMP7]] to <16 x i8>
; CHECK-NEXT:    [[TMP10:%.*]] = shufflevector <16 x i8> [[TMP9]], <16 x i8> poison, <16 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP11:%.*]] = sext i32 [[INDEX]] to i64
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i8, ptr [[TMP12]], i64 16
; CHECK-NEXT:    store <16 x i8> [[TMP10]], ptr [[TMP12]], align 1
; CHECK-NEXT:    store <16 x i8> [[TMP10]], ptr [[TMP13]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 32
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[INDEX_NEXT]], 992
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[TMP15:%.*]] = trunc i32 [[A]] to i16
; CHECK-NEXT:    [[TMP16:%.*]] = insertelement <8 x i16> poison, i16 [[TMP15]], i64 0
; CHECK-NEXT:    [[TMP17:%.*]] = insertelement <8 x i16> poison, i16 [[B]], i64 0
; CHECK-NEXT:    [[TMP18:%.*]] = mul <8 x i16> [[TMP16]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = lshr <8 x i16> [[TMP18]], <i16 8, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>
; CHECK-NEXT:    [[TMP20:%.*]] = trunc <8 x i16> [[TMP19]] to <8 x i8>
; CHECK-NEXT:    [[TMP21:%.*]] = shufflevector <8 x i8> [[TMP20]], <8 x i8> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX7:%.*]] = phi i32 [ 992, [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT8:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP22:%.*]] = sext i32 [[INDEX7]] to i64
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP22]]
; CHECK-NEXT:    store <8 x i8> [[TMP21]], ptr [[TMP23]], align 1
; CHECK-NEXT:    [[INDEX_NEXT8]] = add nuw i32 [[INDEX7]], 8
; CHECK-NEXT:    [[TMP24:%.*]] = icmp eq i32 [[INDEX_NEXT8]], 1000
; CHECK-NEXT:    br i1 [[TMP24]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 poison, label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %conv10 = zext i16 %B to i32
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds i16, ptr %src, i32 %iv
  %l = load i16, ptr %gep.src
  %conv4111 = zext i16 %l to i32
  %mul = mul i32 %A, %conv10
  %0 = lshr i32 %mul, 8
  %conv5 = trunc i32 %0 to i8
  %gep.dst = getelementptr inbounds i8, ptr %dst, i32 %iv
  store i8 %conv5, ptr %gep.dst, align 1
  %iv.next = add i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, 1000
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @test_shrink_select(ptr noalias %src, ptr noalias %dst, i32 %A, i1 %c) {
; CHECK-LABEL: define void @test_shrink_select
; CHECK-SAME: (ptr noalias [[SRC:%.*]], ptr noalias [[DST:%.*]], i32 [[A:%.*]], i1 [[C:%.*]]) {
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[A]] to i16
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <16 x i16> poison, i16 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = mul <16 x i16> [[TMP1]],  <i16 99, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison>
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <16 x i16> [[TMP3]], <16 x i16> poison, <16 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = lshr <16 x i16> [[TMP4]], <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
; CHECK-NEXT:    [[TMP7:%.*]] = select i1 [[C]], <16 x i16> [[TMP5]], <16 x i16> [[TMP4]]
; CHECK-NEXT:    [[TMP9:%.*]] = trunc <16 x i16> [[TMP7]] to <16 x i8>
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP11:%.*]] = sext i32 [[INDEX]] to i64
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i8, ptr [[TMP12]], i64 16
; CHECK-NEXT:    store <16 x i8> [[TMP9]], ptr [[TMP12]], align 1
; CHECK-NEXT:    store <16 x i8> [[TMP10]], ptr [[TMP13]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 32
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[INDEX_NEXT]], 992
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[TMP15:%.*]] = trunc i32 [[A]] to i16
; CHECK-NEXT:    [[TMP16:%.*]] = insertelement <8 x i16> poison, i16 [[TMP15]], i64 0
; CHECK-NEXT:    [[TMP17:%.*]] = mul <8 x i16> [[TMP16]], <i16 99, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison, i16 poison>
; CHECK-NEXT:    [[TMP18:%.*]] = shufflevector <8 x i16> [[TMP17]], <8 x i16> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP19:%.*]] = lshr <8 x i16> [[TMP18]], <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
; CHECK-NEXT:    [[TMP20:%.*]] = select i1 [[C]], <8 x i16> [[TMP19]], <8 x i16> [[TMP18]]
; CHECK-NEXT:    [[TMP21:%.*]] = trunc <8 x i16> [[TMP20]] to <8 x i8>
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX3:%.*]] = phi i32 [ 992, [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT4:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP22:%.*]] = sext i32 [[INDEX3]] to i64
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP22]]
; CHECK-NEXT:    store <8 x i8> [[TMP21]], ptr [[TMP23]], align 1
; CHECK-NEXT:    [[INDEX_NEXT4]] = add nuw i32 [[INDEX3]], 8
; CHECK-NEXT:    [[TMP24:%.*]] = icmp eq i32 [[INDEX_NEXT4]], 1000
; CHECK-NEXT:    br i1 [[TMP24]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 poison, label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP10:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds i16, ptr %src, i32 %iv
  %l = load i16, ptr %gep.src
  %conv4111 = zext i16 %l to i32
  %mul = mul i32 %A, 99
  %shr = lshr i32 %mul, 8
  %sel = select i1 %c, i32 %shr, i32 %mul
  %conv5 = trunc i32 %sel to i8
  %gep.dst = getelementptr inbounds i8, ptr %dst, i32 %iv
  store i8 %conv5, ptr %gep.dst, align 1
  %iv.next = add i32 %iv, 1
  %exitcond.not = icmp eq i32 %iv.next, 1000
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @trunc_invariant_sdiv_result(i32 %a, i32 %b, ptr noalias %src, ptr %dst) {
; CHECK-LABEL: define void @trunc_invariant_sdiv_result
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]], ptr noalias [[SRC:%.*]], ptr [[DST:%.*]]) {
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    [[INVAR_DIV:%.*]] = sdiv i32 [[A]], [[B]]
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[INVAR_DIV]] to i16
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <16 x i16> poison, i16 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <16 x i16> [[TMP1]], <16 x i16> poison, <16 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i64 16
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <16 x i8>, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = zext <16 x i8> [[WIDE_LOAD]] to <16 x i16>
; CHECK-NEXT:    [[TMP6:%.*]] = zext <16 x i8> [[WIDE_LOAD1]] to <16 x i16>
; CHECK-NEXT:    [[TMP7:%.*]] = mul <16 x i16> [[TMP2]], [[TMP5]]
; CHECK-NEXT:    [[TMP8:%.*]] = mul <16 x i16> [[TMP2]], [[TMP6]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i16, ptr [[DST]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, ptr [[TMP9]], i64 32
; CHECK-NEXT:    store <16 x i16> [[TMP7]], ptr [[TMP9]], align 2
; CHECK-NEXT:    store <16 x i16> [[TMP8]], ptr [[TMP10]], align 2
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 32
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], 96
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP11:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[TMP12:%.*]] = trunc i32 [[INVAR_DIV]] to i16
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x i16> poison, i16 [[TMP12]], i64 0
; CHECK-NEXT:    [[TMP14:%.*]] = shufflevector <4 x i16> [[TMP13]], <4 x i16> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX4:%.*]] = phi i64 [ 96, [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT6:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[INDEX4]]
; CHECK-NEXT:    [[WIDE_LOAD5:%.*]] = load <4 x i8>, ptr [[TMP15]], align 1
; CHECK-NEXT:    [[TMP16:%.*]] = zext <4 x i8> [[WIDE_LOAD5]] to <4 x i16>
; CHECK-NEXT:    [[TMP17:%.*]] = mul <4 x i16> [[TMP14]], [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i16, ptr [[DST]], i64 [[INDEX4]]
; CHECK-NEXT:    store <4 x i16> [[TMP17]], ptr [[TMP18]], align 2
; CHECK-NEXT:    [[INDEX_NEXT6]] = add nuw i64 [[INDEX4]], 4
; CHECK-NEXT:    [[TMP19:%.*]] = icmp eq i64 [[INDEX_NEXT6]], 100
; CHECK-NEXT:    br i1 [[TMP19]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP12:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 poison, label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP13:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %invar.div = sdiv i32 %a, %b
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds i8, ptr %src, i64 %iv
  %l = load i8, ptr %gep.src
  %ext = zext i8 %l to i32
  %mul = mul i32 %invar.div, %ext
  %trunc= trunc i32 %mul to i16
  %gep.dst = getelementptr inbounds i16, ptr %dst, i64 %iv
  store i16 %trunc, ptr %gep.dst, align 2
  %iv.next = add i64 %iv, 1
  %exitcond.not.i = icmp eq i64 %iv.next, 100
  br i1 %exitcond.not.i, label %exit, label %loop

exit:
  ret void
}

; Test case for #74231.
define void @replicate_operands_in_with_operands_in_minbws(ptr %dst, ptr noalias %src.1, ptr noalias %src.2, i32 %x) {
; CHECK-LABEL: define void @replicate_operands_in_with_operands_in_minbws
; CHECK-SAME: (ptr [[DST:%.*]], ptr noalias [[SRC_1:%.*]], ptr noalias [[SRC_2:%.*]], i32 [[X:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[X]], 65526
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[GEP_SRC_1:%.*]] = getelementptr inbounds i32, ptr [[SRC_1]], i64 [[IV]]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[GEP_SRC_1]], align 4
; CHECK-NEXT:    [[C_1:%.*]] = icmp eq i32 [[L]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_LATCH]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[GEP_SRC_2:%.*]] = getelementptr inbounds i16, ptr [[SRC_2]], i64 [[IV]]
; CHECK-NEXT:    [[L_2:%.*]] = load i16, ptr [[GEP_SRC_2]], align 2
; CHECK-NEXT:    [[C_2:%.*]] = icmp ult i16 [[L_2]], 100
; CHECK-NEXT:    [[CONV:%.*]] = zext i16 [[L_2]] to i32
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[C_2]], i32 [[SUB]], i32 [[CONV]]
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[SEL]] to i16
; CHECK-NEXT:    [[TRUNC:%.*]] = add i16 [[L_2]], [[TMP0]]
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    store i16 [[TRUNC]], ptr [[GEP_DST]], align 2
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], 1000
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[EXIT:%.*]], label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %sub = sub i32 %x, 10
  br label %loop.header

loop.header:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep.src.1 = getelementptr inbounds i32, ptr %src.1, i64 %iv
  %l = load i32, ptr %gep.src.1
  %c.1 = icmp eq i32 %l, 10
  br i1 %c.1, label %loop.latch, label %if.then

if.then:
  %gep.src.2 = getelementptr inbounds i16, ptr %src.2, i64 %iv
  %l.2 = load i16, ptr %gep.src.2
  %c.2 = icmp ule i16 %l.2, 99
  %conv = zext i16 %l.2 to i32
  %sel = select i1 %c.2, i32 %sub, i32 %conv
  %add = add i32 %conv, %sel
  %trunc = trunc i32 %add to i16
  %gep.dst = getelementptr inbounds i32, ptr %dst, i64 %iv
  store i16 %trunc, ptr %gep.dst, align 2
  br label %loop.latch

loop.latch:
  %iv.next = add i64 %iv, 1
  %tobool.not = icmp eq i64 %iv.next, 1000
  br i1 %tobool.not, label %exit, label %loop.header

exit:
  ret void
}

; Test case for #74307.
define void @old_and_new_size_equalko(ptr noalias %src, ptr noalias %dst) {
; CHECK-LABEL: define void @old_and_new_size_equalko
; CHECK-SAME: (ptr noalias [[SRC:%.*]], ptr noalias [[DST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[INDEX]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[DST]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 16
; CHECK-NEXT:    store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, ptr [[TMP1]], align 4
; CHECK-NEXT:    store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, ptr [[TMP2]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 8
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[INDEX_NEXT]], 1000
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP14:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 poison, label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP15:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds i64, ptr %src, i32 %iv
  %l = load i64, ptr %gep.src
  %cmp = icmp sle i64 %l, 1
  %ext = zext i1 %cmp to i64
  %cmp3 = icmp sle i64 %ext, -10
  %or = or i64 1, %ext
  %trunc = trunc i64 %or to i32
  %gep.dst = getelementptr inbounds i32, ptr %dst, i32 %iv
  store i32 %trunc, ptr %gep.dst, align 4
  %iv.next = add i32 %iv, 1
  %ec = icmp eq i32 %iv.next, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

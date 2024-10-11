; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -mcpu=skylake-avx512 -S %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

; Make sure selected VF for the epilog loop doesn't exceed remaining TC.
define void @test_tc_17_no_epilogue_vectorization(ptr noalias %src, ptr noalias %dst) {
; CHECK-LABEL: @test_tc_17_no_epilogue_vectorization(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP2]], align 64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 0
; CHECK-NEXT:    store <16 x i8> [[WIDE_LOAD]], ptr [[TMP4]], align 64
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 16, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[I_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[LDADDR:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[I]]
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[LDADDR]], align 64
; CHECK-NEXT:    [[STADDR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[I]]
; CHECK-NEXT:    store i8 [[VAL]], ptr [[STADDR]], align 64
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[IS_NEXT:%.*]] = icmp ult i64 [[I_NEXT]], 17
; CHECK-NEXT:    br i1 [[IS_NEXT]], label [[LOOP]], label [[EXIT]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %ldaddr = getelementptr inbounds i8, ptr %src, i64 %i
  %val = load i8, ptr %ldaddr, align 64
  %staddr = getelementptr inbounds i8, ptr %dst, i64 %i
  store i8 %val, ptr %staddr, align 64
  %i.next = add i64 %i, 1
  %is.next = icmp ult i64 %i.next, 17
  br i1 %is.next, label %loop, label %exit

exit:
  ret void
}

define void @test_tc_18(ptr noalias %src, ptr noalias %dst) {
; CHECK-LABEL: @test_tc_18(
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP2]], align 64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 0
; CHECK-NEXT:    store <16 x i8> [[WIDE_LOAD]], ptr [[TMP4]], align 64
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ 16, [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX1:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT3:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[INDEX1]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr [[TMP7]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <2 x i8>, ptr [[TMP8]], align 64
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, ptr [[TMP9]], i32 0
; CHECK-NEXT:    store <2 x i8> [[WIDE_LOAD2]], ptr [[TMP10]], align 64
; CHECK-NEXT:    [[INDEX_NEXT3]] = add nuw i64 [[INDEX1]], 2
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT3]], 18
; CHECK-NEXT:    br i1 [[TMP11]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 18, [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ 16, [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[ITER_CHECK:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[I_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[LDADDR:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[I]]
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[LDADDR]], align 64
; CHECK-NEXT:    [[STADDR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[I]]
; CHECK-NEXT:    store i8 [[VAL]], ptr [[STADDR]], align 64
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[IS_NEXT:%.*]] = icmp ult i64 [[I_NEXT]], 18
; CHECK-NEXT:    br i1 [[IS_NEXT]], label [[LOOP]], label [[EXIT]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %ldaddr = getelementptr inbounds i8, ptr %src, i64 %i
  %val = load i8, ptr %ldaddr, align 64
  %staddr = getelementptr inbounds i8, ptr %dst, i64 %i
  store i8 %val, ptr %staddr, align 64
  %i.next = add i64 %i, 1
  %is.next = icmp ult i64 %i.next, 18
  br i1 %is.next, label %loop, label %exit

exit:
  ret void
}

define void @test_tc_19(ptr noalias %src, ptr noalias %dst) {
; CHECK-LABEL: @test_tc_19(
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH:%.*]], label [[VECTOR_MAIN_LOOP_ITER_CHECK:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <16 x i8>, ptr [[TMP2]], align 64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 0
; CHECK-NEXT:    store <16 x i8> [[WIDE_LOAD]], ptr [[TMP4]], align 64
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    br i1 false, label [[VEC_EPILOG_SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ 16, [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_MAIN_LOOP_ITER_CHECK]] ]
; CHECK-NEXT:    br label [[VEC_EPILOG_VECTOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX1:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT3:%.*]], [[VEC_EPILOG_VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[INDEX1]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr [[TMP7]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <2 x i8>, ptr [[TMP8]], align 64
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, ptr [[TMP9]], i32 0
; CHECK-NEXT:    store <2 x i8> [[WIDE_LOAD2]], ptr [[TMP10]], align 64
; CHECK-NEXT:    [[INDEX_NEXT3]] = add nuw i64 [[INDEX1]], 2
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT3]], 18
; CHECK-NEXT:    br i1 [[TMP11]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[VEC_EPILOG_VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT]], label [[VEC_EPILOG_SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 18, [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ 16, [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[ITER_CHECK:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[VEC_EPILOG_SCALAR_PH]] ], [ [[I_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[LDADDR:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[I]]
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[LDADDR]], align 64
; CHECK-NEXT:    [[STADDR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[I]]
; CHECK-NEXT:    store i8 [[VAL]], ptr [[STADDR]], align 64
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[IS_NEXT:%.*]] = icmp ult i64 [[I_NEXT]], 19
; CHECK-NEXT:    br i1 [[IS_NEXT]], label [[LOOP]], label [[EXIT]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %ldaddr = getelementptr inbounds i8, ptr %src, i64 %i
  %val = load i8, ptr %ldaddr, align 64
  %staddr = getelementptr inbounds i8, ptr %dst, i64 %i
  store i8 %val, ptr %staddr, align 64
  %i.next = add i64 %i, 1
  %is.next = icmp ult i64 %i.next, 19
  br i1 %is.next, label %loop, label %exit

exit:
  ret void
}

define void @test_tc_20(ptr noalias %src, ptr noalias %dst) {
; CHECK-LABEL: @test_tc_20(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr [[TMP4]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[TMP4]], i32 4
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, ptr [[TMP4]], i32 8
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i8, ptr [[TMP4]], i32 12
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i8>, ptr [[TMP8]], align 64
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <4 x i8>, ptr [[TMP9]], align 64
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x i8>, ptr [[TMP10]], align 64
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <4 x i8>, ptr [[TMP11]], align 64
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i8, ptr [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i8, ptr [[TMP12]], i32 0
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i8, ptr [[TMP12]], i32 4
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i8, ptr [[TMP12]], i32 8
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i8, ptr [[TMP12]], i32 12
; CHECK-NEXT:    store <4 x i8> [[WIDE_LOAD]], ptr [[TMP16]], align 64
; CHECK-NEXT:    store <4 x i8> [[WIDE_LOAD1]], ptr [[TMP17]], align 64
; CHECK-NEXT:    store <4 x i8> [[WIDE_LOAD2]], ptr [[TMP18]], align 64
; CHECK-NEXT:    store <4 x i8> [[WIDE_LOAD3]], ptr [[TMP19]], align 64
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP20:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP20]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP10:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 16, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[I_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[LDADDR:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[I]]
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[LDADDR]], align 64
; CHECK-NEXT:    [[STADDR:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[I]]
; CHECK-NEXT:    store i8 [[VAL]], ptr [[STADDR]], align 64
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[IS_NEXT:%.*]] = icmp ult i64 [[I_NEXT]], 20
; CHECK-NEXT:    br i1 [[IS_NEXT]], label [[LOOP]], label [[EXIT]], !llvm.loop [[LOOP11:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i64 [ 0, %entry ], [ %i.next, %loop ]
  %ldaddr = getelementptr inbounds i8, ptr %src, i64 %i
  %val = load i8, ptr %ldaddr, align 64
  %staddr = getelementptr inbounds i8, ptr %dst, i64 %i
  store i8 %val, ptr %staddr, align 64
  %i.next = add i64 %i, 1
  %is.next = icmp ult i64 %i.next, 20
  br i1 %is.next, label %loop, label %exit

exit:
  ret void
}

define void @limit_main_loop_vf_to_avoid_dead_main_vector_loop(ptr noalias %src, ptr noalias %dst) {
; CHECK-LABEL: @limit_main_loop_vf_to_avoid_dead_main_vector_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [3 x i8], ptr [[SRC:%.*]], i64 [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i32 0
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <24 x i8>, ptr [[TMP2]], align 1
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <24 x i8> [[WIDE_VEC]], <24 x i8> poison, <8 x i32> <i32 0, i32 3, i32 6, i32 9, i32 12, i32 15, i32 18, i32 21>
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i32 0
; CHECK-NEXT:    store <8 x i8> [[STRIDED_VEC]], ptr [[TMP4]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 24
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP12:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 24, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP_SRC:%.*]] = getelementptr inbounds [3 x i8], ptr [[SRC]], i64 [[IV]], i64 0
; CHECK-NEXT:    [[L:%.*]] = load i8, ptr [[GEP_SRC]], align 1
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    store i8 [[L]], ptr [[GEP_DST]], align 1
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[IV_NEXT]], 32
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[LOOP]], !llvm.loop [[LOOP13:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src = getelementptr inbounds [3 x i8], ptr %src, i64 %iv, i64 0
  %l = load i8, ptr %gep.src, align 1
  %gep.dst = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %l, ptr %gep.dst, align 1
  %iv.next = add nuw nsw i64 %iv, 1
  %cmp = icmp eq i64 %iv.next, 32
  br i1 %cmp, label %exit, label %loop

exit:
  ret void
}

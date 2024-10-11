; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-pc_linux -passes=loop-vectorize,instcombine < %s | FileCheck %s --check-prefix=SSE
; RUN: opt -S -mtriple=x86_64-pc_linux -passes=loop-vectorize,instcombine -mcpu=sandybridge < %s | FileCheck %s --check-prefix=AVX1
; RUN: opt -S -mtriple=x86_64-pc_linux -passes=loop-vectorize,instcombine -mcpu=haswell < %s | FileCheck %s --check-prefix=AVX2
; RUN: opt -S -mtriple=x86_64-pc_linux -passes=loop-vectorize,instcombine -mcpu=slm < %s | FileCheck %s --check-prefix=SSE
; RUN: opt -S -mtriple=x86_64-pc_linux -passes=loop-vectorize,instcombine -mcpu=atom < %s | FileCheck %s --check-prefix=ATOM

define void @foo(ptr noalias nocapture %a, ptr noalias nocapture readonly %b) {
; SSE-LABEL: @foo(
; SSE-NEXT:  entry:
; SSE-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; SSE:       vector.ph:
; SSE-NEXT:    br label [[VECTOR_BODY:%.*]]
; SSE:       vector.body:
; SSE-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; SSE-NEXT:    [[TMP0:%.*]] = shl i64 [[INDEX]], 1
; SSE-NEXT:    [[TMP1:%.*]] = or disjoint i64 [[TMP0]], 8
; SSE-NEXT:    [[DOTIDX:%.*]] = shl nsw i64 [[INDEX]], 3
; SSE-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[B:%.*]], i64 [[DOTIDX]]
; SSE-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP1]]
; SSE-NEXT:    [[WIDE_VEC:%.*]] = load <8 x i32>, ptr [[TMP2]], align 4
; SSE-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <8 x i32> [[WIDE_VEC]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; SSE-NEXT:    [[STRIDED_VEC3:%.*]] = shufflevector <8 x i32> [[WIDE_VEC]], <8 x i32> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; SSE-NEXT:    [[WIDE_VEC1:%.*]] = load <8 x i32>, ptr [[TMP3]], align 4
; SSE-NEXT:    [[STRIDED_VEC2:%.*]] = shufflevector <8 x i32> [[WIDE_VEC1]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; SSE-NEXT:    [[STRIDED_VEC4:%.*]] = shufflevector <8 x i32> [[WIDE_VEC1]], <8 x i32> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; SSE-NEXT:    [[TMP4:%.*]] = add nsw <4 x i32> [[STRIDED_VEC3]], [[STRIDED_VEC]]
; SSE-NEXT:    [[TMP5:%.*]] = add nsw <4 x i32> [[STRIDED_VEC4]], [[STRIDED_VEC2]]
; SSE-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDEX]]
; SSE-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i8, ptr [[TMP6]], i64 16
; SSE-NEXT:    store <4 x i32> [[TMP4]], ptr [[TMP6]], align 4
; SSE-NEXT:    store <4 x i32> [[TMP5]], ptr [[TMP7]], align 4
; SSE-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; SSE-NEXT:    [[TMP8:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; SSE-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; SSE:       middle.block:
; SSE-NEXT:    br i1 true, label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; SSE:       scalar.ph:
; SSE-NEXT:    br label [[FOR_BODY:%.*]]
; SSE:       for.cond.cleanup:
; SSE-NEXT:    ret void
; SSE:       for.body:
; SSE-NEXT:    br i1 poison, label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
;
; AVX1-LABEL: @foo(
; AVX1-NEXT:  entry:
; AVX1-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; AVX1:       vector.ph:
; AVX1-NEXT:    br label [[VECTOR_BODY:%.*]]
; AVX1:       vector.body:
; AVX1-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; AVX1-NEXT:    [[TMP0:%.*]] = shl i64 [[INDEX]], 1
; AVX1-NEXT:    [[TMP1:%.*]] = or disjoint i64 [[TMP0]], 8
; AVX1-NEXT:    [[TMP2:%.*]] = shl i64 [[INDEX]], 1
; AVX1-NEXT:    [[TMP3:%.*]] = or disjoint i64 [[TMP2]], 16
; AVX1-NEXT:    [[TMP4:%.*]] = shl i64 [[INDEX]], 1
; AVX1-NEXT:    [[TMP5:%.*]] = or disjoint i64 [[TMP4]], 24
; AVX1-NEXT:    [[DOTIDX:%.*]] = shl nsw i64 [[INDEX]], 3
; AVX1-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, ptr [[B:%.*]], i64 [[DOTIDX]]
; AVX1-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP1]]
; AVX1-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP3]]
; AVX1-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP5]]
; AVX1-NEXT:    [[WIDE_VEC:%.*]] = load <8 x i32>, ptr [[TMP6]], align 4
; AVX1-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <8 x i32> [[WIDE_VEC]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; AVX1-NEXT:    [[STRIDED_VEC7:%.*]] = shufflevector <8 x i32> [[WIDE_VEC]], <8 x i32> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; AVX1-NEXT:    [[WIDE_VEC1:%.*]] = load <8 x i32>, ptr [[TMP7]], align 4
; AVX1-NEXT:    [[STRIDED_VEC4:%.*]] = shufflevector <8 x i32> [[WIDE_VEC1]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; AVX1-NEXT:    [[STRIDED_VEC8:%.*]] = shufflevector <8 x i32> [[WIDE_VEC1]], <8 x i32> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; AVX1-NEXT:    [[WIDE_VEC2:%.*]] = load <8 x i32>, ptr [[TMP8]], align 4
; AVX1-NEXT:    [[STRIDED_VEC5:%.*]] = shufflevector <8 x i32> [[WIDE_VEC2]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; AVX1-NEXT:    [[STRIDED_VEC9:%.*]] = shufflevector <8 x i32> [[WIDE_VEC2]], <8 x i32> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; AVX1-NEXT:    [[WIDE_VEC3:%.*]] = load <8 x i32>, ptr [[TMP9]], align 4
; AVX1-NEXT:    [[STRIDED_VEC6:%.*]] = shufflevector <8 x i32> [[WIDE_VEC3]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; AVX1-NEXT:    [[STRIDED_VEC10:%.*]] = shufflevector <8 x i32> [[WIDE_VEC3]], <8 x i32> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; AVX1-NEXT:    [[TMP10:%.*]] = add nsw <4 x i32> [[STRIDED_VEC7]], [[STRIDED_VEC]]
; AVX1-NEXT:    [[TMP11:%.*]] = add nsw <4 x i32> [[STRIDED_VEC8]], [[STRIDED_VEC4]]
; AVX1-NEXT:    [[TMP12:%.*]] = add nsw <4 x i32> [[STRIDED_VEC9]], [[STRIDED_VEC5]]
; AVX1-NEXT:    [[TMP13:%.*]] = add nsw <4 x i32> [[STRIDED_VEC10]], [[STRIDED_VEC6]]
; AVX1-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDEX]]
; AVX1-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr [[TMP14]], i64 16
; AVX1-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i8, ptr [[TMP14]], i64 32
; AVX1-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i8, ptr [[TMP14]], i64 48
; AVX1-NEXT:    store <4 x i32> [[TMP10]], ptr [[TMP14]], align 4
; AVX1-NEXT:    store <4 x i32> [[TMP11]], ptr [[TMP15]], align 4
; AVX1-NEXT:    store <4 x i32> [[TMP12]], ptr [[TMP16]], align 4
; AVX1-NEXT:    store <4 x i32> [[TMP13]], ptr [[TMP17]], align 4
; AVX1-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; AVX1-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; AVX1-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; AVX1:       middle.block:
; AVX1-NEXT:    br i1 true, label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; AVX1:       scalar.ph:
; AVX1-NEXT:    br label [[FOR_BODY:%.*]]
; AVX1:       for.cond.cleanup:
; AVX1-NEXT:    ret void
; AVX1:       for.body:
; AVX1-NEXT:    br i1 poison, label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
;
; AVX2-LABEL: @foo(
; AVX2-NEXT:  entry:
; AVX2-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; AVX2:       vector.ph:
; AVX2-NEXT:    br label [[VECTOR_BODY:%.*]]
; AVX2:       vector.body:
; AVX2-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; AVX2-NEXT:    [[TMP0:%.*]] = shl i64 [[INDEX]], 1
; AVX2-NEXT:    [[TMP1:%.*]] = or disjoint i64 [[TMP0]], 16
; AVX2-NEXT:    [[TMP2:%.*]] = shl i64 [[INDEX]], 1
; AVX2-NEXT:    [[TMP3:%.*]] = or disjoint i64 [[TMP2]], 32
; AVX2-NEXT:    [[TMP4:%.*]] = shl i64 [[INDEX]], 1
; AVX2-NEXT:    [[TMP5:%.*]] = or disjoint i64 [[TMP4]], 48
; AVX2-NEXT:    [[DOTIDX:%.*]] = shl nsw i64 [[INDEX]], 3
; AVX2-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, ptr [[B:%.*]], i64 [[DOTIDX]]
; AVX2-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP1]]
; AVX2-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP3]]
; AVX2-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP5]]
; AVX2-NEXT:    [[WIDE_VEC:%.*]] = load <16 x i32>, ptr [[TMP6]], align 4
; AVX2-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <16 x i32> [[WIDE_VEC]], <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
; AVX2-NEXT:    [[STRIDED_VEC7:%.*]] = shufflevector <16 x i32> [[WIDE_VEC]], <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
; AVX2-NEXT:    [[WIDE_VEC1:%.*]] = load <16 x i32>, ptr [[TMP7]], align 4
; AVX2-NEXT:    [[STRIDED_VEC4:%.*]] = shufflevector <16 x i32> [[WIDE_VEC1]], <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
; AVX2-NEXT:    [[STRIDED_VEC8:%.*]] = shufflevector <16 x i32> [[WIDE_VEC1]], <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
; AVX2-NEXT:    [[WIDE_VEC2:%.*]] = load <16 x i32>, ptr [[TMP8]], align 4
; AVX2-NEXT:    [[STRIDED_VEC5:%.*]] = shufflevector <16 x i32> [[WIDE_VEC2]], <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
; AVX2-NEXT:    [[STRIDED_VEC9:%.*]] = shufflevector <16 x i32> [[WIDE_VEC2]], <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
; AVX2-NEXT:    [[WIDE_VEC3:%.*]] = load <16 x i32>, ptr [[TMP9]], align 4
; AVX2-NEXT:    [[STRIDED_VEC6:%.*]] = shufflevector <16 x i32> [[WIDE_VEC3]], <16 x i32> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
; AVX2-NEXT:    [[STRIDED_VEC10:%.*]] = shufflevector <16 x i32> [[WIDE_VEC3]], <16 x i32> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
; AVX2-NEXT:    [[TMP10:%.*]] = add nsw <8 x i32> [[STRIDED_VEC7]], [[STRIDED_VEC]]
; AVX2-NEXT:    [[TMP11:%.*]] = add nsw <8 x i32> [[STRIDED_VEC8]], [[STRIDED_VEC4]]
; AVX2-NEXT:    [[TMP12:%.*]] = add nsw <8 x i32> [[STRIDED_VEC9]], [[STRIDED_VEC5]]
; AVX2-NEXT:    [[TMP13:%.*]] = add nsw <8 x i32> [[STRIDED_VEC10]], [[STRIDED_VEC6]]
; AVX2-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDEX]]
; AVX2-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr [[TMP14]], i64 32
; AVX2-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i8, ptr [[TMP14]], i64 64
; AVX2-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i8, ptr [[TMP14]], i64 96
; AVX2-NEXT:    store <8 x i32> [[TMP10]], ptr [[TMP14]], align 4
; AVX2-NEXT:    store <8 x i32> [[TMP11]], ptr [[TMP15]], align 4
; AVX2-NEXT:    store <8 x i32> [[TMP12]], ptr [[TMP16]], align 4
; AVX2-NEXT:    store <8 x i32> [[TMP13]], ptr [[TMP17]], align 4
; AVX2-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 32
; AVX2-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; AVX2-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; AVX2:       middle.block:
; AVX2-NEXT:    br i1 true, label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; AVX2:       scalar.ph:
; AVX2-NEXT:    br label [[FOR_BODY:%.*]]
; AVX2:       for.cond.cleanup:
; AVX2-NEXT:    ret void
; AVX2:       for.body:
; AVX2-NEXT:    br i1 poison, label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
;
; ATOM-LABEL: @foo(
; ATOM-NEXT:  entry:
; ATOM-NEXT:    br label [[FOR_BODY:%.*]]
; ATOM:       for.cond.cleanup:
; ATOM-NEXT:    ret void
; ATOM:       for.body:
; ATOM-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; ATOM-NEXT:    [[TMP0:%.*]] = shl nuw nsw i64 [[INDVARS_IV]], 1
; ATOM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i64 [[TMP0]]
; ATOM-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; ATOM-NEXT:    [[TMP2:%.*]] = or disjoint i64 [[TMP0]], 1
; ATOM-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[TMP2]]
; ATOM-NEXT:    [[TMP3:%.*]] = load i32, ptr [[ARRAYIDX3]], align 4
; ATOM-NEXT:    [[ADD4:%.*]] = add nsw i32 [[TMP3]], [[TMP1]]
; ATOM-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; ATOM-NEXT:    store i32 [[ADD4]], ptr [[ARRAYIDX6]], align 4
; ATOM-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; ATOM-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; ATOM-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nsw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %0
  %1 = load i32, ptr %arrayidx, align 4
  %2 = or disjoint i64 %0, 1
  %arrayidx3 = getelementptr inbounds i32, ptr %b, i64 %2
  %3 = load i32, ptr %arrayidx3, align 4
  %add4 = add nsw i32 %3, %1
  %arrayidx6 = getelementptr inbounds i32, ptr %a, i64 %indvars.iv
  store i32 %add4, ptr %arrayidx6, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s --prefer-predicate-over-epilogue=predicate-dont-vectorize --passes=loop-vectorize -mcpu=sifive-p470 -mattr=+v,+f -force-tail-folding-style=data-with-evl -S | FileCheck %s
; Generated from issue #109468.
; In this test case, the vector store with tail mask will transfer to the vp intrinsic with EVL.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @lshift_significand(i32 %n, ptr nocapture writeonly %dst) {
; CHECK-LABEL: define void @lshift_significand(
; CHECK-SAME: i32 [[N:%.*]], ptr nocapture writeonly [[DST:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[CMP1_PEEL:%.*]] = icmp eq i32 [[N]], 0
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[CMP1_PEEL]], i64 2, i64 0
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 3, [[SPEC_SELECT]]
; CHECK-NEXT:    [[TMP1:%.*]] = sub i64 -1, [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ult i64 [[TMP1]], [[TMP3]]
; CHECK-NEXT:    br i1 [[TMP4]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[TMP5:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP6:%.*]] = mul i64 [[TMP5]], 2
; CHECK-NEXT:    [[TMP7:%.*]] = sub i64 [[TMP6]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[TMP0]], [[TMP7]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP6]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = add i64 [[SPEC_SELECT]], [[N_VEC]]
; CHECK-NEXT:    [[TMP8:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP9:%.*]] = mul i64 [[TMP8]], 2
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[EVL_BASED_IV:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_EVL_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = sub i64 [[TMP0]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[TMP11:%.*]] = call i32 @llvm.experimental.get.vector.length.i64(i64 [[TMP10]], i32 2, i1 true)
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i64 [[SPEC_SELECT]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[TMP12:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP13:%.*]] = sub nuw nsw i64 1, [[TMP12]]
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr i64, ptr [[DST]], i64 [[TMP13]]
; CHECK-NEXT:    [[TMP15:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP16:%.*]] = mul i64 [[TMP15]], 2
; CHECK-NEXT:    [[TMP17:%.*]] = mul i64 0, [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = sub i64 1, [[TMP16]]
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr i64, ptr [[TMP14]], i64 [[TMP17]]
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr i64, ptr [[TMP19]], i64 [[TMP18]]
; CHECK-NEXT:    [[VP_REVERSE:%.*]] = call <vscale x 2 x i64> @llvm.experimental.vp.reverse.nxv2i64(<vscale x 2 x i64> zeroinitializer, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer), i32 [[TMP11]])
; CHECK-NEXT:    call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> [[VP_REVERSE]], ptr align 8 [[TMP20]], <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i64 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer), i32 [[TMP11]])
; CHECK-NEXT:    [[TMP21:%.*]] = zext i32 [[TMP11]] to i64
; CHECK-NEXT:    [[INDEX_EVL_NEXT]] = add i64 [[TMP21]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP9]]
; CHECK-NEXT:    [[TMP22:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP22]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], %[[MIDDLE_BLOCK]] ], [ [[SPEC_SELECT]], %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[TMP23:%.*]] = sub nuw nsw i64 1, [[IV]]
; CHECK-NEXT:    [[ARRAYIDX13:%.*]] = getelementptr i64, ptr [[DST]], i64 [[TMP23]]
; CHECK-NEXT:    store i64 0, ptr [[ARRAYIDX13]], align 8
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], 3
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label %[[EXIT]], label %[[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1.peel = icmp eq i32 %n, 0
  %spec.select = select i1 %cmp1.peel, i64 2, i64 0
  br label %loop

loop:
  %iv = phi i64 [ %spec.select, %entry ], [ %iv.next, %loop ]
  %1 = sub nuw nsw i64 1, %iv
  %arrayidx13 = getelementptr i64, ptr %dst, i64 %1
  store i64 0, ptr %arrayidx13, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 3
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.

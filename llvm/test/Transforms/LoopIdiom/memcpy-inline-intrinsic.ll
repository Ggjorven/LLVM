; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-idiom < %s -S | FileCheck %s

%struct.S = type { i32, i32, i8 }

; unsigned copy_noalias(S* __restrict a, S *b, int n) {
;   for (int i = 0; i < n; i++) {
;     a[i] = b[i];
;   }
;   return sizeof(a[0]);
; }

; Function Attrs: nofree nounwind uwtable mustprogress
define dso_local i32 @copy_noalias(ptr noalias nocapture %a, ptr nocapture readonly %b, i32 %n) local_unnamed_addr #0 {
; CHECK-LABEL: @copy_noalias(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP7:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP7]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret i32 12
; CHECK:       for.body:
; CHECK-NEXT:    [[I_08:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[I_08]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], ptr [[B:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[A:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    call void @llvm.memcpy.inline.p0.p0.i64(ptr nonnull align 4 dereferenceable(12) [[ARRAYIDX2]], ptr nonnull align 4 dereferenceable(12) [[ARRAYIDX]], i64 12, i1 false)
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_08]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]]
;
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret i32 12

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %idxprom = zext i32 %i.08 to i64
  %arrayidx = getelementptr inbounds %struct.S, ptr %b, i64 %idxprom
  %arrayidx2 = getelementptr inbounds %struct.S, ptr %a, i64 %idxprom
  call void @llvm.memcpy.inline.p0.p0.i64(ptr nonnull align 4 dereferenceable(12) %arrayidx2, ptr nonnull align 4 dereferenceable(12) %arrayidx, i64 12, i1 false)
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memcpy.inline.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

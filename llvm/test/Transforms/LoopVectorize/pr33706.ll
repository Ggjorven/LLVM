; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --prefix-filecheck-ir-name VAR_ --version 2
; RUN: opt -S -passes=loop-vectorize -force-vector-interleave=1 -force-vector-width=2 < %s | FileCheck %s

@global = local_unnamed_addr global i32 0, align 4
@global.1 = local_unnamed_addr global i32 0, align 4
@global.2 = local_unnamed_addr global float 0x3EF0000000000000, align 4

define void @PR33706(ptr nocapture readonly %arg, ptr nocapture %arg1, i32 %arg2) local_unnamed_addr {
; CHECK-LABEL: define void @PR33706
; CHECK-SAME: (ptr nocapture readonly [[ARG:%.*]], ptr nocapture [[ARG1:%.*]], i32 [[ARG2:%.*]]) local_unnamed_addr {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = load i32, ptr @global.1, align 4
; CHECK-NEXT:    [[VAR_TMP3:%.*]] = getelementptr inbounds float, ptr [[ARG]], i64 190
; CHECK-NEXT:    [[VAR_TMP4:%.*]] = getelementptr inbounds float, ptr [[ARG1]], i64 512
; CHECK-NEXT:    [[VAR_TMP5:%.*]] = and i32 [[TMP]], 65535
; CHECK-NEXT:    [[VAR_TMP6:%.*]] = icmp ugt i32 [[ARG2]], 65536
; CHECK-NEXT:    br i1 [[VAR_TMP6]], label [[BB7:%.*]], label [[BB9:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[VAR_TMP8:%.*]] = load i32, ptr @global, align 4
; CHECK-NEXT:    br label [[BB27:%.*]]
; CHECK:       bb9:
; CHECK-NEXT:    [[VAR_TMP10:%.*]] = udiv i32 65536, [[ARG2]]
; CHECK-NEXT:    br label [[BB11:%.*]]
; CHECK:       bb11:
; CHECK-NEXT:    [[VAR_TMP12:%.*]] = phi i32 [ [[VAR_TMP20:%.*]], [[BB11]] ], [ [[VAR_TMP5]], [[BB9]] ]
; CHECK-NEXT:    [[VAR_TMP13:%.*]] = phi ptr [ [[VAR_TMP18:%.*]], [[BB11]] ], [ [[VAR_TMP4]], [[BB9]] ]
; CHECK-NEXT:    [[VAR_TMP14:%.*]] = phi i32 [ [[VAR_TMP16:%.*]], [[BB11]] ], [ [[VAR_TMP10]], [[BB9]] ]
; CHECK-NEXT:    [[VAR_TMP15:%.*]] = phi i32 [ [[VAR_TMP19:%.*]], [[BB11]] ], [ [[TMP]], [[BB9]] ]
; CHECK-NEXT:    [[VAR_TMP16]] = add nsw i32 [[VAR_TMP14]], -1
; CHECK-NEXT:    [[VAR_TMP17:%.*]] = sitofp i32 [[VAR_TMP12]] to float
; CHECK-NEXT:    store float [[VAR_TMP17]], ptr [[VAR_TMP13]], align 4
; CHECK-NEXT:    [[VAR_TMP18]] = getelementptr inbounds float, ptr [[VAR_TMP13]], i64 1
; CHECK-NEXT:    [[VAR_TMP19]] = add i32 [[VAR_TMP15]], [[ARG2]]
; CHECK-NEXT:    [[VAR_TMP20]] = and i32 [[VAR_TMP19]], 65535
; CHECK-NEXT:    [[VAR_TMP21:%.*]] = icmp eq i32 [[VAR_TMP16]], 0
; CHECK-NEXT:    br i1 [[VAR_TMP21]], label [[BB22:%.*]], label [[BB11]]
; CHECK:       bb22:
; CHECK-NEXT:    [[VAR_TMP23:%.*]] = phi ptr [ [[VAR_TMP18]], [[BB11]] ]
; CHECK-NEXT:    [[VAR_TMP24:%.*]] = phi i32 [ [[VAR_TMP19]], [[BB11]] ]
; CHECK-NEXT:    [[VAR_TMP25:%.*]] = phi i32 [ [[VAR_TMP20]], [[BB11]] ]
; CHECK-NEXT:    [[VAR_TMP26:%.*]] = ashr i32 [[VAR_TMP24]], 16
; CHECK-NEXT:    store i32 [[VAR_TMP26]], ptr @global, align 4
; CHECK-NEXT:    br label [[BB27]]
; CHECK:       bb27:
; CHECK-NEXT:    [[VAR_TMP28:%.*]] = phi i32 [ [[VAR_TMP26]], [[BB22]] ], [ [[VAR_TMP8]], [[BB7]] ]
; CHECK-NEXT:    [[VAR_TMP29:%.*]] = phi ptr [ [[VAR_TMP23]], [[BB22]] ], [ [[VAR_TMP4]], [[BB7]] ]
; CHECK-NEXT:    [[VAR_TMP30:%.*]] = phi i32 [ [[VAR_TMP25]], [[BB22]] ], [ [[VAR_TMP5]], [[BB7]] ]
; CHECK-NEXT:    [[VAR_TMP31:%.*]] = sext i32 [[VAR_TMP28]] to i64
; CHECK-NEXT:    [[VAR_TMP32:%.*]] = getelementptr inbounds float, ptr [[VAR_TMP3]], i64 [[VAR_TMP31]]
; CHECK-NEXT:    [[VAR_TMP33:%.*]] = load float, ptr [[VAR_TMP32]], align 4
; CHECK-NEXT:    [[VAR_TMP34:%.*]] = sitofp i32 [[VAR_TMP30]] to float
; CHECK-NEXT:    [[VAR_TMP35:%.*]] = load float, ptr @global.2, align 4
; CHECK-NEXT:    [[VAR_TMP36:%.*]] = fmul float [[VAR_TMP35]], [[VAR_TMP34]]
; CHECK-NEXT:    [[VAR_TMP37:%.*]] = fadd float [[VAR_TMP33]], [[VAR_TMP36]]
; CHECK-NEXT:    store float [[VAR_TMP37]], ptr [[VAR_TMP29]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load i32, ptr @global.1, align 4
  %tmp3 = getelementptr inbounds float, ptr %arg, i64 190
  %tmp4 = getelementptr inbounds float, ptr %arg1, i64 512
  %tmp5 = and i32 %tmp, 65535
  %tmp6 = icmp ugt i32 %arg2, 65536
  br i1 %tmp6, label %bb7, label %bb9

bb7:                                              ; preds = %bb
  %tmp8 = load i32, ptr @global, align 4
  br label %bb27

bb9:                                              ; preds = %bb
  %tmp10 = udiv i32 65536, %arg2
  br label %bb11

bb11:                                             ; preds = %bb11, %bb9
  %tmp12 = phi i32 [ %tmp20, %bb11 ], [ %tmp5, %bb9 ]
  %tmp13 = phi ptr [ %tmp18, %bb11 ], [ %tmp4, %bb9 ]
  %tmp14 = phi i32 [ %tmp16, %bb11 ], [ %tmp10, %bb9 ]
  %tmp15 = phi i32 [ %tmp19, %bb11 ], [ %tmp, %bb9 ]
  %tmp16 = add nsw i32 %tmp14, -1
  %tmp17 = sitofp i32 %tmp12 to float
  store float %tmp17, ptr %tmp13, align 4
  %tmp18 = getelementptr inbounds float, ptr %tmp13, i64 1
  %tmp19 = add i32 %tmp15, %arg2
  %tmp20 = and i32 %tmp19, 65535
  %tmp21 = icmp eq i32 %tmp16, 0
  br i1 %tmp21, label %bb22, label %bb11

bb22:                                             ; preds = %bb11
  %tmp23 = phi ptr [ %tmp18, %bb11 ]
  %tmp24 = phi i32 [ %tmp19, %bb11 ]
  %tmp25 = phi i32 [ %tmp20, %bb11 ]
  %tmp26 = ashr i32 %tmp24, 16
  store i32 %tmp26, ptr @global, align 4
  br label %bb27

bb27:                                             ; preds = %bb22, %bb7
  %tmp28 = phi i32 [ %tmp26, %bb22 ], [ %tmp8, %bb7 ]
  %tmp29 = phi ptr [ %tmp23, %bb22 ], [ %tmp4, %bb7 ]
  %tmp30 = phi i32 [ %tmp25, %bb22 ], [ %tmp5, %bb7 ]
  %tmp31 = sext i32 %tmp28 to i64
  %tmp32 = getelementptr inbounds float, ptr %tmp3, i64 %tmp31
  %tmp33 = load float, ptr %tmp32, align 4
  %tmp34 = sitofp i32 %tmp30 to float
  %tmp35 = load float, ptr @global.2, align 4
  %tmp36 = fmul float %tmp35, %tmp34
  %tmp37 = fadd float %tmp33, %tmp36
  store float %tmp37, ptr %tmp29, align 4
  ret void
}

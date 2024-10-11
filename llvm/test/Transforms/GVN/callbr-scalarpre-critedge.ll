; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=gvn -S | FileCheck %s

; This test checks that we don't hang trying to split a critical edge in scalar
; PRE when the control flow uses a callbr instruction.

define void @wombat(i64 %arg, ptr %arg1, i64 %arg2, ptr %arg3) {
; CHECK-LABEL: @wombat(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP5:%.*]] = or i64 [[ARG2:%.*]], [[ARG:%.*]]
; CHECK-NEXT:    callbr void asm sideeffect "", "!i,!i"()
; CHECK-NEXT:    to label [[BB6:%.*]] [label [[BB7:%.*]], label %bb.bb9_crit_edge]
; CHECK:       bb.bb9_crit_edge:
; CHECK-NEXT:    [[DOTPRE:%.*]] = trunc i64 [[TMP5]] to i32
; CHECK-NEXT:    br label [[BB9:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    br label [[BB7]]
; CHECK:       bb7:
; CHECK-NEXT:    [[TMP8:%.*]] = trunc i64 [[TMP5]] to i32
; CHECK-NEXT:    tail call void @barney(i32 [[TMP8]])
; CHECK-NEXT:    br label [[BB9]]
; CHECK:       bb9:
; CHECK-NEXT:    [[TMP10_PRE_PHI:%.*]] = phi i32 [ [[DOTPRE]], [[BB_BB9_CRIT_EDGE:%.*]] ], [ [[TMP8]], [[BB7]] ]
; CHECK-NEXT:    store i32 [[TMP10_PRE_PHI]], ptr [[ARG3:%.*]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %tmp5 = or i64 %arg2, %arg
  callbr void asm sideeffect "", "!i,!i"()
  to label %bb6 [label %bb7, label %bb9]

bb6:                                              ; preds = %bb
  br label %bb7

bb7:                                              ; preds = %bb6, %bb
  %tmp8 = trunc i64 %tmp5 to i32
  tail call void @barney(i32 %tmp8)
  br label %bb9

bb9:                                              ; preds = %bb7, %bb
  %tmp10 = trunc i64 %tmp5 to i32
  store i32 %tmp10, ptr %arg3
  ret void
}

declare void @barney(i32)

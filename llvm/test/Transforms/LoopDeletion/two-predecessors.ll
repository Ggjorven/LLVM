; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-deletion -S | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

define dso_local i32 @hoge() local_unnamed_addr #0 {
; CHECK-LABEL: @hoge(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    callbr void asm sideeffect "", "!i"()
; CHECK-NEXT:    to label [[BB1:%.*]] [label %bb2.preheader]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB2_PREHEADER:%.*]]
; CHECK:       bb2.preheader:
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP:%.*]] = phi i32 [ [[TMP3:%.*]], [[BB2]] ], [ undef, [[BB2_PREHEADER]] ]
; CHECK-NEXT:    [[TMP3]] = tail call i32 @widget(i32 [[TMP]])
; CHECK-NEXT:    br label [[BB2]]
;
bb:
  callbr void asm sideeffect "", "!i"() #1
  to label %bb1 [label %bb2]

bb1:                                              ; preds = %bb
  br label %bb2

bb2:                                              ; preds = %bb2, %bb1, %bb
  %tmp = phi i32 [ undef, %bb1 ], [ %tmp3, %bb2 ], [ undef, %bb ]
  %tmp3 = tail call i32 @widget(i32 %tmp) #1
  br label %bb2
}

declare dso_local i32 @widget(...) local_unnamed_addr #0

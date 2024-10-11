; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=jump-threading -S | FileCheck %s

define i1 @func(i1 %arg, i32 %arg1, i1 %arg2) {
; CHECK-LABEL: @func(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br i1 [[ARG:%.*]], label [[BB7:%.*]], label [[BB4:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    callbr void asm sideeffect "", "!i"()
; CHECK-NEXT:    to label [[BB7_THR_COMM:%.*]] [label %bb7.thr_comm]
; CHECK:       bb7.thr_comm:
; CHECK-NEXT:    [[I91:%.*]] = xor i1 [[ARG2:%.*]], [[ARG]]
; CHECK-NEXT:    br i1 [[I91]], label [[BB11:%.*]], label [[BB11]]
; CHECK:       bb7:
; CHECK-NEXT:    [[I:%.*]] = icmp eq i32 [[ARG1:%.*]], 0
; CHECK-NEXT:    [[I9:%.*]] = xor i1 [[I]], [[ARG]]
; CHECK-NEXT:    br i1 [[I9]], label [[BB11]], label [[BB11]]
; CHECK:       bb11:
; CHECK-NEXT:    [[I93:%.*]] = phi i1 [ [[I91]], [[BB7_THR_COMM]] ], [ [[I9]], [[BB7]] ], [ [[I91]], [[BB7_THR_COMM]] ], [ [[I9]], [[BB7]] ]
; CHECK-NEXT:    ret i1 [[I93]]
;
bb:
  br i1 %arg, label %bb3, label %bb4

bb3:
  %i = icmp eq i32 %arg1, 0
  br label %bb7

bb4:
  callbr void asm sideeffect "", "!i"()
  to label %bb5 [label %bb6]

bb5:
  br label %bb6

bb6:
  br label %bb7

bb7:
  %i8 = phi i1 [ %i, %bb3 ], [ %arg2, %bb6 ]
  %i9 = xor i1 %i8, %arg
  br i1 %i9, label %bb11, label %bb10

bb10:
  br label %bb11

bb11:
  ret i1 %i9
}

define i32 @callbr_no_block_merge() {
; CHECK-LABEL: @callbr_no_block_merge(
; CHECK-NEXT:    [[X:%.*]] = callbr i32 asm sideeffect "", "=r"()
; CHECK-NEXT:    to label [[BB:%.*]] []
; CHECK:       bb:
; CHECK-NEXT:    ret i32 [[X]]
;
  %x = callbr i32 asm sideeffect "", "=r"()
  to label %bb []

bb:
  ret i32 %x
}

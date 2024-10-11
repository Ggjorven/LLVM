; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-unknown-linux-gnu -passes='loop-unroll' -unroll-runtime -S < %s 2>&1 | FileCheck %s

define void @mask-high(i64 %arg, ptr dereferenceable(4) %arg1) {
; CHECK-LABEL: @mask-high(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr [[ARG1:%.*]], align 4
; CHECK-NEXT:    [[I2:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[I3:%.*]] = and i64 [[ARG:%.*]], -16
; CHECK-NEXT:    [[I4:%.*]] = or disjoint i64 1, [[I3]]
; CHECK-NEXT:    [[I5:%.*]] = icmp sgt i64 [[I4]], [[I2]]
; CHECK-NEXT:    br i1 [[I5]], label [[BB10:%.*]], label [[BB6_PREHEADER:%.*]]
; CHECK:       bb6.preheader:
; CHECK-NEXT:    br label [[BB6:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    [[I7:%.*]] = phi i64 [ [[I8:%.*]], [[BB6]] ], [ [[I4]], [[BB6_PREHEADER]] ]
; CHECK-NEXT:    [[I8]] = add i64 [[I7]], 1
; CHECK-NEXT:    [[I9:%.*]] = icmp slt i64 [[I7]], [[I2]]
; CHECK-NEXT:    br i1 [[I9]], label [[BB6]], label [[BB10_LOOPEXIT:%.*]]
; CHECK:       bb10.loopexit:
; CHECK-NEXT:    br label [[BB10]]
; CHECK:       bb10:
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr %arg1, align 4
  %i2 = sext i32 %i to i64
  %i3 = and i64 %arg, -16
  %i4 = or disjoint i64 1, %i3
  %i5 = icmp sgt i64 %i4, %i2
  br i1 %i5, label %bb10, label %bb6

bb6:                                              ; preds = %bb6, %bb
  %i7 = phi i64 [ %i4, %bb ], [ %i8, %bb6 ]
  %i8 = add i64 %i7, 1
  %i9 = icmp slt i64 %i7, %i2
  br i1 %i9, label %bb6, label %bb10

bb10:                                             ; preds = %bb6, %bb
  ret void
}


define void @mask-low(i64 %arg, ptr dereferenceable(4) %arg1) {
; CHECK-LABEL: @mask-low(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr [[ARG1:%.*]], align 4
; CHECK-NEXT:    [[I2:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[I3:%.*]] = and i64 [[ARG:%.*]], 16
; CHECK-NEXT:    [[I4:%.*]] = add i64 1, [[I3]]
; CHECK-NEXT:    [[I5:%.*]] = icmp sgt i64 [[I4]], [[I2]]
; CHECK-NEXT:    br i1 [[I5]], label [[BB10:%.*]], label [[BB6_PREHEADER:%.*]]
; CHECK:       bb6.preheader:
; CHECK-NEXT:    br label [[BB6:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    [[I7:%.*]] = phi i64 [ [[I8:%.*]], [[BB6]] ], [ [[I4]], [[BB6_PREHEADER]] ]
; CHECK-NEXT:    [[I8]] = add i64 [[I7]], 1
; CHECK-NEXT:    [[I9:%.*]] = icmp slt i64 [[I7]], [[I2]]
; CHECK-NEXT:    br i1 [[I9]], label [[BB6]], label [[BB10_LOOPEXIT:%.*]]
; CHECK:       bb10.loopexit:
; CHECK-NEXT:    br label [[BB10]]
; CHECK:       bb10:
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr %arg1, align 4
  %i2 = sext i32 %i to i64
  %i3 = and i64 %arg, 16
  %i4 = add i64 1, %i3
  %i5 = icmp sgt i64 %i4, %i2
  br i1 %i5, label %bb10, label %bb6

bb6:                                              ; preds = %bb6, %bb
  %i7 = phi i64 [ %i4, %bb ], [ %i8, %bb6 ]
  %i8 = add i64 %i7, 1
  %i9 = icmp slt i64 %i7, %i2
  br i1 %i9, label %bb6, label %bb10

bb10:                                             ; preds = %bb6, %bb
  ret void
}

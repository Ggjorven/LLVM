; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -S | FileCheck %s

declare void @foo(i16 noundef)

; Function Attrs: mustprogress noreturn uwtable
define void @bar(i64 noundef %ptr) {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i64 [[PTR:%.*]] to i4
; CHECK-NEXT:    [[TMP1:%.*]] = zext i4 [[TMP0]] to i16
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    tail call void @foo(i16 noundef signext [[TMP1]])
; CHECK-NEXT:    br label [[WHILE_BODY]]
;
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  %0 = phi i64 [ %ptr, %entry ], [ %add.ptr, %while.body ]
  %1 = trunc i64 %0 to i16
  %and = and i16 %1, 15                           ; loop invariant
  tail call void @foo(i16 noundef signext %and)
  %add.ptr = add nsw i64 %0,  16
  br label %while.body
}


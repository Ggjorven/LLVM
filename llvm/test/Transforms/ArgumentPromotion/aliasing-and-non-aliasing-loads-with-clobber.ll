; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p argpromotion -S %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

@f = dso_local global { i16, i64 } { i16 1, i64 0 }, align 8

; Test case for https://github.com/llvm/llvm-project/issues/84807.

; Make sure the loads from @callee are not moved to @caller, as the store
; in %then may aliases to load from %q.

define i32 @caller1(i1 %c) {
; CHECK-LABEL: define i32 @caller1(
; CHECK-SAME: i1 [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @callee1(ptr noundef nonnull @f, i1 [[C]])
; CHECK-NEXT:    ret i32 0
;
entry:
  call void @callee1(ptr noundef nonnull @f, i1 %c)
  ret i32 0
}

define internal void @callee1(ptr nocapture noundef readonly %q, i1 %c) {
; CHECK-LABEL: define internal void @callee1(
; CHECK-SAME: ptr nocapture noundef readonly [[Q:%.*]], i1 [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C]], label [[THEN:%.*]], label [[EXIT:%.*]]
; CHECK:       then:
; CHECK-NEXT:    store i16 123, ptr @f, align 8
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[Q_0_VAL:%.*]] = load i16, ptr [[Q]], align 8
; CHECK-NEXT:    [[GEP_8:%.*]] = getelementptr inbounds i8, ptr [[Q]], i64 8
; CHECK-NEXT:    [[Q_8_VAL:%.*]] = load i64, ptr [[GEP_8]], align 8
; CHECK-NEXT:    call void @use(i16 [[Q_0_VAL]], i64 [[Q_8_VAL]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %then, label %exit

then:
  store i16 123, ptr @f, align 8
  br label %exit

exit:
  %l.0 = load i16, ptr %q, align 8
  %gep.8  = getelementptr inbounds i8, ptr %q, i64 8
  %l.1 = load i64, ptr %gep.8, align 8
  call void @use(i16 %l.0, i64 %l.1)
  ret void

  uselistorder ptr %q, { 1, 0 }
}

; Same as @caller1/callee2, but with default uselist order.
define i32 @caller2(i1 %c) {
; CHECK-LABEL: define i32 @caller2(
; CHECK-SAME: i1 [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @callee2(ptr noundef nonnull @f, i1 [[C]])
; CHECK-NEXT:    ret i32 0
;
entry:
  call void @callee2(ptr noundef nonnull @f, i1 %c)
  ret i32 0
}

define internal void @callee2(ptr nocapture noundef readonly %q, i1 %c) {
; CHECK-LABEL: define internal void @callee2(
; CHECK-SAME: ptr nocapture noundef readonly [[Q:%.*]], i1 [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C]], label [[THEN:%.*]], label [[EXIT:%.*]]
; CHECK:       then:
; CHECK-NEXT:    store i16 123, ptr @f, align 8
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[Q_0_VAL:%.*]] = load i16, ptr [[Q]], align 8
; CHECK-NEXT:    [[GEP_8:%.*]] = getelementptr inbounds i8, ptr [[Q]], i64 8
; CHECK-NEXT:    [[Q_8_VAL:%.*]] = load i64, ptr [[GEP_8]], align 8
; CHECK-NEXT:    call void @use(i16 [[Q_0_VAL]], i64 [[Q_8_VAL]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %then, label %exit

then:
  store i16 123, ptr @f, align 8
  br label %exit

exit:
  %l.0 = load i16, ptr %q, align 8
  %gep.8  = getelementptr inbounds i8, ptr %q, i64 8
  %l.1 = load i64, ptr %gep.8, align 8
  call void @use(i16 %l.0, i64 %l.1)
  ret void
}

declare void @use(i16, i64)

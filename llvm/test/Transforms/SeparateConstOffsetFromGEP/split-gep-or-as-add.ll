; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes="separate-const-offset-from-gep<lower-gep>" < %s | FileCheck %s

;; Check that or operations, either with operands with no bits in common or that
;; are disjoint are lowered into constant GEPs. Note that because this is a
;; target-independent test, the GEP separator will lower the separated-off constant
;; part to ptrtoint-based arithmetic.

define void @testOrDoesntSplit(ptr %p) {
; CHECK-LABEL: define void @testOrDoesntSplit(
; CHECK-SAME: ptr [[P:%.*]]) {
; CHECK-NEXT:    [[VAR:%.*]] = tail call i64 @foo()
; CHECK-NEXT:    [[OFF:%.*]] = or i64 [[VAR]], 10
; CHECK-NEXT:    [[Q:%.*]] = getelementptr i8, ptr [[P]], i64 [[OFF]]
; CHECK-NEXT:    store i8 0, ptr [[Q]], align 1
; CHECK-NEXT:    ret void
;
  %var = tail call i64 @foo()
  %off = or i64 %var, 10
  %q = getelementptr i8, ptr %p, i64 %off
  store i8 0, ptr %q
  ret void
}

; COM: The check for `or disjoint` removed the old hasNoBitsInCommon()
; COM: check, ensure that failing to annotate an or with disjoint makes
; COM: the optimization fail.
define void @testNoBitsInCommonOrDoesntSplit(ptr %p) {
; CHECK-LABEL: define void @testNoBitsInCommonOrDoesntSplit(
; CHECK-SAME: ptr [[P:%.*]]) {
; CHECK-NEXT:    [[VAR:%.*]] = tail call i64 @foo()
; CHECK-NEXT:    [[VAR_HIGH:%.*]] = and i64 [[VAR]], -16
; CHECK-NEXT:    [[OFF:%.*]] = or i64 [[VAR_HIGH]], 10
; CHECK-NEXT:    [[Q:%.*]] = getelementptr i8, ptr [[P]], i64 [[OFF]]
; CHECK-NEXT:    store i8 0, ptr [[Q]], align 1
; CHECK-NEXT:    ret void
;
  %var = tail call i64 @foo()
  %var.high = and i64 %var, -16
  %off = or i64 %var.high, 10
  %q = getelementptr i8, ptr %p, i64 %off
  store i8 0, ptr %q
  ret void
}

define void @testDisjointOrSplits(ptr %p) {
; CHECK-LABEL: define void @testDisjointOrSplits(
; CHECK-SAME: ptr [[P:%.*]]) {
; CHECK-NEXT:    [[VAR:%.*]] = tail call i64 @foo()
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[TMP1]], [[VAR]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[TMP2]], 10
; CHECK-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; CHECK-NEXT:    store i8 0, ptr [[TMP4]], align 1
; CHECK-NEXT:    ret void
;
  %var = tail call i64 @foo()
  %off = or disjoint i64 %var, 10
  %q = getelementptr i8, ptr %p, i64 %off
  store i8 0, ptr %q
  ret void
}

declare i64 @foo()

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -S | FileCheck %s

; The assumption underlying this test is that there are pre-existing check lines
; but something has changed, and we would like to avoid needless changes of
; meta variable names so that diffs end up being easier to read, e.g. avoid
; changing X_I33 into X_I34 or renumbering the various TMP variables.

define i32 @func({i32, i32} %x, i32 %y) {
; CHECK-LABEL: define i32 @func(
; CHECK-SAME: { i32, i32 } [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:    [[X_I33:%.*]] = extractvalue { i32, i32 } [[X]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[X_I33]], [[Y]]
; CHECK-NEXT:    [[TMP2:%.*]] = mul i32 [[TMP1]], 3
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %x.i34 = extractvalue {i32, i32} %x, 0
  %1 = add i32 %y, 1
  %2 = add i32 %x.i34, %1
  %3 = mul i32 %2, 3
  ret i32 %3
}

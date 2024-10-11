; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt --passes=instcombine -S < %s | FileCheck %s

define void @foo() {
; CHECK-LABEL: define void @foo() {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    ret void
;
entry:
  ret void
}

define i32 @bar() {
; CHECK-LABEL: define i32 @bar() {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = tail call i32 @foo()
; CHECK-NEXT:    ret i32 [[TMP0]]
;
entry:
  %1 = tail call i32 @foo()
  ret i32 %1
}

define void @goo() {
; CHECK-LABEL: define void @goo() {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    ret void
;
entry:
  %res = call i32 @foo()
  ret void
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @llvm.assume(i1) #1

define i1 @nonnull0_true(ptr %x) {
; CHECK-LABEL: @nonnull0_true(
; CHECK-NEXT:    [[A:%.*]] = icmp ne ptr [[X:%.*]], null
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp ne ptr %x, null
  call void @llvm.assume(i1 %a)
  %q = icmp ne ptr %x, null
  ret i1 %q
}

define i1 @nonnull1_true(ptr %x) {
; CHECK-LABEL: @nonnull1_true(
; CHECK-NEXT:    [[INTPTR:%.*]] = ptrtoint ptr [[X:%.*]] to i64
; CHECK-NEXT:    [[A:%.*]] = icmp ne i64 [[INTPTR]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %intptr = ptrtoint ptr %x to i64
  %a = icmp ne i64 %intptr, 0
  call void @llvm.assume(i1 %a)
  %q = icmp ne ptr %x, null
  ret i1 %q
}

define i1 @nonnull2_true(i8 %x, i8 %y) {
; CHECK-LABEL: @nonnull2_true(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp ugt i8 %x, %y
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull2_true_swapped(i8 %x, i8 %y) {
; CHECK-LABEL: @nonnull2_true_swapped(
; CHECK-NEXT:    [[A:%.*]] = icmp ult i8 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp ult i8 %y, %x
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}

define i1 @nonnull3_unknown(i8 %x) {
; CHECK-LABEL: @nonnull3_unknown(
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp uge i8 %x, 0
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull4_true(i8 %x) {
; CHECK-LABEL: @nonnull4_true(
; CHECK-NEXT:    [[A:%.*]] = icmp uge i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp uge i8 %x, 1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}

define i1 @nonnull5_unknown(i8 %x) {
; CHECK-LABEL: @nonnull5_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp sgt i8 %x, -1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull6_true(i8 %x) {
; CHECK-LABEL: @nonnull6_true(
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i8 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp sgt i8 %x, 0
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull7_true(i8 %x) {
; CHECK-LABEL: @nonnull7_true(
; CHECK-NEXT:    [[A:%.*]] = icmp sgt i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp sgt i8 %x, 1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}

define i1 @nonnull8_unknown(i8 %x) {
; CHECK-LABEL: @nonnull8_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp sge i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp sge i8 %x, -1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull9_unknown(i8 %x) {
; CHECK-LABEL: @nonnull9_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp sge i8 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp sge i8 %x, 0
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull10_true(i8 %x) {
; CHECK-LABEL: @nonnull10_true(
; CHECK-NEXT:    [[A:%.*]] = icmp sge i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp sge i8 %x, 1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}

define i1 @nonnull11_true(i8 %x) {
; CHECK-LABEL: @nonnull11_true(
; CHECK-NEXT:    [[A:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp slt i8 %x, 0
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull12_unknown(i8 %x) {
; CHECK-LABEL: @nonnull12_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp slt i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp slt i8 %x, 1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull13_unknown(i8 %x) {
; CHECK-LABEL: @nonnull13_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp slt i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp slt i8 %x, 2
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}

define i1 @nonnull14_true(i8 %x) {
; CHECK-LABEL: @nonnull14_true(
; CHECK-NEXT:    [[A:%.*]] = icmp sle i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    ret i1 true
;
  %a = icmp sle i8 %x, -1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull15_unknown(i8 %x) {
; CHECK-LABEL: @nonnull15_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp sle i8 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp sle i8 %x, 0
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull16_unknown(i8 %x) {
; CHECK-LABEL: @nonnull16_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp sle i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp sle i8 %x, 1
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}
define i1 @nonnull17_unknown(i8 %x) {
; CHECK-LABEL: @nonnull17_unknown(
; CHECK-NEXT:    [[A:%.*]] = icmp sle i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @llvm.assume(i1 [[A]])
; CHECK-NEXT:    [[Q:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[Q]]
;
  %a = icmp sle i8 %x, 2
  call void @llvm.assume(i1 %a)
  %q = icmp ne i8 %x, 0
  ret i1 %q
}

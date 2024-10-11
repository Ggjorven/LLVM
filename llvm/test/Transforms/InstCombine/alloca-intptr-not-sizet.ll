; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
target datalayout = "p0:64:64:64-p7:128:128:128:32-A7"

define void @test_array_alloca_intptr_not_sizet(i64 %size, ptr %dest) {
; CHECK-LABEL: @test_array_alloca_intptr_not_sizet(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[SIZE:%.*]] to i32
; CHECK-NEXT:    [[ALLOCA:%.*]] = alloca i8, i32 [[TMP1]], align 1, addrspace(7)
; CHECK-NEXT:    store ptr addrspace(7) [[ALLOCA]], ptr [[DEST:%.*]], align 16
; CHECK-NEXT:    ret void
;
  %alloca = alloca i8, i64 %size, addrspace(7)
  store ptr addrspace(7) %alloca, ptr %dest
  ret void
}

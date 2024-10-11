; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2

; RUN: opt < %s -passes=hwasan -S | FileCheck %s
; RUN: opt < %s -passes=hwasan -hwasan-mapping-offset-dynamic=global -S | FileCheck %s --check-prefixes=GLOBAL
; RUN: opt < %s -passes=hwasan -hwasan-mapping-offset=567 -S | FileCheck %s --check-prefixes=FIXED
; RUN: opt < %s -passes=hwasan -hwasan-mapping-offset=567 -hwasan-mapping-offset-dynamic=global -S | FileCheck %s --check-prefixes=FIXED-GLOBAL
; RUN: opt < %s -passes=hwasan -hwasan-mapping-offset-dynamic=global -hwasan-mapping-offset=567 -S | FileCheck %s --check-prefixes=GLOBAL-FIXED

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-android"

define i8 @test_load8(ptr %a) sanitize_hwaddress {
; CHECK-LABEL: define i8 @test_load8
; CHECK-SAME: (ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[DOTHWASAN_SHADOW:%.*]] = call ptr asm "", "=r,0"(ptr @__hwasan_shadow)
; CHECK-NEXT:    call void @llvm.hwasan.check.memaccess(ptr [[DOTHWASAN_SHADOW]], ptr [[A]], i32 0)
; CHECK-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 4
; CHECK-NEXT:    ret i8 [[B]]
;
; GLOBAL-LABEL: define i8 @test_load8
; GLOBAL-SAME: (ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; GLOBAL-NEXT:    [[TMP1:%.*]] = load ptr, ptr @__hwasan_shadow_memory_dynamic_address, align 8
; GLOBAL-NEXT:    call void @llvm.hwasan.check.memaccess(ptr [[TMP1]], ptr [[A]], i32 0)
; GLOBAL-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 4
; GLOBAL-NEXT:    ret i8 [[B]]
;
; FIXED-LABEL: define i8 @test_load8
; FIXED-SAME: (ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; FIXED-NEXT:    [[DOTHWASAN_SHADOW:%.*]] = call ptr asm "", "=r,0"(ptr inttoptr (i64 567 to ptr))
; FIXED-NEXT:    call void @llvm.hwasan.check.memaccess(ptr [[DOTHWASAN_SHADOW]], ptr [[A]], i32 0)
; FIXED-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 4
; FIXED-NEXT:    ret i8 [[B]]
;
; FIXED-GLOBAL-LABEL: define i8 @test_load8
; FIXED-GLOBAL-SAME: (ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; FIXED-GLOBAL-NEXT:    [[TMP1:%.*]] = load ptr, ptr @__hwasan_shadow_memory_dynamic_address, align 8
; FIXED-GLOBAL-NEXT:    call void @llvm.hwasan.check.memaccess(ptr [[TMP1]], ptr [[A]], i32 0)
; FIXED-GLOBAL-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 4
; FIXED-GLOBAL-NEXT:    ret i8 [[B]]
;
; GLOBAL-FIXED-LABEL: define i8 @test_load8
; GLOBAL-FIXED-SAME: (ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; GLOBAL-FIXED-NEXT:    [[DOTHWASAN_SHADOW:%.*]] = call ptr asm "", "=r,0"(ptr inttoptr (i64 567 to ptr))
; GLOBAL-FIXED-NEXT:    call void @llvm.hwasan.check.memaccess(ptr [[DOTHWASAN_SHADOW]], ptr [[A]], i32 0)
; GLOBAL-FIXED-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 4
; GLOBAL-FIXED-NEXT:    ret i8 [[B]]
;
  %b = load i8, ptr %a, align 4
  ret i8 %b
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

declare noalias ptr @malloc(i64) allockind("alloc,uninitialized") allocsize(0) "alloc-family"="malloc"
declare noalias ptr @calloc(i64, i64) allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc"
declare noalias ptr @realloc(ptr nocapture, i64) allockind("realloc") allocsize(1) "alloc-family"="malloc"
declare noalias nonnull ptr @_Znam(i64) ; throwing version of 'new'
declare noalias nonnull ptr @_Znwm(i64) ; throwing version of 'new'
declare noalias ptr @strdup(ptr)
declare noalias ptr @aligned_alloc(i64 allocalign, i64) allockind("alloc,uninitialized,aligned") allocsize(1) "alloc-family"="malloc"
declare noalias align 16 ptr @memalign(i64 allocalign, i64) allocsize(1)
; new[](unsigned int, align_val_t)
declare noalias ptr @_ZnamSt11align_val_t(i64 %size, i64 %align)

declare ptr @my_malloc(i64) allocsize(0)
declare ptr @my_calloc(i64, i64) allocsize(0, 1)

@.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1

define noalias ptr @malloc_nonconstant_size(i64 %n) {
; CHECK-LABEL: @malloc_nonconstant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @malloc(i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @malloc(i64 %n)
  ret ptr %call
}

define noalias ptr @malloc_constant_size() {
; CHECK-LABEL: @malloc_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(40) ptr @malloc(i64 40)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @malloc(i64 40)
  ret ptr %call
}

define noalias ptr @aligned_alloc_constant_size() {
; CHECK-LABEL: @aligned_alloc_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias align 32 dereferenceable_or_null(512) ptr @aligned_alloc(i64 32, i64 512)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @aligned_alloc(i64 32, i64 512)
  ret ptr %call
}

define noalias ptr @aligned_alloc_unknown_size_nonzero(i1 %c) {
; CHECK-LABEL: @aligned_alloc_unknown_size_nonzero(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[C:%.*]], i64 64, i64 128
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias align 32 ptr @aligned_alloc(i64 32, i64 [[SIZE]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %size = select i1 %c, i64 64, i64 128
  %call = tail call noalias ptr @aligned_alloc(i64 32, i64 %size)
  ret ptr %call
}

define noalias ptr @aligned_alloc_unknown_size_possibly_zero(i1 %c) {
; CHECK-LABEL: @aligned_alloc_unknown_size_possibly_zero(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[C:%.*]], i64 64, i64 0
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias align 32 ptr @aligned_alloc(i64 32, i64 [[SIZE]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %size = select i1 %c, i64 64, i64 0
  %call = tail call noalias ptr @aligned_alloc(i64 32, i64 %size)
  ret ptr %call
}

define noalias ptr @aligned_alloc_unknown_align(i64 %align) {
; CHECK-LABEL: @aligned_alloc_unknown_align(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(128) ptr @aligned_alloc(i64 [[ALIGN:%.*]], i64 128)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @aligned_alloc(i64 %align, i64 128)
  ret ptr %call
}

declare noalias ptr @foo(ptr, ptr, ptr)

define noalias ptr @aligned_alloc_dynamic_args(i64 %align, i64 %size) {
; CHECK-LABEL: @aligned_alloc_dynamic_args(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(1024) ptr @aligned_alloc(i64 [[ALIGN:%.*]], i64 1024)
; CHECK-NEXT:    [[CALL_1:%.*]] = tail call noalias dereferenceable_or_null(1024) ptr @aligned_alloc(i64 0, i64 1024)
; CHECK-NEXT:    [[CALL_2:%.*]] = tail call noalias align 32 ptr @aligned_alloc(i64 32, i64 [[SIZE:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @foo(ptr [[CALL]], ptr [[CALL_1]], ptr [[CALL_2]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @aligned_alloc(i64 %align, i64 1024)
  %call_1 = tail call noalias ptr @aligned_alloc(i64 0, i64 1024)
  %call_2 = tail call noalias ptr @aligned_alloc(i64 32, i64 %size)

  call ptr @foo(ptr %call, ptr %call_1, ptr %call_2)
  ret ptr %call
}

define noalias ptr @memalign_constant_size() {
; CHECK-LABEL: @memalign_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias align 32 dereferenceable_or_null(512) ptr @memalign(i64 32, i64 512)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @memalign(i64 32, i64 512)
  ret ptr %call
}

define noalias ptr @memalign_unknown_size_nonzero(i1 %c) {
; CHECK-LABEL: @memalign_unknown_size_nonzero(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[C:%.*]], i64 64, i64 128
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias align 32 ptr @memalign(i64 32, i64 [[SIZE]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %size = select i1 %c, i64 64, i64 128
  %call = tail call noalias ptr @memalign(i64 32, i64 %size)
  ret ptr %call
}

define noalias ptr @memalign_unknown_size_possibly_zero(i1 %c) {
; CHECK-LABEL: @memalign_unknown_size_possibly_zero(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[C:%.*]], i64 64, i64 0
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias align 32 ptr @memalign(i64 32, i64 [[SIZE]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %size = select i1 %c, i64 64, i64 0
  %call = tail call noalias ptr @memalign(i64 32, i64 %size)
  ret ptr %call
}

define noalias ptr @memalign_unknown_align(i64 %align) {
; CHECK-LABEL: @memalign_unknown_align(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(128) ptr @memalign(i64 [[ALIGN:%.*]], i64 128)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @memalign(i64 %align, i64 128)
  ret ptr %call
}

define noalias ptr @malloc_constant_size2() {
; CHECK-LABEL: @malloc_constant_size2(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(40) ptr @malloc(i64 40)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias dereferenceable_or_null(80) ptr @malloc(i64 40)
  ret ptr %call
}

define noalias ptr @malloc_constant_size3() {
; CHECK-LABEL: @malloc_constant_size3(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable(80) dereferenceable_or_null(40) ptr @malloc(i64 40)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias dereferenceable(80) ptr @malloc(i64 40)
  ret ptr %call
}

define noalias ptr @malloc_constant_zero_size() {
; CHECK-LABEL: @malloc_constant_zero_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @malloc(i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @malloc(i64 0)
  ret ptr %call
}

define noalias ptr @realloc_nonconstant_size(ptr %p, i64 %n) {
; CHECK-LABEL: @realloc_nonconstant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @realloc(ptr [[P:%.*]], i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @realloc(ptr %p, i64 %n)
  ret ptr %call
}

define noalias ptr @realloc_constant_zero_size(ptr %p) {
; CHECK-LABEL: @realloc_constant_zero_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @realloc(ptr [[P:%.*]], i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @realloc(ptr %p, i64 0)
  ret ptr %call
}

define noalias ptr @realloc_constant_size(ptr %p) {
; CHECK-LABEL: @realloc_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(40) ptr @realloc(ptr [[P:%.*]], i64 40)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @realloc(ptr %p, i64 40)
  ret ptr %call
}

define noalias ptr @calloc_nonconstant_size(i64 %n) {
; CHECK-LABEL: @calloc_nonconstant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 1, i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 1, i64 %n)
  ret ptr %call
}

define noalias ptr @calloc_nonconstant_size2(i64 %n) {
; CHECK-LABEL: @calloc_nonconstant_size2(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 [[N:%.*]], i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 %n, i64 0)
  ret ptr %call
}

define noalias ptr @calloc_nonconstant_size3(i64 %n) {
; CHECK-LABEL: @calloc_nonconstant_size3(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 [[N:%.*]], i64 [[N]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 %n, i64 %n)
  ret ptr %call
}

define noalias ptr @calloc_constant_zero_size() {
; CHECK-LABEL: @calloc_constant_zero_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 0, i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 0, i64 0)
  ret ptr %call
}

define noalias ptr @calloc_constant_zero_size2(i64 %n) {
; CHECK-LABEL: @calloc_constant_zero_size2(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 [[N:%.*]], i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 %n, i64 0)
  ret ptr %call
}


define noalias ptr @calloc_constant_zero_size3(i64 %n) {
; CHECK-LABEL: @calloc_constant_zero_size3(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 0, i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 0, i64 %n)
  ret ptr %call
}

define noalias ptr @calloc_constant_zero_size4(i64 %n) {
; CHECK-LABEL: @calloc_constant_zero_size4(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 0, i64 1)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 0, i64 1)
  ret ptr %call
}

define noalias ptr @calloc_constant_zero_size5(i64 %n) {
; CHECK-LABEL: @calloc_constant_zero_size5(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 1, i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 1, i64 0)
  ret ptr %call
}

define noalias ptr @calloc_constant_size() {
; CHECK-LABEL: @calloc_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(128) ptr @calloc(i64 16, i64 8)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 16, i64 8)
  ret ptr %call
}

define noalias ptr @calloc_constant_size_overflow() {
; CHECK-LABEL: @calloc_constant_size_overflow(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @calloc(i64 2000000000000, i64 80000000000)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @calloc(i64 2000000000000, i64 80000000000)
  ret ptr %call
}

define noalias ptr @op_new_nonconstant_size(i64 %n) {
; CHECK-LABEL: @op_new_nonconstant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @_Znam(i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call ptr @_Znam(i64 %n)
  ret ptr %call
}

define noalias ptr @op_new_constant_size() {
; CHECK-LABEL: @op_new_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call dereferenceable(40) ptr @_Znam(i64 40)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call ptr @_Znam(i64 40)
  ret ptr %call
}

define noalias ptr @op_new_constant_size2() {
; CHECK-LABEL: @op_new_constant_size2(
; CHECK-NEXT:    [[CALL:%.*]] = tail call dereferenceable(40) ptr @_Znwm(i64 40)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call ptr @_Znwm(i64 40)
  ret ptr %call
}

define noalias ptr @op_new_constant_zero_size() {
; CHECK-LABEL: @op_new_constant_zero_size(
; CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @_Znam(i64 0)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call ptr @_Znam(i64 0)
  ret ptr %call
}

define noalias ptr @strdup_constant_str() {
; CHECK-LABEL: @strdup_constant_str(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(6) ptr @strdup(ptr nonnull @.str)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @strdup(ptr @.str)
  ret ptr %call
}

define noalias ptr @strdup_notconstant_str(ptr %str) {
; CHECK-LABEL: @strdup_notconstant_str(
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @strdup(ptr [[STR:%.*]])
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call noalias ptr @strdup(ptr %str)
  ret ptr %call
}

; OSS-Fuzz #23214
; https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23214
define noalias ptr @ossfuzz_23214() {
; CHECK-LABEL: @ossfuzz_23214(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias dereferenceable_or_null(512) ptr @aligned_alloc(i64 -9223372036854775808, i64 512)
; CHECK-NEXT:    ret ptr [[CALL]]
;
bb:
  %and = and i64 -1, -9223372036854775808
  %call = tail call noalias ptr @aligned_alloc(i64 %and, i64 512)
  ret ptr %call
}

define noalias ptr @op_new_align() {
; CHECK-LABEL: @op_new_align(
; CHECK-NEXT:    [[CALL:%.*]] = tail call align 32 dereferenceable_or_null(32) ptr @_ZnamSt11align_val_t(i64 32, i64 32)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = tail call ptr @_ZnamSt11align_val_t(i64 32, i64 32)
  ret ptr %call
}

define ptr @my_malloc_constant_size() {
; CHECK-LABEL: @my_malloc_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = call dereferenceable_or_null(32) ptr @my_malloc(i64 32)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = call ptr @my_malloc(i64 32)
  ret ptr %call
}

define ptr @my_calloc_constant_size() {
; CHECK-LABEL: @my_calloc_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = call dereferenceable_or_null(128) ptr @my_calloc(i64 32, i64 4)
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = call ptr @my_calloc(i64 32, i64 4)
  ret ptr %call
}

define ptr @virtual_constant_size(ptr %alloc) {
; CHECK-LABEL: @virtual_constant_size(
; CHECK-NEXT:    [[CALL:%.*]] = call dereferenceable_or_null(16) ptr [[ALLOC:%.*]](i64 16) #[[ATTR5:[0-9]+]]
; CHECK-NEXT:    ret ptr [[CALL]]
;
  %call = call ptr %alloc(i64 16) allocsize(0)
  ret ptr %call
}

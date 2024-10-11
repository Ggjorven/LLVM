; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Verifies that we insert spills of PHI instruction _after) all PHI Nodes
; RUN: opt < %s -passes='cgscc(coro-split),simplifycfg,early-cse,simplifycfg' -S | FileCheck %s

; Verifies that the both phis are stored correctly in the coroutine frame
; CHECK: %f.Frame = type { ptr, ptr, i32, i32, i1 }

define ptr @f(i1 %n) presplitcoroutine {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ID:%.*]] = call token @llvm.coro.id(i32 0, ptr null, ptr null, ptr @f.resumers)
; CHECK-NEXT:    [[ALLOC:%.*]] = call ptr @malloc(i32 32)
; CHECK-NEXT:    [[HDL:%.*]] = call noalias nonnull ptr @llvm.coro.begin(token [[ID]], ptr [[ALLOC]])
; CHECK-NEXT:    store ptr @f.resume, ptr [[HDL]], align 8
; CHECK-NEXT:    [[DESTROY_ADDR:%.*]] = getelementptr inbounds nuw [[F_FRAME:%.*]], ptr [[HDL]], i32 0, i32 1
; CHECK-NEXT:    store ptr @f.destroy, ptr [[DESTROY_ADDR]], align 8
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[N:%.*]], i32 0, i32 2
; CHECK-NEXT:    [[SPEC_SELECT5:%.*]] = select i1 [[N]], i32 1, i32 3
; CHECK-NEXT:    [[PHI2_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], ptr [[HDL]], i32 0, i32 3
; CHECK-NEXT:    store i32 [[SPEC_SELECT5]], ptr [[PHI2_SPILL_ADDR]], align 4
; CHECK-NEXT:    [[PHI1_SPILL_ADDR:%.*]] = getelementptr inbounds [[F_FRAME]], ptr [[HDL]], i32 0, i32 2
; CHECK-NEXT:    store i32 [[SPEC_SELECT]], ptr [[PHI1_SPILL_ADDR]], align 4
; CHECK-NEXT:    [[INDEX_ADDR4:%.*]] = getelementptr inbounds nuw [[F_FRAME]], ptr [[HDL]], i32 0, i32 4
; CHECK-NEXT:    store i1 false, ptr [[INDEX_ADDR4]], align 1
; CHECK-NEXT:    ret ptr [[HDL]]
;
entry:
  %id = call token @llvm.coro.id(i32 0, ptr null, ptr null, ptr null)
  %size = call i32 @llvm.coro.size.i32()
  %alloc = call ptr @malloc(i32 %size)
  %hdl = call ptr @llvm.coro.begin(token %id, ptr %alloc)
  br i1 %n, label %begin, label %alt
alt:
  br label %begin

begin:
  %phi1 = phi i32 [ 0, %entry ], [ 2, %alt ]
  %phi2 = phi i32 [ 1, %entry ], [ 3, %alt ]

  %sp1 = call i8 @llvm.coro.suspend(token none, i1 false)
  switch i8 %sp1, label %suspend [i8 0, label %resume
  i8 1, label %cleanup]
resume:
  call i32 @print(i32 %phi1)
  call i32 @print(i32 %phi2)
  br label %cleanup

cleanup:
  %mem = call ptr @llvm.coro.free(token %id, ptr %hdl)
  call void @free(ptr %mem)
  br label %suspend
suspend:
  call i1 @llvm.coro.end(ptr %hdl, i1 0, token none)
  ret ptr %hdl
}

declare ptr @llvm.coro.free(token, ptr)
declare i32 @llvm.coro.size.i32()
declare i8  @llvm.coro.suspend(token, i1)
declare void @llvm.coro.resume(ptr)
declare void @llvm.coro.destroy(ptr)

declare token @llvm.coro.id(i32, ptr, ptr, ptr)
declare i1 @llvm.coro.alloc(token)
declare ptr @llvm.coro.begin(token, ptr)
declare i1 @llvm.coro.end(ptr, i1, token)

declare noalias ptr @malloc(i32)
declare i32 @print(i32)
declare void @free(ptr)

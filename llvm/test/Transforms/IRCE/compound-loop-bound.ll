; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=irce < %s -S | FileCheck %s

; if (K > 0 && M > 0)
;   for (i = 0; i < min(K, M); i++) {...}
;
; TODO: Loop bounds are safe according to loop guards. IRCE is allowed.
define void @incrementing_loop(ptr %arr, ptr %len_ptr, i32 %K, i32 %M) {
; CHECK-LABEL: define void @incrementing_loop(
; CHECK-SAME: ptr [[ARR:%.*]], ptr [[LEN_PTR:%.*]], i32 [[K:%.*]], i32 [[M:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR]], align 4, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[CHECK0:%.*]] = icmp sgt i32 [[K]], 0
; CHECK-NEXT:    [[CHECK1:%.*]] = icmp sgt i32 [[M]], 0
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[CHECK0]], [[CHECK1]]
; CHECK-NEXT:    br i1 [[AND]], label [[PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[SMIN:%.*]] = call i32 @llvm.smin.i32(i32 [[K]], i32 [[M]])
; CHECK-NEXT:    [[SMIN1:%.*]] = call i32 @llvm.smin.i32(i32 [[LEN]], i32 [[M]])
; CHECK-NEXT:    [[SMIN2:%.*]] = call i32 @llvm.smin.i32(i32 [[SMIN1]], i32 [[K]])
; CHECK-NEXT:    [[EXIT_MAINLOOP_AT:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN2]], i32 0)
; CHECK-NEXT:    [[TMP0:%.*]] = icmp slt i32 0, [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP0]], label [[LOOP_PREHEADER:%.*]], label [[MAIN_PSEUDO_EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_NEXT:%.*]], [[IN_BOUNDS:%.*]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IDX_NEXT]] = add nsw i32 [[IDX]], 1
; CHECK-NEXT:    [[GUARD:%.*]] = icmp slt i32 [[IDX]], [[LEN]]
; CHECK-NEXT:    br i1 true, label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS_LOOPEXIT3:%.*]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp slt i32 [[IDX_NEXT]], [[SMIN]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[IDX_NEXT]], [[EXIT_MAINLOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP1]], label [[LOOP]], label [[MAIN_EXIT_SELECTOR:%.*]]
; CHECK:       main.exit.selector:
; CHECK-NEXT:    [[IDX_NEXT_LCSSA:%.*]] = phi i32 [ [[IDX_NEXT]], [[IN_BOUNDS]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[IDX_NEXT_LCSSA]], [[SMIN]]
; CHECK-NEXT:    br i1 [[TMP2]], label [[MAIN_PSEUDO_EXIT]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       main.pseudo.exit:
; CHECK-NEXT:    [[IDX_COPY:%.*]] = phi i32 [ 0, [[PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    [[INDVAR_END:%.*]] = phi i32 [ 0, [[PREHEADER]] ], [ [[IDX_NEXT_LCSSA]], [[MAIN_EXIT_SELECTOR]] ]
; CHECK-NEXT:    br label [[POSTLOOP:%.*]]
; CHECK:       out.of.bounds.loopexit:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS:%.*]]
; CHECK:       out.of.bounds.loopexit3:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit.loopexit:
; CHECK-NEXT:    br label [[EXIT_LOOPEXIT]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       postloop:
; CHECK-NEXT:    br label [[LOOP_POSTLOOP:%.*]]
; CHECK:       loop.postloop:
; CHECK-NEXT:    [[IDX_POSTLOOP:%.*]] = phi i32 [ [[IDX_COPY]], [[POSTLOOP]] ], [ [[IDX_NEXT_POSTLOOP:%.*]], [[IN_BOUNDS_POSTLOOP:%.*]] ]
; CHECK-NEXT:    [[IDX_NEXT_POSTLOOP]] = add i32 [[IDX_POSTLOOP]], 1
; CHECK-NEXT:    [[GUARD_POSTLOOP:%.*]] = icmp slt i32 [[IDX_POSTLOOP]], [[LEN]]
; CHECK-NEXT:    br i1 [[GUARD_POSTLOOP]], label [[IN_BOUNDS_POSTLOOP]], label [[OUT_OF_BOUNDS_LOOPEXIT:%.*]]
; CHECK:       in.bounds.postloop:
; CHECK-NEXT:    [[ADDR_POSTLOOP:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX_POSTLOOP]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR_POSTLOOP]], align 4
; CHECK-NEXT:    [[NEXT_POSTLOOP:%.*]] = icmp slt i32 [[IDX_NEXT_POSTLOOP]], [[SMIN]]
; CHECK-NEXT:    br i1 [[NEXT_POSTLOOP]], label [[LOOP_POSTLOOP]], label [[EXIT_LOOPEXIT_LOOPEXIT:%.*]], !llvm.loop [[LOOP1:![0-9]+]], !loop_constrainer.loop.clone !6
;
entry:
  %len = load i32, ptr %len_ptr, !range !0
  %check0 = icmp sgt i32 %K, 0
  %check1 = icmp sgt i32 %M, 0
  %and = and i1 %check0, %check1
  br i1 %and, label %preheader, label %exit

preheader:
  %smin = call i32 @llvm.smin.i32(i32 %K, i32 %M)
  br label %loop

loop:
  %idx = phi i32 [ 0, %preheader ], [ %idx.next, %in.bounds ]
  %idx.next = add i32 %idx, 1
  %guard = icmp slt i32 %idx, %len
  br i1 %guard, label %in.bounds, label %out.of.bounds

in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp slt i32 %idx.next, %smin
  br i1 %next, label %loop, label %exit

out.of.bounds:
  ret void

exit:
  ret void
}

; if (K > 0 && M > 0)
;   for (i = min(K, M); i >= 0; i--) {...}
;
; TODO: Loop bounds are safe according to loop guards. IRCE is allowed.
define void @decrementing_loop(ptr %arr, ptr %len_ptr, i32 %K, i32 %M) {
; CHECK-LABEL: define void @decrementing_loop(
; CHECK-SAME: ptr [[ARR:%.*]], ptr [[LEN_PTR:%.*]], i32 [[K:%.*]], i32 [[M:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[CHECK0:%.*]] = icmp sgt i32 [[K]], 0
; CHECK-NEXT:    [[CHECK1:%.*]] = icmp sgt i32 [[M]], 0
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[CHECK0]], [[CHECK1]]
; CHECK-NEXT:    br i1 [[AND]], label [[PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[INDVAR_START:%.*]] = call i32 @llvm.smin.i32(i32 [[K]], i32 [[M]])
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDVAR_START]], 1
; CHECK-NEXT:    [[SMIN:%.*]] = call i32 @llvm.smin.i32(i32 [[LEN]], i32 [[TMP0]])
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[SMIN]], i32 0)
; CHECK-NEXT:    [[EXIT_PRELOOP_AT:%.*]] = add nsw i32 [[SMAX]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i32 [[INDVAR_START]], [[EXIT_PRELOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP1]], label [[LOOP_PRELOOP_PREHEADER:%.*]], label [[PRELOOP_PSEUDO_EXIT:%.*]]
; CHECK:       loop.preloop.preheader:
; CHECK-NEXT:    br label [[LOOP_PRELOOP:%.*]]
; CHECK:       mainloop:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_PRELOOP_COPY:%.*]], [[MAINLOOP:%.*]] ], [ [[IDX_DEC:%.*]], [[IN_BOUNDS:%.*]] ]
; CHECK-NEXT:    [[IDX_DEC]] = sub nsw i32 [[IDX]], 1
; CHECK-NEXT:    [[GUARD:%.*]] = icmp slt i32 [[IDX]], [[LEN]]
; CHECK-NEXT:    br i1 true, label [[IN_BOUNDS]], label [[OUT_OF_BOUNDS_LOOPEXIT1:%.*]]
; CHECK:       in.bounds:
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[NEXT:%.*]] = icmp sgt i32 [[IDX_DEC]], -1
; CHECK-NEXT:    br i1 [[NEXT]], label [[LOOP]], label [[EXIT_LOOPEXIT_LOOPEXIT:%.*]]
; CHECK:       out.of.bounds.loopexit:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS:%.*]]
; CHECK:       out.of.bounds.loopexit1:
; CHECK-NEXT:    br label [[OUT_OF_BOUNDS]]
; CHECK:       out.of.bounds:
; CHECK-NEXT:    ret void
; CHECK:       exit.loopexit.loopexit:
; CHECK-NEXT:    br label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       loop.preloop:
; CHECK-NEXT:    [[IDX_PRELOOP:%.*]] = phi i32 [ [[IDX_DEC_PRELOOP:%.*]], [[IN_BOUNDS_PRELOOP:%.*]] ], [ [[INDVAR_START]], [[LOOP_PRELOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IDX_DEC_PRELOOP]] = sub i32 [[IDX_PRELOOP]], 1
; CHECK-NEXT:    [[GUARD_PRELOOP:%.*]] = icmp slt i32 [[IDX_PRELOOP]], [[LEN]]
; CHECK-NEXT:    br i1 [[GUARD_PRELOOP]], label [[IN_BOUNDS_PRELOOP]], label [[OUT_OF_BOUNDS_LOOPEXIT:%.*]]
; CHECK:       in.bounds.preloop:
; CHECK-NEXT:    [[ADDR_PRELOOP:%.*]] = getelementptr i32, ptr [[ARR]], i32 [[IDX_PRELOOP]]
; CHECK-NEXT:    store i32 0, ptr [[ADDR_PRELOOP]], align 4
; CHECK-NEXT:    [[NEXT_PRELOOP:%.*]] = icmp sgt i32 [[IDX_DEC_PRELOOP]], -1
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[IDX_DEC_PRELOOP]], [[EXIT_PRELOOP_AT]]
; CHECK-NEXT:    br i1 [[TMP2]], label [[LOOP_PRELOOP]], label [[PRELOOP_EXIT_SELECTOR:%.*]], !llvm.loop [[LOOP7:![0-9]+]], !loop_constrainer.loop.clone !6
; CHECK:       preloop.exit.selector:
; CHECK-NEXT:    [[IDX_DEC_PRELOOP_LCSSA:%.*]] = phi i32 [ [[IDX_DEC_PRELOOP]], [[IN_BOUNDS_PRELOOP]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[IDX_DEC_PRELOOP_LCSSA]], -1
; CHECK-NEXT:    br i1 [[TMP3]], label [[PRELOOP_PSEUDO_EXIT]], label [[EXIT_LOOPEXIT]]
; CHECK:       preloop.pseudo.exit:
; CHECK-NEXT:    [[IDX_PRELOOP_COPY]] = phi i32 [ [[INDVAR_START]], [[PREHEADER]] ], [ [[IDX_DEC_PRELOOP_LCSSA]], [[PRELOOP_EXIT_SELECTOR]] ]
; CHECK-NEXT:    [[INDVAR_END:%.*]] = phi i32 [ [[INDVAR_START]], [[PREHEADER]] ], [ [[IDX_DEC_PRELOOP_LCSSA]], [[PRELOOP_EXIT_SELECTOR]] ]
; CHECK-NEXT:    br label [[MAINLOOP]]
;
  entry:
  %len = load i32, ptr %len_ptr, !range !0
  %check0 = icmp sgt i32 %K, 0
  %check1 = icmp sgt i32 %M, 0
  %and = and i1 %check0, %check1
  br i1 %and, label %preheader, label %exit

  preheader:
  %smin = call i32 @llvm.smin.i32(i32 %K, i32 %M)
  br label %loop

  loop:
  %idx = phi i32 [ %smin, %preheader ] , [ %idx.dec, %in.bounds ]
  %idx.dec = sub i32 %idx, 1
  %guard = icmp slt i32 %idx, %len
  br i1 %guard, label %in.bounds, label %out.of.bounds

  in.bounds:
  %addr = getelementptr i32, ptr %arr, i32 %idx
  store i32 0, ptr %addr
  %next = icmp sgt i32 %idx.dec, -1
  br i1 %next, label %loop, label %exit

  out.of.bounds:
  ret void

  exit:
  ret void
}

declare i32 @llvm.smin.i32(i32, i32)

!0 = !{i32 0, i32 2147483647}

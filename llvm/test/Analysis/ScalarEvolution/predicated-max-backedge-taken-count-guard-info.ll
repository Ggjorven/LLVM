; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes='print<scalar-evolution>' -scalar-evolution-classify-expressions=0 -disable-output %s 2>&1 | FileCheck %s

define i32 @ptr_induction_ult(ptr %a, ptr %b) {
; CHECK-LABEL: 'ptr_induction_ult'
; CHECK-NEXT:  Determining loop execution counts for: @ptr_induction_ult
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (((-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) /u 4)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i2 ((trunc i64 (ptrtoint ptr %b to i64) to i2) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i2))) to i64) == 0
; CHECK-NEXT:  Loop %loop: Predicated constant max backedge-taken count is i64 4611686018427387903
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i2 ((trunc i64 (ptrtoint ptr %b to i64) to i2) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i2))) to i64) == 0
; CHECK-NEXT:  Loop %loop: Predicated symbolic max backedge-taken count is (((-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) /u 4)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i2 ((trunc i64 (ptrtoint ptr %b to i64) to i2) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i2))) to i64) == 0
;
entry:
  %cmp.6 = icmp ult ptr %a, %b
  br i1 %cmp.6, label %loop, label %exit

loop:
  %ptr.iv = phi ptr [ %ptr.iv.next, %loop ], [ %a, %entry ]
  %ptr.iv.next = getelementptr i32, ptr %ptr.iv, i64 1
  %exitcond = icmp eq ptr %ptr.iv, %b
  br i1 %exitcond, label %exit, label %loop

exit:
  ret i32 0
}

define i32 @ptr_induction_ult_3_step_6(ptr %a, ptr %b) {
; CHECK-LABEL: 'ptr_induction_ult_3_step_6'
; CHECK-NEXT:  Determining loop execution counts for: @ptr_induction_ult_3_step_6
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (((3074457345618258603 * (ptrtoint ptr %b to i64)) + (-3074457345618258603 * (ptrtoint ptr %a to i64))) /u 2)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i1 (trunc i64 ((-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) to i1) to i64) == 0
; CHECK-NEXT:  Loop %loop: Predicated constant max backedge-taken count is i64 9223372036854775807
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i1 (trunc i64 ((-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) to i1) to i64) == 0
; CHECK-NEXT:  Loop %loop: Predicated symbolic max backedge-taken count is (((3074457345618258603 * (ptrtoint ptr %b to i64)) + (-3074457345618258603 * (ptrtoint ptr %a to i64))) /u 2)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i1 (trunc i64 ((-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) to i1) to i64) == 0
;
entry:
  %cmp.6 = icmp ult ptr %a, %b
  br i1 %cmp.6, label %loop, label %exit

loop:
  %ptr.iv = phi ptr [ %ptr.iv.next, %loop ], [ %a, %entry ]
  %ptr.iv.next = getelementptr i8, ptr %ptr.iv, i64 6
  %exitcond = icmp eq ptr %ptr.iv, %b
  br i1 %exitcond, label %exit, label %loop

exit:
  ret i32 0
}

define i32 @ptr_induction_ult_3_step_7(ptr %a, ptr %b) {
; CHECK-LABEL: 'ptr_induction_ult_3_step_7'
; CHECK-NEXT:  Determining loop execution counts for: @ptr_induction_ult_3_step_7
; CHECK-NEXT:  Loop %loop: backedge-taken count is ((7905747460161236407 * (ptrtoint ptr %b to i64)) + (-7905747460161236407 * (ptrtoint ptr %a to i64)))
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is i64 -1
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is ((7905747460161236407 * (ptrtoint ptr %b to i64)) + (-7905747460161236407 * (ptrtoint ptr %a to i64)))
; CHECK-NEXT:  Loop %loop: Trip multiple is 1
;
entry:
  %cmp.6 = icmp ult ptr %a, %b
  br i1 %cmp.6, label %loop, label %exit

loop:
  %ptr.iv = phi ptr [ %ptr.iv.next, %loop ], [ %a, %entry ]
  %ptr.iv.next = getelementptr i8, ptr %ptr.iv, i64 7
  %exitcond = icmp eq ptr %ptr.iv, %b
  br i1 %exitcond, label %exit, label %loop

exit:
  ret i32 0
}

; %a and %b may not have the same alignment, so the loop may only via the early
; exit when %ptr.iv > %b. The predicated exit count for the latch can be
; computed by adding a predicate.
define void @ptr_induction_early_exit_eq_1(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: 'ptr_induction_early_exit_eq_1'
; CHECK-NEXT:  Determining loop execution counts for: @ptr_induction_early_exit_eq_1
; CHECK-NEXT:  Loop %loop: <multiple exits> Unpredictable backedge-taken count.
; CHECK-NEXT:    exit count for loop: ***COULDNOTCOMPUTE***
; CHECK-NEXT:    exit count for loop.inc: ***COULDNOTCOMPUTE***
; CHECK-NEXT:    predicated exit count for loop.inc: ((-8 + (-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) /u 8)
; CHECK-NEXT:     Predicates:
; CHECK-NEXT:      Equal predicate: (zext i3 ((trunc i64 (ptrtoint ptr %b to i64) to i3) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i3))) to i64) == 0
; CHECK-EMPTY:
; CHECK-NEXT:  Loop %loop: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:    symbolic max exit count for loop: ***COULDNOTCOMPUTE***
; CHECK-NEXT:    symbolic max exit count for loop.inc: ***COULDNOTCOMPUTE***
; CHECK-NEXT:    predicated symbolic max exit count for loop.inc: ((-8 + (-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) /u 8)
; CHECK-NEXT:     Predicates:
; CHECK-NEXT:      Equal predicate: (zext i3 ((trunc i64 (ptrtoint ptr %b to i64) to i3) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i3))) to i64) == 0
; CHECK-EMPTY:
; CHECK-NEXT:  Loop %loop: Predicated constant max backedge-taken count is i64 2305843009213693951
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i3 ((trunc i64 (ptrtoint ptr %b to i64) to i3) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i3))) to i64) == 0
; CHECK-NEXT:  Loop %loop: Predicated symbolic max backedge-taken count is ((-8 + (-1 * (ptrtoint ptr %a to i64)) + (ptrtoint ptr %b to i64)) /u 8)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      Equal predicate: (zext i3 ((trunc i64 (ptrtoint ptr %b to i64) to i3) + (-1 * (trunc i64 (ptrtoint ptr %a to i64) to i3))) to i64) == 0
;
entry:
  %cmp = icmp eq ptr %a, %b
  br i1 %cmp, label %exit, label %loop

loop:
  %ptr.iv = phi ptr [ %ptr.iv.next, %loop.inc ], [ %a, %entry ]
  %ld1 = load ptr, ptr %ptr.iv, align 8
  %earlyexitcond = icmp eq ptr %ld1, %c
  br i1 %earlyexitcond, label %exit, label %loop.inc

loop.inc:
  %ptr.iv.next = getelementptr inbounds i8, ptr %ptr.iv, i64 8
  %exitcond = icmp eq ptr %ptr.iv.next, %b
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}



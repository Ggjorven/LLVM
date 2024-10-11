; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -verify-machineinstrs -mcpu=pwr7 -ppc-gep-opt=0 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mcpu=pwr7 -mattr=-isel -ppc-gep-opt=0 < %s | FileCheck --check-prefix=CHECK-NO-ISEL %s
target datalayout = "E-m:e-i64:64-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

; Function Attrs: nounwind
define void @jbd2_journal_commit_transaction(i32 %input1, ptr %input2, ptr %input3, ptr %input4) #0 {
; CHECK-LABEL: jbd2_journal_commit_transaction:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi 7, 3, 1
; CHECK-NEXT:    cmplwi 1, 3, 0
; CHECK-NEXT:    li 8, -5
; CHECK-NEXT:    lis 9, 4
; CHECK-NEXT:    cmpld 6, 4, 5
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_1: # %while.body392
; CHECK-NEXT:    #
; CHECK-NEXT:    bne- 1, .LBB0_4
; CHECK-NEXT:  # %bb.2: # %wait_on_buffer.exit1319
; CHECK-NEXT:    #
; CHECK-NEXT:    ld 4, 0(6)
; CHECK-NEXT:    mr 5, 4
; CHECK-NEXT:    ldu 10, -72(5)
; CHECK-NEXT:    andi. 10, 10, 1
; CHECK-NEXT:    crmove 20, 1
; CHECK-NEXT:    #APP
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    .long 2101356712
; CHECK-NEXT:    andc 10, 10, 9
; CHECK-NEXT:    stdcx. 10, 0, 5
; CHECK-NEXT:    bne- 0, .Ltmp0
; CHECK-EMPTY:
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    std 4, 0(6)
; CHECK-NEXT:    bne+ 6, .LBB0_1
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    isel 7, 3, 8, 20
; CHECK-NEXT:  .LBB0_4: # %while.end418
; CHECK-NEXT:    cmplwi 7, 0
; CHECK-NEXT:    beq 0, .LBB0_6
; CHECK-NEXT:  # %bb.5: # %if.then420
; CHECK-NEXT:  .LBB0_6: # %if.end421
;
; CHECK-NO-ISEL-LABEL: jbd2_journal_commit_transaction:
; CHECK-NO-ISEL:       # %bb.0: # %entry
; CHECK-NO-ISEL-NEXT:    addi 7, 3, 1
; CHECK-NO-ISEL-NEXT:    cmplwi 1, 3, 0
; CHECK-NO-ISEL-NEXT:    lis 8, 4
; CHECK-NO-ISEL-NEXT:    cmpld 5, 4, 5
; CHECK-NO-ISEL-NEXT:    b .LBB0_2
; CHECK-NO-ISEL-NEXT:    .p2align 4
; CHECK-NO-ISEL-NEXT:  .LBB0_1: # %wait_on_buffer.exit1319
; CHECK-NO-ISEL-NEXT:    #
; CHECK-NO-ISEL-NEXT:    #APP
; CHECK-NO-ISEL-NEXT:  .Ltmp0:
; CHECK-NO-ISEL-NEXT:    .long 2101364904
; CHECK-NO-ISEL-NEXT:    andc 10, 10, 8
; CHECK-NO-ISEL-NEXT:    stdcx. 10, 0, 9
; CHECK-NO-ISEL-NEXT:    bne- 0, .Ltmp0
; CHECK-NO-ISEL-EMPTY:
; CHECK-NO-ISEL-NEXT:    #NO_APP
; CHECK-NO-ISEL-NEXT:    std 5, 0(6)
; CHECK-NO-ISEL-NEXT:    beq- 5, .LBB0_6
; CHECK-NO-ISEL-NEXT:  .LBB0_2: # %while.body392
; CHECK-NO-ISEL-NEXT:    #
; CHECK-NO-ISEL-NEXT:    bne- 1, .LBB0_5
; CHECK-NO-ISEL-NEXT:  # %bb.3: # %wait_on_buffer.exit1319
; CHECK-NO-ISEL-NEXT:    #
; CHECK-NO-ISEL-NEXT:    ld 5, 0(6)
; CHECK-NO-ISEL-NEXT:    mr 9, 5
; CHECK-NO-ISEL-NEXT:    ldu 4, -72(9)
; CHECK-NO-ISEL-NEXT:    andi. 4, 4, 1
; CHECK-NO-ISEL-NEXT:    mr 4, 3
; CHECK-NO-ISEL-NEXT:    bc 12, 1, .LBB0_1
; CHECK-NO-ISEL-NEXT:  # %bb.4: # %wait_on_buffer.exit1319
; CHECK-NO-ISEL-NEXT:    #
; CHECK-NO-ISEL-NEXT:    li 4, -5
; CHECK-NO-ISEL-NEXT:    b .LBB0_1
; CHECK-NO-ISEL-NEXT:  .LBB0_5:
; CHECK-NO-ISEL-NEXT:    mr 4, 7
; CHECK-NO-ISEL-NEXT:  .LBB0_6: # %while.end418
; CHECK-NO-ISEL-NEXT:    cmplwi 4, 0
; CHECK-NO-ISEL-NEXT:    beq 0, .LBB0_8
; CHECK-NO-ISEL-NEXT:  # %bb.7: # %if.then420
; CHECK-NO-ISEL-NEXT:  .LBB0_8: # %if.end421
entry:
  br label %while.body392

while.body392:                                    ; preds = %wait_on_buffer.exit1319, %while.body392.lr.ph
  %0 = load ptr, ptr %input4, align 8
  %add.ptr399 = getelementptr inbounds i8, ptr %0, i64 -72
  %ivar = add i32 %input1, 1
  %tobool.i1316 = icmp eq i32 %input1, 0
  br i1 %tobool.i1316, label %wait_on_buffer.exit1319, label %while.end418

wait_on_buffer.exit1319:                          ; preds = %while.body392
  %1 = load volatile i64, ptr %add.ptr399, align 8
  %conv.i.i1322 = and i64 %1, 1
  %lnot404 = icmp eq i64 %conv.i.i1322, 0
  %.err.4 = select i1 %lnot404, i32 -5, i32 %input1
  %2 = call i64 asm sideeffect "1:.long 0x7c0000a8 $| ((($0) & 0x1f) << 21) $| (((0) & 0x1f) << 16) $| ((($3) & 0x1f) << 11) $| (((0) & 0x1) << 0) \0Aandc $0,$0,$2\0Astdcx. $0,0,$3\0Abne- 1b\0A", "=&r,=*m,r,r,*m,~{cc},~{memory}"(ptr elementtype(i64) %add.ptr399, i64 262144, ptr %add.ptr399, ptr elementtype(i64) %add.ptr399) #0
  store ptr %0, ptr %input4, align 8
  %cmp.i1312 = icmp eq ptr %input2, %input3
  br i1 %cmp.i1312, label %while.end418, label %while.body392

while.end418:                                     ; preds = %wait_on_buffer.exit1319, %do.body378
  %err.4.lcssa = phi i32 [ %ivar, %while.body392 ], [ %.err.4, %wait_on_buffer.exit1319 ]
  %tobool419 = icmp eq i32 %err.4.lcssa, 0
  br i1 %tobool419, label %if.end421, label %if.then420


if.then420:                                       ; preds = %while.end418
  unreachable

if.end421:                                        ; preds = %while.end418
  unreachable

}

attributes #0 = { nounwind }


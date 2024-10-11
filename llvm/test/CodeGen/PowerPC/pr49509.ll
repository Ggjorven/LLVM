; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc-unknown-linux-gnu < %s | FileCheck %s

target datalayout = "E-m:e-p:32:32-i64:64-n32"

define void @test() {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    bc 12, 20, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %bb2
; CHECK-NEXT:    li 3, 0
; CHECK-NEXT:    stw 3, 0(3)
; CHECK-NEXT:    lis 3, 256
; CHECK-NEXT:    stw 3, 0(3)
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB0_2: # %bb1
; CHECK-NEXT:    bclr 4, 20, 0
; CHECK-NEXT:  # %bb.3: # %bb66
; CHECK-NEXT:    lwz 4, 12(0)
; CHECK-NEXT:    lwz 5, 8(0)
; CHECK-NEXT:    lwz 6, 0(0)
; CHECK-NEXT:    lwz 7, 4(0)
; CHECK-NEXT:    lbz 3, 0(3)
; CHECK-NEXT:    and 5, 5, 6
; CHECK-NEXT:    and 4, 4, 7
; CHECK-NEXT:    and 5, 4, 5
; CHECK-NEXT:    cmpwi 3, 0
; CHECK-NEXT:    li 3, 0
; CHECK-NEXT:    cmpwi 1, 5, -1
; CHECK-NEXT:    li 4, 0
; CHECK-NEXT:    bc 12, 2, .LBB0_5
; CHECK-NEXT:  # %bb.4: # %bb66
; CHECK-NEXT:    lis 4, 256
; CHECK-NEXT:  .LBB0_5: # %bb66
; CHECK-NEXT:    cmpwi 5, 5, -1
; CHECK-NEXT:    lis 5, 512
; CHECK-NEXT:    beq 5, .LBB0_7
; CHECK-NEXT:  # %bb.6: # %bb66
; CHECK-NEXT:    mr 5, 4
; CHECK-NEXT:  .LBB0_7: # %bb66
; CHECK-NEXT:    cror 20, 6, 2
; CHECK-NEXT:    stw 5, 0(3)
; CHECK-NEXT:    stw 3, 0(3)
; CHECK-NEXT:    blr
bb:
  br i1 undef, label %bb2, label %bb1

bb2:                                              ; preds = %bb
  %i = select i1 undef, i64 0, i64 72057594037927936
  store i64 %i, ptr undef, align 8
  ret void

bb1:                                              ; preds = %bb
  %i50 = load i8, ptr undef, align 8
  %i52 = load i128, ptr null, align 8
  %i62 = icmp eq i8 %i50, 0
  br i1 undef, label %bb66, label %bb64

bb64:                                             ; preds = %bb63
  ret void

bb66:                                             ; preds = %bb63
  %i67 = lshr i128 -1, 0
  %i68 = xor i128 %i52, -1
  %i69 = add i128 0, %i68
  %i70 = and i128 %i67, %i69
  %i71 = icmp eq i128 %i70, 0
  %i74 = select i1 %i62, i64 0, i64 72057594037927936
  %i75 = select i1 %i71, i64 144115188075855872, i64 %i74
  store i64 %i75, ptr undef, align 8
  ret void
}

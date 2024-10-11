; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -switch-range-to-icmp -S | FileCheck %s

; Check that simplifycfg deletes a dead 'seteq' instruction when it
; folds a conditional branch into a switch instruction.

declare void @foo()

declare void @bar()

define void @testcfg(i32 %V) {
; CHECK-LABEL: @testcfg(
; CHECK-NEXT:    [[V_OFF:%.*]] = add i32 [[V:%.*]], -15
; CHECK-NEXT:    [[SWITCH:%.*]] = icmp ult i32 [[V_OFF]], 2
; CHECK-NEXT:    br i1 [[SWITCH]], label [[L2:%.*]], label [[L1:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    ret void
; CHECK:       L1:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[COMMON_RET:%.*]]
; CHECK:       L2:
; CHECK-NEXT:    call void @bar()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
  %C = icmp eq i32 %V, 18
  %D = icmp eq i32 %V, 180
  %E = or i1 %C, %D
  br i1 %E, label %L1, label %Sw
Sw:             ; preds = %0
  switch i32 %V, label %L1 [
  i32 15, label %L2
  i32 16, label %L2
  ]
L1:             ; preds = %Sw, %0
  call void @foo( )
  ret void
L2:             ; preds = %Sw, %Sw
  call void @bar( )
  ret void
}


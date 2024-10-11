; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=newgvn -S | FileCheck %s

define i32 @main(ptr %p, i32 %x, i32 %y) {
; CHECK-LABEL: @main(
; CHECK-NEXT:  block1:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BLOCK2:%.*]], label [[BLOCK3:%.*]]
; CHECK:       block2:
; CHECK-NEXT:    [[A:%.*]] = load ptr, ptr [[P:%.*]], align 8
; CHECK-NEXT:    br label [[BLOCK4:%.*]]
; CHECK:       block3:
; CHECK-NEXT:    [[B:%.*]] = load ptr, ptr [[P]], align 8
; CHECK-NEXT:    br label [[BLOCK4]]
; CHECK:       block4:
; CHECK-NEXT:    [[EXISTINGPHI:%.*]] = phi ptr [ [[A]], [[BLOCK2]] ], [ [[B]], [[BLOCK3]] ]
; CHECK-NEXT:    [[C:%.*]] = load i32, ptr [[EXISTINGPHI]], align 4
; CHECK-NEXT:    [[E:%.*]] = add i32 [[C]], [[C]]
; CHECK-NEXT:    ret i32 [[E]]
;
block1:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp , label %block2, label %block3

block2:
  %a = load ptr, ptr %p
  br label %block4

block3:
  %b = load ptr, ptr %p
  br label %block4

block4:
  %existingPHI = phi ptr [ %a, %block2 ], [ %b, %block3 ]
  %DEAD = load ptr, ptr %p
  %c = load i32, ptr %DEAD
  %d = load i32, ptr %existingPHI
  %e = add i32 %c, %d
  ret i32 %e
}

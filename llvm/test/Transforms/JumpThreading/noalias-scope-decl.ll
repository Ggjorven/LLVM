; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=jump-threading < %s | FileCheck %s

define void @test(ptr %ptr) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !0)
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[I_INC:%.*]], [[LATCH:%.*]] ]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[I]], 100
; CHECK-NEXT:    br i1 [[C]], label [[EXIT:%.*]], label [[LATCH]]
; CHECK:       latch:
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !3)
; CHECK-NEXT:    store i8 0, ptr [[PTR:%.*]], align 1, !noalias !0
; CHECK-NEXT:    store i8 1, ptr [[PTR]], align 1, !noalias !3
; CHECK-NEXT:    [[I_INC]] = add i32 [[I]], 1
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !5)
; CHECK-NEXT:    store i8 0, ptr [[PTR]], align 1, !noalias !0
; CHECK-NEXT:    store i8 1, ptr [[PTR]], align 1, !noalias !5
; CHECK-NEXT:    ret void
;
entry:
  call void @llvm.experimental.noalias.scope.decl(metadata !0)
  br label %loop

loop:
  %i = phi i32 [ 0, %entry ], [ %i.inc, %latch ]
  %c = icmp eq i32 %i, 100
  br i1 %c, label %if, label %latch

if:
  br label %latch

latch:
  %p = phi i1 [ true, %if ], [ false, %loop ]
  call void @llvm.experimental.noalias.scope.decl(metadata !3)
  store i8 0, ptr %ptr, !noalias !0
  store i8 1, ptr %ptr, !noalias !3
  %i.inc = add i32 %i, 1
  br i1 %p, label %exit, label %loop

exit:
  ret void
}

declare void @llvm.experimental.noalias.scope.decl(metadata)

!0 = !{!1}
!1 = distinct !{!1, !2, !"scope1"}
!2 = distinct !{!2, !"domain"}
!3 = !{!4}
!4 = distinct !{!4, !2, !"scope2"}

; CHECK: !0 = !{!1}
; CHECK: !1 = distinct !{!1, !2, !"scope1"}
; CHECK: !2 = distinct !{!2, !"domain"}
; CHECK: !3 = !{!4}
; CHECK: !4 = distinct !{!4, !2, !"scope2"}
; CHECK: !5 = !{!6}
; CHECK: !6 = distinct !{!6, !2, !"scope2:thread"}

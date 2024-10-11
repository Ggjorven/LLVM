; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 < %s -mtriple=riscv64 -mattr=+v | FileCheck %s

declare i32 @llvm.vector.reduce.add.nxv2i32(<vscale x 2 x i32>)

define i32 @test(ptr %a, i64 %n)  {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li a3, 0
; CHECK-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v8, zero
; CHECK-NEXT:  .LBB0_1: # %loop
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vl1re32.v v9, (a0)
; CHECK-NEXT:    mv a2, a3
; CHECK-NEXT:    vredsum.vs v9, v9, v8
; CHECK-NEXT:    vmv.x.s a3, v9
; CHECK-NEXT:    addw a3, a3, a3
; CHECK-NEXT:    addi a1, a1, -1
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    bnez a1, .LBB0_1
; CHECK-NEXT:  # %bb.2: # %exit
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
entry:
  br label %loop

loop:
  %indvar = phi i64 [ 0, %entry ], [ %indvar.inc, %loop ]
  %sum = phi i32 [ 0, %entry ], [ %sum.inc, %loop ]
  %idx = getelementptr inbounds ptr, ptr %a, i64 %indvar
  %data = load <vscale x 2 x i32>, ptr %idx
  %reduce = tail call i32 @llvm.vector.reduce.add.nxv2i32(<vscale x 2 x i32> %data)
  %sum.inc = add i32 %reduce, %reduce
  %indvar.inc = add i64 %indvar, 1
  %cmp = icmp eq i64 %indvar.inc, %n
  br i1 %cmp, label %exit, label %loop

exit:
  ret i32 %sum
}

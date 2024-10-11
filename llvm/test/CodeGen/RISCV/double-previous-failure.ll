; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -target-abi=ilp32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s
; RUN: llc -mtriple=riscv32 -mattr=+zdinx -target-abi=ilp32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFINXZDINX %s

define double @test(double %a) nounwind {
; RV32IFD-LABEL: test:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    ret
;
; RV32IZFINXZDINX-LABEL: test:
; RV32IZFINXZDINX:       # %bb.0:
; RV32IZFINXZDINX-NEXT:    ret
  ret double %a
}

; This previously failed complaining of multiple vreg defs due to an ABI
; lowering issue.

define i32 @main() nounwind {
; RV32IFD-LABEL: main:
; RV32IFD:       # %bb.0: # %entry
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    lui a1, 262144
; RV32IFD-NEXT:    li a0, 0
; RV32IFD-NEXT:    call test
; RV32IFD-NEXT:    sw a0, 0(sp)
; RV32IFD-NEXT:    sw a1, 4(sp)
; RV32IFD-NEXT:    fld fa5, 0(sp)
; RV32IFD-NEXT:    lui a0, %hi(.LCPI1_0)
; RV32IFD-NEXT:    fld fa4, %lo(.LCPI1_0)(a0)
; RV32IFD-NEXT:    flt.d a0, fa5, fa4
; RV32IFD-NEXT:    bnez a0, .LBB1_3
; RV32IFD-NEXT:  # %bb.1: # %entry
; RV32IFD-NEXT:    lui a0, %hi(.LCPI1_1)
; RV32IFD-NEXT:    fld fa4, %lo(.LCPI1_1)(a0)
; RV32IFD-NEXT:    flt.d a0, fa4, fa5
; RV32IFD-NEXT:    bnez a0, .LBB1_3
; RV32IFD-NEXT:  # %bb.2: # %if.end
; RV32IFD-NEXT:    call exit
; RV32IFD-NEXT:  .LBB1_3: # %if.then
; RV32IFD-NEXT:    call abort
;
; RV32IZFINXZDINX-LABEL: main:
; RV32IZFINXZDINX:       # %bb.0: # %entry
; RV32IZFINXZDINX-NEXT:    addi sp, sp, -16
; RV32IZFINXZDINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFINXZDINX-NEXT:    lui a1, 262144
; RV32IZFINXZDINX-NEXT:    li a0, 0
; RV32IZFINXZDINX-NEXT:    call test
; RV32IZFINXZDINX-NEXT:    lui a2, %hi(.LCPI1_0)
; RV32IZFINXZDINX-NEXT:    lw a3, %lo(.LCPI1_0+4)(a2)
; RV32IZFINXZDINX-NEXT:    lw a2, %lo(.LCPI1_0)(a2)
; RV32IZFINXZDINX-NEXT:    flt.d a2, a0, a2
; RV32IZFINXZDINX-NEXT:    bnez a2, .LBB1_3
; RV32IZFINXZDINX-NEXT:  # %bb.1: # %entry
; RV32IZFINXZDINX-NEXT:    lui a2, %hi(.LCPI1_1)
; RV32IZFINXZDINX-NEXT:    lw a3, %lo(.LCPI1_1+4)(a2)
; RV32IZFINXZDINX-NEXT:    lw a2, %lo(.LCPI1_1)(a2)
; RV32IZFINXZDINX-NEXT:    flt.d a0, a2, a0
; RV32IZFINXZDINX-NEXT:    bnez a0, .LBB1_3
; RV32IZFINXZDINX-NEXT:  # %bb.2: # %if.end
; RV32IZFINXZDINX-NEXT:    call exit
; RV32IZFINXZDINX-NEXT:  .LBB1_3: # %if.then
; RV32IZFINXZDINX-NEXT:    call abort
entry:
  %call = call double @test(double 2.000000e+00)
  %cmp = fcmp olt double %call, 2.400000e-01
  %cmp2 = fcmp ogt double %call, 2.600000e-01
  %or.cond = or i1 %cmp, %cmp2
  br i1 %or.cond, label %if.then, label %if.end

if.then:
  call void @abort()
  unreachable

if.end:
  call void @exit(i32 0)
  unreachable
}

declare void @abort()

declare void @exit(i32)

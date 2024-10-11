; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

; Tests that the 'nest' parameter attribute causes the relevant parameter to be
; passed in the right register.

define ptr @nest_receiver(ptr nest %arg) nounwind {
; RV32I-LABEL: nest_receiver:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a0, t2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: nest_receiver:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mv a0, t2
; RV64I-NEXT:    ret
  ret ptr %arg
}

define ptr @nest_caller(ptr %arg) nounwind {
; RV32I-LABEL: nest_caller:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv t2, a0
; RV32I-NEXT:    call nest_receiver
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: nest_caller:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv t2, a0
; RV64I-NEXT:    call nest_receiver
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %result = call ptr @nest_receiver(ptr nest %arg)
  ret ptr %result
}

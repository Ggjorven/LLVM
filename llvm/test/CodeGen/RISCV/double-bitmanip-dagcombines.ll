; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv32 -target-abi=ilp32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s
; RUN: llc -mtriple=riscv32 -target-abi=ilp32 -mattr=+zdinx -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFINXZDINX %s
; RUN: llc -mtriple=riscv64 -target-abi=lp64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -target-abi=lp64 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IFD %s
; RUN: llc -mtriple=riscv64 -target-abi=lp64 -mattr=+zdinx -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IZFINXZDINX %s
;
; This file tests cases where simple floating point operations can be
; profitably handled though bit manipulation if a soft-float ABI is being used
; (e.g. fneg implemented by XORing the sign bit). This is typically handled in
; DAGCombiner::visitBITCAST, but this target-independent code may not trigger
; in cases where we perform custom legalisation (e.g. RV32IFD).

; TODO: Add an appropriate target-specific DAG combine that can handle
; RISCVISD::SplitF64/BuildPairF64 used for RV32IFD.

define double @fneg(double %a) nounwind {
; RV32I-LABEL: fneg:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a2, 524288
; RV32I-NEXT:    xor a1, a1, a2
; RV32I-NEXT:    ret
;
; RV32IFD-LABEL: fneg:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    lui a2, 524288
; RV32IFD-NEXT:    xor a1, a1, a2
; RV32IFD-NEXT:    ret
;
; RV32IZFINXZDINX-LABEL: fneg:
; RV32IZFINXZDINX:       # %bb.0:
; RV32IZFINXZDINX-NEXT:    lui a2, 524288
; RV32IZFINXZDINX-NEXT:    xor a1, a1, a2
; RV32IZFINXZDINX-NEXT:    ret
;
; RV64I-LABEL: fneg:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    slli a1, a1, 63
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IFD-LABEL: fneg:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    li a1, -1
; RV64IFD-NEXT:    slli a1, a1, 63
; RV64IFD-NEXT:    xor a0, a0, a1
; RV64IFD-NEXT:    ret
;
; RV64IZFINXZDINX-LABEL: fneg:
; RV64IZFINXZDINX:       # %bb.0:
; RV64IZFINXZDINX-NEXT:    fneg.d a0, a0
; RV64IZFINXZDINX-NEXT:    ret
  %1 = fneg double %a
  ret double %1
}

declare double @llvm.fabs.f64(double)

define double @fabs(double %a) nounwind {
; RV32I-LABEL: fabs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    srli a1, a1, 1
; RV32I-NEXT:    ret
;
; RV32IFD-LABEL: fabs:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    slli a1, a1, 1
; RV32IFD-NEXT:    srli a1, a1, 1
; RV32IFD-NEXT:    ret
;
; RV32IZFINXZDINX-LABEL: fabs:
; RV32IZFINXZDINX:       # %bb.0:
; RV32IZFINXZDINX-NEXT:    slli a1, a1, 1
; RV32IZFINXZDINX-NEXT:    srli a1, a1, 1
; RV32IZFINXZDINX-NEXT:    ret
;
; RV64I-LABEL: fabs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 1
; RV64I-NEXT:    srli a0, a0, 1
; RV64I-NEXT:    ret
;
; RV64IFD-LABEL: fabs:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    slli a0, a0, 1
; RV64IFD-NEXT:    srli a0, a0, 1
; RV64IFD-NEXT:    ret
;
; RV64IZFINXZDINX-LABEL: fabs:
; RV64IZFINXZDINX:       # %bb.0:
; RV64IZFINXZDINX-NEXT:    fabs.d a0, a0
; RV64IZFINXZDINX-NEXT:    ret
  %1 = call double @llvm.fabs.f64(double %a)
  ret double %1
}

declare double @llvm.copysign.f64(double, double)

; DAGTypeLegalizer::SoftenFloatRes_FCOPYSIGN will convert to bitwise
; operations if floating point isn't supported. A combine could be written to
; do the same even when f64 is legal.

define double @fcopysign_fneg(double %a, double %b) nounwind {
; RV32I-LABEL: fcopysign_fneg:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a2, a3
; RV32I-NEXT:    lui a3, 524288
; RV32I-NEXT:    and a2, a2, a3
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    srli a1, a1, 1
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    ret
;
; RV32IFD-LABEL: fcopysign_fneg:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a2, 8(sp)
; RV32IFD-NEXT:    sw a3, 12(sp)
; RV32IFD-NEXT:    fld fa5, 8(sp)
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    fld fa4, 8(sp)
; RV32IFD-NEXT:    fsgnjn.d fa5, fa4, fa5
; RV32IFD-NEXT:    fsd fa5, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV32IZFINXZDINX-LABEL: fcopysign_fneg:
; RV32IZFINXZDINX:       # %bb.0:
; RV32IZFINXZDINX-NEXT:    fsgnjn.d a0, a0, a2
; RV32IZFINXZDINX-NEXT:    ret
;
; RV64I-LABEL: fcopysign_fneg:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a1
; RV64I-NEXT:    slli a0, a0, 1
; RV64I-NEXT:    srli a0, a0, 1
; RV64I-NEXT:    srli a1, a1, 63
; RV64I-NEXT:    slli a1, a1, 63
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IFD-LABEL: fcopysign_fneg:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fmv.d.x fa5, a0
; RV64IFD-NEXT:    not a0, a1
; RV64IFD-NEXT:    fmv.d.x fa4, a0
; RV64IFD-NEXT:    fsgnj.d fa5, fa5, fa4
; RV64IFD-NEXT:    fmv.x.d a0, fa5
; RV64IFD-NEXT:    ret
;
; RV64IZFINXZDINX-LABEL: fcopysign_fneg:
; RV64IZFINXZDINX:       # %bb.0:
; RV64IZFINXZDINX-NEXT:    fsgnjn.d a0, a0, a1
; RV64IZFINXZDINX-NEXT:    ret
  %1 = fneg double %b
  %2 = call double @llvm.copysign.f64(double %a, double %1)
  ret double %2
}

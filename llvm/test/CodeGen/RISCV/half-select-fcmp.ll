; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi ilp32 < %s | FileCheck -check-prefix=CHECKIZHINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s | FileCheck -check-prefix=CHECKIZHINX %s
; RUN: llc -mtriple=riscv32 -mattr=+zfhmin -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32f | FileCheck -check-prefix=CHECKIZFHMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zfhmin -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64f | FileCheck -check-prefix=CHECKIZFHMIN %s
; RUN: llc -mtriple=riscv32 -mattr=+zhinxmin -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32 | FileCheck -check-prefix=CHECKIZHINXMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zhinxmin -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64 | FileCheck -check-prefix=CHECKIZHINXMIN %s

define half @select_fcmp_false(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_false:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_false:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_false:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_false:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp false half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_oeq(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_oeq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    bnez a0, .LBB1_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_oeq:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    feq.h a2, a0, a1
; CHECKIZHINX-NEXT:    bnez a2, .LBB1_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB1_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_oeq:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    feq.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB1_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB1_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_oeq:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    feq.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB1_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB1_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp oeq half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ogt(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ogt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flt.h a0, fa1, fa0
; CHECK-NEXT:    bnez a0, .LBB2_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ogt:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    flt.h a2, a1, a0
; CHECKIZHINX-NEXT:    bnez a2, .LBB2_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB2_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ogt:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa1
; CHECKIZFHMIN-NEXT:    flt.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB2_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB2_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ogt:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a0
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a1
; CHECKIZHINXMIN-NEXT:    flt.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB2_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB2_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ogt half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_oge(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_oge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fle.h a0, fa1, fa0
; CHECK-NEXT:    bnez a0, .LBB3_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB3_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_oge:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    fle.h a2, a1, a0
; CHECKIZHINX-NEXT:    bnez a2, .LBB3_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB3_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_oge:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa1
; CHECKIZFHMIN-NEXT:    fle.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB3_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB3_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_oge:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a0
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a1
; CHECKIZHINXMIN-NEXT:    fle.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB3_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB3_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp oge half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_olt(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_olt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flt.h a0, fa0, fa1
; CHECK-NEXT:    bnez a0, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_olt:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    flt.h a2, a0, a1
; CHECKIZHINX-NEXT:    bnez a2, .LBB4_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB4_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_olt:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    flt.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB4_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB4_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_olt:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    flt.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB4_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB4_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp olt half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ole(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ole:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fle.h a0, fa0, fa1
; CHECK-NEXT:    bnez a0, .LBB5_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB5_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ole:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    fle.h a2, a0, a1
; CHECKIZHINX-NEXT:    bnez a2, .LBB5_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB5_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ole:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    fle.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB5_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB5_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ole:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    fle.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB5_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB5_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ole half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_one(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_one:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flt.h a0, fa0, fa1
; CHECK-NEXT:    flt.h a1, fa1, fa0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    bnez a0, .LBB6_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB6_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_one:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    flt.h a2, a0, a1
; CHECKIZHINX-NEXT:    flt.h a3, a1, a0
; CHECKIZHINX-NEXT:    or a2, a3, a2
; CHECKIZHINX-NEXT:    bnez a2, .LBB6_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB6_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_one:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    flt.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    flt.s a1, fa5, fa4
; CHECKIZFHMIN-NEXT:    or a0, a1, a0
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB6_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB6_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_one:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    flt.s a4, a3, a2
; CHECKIZHINXMIN-NEXT:    flt.s a2, a2, a3
; CHECKIZHINXMIN-NEXT:    or a2, a2, a4
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB6_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB6_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp one half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ord(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ord:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa1, fa1
; CHECK-NEXT:    feq.h a1, fa0, fa0
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    bnez a0, .LBB7_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB7_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ord:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    feq.h a2, a1, a1
; CHECKIZHINX-NEXT:    feq.h a3, a0, a0
; CHECKIZHINX-NEXT:    and a2, a3, a2
; CHECKIZHINX-NEXT:    bnez a2, .LBB7_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB7_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ord:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    feq.s a0, fa5, fa5
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    feq.s a1, fa5, fa5
; CHECKIZFHMIN-NEXT:    and a0, a1, a0
; CHECKIZFHMIN-NEXT:    bnez a0, .LBB7_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB7_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ord:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    feq.s a2, a2, a2
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    feq.s a3, a3, a3
; CHECKIZHINXMIN-NEXT:    and a2, a3, a2
; CHECKIZHINXMIN-NEXT:    bnez a2, .LBB7_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB7_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ord half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ueq(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ueq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flt.h a0, fa0, fa1
; CHECK-NEXT:    flt.h a1, fa1, fa0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    beqz a0, .LBB8_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB8_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ueq:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    flt.h a2, a0, a1
; CHECKIZHINX-NEXT:    flt.h a3, a1, a0
; CHECKIZHINX-NEXT:    or a2, a3, a2
; CHECKIZHINX-NEXT:    beqz a2, .LBB8_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB8_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ueq:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    flt.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    flt.s a1, fa5, fa4
; CHECKIZFHMIN-NEXT:    or a0, a1, a0
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB8_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB8_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ueq:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    flt.s a4, a3, a2
; CHECKIZHINXMIN-NEXT:    flt.s a2, a2, a3
; CHECKIZHINXMIN-NEXT:    or a2, a2, a4
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB8_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB8_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ueq half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ugt(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fle.h a0, fa0, fa1
; CHECK-NEXT:    beqz a0, .LBB9_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ugt:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    fle.h a2, a0, a1
; CHECKIZHINX-NEXT:    beqz a2, .LBB9_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB9_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ugt:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    fle.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB9_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB9_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ugt:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    fle.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB9_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB9_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ugt half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_uge(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_uge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flt.h a0, fa0, fa1
; CHECK-NEXT:    beqz a0, .LBB10_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB10_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_uge:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    flt.h a2, a0, a1
; CHECKIZHINX-NEXT:    beqz a2, .LBB10_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB10_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_uge:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    flt.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB10_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB10_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_uge:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    flt.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB10_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB10_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp uge half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ult(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fle.h a0, fa1, fa0
; CHECK-NEXT:    beqz a0, .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB11_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ult:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    fle.h a2, a1, a0
; CHECKIZHINX-NEXT:    beqz a2, .LBB11_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB11_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ult:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa1
; CHECKIZFHMIN-NEXT:    fle.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB11_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB11_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ult:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a0
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a1
; CHECKIZHINXMIN-NEXT:    fle.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB11_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB11_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ult half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_ule(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_ule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flt.h a0, fa1, fa0
; CHECK-NEXT:    beqz a0, .LBB12_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB12_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_ule:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    flt.h a2, a1, a0
; CHECKIZHINX-NEXT:    beqz a2, .LBB12_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB12_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_ule:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa1
; CHECKIZFHMIN-NEXT:    flt.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB12_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB12_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_ule:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a0
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a1
; CHECKIZHINXMIN-NEXT:    flt.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB12_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB12_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ule half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_une(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_une:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    beqz a0, .LBB13_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB13_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_une:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    feq.h a2, a0, a1
; CHECKIZHINX-NEXT:    beqz a2, .LBB13_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB13_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_une:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    feq.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB13_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB13_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_une:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    feq.s a2, a3, a2
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB13_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB13_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp une half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_uno(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_uno:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa1, fa1
; CHECK-NEXT:    feq.h a1, fa0, fa0
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    beqz a0, .LBB14_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB14_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_uno:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    feq.h a2, a1, a1
; CHECKIZHINX-NEXT:    feq.h a3, a0, a0
; CHECKIZHINX-NEXT:    and a2, a3, a2
; CHECKIZHINX-NEXT:    beqz a2, .LBB14_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a1
; CHECKIZHINX-NEXT:  .LBB14_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_uno:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    feq.s a0, fa5, fa5
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    feq.s a1, fa5, fa5
; CHECKIZFHMIN-NEXT:    and a0, a1, a0
; CHECKIZFHMIN-NEXT:    beqz a0, .LBB14_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fmv.s fa0, fa1
; CHECKIZFHMIN-NEXT:  .LBB14_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_uno:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a2, a1
; CHECKIZHINXMIN-NEXT:    feq.s a2, a2, a2
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a3, a0
; CHECKIZHINXMIN-NEXT:    feq.s a3, a3, a3
; CHECKIZHINXMIN-NEXT:    and a2, a3, a2
; CHECKIZHINXMIN-NEXT:    beqz a2, .LBB14_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a1
; CHECKIZHINXMIN-NEXT:  .LBB14_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp uno half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

define half @select_fcmp_true(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_true:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_true:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_true:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_true:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp true half %a, %b
  %2 = select i1 %1, half %a, half %b
  ret half %2
}

; Ensure that ISel succeeds for a select+fcmp that has an i32 result type.
define i32 @i32_select_fcmp_oeq(half %a, half %b, i32 %c, i32 %d) nounwind {
; CHECK-LABEL: i32_select_fcmp_oeq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a2, fa0, fa1
; CHECK-NEXT:    bnez a2, .LBB16_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB16_2:
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: i32_select_fcmp_oeq:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    feq.h a1, a0, a1
; CHECKIZHINX-NEXT:    mv a0, a2
; CHECKIZHINX-NEXT:    bnez a1, .LBB16_2
; CHECKIZHINX-NEXT:  # %bb.1:
; CHECKIZHINX-NEXT:    mv a0, a3
; CHECKIZHINX-NEXT:  .LBB16_2:
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: i32_select_fcmp_oeq:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    feq.s a2, fa4, fa5
; CHECKIZFHMIN-NEXT:    bnez a2, .LBB16_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    mv a0, a1
; CHECKIZFHMIN-NEXT:  .LBB16_2:
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: i32_select_fcmp_oeq:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a1, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a0, a0
; CHECKIZHINXMIN-NEXT:    feq.s a1, a0, a1
; CHECKIZHINXMIN-NEXT:    mv a0, a2
; CHECKIZHINXMIN-NEXT:    bnez a1, .LBB16_2
; CHECKIZHINXMIN-NEXT:  # %bb.1:
; CHECKIZHINXMIN-NEXT:    mv a0, a3
; CHECKIZHINXMIN-NEXT:  .LBB16_2:
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp oeq half %a, %b
  %2 = select i1 %1, i32 %c, i32 %d
  ret i32 %2
}

define i32 @select_fcmp_oeq_1_2(half %a, half %b) {
; CHECK-LABEL: select_fcmp_oeq_1_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    li a1, 2
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_oeq_1_2:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    feq.h a0, a0, a1
; CHECKIZHINX-NEXT:    li a1, 2
; CHECKIZHINX-NEXT:    sub a0, a1, a0
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_oeq_1_2:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    feq.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    li a1, 2
; CHECKIZFHMIN-NEXT:    sub a0, a1, a0
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_oeq_1_2:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a1, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a0, a0
; CHECKIZHINXMIN-NEXT:    feq.s a0, a0, a1
; CHECKIZHINXMIN-NEXT:    li a1, 2
; CHECKIZHINXMIN-NEXT:    sub a0, a1, a0
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp fast oeq half %a, %b
  %2 = select i1 %1, i32 1, i32 2
  ret i32 %2
}

define signext i32 @select_fcmp_uge_negone_zero(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_uge_negone_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fle.h a0, fa0, fa1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_uge_negone_zero:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    fle.h a0, a0, a1
; CHECKIZHINX-NEXT:    addi a0, a0, -1
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_uge_negone_zero:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    fle.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    addi a0, a0, -1
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_uge_negone_zero:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a1, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a0, a0
; CHECKIZHINXMIN-NEXT:    fle.s a0, a0, a1
; CHECKIZHINXMIN-NEXT:    addi a0, a0, -1
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ugt half %a, %b
  %2 = select i1 %1, i32 -1, i32 0
  ret i32 %2
}

define signext i32 @select_fcmp_uge_1_2(half %a, half %b) nounwind {
; CHECK-LABEL: select_fcmp_uge_1_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fle.h a0, fa0, fa1
; CHECK-NEXT:    addi a0, a0, 1
; CHECK-NEXT:    ret
;
; CHECKIZHINX-LABEL: select_fcmp_uge_1_2:
; CHECKIZHINX:       # %bb.0:
; CHECKIZHINX-NEXT:    fle.h a0, a0, a1
; CHECKIZHINX-NEXT:    addi a0, a0, 1
; CHECKIZHINX-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_fcmp_uge_1_2:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; CHECKIZFHMIN-NEXT:    fle.s a0, fa4, fa5
; CHECKIZFHMIN-NEXT:    addi a0, a0, 1
; CHECKIZFHMIN-NEXT:    ret
;
; CHECKIZHINXMIN-LABEL: select_fcmp_uge_1_2:
; CHECKIZHINXMIN:       # %bb.0:
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a1, a1
; CHECKIZHINXMIN-NEXT:    fcvt.s.h a0, a0
; CHECKIZHINXMIN-NEXT:    fle.s a0, a0, a1
; CHECKIZHINXMIN-NEXT:    addi a0, a0, 1
; CHECKIZHINXMIN-NEXT:    ret
  %1 = fcmp ugt half %a, %b
  %2 = select i1 %1, i32 1, i32 2
  ret i32 %2
}

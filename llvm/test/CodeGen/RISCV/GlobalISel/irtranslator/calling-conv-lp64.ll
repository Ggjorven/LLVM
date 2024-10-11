; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=riscv64 -global-isel -stop-after=irtranslator \
; RUN:    -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64,RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+f -target-abi=lp64 \
; RUN:    -global-isel -stop-after=irtranslator -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64,RV64F %s

; Any tests that would have identical output for some combination of the lp64*
; ABIs belong in calling-conv-*-common.ll. This file contains tests that will
; have different output across those ABIs. i.e. where some arguments would be
; passed according to the floating point ABI.

define i64 @callee_float_in_regs(i64 %a, float %b) nounwind {
  ; RV64-LABEL: name: callee_float_in_regs
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   liveins: $x10, $x11
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x11
  ; RV64-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; RV64-NEXT:   [[FPTOSI:%[0-9]+]]:_(s64) = G_FPTOSI [[TRUNC]](s32)
  ; RV64-NEXT:   [[ADD:%[0-9]+]]:_(s64) = G_ADD [[COPY]], [[FPTOSI]]
  ; RV64-NEXT:   $x10 = COPY [[ADD]](s64)
  ; RV64-NEXT:   PseudoRET implicit $x10
  %b_fptosi = fptosi float %b to i64
  %1 = add i64 %a, %b_fptosi
  ret i64 %1
}

define i64 @caller_float_in_regs() nounwind {
  ; RV64I-LABEL: name: caller_float_in_regs
  ; RV64I: bb.1 (%ir-block.0):
  ; RV64I-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; RV64I-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_FCONSTANT float 2.000000e+00
  ; RV64I-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; RV64I-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C1]](s32)
  ; RV64I-NEXT:   $x10 = COPY [[C]](s64)
  ; RV64I-NEXT:   $x11 = COPY [[ANYEXT]](s64)
  ; RV64I-NEXT:   PseudoCALL target-flags(riscv-call) @callee_float_in_regs, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit-def $x10
  ; RV64I-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; RV64I-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64I-NEXT:   $x10 = COPY [[COPY]](s64)
  ; RV64I-NEXT:   PseudoRET implicit $x10
  ;
  ; RV64F-LABEL: name: caller_float_in_regs
  ; RV64F: bb.1 (%ir-block.0):
  ; RV64F-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; RV64F-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_FCONSTANT float 2.000000e+00
  ; RV64F-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; RV64F-NEXT:   $x10 = COPY [[C]](s64)
  ; RV64F-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C1]](s32)
  ; RV64F-NEXT:   $x11 = COPY [[ANYEXT]](s64)
  ; RV64F-NEXT:   PseudoCALL target-flags(riscv-call) @callee_float_in_regs, csr_ilp32_lp64, implicit-def $x1, implicit $x10, implicit $x11, implicit-def $x10
  ; RV64F-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; RV64F-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64F-NEXT:   $x10 = COPY [[COPY]](s64)
  ; RV64F-NEXT:   PseudoRET implicit $x10
  %1 = call i64 @callee_float_in_regs(i64 1, float 2.0)
  ret i64 %1
}

define float @callee_tiny_scalar_ret() nounwind {
  ; RV64-LABEL: name: callee_tiny_scalar_ret
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 1.000000e+00
  ; RV64-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[C]](s32)
  ; RV64-NEXT:   $x10 = COPY [[ANYEXT]](s64)
  ; RV64-NEXT:   PseudoRET implicit $x10
  ret float 1.0
}

define i64 @caller_tiny_scalar_ret() nounwind {
  ; RV64-LABEL: name: caller_tiny_scalar_ret
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $x2, implicit $x2
  ; RV64-NEXT:   PseudoCALL target-flags(riscv-call) @callee_tiny_scalar_ret, csr_ilp32_lp64, implicit-def $x1, implicit-def $x10
  ; RV64-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $x2, implicit $x2
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x10
  ; RV64-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; RV64-NEXT:   [[SEXT:%[0-9]+]]:_(s64) = G_SEXT [[TRUNC]](s32)
  ; RV64-NEXT:   $x10 = COPY [[SEXT]](s64)
  ; RV64-NEXT:   PseudoRET implicit $x10
  %1 = call float @callee_tiny_scalar_ret()
  %2 = bitcast float %1 to i32
  %3 = sext i32 %2 to i64
  ret i64 %3
}

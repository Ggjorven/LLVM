; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=riscv64 -mattr=+v -stop-after=finalize-isel | FileCheck %s

define void @vslidedown() {
  ; CHECK-LABEL: name: vslidedown
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   [[ADDI:%[0-9]+]]:gpr = ADDI %stack.0.v, 0
  ; CHECK-NEXT:   [[PseudoVLE8_V_M8_:%[0-9]+]]:vrm8 = PseudoVLE8_V_M8 $noreg, killed [[ADDI]], -1, 3 /* e8 */, 3 /* ta, ma */ :: (load (<vscale x 1 x s512>) from %ir.v, align 1)
  ; CHECK-NEXT:   [[ADDI1:%[0-9]+]]:gpr = ADDI %stack.1, 0
  ; CHECK-NEXT:   PseudoVSE8_V_M8 killed [[PseudoVLE8_V_M8_]], killed [[ADDI1]], -1, 3 /* e8 */ :: (store (<vscale x 1 x s512>) into %stack.1)
  ; CHECK-NEXT:   INLINEASM &"vadd.vv $0, $0, $0", 25 /* sideeffect mayload maystore attdialect */, 262166 /* mem:m */, %stack.0.v, 0, 262166 /* mem:m */, %stack.1, 0
  ; CHECK-NEXT:   PseudoRET
entry:
  %v = alloca <vscale x 64 x i8>, align 1
  %0 = load <vscale x 64 x i8>, ptr %v, align 1
  call void asm sideeffect "vadd.vv $0, $0, $0", "=*imr,imr"(ptr elementtype(<vscale x 64 x i8>) %v, <vscale x 64 x i8> %0)
  ret void
}

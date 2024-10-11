; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1 -mattr=+sme2 -mattr=+sve-b16b16 -verify-machineinstrs < %s | FileCheck %s

define <vscale x 8 x bfloat> @bfclamp(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c){
; CHECK-LABEL: bfclamp:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bfclamp z0.h, z1.h, z2.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fclamp.nxv8bf16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c)
  ret <vscale x 8 x bfloat> %res
}

declare <vscale x 8 x bfloat> @llvm.aarch64.sve.fclamp.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>)

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @test_bfclamp_single_x2_f16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c, <vscale x 8 x bfloat> %d){
; CHECK-LABEL: test_bfclamp_single_x2_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    bfclamp { z0.h, z1.h }, z2.h, z3.h
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.bfclamp.single.x2.nxv8bf16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c, <vscale x 8 x bfloat> %d)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res
}

define { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @test_bfclamp_single_x4_f16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c, <vscale x 8 x bfloat> %d, <vscale x 8 x bfloat> %e, <vscale x 8 x bfloat> %f){
; CHECK-LABEL: test_bfclamp_single_x4_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    bfclamp { z0.h - z3.h }, z4.h, z5.h
; CHECK-NEXT:    ret
  %res = call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.bfclamp.single.x4.nxv8bf16(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c, <vscale x 8 x bfloat> %d, <vscale x 8 x bfloat> %e, <vscale x 8 x bfloat> %f)
  ret { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } %res
}

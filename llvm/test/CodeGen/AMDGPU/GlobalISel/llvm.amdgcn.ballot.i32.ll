; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1010 -global-isel -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 -global-isel -verify-machineinstrs < %s | FileCheck %s

declare i32 @llvm.amdgcn.ballot.i32(i1)
declare i32 @llvm.ctpop.i32(i32)

; Test ballot(0)

define amdgpu_cs i32 @constant_false() {
; CHECK-LABEL: constant_false:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_mov_b32 s0, 0
; CHECK-NEXT:    ; return to shader part epilog
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 0)
  ret i32 %ballot
}

; Test ballot(1)

define amdgpu_cs i32 @constant_true() {
; CHECK-LABEL: constant_true:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_mov_b32 s0, exec_lo
; CHECK-NEXT:    ; return to shader part epilog
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 1)
  ret i32 %ballot
}

; Test ballot of a non-comparison operation

define amdgpu_cs i32 @non_compare(i32 %x) {
; CHECK-LABEL: non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, v0
; CHECK-NEXT:    ; return to shader part epilog
  %trunc = trunc i32 %x to i1
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %trunc)
  ret i32 %ballot
}

; Test ballot of comparisons

define amdgpu_cs i32 @compare_ints(i32 %x, i32 %y) {
; CHECK-LABEL: compare_ints:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_eq_u32_e64 s0, v0, v1
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = icmp eq i32 %x, %y
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %cmp)
  ret i32 %ballot
}

define amdgpu_cs i32 @compare_int_with_constant(i32 %x) {
; CHECK-LABEL: compare_int_with_constant:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_le_i32_e64 s0, 0x63, v0
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = icmp sge i32 %x, 99
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %cmp)
  ret i32 %ballot
}

define amdgpu_cs i32 @compare_floats(float %x, float %y) {
; CHECK-LABEL: compare_floats:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_f32_e64 s0, v0, v1
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = fcmp ogt float %x, %y
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %cmp)
  ret i32 %ballot
}

define amdgpu_cs i32 @ctpop_of_ballot(float %x, float %y) {
; CHECK-LABEL: ctpop_of_ballot:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_f32_e32 vcc_lo, v0, v1
; CHECK-NEXT:    s_bcnt1_i32_b32 s0, vcc_lo
; CHECK-NEXT:    ; return to shader part epilog
  %cmp = fcmp ogt float %x, %y
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %cmp)
  %bcnt = call i32 @llvm.ctpop.i32(i32 %ballot)
  ret i32 %bcnt
}

define amdgpu_cs i32 @branch_divergent_ballot_ne_zero_non_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_ne_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_ne_u32_e32 vcc_lo, 0, v0
; CHECK-NEXT:    s_cmp_eq_u32 vcc_lo, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB7_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB7_3
; CHECK-NEXT:  .LBB7_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB7_3
; CHECK-NEXT:  .LBB7_3:
  %c = trunc i32 %v to i1
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_ne_zero = icmp ne i32 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_ne_zero_non_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_ne_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_eq_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB8_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB8_3
; CHECK-NEXT:  .LBB8_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB8_3
; CHECK-NEXT:  .LBB8_3:
  %c = trunc i32 %v to i1
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_ne_zero = icmp ne i32 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_eq_zero_non_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_eq_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_and_b32_e32 v0, 1, v0
; CHECK-NEXT:    v_cmp_ne_u32_e32 vcc_lo, 0, v0
; CHECK-NEXT:    s_cmp_lg_u32 vcc_lo, 0
; CHECK-NEXT:    s_cbranch_scc0 .LBB9_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB9_3
; CHECK-NEXT:  .LBB9_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB9_3
; CHECK-NEXT:  .LBB9_3:
  %c = trunc i32 %v to i1
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_eq_zero = icmp eq i32 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_eq_zero_non_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_eq_zero_non_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_lg_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc0 .LBB10_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB10_3
; CHECK-NEXT:  .LBB10_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB10_3
; CHECK-NEXT:  .LBB10_3:
  %c = trunc i32 %v to i1
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_eq_zero = icmp eq i32 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_ne_zero_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_ne_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc_lo, 12, v0
; CHECK-NEXT:    s_cmp_eq_u32 vcc_lo, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB11_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB11_3
; CHECK-NEXT:  .LBB11_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB11_3
; CHECK-NEXT:  .LBB11_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_ne_zero = icmp ne i32 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_ne_zero_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_ne_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b32 s0, 1, 0
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_eq_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB12_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB12_3
; CHECK-NEXT:  .LBB12_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB12_3
; CHECK-NEXT:  .LBB12_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_ne_zero = icmp ne i32 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_eq_zero_compare(i32 %v) {
; CHECK-LABEL: branch_divergent_ballot_eq_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc_lo, 12, v0
; CHECK-NEXT:    s_cmp_lg_u32 vcc_lo, 0
; CHECK-NEXT:    s_cbranch_scc0 .LBB13_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB13_3
; CHECK-NEXT:  .LBB13_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB13_3
; CHECK-NEXT:  .LBB13_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_eq_zero = icmp eq i32 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_eq_zero_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_eq_zero_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b32 s0, 1, 0
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_lg_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc0 .LBB14_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB14_3
; CHECK-NEXT:  .LBB14_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB14_3
; CHECK-NEXT:  .LBB14_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_eq_zero = icmp eq i32 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_ne_zero_and(i32 %v1, i32 %v2) {
; CHECK-LABEL: branch_divergent_ballot_ne_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc_lo, 12, v0
; CHECK-NEXT:    v_cmp_lt_u32_e64 s0, 34, v1
; CHECK-NEXT:    s_and_b32 s0, vcc_lo, s0
; CHECK-NEXT:    s_cmp_eq_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB15_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB15_3
; CHECK-NEXT:  .LBB15_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB15_3
; CHECK-NEXT:  .LBB15_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_ne_zero = icmp ne i32 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_ne_zero_and(i32 inreg %v1, i32 inreg %v2) {
; CHECK-LABEL: branch_uniform_ballot_ne_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b32 s0, 1, 0
; CHECK-NEXT:    s_cmp_gt_u32 s1, 34
; CHECK-NEXT:    s_cselect_b32 s1, 1, 0
; CHECK-NEXT:    s_and_b32 s0, s0, s1
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_eq_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc1 .LBB16_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB16_3
; CHECK-NEXT:  .LBB16_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB16_3
; CHECK-NEXT:  .LBB16_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_ne_zero = icmp ne i32 %ballot, 0
  br i1 %ballot_ne_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_divergent_ballot_eq_zero_and(i32 %v1, i32 %v2) {
; CHECK-LABEL: branch_divergent_ballot_eq_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    v_cmp_gt_u32_e32 vcc_lo, 12, v0
; CHECK-NEXT:    v_cmp_lt_u32_e64 s0, 34, v1
; CHECK-NEXT:    s_and_b32 s0, vcc_lo, s0
; CHECK-NEXT:    s_cmp_lg_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc0 .LBB17_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB17_3
; CHECK-NEXT:  .LBB17_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB17_3
; CHECK-NEXT:  .LBB17_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_eq_zero = icmp eq i32 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_eq_zero_and(i32 inreg %v1, i32 inreg %v2) {
; CHECK-LABEL: branch_uniform_ballot_eq_zero_and:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b32 s0, 1, 0
; CHECK-NEXT:    s_cmp_gt_u32 s1, 34
; CHECK-NEXT:    s_cselect_b32 s1, 1, 0
; CHECK-NEXT:    s_and_b32 s0, s0, s1
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_lg_u32 s0, 0
; CHECK-NEXT:    s_cbranch_scc0 .LBB18_2
; CHECK-NEXT:  ; %bb.1: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB18_3
; CHECK-NEXT:  .LBB18_2: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB18_3
; CHECK-NEXT:  .LBB18_3:
  %v1c = icmp ult i32 %v1, 12
  %v2c = icmp ugt i32 %v2, 34
  %c = and i1 %v1c, %v2c
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %ballot_eq_zero = icmp eq i32 %ballot, 0
  br i1 %ballot_eq_zero, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

define amdgpu_cs i32 @branch_uniform_ballot_sgt_N_compare(i32 inreg %v) {
; CHECK-LABEL: branch_uniform_ballot_sgt_N_compare:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_cmp_lt_u32 s0, 12
; CHECK-NEXT:    s_cselect_b32 s0, 1, 0
; CHECK-NEXT:    s_and_b32 s0, 1, s0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s0, 0, s0
; CHECK-NEXT:    s_cmp_le_i32 s0, 22
; CHECK-NEXT:    s_cbranch_scc1 .LBB19_2
; CHECK-NEXT:  ; %bb.1: ; %true
; CHECK-NEXT:    s_mov_b32 s0, 42
; CHECK-NEXT:    s_branch .LBB19_3
; CHECK-NEXT:  .LBB19_2: ; %false
; CHECK-NEXT:    s_mov_b32 s0, 33
; CHECK-NEXT:    s_branch .LBB19_3
; CHECK-NEXT:  .LBB19_3:
  %c = icmp ult i32 %v, 12
  %ballot = call i32 @llvm.amdgcn.ballot.i32(i1 %c)
  %bc = icmp sgt i32 %ballot, 22
  br i1 %bc, label %true, label %false
true:
  ret i32 42
false:
  ret i32 33
}

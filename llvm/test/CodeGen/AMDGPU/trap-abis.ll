; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - -mtriple=amdgcn -mcpu=gfx900 -verify-machineinstrs | FileCheck --check-prefix=NOHSA-TRAP-GFX900 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx803 -verify-machineinstrs | FileCheck --check-prefix=HSA-TRAP-GFX803 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs | FileCheck --check-prefix=HSA-TRAP-GFX900 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -mattr=-trap-handler -verify-machineinstrs | FileCheck --check-prefix=HSA-NOTRAP-GFX900 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -verify-machineinstrs | FileCheck --check-prefix=HSA-TRAP-GFX1100 %s
; RUN: llc %s -o - -O0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -verify-machineinstrs | FileCheck --check-prefix=HSA-TRAP-GFX1100-O0 %s

declare void @llvm.trap() #0
declare void @llvm.debugtrap() #1

define amdgpu_kernel void @trap(ptr addrspace(1) nocapture readonly %arg0) {
; NOHSA-TRAP-GFX900-LABEL: trap:
; NOHSA-TRAP-GFX900:       ; %bb.0:
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: trap:
; HSA-TRAP-GFX803:       ; %bb.0:
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx2 s[2:3], s[8:9], 0x0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v2, 1
; HSA-TRAP-GFX803-NEXT:    s_mov_b64 s[0:1], s[6:7]
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s2
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s3
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_trap 2
;
; HSA-TRAP-GFX900-LABEL: trap:
; HSA-TRAP-GFX900:       ; %bb.0:
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_trap 2
;
; HSA-NOTRAP-GFX900-LABEL: trap:
; HSA-NOTRAP-GFX900:       ; %bb.0:
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX1100-LABEL: trap:
; HSA-TRAP-GFX1100:       ; %bb.0:
; HSA-TRAP-GFX1100-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, 1
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 ttmp2, m0
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-NEXT:    s_trap 2
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    s_and_b32 s0, s0, 0x3ff
; HSA-TRAP-GFX1100-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; HSA-TRAP-GFX1100-NEXT:    s_bitset1_b32 s0, 10
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 m0, s0
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg sendmsg(MSG_INTERRUPT)
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 m0, ttmp2
; HSA-TRAP-GFX1100-NEXT:  .LBB0_1: ; =>This Inner Loop Header: Depth=1
; HSA-TRAP-GFX1100-NEXT:    s_sethalt 5
; HSA-TRAP-GFX1100-NEXT:    s_branch .LBB0_1
;
; HSA-TRAP-GFX1100-O0-LABEL: trap:
; HSA-TRAP-GFX1100-O0:       ; %bb.0:
; HSA-TRAP-GFX1100-O0-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v1, 1
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_trap 2
; HSA-TRAP-GFX1100-O0-NEXT:    s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 ttmp2, m0
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    s_and_b32 s0, s0, 0x3ff
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_b32 s0, s0, 0x400
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 m0, s0
; HSA-TRAP-GFX1100-O0-NEXT:    s_sendmsg sendmsg(MSG_INTERRUPT)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 m0, ttmp2
; HSA-TRAP-GFX1100-O0-NEXT:  .LBB0_1: ; =>This Inner Loop Header: Depth=1
; HSA-TRAP-GFX1100-O0-NEXT:    s_sethalt 5
; HSA-TRAP-GFX1100-O0-NEXT:    s_branch .LBB0_1
  store volatile i32 1, ptr addrspace(1) %arg0
  call void @llvm.trap()
  unreachable
  store volatile i32 2, ptr addrspace(1) %arg0
  ret void
}

define amdgpu_kernel void @non_entry_trap(ptr addrspace(1) nocapture readonly %arg0) local_unnamed_addr {
; NOHSA-TRAP-GFX900-LABEL: non_entry_trap:
; NOHSA-TRAP-GFX900:       ; %bb.0: ; %entry
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v1
; NOHSA-TRAP-GFX900-NEXT:    s_cbranch_vccz .LBB1_2
; NOHSA-TRAP-GFX900-NEXT:  ; %bb.1: ; %ret
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 3
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
; NOHSA-TRAP-GFX900-NEXT:  .LBB1_2: ; %trap
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: non_entry_trap:
; HSA-TRAP-GFX803:       ; %bb.0: ; %entry
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s1
; HSA-TRAP-GFX803-NEXT:    flat_load_dword v0, v[0:1] glc
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v0
; HSA-TRAP-GFX803-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-TRAP-GFX803-NEXT:  ; %bb.1: ; %ret
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v2, 3
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s1
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_endpgm
; HSA-TRAP-GFX803-NEXT:  .LBB1_2: ; %trap
; HSA-TRAP-GFX803-NEXT:    s_mov_b64 s[0:1], s[6:7]
; HSA-TRAP-GFX803-NEXT:    s_trap 2
;
; HSA-TRAP-GFX900-LABEL: non_entry_trap:
; HSA-TRAP-GFX900:       ; %bb.0: ; %entry
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v1
; HSA-TRAP-GFX900-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-TRAP-GFX900-NEXT:  ; %bb.1: ; %ret
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 3
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_endpgm
; HSA-TRAP-GFX900-NEXT:  .LBB1_2: ; %trap
; HSA-TRAP-GFX900-NEXT:    s_trap 2
;
; HSA-NOTRAP-GFX900-LABEL: non_entry_trap:
; HSA-NOTRAP-GFX900:       ; %bb.0: ; %entry
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v1
; HSA-NOTRAP-GFX900-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-NOTRAP-GFX900-NEXT:  ; %bb.1: ; %ret
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 3
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
; HSA-NOTRAP-GFX900-NEXT:  .LBB1_2: ; %trap
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX1100-LABEL: non_entry_trap:
; HSA-TRAP-GFX1100:       ; %bb.0: ; %entry
; HSA-TRAP-GFX1100-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    global_load_b32 v1, v0, s[0:1] glc dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    v_cmp_eq_u32_e32 vcc_lo, -1, v1
; HSA-TRAP-GFX1100-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-TRAP-GFX1100-NEXT:  ; %bb.1: ; %ret
; HSA-TRAP-GFX1100-NEXT:    v_mov_b32_e32 v1, 3
; HSA-TRAP-GFX1100-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-NEXT:    s_nop 0
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; HSA-TRAP-GFX1100-NEXT:    s_endpgm
; HSA-TRAP-GFX1100-NEXT:  .LBB1_2: ; %trap
; HSA-TRAP-GFX1100-NEXT:    s_trap 2
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 ttmp2, m0
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    s_and_b32 s0, s0, 0x3ff
; HSA-TRAP-GFX1100-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; HSA-TRAP-GFX1100-NEXT:    s_bitset1_b32 s0, 10
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 m0, s0
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg sendmsg(MSG_INTERRUPT)
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 m0, ttmp2
; HSA-TRAP-GFX1100-NEXT:  .LBB1_3: ; =>This Inner Loop Header: Depth=1
; HSA-TRAP-GFX1100-NEXT:    s_sethalt 5
; HSA-TRAP-GFX1100-NEXT:    s_branch .LBB1_3
;
; HSA-TRAP-GFX1100-O0-LABEL: non_entry_trap:
; HSA-TRAP-GFX1100-O0:       ; %bb.0: ; %entry
; HSA-TRAP-GFX1100-O0-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b64 s[2:3], s[0:1]
; HSA-TRAP-GFX1100-O0-NEXT:    ; implicit-def: $vgpr2 : SGPR spill to VGPR lane
; HSA-TRAP-GFX1100-O0-NEXT:    v_writelane_b32 v2, s2, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_writelane_b32 v2, s3, 1
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_saveexec_b32 s6, -1
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_store_b32 off, v2, off ; 4-byte Folded Spill
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 exec_lo, s6
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-O0-NEXT:    global_load_b32 v0, v0, s[0:1] glc dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 s0, -1
; HSA-TRAP-GFX1100-O0-NEXT:    ; implicit-def: $sgpr1
; HSA-TRAP-GFX1100-O0-NEXT:    v_cmp_eq_u32_e64 s0, v0, s0
; HSA-TRAP-GFX1100-O0-NEXT:    s_and_b32 vcc_lo, exec_lo, s0
; HSA-TRAP-GFX1100-O0-NEXT:    s_cbranch_vccnz .LBB1_2
; HSA-TRAP-GFX1100-O0-NEXT:  ; %bb.1: ; %trap
; HSA-TRAP-GFX1100-O0-NEXT:    s_trap 2
; HSA-TRAP-GFX1100-O0-NEXT:    s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 ttmp2, m0
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    s_and_b32 s0, s0, 0x3ff
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_b32 s0, s0, 0x400
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 m0, s0
; HSA-TRAP-GFX1100-O0-NEXT:    s_sendmsg sendmsg(MSG_INTERRUPT)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 m0, ttmp2
; HSA-TRAP-GFX1100-O0-NEXT:    s_branch .LBB1_3
; HSA-TRAP-GFX1100-O0-NEXT:  .LBB1_2: ; %ret
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_saveexec_b32 s6, -1
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_load_b32 v2, off, off ; 4-byte Folded Reload
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 exec_lo, s6
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    v_readlane_b32 s0, v2, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_readlane_b32 s1, v2, 1
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v1, 3
; HSA-TRAP-GFX1100-O0-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_endpgm
; HSA-TRAP-GFX1100-O0-NEXT:  .LBB1_3: ; =>This Inner Loop Header: Depth=1
; HSA-TRAP-GFX1100-O0-NEXT:    s_sethalt 5
; HSA-TRAP-GFX1100-O0-NEXT:    s_branch .LBB1_3
entry:
  %tmp29 = load volatile i32, ptr addrspace(1) %arg0
  %cmp = icmp eq i32 %tmp29, -1
  br i1 %cmp, label %ret, label %trap

trap:
  call void @llvm.trap()
  unreachable

ret:
  store volatile i32 3, ptr addrspace(1) %arg0
  ret void
}

define amdgpu_kernel void @trap_with_use_after(ptr addrspace(1) %arg0, ptr addrspace(1) %arg1) {
; NOHSA-TRAP-GFX900-LABEL: trap_with_use_after:
; NOHSA-TRAP-GFX900:       ; %bb.0:
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_cbranch_execnz .LBB2_2
; NOHSA-TRAP-GFX900-NEXT:  ; %bb.1:
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[2:3]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:  .LBB2_2:
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: trap_with_use_after:
; HSA-TRAP-GFX803:       ; %bb.0:
; HSA-TRAP-GFX803-NEXT:    s_mov_b64 s[0:1], s[6:7]
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx4 s[4:7], s[8:9], 0x0
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s4
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s5
; HSA-TRAP-GFX803-NEXT:    flat_load_dword v2, v[0:1] glc
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s6
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s7
; HSA-TRAP-GFX803-NEXT:    s_trap 2
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_endpgm
;
; HSA-TRAP-GFX900-LABEL: trap_with_use_after:
; HSA-TRAP-GFX900:       ; %bb.0:
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_trap 2
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[2:3]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-NOTRAP-GFX900-LABEL: trap_with_use_after:
; HSA-NOTRAP-GFX900:       ; %bb.0:
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_cbranch_execnz .LBB2_2
; HSA-NOTRAP-GFX900-NEXT:  ; %bb.1:
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[2:3]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:  .LBB2_2:
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX1100-LABEL: trap_with_use_after:
; HSA-TRAP-GFX1100:       ; %bb.0:
; HSA-TRAP-GFX1100-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; HSA-TRAP-GFX1100-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    global_load_b32 v1, v0, s[0:1] glc dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    s_cbranch_execnz .LBB2_2
; HSA-TRAP-GFX1100-NEXT:  ; %bb.1:
; HSA-TRAP-GFX1100-NEXT:    global_store_b32 v0, v1, s[2:3] dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-NEXT:    s_nop 0
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; HSA-TRAP-GFX1100-NEXT:    s_endpgm
; HSA-TRAP-GFX1100-NEXT:  .LBB2_2:
; HSA-TRAP-GFX1100-NEXT:    s_trap 2
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 ttmp2, m0
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    s_and_b32 s0, s0, 0x3ff
; HSA-TRAP-GFX1100-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; HSA-TRAP-GFX1100-NEXT:    s_bitset1_b32 s0, 10
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 m0, s0
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg sendmsg(MSG_INTERRUPT)
; HSA-TRAP-GFX1100-NEXT:    s_mov_b32 m0, ttmp2
; HSA-TRAP-GFX1100-NEXT:  .LBB2_3: ; =>This Inner Loop Header: Depth=1
; HSA-TRAP-GFX1100-NEXT:    s_sethalt 5
; HSA-TRAP-GFX1100-NEXT:    s_branch .LBB2_3
;
; HSA-TRAP-GFX1100-O0-LABEL: trap_with_use_after:
; HSA-TRAP-GFX1100-O0:       ; %bb.0:
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_store_b32 off, v0, off offset:8 ; 4-byte Folded Spill
; HSA-TRAP-GFX1100-O0-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_load_b64 s[2:3], s[4:5], 0x8
; HSA-TRAP-GFX1100-O0-NEXT:    ; implicit-def: $vgpr2 : SGPR spill to VGPR lane
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    v_writelane_b32 v2, s2, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_writelane_b32 v2, s3, 1
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_saveexec_b32 s6, -1
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_store_b32 off, v2, off ; 4-byte Folded Spill
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 exec_lo, s6
; HSA-TRAP-GFX1100-O0-NEXT:    global_load_b32 v0, v0, s[0:1] glc dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_store_b32 off, v0, off offset:4 ; 4-byte Folded Spill
; HSA-TRAP-GFX1100-O0-NEXT:    s_cbranch_execnz .LBB2_2
; HSA-TRAP-GFX1100-O0-NEXT:  ; %bb.1:
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_load_b32 v0, off, off offset:8 ; 4-byte Folded Reload
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_load_b32 v1, off, off offset:4 ; 4-byte Folded Reload
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_saveexec_b32 s6, -1
; HSA-TRAP-GFX1100-O0-NEXT:    scratch_load_b32 v2, off, off ; 4-byte Folded Reload
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 exec_lo, s6
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    v_readlane_b32 s0, v2, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_readlane_b32 s1, v2, 1
; HSA-TRAP-GFX1100-O0-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_endpgm
; HSA-TRAP-GFX1100-O0-NEXT:  .LBB2_2:
; HSA-TRAP-GFX1100-O0-NEXT:    s_trap 2
; HSA-TRAP-GFX1100-O0-NEXT:    s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 ttmp2, m0
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    s_and_b32 s0, s0, 0x3ff
; HSA-TRAP-GFX1100-O0-NEXT:    s_or_b32 s0, s0, 0x400
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 m0, s0
; HSA-TRAP-GFX1100-O0-NEXT:    s_sendmsg sendmsg(MSG_INTERRUPT)
; HSA-TRAP-GFX1100-O0-NEXT:    s_mov_b32 m0, ttmp2
; HSA-TRAP-GFX1100-O0-NEXT:  .LBB2_3: ; =>This Inner Loop Header: Depth=1
; HSA-TRAP-GFX1100-O0-NEXT:    s_sethalt 5
; HSA-TRAP-GFX1100-O0-NEXT:    s_branch .LBB2_3
  %tmp = load volatile i32, ptr addrspace(1) %arg0
  call void @llvm.trap()
  store volatile i32 %tmp, ptr addrspace(1) %arg1
  ret void
}

define amdgpu_kernel void @debugtrap(ptr addrspace(1) nocapture readonly %arg0) {
; NOHSA-TRAP-GFX900-LABEL: debugtrap:
; NOHSA-TRAP-GFX900:       ; %bb.0:
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v2, 2
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v2, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: debugtrap:
; HSA-TRAP-GFX803:       ; %bb.0:
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v2, 1
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v3, 2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s1
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_trap 3
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v3
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_endpgm
;
; HSA-TRAP-GFX900-LABEL: debugtrap:
; HSA-TRAP-GFX900:       ; %bb.0:
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v2, 2
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_trap 3
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v2, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-NOTRAP-GFX900-LABEL: debugtrap:
; HSA-NOTRAP-GFX900:       ; %bb.0:
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v2, 2
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v2, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX1100-LABEL: debugtrap:
; HSA-TRAP-GFX1100:       ; %bb.0:
; HSA-TRAP-GFX1100-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, 1
; HSA-TRAP-GFX1100-NEXT:    v_mov_b32_e32 v2, 2
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-NEXT:    s_trap 3
; HSA-TRAP-GFX1100-NEXT:    global_store_b32 v0, v2, s[0:1] dlc
; HSA-TRAP-GFX1100-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-NEXT:    s_nop 0
; HSA-TRAP-GFX1100-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; HSA-TRAP-GFX1100-NEXT:    s_endpgm
;
; HSA-TRAP-GFX1100-O0-LABEL: debugtrap:
; HSA-TRAP-GFX1100-O0:       ; %bb.0:
; HSA-TRAP-GFX1100-O0-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v1, 1
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX1100-O0-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_trap 3
; HSA-TRAP-GFX1100-O0-NEXT:    v_mov_b32_e32 v1, 2
; HSA-TRAP-GFX1100-O0-NEXT:    global_store_b32 v0, v1, s[0:1] dlc
; HSA-TRAP-GFX1100-O0-NEXT:    s_waitcnt_vscnt null, 0x0
; HSA-TRAP-GFX1100-O0-NEXT:    s_endpgm
  store volatile i32 1, ptr addrspace(1) %arg0
  call void @llvm.debugtrap()
  store volatile i32 2, ptr addrspace(1) %arg0
  ret void
}

attributes #0 = { nounwind noreturn }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdhsa_code_object_version", i32 400}

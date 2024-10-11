; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -global-isel=0 -mtriple=amdgcn-amd-amdhsa -mcpu=tahiti < %s | FileCheck -check-prefixes=SI,SI-SDAG %s
; RUN: llc -global-isel=0 -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii < %s | FileCheck -check-prefixes=CI,CI-SDAG %s
; RUN: llc -global-isel=0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=GFX9,GFX9-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii < %s | FileCheck -check-prefixes=CI,CI-GISEL %s
; RUN: llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=GFX9,GFX9-GISEL %s
; RUN: llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 < %s | FileCheck -check-prefixes=GFX10,GFX10-GISEL %s
; RUN: llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 < %s | FileCheck -check-prefixes=GFX11,GFX11-GISEL %s

define amdgpu_kernel void @is_private_vgpr(ptr addrspace(1) %ptr.ptr) {
; SI-LABEL: is_private_vgpr:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; SI-NEXT:    s_load_dword s4, s[6:7], 0x32
; SI-NEXT:    s_mov_b32 s2, 0
; SI-NEXT:    s_mov_b32 s3, 0x100f000
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    buffer_load_dwordx2 v[0:1], v[0:1], s[0:3], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_cmp_eq_u32_e32 vcc, s4, v1
; SI-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; CI-SDAG-LABEL: is_private_vgpr:
; CI-SDAG:       ; %bb.0:
; CI-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CI-SDAG-NEXT:    s_load_dword s2, s[6:7], 0x32
; CI-SDAG-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; CI-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CI-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CI-SDAG-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; CI-SDAG-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-SDAG-NEXT:    flat_load_dwordx2 v[0:1], v[0:1] glc
; CI-SDAG-NEXT:    s_waitcnt vmcnt(0)
; CI-SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, s2, v1
; CI-SDAG-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; CI-SDAG-NEXT:    flat_store_dword v[0:1], v0
; CI-SDAG-NEXT:    s_endpgm
;
; GFX9-LABEL: is_private_vgpr:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dwordx2 v[0:1], v0, s[0:1] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_mov_b64 s[0:1], src_private_base
; GFX9-NEXT:    v_cmp_eq_u32_e32 vcc, s1, v1
; GFX9-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; GFX9-NEXT:    global_store_dword v[0:1], v0, off
; GFX9-NEXT:    s_endpgm
;
; CI-GISEL-LABEL: is_private_vgpr:
; CI-GISEL:       ; %bb.0:
; CI-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CI-GISEL-NEXT:    s_load_dword s2, s[6:7], 0x32
; CI-GISEL-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; CI-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CI-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; CI-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; CI-GISEL-NEXT:    v_add_i32_e32 v0, vcc, v0, v2
; CI-GISEL-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-GISEL-NEXT:    flat_load_dwordx2 v[0:1], v[0:1] glc
; CI-GISEL-NEXT:    s_waitcnt vmcnt(0)
; CI-GISEL-NEXT:    v_cmp_eq_u32_e32 vcc, s2, v1
; CI-GISEL-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; CI-GISEL-NEXT:    flat_store_dword v[0:1], v0
; CI-GISEL-NEXT:    s_endpgm
;
; GFX10-LABEL: is_private_vgpr:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dwordx2 v[0:1], v0, s[0:1] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-NEXT:    s_mov_b64 s[0:1], src_private_base
; GFX10-NEXT:    v_cmp_eq_u32_e32 vcc_lo, s1, v1
; GFX10-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc_lo
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: is_private_vgpr:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b64 s[0:1], s[2:3], 0x0
; GFX11-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(SALU_CYCLE_1)
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b64 v[0:1], v0, s[0:1] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    s_mov_b64 s[0:1], src_private_base
; GFX11-NEXT:    v_cmp_eq_u32_e32 vcc_lo, s1, v1
; GFX11-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc_lo
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %id = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr inbounds ptr, ptr addrspace(1) %ptr.ptr, i32 %id
  %ptr = load volatile ptr, ptr addrspace(1) %gep
  %val = call i1 @llvm.amdgcn.is.private(ptr %ptr)
  %ext = zext i1 %val to i32
  store i32 %ext, ptr addrspace(1) undef
  ret void
}

; FIXME: setcc (zero_extend (setcc)), 1) not folded out, resulting in
; select and vcc branch.
define amdgpu_kernel void @is_private_sgpr(ptr %ptr) {
; SI-LABEL: is_private_sgpr:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s0, s[6:7], 0x1
; SI-NEXT:    s_load_dword s1, s[6:7], 0x32
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s0, s1
; SI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; SI-NEXT:    s_andn2_b64 vcc, exec, s[0:1]
; SI-NEXT:    s_cbranch_vccnz .LBB1_2
; SI-NEXT:  ; %bb.1: ; %bb0
; SI-NEXT:    s_mov_b32 s3, 0x100f000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, 0
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:  .LBB1_2: ; %bb1
; SI-NEXT:    s_endpgm
;
; CI-SDAG-LABEL: is_private_sgpr:
; CI-SDAG:       ; %bb.0:
; CI-SDAG-NEXT:    s_load_dword s0, s[6:7], 0x1
; CI-SDAG-NEXT:    s_load_dword s1, s[6:7], 0x32
; CI-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CI-SDAG-NEXT:    s_cmp_eq_u32 s0, s1
; CI-SDAG-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CI-SDAG-NEXT:    s_andn2_b64 vcc, exec, s[0:1]
; CI-SDAG-NEXT:    s_cbranch_vccnz .LBB1_2
; CI-SDAG-NEXT:  ; %bb.1: ; %bb0
; CI-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; CI-SDAG-NEXT:    flat_store_dword v[0:1], v0
; CI-SDAG-NEXT:    s_waitcnt vmcnt(0)
; CI-SDAG-NEXT:  .LBB1_2: ; %bb1
; CI-SDAG-NEXT:    s_endpgm
;
; GFX9-SDAG-LABEL: is_private_sgpr:
; GFX9-SDAG:       ; %bb.0:
; GFX9-SDAG-NEXT:    s_load_dword s2, s[6:7], 0x4
; GFX9-SDAG-NEXT:    s_mov_b64 s[0:1], src_private_base
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_cmp_eq_u32 s2, s1
; GFX9-SDAG-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GFX9-SDAG-NEXT:    s_andn2_b64 vcc, exec, s[0:1]
; GFX9-SDAG-NEXT:    s_cbranch_vccnz .LBB1_2
; GFX9-SDAG-NEXT:  ; %bb.1: ; %bb0
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-SDAG-NEXT:    global_store_dword v[0:1], v0, off
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9-SDAG-NEXT:  .LBB1_2: ; %bb1
; GFX9-SDAG-NEXT:    s_endpgm
;
; CI-GISEL-LABEL: is_private_sgpr:
; CI-GISEL:       ; %bb.0:
; CI-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CI-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CI-GISEL-NEXT:    s_load_dword s0, s[6:7], 0x32
; CI-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CI-GISEL-NEXT:    s_cmp_lg_u32 s1, s0
; CI-GISEL-NEXT:    s_cbranch_scc1 .LBB1_2
; CI-GISEL-NEXT:  ; %bb.1: ; %bb0
; CI-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; CI-GISEL-NEXT:    flat_store_dword v[0:1], v0
; CI-GISEL-NEXT:    s_waitcnt vmcnt(0)
; CI-GISEL-NEXT:  .LBB1_2: ; %bb1
; CI-GISEL-NEXT:    s_endpgm
;
; GFX9-GISEL-LABEL: is_private_sgpr:
; GFX9-GISEL:       ; %bb.0:
; GFX9-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX9-GISEL-NEXT:    s_mov_b64 s[2:3], src_private_base
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_cmp_lg_u32 s1, s3
; GFX9-GISEL-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX9-GISEL-NEXT:  ; %bb.1: ; %bb0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-GISEL-NEXT:    global_store_dword v[0:1], v0, off
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9-GISEL-NEXT:  .LBB1_2: ; %bb1
; GFX9-GISEL-NEXT:    s_endpgm
;
; GFX10-LABEL: is_private_sgpr:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX10-NEXT:    s_mov_b64 s[2:3], src_private_base
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_cmp_lg_u32 s1, s3
; GFX10-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX10-NEXT:  ; %bb.1: ; %bb0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:  .LBB1_2: ; %bb1
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: is_private_sgpr:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b64 s[0:1], s[2:3], 0x0
; GFX11-NEXT:    s_mov_b64 s[2:3], src_private_base
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_cmp_lg_u32 s1, s3
; GFX11-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX11-NEXT:  ; %bb.1: ; %bb0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off dlc
; GFX11-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX11-NEXT:  .LBB1_2: ; %bb1
; GFX11-NEXT:    s_endpgm
  %val = call i1 @llvm.amdgcn.is.private(ptr %ptr)
  br i1 %val, label %bb0, label %bb1

bb0:
  store volatile i32 0, ptr addrspace(1) undef
  br label %bb1

bb1:
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdhsa_code_object_version", i32 500}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CI: {{.*}}
; GFX10-GISEL: {{.*}}
; GFX11-GISEL: {{.*}}
; SI-SDAG: {{.*}}

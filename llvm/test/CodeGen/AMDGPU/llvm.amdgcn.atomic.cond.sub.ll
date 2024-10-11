; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck %s -check-prefix=GFX12

define float @raw_buffer_atomic_cond_sub_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: raw_buffer_atomic_cond_sub_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_mov_b32_e32 v0, s6
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, off, s[0:3], null th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %orig = call i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 0)
  %r = bitcast i32 %orig to float
  ret float %r
}

define void @raw_buffer_atomic_cond_sub_no_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: raw_buffer_atomic_cond_sub_no_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_mov_b32_e32 v0, s6
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, off, s[0:3], null th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 0)
  ret void
}

define void @raw_buffer_atomic_cond_sub_no_return_forced(<4 x i32> inreg %rsrc, i32 inreg %data) #1 {
; GFX12-LABEL: raw_buffer_atomic_cond_sub_no_return_forced:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_mov_b32_e32 v0, s6
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, off, s[0:3], null
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 0)
  ret void
}

define float @raw_buffer_atomic_cond_sub_imm_soff_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: raw_buffer_atomic_cond_sub_imm_soff_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_mov_b32_e32 v0, s6
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, off, s[0:3], s4 th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %orig = call i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 4, i32 0)
  %r = bitcast i32 %orig to float
  ret float %r
}

define void @raw_buffer_atomic_cond_sub_imm_soff_no_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: raw_buffer_atomic_cond_sub_imm_soff_no_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_mov_b32_e32 v0, s6
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, off, s[0:3], s4 th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 4, i32 0)
  ret void
}

define void @raw_buffer_atomic_cond_sub_imm_soff_no_return_forced(<4 x i32> inreg %rsrc, i32 inreg %data) #1 {
; GFX12-LABEL: raw_buffer_atomic_cond_sub_imm_soff_no_return_forced:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_mov_b32_e32 v0, s6
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, off, s[0:3], s4
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 4, i32 0)
  ret void
}

define float @struct_buffer_atomic_cond_sub_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: struct_buffer_atomic_cond_sub_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v0, s6
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, v1, s[0:3], null idxen th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %orig = call i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 0, i32 0)
  %r = bitcast i32 %orig to float
  ret float %r
}

define void @struct_buffer_atomic_cond_sub_no_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: struct_buffer_atomic_cond_sub_no_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s6
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v1, v0, s[0:3], null idxen th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define void @struct_buffer_atomic_cond_sub_no_return_forced(<4 x i32> inreg %rsrc, i32 inreg %data) #1 {
; GFX12-LABEL: struct_buffer_atomic_cond_sub_no_return_forced:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s6
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v1, v0, s[0:3], null idxen
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define float @struct_buffer_atomic_cond_sub_imm_soff_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: struct_buffer_atomic_cond_sub_imm_soff_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v0, s6
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v0, v1, s[0:3], s4 idxen th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %orig = call i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 4, i32 0)
  %r = bitcast i32 %orig to float
  ret float %r
}

define void @struct_buffer_atomic_cond_sub_imm_soff_no_return(<4 x i32> inreg %rsrc, i32 inreg %data) #0 {
; GFX12-LABEL: struct_buffer_atomic_cond_sub_imm_soff_no_return:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s6
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v1, v0, s[0:3], s4 idxen th:TH_ATOMIC_RETURN
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 4, i32 0)
  ret void
}

define void @struct_buffer_atomic_cond_sub_imm_soff_no_return_forced(<4 x i32> inreg %rsrc, i32 inreg %data) #1 {
; GFX12-LABEL: struct_buffer_atomic_cond_sub_imm_soff_no_return_forced:
; GFX12:       ; %bb.0: ; %main_body
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s6
; GFX12-NEXT:    s_mov_b32 s4, 4
; GFX12-NEXT:    buffer_atomic_cond_sub_u32 v1, v0, s[0:3], s4 idxen
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %unused = call i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32 %data, <4 x i32> %rsrc, i32 0, i32 0, i32 4, i32 0)
  ret void
}

declare i32 @llvm.amdgcn.raw.buffer.atomic.cond.sub.u32.i32(i32, <4 x i32>, i32, i32, i32) #0
declare i32 @llvm.amdgcn.struct.buffer.atomic.cond.sub.u32.i32(i32, <4 x i32>, i32, i32, i32, i32) #0

attributes #0 = { nounwind }
attributes #1 = { nounwind "target-features"="+atomic-csub-no-rtn-insts" }


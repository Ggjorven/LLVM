; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck %s --check-prefix=GFX12

define amdgpu_ps void @test_swmmac_f32_16x16x32_f16_index_key(<8 x half> %A, <16 x half> %B, <8 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_f16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v20, v[20:21], off
; GFX12-NEXT:    v_dual_mov_b32 v33, v19 :: v_dual_mov_b32 v32, v18
; GFX12-NEXT:    v_dual_mov_b32 v31, v17 :: v_dual_mov_b32 v30, v16
; GFX12-NEXT:    v_dual_mov_b32 v29, v15 :: v_dual_mov_b32 v28, v14
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[26:33], v[0:3], v[4:11], v20
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[12:19], v[0:3], v[4:11], v20 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[22:23], v[26:29], off
; GFX12-NEXT:    global_store_b128 v[22:23], v[30:33], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[24:25], v[12:15], off
; GFX12-NEXT:    global_store_b128 v[24:25], v[16:19], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f32.v8f16.v16f16.v8f32.i16(<8 x half> %A, <16 x half> %B, <8 x float> %C, i16 %Index0)
  store <8 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f32.v8f16.v16f16.v8f32.i16(<8 x half> %A, <16 x half> %B, <8 x float> %C, i16 %Index1)
  store <8 x float> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf16_index_key(<8 x i16> %A, <16 x i16> %B, <8 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v20, v[20:21], off
; GFX12-NEXT:    v_dual_mov_b32 v33, v19 :: v_dual_mov_b32 v32, v18
; GFX12-NEXT:    v_dual_mov_b32 v31, v17 :: v_dual_mov_b32 v30, v16
; GFX12-NEXT:    v_dual_mov_b32 v29, v15 :: v_dual_mov_b32 v28, v14
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[26:33], v[0:3], v[4:11], v20
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[12:19], v[0:3], v[4:11], v20 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[22:23], v[26:29], off
; GFX12-NEXT:    global_store_b128 v[22:23], v[30:33], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[24:25], v[12:15], off
; GFX12-NEXT:    global_store_b128 v[24:25], v[16:19], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v8f32.v8i16.v16i16.v8f32.i16(<8 x i16> %A, <16 x i16> %B, <8 x float> %C, i16 %Index0)
  store <8 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v8f32.v8i16.v16i16.v8f32.i16(<8 x i16> %A, <16 x i16> %B, <8 x float> %C, i16 %Index1)
  store <8 x float> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f16_16x16x32_f16_index_key(<8 x half> %A, <16 x half> %B, <8 x half> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f16_16x16x32_f16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v16, v[16:17], off
; GFX12-NEXT:    v_dual_mov_b32 v25, v15 :: v_dual_mov_b32 v24, v14
; GFX12-NEXT:    v_dual_mov_b32 v23, v13 :: v_dual_mov_b32 v22, v12
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[22:25], v[0:3], v[4:11], v16
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[12:15], v[0:3], v[4:11], v16 index_key:1
; GFX12-NEXT:    global_store_b128 v[18:19], v[22:25], off
; GFX12-NEXT:    global_store_b128 v[20:21], v[12:15], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v8f16.v16f16.v8f16.i16(<8 x half> %A, <16 x half> %B, <8 x half> %C, i16 %Index0)
  store <8 x half> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v8f16.v16f16.v8f16.i16(<8 x half> %A, <16 x half> %B, <8 x half> %C, i16 %Index1)
  store <8 x half> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_bf16_16x16x32_bf16_index_key(<8 x i16> %A, <16 x i16> %B, <8 x i16> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_bf16_16x16x32_bf16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v16, v[16:17], off
; GFX12-NEXT:    v_dual_mov_b32 v25, v15 :: v_dual_mov_b32 v24, v14
; GFX12-NEXT:    v_dual_mov_b32 v23, v13 :: v_dual_mov_b32 v22, v12
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[22:25], v[0:3], v[4:11], v16
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[12:15], v[0:3], v[4:11], v16 index_key:1
; GFX12-NEXT:    global_store_b128 v[18:19], v[22:25], off
; GFX12-NEXT:    global_store_b128 v[20:21], v[12:15], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v8i16.v8i16.v16i16.v8i16.i16(<8 x i16> %A, <16 x i16> %B, <8 x i16> %C, i16 %Index0)
  store <8 x i16> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v8i16.v8i16.v16i16.v8i16.i16(<8 x i16> %A, <16 x i16> %B, <8 x i16> %C, i16 %Index1)
  store <8 x i16> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu8_index_key(<2 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v14, v[14:15], off
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    v_dual_mov_b32 v25, v11 :: v_dual_mov_b32 v24, v10
; GFX12-NEXT:    v_dual_mov_b32 v23, v9 :: v_dual_mov_b32 v22, v8
; GFX12-NEXT:    v_dual_mov_b32 v21, v7 :: v_dual_mov_b32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[20:27], v[0:1], v[2:5], v14
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[6:13], v[0:1], v[2:5], v14 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[24:27], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[10:13], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v8i32.v2i32.v4i32.v8i32.i16(i1 0, <2 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i16 %Index0, i1 0)
  store <8 x i32> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v8i32.v2i32.v4i32.v8i32.i16(i1 0, <2 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i16 %Index1, i1 0)
  store <8 x i32> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu4_index_key(i32 %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu4_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v11, v[11:12], off
; GFX12-NEXT:    v_dual_mov_b32 v24, v10 :: v_dual_mov_b32 v23, v9
; GFX12-NEXT:    v_dual_mov_b32 v22, v8 :: v_dual_mov_b32 v21, v7
; GFX12-NEXT:    v_dual_mov_b32 v20, v6 :: v_dual_mov_b32 v19, v5
; GFX12-NEXT:    v_dual_mov_b32 v18, v4 :: v_dual_mov_b32 v17, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[17:24], v0, v[1:2], v11
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[3:10], v0, v[1:2], v11 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[13:14], v[17:20], off
; GFX12-NEXT:    global_store_b128 v[13:14], v[21:24], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[15:16], v[3:6], off
; GFX12-NEXT:    global_store_b128 v[15:16], v[7:10], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v8i32.i32.v2i32.v8i32.i16(i1 0, i32 %A, i1 0, <2 x i32> %B, <8 x i32> %C, i16 %Index0, i1 0)
  store <8 x i32> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v8i32.i32.v2i32.v8i32.i16(i1 0, i32 %A, i1 0, <2 x i32> %B, <8 x i32> %C, i16 %Index1, i1 0)
  store <8 x i32> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_fp8_fp8_index_key(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_fp8_fp8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v14, v[14:15], off
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    v_dual_mov_b32 v25, v11 :: v_dual_mov_b32 v24, v10
; GFX12-NEXT:    v_dual_mov_b32 v23, v9 :: v_dual_mov_b32 v22, v8
; GFX12-NEXT:    v_dual_mov_b32 v21, v7 :: v_dual_mov_b32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[20:27], v[0:1], v[2:5], v14
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[6:13], v[0:1], v[2:5], v14 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[24:27], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[10:13], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index0)
  store <8 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index1)
  store <8 x float> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_fp8_bf8_index_key(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_fp8_bf8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v14, v[14:15], off
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    v_dual_mov_b32 v25, v11 :: v_dual_mov_b32 v24, v10
; GFX12-NEXT:    v_dual_mov_b32 v23, v9 :: v_dual_mov_b32 v22, v8
; GFX12-NEXT:    v_dual_mov_b32 v21, v7 :: v_dual_mov_b32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[20:27], v[0:1], v[2:5], v14
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[6:13], v[0:1], v[2:5], v14 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[24:27], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[10:13], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index0)
  store <8 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index1)
  store <8 x float> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf8_fp8_index_key(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf8_fp8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v14, v[14:15], off
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    v_dual_mov_b32 v25, v11 :: v_dual_mov_b32 v24, v10
; GFX12-NEXT:    v_dual_mov_b32 v23, v9 :: v_dual_mov_b32 v22, v8
; GFX12-NEXT:    v_dual_mov_b32 v21, v7 :: v_dual_mov_b32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[20:27], v[0:1], v[2:5], v14
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[6:13], v[0:1], v[2:5], v14 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[24:27], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[10:13], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index0)
  store <8 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index1)
  store <8 x float> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf8_bf8_index_key(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf8_bf8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v14, v[14:15], off
; GFX12-NEXT:    v_dual_mov_b32 v27, v13 :: v_dual_mov_b32 v26, v12
; GFX12-NEXT:    v_dual_mov_b32 v25, v11 :: v_dual_mov_b32 v24, v10
; GFX12-NEXT:    v_dual_mov_b32 v23, v9 :: v_dual_mov_b32 v22, v8
; GFX12-NEXT:    v_dual_mov_b32 v21, v7 :: v_dual_mov_b32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[20:27], v[0:1], v[2:5], v14
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[6:13], v[0:1], v[2:5], v14 index_key:1
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[24:27], off offset:16
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[10:13], off offset:16
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index0)
  store <8 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32> %A, <4 x i32> %B, <8 x float> %C, i16 %Index1)
  store <8 x float> %res1, ptr addrspace(1) %out1
  ret void
}

declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f32.v8f16.v16f16.v8f32.i16(<8 x half>, <16 x half>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v8f32.v8i16.v16i16.v8f32.i16(<8 x i16>, <16 x i16>, <8 x float>, i16)
declare <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v8f16.v16f16.v8f16.i16(<8 x half>, <16 x half>, <8 x half>, i16)
declare <8 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v8i16.v8i16.v16i16.v8i16.i16(<8 x i16>, <16 x i16>, <8 x i16>, i16)
declare <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v8i32.v2i32.v4i32.v8i32.i16(i1 immarg, <2 x i32>, i1 immarg, <4 x i32>, <8 x i32>, i16 %Index, i1 immarg)
declare <8 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v8i32.i32.v2i32.v8i32.i16(i1 immarg, i32, i1 immarg, <2 x i32>, <8 x i32>, i16 %Index, i1 immarg)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v8f32.v2i32.v4i32.v8f32.i16(<2 x i32>, <4 x i32>, <8 x float>, i16)

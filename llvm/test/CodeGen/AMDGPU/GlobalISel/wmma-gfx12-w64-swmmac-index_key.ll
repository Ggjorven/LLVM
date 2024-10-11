; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize64 -verify-machineinstrs < %s | FileCheck %s --check-prefix=GFX12

define amdgpu_ps void @test_swmmac_f32_16x16x32_f16_index_key(<4 x half> %A, <8 x half> %B, <4 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_f16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v10, v[10:11], off
; GFX12-NEXT:    v_mov_b32_e32 v23, v9
; GFX12-NEXT:    v_mov_b32_e32 v22, v8
; GFX12-NEXT:    v_mov_b32_e32 v21, v7
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v9
; GFX12-NEXT:    v_mov_b32_e32 v26, v8
; GFX12-NEXT:    v_mov_b32_e32 v25, v7
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v31, v9
; GFX12-NEXT:    v_mov_b32_e32 v30, v8
; GFX12-NEXT:    v_mov_b32_e32 v29, v7
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[20:23], v[0:1], v[2:5], v10
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[24:27], v[0:1], v[2:5], v10 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[28:31], v[0:1], v[2:5], v10 index_key:2
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[6:9], v[0:1], v[2:5], v10 index_key:3
; GFX12-NEXT:    global_store_b128 v[12:13], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[14:15], v[24:27], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[28:31], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v4f32.v4f16.v8f16.v4f32.i8(<4 x half> %A, <8 x half> %B, <4 x float> %C, i8 %Index0)
  store <4 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v4f32.v4f16.v8f16.v4f32.i8(<4 x half> %A, <8 x half> %B, <4 x float> %C, i8 %Index1)
  store <4 x float> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v4f32.v4f16.v8f16.v4f32.i8(<4 x half> %A, <8 x half> %B, <4 x float> %C, i8 %Index2)
  store <4 x float> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v4f32.v4f16.v8f16.v4f32.i8(<4 x half> %A, <8 x half> %B, <4 x float> %C, i8 %Index3)
  store <4 x float> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf16_index_key(<4 x i16> %A, <8 x i16> %B, <4 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v10, v[10:11], off
; GFX12-NEXT:    v_mov_b32_e32 v23, v9
; GFX12-NEXT:    v_mov_b32_e32 v22, v8
; GFX12-NEXT:    v_mov_b32_e32 v21, v7
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v9
; GFX12-NEXT:    v_mov_b32_e32 v26, v8
; GFX12-NEXT:    v_mov_b32_e32 v25, v7
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v31, v9
; GFX12-NEXT:    v_mov_b32_e32 v30, v8
; GFX12-NEXT:    v_mov_b32_e32 v29, v7
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[20:23], v[0:1], v[2:5], v10
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[24:27], v[0:1], v[2:5], v10 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[28:31], v[0:1], v[2:5], v10 index_key:2
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf16 v[6:9], v[0:1], v[2:5], v10 index_key:3
; GFX12-NEXT:    global_store_b128 v[12:13], v[20:23], off
; GFX12-NEXT:    global_store_b128 v[14:15], v[24:27], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[28:31], off
; GFX12-NEXT:    global_store_b128 v[18:19], v[6:9], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v4f32.v4i16.v8i16.v4f32.i8(<4 x i16> %A, <8 x i16> %B, <4 x float> %C, i8 %Index0)
  store <4 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v4f32.v4i16.v8i16.v4f32.i8(<4 x i16> %A, <8 x i16> %B, <4 x float> %C, i8 %Index1)
  store <4 x float> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v4f32.v4i16.v8i16.v4f32.i8(<4 x i16> %A, <8 x i16> %B, <4 x float> %C, i8 %Index2)
  store <4 x float> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v4f32.v4i16.v8i16.v4f32.i8(<4 x i16> %A, <8 x i16> %B, <4 x float> %C, i8 %Index3)
  store <4 x float> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_f16_16x16x32_f16_index_key(<4 x half> %A, <8 x half> %B, <4 x half> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f16_16x16x32_f16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v22, v[8:9], off
; GFX12-NEXT:    v_mov_b32_e32 v9, v7
; GFX12-NEXT:    v_mov_b32_e32 v8, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v7
; GFX12-NEXT:    v_mov_b32_e32 v18, v6
; GFX12-NEXT:    v_mov_b32_e32 v21, v7
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[8:9], v[0:1], v[2:5], v22
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[18:19], v[0:1], v[2:5], v22 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[20:21], v[0:1], v[2:5], v22 index_key:2
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[6:7], v[0:1], v[2:5], v22 index_key:3
; GFX12-NEXT:    global_store_b64 v[10:11], v[8:9], off
; GFX12-NEXT:    global_store_b64 v[12:13], v[18:19], off
; GFX12-NEXT:    global_store_b64 v[14:15], v[20:21], off
; GFX12-NEXT:    global_store_b64 v[16:17], v[6:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v4f16.v4f16.v8f16.v4f16.i8(<4 x half> %A, <8 x half> %B, <4 x half> %C, i8 %Index0)
  store <4 x half> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v4f16.v4f16.v8f16.v4f16.i8(<4 x half> %A, <8 x half> %B, <4 x half> %C, i8 %Index1)
  store <4 x half> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v4f16.v4f16.v8f16.v4f16.i8(<4 x half> %A, <8 x half> %B, <4 x half> %C, i8 %Index2)
  store <4 x half> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v4f16.v4f16.v8f16.v4f16.i8(<4 x half> %A, <8 x half> %B, <4 x half> %C, i8 %Index3)
  store <4 x half> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_bf16_16x16x32_bf16_index_key(<4 x i16> %A, <8 x i16> %B, <4 x i16> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_bf16_16x16x32_bf16_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v22, v[8:9], off
; GFX12-NEXT:    v_mov_b32_e32 v9, v7
; GFX12-NEXT:    v_mov_b32_e32 v8, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v7
; GFX12-NEXT:    v_mov_b32_e32 v18, v6
; GFX12-NEXT:    v_mov_b32_e32 v21, v7
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[8:9], v[0:1], v[2:5], v22
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[18:19], v[0:1], v[2:5], v22 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[20:21], v[0:1], v[2:5], v22 index_key:2
; GFX12-NEXT:    v_swmmac_bf16_16x16x32_bf16 v[6:7], v[0:1], v[2:5], v22 index_key:3
; GFX12-NEXT:    global_store_b64 v[10:11], v[8:9], off
; GFX12-NEXT:    global_store_b64 v[12:13], v[18:19], off
; GFX12-NEXT:    global_store_b64 v[14:15], v[20:21], off
; GFX12-NEXT:    global_store_b64 v[16:17], v[6:7], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v4i16.v4i16.v8i16.v4i16.i8(<4 x i16> %A, <8 x i16> %B, <4 x i16> %C, i8 %Index0)
  store <4 x i16> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v4i16.v4i16.v8i16.v4i16.i8(<4 x i16> %A, <8 x i16> %B, <4 x i16> %C, i8 %Index1)
  store <4 x i16> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v4i16.v4i16.v8i16.v4i16.i8(<4 x i16> %A, <8 x i16> %B, <4 x i16> %C, i8 %Index2)
  store <4 x i16> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v4i16.v4i16.v8i16.v4i16.i8(<4 x i16> %A, <8 x i16> %B, <4 x i16> %C, i8 %Index3)
  store <4 x i16> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu8_index_key(i32 %A, <2 x i32> %B, <4 x i32> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v7, v[7:8], off
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v5
; GFX12-NEXT:    v_mov_b32_e32 v18, v4
; GFX12-NEXT:    v_mov_b32_e32 v17, v3
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v23, v5
; GFX12-NEXT:    v_mov_b32_e32 v22, v4
; GFX12-NEXT:    v_mov_b32_e32 v21, v3
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v5
; GFX12-NEXT:    v_mov_b32_e32 v26, v4
; GFX12-NEXT:    v_mov_b32_e32 v25, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[17:20], v0, v[1:2], v7
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[21:24], v0, v[1:2], v7 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[25:28], v0, v[1:2], v7 index_key:2
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[3:6], v0, v[1:2], v7 index_key:3
; GFX12-NEXT:    global_store_b128 v[9:10], v[17:20], off
; GFX12-NEXT:    global_store_b128 v[11:12], v[21:24], off
; GFX12-NEXT:    global_store_b128 v[13:14], v[25:28], off
; GFX12-NEXT:    global_store_b128 v[15:16], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i8 %Index0, i1 0)
  store <4 x i32> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i8 %Index1, i1 0)
  store <4 x i32> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i8 %Index2, i1 0)
  store <4 x i32> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i8 %Index3, i1 0)
  store <4 x i32> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu4_index_key(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu4_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v6, v[6:7], off
; GFX12-NEXT:    v_mov_b32_e32 v15, v5
; GFX12-NEXT:    v_mov_b32_e32 v14, v4
; GFX12-NEXT:    v_mov_b32_e32 v13, v3
; GFX12-NEXT:    v_mov_b32_e32 v12, v2
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[12:15], v0, v1, v6
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[2:5], v0, v1, v6 index_key:1
; GFX12-NEXT:    global_store_b128 v[8:9], v[12:15], off
; GFX12-NEXT:    global_store_b128 v[10:11], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 0, i32 %A, i1 0, i32 %B, <4 x i32> %C, i16 %Index0, i1 0)
  store <4 x i32> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 0, i32 %A, i1 0, i32 %B, <4 x i32> %C, i16 %Index1, i1 0)
  store <4 x i32> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x64_iu4_index_key(i32 %A, <2 x i32> %B, <4 x i32> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1) {
; GFX12-LABEL: test_swmmac_i32_16x16x64_iu4_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v7, v[7:8], off
; GFX12-NEXT:    v_mov_b32_e32 v16, v6
; GFX12-NEXT:    v_mov_b32_e32 v15, v5
; GFX12-NEXT:    v_mov_b32_e32 v14, v4
; GFX12-NEXT:    v_mov_b32_e32 v13, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_swmmac_i32_16x16x64_iu4 v[13:16], v0, v[1:2], v7
; GFX12-NEXT:    v_swmmac_i32_16x16x64_iu4 v[3:6], v0, v[1:2], v7 index_key:1
; GFX12-NEXT:    global_store_b128 v[9:10], v[13:16], off
; GFX12-NEXT:    global_store_b128 v[11:12], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <2 x i16>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <2 x i16> %IndexVec, i32 0
  %res0 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i16 %Index0, i1 0)
  store <4 x i32> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <2 x i16> %IndexVec, i32 1
  %res1 = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i16 %Index1, i1 0)
  store <4 x i32> %res1, ptr addrspace(1) %out1
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_fp8_fp8_index_key(i32 %A, <2 x i32> %B, <4 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_fp8_fp8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v7, v[7:8], off
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v5
; GFX12-NEXT:    v_mov_b32_e32 v18, v4
; GFX12-NEXT:    v_mov_b32_e32 v17, v3
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v23, v5
; GFX12-NEXT:    v_mov_b32_e32 v22, v4
; GFX12-NEXT:    v_mov_b32_e32 v21, v3
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v5
; GFX12-NEXT:    v_mov_b32_e32 v26, v4
; GFX12-NEXT:    v_mov_b32_e32 v25, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[17:20], v0, v[1:2], v7
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[21:24], v0, v[1:2], v7 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[25:28], v0, v[1:2], v7 index_key:2
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_fp8 v[3:6], v0, v[1:2], v7 index_key:3
; GFX12-NEXT:    global_store_b128 v[9:10], v[17:20], off
; GFX12-NEXT:    global_store_b128 v[11:12], v[21:24], off
; GFX12-NEXT:    global_store_b128 v[13:14], v[25:28], off
; GFX12-NEXT:    global_store_b128 v[15:16], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index0)
  store <4 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index1)
  store <4 x float> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index2)
  store <4 x float> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index3)
  store <4 x float> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_fp8_bf8_index_key(i32 %A, <2 x i32> %B, <4 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_fp8_bf8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v7, v[7:8], off
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v5
; GFX12-NEXT:    v_mov_b32_e32 v18, v4
; GFX12-NEXT:    v_mov_b32_e32 v17, v3
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v23, v5
; GFX12-NEXT:    v_mov_b32_e32 v22, v4
; GFX12-NEXT:    v_mov_b32_e32 v21, v3
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v5
; GFX12-NEXT:    v_mov_b32_e32 v26, v4
; GFX12-NEXT:    v_mov_b32_e32 v25, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[17:20], v0, v[1:2], v7
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[21:24], v0, v[1:2], v7 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[25:28], v0, v[1:2], v7 index_key:2
; GFX12-NEXT:    v_swmmac_f32_16x16x32_fp8_bf8 v[3:6], v0, v[1:2], v7 index_key:3
; GFX12-NEXT:    global_store_b128 v[9:10], v[17:20], off
; GFX12-NEXT:    global_store_b128 v[11:12], v[21:24], off
; GFX12-NEXT:    global_store_b128 v[13:14], v[25:28], off
; GFX12-NEXT:    global_store_b128 v[15:16], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index0)
  store <4 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index1)
  store <4 x float> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index2)
  store <4 x float> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index3)
  store <4 x float> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf8_fp8_index_key(i32 %A, <2 x i32> %B, <4 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf8_fp8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v7, v[7:8], off
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v5
; GFX12-NEXT:    v_mov_b32_e32 v18, v4
; GFX12-NEXT:    v_mov_b32_e32 v17, v3
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v23, v5
; GFX12-NEXT:    v_mov_b32_e32 v22, v4
; GFX12-NEXT:    v_mov_b32_e32 v21, v3
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v5
; GFX12-NEXT:    v_mov_b32_e32 v26, v4
; GFX12-NEXT:    v_mov_b32_e32 v25, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[17:20], v0, v[1:2], v7
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[21:24], v0, v[1:2], v7 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[25:28], v0, v[1:2], v7 index_key:2
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_fp8 v[3:6], v0, v[1:2], v7 index_key:3
; GFX12-NEXT:    global_store_b128 v[9:10], v[17:20], off
; GFX12-NEXT:    global_store_b128 v[11:12], v[21:24], off
; GFX12-NEXT:    global_store_b128 v[13:14], v[25:28], off
; GFX12-NEXT:    global_store_b128 v[15:16], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index0)
  store <4 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index1)
  store <4 x float> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index2)
  store <4 x float> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index3)
  store <4 x float> %res3, ptr addrspace(1) %out3
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_bf8_bf8_index_key(i32 %A, <2 x i32> %B, <4 x float> %C, ptr addrspace(1) %IndexVecPtr, ptr addrspace(1) %out0, ptr addrspace(1) %out1, ptr addrspace(1) %out2, ptr addrspace(1) %out3) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_bf8_bf8_index_key:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    global_load_b32 v7, v[7:8], off
; GFX12-NEXT:    v_mov_b32_e32 v20, v6
; GFX12-NEXT:    v_mov_b32_e32 v19, v5
; GFX12-NEXT:    v_mov_b32_e32 v18, v4
; GFX12-NEXT:    v_mov_b32_e32 v17, v3
; GFX12-NEXT:    v_mov_b32_e32 v24, v6
; GFX12-NEXT:    v_mov_b32_e32 v23, v5
; GFX12-NEXT:    v_mov_b32_e32 v22, v4
; GFX12-NEXT:    v_mov_b32_e32 v21, v3
; GFX12-NEXT:    v_mov_b32_e32 v28, v6
; GFX12-NEXT:    v_mov_b32_e32 v27, v5
; GFX12-NEXT:    v_mov_b32_e32 v26, v4
; GFX12-NEXT:    v_mov_b32_e32 v25, v3
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[17:20], v0, v[1:2], v7
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[21:24], v0, v[1:2], v7 index_key:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_3)
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[25:28], v0, v[1:2], v7 index_key:2
; GFX12-NEXT:    v_swmmac_f32_16x16x32_bf8_bf8 v[3:6], v0, v[1:2], v7 index_key:3
; GFX12-NEXT:    global_store_b128 v[9:10], v[17:20], off
; GFX12-NEXT:    global_store_b128 v[11:12], v[21:24], off
; GFX12-NEXT:    global_store_b128 v[13:14], v[25:28], off
; GFX12-NEXT:    global_store_b128 v[15:16], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %IndexVec = load <4 x i8>, ptr addrspace(1) %IndexVecPtr, align 4
  %Index0 = extractelement <4 x i8> %IndexVec, i32 0
  %res0 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index0)
  store <4 x float> %res0, ptr addrspace(1) %out0
  %Index1 = extractelement <4 x i8> %IndexVec, i32 1
  %res1 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index1)
  store <4 x float> %res1, ptr addrspace(1) %out1
  %Index2 = extractelement <4 x i8> %IndexVec, i32 2
  %res2 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index2)
  store <4 x float> %res2, ptr addrspace(1) %out2
  %Index3 = extractelement <4 x i8> %IndexVec, i32 3
  %res3 = call <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v4f32.i32.v2i32.v4f32.i8(i32 %A, <2 x i32> %B, <4 x float> %C, i8 %Index3)
  store <4 x float> %res3, ptr addrspace(1) %out3
  ret void
}

declare <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v4f32.v4f16.v8f16.v4f32.i8(<4 x half>, <8 x half>, <4 x float>, i8)
declare <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf16.v4f32.v4i16.v8i16.v4f32.i8(<4 x i16>, <8 x i16>, <4 x float>, i8)
declare <4 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v4f16.v4f16.v8f16.v4f16.i8(<4 x half>, <8 x half>, <4 x half>, i8)
declare <4 x i16> @llvm.amdgcn.swmmac.bf16.16x16x32.bf16.v4i16.v4i16.v8i16.v4i16.i8(<4 x i16>, <8 x i16>, <4 x i16>, i8)
declare <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 immarg, i32, i1 immarg, <2 x i32>, <4 x i32>, i8 %Index, i1 immarg)
declare <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 immarg, i32, i1 immarg, i32, <4 x i32>, i16 %Index, i1 immarg)
declare <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 immarg, i32, i1 immarg, <2 x i32>, <4 x i32>, i16 %Index, i1 immarg)
declare <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.fp8.v4f32.i32.v2i32.v4f32.i8(i32, <2 x i32>, <4 x float>, i8)
declare <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.fp8.bf8.v4f32.i32.v2i32.v4f32.i8(i32, <2 x i32>, <4 x float>, i8)
declare <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.fp8.v4f32.i32.v2i32.v4f32.i8(i32, <2 x i32>, <4 x float>, i8)
declare <4 x float> @llvm.amdgcn.swmmac.f32.16x16x32.bf8.bf8.v4f32.i32.v2i32.v4f32.i8(i32, <2 x i32>, <4 x float>, i8)

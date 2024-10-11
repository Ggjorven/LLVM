; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,DAG %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs -global-isel=1 < %s | FileCheck -check-prefixes=GCN,GISEL %s

define amdgpu_ps void @test_s_load_i8(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_i8:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_i8 s0, s[0:1], 0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %ld = load i8, ptr addrspace(4) %in
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i8_imm(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; DAG-LABEL: test_s_load_i8_imm:
; DAG:       ; %bb.0:
; DAG-NEXT:    s_movk_i32 s2, 0xff9c
; DAG-NEXT:    s_mov_b32 s3, -1
; DAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; DAG-NEXT:    s_add_nc_u64 s[0:1], s[0:1], s[2:3]
; DAG-NEXT:    s_load_i8 s0, s[0:1], 0x0
; DAG-NEXT:    s_wait_kmcnt 0x0
; DAG-NEXT:    v_mov_b32_e32 v2, s0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: test_s_load_i8_imm:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_add_co_u32 s0, s0, 0xffffff9c
; GISEL-NEXT:    s_add_co_ci_u32 s1, s1, -1
; GISEL-NEXT:    s_load_i8 s0, s[0:1], 0x0
; GISEL-NEXT:    s_wait_kmcnt 0x0
; GISEL-NEXT:    v_mov_b32_e32 v2, s0
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
  %gep = getelementptr i8, ptr addrspace(4) %in, i64 -100
  %ld = load i8, ptr addrspace(4) %gep
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i8_sgpr(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_i8_sgpr:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_i8 s0, s[0:1], s2 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %zext = zext i32 %offset to i64
  %gep = getelementptr i8, ptr addrspace(4) %in, i64 %zext
  %ld = load i8, ptr addrspace(4) %gep
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i8_sgpr_imm(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_i8_sgpr_imm:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_i8 s0, s[0:1], s2 offset:0x10
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %gep1 = getelementptr i8, ptr addrspace(4) %in, i64 16
  %zext = zext i32 %offset to i64
  %gep2 = getelementptr i8, ptr addrspace(4) %gep1, i64 %zext
  %ld = load i8, ptr addrspace(4) %gep2
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i8_divergent(ptr addrspace(4) inreg %in, i32 %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_i8_divergent:
; GCN:       ; %bb.0:
; GCN-NEXT:    global_load_i8 v0, v0, s[0:1] offset:16
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    global_store_b32 v[1:2], v0, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %gep1 = getelementptr i8, ptr addrspace(4) %in, i64 16
  %zext = zext i32 %offset to i64
  %gep2 = getelementptr i8, ptr addrspace(4) %gep1, i64 %zext
  %ld = load i8, ptr addrspace(4) %gep2
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u8(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u8:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u8 s0, s[0:1], 0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %ld = load i8, ptr addrspace(4) %in
  %zext = zext i8 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u8_imm(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u8_imm:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u8 s0, s[0:1], 0xff
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %gep = getelementptr i8, ptr addrspace(4) %in, i64 255
  %ld = load i8, ptr addrspace(4) %gep
  %zext = zext i8 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u8_sgpr(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u8_sgpr:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u8 s0, s[0:1], s2 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %zext1 = zext i32 %offset to i64
  %gep = getelementptr i8, ptr addrspace(4) %in, i64 %zext1
  %ld = load i8, ptr addrspace(4) %gep
  %zext2 = zext i8 %ld to i32
  store i32 %zext2, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u8_sgpr_imm(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u8_sgpr_imm:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u8 s0, s[0:1], s2 offset:0x10
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %gep1 = getelementptr i8, ptr addrspace(4) %in, i64 16
  %zext1= zext i32 %offset to i64
  %gep2 = getelementptr i8, ptr addrspace(4) %gep1, i64 %zext1
  %ld = load i8, ptr addrspace(4) %gep2
  %zext2= zext i8 %ld to i32
  store i32 %zext2, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u8_divergent(ptr addrspace(4) inreg %in, i32 %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u8_divergent:
; GCN:       ; %bb.0:
; GCN-NEXT:    global_load_u8 v0, v0, s[0:1] offset:16
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    global_store_b32 v[1:2], v0, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %gep1 = getelementptr i8, ptr addrspace(4) %in, i64 16
  %zext1= zext i32 %offset to i64
  %gep2 = getelementptr i8, ptr addrspace(4) %gep1, i64 %zext1
  %ld = load i8, ptr addrspace(4) %gep2
  %zext2= zext i8 %ld to i32
  store i32 %zext2, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i16(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_i16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_i16 s0, s[0:1], 0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %ld = load i16, ptr addrspace(4) %in
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i16_imm(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; DAG-LABEL: test_s_load_i16_imm:
; DAG:       ; %bb.0:
; DAG-NEXT:    s_movk_i32 s2, 0xff38
; DAG-NEXT:    s_mov_b32 s3, -1
; DAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; DAG-NEXT:    s_add_nc_u64 s[0:1], s[0:1], s[2:3]
; DAG-NEXT:    s_load_i16 s0, s[0:1], 0x0
; DAG-NEXT:    s_wait_kmcnt 0x0
; DAG-NEXT:    v_mov_b32_e32 v2, s0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: test_s_load_i16_imm:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_add_co_u32 s0, s0, 0xffffff38
; GISEL-NEXT:    s_add_co_ci_u32 s1, s1, -1
; GISEL-NEXT:    s_load_i16 s0, s[0:1], 0x0
; GISEL-NEXT:    s_wait_kmcnt 0x0
; GISEL-NEXT:    v_mov_b32_e32 v2, s0
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
  %gep = getelementptr i16, ptr addrspace(4) %in, i64 -100
  %ld = load i16, ptr addrspace(4) %gep
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i16_sgpr(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_i16_sgpr:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_i16 s0, s[0:1], s2 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %zext = zext i32 %offset to i64
  %gep = getelementptr i8, ptr addrspace(4) %in, i64 %zext
  %ld = load i16, ptr addrspace(4) %gep
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i16_sgpr_imm(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; DAG-LABEL: test_s_load_i16_sgpr_imm:
; DAG:       ; %bb.0:
; DAG-NEXT:    s_mov_b32 s3, 0
; DAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; DAG-NEXT:    s_lshl_b64 s[2:3], s[2:3], 1
; DAG-NEXT:    s_add_nc_u64 s[0:1], s[0:1], s[2:3]
; DAG-NEXT:    s_load_i16 s0, s[0:1], 0x20
; DAG-NEXT:    s_wait_kmcnt 0x0
; DAG-NEXT:    v_mov_b32_e32 v2, s0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: test_s_load_i16_sgpr_imm:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_mov_b32 s3, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_lshl_b64 s[2:3], s[2:3], 1
; GISEL-NEXT:    s_add_co_u32 s0, s0, s2
; GISEL-NEXT:    s_add_co_ci_u32 s1, s1, s3
; GISEL-NEXT:    s_load_i16 s0, s[0:1], 0x20
; GISEL-NEXT:    s_wait_kmcnt 0x0
; GISEL-NEXT:    v_mov_b32_e32 v2, s0
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
  %gep1 = getelementptr i16, ptr addrspace(4) %in, i64 16
  %zext = zext i32 %offset to i64
  %gep2 = getelementptr i16, ptr addrspace(4) %gep1, i64 %zext
  %ld = load i16, ptr addrspace(4) %gep2
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_i16_divergent(ptr addrspace(4) inreg %in, i32 %offset, ptr addrspace(1) %out) {
; DAG-LABEL: test_s_load_i16_divergent:
; DAG:       ; %bb.0:
; DAG-NEXT:    v_dual_mov_b32 v3, v0 :: v_dual_mov_b32 v4, 0
; DAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; DAG-NEXT:    v_lshlrev_b64_e32 v[3:4], 1, v[3:4]
; DAG-NEXT:    v_add_co_u32 v3, vcc_lo, s0, v3
; DAG-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; DAG-NEXT:    v_add_co_ci_u32_e32 v4, vcc_lo, s1, v4, vcc_lo
; DAG-NEXT:    global_load_i16 v0, v[3:4], off offset:32
; DAG-NEXT:    s_wait_loadcnt 0x0
; DAG-NEXT:    global_store_b32 v[1:2], v0, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: test_s_load_i16_divergent:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    v_dual_mov_b32 v3, v1 :: v_dual_mov_b32 v4, v2
; GISEL-NEXT:    v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v6, s1
; GISEL-NEXT:    v_mov_b32_e32 v5, s0
; GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
; GISEL-NEXT:    v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
; GISEL-NEXT:    v_add_co_u32 v0, vcc_lo, v5, v0
; GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; GISEL-NEXT:    v_add_co_ci_u32_e32 v1, vcc_lo, v6, v1, vcc_lo
; GISEL-NEXT:    global_load_i16 v0, v[0:1], off offset:32
; GISEL-NEXT:    s_wait_loadcnt 0x0
; GISEL-NEXT:    global_store_b32 v[3:4], v0, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
  %gep1 = getelementptr i16, ptr addrspace(4) %in, i64 16
  %zext = zext i32 %offset to i64
  %gep2 = getelementptr i16, ptr addrspace(4) %gep1, i64 %zext
  %ld = load i16, ptr addrspace(4) %gep2
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u16(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u16 s0, s[0:1], 0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %ld = load i16, ptr addrspace(4) %in
  %zext = zext i16 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u16_imm(ptr addrspace(4) inreg %in, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u16_imm:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u16 s0, s[0:1], 0x1fe
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %gep = getelementptr i16, ptr addrspace(4) %in, i64 255
  %ld = load i16, ptr addrspace(4) %gep
  %zext = zext i16 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u16_sgpr(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; GCN-LABEL: test_s_load_u16_sgpr:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_u16 s0, s[0:1], s2 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
  %zext1 = zext i32 %offset to i64
  %gep = getelementptr i8, ptr addrspace(4) %in, i64 %zext1
  %ld = load i16, ptr addrspace(4) %gep
  %zext2 = zext i16 %ld to i32
  store i32 %zext2, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u16_sgpr_imm(ptr addrspace(4) inreg %in, i32 inreg %offset, ptr addrspace(1) %out) {
; DAG-LABEL: test_s_load_u16_sgpr_imm:
; DAG:       ; %bb.0:
; DAG-NEXT:    s_mov_b32 s3, 0
; DAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; DAG-NEXT:    s_lshl_b64 s[2:3], s[2:3], 1
; DAG-NEXT:    s_add_nc_u64 s[0:1], s[0:1], s[2:3]
; DAG-NEXT:    s_load_u16 s0, s[0:1], 0x20
; DAG-NEXT:    s_wait_kmcnt 0x0
; DAG-NEXT:    v_mov_b32_e32 v2, s0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: test_s_load_u16_sgpr_imm:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_mov_b32 s3, 0
; GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GISEL-NEXT:    s_lshl_b64 s[2:3], s[2:3], 1
; GISEL-NEXT:    s_add_co_u32 s0, s0, s2
; GISEL-NEXT:    s_add_co_ci_u32 s1, s1, s3
; GISEL-NEXT:    s_load_u16 s0, s[0:1], 0x20
; GISEL-NEXT:    s_wait_kmcnt 0x0
; GISEL-NEXT:    v_mov_b32_e32 v2, s0
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
  %gep1 = getelementptr i16, ptr addrspace(4) %in, i64 16
  %zext1= zext i32 %offset to i64
  %gep2 = getelementptr i16, ptr addrspace(4) %gep1, i64 %zext1
  %ld = load i16, ptr addrspace(4) %gep2
  %zext2= zext i16 %ld to i32
  store i32 %zext2, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_s_load_u16_divergent(ptr addrspace(4) inreg %in, i32 %offset, ptr addrspace(1) %out) {
; DAG-LABEL: test_s_load_u16_divergent:
; DAG:       ; %bb.0:
; DAG-NEXT:    v_dual_mov_b32 v3, v0 :: v_dual_mov_b32 v4, 0
; DAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; DAG-NEXT:    v_lshlrev_b64_e32 v[3:4], 1, v[3:4]
; DAG-NEXT:    v_add_co_u32 v3, vcc_lo, s0, v3
; DAG-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; DAG-NEXT:    v_add_co_ci_u32_e32 v4, vcc_lo, s1, v4, vcc_lo
; DAG-NEXT:    global_load_u16 v0, v[3:4], off offset:32
; DAG-NEXT:    s_wait_loadcnt 0x0
; DAG-NEXT:    global_store_b32 v[1:2], v0, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: test_s_load_u16_divergent:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    v_dual_mov_b32 v3, v1 :: v_dual_mov_b32 v4, v2
; GISEL-NEXT:    v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v6, s1
; GISEL-NEXT:    v_mov_b32_e32 v5, s0
; GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
; GISEL-NEXT:    v_lshlrev_b64_e32 v[0:1], 1, v[0:1]
; GISEL-NEXT:    v_add_co_u32 v0, vcc_lo, v5, v0
; GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; GISEL-NEXT:    v_add_co_ci_u32_e32 v1, vcc_lo, v6, v1, vcc_lo
; GISEL-NEXT:    global_load_u16 v0, v[0:1], off offset:32
; GISEL-NEXT:    s_wait_loadcnt 0x0
; GISEL-NEXT:    global_store_b32 v[3:4], v0, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
  %gep1 = getelementptr i16, ptr addrspace(4) %in, i64 16
  %zext1= zext i32 %offset to i64
  %gep2 = getelementptr i16, ptr addrspace(4) %gep1, i64 %zext1
  %ld = load i16, ptr addrspace(4) %gep2
  %zext2= zext i16 %ld to i32
  store i32 %zext2, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_byte_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out) {
; GCN-LABEL: s_buffer_load_byte_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_i8 s0, s[0:3], 0x4
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i8 @llvm.amdgcn.s.buffer.load.i8(<4 x i32> %src, i32 4, i32 0)
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_byte_sgpr(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %offset) {
; GCN-LABEL: s_buffer_load_byte_sgpr:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_i8 s0, s[0:3], s4 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i8 @llvm.amdgcn.s.buffer.load.i8(<4 x i32> %src, i32 %offset, i32 0)
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_byte_sgpr_or_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %in) {
; GCN-LABEL: s_buffer_load_byte_sgpr_or_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_i8 s0, s[0:3], s4 offset:0x64
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %off = add nuw nsw i32 %in, 100
  %ld = call i8 @llvm.amdgcn.s.buffer.load.i8(<4 x i32> %src, i32 %off, i32 0)
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_byte_sgpr_or_imm_offset_divergent(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 %offset) {
; DAG-LABEL: s_buffer_load_byte_sgpr_or_imm_offset_divergent:
; DAG:       ; %bb.0: ; %main_body
; DAG-NEXT:    buffer_load_i8 v2, v2, s[0:3], null offen
; DAG-NEXT:    s_wait_loadcnt 0x0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: s_buffer_load_byte_sgpr_or_imm_offset_divergent:
; GISEL:       ; %bb.0: ; %main_body
; GISEL-NEXT:    buffer_load_b32 v2, v2, s[0:3], null offen
; GISEL-NEXT:    s_wait_loadcnt 0x0
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
main_body:
  %ld = call i8 @llvm.amdgcn.s.buffer.load.i8(<4 x i32> %src, i32 %offset, i32 0)
  %sext = sext i8 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ubyte_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out) {
; GCN-LABEL: s_buffer_load_ubyte_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_u8 s0, s[0:3], 0x4
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    s_and_b32 s0, s0, 0xff
; GCN-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i8 @llvm.amdgcn.s.buffer.load.u8(<4 x i32> %src, i32 4, i32 0)
  %zext = zext i8 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ubyte_sgpr(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %offset) {
; GCN-LABEL: s_buffer_load_ubyte_sgpr:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_u8 s0, s[0:3], s4 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    s_and_b32 s0, s0, 0xff
; GCN-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i8 @llvm.amdgcn.s.buffer.load.u8(<4 x i32> %src, i32 %offset, i32 0)
  %zext = zext i8 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ubyte_sgpr_or_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %in) {
; GCN-LABEL: s_buffer_load_ubyte_sgpr_or_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_u8 s0, s[0:3], s4 offset:0x64
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    s_and_b32 s0, s0, 0xff
; GCN-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %off = add nuw nsw i32 %in, 100
  %ld = call i8 @llvm.amdgcn.s.buffer.load.u8(<4 x i32> %src, i32 %off, i32 0)
  %zext = zext i8 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ubyte_sgpr_or_imm_offset_divergent(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 %offset) {
; DAG-LABEL: s_buffer_load_ubyte_sgpr_or_imm_offset_divergent:
; DAG:       ; %bb.0: ; %main_body
; DAG-NEXT:    buffer_load_u8 v2, v2, s[0:3], null offen
; DAG-NEXT:    s_wait_loadcnt 0x0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: s_buffer_load_ubyte_sgpr_or_imm_offset_divergent:
; GISEL:       ; %bb.0: ; %main_body
; GISEL-NEXT:    buffer_load_b32 v2, v2, s[0:3], null offen
; GISEL-NEXT:    s_wait_loadcnt 0x0
; GISEL-NEXT:    v_and_b32_e32 v2, 0xff, v2
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
main_body:
  %ld = call i8 @llvm.amdgcn.s.buffer.load.u8(<4 x i32> %src, i32 %offset, i32 0)
  %zext = zext i8 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_short_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out) {
; GCN-LABEL: s_buffer_load_short_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_i16 s0, s[0:3], 0x4
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i16 @llvm.amdgcn.s.buffer.load.i16(<4 x i32> %src, i32 4, i32 0)
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_short_sgpr(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %offset) {
; GCN-LABEL: s_buffer_load_short_sgpr:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_i16 s0, s[0:3], s4 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i16 @llvm.amdgcn.s.buffer.load.i16(<4 x i32> %src, i32 %offset, i32 0)
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_short_sgpr_or_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %in) {
; GCN-LABEL: s_buffer_load_short_sgpr_or_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_i16 s0, s[0:3], s4 offset:0x64
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %off = add nuw nsw i32 %in, 100
  %ld = call i16 @llvm.amdgcn.s.buffer.load.i16(<4 x i32> %src, i32 %off, i32 0)
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_short_sgpr_or_imm_offset_divergent(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 %offset) {
; DAG-LABEL: s_buffer_load_short_sgpr_or_imm_offset_divergent:
; DAG:       ; %bb.0: ; %main_body
; DAG-NEXT:    buffer_load_i16 v2, v2, s[0:3], null offen
; DAG-NEXT:    s_wait_loadcnt 0x0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: s_buffer_load_short_sgpr_or_imm_offset_divergent:
; GISEL:       ; %bb.0: ; %main_body
; GISEL-NEXT:    buffer_load_b32 v2, v2, s[0:3], null offen
; GISEL-NEXT:    s_wait_loadcnt 0x0
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
main_body:
  %ld = call i16 @llvm.amdgcn.s.buffer.load.i16(<4 x i32> %src, i32 %offset, i32 0)
  %sext = sext i16 %ld to i32
  store i32 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ushort_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out) {
; GCN-LABEL: s_buffer_load_ushort_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_u16 s0, s[0:3], 0x4
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    s_and_b32 s0, s0, 0xffff
; GCN-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i16 @llvm.amdgcn.s.buffer.load.u16(<4 x i32> %src, i32 4, i32 0)
  %zext = zext i16 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ushort_sgpr(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %offset) {
; GCN-LABEL: s_buffer_load_ushort_sgpr:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_u16 s0, s[0:3], s4 offset:0x0
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    s_and_b32 s0, s0, 0xffff
; GCN-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %ld = call i16 @llvm.amdgcn.s.buffer.load.u16(<4 x i32> %src, i32 %offset, i32 0)
  %zext = zext i16 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ushort_sgpr_or_imm_offset(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 inreg %in) {
; GCN-LABEL: s_buffer_load_ushort_sgpr_or_imm_offset:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_buffer_load_u16 s0, s[0:3], s4 offset:0x64
; GCN-NEXT:    s_wait_kmcnt 0x0
; GCN-NEXT:    s_and_b32 s0, s0, 0xffff
; GCN-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_b32 v[0:1], v2, off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GCN-NEXT:    s_endpgm
main_body:
  %off = add nuw nsw i32 %in, 100
  %ld = call i16 @llvm.amdgcn.s.buffer.load.u16(<4 x i32> %src, i32 %off, i32 0)
  %zext = zext i16 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @s_buffer_load_ushort_sgpr_or_imm_offset_divergent(<4 x i32> inreg %src, ptr addrspace(1) nocapture %out, i32 %offset) {
; DAG-LABEL: s_buffer_load_ushort_sgpr_or_imm_offset_divergent:
; DAG:       ; %bb.0: ; %main_body
; DAG-NEXT:    buffer_load_u16 v2, v2, s[0:3], null offen
; DAG-NEXT:    s_wait_loadcnt 0x0
; DAG-NEXT:    global_store_b32 v[0:1], v2, off
; DAG-NEXT:    s_nop 0
; DAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; DAG-NEXT:    s_endpgm
;
; GISEL-LABEL: s_buffer_load_ushort_sgpr_or_imm_offset_divergent:
; GISEL:       ; %bb.0: ; %main_body
; GISEL-NEXT:    buffer_load_b32 v2, v2, s[0:3], null offen
; GISEL-NEXT:    s_wait_loadcnt 0x0
; GISEL-NEXT:    v_and_b32_e32 v2, 0xffff, v2
; GISEL-NEXT:    global_store_b32 v[0:1], v2, off
; GISEL-NEXT:    s_nop 0
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
main_body:
  %ld = call i16 @llvm.amdgcn.s.buffer.load.u16(<4 x i32> %src, i32 %offset, i32 0)
  %zext = zext i16 %ld to i32
  store i32 %zext, ptr addrspace(1) %out
  ret void
}

declare i8 @llvm.amdgcn.s.buffer.load.i8(<4 x i32>, i32, i32)
declare i8 @llvm.amdgcn.s.buffer.load.u8(<4 x i32>, i32, i32)
declare i16 @llvm.amdgcn.s.buffer.load.i16(<4 x i32>, i32, i32)
declare i16 @llvm.amdgcn.s.buffer.load.u16(<4 x i32>, i32, i32)

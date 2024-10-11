; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=fiji -verify-machineinstrs < %s | FileCheck --check-prefix=CHECK-SDAG -enable-var-scope %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=fiji -verify-machineinstrs -global-isel < %s | FileCheck --check-prefix=CHECK-GISEL -enable-var-scope %s

declare i32 @llvm.amdgcn.readlane.i32(i32, i32) #0
declare i64 @llvm.amdgcn.readlane.i64(i64, i32) #0
declare double @llvm.amdgcn.readlane.f64(double, i32) #0

define amdgpu_kernel void @test_readlane_sreg_sreg_i32(i32 %src0, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_sreg_sreg_i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_sreg_sreg_i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_endpgm
  %readlane = call i32 @llvm.amdgcn.readlane.i32(i32 %src0, i32 %src1)
  call void asm sideeffect "; use $0", "s"(i32 %readlane)
  ret void
}

define amdgpu_kernel void @test_readlane_sreg_sreg_i64(i64 %src0, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_sreg_sreg_i64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_sreg_sreg_i64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_endpgm
  %readlane = call i64 @llvm.amdgcn.readlane.i64(i64 %src0, i32 %src1)
  call void asm sideeffect "; use $0", "s"(i64 %readlane)
  ret void
}

define amdgpu_kernel void @test_readlane_sreg_sreg_f64(double %src0, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_sreg_sreg_f64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_sreg_sreg_f64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_endpgm
  %readlane = call double @llvm.amdgcn.readlane.f64(double %src0, i32 %src1)
  call void asm sideeffect "; use $0", "s"(double %readlane)
  ret void
}

define amdgpu_kernel void @test_readlane_vreg_sreg_i32(i32 %src0, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_vreg_sreg_i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dword s0, s[6:7], 0x4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; def v0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vreg_sreg_i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dword s0, s[6:7], 0x4
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; def v0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_endpgm
  %vgpr = call i32 asm sideeffect "; def $0", "=v"()
  %readlane = call i32 @llvm.amdgcn.readlane.i32(i32 %vgpr, i32 %src1)
  call void asm sideeffect "; use $0", "s"(i32 %readlane)
  ret void
}

define amdgpu_kernel void @test_readlane_vreg_sreg_i64(i64 %src0, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_vreg_sreg_i64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dword s0, s[6:7], 0x8
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; def v[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readlane_b32 s1, v1, s0
; CHECK-SDAG-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vreg_sreg_i64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dword s1, s[6:7], 0x8
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; def v[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readlane_b32 s0, v0, s1
; CHECK-GISEL-NEXT:    v_readlane_b32 s1, v1, s1
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_endpgm
  %vgpr = call i64 asm sideeffect "; def $0", "=v"()
  %readlane = call i64 @llvm.amdgcn.readlane.i64(i64 %vgpr, i32 %src1)
  call void asm sideeffect "; use $0", "s"(i64 %readlane)
  ret void
}

define amdgpu_kernel void @test_readlane_vreg_sreg_f64(double %src0, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_vreg_sreg_f64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dword s0, s[6:7], 0x8
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; def v[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readlane_b32 s1, v1, s0
; CHECK-SDAG-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vreg_sreg_f64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dword s1, s[6:7], 0x8
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; def v[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readlane_b32 s0, v0, s1
; CHECK-GISEL-NEXT:    v_readlane_b32 s1, v1, s1
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_endpgm
  %vgpr = call double asm sideeffect "; def $0", "=v"()
  %readlane = call double @llvm.amdgcn.readlane.f64(double %vgpr, i32 %src1)
  call void asm sideeffect "; use $0", "s"(double %readlane)
  ret void
}

define amdgpu_kernel void @test_readlane_imm_sreg_i32(ptr addrspace(1) %out, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_imm_sreg_i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, 32
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-SDAG-NEXT:    flat_store_dword v[0:1], v2
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_imm_sreg_i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, 32
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-GISEL-NEXT:    flat_store_dword v[0:1], v2
; CHECK-GISEL-NEXT:    s_endpgm
  %readlane = call i32 @llvm.amdgcn.readlane.i32(i32 32, i32 %src1)
  store i32 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_imm_sreg_i64(ptr addrspace(1) %out, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_imm_sreg_i64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, 32
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_imm_sreg_i64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    s_mov_b64 s[2:3], 32
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %readlane = call i64 @llvm.amdgcn.readlane.i64(i64 32, i32 %src1)
  store i64 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_imm_sreg_f64(ptr addrspace(1) %out, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_imm_sreg_f64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, 0x40400000
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_imm_sreg_f64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    s_mov_b32 s2, 0
; CHECK-GISEL-NEXT:    s_mov_b32 s3, 0x40400000
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %readlane = call double @llvm.amdgcn.readlane.f64(double 32.0, i32 %src1)
  store double %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_vregs_i32(ptr addrspace(1) %out, ptr addrspace(1) %in) #1 {
; CHECK-SDAG-LABEL: test_readlane_vregs_i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; CHECK-SDAG-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-SDAG-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; CHECK-SDAG-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CHECK-SDAG-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s0, v1
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    flat_store_dword v[2:3], v0
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vregs_i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; CHECK-GISEL-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_add_u32_e32 v0, vcc, v0, v2
; CHECK-GISEL-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CHECK-GISEL-NEXT:    flat_load_dwordx2 v[0:1], v[0:1]
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s2, v1
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s2, v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-GISEL-NEXT:    flat_store_dword v[0:1], v2
; CHECK-GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr <2 x i32>, ptr addrspace(1) %in, i32 %tid
  %args = load <2 x i32>, ptr addrspace(1) %gep.in
  %value = extractelement <2 x i32> %args, i32 0
  %lane = extractelement <2 x i32> %args, i32 1
  %readlane = call i32 @llvm.amdgcn.readlane.i32(i32 %value, i32 %lane)
  store i32 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_vregs_i64(ptr addrspace(1) %out, ptr addrspace(1) %in) #1 {
; CHECK-SDAG-LABEL: test_readlane_vregs_i64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; CHECK-SDAG-NEXT:    v_lshlrev_b32_e32 v0, 4, v0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-SDAG-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; CHECK-SDAG-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CHECK-SDAG-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v4, s1
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s0, v2
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s1, v1, s0
; CHECK-SDAG-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[3:4], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vregs_i64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; CHECK-GISEL-NEXT:    v_lshlrev_b32_e32 v2, 4, v0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_add_u32_e32 v0, vcc, v0, v2
; CHECK-GISEL-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CHECK-GISEL-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s3, v2
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s2, v0, s3
; CHECK-GISEL-NEXT:    v_readlane_b32 s3, v1, s3
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr <2 x i64>, ptr addrspace(1) %in, i32 %tid
  %args = load <2 x i64>, ptr addrspace(1) %gep.in
  %value = extractelement <2 x i64> %args, i32 0
  %lane = extractelement <2 x i64> %args, i32 1
  %lane32 = trunc i64 %lane to i32
  %readlane = call i64 @llvm.amdgcn.readlane.i64(i64 %value, i32 %lane32)
  store i64 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_vregs_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #1 {
; CHECK-SDAG-LABEL: test_readlane_vregs_f64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; CHECK-SDAG-NEXT:    v_lshlrev_b32_e32 v0, 4, v0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-SDAG-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; CHECK-SDAG-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CHECK-SDAG-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v4, s1
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s0, v2
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s1, v1, s0
; CHECK-SDAG-NEXT:    v_readlane_b32 s0, v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[3:4], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vregs_f64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; CHECK-GISEL-NEXT:    v_lshlrev_b32_e32 v2, 4, v0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_add_u32_e32 v0, vcc, v0, v2
; CHECK-GISEL-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CHECK-GISEL-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s3, v2
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s2, v0, s3
; CHECK-GISEL-NEXT:    v_readlane_b32 s3, v1, s3
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr <2 x double>, ptr addrspace(1) %in, i32 %tid
  %args = load <2 x double>, ptr addrspace(1) %gep.in
  %value = extractelement <2 x double> %args, i32 0
  %lane = extractelement <2 x double> %args, i32 1
  %lane_cast = bitcast double %lane to i64
  %lane32 = trunc i64 %lane_cast to i32
  %readlane = call double @llvm.amdgcn.readlane.f64(double %value, i32 %lane32)
  store double %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_m0_sreg(ptr addrspace(1) %out, i32 %src1) #1 {
; CHECK-SDAG-LABEL: test_readlane_m0_sreg:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    s_mov_b32 m0, -1
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, m0
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-SDAG-NEXT:    flat_store_dword v[0:1], v2
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_m0_sreg:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    s_mov_b32 m0, -1
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, m0
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-GISEL-NEXT:    flat_store_dword v[0:1], v2
; CHECK-GISEL-NEXT:    s_endpgm
  %m0 = call i32 asm "s_mov_b32 m0, -1", "={m0}"()
  %readlane = call i32 @llvm.amdgcn.readlane(i32 %m0, i32 %src1)
  store i32 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_vgpr_imm_i32(ptr addrspace(1) %out) #1 {
; CHECK-SDAG-LABEL: test_readlane_vgpr_imm_i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; def v0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_readlane_b32 s2, v0, 32
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s2
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-SDAG-NEXT:    flat_store_dword v[0:1], v2
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vgpr_imm_i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; def v0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_readlane_b32 s2, v0, 32
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s2
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-GISEL-NEXT:    flat_store_dword v[0:1], v2
; CHECK-GISEL-NEXT:    s_endpgm
  %vgpr = call i32 asm sideeffect "; def $0", "=v"()
  %readlane = call i32 @llvm.amdgcn.readlane.i32(i32 %vgpr, i32 32) #0
  store i32 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_vgpr_imm_i64(ptr addrspace(1) %out) #1 {
; CHECK-SDAG-LABEL: test_readlane_vgpr_imm_i64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; def v[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_readlane_b32 s2, v1, 32
; CHECK-SDAG-NEXT:    v_readlane_b32 s3, v0, 32
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s3
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s2
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vgpr_imm_i64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; def v[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_readlane_b32 s2, v0, 32
; CHECK-GISEL-NEXT:    v_readlane_b32 s3, v1, 32
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %vgpr = call i64 asm sideeffect "; def $0", "=v"()
  %readlane = call i64 @llvm.amdgcn.readlane.i64(i64 %vgpr, i32 32) #0
  store i64 %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_vgpr_imm_f64(ptr addrspace(1) %out) #1 {
; CHECK-SDAG-LABEL: test_readlane_vgpr_imm_f64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; def v[0:1]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_readlane_b32 s2, v1, 32
; CHECK-SDAG-NEXT:    v_readlane_b32 s3, v0, 32
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s3
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s2
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_vgpr_imm_f64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; def v[0:1]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_readlane_b32 s2, v0, 32
; CHECK-GISEL-NEXT:    v_readlane_b32 s3, v1, 32
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %vgpr = call double asm sideeffect "; def $0", "=v"()
  %readlane = call double @llvm.amdgcn.readlane.f64(double %vgpr, i32 32) #0
  store double %readlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_copy_from_sgpr_i32(ptr addrspace(1) %out) #1 {
; CHECK-SDAG-LABEL: test_readlane_copy_from_sgpr_i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    s_mov_b32 s2, 0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s2
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-SDAG-NEXT:    flat_store_dword v[0:1], v2
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_copy_from_sgpr_i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    s_mov_b32 s2, 0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s2
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-GISEL-NEXT:    flat_store_dword v[0:1], v2
; CHECK-GISEL-NEXT:    s_endpgm
  %sgpr = call i32 asm "s_mov_b32 $0, 0", "=s"()
  %readfirstlane = call i32 @llvm.amdgcn.readlane.i32(i32 %sgpr, i32 7)
  store i32 %readfirstlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_copy_from_sgpr_i64(ptr addrspace(1) %out) #1 {
; CHECK-SDAG-LABEL: test_readlane_copy_from_sgpr_i64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    s_mov_b64 s[2:3], 0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_copy_from_sgpr_i64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    s_mov_b64 s[2:3], 0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %sgpr = call i64 asm "s_mov_b64 $0, 0", "=s"()
  %readfirstlane = call i64 @llvm.amdgcn.readlane.i64(i64 %sgpr, i32 7)
  store i64 %readfirstlane, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_readlane_copy_from_sgpr_f64(ptr addrspace(1) %out) #1 {
; CHECK-SDAG-LABEL: test_readlane_copy_from_sgpr_f64:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    s_mov_b64 s[2:3], 0
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-SDAG-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-SDAG-NEXT:    s_endpgm
;
; CHECK-GISEL-LABEL: test_readlane_copy_from_sgpr_f64:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    s_mov_b64 s[2:3], 0
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v0, s2
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v1, s3
; CHECK-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-GISEL-NEXT:    v_mov_b32_e32 v2, s0
; CHECK-GISEL-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CHECK-GISEL-NEXT:    s_endpgm
  %sgpr = call double asm "s_mov_b64 $0, 0", "=s"()
  %readfirstlane = call double @llvm.amdgcn.readlane.f64(double %sgpr, i32 7)
  store double %readfirstlane, ptr addrspace(1) %out, align 4
  ret void
}

define void @test_readlane_half(ptr addrspace(1) %out, half %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_half:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s4
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_half:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s4
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call half @llvm.amdgcn.readlane.f16(half %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(half %x)
  ret void
}

define void @test_readlane_float(ptr addrspace(1) %out, float %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_float:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s4
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_float:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s4
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call float @llvm.amdgcn.readlane.f32(float %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(float %x)
  ret void
}

define void @test_readlane_bfloat(ptr addrspace(1) %out, bfloat %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_bfloat:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s4
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_bfloat:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s4
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call bfloat @llvm.amdgcn.readlane.bf16(bfloat %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(bfloat %x)
  ret void
}

define void @test_readlane_i16(ptr addrspace(1) %out, i16 %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_i16:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    s_and_b32 s4, s4, 0xffff
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s4
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_i16:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s4
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call i16 @llvm.amdgcn.readlane.i16(i16 %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(i16 %x)
  ret void
}

define void @test_readlane_v2f16(ptr addrspace(1) %out, <2 x half> %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_v2f16:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s4
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_v2f16:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s4, v3
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s4
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call <2 x half> @llvm.amdgcn.readlane.v2f16(<2 x half> %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(<2 x half> %x)
  ret void
}

define void @test_readlane_v2f32(ptr addrspace(1) %out, <2 x float> %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_v2f32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v4
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s5, v3, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[4:5]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_v2f32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s5, v4
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s5
; CHECK-GISEL-NEXT:    v_readlane_b32 s5, v3, s5
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[4:5]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call <2 x float> @llvm.amdgcn.readlane.v2f32(<2 x float> %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(<2 x float> %x)
  ret void
}

define void @test_readlane_v7i32(ptr addrspace(1) %out, <7 x i32> %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_v7i32:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v9
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s10, v8, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s9, v7, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s8, v6, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s7, v5, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s6, v4, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s5, v3, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[4:10]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_v7i32:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s10, v9
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s10
; CHECK-GISEL-NEXT:    v_readlane_b32 s5, v3, s10
; CHECK-GISEL-NEXT:    v_readlane_b32 s6, v4, s10
; CHECK-GISEL-NEXT:    v_readlane_b32 s7, v5, s10
; CHECK-GISEL-NEXT:    v_readlane_b32 s8, v6, s10
; CHECK-GISEL-NEXT:    v_readlane_b32 s9, v7, s10
; CHECK-GISEL-NEXT:    v_readlane_b32 s10, v8, s10
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[4:10]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call <7 x i32> @llvm.amdgcn.readlane.v7i32(<7 x i32> %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(<7 x i32> %x)
  ret void
}

define void @test_readlane_v8i16(ptr addrspace(1) %out, <8 x i16> %src, i32 %src1) {
; CHECK-SDAG-LABEL: test_readlane_v8i16:
; CHECK-SDAG:       ; %bb.0:
; CHECK-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-SDAG-NEXT:    v_readfirstlane_b32 s4, v6
; CHECK-SDAG-NEXT:    s_nop 3
; CHECK-SDAG-NEXT:    v_readlane_b32 s7, v5, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s6, v4, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s5, v3, s4
; CHECK-SDAG-NEXT:    v_readlane_b32 s4, v2, s4
; CHECK-SDAG-NEXT:    ;;#ASMSTART
; CHECK-SDAG-NEXT:    ; use s[4:7]
; CHECK-SDAG-NEXT:    ;;#ASMEND
; CHECK-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; CHECK-GISEL-LABEL: test_readlane_v8i16:
; CHECK-GISEL:       ; %bb.0:
; CHECK-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-GISEL-NEXT:    v_readfirstlane_b32 s7, v6
; CHECK-GISEL-NEXT:    s_nop 3
; CHECK-GISEL-NEXT:    v_readlane_b32 s4, v2, s7
; CHECK-GISEL-NEXT:    v_readlane_b32 s5, v3, s7
; CHECK-GISEL-NEXT:    v_readlane_b32 s6, v4, s7
; CHECK-GISEL-NEXT:    v_readlane_b32 s7, v5, s7
; CHECK-GISEL-NEXT:    ;;#ASMSTART
; CHECK-GISEL-NEXT:    ; use s[4:7]
; CHECK-GISEL-NEXT:    ;;#ASMEND
; CHECK-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %x = call <8 x i16> @llvm.amdgcn.readlane.v8i16(<8 x i16> %src, i32 %src1)
  call void asm sideeffect "; use $0", "s"(<8 x i16> %x)
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #2

attributes #0 = { nounwind readnone convergent }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }

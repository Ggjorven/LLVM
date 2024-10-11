; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-- -mcpu=tahiti < %s | FileCheck -check-prefix=SI %s
; RUN: llc -mtriple=amdgcn-- -mcpu=fiji < %s | FileCheck -check-prefix=VI %s

define amdgpu_kernel void @test_fmin_legacy_uge_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_uge_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_nlt_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_uge_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_nlt_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp uge double %a, %b
  %val = select i1 %cmp, double %b, double %a
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_ugt_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_ugt_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_nle_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_ugt_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_nle_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp ugt double %a, %b
  %val = select i1 %cmp, double %b, double %a
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_ule_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_ule_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_ngt_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_ule_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_ngt_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp ule double %a, %b
  %val = select i1 %cmp, double %a, double %b
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_ult_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_ult_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_nge_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_ult_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_nge_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp ult double %a, %b
  %val = select i1 %cmp, double %a, double %b
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_oge_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_oge_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_ge_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_oge_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_ge_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp oge double %a, %b
  %val = select i1 %cmp, double %b, double %a
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_ogt_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_ogt_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_gt_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_ogt_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_gt_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v1, v3, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp ogt double %a, %b
  %val = select i1 %cmp, double %b, double %a
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_ole_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_ole_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_le_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_ole_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_le_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp ole double %a, %b
  %val = select i1 %cmp, double %a, double %b
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @test_fmin_legacy_olt_f64(ptr addrspace(1) %out, ptr addrspace(1) %in) #0 {
; SI-LABEL: test_fmin_legacy_olt_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    buffer_load_dwordx4 v[0:3], v[0:1], s[8:11], 0 addr64
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cmp_lt_f64_e32 vcc, v[0:1], v[2:3]
; SI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; SI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_fmin_legacy_olt_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dwordx4 v[0:3], v[0:1]
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cmp_lt_f64_e32 vcc, v[0:1], v[2:3]
; VI-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; VI-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; VI-NEXT:    flat_store_dwordx2 v[4:5], v[0:1]
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #1
  %gep.0 = getelementptr double, ptr addrspace(1) %in, i32 %tid
  %gep.1 = getelementptr double, ptr addrspace(1) %gep.0, i32 1

  %a = load double, ptr addrspace(1) %gep.0, align 8
  %b = load double, ptr addrspace(1) %gep.1, align 8

  %cmp = fcmp olt double %a, %b
  %val = select i1 %cmp, double %a, double %b
  store double %val, ptr addrspace(1) %out, align 8
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

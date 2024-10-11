; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a < %s | FileCheck %s

declare double @llvm.amdgcn.flat.atomic.fmin.f64.p0.f64(ptr nocapture, double) #0
declare double @llvm.amdgcn.flat.atomic.fmax.f64.p0.f64(ptr nocapture, double) #0

define protected amdgpu_kernel void @InferNothing(i32 %a, ptr %b, double %c) {
; CHECK-LABEL: InferNothing:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[2:3], 0x24
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s1, s0, 31
; CHECK-NEXT:    s_lshl_b64 s[0:1], s[0:1], 3
; CHECK-NEXT:    s_add_u32 s0, s0, s4
; CHECK-NEXT:    s_addc_u32 s1, s1, s5
; CHECK-NEXT:    v_mov_b32_e32 v3, s1
; CHECK-NEXT:    v_add_co_u32_e64 v2, vcc, -8, s0
; CHECK-NEXT:    v_mov_b32_e32 v0, s6
; CHECK-NEXT:    v_mov_b32_e32 v1, s7
; CHECK-NEXT:    v_addc_co_u32_e32 v3, vcc, -1, v3, vcc
; CHECK-NEXT:    flat_atomic_add_f64 v[2:3], v[0:1]
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    buffer_wbinvl1_vol
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr %b, i64 %i.2
  %i.4 = atomicrmw fadd ptr %i.3, double %c syncscope("agent") seq_cst, align 8, !amdgpu.no.fine.grained.memory !0
  ret void
}

define protected amdgpu_kernel void @InferFadd(i32 %a, ptr addrspace(1) %b, double %c) {
; CHECK-LABEL: InferFadd:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_mov_b64 s[0:1], exec
; CHECK-NEXT:    v_mbcnt_lo_u32_b32 v0, s0, 0
; CHECK-NEXT:    v_mbcnt_hi_u32_b32 v0, s1, v0
; CHECK-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; CHECK-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; CHECK-NEXT:    s_cbranch_execz .LBB1_2
; CHECK-NEXT:  ; %bb.1:
; CHECK-NEXT:    s_load_dword s8, s[2:3], 0x24
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s9, s8, 31
; CHECK-NEXT:    s_lshl_b64 s[2:3], s[8:9], 3
; CHECK-NEXT:    s_add_u32 s2, s4, s2
; CHECK-NEXT:    s_addc_u32 s3, s5, s3
; CHECK-NEXT:    s_bcnt1_i32_b64 s0, s[0:1]
; CHECK-NEXT:    v_cvt_f64_u32_e32 v[0:1], s0
; CHECK-NEXT:    v_mul_f64 v[0:1], s[6:7], v[0:1]
; CHECK-NEXT:    global_atomic_add_f64 v2, v[0:1], s[2:3] offset:-8
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    buffer_wbinvl1_vol
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr addrspace(1) %b, i64 %i.2
  %i.4 = addrspacecast ptr addrspace(1) %i.3 to ptr
  %0 = atomicrmw fadd ptr %i.4, double %c syncscope("agent") seq_cst, align 8, !amdgpu.no.fine.grained.memory !0
  ret void
}

define protected amdgpu_kernel void @InferFmax(i32 %a, ptr addrspace(1) %b, double %c) {
; CHECK-LABEL: InferFmax:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[2:3], 0x24
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s1, s0, 31
; CHECK-NEXT:    s_lshl_b64 s[0:1], s[0:1], 3
; CHECK-NEXT:    s_add_u32 s0, s4, s0
; CHECK-NEXT:    v_mov_b32_e32 v0, s6
; CHECK-NEXT:    v_mov_b32_e32 v1, s7
; CHECK-NEXT:    s_addc_u32 s1, s5, s1
; CHECK-NEXT:    global_atomic_max_f64 v2, v[0:1], s[0:1] offset:-8
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr addrspace(1) %b, i64 %i.2
  %i.4 = addrspacecast ptr addrspace(1) %i.3 to ptr
  %i.5 = tail call contract double @llvm.amdgcn.flat.atomic.fmax.f64.p0.f64(ptr %i.4, double %c) #1
  ret void
}

define protected amdgpu_kernel void @InferFmin(i32 %a, ptr addrspace(1) %b, double %c) {
; CHECK-LABEL: InferFmin:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[2:3], 0x24
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s1, s0, 31
; CHECK-NEXT:    s_lshl_b64 s[0:1], s[0:1], 3
; CHECK-NEXT:    s_add_u32 s0, s4, s0
; CHECK-NEXT:    v_mov_b32_e32 v0, s6
; CHECK-NEXT:    v_mov_b32_e32 v1, s7
; CHECK-NEXT:    s_addc_u32 s1, s5, s1
; CHECK-NEXT:    global_atomic_min_f64 v2, v[0:1], s[0:1] offset:-8
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr addrspace(1) %b, i64 %i.2
  %i.4 = addrspacecast ptr addrspace(1) %i.3 to ptr
  %i.5 = tail call contract double @llvm.amdgcn.flat.atomic.fmin.f64.p0.f64(ptr %i.4, double %c) #1
  ret void
}

define protected amdgpu_kernel void @InferMixed(i32 %a, ptr addrspace(1) %b, double %c, ptr %d) {
; CHECK-LABEL: InferMixed:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dwordx2 s[8:9], s[2:3], 0x3c
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    s_mov_b64 s[0:1], exec
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, s8
; CHECK-NEXT:    v_mov_b32_e32 v1, s9
; CHECK-NEXT:    v_pk_mov_b32 v[2:3], s[6:7], s[6:7] op_sel:[0,1]
; CHECK-NEXT:    flat_atomic_add_f64 v[0:1], v[2:3]
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    buffer_wbinvl1_vol
; CHECK-NEXT:    v_mbcnt_lo_u32_b32 v0, s0, 0
; CHECK-NEXT:    v_mbcnt_hi_u32_b32 v0, s1, v0
; CHECK-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; CHECK-NEXT:    s_and_saveexec_b64 s[8:9], vcc
; CHECK-NEXT:    s_cbranch_execz .LBB4_2
; CHECK-NEXT:  ; %bb.1:
; CHECK-NEXT:    s_load_dword s2, s[2:3], 0x24
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s3, s2, 31
; CHECK-NEXT:    s_lshl_b64 s[2:3], s[2:3], 3
; CHECK-NEXT:    s_add_u32 s2, s4, s2
; CHECK-NEXT:    s_addc_u32 s3, s5, s3
; CHECK-NEXT:    s_bcnt1_i32_b64 s0, s[0:1]
; CHECK-NEXT:    v_cvt_f64_u32_e32 v[0:1], s0
; CHECK-NEXT:    v_mul_f64 v[0:1], s[6:7], v[0:1]
; CHECK-NEXT:    global_atomic_add_f64 v2, v[0:1], s[2:3] offset:-7
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    buffer_wbinvl1_vol
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr addrspace(1) %b, i64 %i.2
  br label %bb1

bb1:                                              ; preds = %entry
  %i.7 = ptrtoint ptr addrspace(1) %i.3 to i64
  %i.8 = add nsw i64 %i.7, 1
  %i.9 = inttoptr i64 %i.8 to ptr addrspace(1)
  %0 = atomicrmw fadd ptr %d, double %c syncscope("agent") seq_cst, align 8, !amdgpu.no.fine.grained.memory !0
  %i.11 = addrspacecast ptr addrspace(1) %i.9 to ptr
  %1 = atomicrmw fadd ptr %i.11, double %c syncscope("agent") seq_cst, align 8, !amdgpu.no.fine.grained.memory !0
  ret void
}

define protected amdgpu_kernel void @InferPHI(i32 %a, ptr addrspace(1) %b, double %c) {
; CHECK-LABEL: InferPHI:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[2:3], 0x24
; CHECK-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x2c
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_ashr_i32 s1, s0, 31
; CHECK-NEXT:    s_lshl_b64 s[0:1], s[0:1], 3
; CHECK-NEXT:    s_add_u32 s0, s4, s0
; CHECK-NEXT:    s_addc_u32 s1, s5, s1
; CHECK-NEXT:    s_add_u32 s2, s0, -8
; CHECK-NEXT:    s_addc_u32 s3, s1, -1
; CHECK-NEXT:    s_cmp_eq_u64 s[0:1], 9
; CHECK-NEXT:    s_cselect_b64 s[0:1], -1, 0
; CHECK-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[0:1]
; CHECK-NEXT:    v_cmp_ne_u32_e64 s[0:1], 1, v0
; CHECK-NEXT:  .LBB5_1: ; %bb0
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    s_and_b64 vcc, exec, s[0:1]
; CHECK-NEXT:    s_cbranch_vccnz .LBB5_1
; CHECK-NEXT:  ; %bb.2: ; %bb1
; CHECK-NEXT:    s_mov_b64 s[0:1], exec
; CHECK-NEXT:    v_mbcnt_lo_u32_b32 v0, s0, 0
; CHECK-NEXT:    v_mbcnt_hi_u32_b32 v0, s1, v0
; CHECK-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; CHECK-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; CHECK-NEXT:    s_cbranch_execz .LBB5_4
; CHECK-NEXT:  ; %bb.3:
; CHECK-NEXT:    s_bcnt1_i32_b64 s0, s[0:1]
; CHECK-NEXT:    v_cvt_f64_u32_e32 v[0:1], s0
; CHECK-NEXT:    v_mul_f64 v[0:1], s[6:7], v[0:1]
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    global_atomic_add_f64 v2, v[0:1], s[2:3]
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    buffer_wbinvl1_vol
; CHECK-NEXT:  .LBB5_4:
; CHECK-NEXT:    s_endpgm
entry:
  %i = add nsw i32 %a, -1
  %i.2 = sext i32 %i to i64
  %i.3 = getelementptr inbounds double, ptr addrspace(1) %b, i64 %i.2
  %i.4 = ptrtoint ptr addrspace(1) %i.3 to i64
  br label %bb0

bb0:                                              ; preds = %bb0, %entry
  %phi = phi ptr addrspace(1) [ %i.3, %entry ], [ %i.9, %bb0 ]
  %i.7 = ptrtoint ptr addrspace(1) %phi to i64
  %i.8 = sub nsw i64 %i.7, 1
  %cmp2 = icmp eq i64 %i.8, 0
  %i.9 = inttoptr i64 %i.7 to ptr addrspace(1)
  br i1 %cmp2, label %bb1, label %bb0

bb1:                                              ; preds = %bb0
  %i.10 = addrspacecast ptr addrspace(1) %i.9 to ptr
  %0 = atomicrmw fadd ptr %i.10, double %c syncscope("agent") seq_cst, align 8, !amdgpu.no.fine.grained.memory !0
  ret void
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { mustprogress nounwind willreturn memory(argmem: readwrite) "target-cpu"="gfx90a" }

!0 = !{}

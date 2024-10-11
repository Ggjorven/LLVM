; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -march=amdgcn < %s | FileCheck -check-prefixes=SI,GCN %s
; RUN: llc -march=amdgcn -mcpu=tonga < %s | FileCheck -check-prefixes=VI,GCN %s

define amdgpu_kernel void @fneg_fabs_fadd_f64(ptr addrspace(1) %out, double %x, double %y) {
; SI-LABEL: fneg_fabs_fadd_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x9
; SI-NEXT:    s_load_dwordx2 s[8:9], s[2:3], 0xd
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    v_mov_b32_e32 v0, s6
; SI-NEXT:    v_mov_b32_e32 v1, s7
; SI-NEXT:    v_add_f64 v[0:1], s[8:9], -|v[0:1]|
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_fadd_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s6
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_f64 v[0:1], s[0:1], -|v[0:1]|
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %fabs = call double @llvm.fabs.f64(double %x)
  %fsub = fsub double -0.000000e+00, %fabs
  %fadd = fadd double %y, %fsub
  store double %fadd, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @v_fneg_fabs_fadd_f64(ptr addrspace(1) %out, ptr addrspace(1) %xptr, ptr addrspace(1) %yptr) {
; SI-LABEL: v_fneg_fabs_fadd_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_add_f64 v[0:1], s[4:5], -|s[4:5]|
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_fneg_fabs_fadd_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_load_dwordx2 s[2:3], s[2:3], 0x0
; VI-NEXT:    v_mov_b32_e32 v2, s0
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_add_f64 v[0:1], s[2:3], -|s[2:3]|
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %x = load double, ptr addrspace(1) %xptr, align 8
  %y = load double, ptr addrspace(1) %xptr, align 8
  %fabs = call double @llvm.fabs.f64(double %x)
  %fsub = fsub double -0.000000e+00, %fabs
  %fadd = fadd double %y, %fsub
  store double %fadd, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @fneg_fabs_fmul_f64(ptr addrspace(1) %out, double %x, double %y) {
; SI-LABEL: fneg_fabs_fmul_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x9
; SI-NEXT:    s_load_dwordx2 s[8:9], s[2:3], 0xd
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    v_mov_b32_e32 v0, s6
; SI-NEXT:    v_mov_b32_e32 v1, s7
; SI-NEXT:    v_mul_f64 v[0:1], s[8:9], -|v[0:1]|
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_fmul_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x34
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s6
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_mul_f64 v[0:1], s[0:1], -|v[0:1]|
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %fabs = call double @llvm.fabs.f64(double %x)
  %fsub = fsub double -0.000000e+00, %fabs
  %fmul = fmul double %y, %fsub
  store double %fmul, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @fneg_fabs_free_f64(ptr addrspace(1) %out, i64 %in) {
; SI-LABEL: fneg_fabs_free_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_bitset1_b32 s3, 31
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    v_mov_b32_e32 v0, s2
; SI-NEXT:    v_mov_b32_e32 v1, s3
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_free_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    s_or_b32 s0, s3, 0x80000000
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    v_mov_b32_e32 v3, s0
; VI-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; VI-NEXT:    s_endpgm
  %bc = bitcast i64 %in to double
  %fabs = call double @llvm.fabs.f64(double %bc)
  %fsub = fsub double -0.000000e+00, %fabs
  store double %fsub, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @fneg_fabs_fn_free_f64(ptr addrspace(1) %out, i64 %in) {
; SI-LABEL: fneg_fabs_fn_free_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_bitset1_b32 s3, 31
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    v_mov_b32_e32 v0, s2
; SI-NEXT:    v_mov_b32_e32 v1, s3
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_fn_free_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    s_or_b32 s0, s3, 0x80000000
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    v_mov_b32_e32 v3, s0
; VI-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; VI-NEXT:    s_endpgm
  %bc = bitcast i64 %in to double
  %fabs = call double @fabs(double %bc)
  %fsub = fsub double -0.000000e+00, %fabs
  store double %fsub, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @fneg_fabs_f64(ptr addrspace(1) %out, [8 x i32], double %in) {
; SI-LABEL: fneg_fabs_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x13
; SI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_bitset1_b32 s5, 31
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x4c
; VI-NEXT:    s_load_dwordx2 s[2:3], s[2:3], 0x24
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_bitset1_b32 s1, 31
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v3, s3
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %fabs = call double @llvm.fabs.f64(double %in)
  %fsub = fsub double -0.000000e+00, %fabs
  store double %fsub, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @fneg_fabs_v2f64(ptr addrspace(1) %out, <2 x double> %in) {
; SI-LABEL: fneg_fabs_v2f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0xd
; SI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_bitset1_b32 s7, 31
; SI-NEXT:    s_bitset1_b32 s5, 31
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v2, s6
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    v_mov_b32_e32 v3, s7
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_v2f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x34
; VI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x24
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_or_b32 s2, s7, 0x80000000
; VI-NEXT:    s_or_b32 s3, s5, 0x80000000
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v2, s6
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_mov_b32_e32 v3, s2
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; VI-NEXT:    s_endpgm
  %fabs = call <2 x double> @llvm.fabs.v2f64(<2 x double> %in)
  %fsub = fsub <2 x double> <double -0.000000e+00, double -0.000000e+00>, %fabs
  store <2 x double> %fsub, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @fneg_fabs_v4f64(ptr addrspace(1) %out, <4 x double> %in) {
; SI-LABEL: fneg_fabs_v4f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x11
; SI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_bitset1_b32 s7, 31
; SI-NEXT:    s_bitset1_b32 s11, 31
; SI-NEXT:    s_bitset1_b32 s9, 31
; SI-NEXT:    s_bitset1_b32 s5, 31
; SI-NEXT:    v_mov_b32_e32 v0, s8
; SI-NEXT:    v_mov_b32_e32 v2, s10
; SI-NEXT:    v_mov_b32_e32 v4, s4
; SI-NEXT:    v_mov_b32_e32 v6, s6
; SI-NEXT:    v_mov_b32_e32 v1, s9
; SI-NEXT:    v_mov_b32_e32 v3, s11
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0 offset:16
; SI-NEXT:    v_mov_b32_e32 v5, s5
; SI-NEXT:    v_mov_b32_e32 v7, s7
; SI-NEXT:    buffer_store_dwordx4 v[4:7], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_v4f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x44
; VI-NEXT:    s_load_dwordx2 s[0:1], s[2:3], 0x24
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_bitset1_b32 s7, 31
; VI-NEXT:    s_bitset1_b32 s5, 31
; VI-NEXT:    s_or_b32 s2, s11, 0x80000000
; VI-NEXT:    s_or_b32 s3, s9, 0x80000000
; VI-NEXT:    v_mov_b32_e32 v3, s2
; VI-NEXT:    s_add_u32 s2, s0, 16
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    s_addc_u32 s3, s1, 0
; VI-NEXT:    v_mov_b32_e32 v5, s3
; VI-NEXT:    v_mov_b32_e32 v0, s8
; VI-NEXT:    v_mov_b32_e32 v2, s10
; VI-NEXT:    v_mov_b32_e32 v4, s2
; VI-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; VI-NEXT:    v_mov_b32_e32 v5, s1
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    v_mov_b32_e32 v2, s6
; VI-NEXT:    v_mov_b32_e32 v3, s7
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; VI-NEXT:    s_endpgm
  %fabs = call <4 x double> @llvm.fabs.v4f64(<4 x double> %in)
  %fsub = fsub <4 x double> <double -0.000000e+00, double -0.000000e+00, double -0.000000e+00, double -0.000000e+00>, %fabs
  store <4 x double> %fsub, ptr addrspace(1) %out
  ret void
}

declare double @fabs(double) readnone
declare double @llvm.fabs.f64(double) readnone
declare <2 x double> @llvm.fabs.v2f64(<2 x double>) readnone
declare <4 x double> @llvm.fabs.v4f64(<4 x double>) readnone
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; GCN: {{.*}}

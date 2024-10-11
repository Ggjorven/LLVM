; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx940 -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -enable-new-pm -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx940 -enable-new-pm -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s

define amdgpu_ps <2 x half> @global_atomic_fadd_v2f16_rtn(ptr addrspace(1) %ptr, <2 x half> %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_rtn
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_PK_ADD_F16_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_PK_ADD_F16_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (load store syncscope("agent") seq_cst (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_PK_ADD_F16_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd ptr addrspace(1) %ptr, <2 x half> %data syncscope("agent") seq_cst, align 4, !amdgpu.no.fine.grained.memory !0
  ret <2 x half> %ret
}

define amdgpu_ps <2 x half> @global_atomic_fadd_v2f16_saddr_rtn(ptr addrspace(1) inreg %ptr, <2 x half> %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_saddr_rtn
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_PK_ADD_F16_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_PK_ADD_F16_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (load store syncscope("agent") seq_cst (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_PK_ADD_F16_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd ptr addrspace(1) %ptr, <2 x half> %data syncscope("agent") seq_cst, align 4, !amdgpu.no.fine.grained.memory !0
  ret <2 x half> %ret
}

define amdgpu_ps <2 x half> @global_atomic_fadd_v2f16_rtn_flat(ptr addrspace(1) %ptr, <2 x half> %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_rtn_flat
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_PK_ADD_F16_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_PK_ADD_F16_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (load store syncscope("agent") seq_cst (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_PK_ADD_F16_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd ptr addrspace(1) %ptr, <2 x half> %data syncscope("agent") seq_cst, align 4, !amdgpu.no.fine.grained.memory !0
  ret <2 x half> %ret
}

define amdgpu_ps <2 x half> @global_atomic_fadd_v2f16_saddr_rtn_flat(ptr addrspace(1) inreg %ptr, <2 x half> %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_saddr_rtn_flat
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_PK_ADD_F16_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_PK_ADD_F16_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (load store syncscope("agent") seq_cst (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_PK_ADD_F16_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd ptr addrspace(1) %ptr, <2 x half> %data syncscope("agent") seq_cst, align 4, !amdgpu.no.fine.grained.memory !0
  ret <2 x half> %ret
}

!0 = !{}

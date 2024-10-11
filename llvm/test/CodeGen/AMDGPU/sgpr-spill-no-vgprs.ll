; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

; The first 64 SGPR spills can go to a VGPR, but there isn't a second
; so some spills must be to memory. The last 16 element spill runs out of lanes at the 15th element.

define amdgpu_kernel void @partial_no_vgprs_last_sgpr_spill(ptr addrspace(1) %out, i32 %in) #1 {
; GCN-LABEL: partial_no_vgprs_last_sgpr_spill:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_add_u32 s0, s0, s13
; GCN-NEXT:    s_addc_u32 s1, s1, 0
; GCN-NEXT:    s_load_dword s4, s[6:7], 0x2
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; def s[8:23]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ; implicit-def: $vgpr22 : SGPR spill to VGPR lane
; GCN-NEXT:    v_writelane_b32 v22, s8, 0
; GCN-NEXT:    v_writelane_b32 v22, s9, 1
; GCN-NEXT:    v_writelane_b32 v22, s10, 2
; GCN-NEXT:    v_writelane_b32 v22, s11, 3
; GCN-NEXT:    v_writelane_b32 v22, s12, 4
; GCN-NEXT:    v_writelane_b32 v22, s13, 5
; GCN-NEXT:    v_writelane_b32 v22, s14, 6
; GCN-NEXT:    v_writelane_b32 v22, s15, 7
; GCN-NEXT:    v_writelane_b32 v22, s16, 8
; GCN-NEXT:    v_writelane_b32 v22, s17, 9
; GCN-NEXT:    v_writelane_b32 v22, s18, 10
; GCN-NEXT:    v_writelane_b32 v22, s19, 11
; GCN-NEXT:    v_writelane_b32 v22, s20, 12
; GCN-NEXT:    v_writelane_b32 v22, s21, 13
; GCN-NEXT:    v_writelane_b32 v22, s22, 14
; GCN-NEXT:    v_writelane_b32 v22, s23, 15
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; def s[8:23]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_writelane_b32 v22, s8, 16
; GCN-NEXT:    v_writelane_b32 v22, s9, 17
; GCN-NEXT:    v_writelane_b32 v22, s10, 18
; GCN-NEXT:    v_writelane_b32 v22, s11, 19
; GCN-NEXT:    v_writelane_b32 v22, s12, 20
; GCN-NEXT:    v_writelane_b32 v22, s13, 21
; GCN-NEXT:    v_writelane_b32 v22, s14, 22
; GCN-NEXT:    v_writelane_b32 v22, s15, 23
; GCN-NEXT:    v_writelane_b32 v22, s16, 24
; GCN-NEXT:    v_writelane_b32 v22, s17, 25
; GCN-NEXT:    v_writelane_b32 v22, s18, 26
; GCN-NEXT:    v_writelane_b32 v22, s19, 27
; GCN-NEXT:    v_writelane_b32 v22, s20, 28
; GCN-NEXT:    v_writelane_b32 v22, s21, 29
; GCN-NEXT:    v_writelane_b32 v22, s22, 30
; GCN-NEXT:    v_writelane_b32 v22, s23, 31
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; def s[8:23]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_writelane_b32 v22, s8, 32
; GCN-NEXT:    v_writelane_b32 v22, s9, 33
; GCN-NEXT:    v_writelane_b32 v22, s10, 34
; GCN-NEXT:    v_writelane_b32 v22, s11, 35
; GCN-NEXT:    v_writelane_b32 v22, s12, 36
; GCN-NEXT:    v_writelane_b32 v22, s13, 37
; GCN-NEXT:    v_writelane_b32 v22, s14, 38
; GCN-NEXT:    v_writelane_b32 v22, s15, 39
; GCN-NEXT:    v_writelane_b32 v22, s16, 40
; GCN-NEXT:    v_writelane_b32 v22, s17, 41
; GCN-NEXT:    v_writelane_b32 v22, s18, 42
; GCN-NEXT:    v_writelane_b32 v22, s19, 43
; GCN-NEXT:    v_writelane_b32 v22, s20, 44
; GCN-NEXT:    v_writelane_b32 v22, s21, 45
; GCN-NEXT:    v_writelane_b32 v22, s22, 46
; GCN-NEXT:    v_writelane_b32 v22, s23, 47
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; def s[8:23]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_writelane_b32 v22, s8, 48
; GCN-NEXT:    v_writelane_b32 v22, s9, 49
; GCN-NEXT:    v_writelane_b32 v22, s10, 50
; GCN-NEXT:    v_writelane_b32 v22, s11, 51
; GCN-NEXT:    v_writelane_b32 v22, s12, 52
; GCN-NEXT:    v_writelane_b32 v22, s13, 53
; GCN-NEXT:    v_writelane_b32 v22, s14, 54
; GCN-NEXT:    v_writelane_b32 v22, s15, 55
; GCN-NEXT:    v_writelane_b32 v22, s16, 56
; GCN-NEXT:    v_writelane_b32 v22, s17, 57
; GCN-NEXT:    v_writelane_b32 v22, s18, 58
; GCN-NEXT:    v_writelane_b32 v22, s19, 59
; GCN-NEXT:    v_writelane_b32 v22, s20, 60
; GCN-NEXT:    v_writelane_b32 v22, s21, 61
; GCN-NEXT:    v_writelane_b32 v22, s22, 62
; GCN-NEXT:    v_writelane_b32 v22, s23, 63
; GCN-NEXT:    s_or_saveexec_b64 s[24:25], -1
; GCN-NEXT:    buffer_store_dword v22, off, s[0:3], 0 offset:4 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[24:25]
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; def s[6:7]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ; implicit-def: $vgpr22 : SGPR spill to VGPR lane
; GCN-NEXT:    v_writelane_b32 v22, s6, 0
; GCN-NEXT:    v_writelane_b32 v22, s7, 1
; GCN-NEXT:    s_or_saveexec_b64 s[24:25], -1
; GCN-NEXT:    buffer_store_dword v22, off, s[0:3], 0 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[24:25]
; GCN-NEXT:    s_mov_b32 s5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lg_u32 s4, s5
; GCN-NEXT:    s_cbranch_scc1 .LBB0_2
; GCN-NEXT:  ; %bb.1: ; %bb0
; GCN-NEXT:    s_or_saveexec_b64 s[24:25], -1
; GCN-NEXT:    buffer_load_dword v23, off, s[0:3], 0 offset:4 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[24:25]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readlane_b32 s4, v23, 0
; GCN-NEXT:    v_readlane_b32 s5, v23, 1
; GCN-NEXT:    v_readlane_b32 s6, v23, 2
; GCN-NEXT:    v_readlane_b32 s7, v23, 3
; GCN-NEXT:    v_readlane_b32 s8, v23, 4
; GCN-NEXT:    v_readlane_b32 s9, v23, 5
; GCN-NEXT:    v_readlane_b32 s10, v23, 6
; GCN-NEXT:    v_readlane_b32 s11, v23, 7
; GCN-NEXT:    v_readlane_b32 s12, v23, 8
; GCN-NEXT:    v_readlane_b32 s13, v23, 9
; GCN-NEXT:    v_readlane_b32 s14, v23, 10
; GCN-NEXT:    v_readlane_b32 s15, v23, 11
; GCN-NEXT:    v_readlane_b32 s16, v23, 12
; GCN-NEXT:    v_readlane_b32 s17, v23, 13
; GCN-NEXT:    v_readlane_b32 s18, v23, 14
; GCN-NEXT:    v_readlane_b32 s19, v23, 15
; GCN-NEXT:    s_or_saveexec_b64 s[24:25], -1
; GCN-NEXT:    buffer_load_dword v22, off, s[0:3], 0 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[24:25]
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use s[4:19]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_readlane_b32 s4, v23, 16
; GCN-NEXT:    v_readlane_b32 s5, v23, 17
; GCN-NEXT:    v_readlane_b32 s6, v23, 18
; GCN-NEXT:    v_readlane_b32 s7, v23, 19
; GCN-NEXT:    v_readlane_b32 s8, v23, 20
; GCN-NEXT:    v_readlane_b32 s9, v23, 21
; GCN-NEXT:    v_readlane_b32 s10, v23, 22
; GCN-NEXT:    v_readlane_b32 s11, v23, 23
; GCN-NEXT:    v_readlane_b32 s12, v23, 24
; GCN-NEXT:    v_readlane_b32 s13, v23, 25
; GCN-NEXT:    v_readlane_b32 s14, v23, 26
; GCN-NEXT:    v_readlane_b32 s15, v23, 27
; GCN-NEXT:    v_readlane_b32 s16, v23, 28
; GCN-NEXT:    v_readlane_b32 s17, v23, 29
; GCN-NEXT:    v_readlane_b32 s18, v23, 30
; GCN-NEXT:    v_readlane_b32 s19, v23, 31
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use s[4:19]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_readlane_b32 s4, v23, 32
; GCN-NEXT:    v_readlane_b32 s5, v23, 33
; GCN-NEXT:    v_readlane_b32 s6, v23, 34
; GCN-NEXT:    v_readlane_b32 s7, v23, 35
; GCN-NEXT:    v_readlane_b32 s8, v23, 36
; GCN-NEXT:    v_readlane_b32 s9, v23, 37
; GCN-NEXT:    v_readlane_b32 s10, v23, 38
; GCN-NEXT:    v_readlane_b32 s11, v23, 39
; GCN-NEXT:    v_readlane_b32 s12, v23, 40
; GCN-NEXT:    v_readlane_b32 s13, v23, 41
; GCN-NEXT:    v_readlane_b32 s14, v23, 42
; GCN-NEXT:    v_readlane_b32 s15, v23, 43
; GCN-NEXT:    v_readlane_b32 s16, v23, 44
; GCN-NEXT:    v_readlane_b32 s17, v23, 45
; GCN-NEXT:    v_readlane_b32 s18, v23, 46
; GCN-NEXT:    v_readlane_b32 s19, v23, 47
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use s[4:19]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_readlane_b32 s8, v23, 48
; GCN-NEXT:    v_readlane_b32 s9, v23, 49
; GCN-NEXT:    v_readlane_b32 s10, v23, 50
; GCN-NEXT:    v_readlane_b32 s11, v23, 51
; GCN-NEXT:    v_readlane_b32 s12, v23, 52
; GCN-NEXT:    v_readlane_b32 s13, v23, 53
; GCN-NEXT:    v_readlane_b32 s14, v23, 54
; GCN-NEXT:    v_readlane_b32 s15, v23, 55
; GCN-NEXT:    v_readlane_b32 s16, v23, 56
; GCN-NEXT:    v_readlane_b32 s17, v23, 57
; GCN-NEXT:    v_readlane_b32 s18, v23, 58
; GCN-NEXT:    v_readlane_b32 s19, v23, 59
; GCN-NEXT:    v_readlane_b32 s20, v23, 60
; GCN-NEXT:    v_readlane_b32 s21, v23, 61
; GCN-NEXT:    v_readlane_b32 s22, v23, 62
; GCN-NEXT:    v_readlane_b32 s23, v23, 63
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readlane_b32 s4, v22, 0
; GCN-NEXT:    v_readlane_b32 s5, v22, 1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use s[8:23]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use s[4:5]
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:  .LBB0_2: ; %ret
; GCN-NEXT:    s_endpgm
  call void asm sideeffect "", "~{v[0:7]}" () #0
  call void asm sideeffect "", "~{v[8:15]}" () #0
  call void asm sideeffect "", "~{v[16:19]}"() #0
  call void asm sideeffect "", "~{v[20:21]}"() #0

  %wide.sgpr0 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %wide.sgpr1 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %wide.sgpr2 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %wide.sgpr3 = call <16 x i32> asm sideeffect "; def $0", "=s" () #0
  %wide.sgpr4 = call <2 x i32> asm sideeffect "; def $0", "=s" () #0
  %cmp = icmp eq i32 %in, 0
  br i1 %cmp, label %bb0, label %ret

bb0:
  call void asm sideeffect "; use $0", "s"(<16 x i32> %wide.sgpr0) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %wide.sgpr1) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %wide.sgpr2) #0
  call void asm sideeffect "; use $0", "s"(<16 x i32> %wide.sgpr3) #0
  call void asm sideeffect "; use $0", "s"(<2 x i32> %wide.sgpr4) #0
  br label %ret

ret:
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind "amdgpu-waves-per-eu"="10,10" }

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdhsa_code_object_version", i32 500}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck %s -check-prefix=GFX12
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck %s -check-prefix=GFX12

define amdgpu_ps void @test_bvhcnt() {
; GFX12-LABEL: test_bvhcnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.bvhcnt(i16 0)
  ret void
}

define amdgpu_ps void @test_dscnt() {
; GFX12-LABEL: test_dscnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_dscnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.dscnt(i16 0)
  ret void
}

define amdgpu_ps void @test_expcnt() {
; GFX12-LABEL: test_expcnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.expcnt(i16 0)
  ret void
}

define amdgpu_ps void @test_kmcnt() {
; GFX12-LABEL: test_kmcnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.kmcnt(i16 0)
  ret void
}

define amdgpu_ps void @test_loadcnt() {
; GFX12-LABEL: test_loadcnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.loadcnt(i16 0)
  ret void
}

define amdgpu_ps void @test_loadcnt_dscnt() {
; GFX12-LABEL: test_loadcnt_dscnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.loadcnt(i16 0)
  call void @llvm.amdgcn.s.wait.dscnt(i16 0)
  ret void
}

define amdgpu_ps void @test_samplecnt() {
; GFX12-LABEL: test_samplecnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.samplecnt(i16 0)
  ret void
}

define amdgpu_ps void @test_storecnt() {
; GFX12-LABEL: test_storecnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_storecnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.storecnt(i16 0)
  ret void
}

define amdgpu_ps void @test_storecnt_dscnt() {
; GFX12-LABEL: test_storecnt_dscnt:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_storecnt_dscnt 0x0
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.s.wait.storecnt(i16 0)
  call void @llvm.amdgcn.s.wait.dscnt(i16 0)
  ret void
}

declare void @llvm.amdgcn.s.wait.bvhcnt(i16)
declare void @llvm.amdgcn.s.wait.dscnt(i16)
declare void @llvm.amdgcn.s.wait.expcnt(i16)
declare void @llvm.amdgcn.s.wait.kmcnt(i16)
declare void @llvm.amdgcn.s.wait.loadcnt(i16)
declare void @llvm.amdgcn.s.wait.samplecnt(i16)
declare void @llvm.amdgcn.s.wait.storecnt(i16)

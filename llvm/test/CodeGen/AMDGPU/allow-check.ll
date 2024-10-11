; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=amdgcn-amd-mesa3d -global-isel=0 -fast-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple=amdgcn-amd-mesa3d -global-isel=1 -fast-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple=amdgcn-amd-mesa3d -global-isel=0 -fast-isel=1 | FileCheck %s

define i1 @test_runtime() local_unnamed_addr {
; CHECK-LABEL: test_runtime:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 1
; CHECK-NEXT:    s_setpc_b64 s[30:31]
entry:
  %allow = call i1 @llvm.allow.runtime.check(metadata !"test_check")
  ret i1 %allow
}

declare i1 @llvm.allow.runtime.check(metadata) nounwind

define i1 @test_ubsan() local_unnamed_addr {
; CHECK-LABEL: test_ubsan:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, 1
; CHECK-NEXT:    s_setpc_b64 s[30:31]
entry:
  %allow = call i1 @llvm.allow.ubsan.check(i8 7)
  ret i1 %allow
}

declare i1 @llvm.allow.ubsan.check(i8) nounwind

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes=bpf-aspace-simplify -mtriple=bpf-pc-linux -S < %s | FileCheck %s

; Check that when bpf-aspace-simplify pass modifies chain
; 'cast M->N -> GEP -> cast N->M' it does not remove GEP,
; when that GEP is used by some other instruction.

define dso_local ptr addrspace(1) @test (ptr addrspace(1) %p) {
; CHECK-LABEL: define dso_local ptr addrspace(1) @test(
; CHECK-SAME: ptr addrspace(1) [[P:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = addrspacecast ptr addrspace(1) [[P]] to ptr
; CHECK-NEXT:    [[B:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 8
; CHECK-NEXT:    [[B1:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[P]], i64 8
; CHECK-NEXT:    call void @sink(ptr [[B]])
; CHECK-NEXT:    ret ptr addrspace(1) [[B1]]
;
  entry:
  %a = addrspacecast ptr addrspace(1) %p to ptr
  %b = getelementptr inbounds i8, ptr %a, i64 8
  %c = addrspacecast ptr %b to ptr addrspace(1)
  call void @sink(ptr %b)
  ret ptr addrspace(1) %c
}

declare dso_local void @sink(ptr)

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -fast-isel < %s | FileCheck -check-prefixes=CHECK,FASTISEL %s
; RUN: llc < %s | FileCheck -check-prefixes=CHECK,SDAG %s

target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-windows-msvc"

define void @issue56055(ptr addrspace(270) %ptr, ptr %out) {
; CHECK-LABEL: issue56055:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addl $2, %ecx
; CHECK-NEXT:    movl %ecx, (%rdx)
; CHECK-NEXT:    retq
  %add.ptr = getelementptr inbounds i8, ptr addrspace(270) %ptr, i32 2
  store ptr addrspace(270) %add.ptr, ptr %out
  ret void
}

define void @issue56055_vector(<2 x ptr addrspace(270)> %ptr, ptr %out) {
; CHECK-LABEL: issue56055_vector:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movdqa (%rcx), %xmm0
; CHECK-NEXT:    paddd __xmm@00000000000000000000000200000002(%rip), %xmm0
; CHECK-NEXT:    movq %xmm0, (%rdx)
; CHECK-NEXT:    retq
  %add.ptr = getelementptr inbounds i8, <2 x ptr addrspace(270)> %ptr, <2 x i32> <i32 2, i32 2>
  store <2 x ptr addrspace(270)> %add.ptr, ptr %out
  ret void
}

define void @issue56055_small_idx(ptr addrspace(270) %ptr, ptr %out, i16 %idx) {
; CHECK-LABEL: issue56055_small_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movswl %r8w, %eax
; CHECK-NEXT:    addl %ecx, %eax
; CHECK-NEXT:    movl %eax, (%rdx)
; CHECK-NEXT:    retq
  %add.ptr = getelementptr inbounds i8, ptr addrspace(270) %ptr, i16 %idx
  store ptr addrspace(270) %add.ptr, ptr %out
  ret void
}

define void @issue56055_small_idx_vector(<2 x ptr addrspace(270)> %ptr, ptr %out, <2 x i16> %idx) {
; CHECK-LABEL: issue56055_small_idx_vector:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pshuflw {{.*#+}} xmm0 = mem[0,0,2,1,4,5,6,7]
; CHECK-NEXT:    psrad $16, %xmm0
; CHECK-NEXT:    paddd (%rcx), %xmm0
; CHECK-NEXT:    movq %xmm0, (%rdx)
; CHECK-NEXT:    retq
  %add.ptr = getelementptr inbounds i8, <2 x ptr addrspace(270)> %ptr, <2 x i16> %idx
  store <2 x ptr addrspace(270)> %add.ptr, ptr %out
  ret void
}

define void @issue56055_large_idx(ptr addrspace(270) %ptr, ptr %out, i64 %idx) {
; CHECK-LABEL: issue56055_large_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addl %ecx, %r8d
; CHECK-NEXT:    movl %r8d, (%rdx)
; CHECK-NEXT:    retq
  %add.ptr = getelementptr inbounds i8, ptr addrspace(270) %ptr, i64 %idx
  store ptr addrspace(270) %add.ptr, ptr %out
  ret void
}

define void @issue56055_large_idx_vector(<2 x ptr addrspace(270)> %ptr, ptr %out, <2 x i64> %idx) {
; CHECK-LABEL: issue56055_large_idx_vector:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,2,2,3]
; CHECK-NEXT:    paddd (%rcx), %xmm0
; CHECK-NEXT:    movq %xmm0, (%rdx)
; CHECK-NEXT:    retq
  %add.ptr = getelementptr inbounds i8, <2 x ptr addrspace(270)> %ptr, <2 x i64> %idx
  store <2 x ptr addrspace(270)> %add.ptr, ptr %out
  ret void
}

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; FASTISEL: {{.*}}
; SDAG: {{.*}}

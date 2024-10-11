; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s --check-prefixes=ALL,CHECK
; RUN: llc -O0 < %s | FileCheck %s --check-prefixes=ALL,CHECK-O0

; Source to regenerate:
; struct Foo {
;   int * __ptr32 p32;
;   int * __ptr64 p64;
;   __attribute__((address_space(9))) int *p_other;
; };
; void use_foo(Foo *f);
; void test_sign_ext(Foo *f, int * __ptr32 __sptr i) {
;   f->p64 = i;
;   use_foo(f);
; }
; void test_zero_ext(Foo *f, int * __ptr32 __uptr i) {
;   f->p64 = i;
;   use_foo(f);
; }
; void test_trunc(Foo *f, int * __ptr64 i) {
;   f->p32 = i;
;   use_foo(f);
; }
; void test_noop1(Foo *f, int * __ptr32 i) {
;   f->p32 = i;
;   use_foo(f);
; }
; void test_noop2(Foo *f, int * __ptr64 i) {
;   f->p64 = i;
;   use_foo(f);
; }
; void test_null_arg(Foo *f) {
;   test_noop2(f, 0);
; }
; void test_unrecognized(Foo *f, __attribute__((address_space(14))) int *i) {
;   f->p64 = (int * __ptr64)i;
;   use_foo(f);
; }
; void test_unrecognized2(Foo *f, int * __ptr64 i) {
;   f->p_other = i;
;   use_foo(f);
; }
;
; $ clang -cc1 -triple x86_64-windows-msvc -fms-extensions -O2 -S t.cpp

target datalayout = "e-m:x-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i686-unknown-windows-msvc"

%struct.Foo = type { ptr, ptr addrspace(272), ptr addrspace(9) }
declare dso_local void @use_foo(ptr)

define dso_local void @test_sign_ext(ptr %f, ptr %i) {
; CHECK-LABEL: test_sign_ext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %ecx, 8(%eax)
; CHECK-NEXT:    sarl $31, %ecx
; CHECK-NEXT:    movl %ecx, 12(%eax)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_sign_ext:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %edx, %ecx
; CHECK-O0-NEXT:    sarl $31, %ecx
; CHECK-O0-NEXT:    movl %edx, 8(%eax)
; CHECK-O0-NEXT:    movl %ecx, 12(%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  %0 = addrspacecast ptr %i to ptr addrspace(272)
  %p64 = getelementptr inbounds %struct.Foo, ptr %f, i32 0, i32 1
  store ptr addrspace(272) %0, ptr %p64, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

define dso_local void @test_zero_ext(ptr %f, ptr addrspace(271) %i) {
; CHECK-LABEL: test_zero_ext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, 8(%ecx)
; CHECK-NEXT:    movl $0, 12(%ecx)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_zero_ext:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %ecx, 8(%eax)
; CHECK-O0-NEXT:    movl $0, 12(%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  %0 = addrspacecast ptr addrspace(271) %i to ptr addrspace(272)
  %p64 = getelementptr inbounds %struct.Foo, ptr %f, i32 0, i32 1
  store ptr addrspace(272) %0, ptr %p64, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

define dso_local void @test_trunc(ptr %f, ptr addrspace(272) %i) {
; CHECK-LABEL: test_trunc:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, (%ecx)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_trunc:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %ecx, (%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  %0 = addrspacecast ptr addrspace(272) %i to ptr
  store ptr %0, ptr %f, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

define dso_local void @test_noop1(ptr %f, ptr %i) {
; CHECK-LABEL: test_noop1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, (%ecx)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_noop1:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %ecx, (%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  store ptr %i, ptr %f, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

define dso_local void @test_noop2(ptr %f, ptr addrspace(272) %i) {
; CHECK-LABEL: test_noop2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-NEXT:    movl %ecx, 12(%edx)
; CHECK-NEXT:    movl %eax, 8(%edx)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_noop2:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %edx, 8(%eax)
; CHECK-O0-NEXT:    movl %ecx, 12(%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  %p64 = getelementptr inbounds %struct.Foo, ptr %f, i32 0, i32 1
  store ptr addrspace(272) %i, ptr %p64, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

; Test that null can be passed as a 64-bit pointer.
define dso_local void @test_null_arg(ptr %f) {
; CHECK-LABEL: test_null_arg:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl $0
; CHECK-NEXT:    pushl $0
; CHECK-NEXT:    pushl {{[0-9]+}}(%esp)
; CHECK-NEXT:    calll _test_noop2
; CHECK-NEXT:    addl $12, %esp
; CHECK-NEXT:    retl
;
; CHECK-O0-LABEL: test_null_arg:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    subl $12, %esp
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl %esp, %eax
; CHECK-O0-NEXT:    movl %ecx, (%eax)
; CHECK-O0-NEXT:    movl $0, 8(%eax)
; CHECK-O0-NEXT:    movl $0, 4(%eax)
; CHECK-O0-NEXT:    calll _test_noop2
; CHECK-O0-NEXT:    addl $12, %esp
; CHECK-O0-NEXT:    retl
entry:
  call void @test_noop2(ptr %f, ptr addrspace(272) null)
  ret void
}

define dso_local void @test_unrecognized(ptr %f, ptr addrspace(14) %i) {
; CHECK-LABEL: test_unrecognized:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %ecx, 8(%eax)
; CHECK-NEXT:    sarl $31, %ecx
; CHECK-NEXT:    movl %ecx, 12(%eax)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_unrecognized:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %edx, %ecx
; CHECK-O0-NEXT:    sarl $31, %ecx
; CHECK-O0-NEXT:    movl %edx, 8(%eax)
; CHECK-O0-NEXT:    movl %ecx, 12(%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  %0 = addrspacecast ptr addrspace(14) %i to ptr addrspace(272)
  %p64 = getelementptr inbounds %struct.Foo, ptr %f, i32 0, i32 1
  store ptr addrspace(272) %0, ptr %p64, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

define dso_local void @test_unrecognized2(ptr %f, ptr addrspace(272) %i) {
; CHECK-LABEL: test_unrecognized2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, 16(%ecx)
; CHECK-NEXT:    jmp _use_foo # TAILCALL
;
; CHECK-O0-LABEL: test_unrecognized2:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %ecx, 16(%eax)
; CHECK-O0-NEXT:    jmp _use_foo # TAILCALL
entry:
  %0 = addrspacecast ptr addrspace(272) %i to ptr addrspace(9)
  %p_other = getelementptr inbounds %struct.Foo, ptr %f, i32 0, i32 2
  store ptr addrspace(9) %0, ptr %p_other, align 8
  tail call void @use_foo(ptr %f)
  ret void
}

define i32 @test_load_sptr32(ptr addrspace(270) %i) {
; ALL-LABEL: test_load_sptr32:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    movl {{[0-9]+}}(%esp), %eax
; ALL-NEXT:    movl (%eax), %eax
; ALL-NEXT:    retl
entry:
  %0 = load i32, ptr addrspace(270) %i, align 4
  ret i32 %0
}

define i32 @test_load_uptr32(ptr addrspace(271) %i) {
; ALL-LABEL: test_load_uptr32:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    movl {{[0-9]+}}(%esp), %eax
; ALL-NEXT:    movl (%eax), %eax
; ALL-NEXT:    retl
entry:
  %0 = load i32, ptr addrspace(271) %i, align 4
  ret i32 %0
}

define i32 @test_load_ptr64(ptr addrspace(272) %i) {
; CHECK-LABEL: test_load_ptr64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    retl
;
; CHECK-O0-LABEL: test_load_ptr64:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl (%eax), %eax
; CHECK-O0-NEXT:    retl
entry:
  %0 = load i32, ptr addrspace(272) %i, align 8
  ret i32 %0
}

define void @test_store_sptr32(ptr addrspace(270) %s, i32 %i) {
; CHECK-LABEL: test_store_sptr32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, (%ecx)
; CHECK-NEXT:    retl
;
; CHECK-O0-LABEL: test_store_sptr32:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %ecx, (%eax)
; CHECK-O0-NEXT:    retl
entry:
  store i32 %i, ptr addrspace(270) %s, align 4
  ret void
}

define void @test_store_uptr32(ptr addrspace(271) %s, i32 %i) {
; CHECK-LABEL: test_store_uptr32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, (%ecx)
; CHECK-NEXT:    retl
;
; CHECK-O0-LABEL: test_store_uptr32:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl %ecx, (%eax)
; CHECK-O0-NEXT:    retl
entry:
  store i32 %i, ptr addrspace(271) %s, align 4
  ret void
}

define void @test_store_ptr64(ptr addrspace(272) %s, i32 %i) {
; CHECK-LABEL: test_store_ptr64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, (%ecx)
; CHECK-NEXT:    retl
;
; CHECK-O0-LABEL: test_store_ptr64:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl %ecx, (%eax)
; CHECK-O0-NEXT:    retl
entry:
  store i32 %i, ptr addrspace(272) %s, align 8
  ret void
}

define i64 @test_load_sptr32_zext_i64(ptr addrspace(270) %i) {
; ALL-LABEL: test_load_sptr32_zext_i64:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    movl {{[0-9]+}}(%esp), %eax
; ALL-NEXT:    movl (%eax), %eax
; ALL-NEXT:    xorl %edx, %edx
; ALL-NEXT:    retl
entry:
  %0 = load i32, ptr addrspace(270) %i, align 4
  %1 = zext i32 %0 to i64
  ret i64 %1
}

define void @test_store_sptr32_trunc_i1(ptr addrspace(270) %s, i32 %i) {
; CHECK-LABEL: test_store_sptr32_trunc_i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    andl $1, %ecx
; CHECK-NEXT:    movb %cl, (%eax)
; CHECK-NEXT:    retl
;
; CHECK-O0-LABEL: test_store_sptr32_trunc_i1:
; CHECK-O0:       # %bb.0: # %entry
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-O0-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-O0-NEXT:    andl $1, %ecx
; CHECK-O0-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-O0-NEXT:    movb %cl, (%eax)
; CHECK-O0-NEXT:    retl
entry:
  %0 = trunc i32 %i to i1
  store i1 %0, ptr addrspace(270) %s
  ret void
}

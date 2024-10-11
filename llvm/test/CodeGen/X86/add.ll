; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-linux -verify-machineinstrs | FileCheck %s --check-prefix=X64-LINUX
; RUN: llc < %s -mtriple=x86_64-win32 | FileCheck %s --check-prefix=X64-WIN32

declare {i32, i1} @llvm.sadd.with.overflow.i32(i32, i32)
declare {i32, i1} @llvm.uadd.with.overflow.i32(i32, i32)

; The immediate can be encoded in a smaller way if the
; instruction is a sub instead of an add.
define i32 @test1(i32 inreg %a) nounwind {
; X86-LABEL: test1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    subl $-128, %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test1:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-LINUX-NEXT:    leal 128(%rdi), %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test1:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    # kill: def $ecx killed $ecx def $rcx
; X64-WIN32-NEXT:    leal 128(%rcx), %eax
; X64-WIN32-NEXT:    retq
entry:
  %b = add i32 %a, 128
  ret i32 %b
}

define i32 @test1b(ptr %p) nounwind {
; X86-LABEL: test1b:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    subl $-128, %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test1b:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    movl (%rdi), %eax
; X64-LINUX-NEXT:    subl $-128, %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test1b:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    movl (%rcx), %eax
; X64-WIN32-NEXT:    subl $-128, %eax
; X64-WIN32-NEXT:    retq
entry:
  %a = load i32, ptr %p
  %b = add i32 %a, 128
  ret i32 %b
}

define i64 @test2(i64 inreg %a) nounwind {
; X86-LABEL: test2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    addl $-2147483648, %eax # imm = 0x80000000
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test2:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    movq %rdi, %rax
; X64-LINUX-NEXT:    subq $-2147483648, %rax # imm = 0x80000000
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test2:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    movq %rcx, %rax
; X64-WIN32-NEXT:    subq $-2147483648, %rax # imm = 0x80000000
; X64-WIN32-NEXT:    retq
entry:
  %b = add i64 %a, 2147483648
  ret i64 %b
}
define i64 @test3(i64 inreg %a) nounwind {
; X86-LABEL: test3:
; X86:       # %bb.0: # %entry
; X86-NEXT:    addl $128, %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test3:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    leaq 128(%rdi), %rax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test3:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    leaq 128(%rcx), %rax
; X64-WIN32-NEXT:    retq
entry:
  %b = add i64 %a, 128
  ret i64 %b
}

define i64 @test3b(ptr %p) nounwind {
; X86-LABEL: test3b:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl 4(%ecx), %edx
; X86-NEXT:    movl $128, %eax
; X86-NEXT:    addl (%ecx), %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test3b:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    movq (%rdi), %rax
; X64-LINUX-NEXT:    subq $-128, %rax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test3b:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    movq (%rcx), %rax
; X64-WIN32-NEXT:    subq $-128, %rax
; X64-WIN32-NEXT:    retq
entry:
  %a = load i64, ptr %p
  %b = add i64 %a, 128
  ret i64 %b
}

define i1 @test4(i32 %v1, i32 %v2, ptr %X) nounwind {
; X86-LABEL: test4:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    jo .LBB5_2
; X86-NEXT:  # %bb.1: # %normal
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $0, (%eax)
; X86-NEXT:  .LBB5_2: # %overflow
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test4:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    addl %esi, %edi
; X64-LINUX-NEXT:    jo .LBB5_2
; X64-LINUX-NEXT:  # %bb.1: # %normal
; X64-LINUX-NEXT:    movl $0, (%rdx)
; X64-LINUX-NEXT:  .LBB5_2: # %overflow
; X64-LINUX-NEXT:    xorl %eax, %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test4:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    addl %edx, %ecx
; X64-WIN32-NEXT:    jo .LBB5_2
; X64-WIN32-NEXT:  # %bb.1: # %normal
; X64-WIN32-NEXT:    movl $0, (%r8)
; X64-WIN32-NEXT:  .LBB5_2: # %overflow
; X64-WIN32-NEXT:    xorl %eax, %eax
; X64-WIN32-NEXT:    retq
entry:
  %t = call {i32, i1} @llvm.sadd.with.overflow.i32(i32 %v1, i32 %v2)
  %sum = extractvalue {i32, i1} %t, 0
  %obit = extractvalue {i32, i1} %t, 1
  br i1 %obit, label %overflow, label %normal

normal:
  store i32 0, ptr %X
  br label %overflow

overflow:
  ret i1 false
}

define i1 @test5(i32 %v1, i32 %v2, ptr %X) nounwind {
; X86-LABEL: test5:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    jb .LBB6_2
; X86-NEXT:  # %bb.1: # %normal
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $0, (%eax)
; X86-NEXT:  .LBB6_2: # %carry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test5:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    addl %esi, %edi
; X64-LINUX-NEXT:    jb .LBB6_2
; X64-LINUX-NEXT:  # %bb.1: # %normal
; X64-LINUX-NEXT:    movl $0, (%rdx)
; X64-LINUX-NEXT:  .LBB6_2: # %carry
; X64-LINUX-NEXT:    xorl %eax, %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test5:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    addl %edx, %ecx
; X64-WIN32-NEXT:    jb .LBB6_2
; X64-WIN32-NEXT:  # %bb.1: # %normal
; X64-WIN32-NEXT:    movl $0, (%r8)
; X64-WIN32-NEXT:  .LBB6_2: # %carry
; X64-WIN32-NEXT:    xorl %eax, %eax
; X64-WIN32-NEXT:    retq
entry:
  %t = call {i32, i1} @llvm.uadd.with.overflow.i32(i32 %v1, i32 %v2)
  %sum = extractvalue {i32, i1} %t, 0
  %obit = extractvalue {i32, i1} %t, 1
  br i1 %obit, label %carry, label %normal

normal:
  store i32 0, ptr %X
  br label %carry

carry:
  ret i1 false
}

define i64 @test6(i64 %A, i32 %B) nounwind {
; X86-LABEL: test6:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test6:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-LINUX-NEXT:    shlq $32, %rsi
; X64-LINUX-NEXT:    leaq (%rsi,%rdi), %rax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test6:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    # kill: def $edx killed $edx def $rdx
; X64-WIN32-NEXT:    shlq $32, %rdx
; X64-WIN32-NEXT:    leaq (%rdx,%rcx), %rax
; X64-WIN32-NEXT:    retq
entry:
  %tmp12 = zext i32 %B to i64
  %tmp3 = shl i64 %tmp12, 32
  %tmp5 = add i64 %tmp3, %A
  ret i64 %tmp5
}

define {i32, i1} @test7(i32 %v1, i32 %v2) nounwind {
; X86-LABEL: test7:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setb %dl
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test7:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    movl %edi, %eax
; X64-LINUX-NEXT:    addl %esi, %eax
; X64-LINUX-NEXT:    setb %dl
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test7:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    movl %ecx, %eax
; X64-WIN32-NEXT:    addl %edx, %eax
; X64-WIN32-NEXT:    setb %dl
; X64-WIN32-NEXT:    retq
entry:
  %t = call {i32, i1} @llvm.uadd.with.overflow.i32(i32 %v1, i32 %v2)
  ret {i32, i1} %t
}

; PR5443
define {i64, i1} @test8(i64 %left, i64 %right) nounwind {
; X86-LABEL: test8:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    setb %cl
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test8:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    movq %rdi, %rax
; X64-LINUX-NEXT:    addq %rsi, %rax
; X64-LINUX-NEXT:    setb %dl
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test8:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    movq %rcx, %rax
; X64-WIN32-NEXT:    addq %rdx, %rax
; X64-WIN32-NEXT:    setb %dl
; X64-WIN32-NEXT:    retq
entry:
  %extleft = zext i64 %left to i65
  %extright = zext i64 %right to i65
  %sum = add i65 %extleft, %extright
  %res.0 = trunc i65 %sum to i64
  %overflow = and i65 %sum, -18446744073709551616
  %res.1 = icmp ne i65 %overflow, 0
  %final0 = insertvalue {i64, i1} undef, i64 %res.0, 0
  %final1 = insertvalue {i64, i1} %final0, i1 %res.1, 1
  ret {i64, i1} %final1
}

define i32 @test9(i32 %x, i32 %y) nounwind readnone {
; X86-LABEL: test9:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    cmpl $10, {{[0-9]+}}(%esp)
; X86-NEXT:    sete %cl
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test9:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    movl %esi, %eax
; X64-LINUX-NEXT:    xorl %ecx, %ecx
; X64-LINUX-NEXT:    cmpl $10, %edi
; X64-LINUX-NEXT:    sete %cl
; X64-LINUX-NEXT:    subl %ecx, %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test9:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    movl %edx, %eax
; X64-WIN32-NEXT:    xorl %edx, %edx
; X64-WIN32-NEXT:    cmpl $10, %ecx
; X64-WIN32-NEXT:    sete %dl
; X64-WIN32-NEXT:    subl %edx, %eax
; X64-WIN32-NEXT:    retq
entry:
  %cmp = icmp eq i32 %x, 10
  %sub = sext i1 %cmp to i32
  %cond = add i32 %sub, %y
  ret i32 %cond
}

define i1 @test10(i32 %x) nounwind {
; X86-LABEL: test10:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    incl %eax
; X86-NEXT:    seto %al
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test10:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    incl %edi
; X64-LINUX-NEXT:    seto %al
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test10:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    incl %ecx
; X64-WIN32-NEXT:    seto %al
; X64-WIN32-NEXT:    retq
entry:
  %t = call {i32, i1} @llvm.sadd.with.overflow.i32(i32 %x, i32 1)
  %obit = extractvalue {i32, i1} %t, 1
  ret i1 %obit
}

define void @test11(ptr inreg %a) nounwind {
; X86-LABEL: test11:
; X86:       # %bb.0: # %entry
; X86-NEXT:    subl $-128, (%eax)
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test11:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    subl $-128, (%rdi)
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test11:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    subl $-128, (%rcx)
; X64-WIN32-NEXT:    retq
entry:
  %aa = load i32, ptr %a
  %b = add i32 %aa, 128
  store i32 %b, ptr %a
  ret void
}

define void @test12(ptr inreg %a) nounwind {
; X86-LABEL: test12:
; X86:       # %bb.0: # %entry
; X86-NEXT:    addl $-2147483648, (%eax) # imm = 0x80000000
; X86-NEXT:    adcl $0, 4(%eax)
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test12:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    subq $-2147483648, (%rdi) # imm = 0x80000000
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test12:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    subq $-2147483648, (%rcx) # imm = 0x80000000
; X64-WIN32-NEXT:    retq
entry:
  %aa = load i64, ptr %a
  %b = add i64 %aa, 2147483648
  store i64 %b, ptr %a
  ret void
}

define void @test13(ptr inreg %a) nounwind {
; X86-LABEL: test13:
; X86:       # %bb.0: # %entry
; X86-NEXT:    addl $128, (%eax)
; X86-NEXT:    adcl $0, 4(%eax)
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: test13:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    subq $-128, (%rdi)
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: test13:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    subq $-128, (%rcx)
; X64-WIN32-NEXT:    retq
entry:
  %aa = load i64, ptr %a
  %b = add i64 %aa, 128
  store i64 %b, ptr %a
  ret void
}

define i32 @inc_not(i32 %a) {
; X86-LABEL: inc_not:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: inc_not:
; X64-LINUX:       # %bb.0:
; X64-LINUX-NEXT:    movl %edi, %eax
; X64-LINUX-NEXT:    negl %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: inc_not:
; X64-WIN32:       # %bb.0:
; X64-WIN32-NEXT:    movl %ecx, %eax
; X64-WIN32-NEXT:    negl %eax
; X64-WIN32-NEXT:    retq
  %nota = xor i32 %a, -1
  %r = add i32 %nota, 1
  ret i32 %r
}

define <4 x i32> @inc_not_vec(<4 x i32> %a) nounwind {
; X86-LABEL: inc_not_vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %esi, %esi
; X86-NEXT:    subl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    xorl %edi, %edi
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, 12(%eax)
; X86-NEXT:    movl %edi, 8(%eax)
; X86-NEXT:    movl %esi, 4(%eax)
; X86-NEXT:    movl %edx, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl $4
;
; X64-LINUX-LABEL: inc_not_vec:
; X64-LINUX:       # %bb.0:
; X64-LINUX-NEXT:    pxor %xmm1, %xmm1
; X64-LINUX-NEXT:    psubd %xmm0, %xmm1
; X64-LINUX-NEXT:    movdqa %xmm1, %xmm0
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: inc_not_vec:
; X64-WIN32:       # %bb.0:
; X64-WIN32-NEXT:    pxor %xmm0, %xmm0
; X64-WIN32-NEXT:    psubd (%rcx), %xmm0
; X64-WIN32-NEXT:    retq
  %nota = xor <4 x i32> %a, <i32 -1, i32 -1, i32 -1, i32 -1>
  %r = add <4 x i32> %nota, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %r
}

define void @uaddo1_not(i32 %a, ptr %p0, ptr %p1) {
; X86-LABEL: uaddo1_not:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, (%ecx)
; X86-NEXT:    setae (%eax)
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: uaddo1_not:
; X64-LINUX:       # %bb.0:
; X64-LINUX-NEXT:    negl %edi
; X64-LINUX-NEXT:    movl %edi, (%rsi)
; X64-LINUX-NEXT:    setae (%rdx)
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: uaddo1_not:
; X64-WIN32:       # %bb.0:
; X64-WIN32-NEXT:    negl %ecx
; X64-WIN32-NEXT:    movl %ecx, (%rdx)
; X64-WIN32-NEXT:    setae (%r8)
; X64-WIN32-NEXT:    retq
  %nota = xor i32 %a, -1
  %uaddo = call {i32, i1} @llvm.uadd.with.overflow.i32(i32 %nota, i32 1)
  %r0 = extractvalue {i32, i1} %uaddo, 0
  %r1 = extractvalue {i32, i1} %uaddo, 1
  store i32 %r0, ptr %p0
  store i1 %r1, ptr %p1
  ret void
}

define i32 @add_to_sub(i32 %a, i32 %b) {
; X86-LABEL: add_to_sub:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: add_to_sub:
; X64-LINUX:       # %bb.0:
; X64-LINUX-NEXT:    movl %esi, %eax
; X64-LINUX-NEXT:    subl %edi, %eax
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: add_to_sub:
; X64-WIN32:       # %bb.0:
; X64-WIN32-NEXT:    movl %edx, %eax
; X64-WIN32-NEXT:    subl %ecx, %eax
; X64-WIN32-NEXT:    retq
  %nota = xor i32 %a, -1
  %add = add i32 %nota, %b
  %r = add i32 %add, 1
  ret i32 %r
}

declare dso_local void @bar_i32(i32)
declare dso_local void @bar_i64(i64)

; Make sure we can use sub -128 for add 128 when the flags are used.
define void @add_i32_128_flag(i32 %x) {
; X86-LABEL: add_i32_128_flag:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    subl $-128, %eax
; X86-NEXT:    je .LBB19_2
; X86-NEXT:  # %bb.1: # %if.then
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll bar_i32
; X86-NEXT:    addl $4, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -4
; X86-NEXT:  .LBB19_2: # %if.end
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: add_i32_128_flag:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    subl $-128, %edi
; X64-LINUX-NEXT:    jne bar_i32 # TAILCALL
; X64-LINUX-NEXT:  # %bb.1: # %if.end
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: add_i32_128_flag:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    subl $-128, %ecx
; X64-WIN32-NEXT:    jne bar_i32 # TAILCALL
; X64-WIN32-NEXT:  # %bb.1: # %if.end
; X64-WIN32-NEXT:    retq
entry:
  %add = add i32 %x, 128
  %tobool = icmp eq i32 %add, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:
  tail call void @bar_i32(i32 %add)
  br label %if.end

if.end:
  ret void
}

; Make sure we can use sub -128 for add 128 when the flags are used.
define void @add_i64_128_flag(i64 %x) {
; X86-LABEL: add_i64_128_flag:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $128, %eax
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    adcl $0, %ecx
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    orl %ecx, %edx
; X86-NEXT:    je .LBB20_2
; X86-NEXT:  # %bb.1: # %if.then
; X86-NEXT:    pushl %ecx
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll bar_i64
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:  .LBB20_2: # %if.end
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: add_i64_128_flag:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    subq $-128, %rdi
; X64-LINUX-NEXT:    jne bar_i64 # TAILCALL
; X64-LINUX-NEXT:  # %bb.1: # %if.end
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: add_i64_128_flag:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    subq $-128, %rcx
; X64-WIN32-NEXT:    jne bar_i64 # TAILCALL
; X64-WIN32-NEXT:  # %bb.1: # %if.end
; X64-WIN32-NEXT:    retq
entry:
  %add = add i64 %x, 128
  %tobool = icmp eq i64 %add, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:
  tail call void @bar_i64(i64 %add)
  br label %if.end

if.end:
  ret void
}

; Make sure we can use sub -2147483648 for add 2147483648 when the flags are used.
define void @add_i64_2147483648_flag(i64 %x) {
; X86-LABEL: add_i64_2147483648_flag:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $-2147483648, %eax # imm = 0x80000000
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    adcl $0, %ecx
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    orl %ecx, %edx
; X86-NEXT:    je .LBB21_2
; X86-NEXT:  # %bb.1: # %if.then
; X86-NEXT:    pushl %ecx
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_adjust_cfa_offset 4
; X86-NEXT:    calll bar_i64
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_adjust_cfa_offset -8
; X86-NEXT:  .LBB21_2: # %if.end
; X86-NEXT:    retl
;
; X64-LINUX-LABEL: add_i64_2147483648_flag:
; X64-LINUX:       # %bb.0: # %entry
; X64-LINUX-NEXT:    subq $-2147483648, %rdi # imm = 0x80000000
; X64-LINUX-NEXT:    jne bar_i64 # TAILCALL
; X64-LINUX-NEXT:  # %bb.1: # %if.end
; X64-LINUX-NEXT:    retq
;
; X64-WIN32-LABEL: add_i64_2147483648_flag:
; X64-WIN32:       # %bb.0: # %entry
; X64-WIN32-NEXT:    subq $-2147483648, %rcx # imm = 0x80000000
; X64-WIN32-NEXT:    jne bar_i64 # TAILCALL
; X64-WIN32-NEXT:  # %bb.1: # %if.end
; X64-WIN32-NEXT:    retq
entry:
  %add = add i64 %x, 2147483648
  %tobool = icmp eq i64 %add, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:
  tail call void @bar_i64(i64 %add)
  br label %if.end

if.end:
  ret void
}

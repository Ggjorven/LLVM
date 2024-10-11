; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+sse4.2 |  FileCheck %s

define void @update(ptr %dst, ptr %src, i32 %n) nounwind {
; CHECK-LABEL: update:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %eax
; CHECK-NEXT:    movl $0, (%esp)
; CHECK-NEXT:    pcmpeqd %xmm0, %xmm0
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_1: # %forcond
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movl (%esp), %eax
; CHECK-NEXT:    cmpl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    jge .LBB0_3
; CHECK-NEXT:  # %bb.2: # %forbody
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movl (%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    psubb %xmm0, %xmm1
; CHECK-NEXT:    pextrb $2, %xmm1, 2(%ecx,%eax,4)
; CHECK-NEXT:    pextrw $0, %xmm1, (%ecx,%eax,4)
; CHECK-NEXT:    incl (%esp)
; CHECK-NEXT:    jmp .LBB0_1
; CHECK-NEXT:  .LBB0_3: # %afterfor
; CHECK-NEXT:    popl %eax
; CHECK-NEXT:    retl
entry:
	%dst.addr = alloca ptr
	%src.addr = alloca ptr
	%n.addr = alloca i32
	%i = alloca i32, align 4
	store ptr %dst, ptr %dst.addr
	store ptr %src, ptr %src.addr
	store i32 %n, ptr %n.addr
	store i32 0, ptr %i
	br label %forcond

forcond:
	%tmp = load i32, ptr %i
	%tmp1 = load i32, ptr %n.addr
	%cmp = icmp slt i32 %tmp, %tmp1
	br i1 %cmp, label %forbody, label %afterfor

forbody:
	%tmp2 = load i32, ptr %i
	%tmp3 = load ptr, ptr %dst.addr
	%arrayidx = getelementptr <3 x i8>, ptr %tmp3, i32 %tmp2
	%tmp4 = load i32, ptr %i
	%tmp5 = load ptr, ptr %src.addr
	%arrayidx6 = getelementptr <3 x i8>, ptr %tmp5, i32 %tmp4
	%tmp7 = load <3 x i8>, ptr %arrayidx6
	%add = add <3 x i8> %tmp7, < i8 1, i8 1, i8 1 >
	store <3 x i8> %add, ptr %arrayidx
	br label %forinc

forinc:
	%tmp8 = load i32, ptr %i
	%inc = add i32 %tmp8, 1
	store i32 %inc, ptr %i
	br label %forcond

afterfor:
	ret void
}


; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64

@v16 = dso_local global i16 0, align 2
@v32 = dso_local global i32 0, align 4
@v64 = dso_local global i64 0, align 8

define i16 @bts1() nounwind {
; X86-LABEL: bts1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btsw $0, v16
; X86-NEXT:    setb %al
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: bts1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsw $0, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v16, i16 1 monotonic, align 2
  %and = and i16 %0, 1
  ret i16 %and
}

define i16 @bts2() nounwind {
; X86-LABEL: bts2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btsw $1, v16
; X86-NEXT:    setb %al
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: bts2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsw $1, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    addl %eax, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v16, i16 2 monotonic, align 2
  %and = and i16 %0, 2
  ret i16 %and
}

define i16 @bts15() nounwind {
; X86-LABEL: bts15:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btsw $15, v16
; X86-NEXT:    setb %al
; X86-NEXT:    shll $15, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: bts15:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsw $15, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shll $15, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v16, i16 32768 monotonic, align 2
  %and = and i16 %0, 32768
  ret i16 %and
}

define i32 @bts31() nounwind {
; X86-LABEL: bts31:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btsl $31, v32
; X86-NEXT:    setb %al
; X86-NEXT:    shll $31, %eax
; X86-NEXT:    retl
;
; X64-LABEL: bts31:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsl $31, v32(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shll $31, %eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v32, i32 2147483648 monotonic, align 4
  %and = and i32 %0, 2147483648
  ret i32 %and
}

define i64 @bts63() nounwind {
; X86-LABEL: bts63:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl $-2147483648, %esi # imm = 0x80000000
; X86-NEXT:    movl v64+4, %edx
; X86-NEXT:    movl v64, %eax
; X86-NEXT:    .p2align 4, 0x90
; X86-NEXT:  .LBB4_1: # %atomicrmw.start
; X86-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    orl %esi, %ecx
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    lock cmpxchg8b v64
; X86-NEXT:    jne .LBB4_1
; X86-NEXT:  # %bb.2: # %atomicrmw.end
; X86-NEXT:    andl %esi, %edx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: bts63:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsq $63, v64(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shlq $63, %rax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v64, i64 -9223372036854775808 monotonic, align 8
  %and = and i64 %0, -9223372036854775808
  ret i64 %and
}

define i16 @btc1() nounwind {
; X86-LABEL: btc1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btcw $0, v16
; X86-NEXT:    setb %al
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: btc1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btcw $0, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw xor ptr @v16, i16 1 monotonic, align 2
  %and = and i16 %0, 1
  ret i16 %and
}

define i16 @btc2() nounwind {
; X86-LABEL: btc2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btcw $1, v16
; X86-NEXT:    setb %al
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: btc2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btcw $1, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    addl %eax, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw xor ptr @v16, i16 2 monotonic, align 2
  %and = and i16 %0, 2
  ret i16 %and
}

define i16 @btc15() nounwind {
; X86-LABEL: btc15:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movw $-32768, %ax # imm = 0x8000
; X86-NEXT:    lock xaddw %ax, v16
; X86-NEXT:    andl $32768, %eax # imm = 0x8000
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: btc15:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movw $-32768, %ax # imm = 0x8000
; X64-NEXT:    lock xaddw %ax, v16(%rip)
; X64-NEXT:    andl $32768, %eax # imm = 0x8000
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw xor ptr @v16, i16 32768 monotonic, align 2
  %and = and i16 %0, 32768
  ret i16 %and
}

define i32 @btc31() nounwind {
; X86-LABEL: btc31:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl $-2147483648, %eax # imm = 0x80000000
; X86-NEXT:    lock xaddl %eax, v32
; X86-NEXT:    andl $-2147483648, %eax # imm = 0x80000000
; X86-NEXT:    retl
;
; X64-LABEL: btc31:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl $-2147483648, %eax # imm = 0x80000000
; X64-NEXT:    lock xaddl %eax, v32(%rip)
; X64-NEXT:    andl $-2147483648, %eax # imm = 0x80000000
; X64-NEXT:    retq
entry:
  %0 = atomicrmw xor ptr @v32, i32 2147483648 monotonic, align 4
  %and = and i32 %0, 2147483648
  ret i32 %and
}

define i64 @btc63() nounwind {
; X86-LABEL: btc63:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl $-2147483648, %esi # imm = 0x80000000
; X86-NEXT:    movl v64+4, %edx
; X86-NEXT:    movl v64, %eax
; X86-NEXT:    .p2align 4, 0x90
; X86-NEXT:  .LBB9_1: # %atomicrmw.start
; X86-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    xorl %esi, %ecx
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    lock cmpxchg8b v64
; X86-NEXT:    jne .LBB9_1
; X86-NEXT:  # %bb.2: # %atomicrmw.end
; X86-NEXT:    andl %esi, %edx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: btc63:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movabsq $-9223372036854775808, %rcx # imm = 0x8000000000000000
; X64-NEXT:    movq %rcx, %rax
; X64-NEXT:    lock xaddq %rax, v64(%rip)
; X64-NEXT:    andq %rcx, %rax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw xor ptr @v64, i64 -9223372036854775808 monotonic, align 8
  %and = and i64 %0, -9223372036854775808
  ret i64 %and
}

define i16 @btr1() nounwind {
; X86-LABEL: btr1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btrw $0, v16
; X86-NEXT:    setb %al
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: btr1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btrw $0, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw and ptr @v16, i16 -2 monotonic, align 2
  %and = and i16 %0, 1
  ret i16 %and
}

define i16 @btr2() nounwind {
; X86-LABEL: btr2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btrw $1, v16
; X86-NEXT:    setb %al
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: btr2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btrw $1, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    addl %eax, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw and ptr @v16, i16 -3 monotonic, align 2
  %and = and i16 %0, 2
  ret i16 %and
}

define i16 @btr15() nounwind {
; X86-LABEL: btr15:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btrw $15, v16
; X86-NEXT:    setb %al
; X86-NEXT:    shll $15, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: btr15:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btrw $15, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shll $15, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw and ptr @v16, i16 32767 monotonic, align 2
  %and = and i16 %0, 32768
  ret i16 %and
}

define i32 @btr31() nounwind {
; X86-LABEL: btr31:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btrl $31, v32
; X86-NEXT:    setb %al
; X86-NEXT:    shll $31, %eax
; X86-NEXT:    retl
;
; X64-LABEL: btr31:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btrl $31, v32(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shll $31, %eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw and ptr @v32, i32 2147483647 monotonic, align 4
  %and = and i32 %0, 2147483648
  ret i32 %and
}

define i64 @btr63() nounwind {
; X86-LABEL: btr63:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl $2147483647, %esi # imm = 0x7FFFFFFF
; X86-NEXT:    movl $-1, %edi
; X86-NEXT:    movl v64+4, %edx
; X86-NEXT:    movl v64, %eax
; X86-NEXT:    .p2align 4, 0x90
; X86-NEXT:  .LBB14_1: # %atomicrmw.start
; X86-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    andl %edi, %ebx
; X86-NEXT:    movl %edx, %ecx
; X86-NEXT:    andl %esi, %ecx
; X86-NEXT:    lock cmpxchg8b v64
; X86-NEXT:    jne .LBB14_1
; X86-NEXT:  # %bb.2: # %atomicrmw.end
; X86-NEXT:    addl $1, %edi
; X86-NEXT:    adcl $0, %esi
; X86-NEXT:    andl %edi, %eax
; X86-NEXT:    andl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: btr63:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btrq $63, v64(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shlq $63, %rax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw and ptr @v64, i64 9223372036854775807 monotonic, align 8
  %and = and i64 %0, -9223372036854775808
  ret i64 %and
}

define i16 @multi_use1() nounwind {
; X86-LABEL: multi_use1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzwl v16, %eax
; X86-NEXT:    .p2align 4, 0x90
; X86-NEXT:  .LBB15_1: # %atomicrmw.start
; X86-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    orl $1, %ecx
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    lock cmpxchgw %cx, v16
; X86-NEXT:    # kill: def $ax killed $ax def $eax
; X86-NEXT:    jne .LBB15_1
; X86-NEXT:  # %bb.2: # %atomicrmw.end
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    xorl $2, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: multi_use1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movzwl v16(%rip), %eax
; X64-NEXT:    .p2align 4, 0x90
; X64-NEXT:  .LBB15_1: # %atomicrmw.start
; X64-NEXT:    # =>This Inner Loop Header: Depth=1
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    orl $1, %ecx
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    lock cmpxchgw %cx, v16(%rip)
; X64-NEXT:    # kill: def $ax killed $ax def $eax
; X64-NEXT:    jne .LBB15_1
; X64-NEXT:  # %bb.2: # %atomicrmw.end
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    andl $1, %ecx
; X64-NEXT:    xorl $2, %eax
; X64-NEXT:    orl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v16, i16 1 monotonic, align 2
  %1 = and i16 %0, 1
  %2 = xor i16 %0, 2
  %3 = or i16 %1, %2
  ret i16 %3
}

define i16 @multi_use2() nounwind {
; X86-LABEL: multi_use2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btsw $0, v16
; X86-NEXT:    setb %al
; X86-NEXT:    leal (%eax,%eax,2), %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: multi_use2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsw $0, v16(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    leal (%rax,%rax,2), %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v16, i16 1 monotonic, align 2
  %1 = and i16 %0, 1
  %2 = shl i16 %1, 1
  %3 = or i16 %1, %2
  ret i16 %3
}

define i16 @use_in_diff_bb() nounwind {
; X86-LABEL: use_in_diff_bb:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzwl v16, %esi
; X86-NEXT:    .p2align 4, 0x90
; X86-NEXT:  .LBB17_1: # %atomicrmw.start
; X86-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NEXT:    movl %esi, %ecx
; X86-NEXT:    orl $1, %ecx
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    lock cmpxchgw %cx, v16
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    jne .LBB17_1
; X86-NEXT:  # %bb.2: # %atomicrmw.end
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    testb %al, %al
; X86-NEXT:    jne .LBB17_4
; X86-NEXT:  # %bb.3:
; X86-NEXT:    calll foo@PLT
; X86-NEXT:  .LBB17_4:
; X86-NEXT:    andl $1, %esi
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
;
; X64-LABEL: use_in_diff_bb:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pushq %rbx
; X64-NEXT:    movzwl v16(%rip), %ebx
; X64-NEXT:    .p2align 4, 0x90
; X64-NEXT:  .LBB17_1: # %atomicrmw.start
; X64-NEXT:    # =>This Inner Loop Header: Depth=1
; X64-NEXT:    movl %ebx, %ecx
; X64-NEXT:    orl $1, %ecx
; X64-NEXT:    movl %ebx, %eax
; X64-NEXT:    lock cmpxchgw %cx, v16(%rip)
; X64-NEXT:    movl %eax, %ebx
; X64-NEXT:    jne .LBB17_1
; X64-NEXT:  # %bb.2: # %atomicrmw.end
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testb %al, %al
; X64-NEXT:    jne .LBB17_4
; X64-NEXT:  # %bb.3:
; X64-NEXT:    callq foo@PLT
; X64-NEXT:  .LBB17_4:
; X64-NEXT:    andl $1, %ebx
; X64-NEXT:    movl %ebx, %eax
; X64-NEXT:    popq %rbx
; X64-NEXT:    retq
entry:
  %0 = atomicrmw or ptr @v16, i16 1 monotonic, align 2
  br i1 undef, label %1, label %2
1:
  call void @foo()
  br label %3
2:
  br label %3
3:
  %and = and i16 %0, 1
  ret i16 %and
}

declare void @foo()

define void @no_and_cmp0_fold() nounwind {
; X86-LABEL: no_and_cmp0_fold:
; X86:       # %bb.0: # %entry
; X86-NEXT:    lock btsl $3, v32
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    testb %al, %al
; X86-NEXT:    je .LBB18_1
; X86-NEXT:  # %bb.2: # %if.end
; X86-NEXT:    retl
; X86-NEXT:  .LBB18_1: # %if.then
;
; X64-LABEL: no_and_cmp0_fold:
; X64:       # %bb.0: # %entry
; X64-NEXT:    lock btsl $3, v32(%rip)
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testb %al, %al
; X64-NEXT:    je .LBB18_1
; X64-NEXT:  # %bb.2: # %if.end
; X64-NEXT:    retq
; X64-NEXT:  .LBB18_1: # %if.then
entry:
  %0 = atomicrmw or ptr @v32, i32 8 monotonic, align 4
  %and = and i32 %0, 8
  %tobool = icmp ne i32 %and, 0
  br i1 undef, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  unreachable

if.end:                                           ; preds = %entry
  %or.cond8 = select i1 %tobool, i1 undef, i1 false
  ret void
}

define i32 @split_hoist_and(i32 %0) nounwind {
; X86-LABEL: split_hoist_and:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    lock btsl $3, v32
; X86-NEXT:    setb %al
; X86-NEXT:    shll $3, %eax
; X86-NEXT:    testl %ecx, %ecx
; X86-NEXT:    retl
;
; X64-LABEL: split_hoist_and:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    lock btsl $3, v32(%rip)
; X64-NEXT:    setb %al
; X64-NEXT:    shll $3, %eax
; X64-NEXT:    retq
  %2 = atomicrmw or ptr @v32, i32 8 monotonic, align 4
  %3 = tail call i32 @llvm.ctlz.i32(i32 %0, i1 false)
  %4 = and i32 %2, 8
  ret i32 %4
}

declare i32 @llvm.ctlz.i32(i32, i1)

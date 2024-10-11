; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefixes=X64,NOBMI
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi | FileCheck %s --check-prefixes=X64,BMI

; InstCombine and DAGCombiner transform an 'add' into an 'or'
; if there are no common bits from the incoming operands.
; LEA instruction selection should be able to see through that
; transform and reduce add/shift/or instruction counts.

define i32 @or_shift1_and1(i32 %x, i32 %y) {
; X86-LABEL: or_shift1_and1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    leal (%ecx,%eax,2), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift1_and1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $1, %esi
; X64-NEXT:    leal (%rsi,%rdi,2), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 1
  %and = and i32 %y, 1
  %or = or i32 %and, %shl
  ret i32 %or
}

define i32 @or_shift1_and1_swapped(i32 %x, i32 %y) {
; X86-LABEL: or_shift1_and1_swapped:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    leal (%ecx,%eax,2), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift1_and1_swapped:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $1, %esi
; X64-NEXT:    leal (%rsi,%rdi,2), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 1
  %and = and i32 %y, 1
  %or = or i32 %shl, %and
  ret i32 %or
}

define i32 @or_shift2_and1(i32 %x, i32 %y) {
; X86-LABEL: or_shift2_and1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    leal (%ecx,%eax,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift2_and1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $1, %esi
; X64-NEXT:    leal (%rsi,%rdi,4), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 2
  %and = and i32 %y, 1
  %or = or i32 %shl, %and
  ret i32 %or
}

define i32 @or_shift3_and1(i32 %x, i32 %y) {
; X86-LABEL: or_shift3_and1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $1, %ecx
; X86-NEXT:    leal (%ecx,%eax,8), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift3_and1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $1, %esi
; X64-NEXT:    leal (%rsi,%rdi,8), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 3
  %and = and i32 %y, 1
  %or = or i32 %shl, %and
  ret i32 %or
}

define i32 @or_shift3_and7(i32 %x, i32 %y) {
; X86-LABEL: or_shift3_and7:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $7, %ecx
; X86-NEXT:    leal (%ecx,%eax,8), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift3_and7:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $7, %esi
; X64-NEXT:    leal (%rsi,%rdi,8), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 3
  %and = and i32 %y, 7
  %or = or i32 %shl, %and
  ret i32 %or
}

; The shift is too big for an LEA.

define i32 @or_shift4_and1(i32 %x, i32 %y) {
; X86-LABEL: or_shift4_and1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll $4, %ecx
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift4_and1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    shll $4, %edi
; X64-NEXT:    andl $1, %esi
; X64-NEXT:    leal (%rsi,%rdi), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 4
  %and = and i32 %y, 1
  %or = or i32 %shl, %and
  ret i32 %or
}

; The mask is too big for the shift, so the 'or' isn't equivalent to an 'add'.

define i32 @or_shift3_and8(i32 %x, i32 %y) {
; X86-LABEL: or_shift3_and8:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll $3, %ecx
; X86-NEXT:    andl $8, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift3_and8:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (,%rdi,8), %eax
; X64-NEXT:    andl $8, %esi
; X64-NEXT:    orl %esi, %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 3
  %and = and i32 %y, 8
  %or = or i32 %shl, %and
  ret i32 %or
}

; 64-bit operands should work too.

define i64 @or_shift1_and1_64(i64 %x, i64 %y) {
; X86-LABEL: or_shift1_and1_64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    shldl $1, %ecx, %edx
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    leal (%eax,%ecx,2), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift1_and1_64:
; X64:       # %bb.0:
; X64-NEXT:    andl $1, %esi
; X64-NEXT:    leaq (%rsi,%rdi,2), %rax
; X64-NEXT:    retq
  %shl = shl i64 %x, 1
  %and = and i64 %y, 1
  %or = or i64 %and, %shl
  ret i64 %or
}

; In the following patterns, lhs and rhs of the or instruction have no common bits.

define i32 @or_and_and_rhs_neg_i32(i32 %x, i32 %y, i32 %z) {
; X86-LABEL: or_and_and_rhs_neg_i32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    incl %eax
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_and_rhs_neg_i32:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    # kill: def $edx killed $edx def $rdx
; NOBMI-NEXT:    xorl %edi, %edx
; NOBMI-NEXT:    andl %esi, %edx
; NOBMI-NEXT:    xorl %edi, %edx
; NOBMI-NEXT:    leal 1(%rdx), %eax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_and_rhs_neg_i32:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    # kill: def $edx killed $edx def $rdx
; BMI-NEXT:    andl %esi, %edx
; BMI-NEXT:    andnl %edi, %esi, %eax
; BMI-NEXT:    leal 1(%rdx,%rax), %eax
; BMI-NEXT:    retq
entry:
  %and1 = and i32 %z, %y
  %xor = xor i32 %y, -1
  %and2 = and i32 %x, %xor
  %or = or i32 %and1, %and2
  %inc = add i32 %or, 1
  ret i32 %inc
}

define i32 @or_and_and_lhs_neg_i32(i32 %x, i32 %y, i32 %z) {
; X86-LABEL: or_and_and_lhs_neg_i32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    incl %eax
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_and_lhs_neg_i32:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    # kill: def $edx killed $edx def $rdx
; NOBMI-NEXT:    xorl %edi, %edx
; NOBMI-NEXT:    andl %esi, %edx
; NOBMI-NEXT:    xorl %edi, %edx
; NOBMI-NEXT:    leal 1(%rdx), %eax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_and_lhs_neg_i32:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    # kill: def $edx killed $edx def $rdx
; BMI-NEXT:    andl %esi, %edx
; BMI-NEXT:    andnl %edi, %esi, %eax
; BMI-NEXT:    leal 1(%rdx,%rax), %eax
; BMI-NEXT:    retq
entry:
  %and1 = and i32 %z, %y
  %xor = xor i32 %y, -1
  %and2 = and i32 %xor, %x
  %or = or i32 %and1, %and2
  %inc = add i32 %or, 1
  ret i32 %inc
}

define i32 @or_and_rhs_neg_and_i32(i32 %x, i32 %y, i32 %z) {
; X86-LABEL: or_and_rhs_neg_and_i32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    incl %eax
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_rhs_neg_and_i32:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    # kill: def $edi killed $edi def $rdi
; NOBMI-NEXT:    xorl %edx, %edi
; NOBMI-NEXT:    andl %esi, %edi
; NOBMI-NEXT:    xorl %edx, %edi
; NOBMI-NEXT:    leal 1(%rdi), %eax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_rhs_neg_and_i32:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    # kill: def $edi killed $edi def $rdi
; BMI-NEXT:    andnl %edx, %esi, %eax
; BMI-NEXT:    andl %esi, %edi
; BMI-NEXT:    leal 1(%rax,%rdi), %eax
; BMI-NEXT:    retq
entry:
  %xor = xor i32 %y, -1
  %and1 = and i32 %z, %xor
  %and2 = and i32 %x, %y
  %or = or i32 %and1, %and2
  %inc = add i32 %or, 1
  ret i32 %inc
}

define i32 @or_and_lhs_neg_and_i32(i32 %x, i32 %y, i32 %z) {
; X86-LABEL: or_and_lhs_neg_and_i32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    incl %eax
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_lhs_neg_and_i32:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    # kill: def $edi killed $edi def $rdi
; NOBMI-NEXT:    xorl %edx, %edi
; NOBMI-NEXT:    andl %esi, %edi
; NOBMI-NEXT:    xorl %edx, %edi
; NOBMI-NEXT:    leal 1(%rdi), %eax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_lhs_neg_and_i32:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    # kill: def $edi killed $edi def $rdi
; BMI-NEXT:    andnl %edx, %esi, %eax
; BMI-NEXT:    andl %esi, %edi
; BMI-NEXT:    leal 1(%rax,%rdi), %eax
; BMI-NEXT:    retq
entry:
  %xor = xor i32 %y, -1
  %and1 = and i32 %xor, %z
  %and2 = and i32 %x, %y
  %or = or i32 %and1, %and2
  %inc = add i32 %or, 1
  ret i32 %inc
}

define i64 @or_and_and_rhs_neg_i64(i64 %x, i64 %y, i64 %z) {
; X86-LABEL: or_and_and_rhs_neg_i64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    andl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    addl $1, %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_and_rhs_neg_i64:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    xorq %rdi, %rdx
; NOBMI-NEXT:    andq %rsi, %rdx
; NOBMI-NEXT:    xorq %rdi, %rdx
; NOBMI-NEXT:    leaq 1(%rdx), %rax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_and_rhs_neg_i64:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    andq %rsi, %rdx
; BMI-NEXT:    andnq %rdi, %rsi, %rax
; BMI-NEXT:    leaq 1(%rdx,%rax), %rax
; BMI-NEXT:    retq
entry:
  %and1 = and i64 %z, %y
  %xor = xor i64 %y, -1
  %and2 = and i64 %x, %xor
  %or = or i64 %and1, %and2
  %inc = add i64 %or, 1
  ret i64 %inc
}

define i64 @or_and_and_lhs_neg_i64(i64 %x, i64 %y, i64 %z) {
; X86-LABEL: or_and_and_lhs_neg_i64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    andl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    addl $1, %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_and_lhs_neg_i64:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    xorq %rdi, %rdx
; NOBMI-NEXT:    andq %rsi, %rdx
; NOBMI-NEXT:    xorq %rdi, %rdx
; NOBMI-NEXT:    leaq 1(%rdx), %rax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_and_lhs_neg_i64:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    andq %rsi, %rdx
; BMI-NEXT:    andnq %rdi, %rsi, %rax
; BMI-NEXT:    leaq 1(%rdx,%rax), %rax
; BMI-NEXT:    retq
entry:
  %and1 = and i64 %z, %y
  %xor = xor i64 %y, -1
  %and2 = and i64 %xor, %x
  %or = or i64 %and1, %and2
  %inc = add i64 %or, 1
  ret i64 %inc
}

define i64 @or_and_rhs_neg_and_i64(i64 %x, i64 %y, i64 %z) {
; X86-LABEL: or_and_rhs_neg_and_i64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    andl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    addl $1, %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_rhs_neg_and_i64:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    xorq %rdx, %rdi
; NOBMI-NEXT:    andq %rsi, %rdi
; NOBMI-NEXT:    xorq %rdx, %rdi
; NOBMI-NEXT:    leaq 1(%rdi), %rax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_rhs_neg_and_i64:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    andnq %rdx, %rsi, %rax
; BMI-NEXT:    andq %rsi, %rdi
; BMI-NEXT:    leaq 1(%rax,%rdi), %rax
; BMI-NEXT:    retq
entry:
  %xor = xor i64 %y, -1
  %and1 = and i64 %z, %xor
  %and2 = and i64 %x, %y
  %or = or i64 %and1, %and2
  %inc = add i64 %or, 1
  ret i64 %inc
}

define i64 @or_and_lhs_neg_and_i64(i64 %x, i64 %y, i64 %z) {
; X86-LABEL: or_and_lhs_neg_and_i64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    andl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %eax
; X86-NEXT:    addl $1, %eax
; X86-NEXT:    adcl $0, %edx
; X86-NEXT:    retl
;
; NOBMI-LABEL: or_and_lhs_neg_and_i64:
; NOBMI:       # %bb.0: # %entry
; NOBMI-NEXT:    xorq %rdx, %rdi
; NOBMI-NEXT:    andq %rsi, %rdi
; NOBMI-NEXT:    xorq %rdx, %rdi
; NOBMI-NEXT:    leaq 1(%rdi), %rax
; NOBMI-NEXT:    retq
;
; BMI-LABEL: or_and_lhs_neg_and_i64:
; BMI:       # %bb.0: # %entry
; BMI-NEXT:    andnq %rdx, %rsi, %rax
; BMI-NEXT:    andq %rsi, %rdi
; BMI-NEXT:    leaq 1(%rax,%rdi), %rax
; BMI-NEXT:    retq
entry:
  %xor = xor i64 %y, -1
  %and1 = and i64 %xor, %z
  %and2 = and i64 %x, %y
  %or = or i64 %and1, %and2
  %inc = add i64 %or, 1
  ret i64 %inc
}

define i32 @or_sext1(i32 %x) {
; X86-LABEL: or_sext1:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(%eax,%eax), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext1:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(%rax,%rax), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sext = sext i1 %cmp to i32
  %or = or i32 %sext, 1
  ret i32 %or
}

define i64 @or_sext1_64(i64 %x) {
; X86-LABEL: or_sext1_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    movl $42, %ecx
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl $1, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext1_64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $43, %rdi
; X64-NEXT:    setl %al
; X64-NEXT:    leaq -1(%rax,%rax), %rax
; X64-NEXT:    retq
  %cmp = icmp sgt i64 %x, 42
  %sext = sext i1 %cmp to i64
  %or = or i64 %sext, 1
  ret i64 %or
}

define i32 @or_sext2(i32 %x) {
; X86-LABEL: or_sext2:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(%eax,%eax,2), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext2:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(%rax,%rax,2), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sext = sext i1 %cmp to i32
  %or = or i32 %sext, 2
  ret i32 %or
}

define i64 @or_sext2_64(i64 %x) {
; X86-LABEL: or_sext2_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    movl $42, %ecx
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext2_64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $43, %rdi
; X64-NEXT:    setl %al
; X64-NEXT:    leaq -1(%rax,%rax,2), %rax
; X64-NEXT:    retq
  %cmp = icmp sgt i64 %x, 42
  %sext = sext i1 %cmp to i64
  %or = or i64 %sext, 2
  ret i64 %or
}

define i32 @or_sext3(i32 %x) {
; X86-LABEL: or_sext3:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(,%eax,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext3:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(,%rax,4), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sext = sext i1 %cmp to i32
  %or = or i32 %sext, 3
  ret i32 %or
}

define i64 @or_sext3_64(i64 %x) {
; X86-LABEL: or_sext3_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    movl $42, %ecx
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl $3, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext3_64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $43, %rdi
; X64-NEXT:    setl %al
; X64-NEXT:    leaq -1(,%rax,4), %rax
; X64-NEXT:    retq
  %cmp = icmp sgt i64 %x, 42
  %sext = sext i1 %cmp to i64
  %or = or i64 %sext, 3
  ret i64 %or
}

define i32 @or_sext4(i32 %x) {
; X86-LABEL: or_sext4:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(%eax,%eax,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext4:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(%rax,%rax,4), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sext = sext i1 %cmp to i32
  %or = or i32 %sext, 4
  ret i32 %or
}

define i64 @or_sext4_64(i64 %x) {
; X86-LABEL: or_sext4_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    movl $42, %ecx
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl $4, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext4_64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $43, %rdi
; X64-NEXT:    setl %al
; X64-NEXT:    leaq -1(%rax,%rax,4), %rax
; X64-NEXT:    retq
  %cmp = icmp sgt i64 %x, 42
  %sext = sext i1 %cmp to i64
  %or = or i64 %sext, 4
  ret i64 %or
}

define i32 @or_sext7(i32 %x) {
; X86-LABEL: or_sext7:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(,%eax,8), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext7:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(,%rax,8), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sext = sext i1 %cmp to i32
  %or = or i32 %sext, 7
  ret i32 %or
}

define i64 @or_sext7_64(i64 %x) {
; X86-LABEL: or_sext7_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    movl $42, %ecx
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl $7, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext7_64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $43, %rdi
; X64-NEXT:    setl %al
; X64-NEXT:    leaq -1(,%rax,8), %rax
; X64-NEXT:    retq
  %cmp = icmp sgt i64 %x, 42
  %sext = sext i1 %cmp to i64
  %or = or i64 %sext, 7
  ret i64 %or
}

define i32 @or_sext8(i32 %x) {
; X86-LABEL: or_sext8:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $43, {{[0-9]+}}(%esp)
; X86-NEXT:    setl %al
; X86-NEXT:    leal -1(%eax,%eax,8), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext8:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $43, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    leal -1(%rax,%rax,8), %eax
; X64-NEXT:    retq
  %cmp = icmp sgt i32 %x, 42
  %sext = sext i1 %cmp to i32
  %or = or i32 %sext, 8
  ret i32 %or
}

define i64 @or_sext8_64(i64 %x) {
; X86-LABEL: or_sext8_64:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    movl $42, %ecx
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %edx
; X86-NEXT:    negl %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl $8, %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_sext8_64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq $43, %rdi
; X64-NEXT:    setl %al
; X64-NEXT:    leaq -1(%rax,%rax,8), %rax
; X64-NEXT:    retq
  %cmp = icmp sgt i64 %x, 42
  %sext = sext i1 %cmp to i64
  %or = or i64 %sext, 8
  ret i64 %or
}

define i64 @or_large_constant(i64 %x) {
; X86-LABEL: or_large_constant:
; X86:       # %bb.0: # %entry
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    movl $1, %eax
; X86-NEXT:    cmpl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $0, %eax
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    setl %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    negl %eax
; X86-NEXT:    sbbl %edx, %edx
; X86-NEXT:    orl $1, %eax
; X86-NEXT:    orl $128, %edx
; X86-NEXT:    retl
;
; X64-LABEL: or_large_constant:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    cmpq $2, %rdi
; X64-NEXT:    setge %cl
; X64-NEXT:    negq %rcx
; X64-NEXT:    movabsq $549755813889, %rax # imm = 0x8000000001
; X64-NEXT:    orq %rcx, %rax
; X64-NEXT:    retq
entry:
  %cmp = icmp sgt i64 %x, 1
  %zext = zext i1 %cmp to i64
  %sub = sub i64 0, %zext
  %or = or i64 %sub, 549755813889   ; 0x8000000001
  ret i64 %or
}

define i32 @or_shift1_disjoint(i32 %x, i32 %y) {
; X86-LABEL: or_shift1_disjoint:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl %eax, %eax
; X86-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
;
; X64-LABEL: or_shift1_disjoint:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rsi,%rdi,2), %eax
; X64-NEXT:    retq
  %shl = shl i32 %x, 1
  %or = or disjoint i32 %y, %shl
  ret i32 %or
}


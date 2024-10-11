; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-linux-gnu | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-linux-gnu | FileCheck %s --check-prefixes=X64

; fold (shl (zext (lshr (A, X))), X) -> (zext (shl (lshr (A, X)), X))

; Canolicalize the sequence shl/zext/lshr performing the zeroextend
; as the last instruction of the sequence.
; This will help DAGCombiner to identify and then fold the sequence
; of shifts into a single AND.
; This transformation is profitable if the shift amounts are the same
; and if there is only one use of the zext.

define i16 @fun1(i8 zeroext %v) {
; X86-LABEL: fun1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: fun1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $-16, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
entry:
  %shr = lshr i8 %v, 4
  %ext = zext i8 %shr to i16
  %shl = shl i16 %ext, 4
  ret i16 %shl
}

define i32 @fun2(i8 zeroext %v) {
; X86-LABEL: fun2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    retl
;
; X64-LABEL: fun2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $-16, %eax
; X64-NEXT:    retq
entry:
  %shr = lshr i8 %v, 4
  %ext = zext i8 %shr to i32
  %shl = shl i32 %ext, 4
  ret i32 %shl
}

define i32 @fun3(i16 zeroext %v) {
; X86-LABEL: fun3:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    retl
;
; X64-LABEL: fun3:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $-16, %eax
; X64-NEXT:    retq
entry:
  %shr = lshr i16 %v, 4
  %ext = zext i16 %shr to i32
  %shl = shl i32 %ext, 4
  ret i32 %shl
}

define i64 @fun4(i8 zeroext %v) {
; X86-LABEL: fun4:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun4:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $-16, %eax
; X64-NEXT:    retq
entry:
  %shr = lshr i8 %v, 4
  %ext = zext i8 %shr to i64
  %shl = shl i64 %ext, 4
  ret i64 %shl
}

define i64 @fun5(i16 zeroext %v) {
; X86-LABEL: fun5:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun5:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $-16, %eax
; X64-NEXT:    retq
entry:
  %shr = lshr i16 %v, 4
  %ext = zext i16 %shr to i64
  %shl = shl i64 %ext, 4
  ret i64 %shl
}

define i64 @fun6(i32 zeroext %v) {
; X86-LABEL: fun6:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun6:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $-16, %eax
; X64-NEXT:    retq
entry:
  %shr = lshr i32 %v, 4
  %ext = zext i32 %shr to i64
  %shl = shl i64 %ext, 4
  ret i64 %shl
}

; Don't fold the pattern if we use arithmetic shifts.

define i64 @fun7(i8 zeroext %v) {
; X86-LABEL: fun7:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sarb $4, %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    shll $4, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun7:
; X64:       # %bb.0: # %entry
; X64-NEXT:    sarb $4, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    shll $4, %eax
; X64-NEXT:    retq
entry:
  %shr = ashr i8 %v, 4
  %ext = zext i8 %shr to i64
  %shl = shl i64 %ext, 4
  ret i64 %shl
}

define i64 @fun8(i16 zeroext %v) {
; X86-LABEL: fun8:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $1048560, %eax # imm = 0xFFFF0
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun8:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movswl %di, %eax
; X64-NEXT:    andl $1048560, %eax # imm = 0xFFFF0
; X64-NEXT:    retq
entry:
  %shr = ashr i16 %v, 4
  %ext = zext i16 %shr to i64
  %shl = shl i64 %ext, 4
  ret i64 %shl
}

define i64 @fun9(i32 zeroext %v) {
; X86-LABEL: fun9:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    sarl $4, %edx
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    shrl $28, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun9:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    sarl $4, %eax
; X64-NEXT:    shlq $4, %rax
; X64-NEXT:    retq
entry:
  %shr = ashr i32 %v, 4
  %ext = zext i32 %shr to i64
  %shl = shl i64 %ext, 4
  ret i64 %shl
}

; Don't fold the pattern if there is more than one use of the
; operand in input to the shift left.

define i64 @fun10(i8 zeroext %v) {
; X86-LABEL: fun10:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrb $4, %al
; X86-NEXT:    movzbl %al, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shll $4, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun10:
; X64:       # %bb.0: # %entry
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrb $4, %al
; X64-NEXT:    movzbl %al, %eax
; X64-NEXT:    andl $-16, %edi
; X64-NEXT:    orq %rdi, %rax
; X64-NEXT:    retq
entry:
  %shr = lshr i8 %v, 4
  %ext = zext i8 %shr to i64
  %shl = shl i64 %ext, 4
  %add = add i64 %shl, %ext
  ret i64 %add
}

define i64 @fun11(i16 zeroext %v) {
; X86-LABEL: fun11:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shrl $4, %ecx
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: fun11:
; X64:       # %bb.0: # %entry
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrl $4, %eax
; X64-NEXT:    andl $-16, %edi
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    retq
entry:
  %shr = lshr i16 %v, 4
  %ext = zext i16 %shr to i64
  %shl = shl i64 %ext, 4
  %add = add i64 %shl, %ext
  ret i64 %add
}

define i64 @fun12(i32 zeroext %v) {
; X86-LABEL: fun12:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shrl $4, %ecx
; X86-NEXT:    andl $-16, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    setb %dl
; X86-NEXT:    retl
;
; X64-LABEL: fun12:
; X64:       # %bb.0: # %entry
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrl $4, %eax
; X64-NEXT:    andl $-16, %edi
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    retq
entry:
  %shr = lshr i32 %v, 4
  %ext = zext i32 %shr to i64
  %shl = shl i64 %ext, 4
  %add = add i64 %shl, %ext
  ret i64 %add
}

; PR17380
; Make sure that the combined dags are legal if we run the DAGCombiner after
; Legalization took place. The add instruction is redundant and increases by
; one the number of uses of the zext. This prevents the transformation from
; firing before dags are legalized and optimized.
; Once the add is removed, the number of uses becomes one and therefore the
; dags are canonicalized. After Legalization, we need to make sure that the
; valuetype for the shift count is legal.
; Verify also that we correctly fold the shl-shr sequence into an
; AND with bitmask.

define void @g(i32 %a) nounwind {
; X86-LABEL: g:
; X86:       # %bb.0:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $-4, %eax
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    pushl $0
; X86-NEXT:    pushl %eax
; X86-NEXT:    calll f
; X86-NEXT:    addl $28, %esp
; X86-NEXT:    retl
;
; X64-LABEL: g:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    andl $-4, %edi
; X64-NEXT:    jmp f # TAILCALL
  %b = lshr i32 %a, 2
  %c = zext i32 %b to i64
  %d = add i64 %c, 1
  %e = shl i64 %c, 2
  tail call void @f(i64 %e)
  ret void
}

define i32 @shift_zext_shl(i8 zeroext %x) {
; X86-LABEL: shift_zext_shl:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $64, %eax
; X86-NEXT:    shll $9, %eax
; X86-NEXT:    retl
;
; X64-LABEL: shift_zext_shl:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $64, %eax
; X64-NEXT:    shll $9, %eax
; X64-NEXT:    retq
  %a = and i8 %x, 64
  %b = zext i8 %a to i16
  %c = shl i16 %b, 9
  %d = zext i16 %c to i32
  ret i32 %d
}

define i32 @shift_zext_shl2(i8 zeroext %x) {
; X86-LABEL: shift_zext_shl2:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $64, %eax
; X86-NEXT:    shll $9, %eax
; X86-NEXT:    retl
;
; X64-LABEL: shift_zext_shl2:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $64, %eax
; X64-NEXT:    shll $9, %eax
; X64-NEXT:    retq
  %a = and i8 %x, 64
  %b = zext i8 %a to i32
  %c = shl i32 %b, 9
  ret i32 %c
}

define <4 x i32> @shift_zext_shl_vec(<4 x i8> %x) nounwind {
; X86-LABEL: shift_zext_shl_vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl $64, %ecx
; X86-NEXT:    shll $9, %ecx
; X86-NEXT:    andl $63, %edx
; X86-NEXT:    shll $8, %edx
; X86-NEXT:    andl $31, %esi
; X86-NEXT:    shll $7, %esi
; X86-NEXT:    andl $23, %edi
; X86-NEXT:    shll $6, %edi
; X86-NEXT:    movl %edi, 12(%eax)
; X86-NEXT:    movl %esi, 8(%eax)
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl $4
;
; X64-LABEL: shift_zext_shl_vec:
; X64:       # %bb.0:
; X64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-NEXT:    pxor %xmm1, %xmm1
; X64-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; X64-NEXT:    pmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 # [512,256,128,64,u,u,u,u]
; X64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; X64-NEXT:    retq
  %a = and <4 x i8> %x, <i8 64, i8 63, i8 31, i8 23>
  %b = zext <4 x i8> %a to <4 x i16>
  %c = shl <4 x i16> %b, <i16 9, i16 8, i16 7, i16 6>
  %d = zext <4 x i16> %c to <4 x i32>
  ret <4 x i32> %d
}

define <4 x i32> @shift_zext_shl2_vec(<4 x i8> %x) nounwind {
; X86-LABEL: shift_zext_shl2_vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    andl $23, %edi
; X86-NEXT:    andl $31, %esi
; X86-NEXT:    andl $63, %edx
; X86-NEXT:    andl $64, %ecx
; X86-NEXT:    shll $9, %ecx
; X86-NEXT:    shll $8, %edx
; X86-NEXT:    shll $7, %esi
; X86-NEXT:    shll $6, %edi
; X86-NEXT:    movl %edi, 12(%eax)
; X86-NEXT:    movl %esi, 8(%eax)
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl $4
;
; X64-LABEL: shift_zext_shl2_vec:
; X64:       # %bb.0:
; X64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-NEXT:    pxor %xmm1, %xmm1
; X64-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; X64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; X64-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X64-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; X64-NEXT:    retq
  %a = and <4 x i8> %x, <i8 64, i8 63, i8 31, i8 23>
  %b = zext <4 x i8> %a to <4 x i32>
  %c = shl <4 x i32> %b, <i32 9, i32 8, i32 7, i32 6>
  ret <4 x i32> %c
}

declare dso_local void @f(i64)


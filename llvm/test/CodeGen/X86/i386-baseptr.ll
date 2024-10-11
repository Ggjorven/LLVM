; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i386-pc-linux -stackrealign -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=i386-pc-none-elf -stackrealign -verify-machineinstrs < %s | FileCheck %s

declare i32 @helper() nounwind
define void @base() #0 {
; CHECK-LABEL: base:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    .cfi_offset %ebp, -8
; CHECK-NEXT:    movl %esp, %ebp
; CHECK-NEXT:    .cfi_def_cfa_register %ebp
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    andl $-32, %esp
; CHECK-NEXT:    subl $32, %esp
; CHECK-NEXT:    movl %esp, %esi
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:    calll helper@PLT
; CHECK-NEXT:    movl %esp, %ecx
; CHECK-NEXT:    leal 31(,%eax,4), %eax
; CHECK-NEXT:    andl $-32, %eax
; CHECK-NEXT:    movl %ecx, %edx
; CHECK-NEXT:    subl %eax, %edx
; CHECK-NEXT:    movl %edx, %esp
; CHECK-NEXT:    negl %eax
; CHECK-NEXT:    movl $0, (%ecx,%eax)
; CHECK-NEXT:    leal -4(%ebp), %esp
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    popl %ebp
; CHECK-NEXT:    .cfi_def_cfa %esp, 4
; CHECK-NEXT:    retl
entry:
  %k = call i32 @helper()
  %a = alloca i32, i32 %k, align 4
  store i32 0, ptr %a, align 4
  ret void
}

define void @clobber_base() #0 {
; CHECK-LABEL: clobber_base:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    leal {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    .cfi_def_cfa %ecx, 0
; CHECK-NEXT:    andl $-128, %esp
; CHECK-NEXT:    pushl -4(%ecx)
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    movl %esp, %ebp
; CHECK-NEXT:    .cfi_escape 0x10, 0x05, 0x02, 0x75, 0x00 #
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    subl $244, %esp
; CHECK-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    .cfi_escape 0x10, 0x06, 0x02, 0x75, 0x7c #
; CHECK-NEXT:    .cfi_escape 0x0f, 0x04, 0x75, 0x84, 0x7f, 0x06 #
; CHECK-NEXT:    calll helper@PLT
; CHECK-NEXT:    movl %esp, %ecx
; CHECK-NEXT:    leal 31(,%eax,4), %eax
; CHECK-NEXT:    andl $-32, %eax
; CHECK-NEXT:    movl %ecx, %edx
; CHECK-NEXT:    subl %eax, %edx
; CHECK-NEXT:    movl %edx, %esp
; CHECK-NEXT:    negl %eax
; CHECK-NEXT:    movl $405, %esi # imm = 0x195
; CHECK-NEXT:    #APP
; CHECK-NEXT:    nop
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    movl $8, %edx
; CHECK-NEXT:    #APP
; CHECK-NEXT:    movl %edx, -120(%ebp)
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    movl $0, (%ecx,%eax)
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    leal -4(%ebp), %esp
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    popl %ebp
; CHECK-NEXT:    leal -4(%ecx), %esp
; CHECK-NEXT:    .cfi_def_cfa %esp, 4
; CHECK-NEXT:    retl
entry:
  %k = call i32 @helper()
  %a = alloca i32, align 128
  %b = alloca i32, i32 %k, align 4
  ; clobber base pointer register
  tail call void asm sideeffect "nop", "{si}"(i32 405)
  call void asm sideeffect "movl $0, $1", "r,*m"(i32 8, ptr elementtype(i32) %a)
  store i32 0, ptr %b, align 4
  ret void
}

define x86_regcallcc void @clobber_baseptr_argptr(i32 %param1, i32 %param2, i32 %param3, i32 %param4, i32 %param5, i32 %param6) #0 {
; CHECK-LABEL: clobber_baseptr_argptr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    .cfi_offset %ebp, -8
; CHECK-NEXT:    movl %esp, %ebp
; CHECK-NEXT:    .cfi_def_cfa_register %ebp
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:    andl $-128, %esp
; CHECK-NEXT:    subl $128, %esp
; CHECK-NEXT:    movl %esp, %esi
; CHECK-NEXT:    .cfi_offset %ebx, -12
; CHECK-NEXT:    movl 8(%ebp), %edi
; CHECK-NEXT:    calll helper@PLT
; CHECK-NEXT:    movl %esp, %ecx
; CHECK-NEXT:    leal 31(,%eax,4), %eax
; CHECK-NEXT:    andl $-32, %eax
; CHECK-NEXT:    movl %ecx, %edx
; CHECK-NEXT:    subl %eax, %edx
; CHECK-NEXT:    movl %edx, %esp
; CHECK-NEXT:    negl %eax
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    subl $28, %esp
; CHECK-NEXT:    movl $405, %esi # imm = 0x195
; CHECK-NEXT:    #APP
; CHECK-NEXT:    nop
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    addl $28, %esp
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    movl $405, %ebx # imm = 0x195
; CHECK-NEXT:    #APP
; CHECK-NEXT:    nop
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    movl $8, %edx
; CHECK-NEXT:    #APP
; CHECK-NEXT:    movl %edx, (%esi)
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    movl %edi, (%ecx,%eax)
; CHECK-NEXT:    leal -4(%ebp), %esp
; CHECK-NEXT:    popl %ebx
; CHECK-NEXT:    popl %ebp
; CHECK-NEXT:    .cfi_def_cfa %esp, 4
; CHECK-NEXT:    retl
entry:
  %k = call i32 @helper()
  %a = alloca i32, align 128
  %b = alloca i32, i32 %k, align 4
  ; clobber base pointer register
  tail call void asm sideeffect "nop", "{si}"(i32 405)
  ; clobber argument pointer register
  tail call void asm sideeffect "nop", "{bx}"(i32 405)
  call void asm sideeffect "movl $0, $1", "r,*m"(i32 8, ptr elementtype(i32) %a)
  store i32 %param6, ptr %b, align 4
  ret void
}

attributes #0 = {"frame-pointer"="all"}
!llvm.module.flags = !{!0}
!0 = !{i32 2, !"override-stack-alignment", i32 32}

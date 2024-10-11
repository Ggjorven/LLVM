; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; Check that a division is bypassed when appropriate only.
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=atom       < %s | FileCheck -check-prefixes=CHECK,ATOM %s
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=x86-64     < %s | FileCheck -check-prefixes=CHECK,REST,X64 %s
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=silvermont < %s | FileCheck -check-prefixes=CHECK,REST,SLM %s
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake    < %s | FileCheck -check-prefixes=CHECK,REST,SKL %s
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=goldmont   < %s | FileCheck -check-prefixes=CHECK,REST,GMT %s
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mcpu=gracemont  < %s | FileCheck -check-prefixes=CHECK,REST,GMT %s
; RUN: llc -profile-summary-huge-working-set-size-threshold=1 -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake    < %s | FileCheck -check-prefixes=HUGEWS %s

; Verify that div32 is bypassed only for Atoms.
define i32 @div32(i32 %a, i32 %b) {
; ATOM-LABEL: div32:
; ATOM:       # %bb.0: # %entry
; ATOM-NEXT:    movl %edi, %eax
; ATOM-NEXT:    orl %esi, %eax
; ATOM-NEXT:    testl $-256, %eax
; ATOM-NEXT:    je .LBB0_1
; ATOM-NEXT:  # %bb.2:
; ATOM-NEXT:    movl %edi, %eax
; ATOM-NEXT:    cltd
; ATOM-NEXT:    idivl %esi
; ATOM-NEXT:    retq
; ATOM-NEXT:  .LBB0_1:
; ATOM-NEXT:    movzbl %dil, %eax
; ATOM-NEXT:    divb %sil
; ATOM-NEXT:    movzbl %al, %eax
; ATOM-NEXT:    retq
;
; REST-LABEL: div32:
; REST:       # %bb.0: # %entry
; REST-NEXT:    movl %edi, %eax
; REST-NEXT:    cltd
; REST-NEXT:    idivl %esi
; REST-NEXT:    retq
;
; HUGEWS-LABEL: div32:
; HUGEWS:       # %bb.0: # %entry
; HUGEWS-NEXT:    movl %edi, %eax
; HUGEWS-NEXT:    cltd
; HUGEWS-NEXT:    idivl %esi
; HUGEWS-NEXT:    retq
entry:
  %div = sdiv i32 %a, %b
  ret i32 %div
}

; Verify that div64 is always bypassed.
define i64 @div64(i64 %a, i64 %b) {
; ATOM-LABEL: div64:
; ATOM:       # %bb.0: # %entry
; ATOM-NEXT:    movq %rdi, %rcx
; ATOM-NEXT:    movq %rdi, %rax
; ATOM-NEXT:    orq %rsi, %rcx
; ATOM-NEXT:    shrq $32, %rcx
; ATOM-NEXT:    je .LBB1_1
; ATOM-NEXT:  # %bb.2:
; ATOM-NEXT:    cqto
; ATOM-NEXT:    idivq %rsi
; ATOM-NEXT:    retq
; ATOM-NEXT:  .LBB1_1:
; ATOM-NEXT:    # kill: def $eax killed $eax killed $rax
; ATOM-NEXT:    xorl %edx, %edx
; ATOM-NEXT:    divl %esi
; ATOM-NEXT:    # kill: def $eax killed $eax def $rax
; ATOM-NEXT:    retq
;
; X64-LABEL: div64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    orq %rsi, %rcx
; X64-NEXT:    shrq $32, %rcx
; X64-NEXT:    je .LBB1_1
; X64-NEXT:  # %bb.2:
; X64-NEXT:    cqto
; X64-NEXT:    idivq %rsi
; X64-NEXT:    retq
; X64-NEXT:  .LBB1_1:
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    divl %esi
; X64-NEXT:    # kill: def $eax killed $eax def $rax
; X64-NEXT:    retq
;
; SLM-LABEL: div64:
; SLM:       # %bb.0: # %entry
; SLM-NEXT:    movq %rdi, %rcx
; SLM-NEXT:    movq %rdi, %rax
; SLM-NEXT:    orq %rsi, %rcx
; SLM-NEXT:    shrq $32, %rcx
; SLM-NEXT:    je .LBB1_1
; SLM-NEXT:  # %bb.2:
; SLM-NEXT:    cqto
; SLM-NEXT:    idivq %rsi
; SLM-NEXT:    retq
; SLM-NEXT:  .LBB1_1:
; SLM-NEXT:    xorl %edx, %edx
; SLM-NEXT:    # kill: def $eax killed $eax killed $rax
; SLM-NEXT:    divl %esi
; SLM-NEXT:    # kill: def $eax killed $eax def $rax
; SLM-NEXT:    retq
;
; SKL-LABEL: div64:
; SKL:       # %bb.0: # %entry
; SKL-NEXT:    movq %rdi, %rax
; SKL-NEXT:    movq %rdi, %rcx
; SKL-NEXT:    orq %rsi, %rcx
; SKL-NEXT:    shrq $32, %rcx
; SKL-NEXT:    je .LBB1_1
; SKL-NEXT:  # %bb.2:
; SKL-NEXT:    cqto
; SKL-NEXT:    idivq %rsi
; SKL-NEXT:    retq
; SKL-NEXT:  .LBB1_1:
; SKL-NEXT:    # kill: def $eax killed $eax killed $rax
; SKL-NEXT:    xorl %edx, %edx
; SKL-NEXT:    divl %esi
; SKL-NEXT:    # kill: def $eax killed $eax def $rax
; SKL-NEXT:    retq
;
; GMT-LABEL: div64:
; GMT:       # %bb.0: # %entry
; GMT-NEXT:    movq %rdi, %rax
; GMT-NEXT:    cqto
; GMT-NEXT:    idivq %rsi
; GMT-NEXT:    retq
;
; HUGEWS-LABEL: div64:
; HUGEWS:       # %bb.0: # %entry
; HUGEWS-NEXT:    movq %rdi, %rax
; HUGEWS-NEXT:    cqto
; HUGEWS-NEXT:    idivq %rsi
; HUGEWS-NEXT:    retq
entry:
  %div = sdiv i64 %a, %b
  ret i64 %div
}


; Verify that no extra code is generated when optimizing for size.

define i64 @div64_optsize(i64 %a, i64 %b) optsize {
; CHECK-LABEL: div64_optsize:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    cqto
; CHECK-NEXT:    idivq %rsi
; CHECK-NEXT:    retq
;
; HUGEWS-LABEL: div64_optsize:
; HUGEWS:       # %bb.0:
; HUGEWS-NEXT:    movq %rdi, %rax
; HUGEWS-NEXT:    cqto
; HUGEWS-NEXT:    idivq %rsi
; HUGEWS-NEXT:    retq
  %div = sdiv i64 %a, %b
  ret i64 %div
}

define i64 @div64_pgso(i64 %a, i64 %b) !prof !15 {
; CHECK-LABEL: div64_pgso:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    cqto
; CHECK-NEXT:    idivq %rsi
; CHECK-NEXT:    retq
;
; HUGEWS-LABEL: div64_pgso:
; HUGEWS:       # %bb.0:
; HUGEWS-NEXT:    movq %rdi, %rax
; HUGEWS-NEXT:    cqto
; HUGEWS-NEXT:    idivq %rsi
; HUGEWS-NEXT:    retq
  %div = sdiv i64 %a, %b
  ret i64 %div
}

define i64 @div64_hugews(i64 %a, i64 %b) {
; ATOM-LABEL: div64_hugews:
; ATOM:       # %bb.0:
; ATOM-NEXT:    movq %rdi, %rcx
; ATOM-NEXT:    movq %rdi, %rax
; ATOM-NEXT:    orq %rsi, %rcx
; ATOM-NEXT:    shrq $32, %rcx
; ATOM-NEXT:    je .LBB4_1
; ATOM-NEXT:  # %bb.2:
; ATOM-NEXT:    cqto
; ATOM-NEXT:    idivq %rsi
; ATOM-NEXT:    retq
; ATOM-NEXT:  .LBB4_1:
; ATOM-NEXT:    # kill: def $eax killed $eax killed $rax
; ATOM-NEXT:    xorl %edx, %edx
; ATOM-NEXT:    divl %esi
; ATOM-NEXT:    # kill: def $eax killed $eax def $rax
; ATOM-NEXT:    retq
;
; X64-LABEL: div64_hugews:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    orq %rsi, %rcx
; X64-NEXT:    shrq $32, %rcx
; X64-NEXT:    je .LBB4_1
; X64-NEXT:  # %bb.2:
; X64-NEXT:    cqto
; X64-NEXT:    idivq %rsi
; X64-NEXT:    retq
; X64-NEXT:  .LBB4_1:
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    divl %esi
; X64-NEXT:    # kill: def $eax killed $eax def $rax
; X64-NEXT:    retq
;
; SLM-LABEL: div64_hugews:
; SLM:       # %bb.0:
; SLM-NEXT:    movq %rdi, %rcx
; SLM-NEXT:    movq %rdi, %rax
; SLM-NEXT:    orq %rsi, %rcx
; SLM-NEXT:    shrq $32, %rcx
; SLM-NEXT:    je .LBB4_1
; SLM-NEXT:  # %bb.2:
; SLM-NEXT:    cqto
; SLM-NEXT:    idivq %rsi
; SLM-NEXT:    retq
; SLM-NEXT:  .LBB4_1:
; SLM-NEXT:    xorl %edx, %edx
; SLM-NEXT:    # kill: def $eax killed $eax killed $rax
; SLM-NEXT:    divl %esi
; SLM-NEXT:    # kill: def $eax killed $eax def $rax
; SLM-NEXT:    retq
;
; SKL-LABEL: div64_hugews:
; SKL:       # %bb.0:
; SKL-NEXT:    movq %rdi, %rax
; SKL-NEXT:    movq %rdi, %rcx
; SKL-NEXT:    orq %rsi, %rcx
; SKL-NEXT:    shrq $32, %rcx
; SKL-NEXT:    je .LBB4_1
; SKL-NEXT:  # %bb.2:
; SKL-NEXT:    cqto
; SKL-NEXT:    idivq %rsi
; SKL-NEXT:    retq
; SKL-NEXT:  .LBB4_1:
; SKL-NEXT:    # kill: def $eax killed $eax killed $rax
; SKL-NEXT:    xorl %edx, %edx
; SKL-NEXT:    divl %esi
; SKL-NEXT:    # kill: def $eax killed $eax def $rax
; SKL-NEXT:    retq
;
; GMT-LABEL: div64_hugews:
; GMT:       # %bb.0:
; GMT-NEXT:    movq %rdi, %rax
; GMT-NEXT:    cqto
; GMT-NEXT:    idivq %rsi
; GMT-NEXT:    retq
;
; HUGEWS-LABEL: div64_hugews:
; HUGEWS:       # %bb.0:
; HUGEWS-NEXT:    movq %rdi, %rax
; HUGEWS-NEXT:    cqto
; HUGEWS-NEXT:    idivq %rsi
; HUGEWS-NEXT:    retq
  %div = sdiv i64 %a, %b
  ret i64 %div
}

define i32 @div32_optsize(i32 %a, i32 %b) optsize {
; CHECK-LABEL: div32_optsize:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %esi
; CHECK-NEXT:    retq
;
; HUGEWS-LABEL: div32_optsize:
; HUGEWS:       # %bb.0:
; HUGEWS-NEXT:    movl %edi, %eax
; HUGEWS-NEXT:    cltd
; HUGEWS-NEXT:    idivl %esi
; HUGEWS-NEXT:    retq
  %div = sdiv i32 %a, %b
  ret i32 %div
}

define i32 @div32_pgso(i32 %a, i32 %b) !prof !15 {
; CHECK-LABEL: div32_pgso:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %esi
; CHECK-NEXT:    retq
;
; HUGEWS-LABEL: div32_pgso:
; HUGEWS:       # %bb.0:
; HUGEWS-NEXT:    movl %edi, %eax
; HUGEWS-NEXT:    cltd
; HUGEWS-NEXT:    idivl %esi
; HUGEWS-NEXT:    retq
  %div = sdiv i32 %a, %b
  ret i32 %div
}

define i32 @div32_minsize(i32 %a, i32 %b) minsize {
; CHECK-LABEL: div32_minsize:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %esi
; CHECK-NEXT:    retq
;
; HUGEWS-LABEL: div32_minsize:
; HUGEWS:       # %bb.0:
; HUGEWS-NEXT:    movl %edi, %eax
; HUGEWS-NEXT:    cltd
; HUGEWS-NEXT:    idivl %esi
; HUGEWS-NEXT:    retq
  %div = sdiv i32 %a, %b
  ret i32 %div
}

!llvm.module.flags = !{!1}
!1 = !{i32 1, !"ProfileSummary", !2}
!2 = !{!3, !4, !5, !6, !7, !8, !9, !10}
!3 = !{!"ProfileFormat", !"InstrProf"}
!4 = !{!"TotalCount", i64 10000}
!5 = !{!"MaxCount", i64 1000}
!6 = !{!"MaxInternalCount", i64 1}
!7 = !{!"MaxFunctionCount", i64 1000}
!8 = !{!"NumCounts", i64 3}
!9 = !{!"NumFunctions", i64 3}
!10 = !{!"DetailedSummary", !11}
!11 = !{!12, !13, !14}
!12 = !{i32 10000, i64 1000, i32 1}
!13 = !{i32 999000, i64 1000, i32 3}
!14 = !{i32 999999, i64 5, i32 3}
!15 = !{!"function_entry_count", i64 0}

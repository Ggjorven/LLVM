; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ndd -verify-machineinstrs | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ndd,nf -verify-machineinstrs | FileCheck --check-prefix=NF %s

define i16 @mul16rr(i16 noundef %a, i16 noundef %b) {
; CHECK-LABEL: mul16rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull %esi, %edi, %eax
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq
;
; NF-LABEL: mul16rr:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imull %esi, %edi, %eax
; NF-NEXT:    # kill: def $ax killed $ax killed $eax
; NF-NEXT:    retq
entry:
  %mul = mul i16 %a, %b
  ret i16 %mul
}

define i32 @mul32rr(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: mul32rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull %esi, %edi, %eax
; CHECK-NEXT:    retq
;
; NF-LABEL: mul32rr:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imull %esi, %edi, %eax
; NF-NEXT:    retq
entry:
  %mul = mul i32 %a, %b
  ret i32 %mul
}

define i64 @mul64rr(i64 noundef %a, i64 noundef %b) {
; CHECK-LABEL: mul64rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulq %rsi, %rdi, %rax
; CHECK-NEXT:    retq
;
; NF-LABEL: mul64rr:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulq %rsi, %rdi, %rax
; NF-NEXT:    retq
entry:
  %mul = mul i64 %a, %b
  ret i64 %mul
}

define i16 @smul16rr(i16 noundef %a, i16 noundef %b) {
; CHECK-LABEL: smul16rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulw %si, %di, %ax
; CHECK-NEXT:    retq
;
; NF-LABEL: smul16rr:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulw %si, %di, %ax
; NF-NEXT:    retq
entry:
  %t = call {i16, i1} @llvm.smul.with.overflow.i16(i16 %a, i16 %b)
  %mul = extractvalue {i16, i1} %t, 0
  ret i16 %mul
}

define i32 @smul32rr(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: smul32rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull %esi, %edi, %eax
; CHECK-NEXT:    retq
;
; NF-LABEL: smul32rr:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imull %esi, %edi, %eax
; NF-NEXT:    retq
entry:
  %t = call {i32, i1} @llvm.smul.with.overflow.i32(i32 %a, i32 %b)
  %mul = extractvalue {i32, i1} %t, 0
  ret i32 %mul
}

define i64 @smul64rr(i64 noundef %a, i64 noundef %b) {
; CHECK-LABEL: smul64rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulq %rsi, %rdi, %rax
; CHECK-NEXT:    retq
;
; NF-LABEL: smul64rr:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulq %rsi, %rdi, %rax
; NF-NEXT:    retq
entry:
  %t = call {i64, i1} @llvm.smul.with.overflow.i64(i64 %a, i64 %b)
  %mul = extractvalue {i64, i1} %t, 0
  ret i64 %mul
}

define i16 @mul16rm(i16 noundef %a, ptr %ptr) {
; CHECK-LABEL: mul16rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulw (%rsi), %di, %ax
; CHECK-NEXT:    retq
;
; NF-LABEL: mul16rm:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulw (%rsi), %di, %ax
; NF-NEXT:    retq
entry:
  %b = load i16, ptr %ptr
  %mul = mul i16 %a, %b
  ret i16 %mul
}

define i32 @mul32rm(i32 noundef %a, ptr %ptr) {
; CHECK-LABEL: mul32rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull (%rsi), %edi, %eax
; CHECK-NEXT:    retq
;
; NF-LABEL: mul32rm:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imull (%rsi), %edi, %eax
; NF-NEXT:    retq
entry:
  %b = load i32, ptr %ptr
  %mul = mul i32 %a, %b
  ret i32 %mul
}

define i64 @mul64rm(i64 noundef %a, ptr %ptr) {
; CHECK-LABEL: mul64rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulq (%rsi), %rdi, %rax
; CHECK-NEXT:    retq
;
; NF-LABEL: mul64rm:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulq (%rsi), %rdi, %rax
; NF-NEXT:    retq
entry:
  %b = load i64, ptr %ptr
  %mul = mul i64 %a, %b
  ret i64 %mul
}

define i16 @smul16rm(i16 noundef %a, ptr %ptr) {
; CHECK-LABEL: smul16rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulw (%rsi), %di, %ax
; CHECK-NEXT:    retq
;
; NF-LABEL: smul16rm:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulw (%rsi), %di, %ax
; NF-NEXT:    retq
entry:
  %b = load i16, ptr %ptr
  %t = call {i16, i1} @llvm.smul.with.overflow.i16(i16 %a, i16 %b)
  %mul = extractvalue {i16, i1} %t, 0
  ret i16 %mul
}

define i32 @smul32rm(i32 noundef %a, ptr %ptr) {
; CHECK-LABEL: smul32rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull (%rsi), %edi, %eax
; CHECK-NEXT:    retq
;
; NF-LABEL: smul32rm:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imull (%rsi), %edi, %eax
; NF-NEXT:    retq
entry:
  %b = load i32, ptr %ptr
  %t = call {i32, i1} @llvm.smul.with.overflow.i32(i32 %a, i32 %b)
  %mul = extractvalue {i32, i1} %t, 0
  ret i32 %mul
}

define i64 @smul64rm(i64 noundef %a, ptr %ptr) {
; CHECK-LABEL: smul64rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imulq (%rsi), %rdi, %rax
; CHECK-NEXT:    retq
;
; NF-LABEL: smul64rm:
; NF:       # %bb.0: # %entry
; NF-NEXT:    {nf} imulq (%rsi), %rdi, %rax
; NF-NEXT:    retq
entry:
  %b = load i64, ptr %ptr
  %t = call {i64, i1} @llvm.smul.with.overflow.i64(i64 %a, i64 %b)
  %mul = extractvalue {i64, i1} %t, 0
  ret i64 %mul
}

declare { i16, i1 } @llvm.smul.with.overflow.i16(i16, i16) nounwind readnone
declare { i32, i1 } @llvm.smul.with.overflow.i32(i32, i32) nounwind readnone
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) nounwind readnone

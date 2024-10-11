; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=thumbv8.1m.main-arm-none-eabi < %s | FileCheck %s --check-prefix=BTI
; RUN: llc -mtriple=thumbv8.1m.main-arm-none-eabi -mattr=+no-bti-at-return-twice < %s | \
; RUN: FileCheck %s --check-prefix=NOBTI

; C source
; --------
; jmp_buf buf;
;
; extern void bar(int x);
;
; int foo(int x) {
;   if (setjmp(buf))
;     x = 0;
;   else
;     bar(x);
;   return x;
; }

@buf = global [20 x i64] zeroinitializer, align 8

define i32 @foo(i32 %x)  "branch-target-enforcement" {
; BTI-LABEL: foo:
; BTI:       @ %bb.0: @ %entry
; BTI-NEXT:    bti
; BTI-NEXT:    .save {r4, lr}
; BTI-NEXT:    push {r4, lr}
; BTI-NEXT:    mov r4, r0
; BTI-NEXT:    movw r0, :lower16:buf
; BTI-NEXT:    movt r0, :upper16:buf
; BTI-NEXT:    bl setjmp
; BTI-NEXT:    bti
; BTI-NEXT:    cmp r0, #0
; BTI-NEXT:    itt ne
; BTI-NEXT:    movne r0, #0
; BTI-NEXT:    popne {r4, pc}
; BTI-NEXT:  .LBB0_1: @ %if.else
; BTI-NEXT:    mov r0, r4
; BTI-NEXT:    bl bar
; BTI-NEXT:    mov r0, r4
; BTI-NEXT:    pop {r4, pc}
;
; NOBTI-LABEL: foo:
; NOBTI:       @ %bb.0: @ %entry
; NOBTI-NEXT:    bti
; NOBTI-NEXT:    .save {r4, lr}
; NOBTI-NEXT:    push {r4, lr}
; NOBTI-NEXT:    mov r4, r0
; NOBTI-NEXT:    movw r0, :lower16:buf
; NOBTI-NEXT:    movt r0, :upper16:buf
; NOBTI-NEXT:    bl setjmp
; NOBTI-NEXT:    cmp r0, #0
; NOBTI-NEXT:    itt ne
; NOBTI-NEXT:    movne r0, #0
; NOBTI-NEXT:    popne {r4, pc}
; NOBTI-NEXT:  .LBB0_1: @ %if.else
; NOBTI-NEXT:    mov r0, r4
; NOBTI-NEXT:    bl bar
; NOBTI-NEXT:    mov r0, r4
; NOBTI-NEXT:    pop {r4, pc}

entry:
  %call = call i32 @setjmp(ptr @buf) #0
  %tobool.not = icmp eq i32 %call, 0
  br i1 %tobool.not, label %if.else, label %if.end

if.else:                                          ; preds = %entry
  call void @bar(i32 %x)
  br label %if.end

if.end:                                           ; preds = %entry, %if.else
  %x.addr.0 = phi i32 [ %x, %if.else ], [ 0, %entry ]
  ret i32 %x.addr.0
}

;; Check that the BL to setjmp correctly clobbers LR

define i32 @baz() "branch-target-enforcement" {
; BTI-LABEL: baz:
; BTI:       @ %bb.0: @ %entry
; BTI-NEXT:    bti
; BTI-NEXT:    .save {r7, lr}
; BTI-NEXT:    push {r7, lr}
; BTI-NEXT:    .pad #160
; BTI-NEXT:    sub sp, #160
; BTI-NEXT:    mov r0, sp
; BTI-NEXT:    bl setjmp
; BTI-NEXT:    bti
; BTI-NEXT:    movs r0, #0
; BTI-NEXT:    add sp, #160
; BTI-NEXT:    pop {r7, pc}
;
; NOBTI-LABEL: baz:
; NOBTI:       @ %bb.0: @ %entry
; NOBTI-NEXT:    bti
; NOBTI-NEXT:    .save {r7, lr}
; NOBTI-NEXT:    push {r7, lr}
; NOBTI-NEXT:    .pad #160
; NOBTI-NEXT:    sub sp, #160
; NOBTI-NEXT:    mov r0, sp
; NOBTI-NEXT:    bl setjmp
; NOBTI-NEXT:    movs r0, #0
; NOBTI-NEXT:    add sp, #160
; NOBTI-NEXT:    pop {r7, pc}
entry:
  %outgoing_jb = alloca [20 x i64], align 8
  %call = call i32 @setjmp(ptr %outgoing_jb) returns_twice
  ret i32 0
}

declare void @bar(i32)
declare i32 @setjmp(ptr) #0

attributes #0 = { returns_twice }


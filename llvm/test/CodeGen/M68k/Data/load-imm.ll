; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=m68k-linux -verify-machineinstrs | FileCheck %s

define i1 @return_true() {
; CHECK-LABEL: return_true:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #1, %d0
; CHECK-NEXT:    rts
  ret i1 true
}

define i8 @return_0_i8() {
; CHECK-LABEL: return_0_i8:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #0, %d0
; CHECK-NEXT:    rts
  ret i8 0
}

define i16 @return_0_i16() {
; CHECK-LABEL: return_0_i16:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #0, %d0
; CHECK-NEXT:    rts
  ret i16 0
}

define i32 @return_0_i32() {
; CHECK-LABEL: return_0_i32:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #0, %d0
; CHECK-NEXT:    rts
  ret i32 0
}

define i64 @return_0_i64() {
; CHECK-LABEL: return_0_i64:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #0, %d0
; CHECK-NEXT:    move.l %d0, %d1
; CHECK-NEXT:    rts
  ret i64 0
}

define i16 @return_neg1_i16() {
; CHECK-LABEL: return_neg1_i16:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #-1, %d0
; CHECK-NEXT:    rts
  ret i16 -1
}

define i32 @return_neg1_i32() {
; CHECK-LABEL: return_neg1_i32:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #-1, %d0
; CHECK-NEXT:    rts
  ret i32 -1
}

define i8 @return_160_i8() {
; CHECK-LABEL: return_160_i8:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #-96, %d0
; CHECK-NEXT:    rts
  ret i8 160
}

define i16 @return_160_i16() {
; CHECK-LABEL: return_160_i16:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    move.w #160, %d0
; CHECK-NEXT:    rts
  ret i16 160
}

define i32 @return_160_i32() {
; CHECK-LABEL: return_160_i32:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #95, %d0
; CHECK-NEXT:    not.b %d0
; CHECK-NEXT:    rts
  ret i32 160
}

define i16 @return_14281_i16() {
; CHECK-LABEL: return_14281_i16:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    move.w #14281, %d0
; CHECK-NEXT:    rts
  ret i16 14281
}

define i32 @return_14281_i32() {
; CHECK-LABEL: return_14281_i32:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    move.l #14281, %d0
; CHECK-NEXT:    rts
  ret i32 14281
}

define i64 @return_14281_i64() {
; CHECK-LABEL: return_14281_i64:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    moveq #0, %d0
; CHECK-NEXT:    move.l #14281, %d1
; CHECK-NEXT:    rts
  ret i64 14281
}

define ptr @return_null() {
; CHECK-LABEL: return_null:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    suba.l %a0, %a0
; CHECK-NEXT:    rts
  ret ptr null
}

define ptr @return_nonnull() {
; CHECK-LABEL: return_nonnull:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    move.w #200, %a0
; CHECK-NEXT:    rts
  ret ptr inttoptr (i32 200 to ptr)
}

define ptr @return_large_nonnull() {
; CHECK-LABEL: return_large_nonnull:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0:
; CHECK-NEXT:    move.l #74281, %a0
; CHECK-NEXT:    rts
  ret ptr inttoptr (i32 74281 to ptr)
}
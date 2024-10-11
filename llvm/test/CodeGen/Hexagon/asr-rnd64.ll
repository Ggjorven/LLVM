; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -march=hexagon < %s | FileCheck %s
;
; Check if we generate rounding-asr instruction.  It is equivalent to
; Rd = ((Rs >> #u) +1) >> 1.

target triple = "hexagon"

define i32 @f0(i32 %a0) {
; CHECK-LABEL: f0:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = asr(r0,#10):rnd
; CHECK-NEXT:     r1 = r0
; CHECK-NEXT:     r29 = add(r29,#-8)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r29 = add(r29,#8)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memw(r29+#4) = r1
; CHECK-NEXT:    }
b0:
  %v0 = alloca i32, align 4
  store i32 %a0, ptr %v0, align 4
  %v1 = load i32, ptr %v0, align 4
  %v2 = ashr i32 %v1, 10
  %v3 = add nsw i32 %v2, 1
  %v4 = ashr i32 %v3, 1
  ret i32 %v4
}

define i64 @f1(i64 %a0) {
; CHECK-LABEL: f1:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1:0 = asr(r1:0,#17):rnd
; CHECK-NEXT:     r3:2 = combine(r1,r0)
; CHECK-NEXT:     r29 = add(r29,#-8)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r29 = add(r29,#8)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memd(r29+#0) = r3:2
; CHECK-NEXT:    }
b0:
  %v0 = alloca i64, align 8
  store i64 %a0, ptr %v0, align 8
  %v1 = load i64, ptr %v0, align 8
  %v2 = ashr i64 %v1, 17
  %v3 = add nsw i64 %v2, 1
  %v4 = ashr i64 %v3, 1
  ret i64 %v4
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=hexagon < %s | FileCheck %s

define i1 @f0(i32 %a0) #0 {
; CHECK-LABEL: f0:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r0,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,#0,#1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = icmp ne i32 %a0, 0
  ret i1 %v0
}

attributes #0 = { nounwind "target-cpu"="hexagonv66" }

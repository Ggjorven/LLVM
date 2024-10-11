; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O2 -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; #include <arm_sve.h>
; #include <stdint.h>
;
; void redundant_store(uint32_t *p, svint32_t v) {
;     *p = 1;
;     *(svint32_t *)p = v;
; }
define void @redundant_store(ptr nocapture %p, <vscale x 4 x i32> %v) {
; CHECK-LABEL: redundant_store:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  store i32 1, ptr %p, align 4
  store <vscale x 4 x i32> %v, ptr %p, align 16
  ret void
}

define void @two_scalable_same_size(ptr writeonly %ptr, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: two_scalable_same_size:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    st1w { z1.s }, p0, [x0]
; CHECK-NEXT:    ret
entry:
  store <vscale x 4 x i32> %a, ptr %ptr
  store <vscale x 4 x i32> %b, ptr %ptr
  ret void
}

; make sure that scalable store is present, becuase we don't know its final size.
define void @keep_scalable_store(ptr writeonly %ptr, ptr %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: keep_scalable_store:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldp q2, q1, [x1]
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    stp q2, q1, [x0]
; CHECK-NEXT:    ret
entry:
  %0 = load <8 x i32>, ptr %a
  store <vscale x 4 x i32> %b, ptr %ptr
  store <8 x i32> %0, ptr %ptr
  ret void
}

define void @two_scalable_keep_stores(ptr writeonly %ptr, <vscale x 4 x i32> %a, <vscale x 4 x i64> %b) {
; CHECK-LABEL: two_scalable_keep_stores:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    st1d { z2.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0]
; CHECK-NEXT:    st1w { z0.s }, p1, [x0]
; CHECK-NEXT:    ret
entry:
  store <vscale x 4 x i64> %b, ptr %ptr
  store <vscale x 4 x i32> %a, ptr %ptr
  ret void
}

define void @two_scalable_remove_store(ptr writeonly %ptr, <vscale x 4 x i32> %a, <vscale x 4 x i64> %b) {
; CHECK-LABEL: two_scalable_remove_store:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z2.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0]
; CHECK-NEXT:    ret
entry:
  store <vscale x 4 x i32> %a, ptr %ptr
  store <vscale x 4 x i64> %b, ptr %ptr
  ret void
}

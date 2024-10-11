; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; Test removal of AND operations that don't affect last 6 bits of shift amount
; operand.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z14 | FileCheck %s

; Test that AND is not removed when some lower 6 bits are not set.
define i32 @f1(i32 %a, i32 %sh) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nill %r3, 31
; CHECK-NEXT:    sll %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 31
  %shift = shl i32 %a, %and
  ret i32 %shift
}

; Test removal of AND mask with only bottom 6 bits set.
define i32 @f2(i32 %a, i32 %sh) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sll %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 63
  %shift = shl i32 %a, %and
  ret i32 %shift
}

; Test removal of AND mask including but not limited to bottom 6 bits.
define i32 @f3(i32 %a, i32 %sh) {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sll %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 255
  %shift = shl i32 %a, %and
  ret i32 %shift
}

; Test removal of AND mask from SRA.
define i32 @f4(i32 %a, i32 %sh) {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sra %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 63
  %shift = ashr i32 %a, %and
  ret i32 %shift
}

; Test removal of AND mask from SRL.
define i32 @f5(i32 %a, i32 %sh) {
; CHECK-LABEL: f5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srl %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 63
  %shift = lshr i32 %a, %and
  ret i32 %shift
}

; Test removal of AND mask from SLLG.
define i64 @f6(i64 %a, i64 %sh) {
; CHECK-LABEL: f6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sllg %r2, %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i64 %sh, 63
  %shift = shl i64 %a, %and
  ret i64 %shift
}

; Test removal of AND mask from SRAG.
define i64 @f7(i64 %a, i64 %sh) {
; CHECK-LABEL: f7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srag %r2, %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i64 %sh, 63
  %shift = ashr i64 %a, %and
  ret i64 %shift
}

; Test removal of AND mask from SRLG.
define i64 @f8(i64 %a, i64 %sh) {
; CHECK-LABEL: f8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srlg %r2, %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i64 %sh, 63
  %shift = lshr i64 %a, %and
  ret i64 %shift
}

; Test that AND with two register operands is not affected.
define i32 @f9(i32 %a, i32 %b, i32 %sh) {
; CHECK-LABEL: f9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nr %r3, %r4
; CHECK-NEXT:    sll %r2, 0(%r3)
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, %b
  %shift = shl i32 %a, %and
  ret i32 %shift
}

; Test that AND is not entirely removed if the result is reused.
define i32 @f10(i32 %a, i32 %sh) {
; CHECK-LABEL: f10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sll %r2, 0(%r3)
; CHECK-NEXT:    nilf %r3, 63
; CHECK-NEXT:    ar %r2, %r3
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 63
  %shift = shl i32 %a, %and
  %reuse = add i32 %and, %shift
  ret i32 %reuse
}

define i128 @f11(i128 %a, i32 %sh) {
; CHECK-LABEL: f11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vlvgp %v1, %r4, %r4
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vrepb %v1, %v1, 15
; CHECK-NEXT:    vslb %v0, %v0, %v1
; CHECK-NEXT:    vsl %v0, %v0, %v1
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 127
  %ext = zext i32 %and to i128
  %shift = shl i128 %a, %ext
  ret i128 %shift
}

define i128 @f12(i128 %a, i32 %sh) {
; CHECK-LABEL: f12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vlvgp %v1, %r4, %r4
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vrepb %v1, %v1, 15
; CHECK-NEXT:    vsrlb %v0, %v0, %v1
; CHECK-NEXT:    vsrl %v0, %v0, %v1
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 127
  %ext = zext i32 %and to i128
  %shift = lshr i128 %a, %ext
  ret i128 %shift
}

define i128 @f13(i128 %a, i32 %sh) {
; CHECK-LABEL: f13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vlvgp %v1, %r4, %r4
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vrepb %v1, %v1, 15
; CHECK-NEXT:    vsrab %v0, %v0, %v1
; CHECK-NEXT:    vsra %v0, %v0, %v1
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %and = and i32 %sh, 127
  %ext = zext i32 %and to i128
  %shift = ashr i128 %a, %ext
  ret i128 %shift
}


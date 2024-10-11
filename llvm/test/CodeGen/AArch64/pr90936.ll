; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s

define void @f(i16 %arg, ptr %arg1) {
; CHECK-LABEL: f:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ubfx w8, w0, #8, #6
; CHECK-NEXT:    strb w0, [x1]
; CHECK-NEXT:    strb w8, [x1, #1]
; CHECK-NEXT:    ret
bb:
  %i = trunc i16 %arg to i8
  %i2 = trunc i16 %arg to i14
  %i3 = lshr i14 %i2, 8
  store i8 %i, ptr %arg1, align 1
  %i4 = getelementptr i8, ptr %arg1, i64 1
  %i5 = trunc i14 %i3 to i8
  store i8 %i5, ptr %i4, align 1
  ret void
}

define void @g(i32 %arg, ptr %arg1) {
; CHECK-LABEL: g:
; CHECK:       // %bb.0: // %bb
; CHECK-NEXT:    lsr w8, w0, #8
; CHECK-NEXT:    lsr w9, w0, #16
; CHECK-NEXT:    strb w0, [x1]
; CHECK-NEXT:    strb wzr, [x1, #3]
; CHECK-NEXT:    strb w8, [x1, #1]
; CHECK-NEXT:    strb w9, [x1, #2]
; CHECK-NEXT:    ret
bb:
  %i = trunc i32 %arg to i8
  store i8 %i, ptr %arg1, align 1
  %i2 = lshr i32 %arg, 8
  %i3 = trunc i32 %i2 to i8
  %i4 = getelementptr i8, ptr %arg1, i64 1
  store i8 %i3, ptr %i4, align 1
  %i5 = lshr i32 %arg, 16
  %i6 = trunc i32 %i5 to i8
  %i7 = getelementptr i8, ptr %arg1, i64 2
  store i8 %i6, ptr %i7, align 1
  %i8 = zext i8 %i to i32
  %i9 = lshr i32 %i8, 24
  %i10 = getelementptr i8, ptr %arg1, i64 3
  %i11 = trunc i32 %i9 to i8
  store i8 %i11, ptr %i10, align 1
  ret void
}

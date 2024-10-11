; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple arm64e-apple-darwin             -verify-machineinstrs -global-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple arm64e-apple-darwin             -verify-machineinstrs -global-isel=1 -global-isel-abort=1 | FileCheck %s
; RUN: llc < %s -mtriple aarch64-linux-gnu -mattr=+pauth -verify-machineinstrs -global-isel=0 | FileCheck %s
; RUN: llc < %s -mtriple aarch64-linux-gnu -mattr=+pauth -verify-machineinstrs -global-isel=1 -global-isel-abort=1 | FileCheck %s

define i64 @test_blend(i64 %arg, i64 %arg1) {
; CHECK-LABEL: test_blend:
; CHECK:       %bb.0:
; CHECK-NEXT:    bfi x0, x1, #48, #16
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.ptrauth.blend(i64 %arg, i64 %arg1)
  ret i64 %tmp
}

define i64 @test_blend_constant(i64 %arg) {
; CHECK-LABEL: test_blend_constant:
; CHECK:       %bb.0:
; CHECK-NEXT:    movk x0, #12345, lsl #48
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.ptrauth.blend(i64 %arg, i64 12345)
  ret i64 %tmp
}

; Blend isn't commutative.
define i64 @test_blend_constant_swapped(i64 %arg) {
; CHECK-LABEL: test_blend_constant_swapped:
; CHECK:       %bb.0:
; CHECK-NEXT:    mov w8, #12345
; CHECK-NEXT:    bfi x8, x0, #48, #16
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.ptrauth.blend(i64 12345, i64 %arg)
  ret i64 %tmp
}

; Blends of constants wider than 16 bits truncate the constant.
define i64 @test_blend_constant_wide(i64 %arg) {
; CHECK-LABEL: test_blend_constant_wide:
; CHECK:       %bb.0:
; CHECK-NEXT:    mov w8, #65536
; CHECK-NEXT:    bfi x0, x8, #48, #16
; CHECK-NEXT:    ret
  %tmp = call i64 @llvm.ptrauth.blend(i64 %arg, i64 65536)
  ret i64 %tmp
}

declare i64 @llvm.ptrauth.blend(i64, i64)

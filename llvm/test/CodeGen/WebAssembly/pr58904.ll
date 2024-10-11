; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=wasm32-- | FileCheck %s

define i64 @PR58904() {
; CHECK-LABEL: PR58904:
; CHECK:         .functype PR58904 () -> (i64)
; CHECK-NEXT:  # %bb.0: # %BB
; CHECK-NEXT:    global.get __stack_pointer
; CHECK-NEXT:    i32.const 16
; CHECK-NEXT:    i32.sub
; CHECK-NEXT:    i32.const 8
; CHECK-NEXT:    i32.add
; CHECK-NEXT:    i64.extend_i32_u
; CHECK-NEXT:    # fallthrough-return
BB:
  %A = alloca i64
  %C2 = ptrtoint ptr %A to i64
  %B2 = urem i64 %C2, -1
  ret i64 %B2
}

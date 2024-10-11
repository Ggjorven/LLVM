; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: %if x86-registered-target %{ opt < %s -mtriple=x86_64-unknown -passes=slp-vectorizer,instcombine -S -slp-threshold=-10000 | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt < %s -mtriple=aarch64-unknown-linux-gnu -passes=slp-vectorizer,instcombine -S -slp-threshold=-10000 | FileCheck %s %}

define <8 x i32> @sdiv_v8i32_undefs(<8 x i32> %a) {
; CHECK-LABEL: @sdiv_v8i32_undefs(
; CHECK-NEXT:    ret <8 x i32> poison
;
  %a0 = extractelement <8 x i32> %a, i32 0
  %a1 = extractelement <8 x i32> %a, i32 1
  %a2 = extractelement <8 x i32> %a, i32 2
  %a3 = extractelement <8 x i32> %a, i32 3
  %a4 = extractelement <8 x i32> %a, i32 4
  %a5 = extractelement <8 x i32> %a, i32 5
  %a6 = extractelement <8 x i32> %a, i32 6
  %a7 = extractelement <8 x i32> %a, i32 7
  %ab0 = sdiv i32 %a0, undef
  %ab1 = sdiv i32 %a1, 4
  %ab2 = sdiv i32 %a2, 8
  %ab3 = sdiv i32 %a3, 16
  %ab4 = sdiv i32 %a4, undef
  %ab5 = sdiv i32 %a5, 4
  %ab6 = sdiv i32 %a6, 8
  %ab7 = sdiv i32 %a7, 16
  %r0 = insertelement <8 x i32> poison, i32 %ab0, i32 0
  %r1 = insertelement <8 x i32>   %r0, i32 %ab1, i32 1
  %r2 = insertelement <8 x i32>   %r1, i32 %ab2, i32 2
  %r3 = insertelement <8 x i32>   %r2, i32 %ab3, i32 3
  %r4 = insertelement <8 x i32>   %r3, i32 %ab4, i32 4
  %r5 = insertelement <8 x i32>   %r4, i32 %ab5, i32 5
  %r6 = insertelement <8 x i32>   %r5, i32 %ab6, i32 6
  %r7 = insertelement <8 x i32>   %r6, i32 %ab7, i32 7
  ret <8 x i32> %r7
}


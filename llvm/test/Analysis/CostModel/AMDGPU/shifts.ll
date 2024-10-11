; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900 -mattr=+half-rate-64-ops < %s | FileCheck -check-prefixes=FAST64 %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mattr=-half-rate-64-ops < %s | FileCheck -check-prefixes=SLOW64 %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900 -mattr=+half-rate-64-ops < %s | FileCheck -check-prefixes=FAST64-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mattr=-half-rate-64-ops < %s | FileCheck -check-prefixes=SLOW64-SIZE %s
; END.

define amdgpu_kernel void @shl() #0 {
; FAST64-LABEL: 'shl'
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = shl i8 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = shl <2 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = shl <3 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = shl <4 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = shl <5 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = shl i16 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2i16 = shl <2 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3i16 = shl <3 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = shl <4 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5i16 = shl <5 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = shl i32 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = shl <2 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = shl <3 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = shl <4 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = shl <5 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = shl i64 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = shl <2 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = shl <3 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = shl <4 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = shl <5 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; SLOW64-LABEL: 'shl'
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = shl i8 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = shl <2 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = shl <3 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = shl <4 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = shl <5 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = shl i16 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i16 = shl <2 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i16 = shl <3 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i16 = shl <4 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i16 = shl <5 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = shl i32 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = shl <2 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = shl <3 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = shl <4 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = shl <5 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %i64 = shl i64 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v2i64 = shl <2 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v3i64 = shl <3 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v4i64 = shl <4 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v5i64 = shl <5 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; FAST64-SIZE-LABEL: 'shl'
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = shl i8 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = shl <2 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = shl <3 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = shl <4 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = shl <5 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = shl i16 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2i16 = shl <2 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3i16 = shl <3 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = shl <4 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5i16 = shl <5 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = shl i32 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = shl <2 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = shl <3 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = shl <4 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = shl <5 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = shl i64 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = shl <2 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = shl <3 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = shl <4 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = shl <5 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SLOW64-SIZE-LABEL: 'shl'
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = shl i8 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = shl <2 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = shl <3 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = shl <4 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = shl <5 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = shl i16 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i16 = shl <2 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i16 = shl <3 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i16 = shl <4 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i16 = shl <5 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = shl i32 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = shl <2 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = shl <3 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = shl <4 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = shl <5 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = shl i64 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = shl <2 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = shl <3 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = shl <4 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = shl <5 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %i8 = shl i8 undef, undef
  %v2i8 = shl <2 x i8> undef, undef
  %v3i8 = shl <3 x i8> undef, undef
  %v4i8 = shl <4 x i8> undef, undef
  %v5i8 = shl <5 x i8> undef, undef
  %i16 = shl i16 undef, undef
  %v2i16 = shl <2 x i16> undef, undef
  %v3i16 = shl <3 x i16> undef, undef
  %v4i16 = shl <4 x i16> undef, undef
  %v5i16 = shl <5 x i16> undef, undef
  %i32 = shl i32 undef, undef
  %v2i32 = shl <2 x i32> undef, undef
  %v3i32 = shl <3 x i32> undef, undef
  %v4i32 = shl <4 x i32> undef, undef
  %v5i32 = shl <5 x i32> undef, undef
  %i64 = shl i64 undef, undef
  %v2i64 = shl <2 x i64> undef, undef
  %v3i64 = shl <3 x i64> undef, undef
  %v4i64 = shl <4 x i64> undef, undef
  %v5i64 = shl <5 x i64> undef, undef
  ret void
}

define amdgpu_kernel void @lshr() #0 {
; FAST64-LABEL: 'lshr'
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = lshr i8 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = lshr <2 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = lshr <3 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = lshr <4 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = lshr <5 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = lshr i16 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2i16 = lshr <2 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3i16 = lshr <3 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = lshr <4 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5i16 = lshr <5 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = lshr i32 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = lshr <2 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = lshr <3 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = lshr <4 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = lshr <5 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = lshr i64 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = lshr <2 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = lshr <3 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = lshr <4 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = lshr <5 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; SLOW64-LABEL: 'lshr'
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = lshr i8 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = lshr <2 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = lshr <3 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = lshr <4 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = lshr <5 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = lshr i16 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i16 = lshr <2 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i16 = lshr <3 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i16 = lshr <4 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i16 = lshr <5 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = lshr i32 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = lshr <2 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = lshr <3 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = lshr <4 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = lshr <5 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %i64 = lshr i64 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v2i64 = lshr <2 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v3i64 = lshr <3 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v4i64 = lshr <4 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v5i64 = lshr <5 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; FAST64-SIZE-LABEL: 'lshr'
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = lshr i8 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = lshr <2 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = lshr <3 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = lshr <4 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = lshr <5 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = lshr i16 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2i16 = lshr <2 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3i16 = lshr <3 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = lshr <4 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5i16 = lshr <5 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = lshr i32 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = lshr <2 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = lshr <3 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = lshr <4 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = lshr <5 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = lshr i64 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = lshr <2 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = lshr <3 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = lshr <4 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = lshr <5 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SLOW64-SIZE-LABEL: 'lshr'
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = lshr i8 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = lshr <2 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = lshr <3 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = lshr <4 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = lshr <5 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = lshr i16 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i16 = lshr <2 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i16 = lshr <3 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i16 = lshr <4 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i16 = lshr <5 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = lshr i32 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = lshr <2 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = lshr <3 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = lshr <4 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = lshr <5 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = lshr i64 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = lshr <2 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = lshr <3 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = lshr <4 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = lshr <5 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %i8 = lshr i8 undef, undef
  %v2i8 = lshr <2 x i8> undef, undef
  %v3i8 = lshr <3 x i8> undef, undef
  %v4i8 = lshr <4 x i8> undef, undef
  %v5i8 = lshr <5 x i8> undef, undef
  %i16 = lshr i16 undef, undef
  %v2i16 = lshr <2 x i16> undef, undef
  %v3i16 = lshr <3 x i16> undef, undef
  %v4i16 = lshr <4 x i16> undef, undef
  %v5i16 = lshr <5 x i16> undef, undef
  %i32 = lshr i32 undef, undef
  %v2i32 = lshr <2 x i32> undef, undef
  %v3i32 = lshr <3 x i32> undef, undef
  %v4i32 = lshr <4 x i32> undef, undef
  %v5i32 = lshr <5 x i32> undef, undef
  %i64 = lshr i64 undef, undef
  %v2i64 = lshr <2 x i64> undef, undef
  %v3i64 = lshr <3 x i64> undef, undef
  %v4i64 = lshr <4 x i64> undef, undef
  %v5i64 = lshr <5 x i64> undef, undef
  ret void
}

define amdgpu_kernel void @ashr() #0 {
; FAST64-LABEL: 'ashr'
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = ashr i8 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = ashr <2 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = ashr <3 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = ashr <4 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = ashr <5 x i8> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = ashr i16 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2i16 = ashr <2 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3i16 = ashr <3 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = ashr <4 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5i16 = ashr <5 x i16> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = ashr i32 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = ashr <2 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = ashr <3 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = ashr <4 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = ashr <5 x i32> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = ashr i64 undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = ashr <2 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = ashr <3 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = ashr <4 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = ashr <5 x i64> undef, undef
; FAST64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; SLOW64-LABEL: 'ashr'
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = ashr i8 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = ashr <2 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = ashr <3 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = ashr <4 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = ashr <5 x i8> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = ashr i16 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i16 = ashr <2 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i16 = ashr <3 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i16 = ashr <4 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i16 = ashr <5 x i16> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = ashr i32 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = ashr <2 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = ashr <3 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = ashr <4 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = ashr <5 x i32> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %i64 = ashr i64 undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v2i64 = ashr <2 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v3i64 = ashr <3 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v4i64 = ashr <4 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v5i64 = ashr <5 x i64> undef, undef
; SLOW64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; FAST64-SIZE-LABEL: 'ashr'
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = ashr i8 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = ashr <2 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = ashr <3 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = ashr <4 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = ashr <5 x i8> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = ashr i16 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2i16 = ashr <2 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3i16 = ashr <3 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = ashr <4 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5i16 = ashr <5 x i16> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = ashr i32 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = ashr <2 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = ashr <3 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = ashr <4 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = ashr <5 x i32> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = ashr i64 undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = ashr <2 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = ashr <3 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = ashr <4 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = ashr <5 x i64> undef, undef
; FAST64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SLOW64-SIZE-LABEL: 'ashr'
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i8 = ashr i8 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i8 = ashr <2 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i8 = ashr <3 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i8 = ashr <4 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i8 = ashr <5 x i8> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i16 = ashr i16 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i16 = ashr <2 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3i16 = ashr <3 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i16 = ashr <4 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5i16 = ashr <5 x i16> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %i32 = ashr i32 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2i32 = ashr <2 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3i32 = ashr <3 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4i32 = ashr <4 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5i32 = ashr <5 x i32> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %i64 = ashr i64 undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2i64 = ashr <2 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3i64 = ashr <3 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4i64 = ashr <4 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5i64 = ashr <5 x i64> undef, undef
; SLOW64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %i8 = ashr i8 undef, undef
  %v2i8 = ashr <2 x i8> undef, undef
  %v3i8 = ashr <3 x i8> undef, undef
  %v4i8 = ashr <4 x i8> undef, undef
  %v5i8 = ashr <5 x i8> undef, undef
  %i16 = ashr i16 undef, undef
  %v2i16 = ashr <2 x i16> undef, undef
  %v3i16 = ashr <3 x i16> undef, undef
  %v4i16 = ashr <4 x i16> undef, undef
  %v5i16 = ashr <5 x i16> undef, undef
  %i32 = ashr i32 undef, undef
  %v2i32 = ashr <2 x i32> undef, undef
  %v3i32 = ashr <3 x i32> undef, undef
  %v4i32 = ashr <4 x i32> undef, undef
  %v5i32 = ashr <5 x i32> undef, undef
  %i64 = ashr i64 undef, undef
  %v2i64 = ashr <2 x i64> undef, undef
  %v3i64 = ashr <3 x i64> undef, undef
  %v4i64 = ashr <4 x i64> undef, undef
  %v5i64 = ashr <5 x i64> undef, undef
  ret void
}

attributes #0 = { nounwind }

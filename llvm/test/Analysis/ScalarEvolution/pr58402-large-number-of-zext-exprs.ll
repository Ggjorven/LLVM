; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes='print<scalar-evolution>' -disable-output %s 2>&1 | FileCheck %s

define i32 @pr58402_large_number_of_zext(ptr %dst) {
; CHECK-LABEL: 'pr58402_large_number_of_zext'
; CHECK-NEXT:  Classifying expressions for: @pr58402_large_number_of_zext
; CHECK-NEXT:    %d.0 = phi i32 [ 0, %entry ], [ %add7.15, %header ]
; CHECK-NEXT:    --> %d.0 U: [0,65) S: [0,65) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %b.0 = phi i32 [ 59, %entry ], [ %b.0, %header ]
; CHECK-NEXT:    --> 59 U: [59,60) S: [59,60) Exits: 59 LoopDispositions: { %header: Invariant }
; CHECK-NEXT:    %conv.neg = sext i1 %cmp to i32
; CHECK-NEXT:    --> (sext i1 %cmp to i32) U: [-1,1) S: [-1,1) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %conv = zext i1 %cmp to i32
; CHECK-NEXT:    --> (zext i1 %cmp to i32) U: [0,2) S: [0,2) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i = and i32 %conv, -2
; CHECK-NEXT:    --> (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw> U: [0,1) S: [0,1) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7 = add i32 %i, 4
; CHECK-NEXT:    --> (4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> U: [4,5) S: [4,5) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i1 = and i32 %add7, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [4,5) S: [4,5) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.1 = add i32 %i1, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [8,9) S: [8,9) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i2 = and i32 %add7.1, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [8,9) S: [8,9) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.2 = add i32 %i2, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [12,13) S: [12,13) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i3 = and i32 %add7.2, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [12,13) S: [12,13) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.3 = add i32 %i3, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [16,17) S: [16,17) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i4 = and i32 %add7.3, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [16,17) S: [16,17) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.4 = add i32 %i4, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [20,21) S: [20,21) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i5 = and i32 %add7.4, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [20,21) S: [20,21) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.5 = add i32 %i5, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [24,25) S: [24,25) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i6 = and i32 %add7.5, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [24,25) S: [24,25) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.6 = add i32 %i6, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [28,29) S: [28,29) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i7 = and i32 %add7.6, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [28,29) S: [28,29) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.7 = add i32 %i7, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [32,33) S: [32,33) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i8 = and i32 %add7.7, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [32,33) S: [32,33) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.8 = add i32 %i8, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [36,37) S: [36,37) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i9 = and i32 %add7.8, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [36,37) S: [36,37) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.9 = add i32 %i9, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [40,41) S: [40,41) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i10 = and i32 %add7.9, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [40,41) S: [40,41) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.10 = add i32 %i10, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [44,45) S: [44,45) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i11 = and i32 %add7.10, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [44,45) S: [44,45) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.11 = add i32 %i11, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [48,49) S: [48,49) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i12 = and i32 %add7.11, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [48,49) S: [48,49) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.12 = add i32 %i12, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [52,53) S: [52,53) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i13 = and i32 %add7.12, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [52,53) S: [52,53) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.13 = add i32 %i13, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [56,57) S: [56,57) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i14 = and i32 %add7.13, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [56,57) S: [56,57) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.14 = add i32 %i14, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [60,61) S: [60,61) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i15 = and i32 %add7.14, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [60,61) S: [60,61) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %add7.15 = add i32 %i15, 4
; CHECK-NEXT:    --> (4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> U: [64,65) S: [64,65) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:    %i16 = and i32 %add7.15, -2
; CHECK-NEXT:    --> (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((4 + (2 * ((zext i1 %cmp to i32) /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw>)<nuw><nsw> /u 2))<nuw><nsw> U: [64,65) S: [64,65) Exits: <<Unknown>> LoopDispositions: { %header: Variant }
; CHECK-NEXT:  Determining loop execution counts for: @pr58402_large_number_of_zext
; CHECK-NEXT:  Loop %header: <multiple exits> Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %header: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %header: Unpredictable symbolic max backedge-taken count.
;
entry:
  br label %header

header:
  %d.0 = phi i32 [ 0, %entry ], [ %add7.15, %header ]
  %b.0 = phi i32 [ 59, %entry ], [ %b.0, %header ]
  %cmp = icmp slt i32 %b.0, 1
  %conv.neg = sext i1 %cmp to i32
  %conv = zext i1 %cmp to i32
  %i = and i32 %conv, -2
  %add7 = add i32 %i, 4
  %i1 = and i32 %add7, -2
  %add7.1 = add i32 %i1, 4
  %i2 = and i32 %add7.1, -2
  %add7.2 = add i32 %i2, 4
  %i3 = and i32 %add7.2, -2
  %add7.3 = add i32 %i3, 4
  %i4 = and i32 %add7.3, -2
  %add7.4 = add i32 %i4, 4
  %i5 = and i32 %add7.4, -2
  %add7.5 = add i32 %i5, 4
  %i6 = and i32 %add7.5, -2
  %add7.6 = add i32 %i6, 4
  %i7 = and i32 %add7.6, -2
  %add7.7 = add i32 %i7, 4
  %i8 = and i32 %add7.7, -2
  %add7.8 = add i32 %i8, 4
  %i9 = and i32 %add7.8, -2
  %add7.9 = add i32 %i9, 4
  %i10 = and i32 %add7.9, -2
  %add7.10 = add i32 %i10, 4
  %i11 = and i32 %add7.10, -2
  %add7.11 = add i32 %i11, 4
  %i12 = and i32 %add7.11, -2
  %add7.12 = add i32 %i12, 4
  %i13 = and i32 %add7.12, -2
  %add7.13 = add i32 %i13, 4
  %i14 = and i32 %add7.13, -2
  %add7.14 = add i32 %i14, 4
  %i15 = and i32 %add7.14, -2
  %add7.15 = add i32 %i15, 4
  %i16 = and i32 %add7.15, -2
  store i32 %add7.15, ptr %dst, align 4
  br label %header
}

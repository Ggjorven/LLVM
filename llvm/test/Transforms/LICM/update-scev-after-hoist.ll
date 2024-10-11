; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes='loop-unroll,loop-mssa(licm),print<scalar-evolution>' -unroll-count=4 -disable-output < %s 2>&1 | FileCheck %s --check-prefix=SCEV-EXPR

define i16 @main() {
; SCEV-EXPR-LABEL: 'main'
; SCEV-EXPR-NEXT:  Classifying expressions for: @main
; SCEV-EXPR-NEXT:    %mul = phi i16 [ 1, %entry ], [ %mul.n.3.reass, %loop ]
; SCEV-EXPR-NEXT:    --> %mul U: [0,-15) S: [-32768,32753) Exits: 4096 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %div = phi i16 [ 32767, %entry ], [ %div.n.3, %loop ]
; SCEV-EXPR-NEXT:    --> %div U: [-2048,-32768) S: [-2048,-32768) Exits: 7 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %mul.n.reass.reass = mul i16 %mul, 8
; SCEV-EXPR-NEXT:    --> (8 * %mul) U: [0,-7) S: [-32768,32761) Exits: -32768 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %div.n = sdiv i16 %div, 2
; SCEV-EXPR-NEXT:    --> %div.n U: [-16384,16384) S: [-16384,16384) Exits: 3 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %div.n.1 = sdiv i16 %div.n, 2
; SCEV-EXPR-NEXT:    --> %div.n.1 U: [-8192,8192) S: [-8192,8192) Exits: 1 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %div.n.2 = sdiv i16 %div.n.1, 2
; SCEV-EXPR-NEXT:    --> %div.n.2 U: [-4096,4096) S: [-4096,4096) Exits: 0 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %mul.n.3.reass = mul i16 %mul, 16
; SCEV-EXPR-NEXT:    --> (16 * %mul) U: [0,-15) S: [-32768,32753) Exits: 0 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %div.n.3 = sdiv i16 %div.n.2, 2
; SCEV-EXPR-NEXT:    --> %div.n.3 U: [-2048,2048) S: [-2048,2048) Exits: 0 LoopDispositions: { %loop: Variant }
; SCEV-EXPR-NEXT:    %mul.lcssa = phi i16 [ %mul.n.reass.reass, %loop ]
; SCEV-EXPR-NEXT:    --> (8 * %mul) U: [0,-7) S: [-32768,32761) --> -32768 U: [-32768,-32767) S: [-32768,-32767)
; SCEV-EXPR-NEXT:  Determining loop execution counts for: @main
; SCEV-EXPR-NEXT:  Loop %loop: backedge-taken count is i32 3
; SCEV-EXPR-NEXT:  Loop %loop: constant max backedge-taken count is i32 3
; SCEV-EXPR-NEXT:  Loop %loop: symbolic max backedge-taken count is i32 3
; SCEV-EXPR-NEXT:  Loop %loop: Trip multiple is 4
;
entry:
  br label %loop

loop:
  %mul = phi i16 [ 1, %entry ], [ %mul.n, %loop ]
  %div = phi i16 [ 32767, %entry ], [ %div.n, %loop ]
  %mul.n = mul i16 %mul, 2
  %div.n = sdiv i16 %div, 2
  %cmp = icmp sgt i16 %div, 0
  br i1 %cmp, label %loop, label %end

end:
  ret i16 %mul
}

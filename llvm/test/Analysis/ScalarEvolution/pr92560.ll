; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -disable-output "-passes=print<scalar-evolution>" < %s 2>&1 | FileCheck %s

define dso_local void @simple(i32 noundef %n) local_unnamed_addr {
; CHECK-LABEL: 'simple'
; CHECK-NEXT:  Classifying expressions for: @simple
; CHECK-NEXT:    %right.06 = phi i32 [ %dec, %while.body ], [ %n, %entry ]
; CHECK-NEXT:    --> {%n,+,-4}<nsw><%while.body> U: full-set S: full-set Exits: ((-4 * (((-4 + (-1 * (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))<nuw><nsw> + (4 smax (-4 + %n))) /u 8) + (1 umin (-4 + (4 smax (-4 + %n)))<nsw>)))<nsw> + %n) LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %left.05 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,4}<nuw><nsw><%while.body> U: [0,2147483641) S: [0,2147483641) Exits: (4 * (((-4 + (-1 * (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))<nuw><nsw> + (4 smax (-4 + %n))) /u 8) + (1 umin (-4 + (4 smax (-4 + %n)))<nsw>)))<nuw> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %left.05, 4
; CHECK-NEXT:    --> {4,+,4}<nuw><nsw><%while.body> U: [4,2147483645) S: [4,2147483645) Exits: (4 + (4 * (((-4 + (-1 * (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))<nuw><nsw> + (4 smax (-4 + %n))) /u 8) + (1 umin (-4 + (4 smax (-4 + %n)))<nsw>)))<nuw>)<nuw> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %dec = add nsw i32 %right.06, -4
; CHECK-NEXT:    --> {(-4 + %n),+,-4}<nsw><%while.body> U: full-set S: full-set Exits: (-4 + (-4 * (((-4 + (-1 * (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))<nuw><nsw> + (4 smax (-4 + %n))) /u 8) + (1 umin (-4 + (4 smax (-4 + %n)))<nsw>)))<nsw> + %n) LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @simple
; CHECK-NEXT:  Loop %while.body: backedge-taken count is (((-4 + (-1 * (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))<nuw><nsw> + (4 smax (-4 + %n))) /u 8) + (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))
; CHECK-NEXT:  Loop %while.body: constant max backedge-taken count is i32 536870910
; CHECK-NEXT:  Loop %while.body: symbolic max backedge-taken count is (((-4 + (-1 * (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))<nuw><nsw> + (4 smax (-4 + %n))) /u 8) + (1 umin (-4 + (4 smax (-4 + %n)))<nsw>))
; CHECK-NEXT:  Loop %while.body: Trip multiple is 1
;
entry:
  %cmp4 = icmp sgt i32 %n, 0
  br i1 %cmp4, label %while.body, label %while.end

while.body:
  %right.06 = phi i32 [ %dec, %while.body ], [ %n, %entry ]
  %left.05 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %inc = add nuw nsw i32 %left.05, 4
  %dec = add nsw i32 %right.06, -4
  %cmp = icmp slt i32 %inc, %dec
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}

; Cannot find backedge-count because subtraction of strides is wrapping.
define dso_local void @stride_overflow(i32 noundef %n) local_unnamed_addr {
; CHECK-LABEL: 'stride_overflow'
; CHECK-NEXT:  Classifying expressions for: @stride_overflow
; CHECK-NEXT:    %right.06 = phi i32 [ %dec, %while.body ], [ %n, %entry ]
; CHECK-NEXT:    --> {%n,+,-1}<nsw><%while.body> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %left.05 = phi i32 [ %inc, %while.body ], [ 2147483647, %entry ]
; CHECK-NEXT:    --> {2147483647,+,2147483647}<nuw><nsw><%while.body> U: [2147483647,-2147483648) S: [2147483647,-2147483648) Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %left.05, 2147483647
; CHECK-NEXT:    --> {-2,+,2147483647}<nuw><nsw><%while.body> U: [-2,-1) S: [-2,0) Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %dec = add nsw i32 %right.06, -1
; CHECK-NEXT:    --> {(-1 + %n),+,-1}<nsw><%while.body> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @stride_overflow
; CHECK-NEXT:  Loop %while.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %while.body: constant max backedge-taken count is i32 1
; CHECK-NEXT:  Loop %while.body: symbolic max backedge-taken count is i32 1
;
entry:
  %cmp4 = icmp sgt i32 %n, 0
  br i1 %cmp4, label %while.body, label %while.end

while.body:
  %right.06 = phi i32 [ %dec, %while.body ], [ %n, %entry ]
  %left.05 = phi i32 [ %inc, %while.body ], [ 2147483647, %entry ]
  %inc = add nuw nsw i32 %left.05, 2147483647
  %dec = add nsw i32 %right.06, -1
  %cmp = icmp slt i32 %inc, %dec
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}

; Cannot find backedge-count because %conv110 is wrapping
define dso_local void @rhs_wrapping() local_unnamed_addr {
; CHECK-LABEL: 'rhs_wrapping'
; CHECK-NEXT:  Classifying expressions for: @rhs_wrapping
; CHECK-NEXT:    %a = alloca i8, align 1
; CHECK-NEXT:    --> %a U: full-set S: full-set
; CHECK-NEXT:    %conv110 = phi i32 [ 0, %entry ], [ %sext8, %while.body ]
; CHECK-NEXT:    --> {0,+,-1090519040}<%while.body> U: [0,-16777215) S: [-2147483648,2130706433) Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %conv9 = phi i32 [ -2147483648, %entry ], [ %sext, %while.body ]
; CHECK-NEXT:    --> {-2147483648,+,16777216}<nsw><%while.body> U: [0,-16777215) S: [-2147483648,2113929217) Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %sext = add nsw i32 %conv9, 16777216
; CHECK-NEXT:    --> {-2130706432,+,16777216}<nsw><%while.body> U: [0,-16777215) S: [-2130706432,2130706433) Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %sext8 = add i32 %conv110, -1090519040
; CHECK-NEXT:    --> {-1090519040,+,-1090519040}<%while.body> U: [0,-16777215) S: [-2147483648,2130706433) Exits: <<Unknown>> LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @rhs_wrapping
; CHECK-NEXT:  Loop %while.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %while.body: constant max backedge-taken count is i32 254
; CHECK-NEXT:  Loop %while.body: symbolic max backedge-taken count is i32 254
;
entry:
  %a = alloca i8, align 1
  br label %while.body

while.body:
  %conv110 = phi i32 [ 0, %entry ], [ %sext8, %while.body ]
  %conv9 = phi i32 [ -2147483648, %entry ], [ %sext, %while.body ]
  %sext = add nsw i32 %conv9, 16777216
  %sext8 = add i32 %conv110, -1090519040
  %cmp = icmp slt i32 %sext, %sext8
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}

; abs(left_stride) != abs(right_stride)
define dso_local void @simple2() local_unnamed_addr {
; CHECK-LABEL: 'simple2'
; CHECK-NEXT:  Classifying expressions for: @simple2
; CHECK-NEXT:    %right.08 = phi i32 [ 50, %entry ], [ %add2, %while.body ]
; CHECK-NEXT:    --> {50,+,-5}<nsw><%while.body> U: [25,51) S: [25,51) Exits: 25 LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %left.07 = phi i32 [ 0, %entry ], [ %add, %while.body ]
; CHECK-NEXT:    --> {0,+,4}<nuw><nsw><%while.body> U: [0,21) S: [0,21) Exits: 20 LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %add = add nuw nsw i32 %left.07, 4
; CHECK-NEXT:    --> {4,+,4}<nuw><nsw><%while.body> U: [4,25) S: [4,25) Exits: 24 LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:    %add2 = add nsw i32 %right.08, -5
; CHECK-NEXT:    --> {45,+,-5}<nsw><%while.body> U: [20,46) S: [20,46) Exits: 20 LoopDispositions: { %while.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @simple2
; CHECK-NEXT:  Loop %while.body: backedge-taken count is i32 5
; CHECK-NEXT:  Loop %while.body: constant max backedge-taken count is i32 5
; CHECK-NEXT:  Loop %while.body: symbolic max backedge-taken count is i32 5
; CHECK-NEXT:  Loop %while.body: Trip multiple is 6
;
entry:
  br label %while.body

while.body:
  %right.08 = phi i32 [ 50, %entry ], [ %add2, %while.body ]
  %left.07 = phi i32 [ 0, %entry ], [ %add, %while.body ]
  %add = add nuw nsw i32 %left.07, 4
  %add2 = add nsw i32 %right.08, -5
  %cmp = icmp slt i32 %add, %add2
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}

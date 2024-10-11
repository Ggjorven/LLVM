; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt "-passes=print<scalar-evolution>" -disable-output < %s 2>&1 | FileCheck %s

define void @vscale_gep(ptr %p) {
; CHECK-LABEL: 'vscale_gep'
; CHECK-NEXT:  Classifying expressions for: @vscale_gep
; CHECK-NEXT:    %1 = getelementptr <vscale x 4 x i32>, ptr null, i32 3
; CHECK-NEXT:    --> ((48 * vscale) + null) U: [0,-15) S: [-9223372036854775808,9223372036854775793)
; CHECK-NEXT:    %2 = getelementptr <vscale x 1 x i64>, ptr %p, i32 1
; CHECK-NEXT:    --> ((8 * vscale) + %p) U: full-set S: full-set
; CHECK-NEXT:  Determining loop execution counts for: @vscale_gep
;
  getelementptr <vscale x 4 x i32>, ptr null, i32 3
  getelementptr <vscale x 1 x i64>, ptr %p, i32 1
  ret void
}

define void @vscale_gep_range(ptr %p) vscale_range(2, 16) {
; CHECK-LABEL: 'vscale_gep_range'
; CHECK-NEXT:  Classifying expressions for: @vscale_gep_range
; CHECK-NEXT:    %1 = getelementptr <vscale x 4 x i32>, ptr null, i32 3
; CHECK-NEXT:    --> ((48 * vscale)<nuw><nsw> + null) U: [96,769) S: [96,769)
; CHECK-NEXT:    %2 = getelementptr <vscale x 1 x i64>, ptr %p, i32 1
; CHECK-NEXT:    --> ((8 * vscale)<nuw><nsw> + %p) U: full-set S: full-set
; CHECK-NEXT:  Determining loop execution counts for: @vscale_gep_range
;
  getelementptr <vscale x 4 x i32>, ptr null, i32 3
  getelementptr <vscale x 1 x i64>, ptr %p, i32 1
  ret void
}

define i64 @vscale_no_range() {
; CHECK-LABEL: 'vscale_no_range'
; CHECK-NEXT:  Classifying expressions for: @vscale_no_range
; CHECK-NEXT:    %vscale = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    --> vscale U: [1,0) S: [1,0)
; CHECK-NEXT:  Determining loop execution counts for: @vscale_no_range
;
  %vscale = call i64 @llvm.vscale.i64()
  ret i64 %vscale
}

define i64 @vscale_min_max_range() vscale_range(2, 16) {
; CHECK-LABEL: 'vscale_min_max_range'
; CHECK-NEXT:  Classifying expressions for: @vscale_min_max_range
; CHECK-NEXT:    %vscale = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    --> vscale U: [2,17) S: [2,17)
; CHECK-NEXT:  Determining loop execution counts for: @vscale_min_max_range
;
  %vscale = call i64 @llvm.vscale.i64()
  ret i64 %vscale
}

define i64 @vscale_min_range() vscale_range(2, 0) {
; CHECK-LABEL: 'vscale_min_range'
; CHECK-NEXT:  Classifying expressions for: @vscale_min_range
; CHECK-NEXT:    %vscale = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    --> vscale U: [2,0) S: [2,0)
; CHECK-NEXT:  Determining loop execution counts for: @vscale_min_range
;
  %vscale = call i64 @llvm.vscale.i64()
  ret i64 %vscale
}

define i64 @vscale_exact_range() vscale_range(2) {
; CHECK-LABEL: 'vscale_exact_range'
; CHECK-NEXT:  Classifying expressions for: @vscale_exact_range
; CHECK-NEXT:    %vscale = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    --> vscale U: [2,3) S: [2,3)
; CHECK-NEXT:  Determining loop execution counts for: @vscale_exact_range
;
  %vscale = call i64 @llvm.vscale.i64()
  ret i64 %vscale
}

define void @vscale_step_ne_tripcount(i64 %N) vscale_range(2, 1024) {
; CHECK-LABEL: 'vscale_step_ne_tripcount'
; CHECK-NEXT:  Classifying expressions for: @vscale_step_ne_tripcount
; CHECK-NEXT:    %0 = sub i64 -1, %N
; CHECK-NEXT:    --> (-1 + (-1 * %N)) U: full-set S: full-set
; CHECK-NEXT:    %1 = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    --> vscale U: [2,1025) S: [2,1025)
; CHECK-NEXT:    %2 = mul i64 %1, 4
; CHECK-NEXT:    --> (4 * vscale)<nuw><nsw> U: [8,4097) S: [8,4097)
; CHECK-NEXT:    %4 = sub i64 %2, 1
; CHECK-NEXT:    --> (-1 + (4 * vscale)<nuw><nsw>)<nsw> U: [7,4096) S: [7,4096)
; CHECK-NEXT:    %n.rnd.up = add i64 %N, %4
; CHECK-NEXT:    --> (-1 + (4 * vscale)<nuw><nsw> + %N) U: full-set S: full-set
; CHECK-NEXT:    %n.mod.vf = urem i64 %n.rnd.up, %2
; CHECK-NEXT:    --> (-1 + (vscale * (4 + (-4 * ((-1 + (4 * vscale)<nuw><nsw> + %N) /u (4 * vscale)<nuw><nsw>))<nsw>)<nsw>) + %N) U: full-set S: full-set
; CHECK-NEXT:    %n.vec = sub i64 %n.rnd.up, %n.mod.vf
; CHECK-NEXT:    --> (4 * vscale * ((-1 + (4 * vscale)<nuw><nsw> + %N) /u (4 * vscale)<nuw><nsw>)) U: [0,-3) S: [-9223372036854775808,9223372036854775805)
; CHECK-NEXT:    %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
; CHECK-NEXT:    --> {0,+,(4 * vscale)<nuw><nsw>}<nuw><%vector.body> U: [0,-3) S: [-9223372036854775808,9223372036854775805) Exits: (4 * vscale * ((-1 * vscale * (4 + (-4 * ((-1 + (4 * vscale)<nuw><nsw> + %N) /u (4 * vscale)<nuw><nsw>))<nsw>)<nsw>) /u (4 * vscale)<nuw><nsw>)) LoopDispositions: { %vector.body: Computable }
; CHECK-NEXT:    %index.next = add nuw i64 %index, %2
; CHECK-NEXT:    --> {(4 * vscale)<nuw><nsw>,+,(4 * vscale)<nuw><nsw>}<nuw><%vector.body> U: [8,-3) S: [-9223372036854775808,9223372036854775805) Exits: (vscale * (4 + (4 * ((-1 * vscale * (4 + (-4 * ((-1 + (4 * vscale)<nuw><nsw> + %N) /u (4 * vscale)<nuw><nsw>))<nsw>)<nsw>) /u (4 * vscale)<nuw><nsw>))<nuw><nsw>)<nuw>) LoopDispositions: { %vector.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @vscale_step_ne_tripcount
; CHECK-NEXT:  Loop %vector.body: backedge-taken count is ((-1 * vscale * (4 + (-4 * ((-1 + (4 * vscale)<nuw><nsw> + %N) /u (4 * vscale)<nuw><nsw>))<nsw>)<nsw>) /u (4 * vscale)<nuw><nsw>)
; CHECK-NEXT:  Loop %vector.body: constant max backedge-taken count is i64 2305843009213693951
; CHECK-NEXT:  Loop %vector.body: symbolic max backedge-taken count is ((-1 * vscale * (4 + (-4 * ((-1 + (4 * vscale)<nuw><nsw> + %N) /u (4 * vscale)<nuw><nsw>))<nsw>)<nsw>) /u (4 * vscale)<nuw><nsw>)
; CHECK-NEXT:  Loop %vector.body: Trip multiple is 1
;
entry:
  %0 = sub i64 -1, %N
  %1 = call i64 @llvm.vscale.i64()
  %2 = mul i64 %1, 4
  %3 = icmp ult i64 %0, %2
  br i1 %3, label %loop.exit, label %vector.ph

vector.ph:                                        ; preds = %entry
  %8 = sub i64 %2, 1
  %n.rnd.up = add i64 %N, %8
  %n.mod.vf = urem i64 %n.rnd.up, %2
  %n.vec = sub i64 %n.rnd.up, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %index.next = add nuw i64 %index, %2
  %22 = icmp eq i64 %index.next, %n.vec
  br i1 %22, label %loop.exit, label %vector.body

loop.exit:
  ret void
}

declare i64 @llvm.vscale.i64()

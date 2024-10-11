; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -passes=separate-const-offset-from-gep < %s | FileCheck %s

declare void @use.i32(i32 noundef)
declare void @allow.undef.use.i32(i32)

declare void @use.v2i32(<2 x i32> noundef)
declare void @allow.undef.use.v2i32(<2 x i32>)

declare void @use.i64(i64 noundef)

; Should fold out the 64-bit add
define i64 @add_sext__dominating_add_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext i32 [[ADD_NSW]] to i64
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

; Should fold out the 64-bit sub
define i64 @sub_sext__dominating_sub_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sext i32 [[SUB_NSW]] to i64
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

; Should fold out the 64-bit add. The 64-bit add has commuted operands
; compared to the original.
define i64 @add_sext__dominating_add_nsw_commuted(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nsw_commuted
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext i32 [[ADD_NSW]] to i64
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg1.sext, %arg0.sext
  call void @use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

; The second sub has commuted operands
define i64 @sub_sext__dominating_sub_nsw_commuted(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nsw_commuted
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG1_SEXT]], [[ARG0_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg1.sext, %arg0.sext
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

; Missing nsw on the add i32, can't do anything
define i64 @add_sext__dominating_add(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

; Missing nsw on the sub i32, can't do anything
define i64 @sub_sext__dominating_sub(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

; The use of the 32-bit add allows poison, so can't fold.
define i64 @add_sext__dominating_add_nsw_defined(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nsw_defined
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @allow.undef.use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @allow.undef.use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

; The use of the 32-bit sub allows poison, so can't fold.
define i64 @sub_sext__dominating_sub_nsw_defined(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nsw_defined
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @allow.undef.use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @allow.undef.use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

define i64 @add_sext__dominating_add_nsw_multi_use_sext0(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nsw_multi_use_sext0
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i64(i64 [[ARG0_SEXT]])
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i64(i64 %arg0.sext)
  call void @use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

define i64 @add_sext__dominating_add_nsw_multi_use_sext1(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nsw_multi_use_sext1
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i64(i64 [[ARG1_SEXT]])
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i64(i64 %arg1.sext)
  call void @use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

define i64 @sub_sext__dominating_sub_nsw_multi_use_sext0(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nsw_multi_use_sext0
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i64(i64 [[ARG0_SEXT]])
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i64(i64 %arg0.sext)
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

define i64 @sub_sext__dominating_sub_nsw_multi_use_sext1(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nsw_multi_use_sext1
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i64(i64 [[ARG1_SEXT]])
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i64(i64 %arg1.sext)
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

; --------------------------------------------------------------------
; Vector handling
; --------------------------------------------------------------------

; Should fold out the 64-bit add
define <2 x i64> @add_sext__dominating_add_nsw_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @add_sext__dominating_add_nsw_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext <2 x i32> [[ADD_NSW]] to <2 x i64>
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[ADD_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %add.sext = add <2 x i64> %arg0.sext, %arg1.sext
  call void @use.v2i32(<2 x i32> %add.nsw)
  ret <2 x i64> %add.sext
}

; Should fold out the 64-bit sub
define <2 x i64> @sub_sext__dominating_sub_nsw_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @sub_sext__dominating_sub_nsw_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sext <2 x i32> [[SUB_NSW]] to <2 x i64>
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[SUB_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %sub.sext = sub <2 x i64> %arg0.sext, %arg1.sext
  call void @use.v2i32(<2 x i32> %sub.nsw)
  ret <2 x i64> %sub.sext
}

; Should fold out the 64-bit add. The 64-bit add has commuted operands
; compared to the original.
define <2 x i64> @add_sext__dominating_add_nsw_commuted_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @add_sext__dominating_add_nsw_commuted_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext <2 x i32> [[ADD_NSW]] to <2 x i64>
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[ADD_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %add.sext = add <2 x i64> %arg1.sext, %arg0.sext
  call void @use.v2i32(<2 x i32> %add.nsw)
  ret <2 x i64> %add.sext
}

; The second sub has commuted operands
define <2 x i64> @sub_sext__dominating_sub_nsw_commuted_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @sub_sext__dominating_sub_nsw_commuted_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub <2 x i64> [[ARG1_SEXT]], [[ARG0_SEXT]]
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[SUB_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %sub.sext = sub <2 x i64> %arg1.sext, %arg0.sext
  call void @use.v2i32(<2 x i32> %sub.nsw)
  ret <2 x i64> %sub.sext
}

; Missing nsw on the add <2 x i32>, can't do anything
define <2 x i64> @add_sext__dominating_add_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @add_sext__dominating_add_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add <2 x i64> [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[ADD_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[ADD_SEXT]]
;
entry:
  %add.nsw = add <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %add.sext = add <2 x i64> %arg0.sext, %arg1.sext
  call void @use.v2i32(<2 x i32> %add.nsw)
  ret <2 x i64> %add.sext
}

; Missing nsw on the sub <2 x i32>, can't do anything
define <2 x i64> @sub_sext__dominating_sub_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @sub_sext__dominating_sub_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub <2 x i64> [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[SUB_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %sub.sext = sub <2 x i64> %arg0.sext, %arg1.sext
  call void @use.v2i32(<2 x i32> %sub.nsw)
  ret <2 x i64> %sub.sext
}

; The use of the 32-bit add allows poison, so can't fold.
define <2 x i64> @add_sext__dominating_add_nsw_defined_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @add_sext__dominating_add_nsw_defined_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add <2 x i64> [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @allow.undef.use.v2i32(<2 x i32> [[ADD_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %add.sext = add <2 x i64> %arg0.sext, %arg1.sext
  call void @allow.undef.use.v2i32(<2 x i32> %add.nsw)
  ret <2 x i64> %add.sext
}

; The use of the 32-bit sub allows poison, so can't fold.
define <2 x i64> @sub_sext__dominating_sub_nsw_defined_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @sub_sext__dominating_sub_nsw_defined_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub <2 x i64> [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @allow.undef.use.v2i32(<2 x i32> [[SUB_NSW]])
; CHECK-NEXT:    ret <2 x i64> [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw <2 x i32> %arg0, %arg1
  %arg0.sext = sext <2 x i32> %arg0 to <2 x i64>
  %arg1.sext = sext <2 x i32> %arg1 to <2 x i64>
  %sub.sext = sub <2 x i64> %arg0.sext, %arg1.sext
  call void @allow.undef.use.v2i32(<2 x i32> %sub.nsw)
  ret <2 x i64> %sub.sext
}

; --------------------------------------------------------------------
; Zext x nsw
; --------------------------------------------------------------------

; Want sext, not zext
define i64 @add_zext__dominating_add_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_zext__dominating_add_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = zext i32 %arg0 to i64
  %arg1.sext = zext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nsw)
  ret i64 %add.sext
}

; Want sext, not zext
define i64 @sub_zext__dominating_add_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_zext__dominating_add_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = zext i32 %arg0 to i64
  %arg1.sext = zext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

; --------------------------------------------------------------------
; sext x nuw
; --------------------------------------------------------------------

; Want nsw, not nuw
define i64 @add_sext__dominating_add_nuw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nuw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW:%.*]] = add nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nuw = add nuw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nuw)
  ret i64 %add.sext
}

; Want nsw, not nuw
define i64 @sub_sext__dominating_sub_nuw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nuw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NUW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nuw = sub nuw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nuw)
  ret i64 %sub.sext
}

; --------------------------------------------------------------------
; Misc negative tests
; --------------------------------------------------------------------

; Opcode mismatch 1
define i64 @add_sext__dominating_sub_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_sub_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nsw)
  ret i64 %sub.sext
}

; Opcode mismatch 2
define i64 @sub_sext__dominating_add_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_add_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nsw)
  ret i64 %sub.sext
}

; Both nsw add and sub coexist for the same inputs
define void @add_sext__dominating_add_nsw_sub_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define void @add_sext__dominating_add_nsw_sub_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext i32 [[ADD_NSW]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    call void @use.i64(i64 [[ADD_SEXT]])
; CHECK-NEXT:    call void @use.i64(i64 [[SUB_SEXT]])
; CHECK-NEXT:    ret void
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nsw)
  call void @use.i32(i32 %sub.nsw)
  call void @use.i64(i64 %add.sext)
  call void @use.i64(i64 %sub.sext)
  ret void
}

; Both nsw add and sub coexist for the same inputs, but commuted
define void @add_sext__dominating_add_nsw_sub_nsw_swapped(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define void @add_sext__dominating_add_nsw_sub_nsw_swapped
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG1]], [[ARG0]]
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext i32 [[ADD_NSW]] to i64
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG1_SEXT]], [[ARG0_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    call void @use.i64(i64 [[ADD_SEXT]])
; CHECK-NEXT:    call void @use.i64(i64 [[SUB_SEXT]])
; CHECK-NEXT:    ret void
;
entry:
  %add.nsw = add nsw i32 %arg0, %arg1
  %sub.nsw = sub nsw i32 %arg1, %arg0
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  %sub.sext = sub i64 %arg1.sext, %arg0.sext
  call void @use.i32(i32 %add.nsw)
  call void @use.i32(i32 %sub.nsw)
  call void @use.i64(i64 %add.sext)
  call void @use.i64(i64 %sub.sext)
  ret void
}

; --------------------------------------------------------------------
; zext x nuw
; --------------------------------------------------------------------

; Should fold out the add i64
define i64 @add_zext__dominating_add_nuw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_zext__dominating_add_nuw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW:%.*]] = add nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_ZEXT:%.*]] = add i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW]])
; CHECK-NEXT:    ret i64 [[ADD_ZEXT]]
;
entry:
  %add.nuw = add nuw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %add.zext = add i64 %arg0.zext, %arg1.zext
  call void @use.i32(i32 %add.nuw)
  ret i64 %add.zext
}

; Should fold out the sub i64
define i64 @sub_zext__dominating_sub_nuw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_zext__dominating_sub_nuw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_ZEXT:%.*]] = sub i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NUW]])
; CHECK-NEXT:    ret i64 [[SUB_ZEXT]]
;
entry:
  %sub.nuw = sub nuw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %sub.zext = sub i64 %arg0.zext, %arg1.zext
  call void @use.i32(i32 %sub.nuw)
  ret i64 %sub.zext
}

; Should fold out the add <2 x i64>
define <2 x i64> @add_zext__dominating_add_nuw_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @add_zext__dominating_add_nuw_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW:%.*]] = add nuw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[ADD_ZEXT:%.*]] = add <2 x i64> [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[ADD_NUW]])
; CHECK-NEXT:    ret <2 x i64> [[ADD_ZEXT]]
;
entry:
  %add.nuw = add nuw <2 x i32> %arg0, %arg1
  %arg0.zext = zext <2 x i32> %arg0 to <2 x i64>
  %arg1.zext = zext <2 x i32> %arg1 to <2 x i64>
  %add.zext = add <2 x i64> %arg0.zext, %arg1.zext
  call void @use.v2i32(<2 x i32> %add.nuw)
  ret <2 x i64> %add.zext
}

; Should fold out the sub <2 x i64>
define <2 x i64> @sub_zext__dominating_sub_nuw_vector(<2 x i32> %arg0, <2 x i32> %arg1) {
; CHECK-LABEL: define <2 x i64> @sub_zext__dominating_sub_nuw_vector
; CHECK-SAME: (<2 x i32> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw <2 x i32> [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext <2 x i32> [[ARG0]] to <2 x i64>
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext <2 x i32> [[ARG1]] to <2 x i64>
; CHECK-NEXT:    [[SUB_ZEXT:%.*]] = sub <2 x i64> [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    call void @use.v2i32(<2 x i32> [[SUB_NUW]])
; CHECK-NEXT:    ret <2 x i64> [[SUB_ZEXT]]
;
entry:
  %sub.nuw = sub nuw <2 x i32> %arg0, %arg1
  %arg0.zext = zext <2 x i32> %arg0 to <2 x i64>
  %arg1.zext = zext <2 x i32> %arg1 to <2 x i64>
  %sub.zext = sub <2 x i64> %arg0.zext, %arg1.zext
  call void @use.v2i32(<2 x i32> %sub.nuw)
  ret <2 x i64> %sub.zext
}

; Both nuw and nsw exist
define void @add_zext_add_sext__dominating_add_nuw_add_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define void @add_zext_add_sext__dominating_add_nuw_add_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW:%.*]] = add nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_NSW:%.*]] = add nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_ZEXT:%.*]] = add i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = add i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW]])
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NSW]])
; CHECK-NEXT:    call void @use.i64(i64 [[ADD_ZEXT]])
; CHECK-NEXT:    call void @use.i64(i64 [[ADD_SEXT]])
; CHECK-NEXT:    ret void
;
entry:
  %add.nuw = add nuw i32 %arg0, %arg1
  %add.nsw = add nsw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.zext = add i64 %arg0.zext, %arg1.zext
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nuw)
  call void @use.i32(i32 %add.nsw)
  call void @use.i64(i64 %add.zext)
  call void @use.i64(i64 %add.sext)
  ret void
}

; Both exist
define void @sub_zext_sub_sext__dominating_sub_nuw_sub_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define void @sub_zext_sub_sext__dominating_sub_nuw_sub_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_ZEXT:%.*]] = sub i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NUW]])
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    call void @use.i64(i64 [[SUB_ZEXT]])
; CHECK-NEXT:    call void @use.i64(i64 [[SUB_SEXT]])
; CHECK-NEXT:    ret void
;
entry:
  %sub.nuw = sub nuw i32 %arg0, %arg1
  %sub.nsw = sub nsw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.zext = sub i64 %arg0.zext, %arg1.zext
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nuw)
  call void @use.i32(i32 %sub.nsw)
  call void @use.i64(i64 %sub.zext)
  call void @use.i64(i64 %sub.sext)
  ret void
}

; Both exist with commuted operands from each other
define void @sub_zext_sub_sext__dominating_sub_nuw_sub_nsw_commuted(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define void @sub_zext_sub_sext__dominating_sub_nuw_sub_nsw_commuted
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_NSW:%.*]] = sub nsw i32 [[ARG1]], [[ARG0]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ARG0_SEXT:%.*]] = sext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_SEXT:%.*]] = sext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_ZEXT:%.*]] = sub i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sub i64 [[ARG0_SEXT]], [[ARG1_SEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NUW]])
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NSW]])
; CHECK-NEXT:    call void @use.i64(i64 [[SUB_ZEXT]])
; CHECK-NEXT:    call void @use.i64(i64 [[SUB_SEXT]])
; CHECK-NEXT:    ret void
;
entry:
  %sub.nuw = sub nuw i32 %arg0, %arg1
  %sub.nsw = sub nsw i32 %arg1, %arg0
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.zext = sub i64 %arg0.zext, %arg1.zext
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nuw)
  call void @use.i32(i32 %sub.nsw)
  call void @use.i64(i64 %sub.zext)
  call void @use.i64(i64 %sub.sext)
  ret void
}

; --------------------------------------------------------------------
; zext x nuw+nsw
; --------------------------------------------------------------------

; Should fold out the add i64
define i64 @add_zext__dominating_add_nuw_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_zext__dominating_add_nuw_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW_NSW:%.*]] = add nuw nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_ZEXT:%.*]] = add i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_ZEXT]]
;
entry:
  %add.nuw.nsw = add nuw nsw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %add.zext = add i64 %arg0.zext, %arg1.zext
  call void @use.i32(i32 %add.nuw.nsw)
  ret i64 %add.zext
}

; Should fold out the add i64
define i64 @add_zext__dominating_add_nuw_nsw_commute(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_zext__dominating_add_nuw_nsw_commute
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW_NSW:%.*]] = add nuw nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[ADD_ZEXT:%.*]] = add i64 [[ARG1_ZEXT]], [[ARG0_ZEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_ZEXT]]
;
entry:
  %add.nuw.nsw = add nuw nsw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %add.zext = add i64 %arg1.zext, %arg0.zext
  call void @use.i32(i32 %add.nuw.nsw)
  ret i64 %add.zext
}

; Should fold out the sub i64
define i64 @sub_zext__dominating_sub_nuw_esw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_zext__dominating_sub_nuw_esw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ARG0_ZEXT:%.*]] = zext i32 [[ARG0]] to i64
; CHECK-NEXT:    [[ARG1_ZEXT:%.*]] = zext i32 [[ARG1]] to i64
; CHECK-NEXT:    [[SUB_ZEXT:%.*]] = sub i64 [[ARG0_ZEXT]], [[ARG1_ZEXT]]
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NUW]])
; CHECK-NEXT:    ret i64 [[SUB_ZEXT]]
;
entry:
  %sub.nuw = sub nuw nsw i32 %arg0, %arg1
  %arg0.zext = zext i32 %arg0 to i64
  %arg1.zext = zext i32 %arg1 to i64
  %sub.zext = sub i64 %arg0.zext, %arg1.zext
  call void @use.i32(i32 %sub.nuw)
  ret i64 %sub.zext
}

; --------------------------------------------------------------------
; sext x nuw+nsw
; --------------------------------------------------------------------

; Should fold out the add i64
define i64 @add_sext__dominating_add_nuw_nsw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nuw_nsw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW_NSW:%.*]] = add nuw nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext i32 [[ADD_NUW_NSW]] to i64
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nuw.nsw = add nuw nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %add.nuw.nsw)
  ret i64 %add.sext
}

; Should fold out the add i64
define i64 @add_sext__dominating_add_nuw_nsw_commute(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @add_sext__dominating_add_nuw_nsw_commute
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_NUW_NSW:%.*]] = add nuw nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[ADD_SEXT:%.*]] = sext i32 [[ADD_NUW_NSW]] to i64
; CHECK-NEXT:    call void @use.i32(i32 [[ADD_NUW_NSW]])
; CHECK-NEXT:    ret i64 [[ADD_SEXT]]
;
entry:
  %add.nuw.nsw = add nuw nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %add.sext = add i64 %arg1.sext, %arg0.sext
  call void @use.i32(i32 %add.nuw.nsw)
  ret i64 %add.sext
}

; Should fold out the sub i64
define i64 @sub_sext__dominating_sub_nuw_esw(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i64 @sub_sext__dominating_sub_nuw_esw
; CHECK-SAME: (i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB_NUW:%.*]] = sub nuw nsw i32 [[ARG0]], [[ARG1]]
; CHECK-NEXT:    [[SUB_SEXT:%.*]] = sext i32 [[SUB_NUW]] to i64
; CHECK-NEXT:    call void @use.i32(i32 [[SUB_NUW]])
; CHECK-NEXT:    ret i64 [[SUB_SEXT]]
;
entry:
  %sub.nuw = sub nuw nsw i32 %arg0, %arg1
  %arg0.sext = sext i32 %arg0 to i64
  %arg1.sext = sext i32 %arg1 to i64
  %sub.sext = sub i64 %arg0.sext, %arg1.sext
  call void @use.i32(i32 %sub.nuw)
  ret i64 %sub.sext
}

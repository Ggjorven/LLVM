; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i32 %arg)
declare void @vec_use(<4 x i32> %arg)

; (x+c1)+c2

define i32 @add_const_add_const(i32 %arg) {
; CHECK-LABEL: @add_const_add_const(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG:%.*]], 10
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = add i32 %arg, 8
  %t1 = add i32 %t0, 2
  ret i32 %t1
}

define i32 @add_const_add_const_extrause(i32 %arg) {
; CHECK-LABEL: @add_const_add_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[ARG:%.*]], 8
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG]], 10
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = add i32 %arg, 8
  call void @use(i32 %t0)
  %t1 = add i32 %t0, 2
  ret i32 %t1
}

define <4 x i32> @vec_add_const_add_const(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_add_const(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 10, i32 10, i32 10, i32 10>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  %t1 = add <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_add_const_add_const_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_add_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 8, i32 8, i32 8, i32 8>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG]], <i32 10, i32 10, i32 10, i32 10>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  call void @vec_use(<4 x i32> %t0)
  %t1 = add <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_add_const_add_const_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_add_const_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 23, i32 undef, i32 undef, i32 10>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 21, i32 undef, i32 8, i32 8>
  %t1 = add <4 x i32> %t0, <i32 2, i32 3, i32 undef, i32 2>
  ret <4 x i32> %t1
}

; (x+c1)-c2

define i32 @add_const_sub_const(i32 %arg) {
; CHECK-LABEL: @add_const_sub_const(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG:%.*]], 6
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = add i32 %arg, 8
  %t1 = sub i32 %t0, 2
  ret i32 %t1
}

define i32 @add_const_sub_const_extrause(i32 %arg) {
; CHECK-LABEL: @add_const_sub_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[ARG:%.*]], 8
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG]], 6
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = add i32 %arg, 8
  call void @use(i32 %t0)
  %t1 = sub i32 %t0, 2
  ret i32 %t1
}

define <4 x i32> @vec_add_const_sub_const(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_sub_const(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 6, i32 6, i32 6, i32 6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  %t1 = sub <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_add_const_sub_const_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_sub_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 8, i32 8, i32 8, i32 8>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG]], <i32 6, i32 6, i32 6, i32 6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  call void @vec_use(<4 x i32> %t0)
  %t1 = sub <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_add_const_sub_const_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_sub_const_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 19, i32 undef, i32 undef, i32 6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 21, i32 undef, i32 8, i32 8>
  %t1 = sub <4 x i32> %t0, <i32 2, i32 3, i32 undef, i32 2>
  ret <4 x i32> %t1
}

; c2-(x+c1)

define i32 @add_const_const_sub(i32 %arg) {
; CHECK-LABEL: @add_const_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = sub i32 -6, [[ARG:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = add i32 %arg, 8
  %t1 = sub i32 2, %t0
  ret i32 %t1
}

define i8 @add_nsw_const_const_sub_nsw(i8 %arg) {
; CHECK-LABEL: @add_nsw_const_const_sub_nsw(
; CHECK-NEXT:    [[T1:%.*]] = sub nsw i8 -128, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add nsw i8 %arg, 1
  %t1 = sub nsw i8 -127, %t0
  ret i8 %t1
}

define i8 @add_nsw_const_const_sub(i8 %arg) {
; CHECK-LABEL: @add_nsw_const_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = sub i8 -128, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add nsw i8 %arg, 1
  %t1 = sub i8 -127, %t0
  ret i8 %t1
}

define i8 @add_const_const_sub_nsw(i8 %arg) {
; CHECK-LABEL: @add_const_const_sub_nsw(
; CHECK-NEXT:    [[T1:%.*]] = sub i8 -128, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add i8 %arg, 1
  %t1 = sub nsw i8 -127, %t0
  ret i8 %t1
}

; 127-X with nsw will be more poisonous than -127-(X+2) with nsw. (see X = -1)
define i8 @add_nsw_const_const_sub_nsw_ov(i8 %arg) {
; CHECK-LABEL: @add_nsw_const_const_sub_nsw_ov(
; CHECK-NEXT:    [[T1:%.*]] = sub i8 127, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add nsw i8 %arg, 2
  %t1 = sub nsw i8 -127, %t0
  ret i8 %t1
}

define i8 @add_nuw_const_const_sub_nuw(i8 %arg) {
; CHECK-LABEL: @add_nuw_const_const_sub_nuw(
; CHECK-NEXT:    [[T1:%.*]] = sub nuw i8 -128, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add nuw i8 %arg, 1
  %t1 = sub nuw i8 -127, %t0
  ret i8 %t1
}

define i8 @add_nuw_const_const_sub(i8 %arg) {
; CHECK-LABEL: @add_nuw_const_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = sub i8 -128, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add nuw i8 %arg, 1
  %t1 = sub i8 -127, %t0
  ret i8 %t1
}

define i8 @add_const_const_sub_nuw(i8 %arg) {
; CHECK-LABEL: @add_const_const_sub_nuw(
; CHECK-NEXT:    [[T1:%.*]] = sub i8 -128, [[ARG:%.*]]
; CHECK-NEXT:    ret i8 [[T1]]
;
  %t0 = add i8 %arg, 1
  %t1 = sub nuw i8 -127, %t0
  ret i8 %t1
}

define <2 x i8> @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1(<2 x i8> %arg) {
; CHECK-LABEL: @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1(
; CHECK-NEXT:    [[T1:%.*]] = sub nsw <2 x i8> <i8 -127, i8 -126>, [[ARG:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[T1]]
;
  %t0 = add nsw <2 x i8> %arg, <i8 2, i8 0>
  %t1 = sub nsw <2 x i8> <i8 -125, i8 -126>, %t0
  ret <2 x i8> %t1
}

define <2 x i8> @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2(<2 x i8> %arg) {
; CHECK-LABEL: @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2(
; CHECK-NEXT:    [[T1:%.*]] = sub nsw <2 x i8> <i8 -126, i8 -128>, [[ARG:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[T1]]
;
  %t0 = add nsw <2 x i8> %arg, <i8 1, i8 2>
  %t1 = sub nsw <2 x i8> <i8 -125, i8 -126>, %t0
  ret <2 x i8> %t1
}

define <2 x i8> @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3(<2 x i8> %arg) {
; CHECK-LABEL: @non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3(
; CHECK-NEXT:    [[T1:%.*]] = sub nsw <2 x i8> <i8 -120, i8 -127>, [[ARG:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[T1]]
;
  %t0 = add nsw <2 x i8> %arg, <i8 0, i8 1>
  %t1 = sub nsw <2 x i8> <i8 -120, i8 -126>, %t0
  ret <2 x i8> %t1
}

; 127-X with nsw will be more poisonous than -127-(X+2) with nsw. (see X = -1)
define <2 x i8> @non_splat_vec_add_nsw_const_const_sub_nsw_ov(<2 x i8> %arg) {
; CHECK-LABEL: @non_splat_vec_add_nsw_const_const_sub_nsw_ov(
; CHECK-NEXT:    [[T1:%.*]] = sub <2 x i8> <i8 -127, i8 127>, [[ARG:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[T1]]
;
  %t0 = add nsw <2 x i8> %arg, <i8 1, i8 2>
  %t1 = sub nsw <2 x i8> <i8 -126, i8 -127>, %t0
  ret <2 x i8> %t1
}


define i32 @add_const_const_sub_extrause(i32 %arg) {
; CHECK-LABEL: @add_const_const_sub_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[ARG:%.*]], 8
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub i32 -6, [[ARG]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = add i32 %arg, 8
  call void @use(i32 %t0)
  %t1 = sub i32 2, %t0
  ret i32 %t1
}

define <4 x i32> @vec_add_const_const_sub(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 -6, i32 -6, i32 -6, i32 -6>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  %t1 = sub <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @vec_add_const_const_sub_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_const_sub_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 8, i32 8, i32 8, i32 8>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 -6, i32 -6, i32 -6, i32 -6>, [[ARG]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  call void @vec_use(<4 x i32> %t0)
  %t1 = sub <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @vec_add_const_const_sub_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_add_const_const_sub_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 -19, i32 undef, i32 undef, i32 -6>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = add <4 x i32> %arg, <i32 21, i32 undef, i32 8, i32 8>
  %t1 = sub <4 x i32> <i32 2, i32 3, i32 undef, i32 2>, %t0
  ret <4 x i32> %t1
}

; (x-c1)+c2

define i32 @sub_const_add_const(i32 %arg) {
; CHECK-LABEL: @sub_const_add_const(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG:%.*]], -6
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 %arg, 8
  %t1 = add i32 %t0, 2
  ret i32 %t1
}

define i32 @sub_const_add_const_extrause(i32 %arg) {
; CHECK-LABEL: @sub_const_add_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[ARG:%.*]], -8
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG]], -6
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 %arg, 8
  call void @use(i32 %t0)
  %t1 = add i32 %t0, 2
  ret i32 %t1
}

define <4 x i32> @vec_sub_const_add_const(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_add_const(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -6, i32 -6, i32 -6, i32 -6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  %t1 = add <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_sub_const_add_const_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_add_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -8, i32 -8, i32 -8, i32 -8>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG]], <i32 -6, i32 -6, i32 -6, i32 -6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  call void @vec_use(<4 x i32> %t0)
  %t1 = add <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_sub_const_add_const_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_add_const_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -19, i32 undef, i32 undef, i32 -6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 21, i32 undef, i32 8, i32 8>
  %t1 = add <4 x i32> %t0, <i32 2, i32 3, i32 undef, i32 2>
  ret <4 x i32> %t1
}

; (x-c1)-c2

define i32 @sub_const_sub_const(i32 %arg) {
; CHECK-LABEL: @sub_const_sub_const(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG:%.*]], -10
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 %arg, 8
  %t1 = sub i32 %t0, 2
  ret i32 %t1
}

define i32 @sub_const_sub_const_extrause(i32 %arg) {
; CHECK-LABEL: @sub_const_sub_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[ARG:%.*]], -8
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG]], -10
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 %arg, 8
  call void @use(i32 %t0)
  %t1 = sub i32 %t0, 2
  ret i32 %t1
}

define <4 x i32> @vec_sub_const_sub_const(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_sub_const(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -10, i32 -10, i32 -10, i32 -10>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  %t1 = sub <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_sub_const_sub_const_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_sub_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -8, i32 -8, i32 -8, i32 -8>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG]], <i32 -10, i32 -10, i32 -10, i32 -10>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  call void @vec_use(<4 x i32> %t0)
  %t1 = sub <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_sub_const_sub_const_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_sub_const_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -23, i32 undef, i32 undef, i32 -10>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 21, i32 undef, i32 8, i32 8>
  %t1 = sub <4 x i32> %t0, <i32 2, i32 3, i32 undef, i32 2>
  ret <4 x i32> %t1
}

; c2-(x-c1)

define i32 @sub_const_const_sub(i32 %arg) {
; CHECK-LABEL: @sub_const_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = sub i32 10, [[ARG:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 %arg, 8
  %t1 = sub i32 2, %t0
  ret i32 %t1
}

define i32 @sub_const_const_sub_extrause(i32 %arg) {
; CHECK-LABEL: @sub_const_const_sub_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[ARG:%.*]], -8
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub i32 10, [[ARG]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 %arg, 8
  call void @use(i32 %t0)
  %t1 = sub i32 2, %t0
  ret i32 %t1
}

define <4 x i32> @vec_sub_const_const_sub(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 10, i32 10, i32 10, i32 10>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  %t1 = sub <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @vec_sub_const_const_sub_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_const_sub_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -8, i32 -8, i32 -8, i32 -8>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 10, i32 10, i32 10, i32 10>, [[ARG]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 8, i32 8, i32 8, i32 8>
  call void @vec_use(<4 x i32> %t0)
  %t1 = sub <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @vec_sub_const_const_sub_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_sub_const_const_sub_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 23, i32 undef, i32 undef, i32 10>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> %arg, <i32 21, i32 undef, i32 8, i32 8>
  %t1 = sub <4 x i32> <i32 2, i32 3, i32 undef, i32 2>, %t0
  ret <4 x i32> %t1
}

; (c1-x)+c2

define i32 @const_sub_add_const(i32 %arg) {
; CHECK-LABEL: @const_sub_add_const(
; CHECK-NEXT:    [[T1:%.*]] = sub i32 10, [[ARG:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 8, %arg
  %t1 = add i32 %t0, 2
  ret i32 %t1
}

define i32 @const_sub_add_const_extrause(i32 %arg) {
; CHECK-LABEL: @const_sub_add_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = sub i32 8, [[ARG:%.*]]
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub i32 10, [[ARG]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 8, %arg
  call void @use(i32 %t0)
  %t1 = add i32 %t0, 2
  ret i32 %t1
}

define <4 x i32> @vec_const_sub_add_const(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_add_const(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 10, i32 10, i32 10, i32 10>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, %arg
  %t1 = add <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_const_sub_add_const_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_add_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, [[ARG:%.*]]
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 10, i32 10, i32 10, i32 10>, [[ARG]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, %arg
  call void @vec_use(<4 x i32> %t0)
  %t1 = add <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_const_sub_add_const_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_add_const_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 23, i32 undef, i32 undef, i32 10>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 21, i32 undef, i32 8, i32 8>, %arg
  %t1 = add <4 x i32> %t0, <i32 2, i32 3, i32 undef, i32 2>
  ret <4 x i32> %t1
}

; (c1-x)-c2

define i32 @const_sub_sub_const(i32 %arg) {
; CHECK-LABEL: @const_sub_sub_const(
; CHECK-NEXT:    [[T1:%.*]] = sub i32 6, [[ARG:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 8, %arg
  %t1 = sub i32 %t0, 2
  ret i32 %t1
}

define i32 @const_sub_sub_const_extrause(i32 %arg) {
; CHECK-LABEL: @const_sub_sub_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = sub i32 8, [[ARG:%.*]]
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub i32 6, [[ARG]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 8, %arg
  call void @use(i32 %t0)
  %t1 = sub i32 %t0, 2
  ret i32 %t1
}

define <4 x i32> @vec_const_sub_sub_const(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_sub_const(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 6, i32 6, i32 6, i32 6>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, %arg
  %t1 = sub <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_const_sub_sub_const_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_sub_const_extrause(
; CHECK-NEXT:    [[T0:%.*]] = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, [[ARG:%.*]]
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 6, i32 6, i32 6, i32 6>, [[ARG]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, %arg
  call void @vec_use(<4 x i32> %t0)
  %t1 = sub <4 x i32> %t0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %t1
}

define <4 x i32> @vec_const_sub_sub_const_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_sub_const_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = sub <4 x i32> <i32 19, i32 undef, i32 undef, i32 6>, [[ARG:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 21, i32 undef, i32 8, i32 8>, %arg
  %t1 = sub <4 x i32> %t0, <i32 2, i32 3, i32 undef, i32 2>
  ret <4 x i32> %t1
}

; c2-(c1-x)
; FIXME

define i32 @const_sub_const_sub(i32 %arg) {
; CHECK-LABEL: @const_sub_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG:%.*]], -6
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 8, %arg
  %t1 = sub i32 2, %t0
  ret i32 %t1
}

define i32 @const_sub_const_sub_extrause(i32 %arg) {
; CHECK-LABEL: @const_sub_const_sub_extrause(
; CHECK-NEXT:    [[T0:%.*]] = sub i32 8, [[ARG:%.*]]
; CHECK-NEXT:    call void @use(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[ARG]], -6
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 8, %arg
  call void @use(i32 %t0)
  %t1 = sub i32 2, %t0
  ret i32 %t1
}

define <4 x i32> @vec_const_sub_const_sub(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_const_sub(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -6, i32 -6, i32 -6, i32 -6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, %arg
  %t1 = sub <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @vec_const_sub_const_sub_extrause(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_const_sub_extrause(
; CHECK-NEXT:    [[T0:%.*]] = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, [[ARG:%.*]]
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG]], <i32 -6, i32 -6, i32 -6, i32 -6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 8, i32 8, i32 8, i32 8>, %arg
  call void @vec_use(<4 x i32> %t0)
  %t1 = sub <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @vec_const_sub_const_sub_nonsplat(<4 x i32> %arg) {
; CHECK-LABEL: @vec_const_sub_const_sub_nonsplat(
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[ARG:%.*]], <i32 -19, i32 undef, i32 undef, i32 -6>
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = sub <4 x i32> <i32 21, i32 undef, i32 8, i32 8>, %arg
  %t1 = sub <4 x i32> <i32 2, i32 3, i32 undef, i32 2>, %t0
  ret <4 x i32> %t1
}

define i7 @addsub_combine_constants(i7 %x, i7 %y) {
; CHECK-LABEL: @addsub_combine_constants(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i7 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[A2:%.*]] = add i7 [[TMP1]], 52
; CHECK-NEXT:    ret i7 [[A2]]
;
  %a1 = add i7 %x, 42
  %s = sub i7 10, %y
  %a2 = add nsw i7 %a1, %s
  ret i7 %a2
}

define <4 x i32> @addsub_combine_constants_use1(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @addsub_combine_constants_use1(
; CHECK-NEXT:    [[A1:%.*]] = add <4 x i32> [[X:%.*]], <i32 42, i32 -7, i32 0, i32 -1>
; CHECK-NEXT:    call void @vec_use(<4 x i32> [[A1]])
; CHECK-NEXT:    [[TMP1:%.*]] = sub <4 x i32> [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[A2:%.*]] = add <4 x i32> [[TMP1]], <i32 -58, i32 -6, i32 -1, i32 41>
; CHECK-NEXT:    ret <4 x i32> [[A2]]
;
  %a1 = add <4 x i32> %x, <i32 42, i32 -7, i32 0, i32 -1>
  call void @vec_use(<4 x i32> %a1)
  %s = sub <4 x i32> <i32 -100, i32 1, i32 -1, i32 42>, %y
  %a2 = add nuw <4 x i32> %s, %a1
  ret <4 x i32> %a2
}

define i32 @addsub_combine_constants_use2(i32 %x, i32 %y) {
; CHECK-LABEL: @addsub_combine_constants_use2(
; CHECK-NEXT:    [[S:%.*]] = sub i32 100, [[Y:%.*]]
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[A2:%.*]] = add i32 [[TMP1]], 142
; CHECK-NEXT:    ret i32 [[A2]]
;
  %a1 = add i32 %x, 42
  %s = sub i32 100, %y
  call void @use(i32 %s)
  %a2 = add i32 %a1, %s
  ret i32 %a2
}

; negative test - too many uses

define i32 @addsub_combine_constants_use3(i32 %x, i32 %y) {
; CHECK-LABEL: @addsub_combine_constants_use3(
; CHECK-NEXT:    [[A1:%.*]] = add i32 [[X:%.*]], 42
; CHECK-NEXT:    call void @use(i32 [[A1]])
; CHECK-NEXT:    [[S:%.*]] = sub i32 100, [[Y:%.*]]
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[A2:%.*]] = add i32 [[A1]], [[S]]
; CHECK-NEXT:    ret i32 [[A2]]
;
  %a1 = add i32 %x, 42
  call void @use(i32 %a1)
  %s = sub i32 100, %y
  call void @use(i32 %s)
  %a2 = add i32 %a1, %s
  ret i32 %a2
}

define i5 @sub_from_constant(i5 %x, i5 %y) {
; CHECK-LABEL: @sub_from_constant(
; CHECK-NEXT:    [[REASS_SUB:%.*]] = sub i5 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = add i5 [[REASS_SUB]], 10
; CHECK-NEXT:    ret i5 [[R]]
;
  %sub = sub i5 10, %x
  %r = add i5 %sub, %y
  ret i5 %r
}

define i5 @sub_from_constant_commute(i5 %x, i5 %p) {
; CHECK-LABEL: @sub_from_constant_commute(
; CHECK-NEXT:    [[Y:%.*]] = mul i5 [[P:%.*]], [[P]]
; CHECK-NEXT:    [[REASS_SUB:%.*]] = sub i5 [[Y]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = add i5 [[REASS_SUB]], 10
; CHECK-NEXT:    ret i5 [[R]]
;
  %y = mul i5 %p, %p  ; thwart complexity-based canonicalization
  %sub = sub nsw i5 10, %x
  %r = add nsw i5 %y, %sub
  ret i5 %r
}

define <2 x i8> @sub_from_constant_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @sub_from_constant_vec(
; CHECK-NEXT:    [[REASS_SUB:%.*]] = sub <2 x i8> [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = add <2 x i8> [[REASS_SUB]], <i8 2, i8 -42>
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %sub = sub nuw <2 x i8> <i8 2, i8 -42>, %x
  %r = add nuw <2 x i8> %sub, %y
  ret <2 x i8> %r
}

; negative test - don't create extra instructions

define i8 @sub_from_constant_extra_use(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_from_constant_extra_use(
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 1, [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[SUB]])
; CHECK-NEXT:    [[R:%.*]] = add i8 [[SUB]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sub = sub i8 1, %x
  call void @use(i8 %sub)
  %r = add i8 %sub, %y
  ret i8 %r
}

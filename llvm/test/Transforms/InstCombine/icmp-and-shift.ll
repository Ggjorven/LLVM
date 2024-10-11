; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i8)

define i32 @icmp_eq_and_pow2_shl1(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl1(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP0:%.*]], 4
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 1, %0
  %and = and i32 %shl, 16
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_eq_and_pow2_shl1_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl1_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne <2 x i32> [[TMP0:%.*]], <i32 4, i32 4>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 1, i32 1>, %0
  %and = and <2 x i32> %shl, <i32 16, i32 16>
  %cmp = icmp eq <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_ne_and_pow2_shl1(i32 %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_shl1(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP0:%.*]], 4
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 1, %0
  %and = and i32 %shl, 16
  %cmp = icmp ne i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_ne_and_pow2_shl1_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_shl1_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq <2 x i32> [[TMP0:%.*]], <i32 4, i32 4>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 1, i32 1>, %0
  %and = and <2 x i32> %shl, <i32 16, i32 16>
  %cmp = icmp ne <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_eq_and_pow2_shl_pow2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl_pow2(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP0:%.*]], 3
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 2, %0
  %and = and i32 %shl, 16
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_eq_and_pow2_shl_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl_pow2_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne <2 x i32> [[TMP0:%.*]], <i32 2, i32 2>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 4, i32 4>, %0
  %and = and <2 x i32> %shl, <i32 16, i32 16>
  %cmp = icmp eq <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_ne_and_pow2_shl_pow2(i32 %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_shl_pow2(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP0:%.*]], 3
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 2, %0
  %and = and i32 %shl, 16
  %cmp = icmp ne i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_ne_and_pow2_shl_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_shl_pow2_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq <2 x i32> [[TMP0:%.*]], <i32 2, i32 2>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 4, i32 4>, %0
  %and = and <2 x i32> %shl, <i32 16, i32 16>
  %cmp = icmp ne <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_eq_and_pow2_shl_pow2_negative1(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl_pow2_negative1(
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 11, [[TMP0:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = lshr i32 [[SHL]], 4
; CHECK-NEXT:    [[AND_LOBIT:%.*]] = and i32 [[AND]], 1
; CHECK-NEXT:    [[CONV:%.*]] = xor i32 [[AND_LOBIT]], 1
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 11, %0
  %and = and i32 %shl, 16
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp_eq_and_pow2_shl_pow2_negative2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl_pow2_negative2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP0:%.*]], 2
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 2, %0
  %and = and i32 %shl, 14
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp_eq_and_pow2_shl_pow2_negative3(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_shl_pow2_negative3(
; CHECK-NEXT:    ret i32 1
;
  %shl = shl i32 32, %0
  %and = and i32 %shl, 16
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define i32 @icmp_eq_and_pow2_minus1_shl1(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_minus1_shl1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP0:%.*]], 3
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 1, %0
  %and = and i32 %shl, 15
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_eq_and_pow2_minus1_shl1_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_minus1_shl1_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt <2 x i32> [[TMP0:%.*]], <i32 3, i32 3>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[CMP]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 1, i32 1>, %0
  %and = and <2 x i32> %shl, <i32 15, i32 15>
  %cmp = icmp eq <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_ne_and_pow2_minus1_shl1(i32 %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_minus1_shl1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[TMP0:%.*]], 4
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 1, %0
  %and = and i32 %shl, 15
  %cmp = icmp ne i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_ne_and_pow2_minus1_shl1_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_minus1_shl1_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult <2 x i32> [[TMP0:%.*]], <i32 4, i32 4>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[CMP]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 1, i32 1>, %0
  %and = and <2 x i32> %shl, <i32 15, i32 15>
  %cmp = icmp ne <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_eq_and_pow2_minus1_shl_pow2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_minus1_shl_pow2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP0:%.*]], 2
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 2, %0
  %and = and i32 %shl, 15
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_eq_and_pow2_minus1_shl_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_minus1_shl_pow2_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt <2 x i32> [[TMP0:%.*]], <i32 1, i32 1>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[CMP]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 4, i32 4>, %0
  %and = and <2 x i32> %shl, <i32 15, i32 15>
  %cmp = icmp eq <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_ne_and_pow2_minus1_shl_pow2(i32 %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_minus1_shl_pow2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[TMP0:%.*]], 3
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 2, %0
  %and = and i32 %shl, 15
  %cmp = icmp ne i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_ne_and_pow2_minus1_shl_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_minus1_shl_pow2_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult <2 x i32> [[TMP0:%.*]], <i32 2, i32 2>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[CMP]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %shl = shl <2 x i32> <i32 4, i32 4>, %0
  %and = and <2 x i32> %shl, <i32 15, i32 15>
  %cmp = icmp ne <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_eq_and_pow2_minus1_shl1_negative1(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_minus1_shl1_negative1(
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 3, [[TMP0:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[SHL]], 15
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 0
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %shl = shl i32 3, %0
  %and = and i32 %shl, 15
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp_eq_and_pow2_minus1_shl1_negative2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_minus1_shl1_negative2(
; CHECK-NEXT:    ret i32 1
;
  %shl = shl i32 32, %0
  %and = and i32 %shl, 15
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define i32 @icmp_eq_and1_lshr_pow2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and1_lshr_pow2(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP0:%.*]], 3
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %lshr = lshr i32 8, %0
  %and  = and i32 %lshr, 1
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_eq_and1_lshr_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_eq_and1_lshr_pow2_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne <2 x i32> [[TMP0:%.*]], <i32 3, i32 3>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %lshr = lshr <2 x i32> <i32 8, i32 8>, %0
  %and  = and <2 x i32> %lshr, <i32 1, i32 1>
  %cmp  = icmp eq <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_ne_and1_lshr_pow2(i32 %0) {
; CHECK-LABEL: @icmp_ne_and1_lshr_pow2(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP0:%.*]], 3
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %lshr = lshr i32 8, %0
  %and  = and i32 %lshr, 1
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_ne_and1_lshr_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_ne_and1_lshr_pow2_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq <2 x i32> [[TMP0:%.*]], <i32 1, i32 1>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %lshr = lshr <2 x i32> <i32 8, i32 8>, %0
  %and  = and <2 x i32> %lshr, <i32 4, i32 4>
  %cmp  = icmp ne <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_eq_and_pow2_lshr_pow2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_lshr_pow2(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP0:%.*]], 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %lshr = lshr i32 8, %0
  %and  = and i32 %lshr, 4
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp_eq_and_pow2_lshr_pow2_case2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_lshr_pow2_case2(
; CHECK-NEXT:    ret i32 1
;
  %lshr = lshr i32 4, %0
  %and  = and i32 %lshr, 8
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_eq_and_pow2_lshr_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_eq_and_pow2_lshr_pow2_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne <2 x i32> [[TMP0:%.*]], <i32 1, i32 1>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %lshr = lshr <2 x i32> <i32 8, i32 8>, %0
  %and  = and <2 x i32> %lshr, <i32 4, i32 4>
  %cmp  = icmp eq <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_ne_and_pow2_lshr_pow2(i32 %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_lshr_pow2(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP0:%.*]], 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %lshr = lshr i32 8, %0
  %and  = and i32 %lshr, 4
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp_ne_and_pow2_lshr_pow2_case2(i32 %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_lshr_pow2_case2(
; CHECK-NEXT:    ret i32 1
;
  %lshr = lshr i32 4, %0
  %and  = and i32 %lshr, 8
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define <2 x i32> @icmp_ne_and_pow2_lshr_pow2_vec(<2 x i32> %0) {
; CHECK-LABEL: @icmp_ne_and_pow2_lshr_pow2_vec(
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq <2 x i32> [[TMP0:%.*]], <i32 1, i32 1>
; CHECK-NEXT:    [[CONV:%.*]] = zext <2 x i1> [[TMP2]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[CONV]]
;
  %lshr = lshr <2 x i32> <i32 8, i32 8>, %0
  %and  = and <2 x i32> %lshr, <i32 4, i32 4>
  %cmp  = icmp ne <2 x i32> %and, <i32 0, i32 0>
  %conv = zext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %conv
}

define i32 @icmp_eq_and1_lshr_pow2_minus_one(i32 %0) {
; CHECK-LABEL: @icmp_eq_and1_lshr_pow2_minus_one(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP0:%.*]], 2
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %lshr = lshr i32 7, %0
  %and  = and i32 %lshr, 1
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp_eq_and1_lshr_pow2_negative2(i32 %0) {
; CHECK-LABEL: @icmp_eq_and1_lshr_pow2_negative2(
; CHECK-NEXT:    [[LSHR:%.*]] = lshr i32 8, [[TMP0:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[LSHR]], 3
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 0
; CHECK-NEXT:    [[CONV:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
  %lshr = lshr i32 8, %0
  %and  = and i32 %lshr, 3
  %cmp  = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i1 @eq_and_shl_one(i8 %x, i8 %y) {
; CHECK-LABEL: @eq_and_shl_one(
; CHECK-NEXT:    [[POW2:%.*]] = shl nuw i8 1, [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[POW2]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %pow2 = shl i8 1, %y
  %and = and i8 %pow2, %x
  %cmp = icmp eq i8 %and, %pow2
  ret i1 %cmp
}

define <2 x i1> @ne_and_shl_one_commute(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @ne_and_shl_one_commute(
; CHECK-NEXT:    [[POW2:%.*]] = shl nuw <2 x i8> <i8 1, i8 poison>, [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i8> [[POW2]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[AND]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %pow2 = shl <2 x i8> <i8 1, i8 poison>, %y
  %and = and <2 x i8> %pow2, %x
  %cmp = icmp ne <2 x i8> %pow2, %and
  ret <2 x i1> %cmp
}

define i1 @ne_and_lshr_minval(i8 %px, i8 %y) {
; CHECK-LABEL: @ne_and_lshr_minval(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[POW2:%.*]] = lshr exact i8 -128, [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[X]], [[POW2]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x = mul i8 %px, %px ; thwart complexity-based canonicalization
  %pow2 = lshr i8 -128, %y
  %and = and i8 %x, %pow2
  %cmp = icmp ne i8 %and, %pow2
  ret i1 %cmp
}

define i1 @eq_and_lshr_minval_commute(i8 %px, i8 %y) {
; CHECK-LABEL: @eq_and_lshr_minval_commute(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[POW2:%.*]] = lshr exact i8 -128, [[Y:%.*]]
; CHECK-NEXT:    call void @use(i8 [[POW2]])
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[X]], [[POW2]]
; CHECK-NEXT:    call void @use(i8 [[AND]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x = mul i8 %px, %px ; thwart complexity-based canonicalization
  %pow2 = lshr i8 -128, %y
  call void @use(i8 %pow2)
  %and = and i8 %x, %pow2
  call void @use(i8 %and)
  %cmp = icmp eq i8 %pow2, %and
  ret i1 %cmp
}

; Negative test: May be power of two or zero.
define i1 @eq_and_shl_two(i8 %x, i8 %y) {
; CHECK-LABEL: @eq_and_shl_two(
; CHECK-NEXT:    [[POW2_OR_ZERO:%.*]] = shl i8 2, [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[X:%.*]], [[POW2_OR_ZERO]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[AND]], [[POW2_OR_ZERO]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %pow2_or_zero = shl i8 2, %y
  %and = and i8 %x, %pow2_or_zero
  %cmp = icmp eq i8 %and, %pow2_or_zero
  ret i1 %cmp
}

; Negative test: Wrong predicate.
define i1 @slt_and_shl_one(i8 %x, i8 %y) {
; CHECK-LABEL: @slt_and_shl_one(
; CHECK-NEXT:    [[POW2:%.*]] = shl nuw i8 1, [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[X:%.*]], [[POW2]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[AND]], [[POW2]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %pow2 = shl i8 1, %y
  %and = and i8 %x, %pow2
  %cmp = icmp slt i8 %and, %pow2
  ret i1 %cmp
}

define i1 @fold_eq_lhs(i8 %x, i8 %y) {
; CHECK-LABEL: @fold_eq_lhs(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i8 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 -1, %x
  %and = and i8 %shl, %y
  %r = icmp eq i8 %and, 0
  ret i1 %r
}

define i1 @fold_eq_lhs_fail_eq_nonzero(i8 %x, i8 %y) {
; CHECK-LABEL: @fold_eq_lhs_fail_eq_nonzero(
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i8 -1, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[SHL]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[AND]], 1
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 -1, %x
  %and = and i8 %shl, %y
  %r = icmp eq i8 %and, 1
  ret i1 %r
}

define i1 @fold_eq_lhs_fail_multiuse_shl(i8 %x, i8 %y) {
; CHECK-LABEL: @fold_eq_lhs_fail_multiuse_shl(
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i8 -1, [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[SHL]])
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[SHL]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %shl = shl i8 -1, %x
  call void @use(i8 %shl)
  %and = and i8 %shl, %y
  %r = icmp eq i8 %and, 0
  ret i1 %r
}

define i1 @fold_ne_rhs(i8 %x, i8 %yy) {
; CHECK-LABEL: @fold_ne_rhs(
; CHECK-NEXT:    [[Y:%.*]] = xor i8 [[YY:%.*]], 123
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i8 [[Y]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = xor i8 %yy, 123
  %shl = shl i8 -1, %x
  %and = and i8 %y, %shl
  %r = icmp ne i8 %and, 0
  ret i1 %r
}

define i1 @fold_ne_rhs_fail_multiuse_and(i8 %x, i8 %yy) {
; CHECK-LABEL: @fold_ne_rhs_fail_multiuse_and(
; CHECK-NEXT:    [[Y:%.*]] = xor i8 [[YY:%.*]], 123
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i8 -1, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[Y]], [[SHL]]
; CHECK-NEXT:    call void @use(i8 [[AND]])
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = xor i8 %yy, 123
  %shl = shl i8 -1, %x
  %and = and i8 %y, %shl
  call void @use(i8 %and)
  %r = icmp ne i8 %and, 0
  ret i1 %r
}

define i1 @fold_ne_rhs_fail_shift_not_1s(i8 %x, i8 %yy) {
; CHECK-LABEL: @fold_ne_rhs_fail_shift_not_1s(
; CHECK-NEXT:    [[Y:%.*]] = xor i8 [[YY:%.*]], 122
; CHECK-NEXT:    [[SHL:%.*]] = shl i8 -2, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[Y]], [[SHL]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = xor i8 %yy, 123
  %shl = shl i8 -2, %x
  %and = and i8 %y, %shl
  %r = icmp ne i8 %and, 0
  ret i1 %r
}

define i1 @test_shr_and_1_ne_0(i32 %a, i32 %b) {
; CHECK-LABEL: @test_shr_and_1_ne_0(
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw i32 1, [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[A:%.*]], [[TMP1]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i32 %a, %b
  %and = and i32 %shr, 1
  %cmp = icmp ne i32 %and, 0
  ret i1 %cmp
}

define i1 @test_const_shr_and_1_ne_0(i32 %b) {
; CHECK-LABEL: @test_const_shr_and_1_ne_0(
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw i32 1, [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 42
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i32 42, %b
  %and = and i32 %shr, 1
  %cmp = icmp ne i32 %and, 0
  ret i1 %cmp
}

define i1 @test_not_const_shr_and_1_ne_0(i32 %b) {
; CHECK-LABEL: @test_not_const_shr_and_1_ne_0(
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw i32 1, [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 42
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i32 42, %b
  %and = and i32 %shr, 1
  %cmp = icmp eq i32 %and, 0
  ret i1 %cmp
}

define i1 @test_const_shr_exact_and_1_ne_0(i32 %b) {
; CHECK-LABEL: @test_const_shr_exact_and_1_ne_0(
; CHECK-NEXT:    [[TMP1:%.*]] = shl nuw i32 1, [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 42
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i32 42, %b
  %and = and i32 %shr, 1
  %cmp = icmp ne i32 %and, 0
  ret i1 %cmp
}

define i1 @test_const_shr_and_2_ne_0_negative(i32 %b) {
; CHECK-LABEL: @test_const_shr_and_2_ne_0_negative(
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 42, [[B:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[SHR]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i32 42, %b
  %and = and i32 %shr, 2
  %cmp = icmp eq i32 %and, 0
  ret i1 %cmp
}

define <8 x i1> @test_const_shr_and_1_ne_0_v8i8_splat_negative(<8 x i8> %b) {
; CHECK-LABEL: @test_const_shr_and_1_ne_0_v8i8_splat_negative(
; CHECK-NEXT:    [[SHR:%.*]] = lshr <8 x i8> <i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42>, [[B:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = trunc <8 x i8> [[SHR]] to <8 x i1>
; CHECK-NEXT:    ret <8 x i1> [[CMP]]
;
  %shr = lshr <8 x i8> <i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42, i8 42>, %b
  %and = and <8 x i8> %shr, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %cmp = icmp ne <8 x i8> %and, zeroinitializer
  ret <8 x i1> %cmp
}

define <8 x i1> @test_const_shr_and_1_ne_0_v8i8_nonsplat_negative(<8 x i8> %b) {
; CHECK-LABEL: @test_const_shr_and_1_ne_0_v8i8_nonsplat_negative(
; CHECK-NEXT:    [[SHR:%.*]] = lshr <8 x i8> <i8 42, i8 43, i8 44, i8 45, i8 46, i8 47, i8 48, i8 49>, [[B:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = trunc <8 x i8> [[SHR]] to <8 x i1>
; CHECK-NEXT:    ret <8 x i1> [[CMP]]
;
  %shr = lshr <8 x i8> <i8 42, i8 43, i8 44, i8 45, i8 46, i8 47, i8 48, i8 49>, %b
  %and = and <8 x i8> %shr, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %cmp = icmp ne <8 x i8> %and, zeroinitializer
  ret <8 x i1> %cmp
}

define i1 @test_const_shr_and_1_ne_0_i1_negative(i1 %b) {
; CHECK-LABEL: @test_const_shr_and_1_ne_0_i1_negative(
; CHECK-NEXT:    ret i1 true
;
  %shr = lshr i1 1, %b
  %and = and i1 %shr, 1
  %cmp = icmp ne i1 %and, 0
  ret i1 %cmp
}

define i1 @test_const_shr_and_1_ne_0_multi_use_lshr_negative(i32 %b) {
; CHECK-LABEL: @test_const_shr_and_1_ne_0_multi_use_lshr_negative(
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 42, [[B:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[SHR]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ne i32 [[AND]], 0
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[B]], [[SHR]]
; CHECK-NEXT:    [[RET:%.*]] = and i1 [[CMP1]], [[CMP2]]
; CHECK-NEXT:    ret i1 [[RET]]
;
  %shr = lshr i32 42, %b
  %and = and i32 %shr, 1
  %cmp1 = icmp ne i32 %and, 0
  %cmp2 = icmp eq i32 %b, %shr
  %ret = and i1 %cmp1, %cmp2
  ret i1 %ret
}

define i1 @test_const_shr_and_1_ne_0_multi_use_and_negative(i32 %b) {
; CHECK-LABEL: @test_const_shr_and_1_ne_0_multi_use_and_negative(
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 42, [[B:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[SHR]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ne i32 [[AND]], 0
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[B]], [[AND]]
; CHECK-NEXT:    [[RET:%.*]] = and i1 [[CMP1]], [[CMP2]]
; CHECK-NEXT:    ret i1 [[RET]]
;
  %shr = lshr i32 42, %b
  %and = and i32 %shr, 1
  %cmp1 = icmp ne i32 %and, 0
  %cmp2 = icmp eq i32 %b, %and
  %ret = and i1 %cmp1, %cmp2
  ret i1 %ret
}

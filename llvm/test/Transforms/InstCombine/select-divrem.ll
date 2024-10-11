; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; It is a miscompile in most of these tests if we
; execute div/rem without freezing the potentially
; poison condition value.

define i5 @sdiv_common_divisor(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @sdiv_common_divisor(
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i1 [[B:%.*]]
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[TMP1]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = sdiv i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = sdiv i5 %y, %x
  %r2 = sdiv i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @srem_common_divisor(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @srem_common_divisor(
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i1 [[B:%.*]]
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[TMP1]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = srem i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = srem i5 %y, %x
  %r2 = srem i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

; This is ok without freeze because UB can only happen with x==0,
; and that occurs in the original code.

define i5 @udiv_common_divisor(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @udiv_common_divisor(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = udiv i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = udiv i5 %y, %x
  %r2 = udiv i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

; This is ok without freeze because UB can only happen with x==0,
; and that occurs in the original code.

define i5 @urem_common_divisor(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @urem_common_divisor(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = urem i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = urem i5 %y, %x
  %r2 = urem i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @sdiv_common_dividend(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @sdiv_common_dividend(
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i1 [[B:%.*]]
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[TMP1]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = sdiv i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = sdiv i5 %x, %y
  %r2 = sdiv i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @srem_common_dividend(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @srem_common_dividend(
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i1 [[B:%.*]]
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[TMP1]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = srem i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = srem i5 %x, %y
  %r2 = srem i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @udiv_common_dividend(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @udiv_common_dividend(
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i1 [[B:%.*]]
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[TMP1]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = udiv i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = udiv i5 %x, %y
  %r2 = udiv i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @urem_common_dividend(i1 %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @urem_common_dividend(
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i1 [[B:%.*]]
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[TMP1]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = urem i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = urem i5 %x, %y
  %r2 = urem i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

; Repeat the above tests, but guarantee that the select
; condition is not poison via argument attribute. That
; makes it safe to execute the select before div/rem
; without needing to freeze the condition.

define i5 @sdiv_common_divisor_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @sdiv_common_divisor_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = sdiv i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = sdiv i5 %y, %x
  %r2 = sdiv i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @srem_common_divisor_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @srem_common_divisor_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = srem i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = srem i5 %y, %x
  %r2 = srem i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @udiv_common_divisor_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @udiv_common_divisor_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = udiv i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = udiv i5 %y, %x
  %r2 = udiv i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @urem_common_divisor_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @urem_common_divisor_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = urem i5 [[SEL_V]], [[X:%.*]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = urem i5 %y, %x
  %r2 = urem i5 %z, %x
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @sdiv_common_dividend_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @sdiv_common_dividend_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = sdiv i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = sdiv i5 %x, %y
  %r2 = sdiv i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @srem_common_dividend_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @srem_common_dividend_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = srem i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = srem i5 %x, %y
  %r2 = srem i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @udiv_common_dividend_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @udiv_common_dividend_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = udiv i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = udiv i5 %x, %y
  %r2 = udiv i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i5 @urem_common_dividend_defined_cond(i1 noundef %b, i5 %x, i5 %y, i5 %z) {
; CHECK-LABEL: @urem_common_dividend_defined_cond(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[B:%.*]], i5 [[Z:%.*]], i5 [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = urem i5 [[X:%.*]], [[SEL_V]]
; CHECK-NEXT:    ret i5 [[SEL]]
;
  %r1 = urem i5 %x, %y
  %r2 = urem i5 %x, %z
  %sel = select i1 %b, i5 %r2, i5 %r1
  ret i5 %sel
}

define i32 @rem_euclid_1(i32 %0) {
; CHECK-LABEL: @rem_euclid_1(
; CHECK-NEXT:    [[SEL:%.*]] = and i32 [[TMP0:%.*]], 7
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %rem = srem i32 %0, 8
  %cond = icmp slt i32 %rem, 0
  %add = add i32 %rem, 8
  %sel = select i1 %cond, i32 %add, i32 %rem
  ret i32 %sel
}

define i32 @rem_euclid_2(i32 %0) {
; CHECK-LABEL: @rem_euclid_2(
; CHECK-NEXT:    [[SEL:%.*]] = and i32 [[TMP0:%.*]], 7
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %rem = srem i32 %0, 8
  %cond = icmp sgt i32 %rem, -1
  %add = add i32 %rem, 8
  %sel = select i1 %cond, i32 %rem, i32 %add
  ret i32 %sel
}

define i32 @rem_euclid_wrong_sign_test(i32 %0) {
; CHECK-LABEL: @rem_euclid_wrong_sign_test(
; CHECK-NEXT:    [[REM:%.*]] = srem i32 [[TMP0:%.*]], 8
; CHECK-NEXT:    [[COND:%.*]] = icmp sgt i32 [[REM]], 0
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[REM]], 8
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[COND]], i32 [[ADD]], i32 [[REM]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %rem = srem i32 %0, 8
  %cond = icmp sgt i32 %rem, 0
  %add = add i32 %rem, 8
  %sel = select i1 %cond, i32 %add, i32 %rem
  ret i32 %sel
}

define i32 @rem_euclid_add_different_const(i32 %0) {
; CHECK-LABEL: @rem_euclid_add_different_const(
; CHECK-NEXT:    [[REM:%.*]] = srem i32 [[TMP0:%.*]], 8
; CHECK-NEXT:    [[COND:%.*]] = icmp slt i32 [[REM]], 0
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[REM]], 9
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[COND]], i32 [[ADD]], i32 [[REM]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %rem = srem i32 %0, 8
  %cond = icmp slt i32 %rem, 0
  %add = add i32 %rem, 9
  %sel = select i1 %cond, i32 %add, i32 %rem
  ret i32 %sel
}

define i32 @rem_euclid_wrong_operands_select(i32 %0) {
; CHECK-LABEL: @rem_euclid_wrong_operands_select(
; CHECK-NEXT:    [[REM:%.*]] = srem i32 [[TMP0:%.*]], 8
; CHECK-NEXT:    [[COND:%.*]] = icmp slt i32 [[REM]], 0
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[REM]], 8
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[COND]], i32 [[REM]], i32 [[ADD]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %rem = srem i32 %0, 8
  %cond = icmp slt i32 %rem, 0
  %add = add i32 %rem, 8
  %sel = select i1 %cond, i32 %rem, i32 %add
  ret i32 %sel
}

define <2 x i32> @rem_euclid_vec(<2 x i32> %0) {
; CHECK-LABEL: @rem_euclid_vec(
; CHECK-NEXT:    [[SEL:%.*]] = and <2 x i32> [[TMP0:%.*]], <i32 7, i32 7>
; CHECK-NEXT:    ret <2 x i32> [[SEL]]
;
  %rem = srem <2 x i32> %0, <i32 8, i32 8>
  %cond = icmp slt <2 x i32> %rem, <i32 0, i32 0>
  %add = add <2 x i32> %rem, <i32 8, i32 8>
  %sel = select <2 x i1> %cond, <2 x i32> %add, <2 x i32> %rem
  ret <2 x i32> %sel
}

define i128 @rem_euclid_i128(i128 %0) {
; CHECK-LABEL: @rem_euclid_i128(
; CHECK-NEXT:    [[SEL:%.*]] = and i128 [[TMP0:%.*]], 7
; CHECK-NEXT:    ret i128 [[SEL]]
;
  %rem = srem i128 %0, 8
  %cond = icmp slt i128 %rem, 0
  %add = add i128 %rem, 8
  %sel = select i1 %cond, i128 %add, i128 %rem
  ret i128 %sel
}

define i8 @rem_euclid_non_const_pow2(i8 %0, i8 %1) {
; CHECK-LABEL: @rem_euclid_non_const_pow2(
; CHECK-NEXT:    [[NOTMASK:%.*]] = shl nsw i8 -1, [[TMP0:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i8 [[NOTMASK]], -1
; CHECK-NEXT:    [[SEL:%.*]] = and i8 [[TMP1:%.*]], [[TMP3]]
; CHECK-NEXT:    ret i8 [[SEL]]
;
  %pow2 = shl i8 1, %0
  %rem = srem i8 %1, %pow2
  %cond = icmp slt i8 %rem, 0
  %add = add i8 %rem, %pow2
  %sel = select i1 %cond, i8 %add, i8 %rem
  ret i8 %sel
}

define i32 @rem_euclid_pow2_true_arm_folded(i32 %n) {
; CHECK-LABEL: @rem_euclid_pow2_true_arm_folded(
; CHECK-NEXT:    [[RES:%.*]] = and i32 [[N:%.*]], 1
; CHECK-NEXT:    ret i32 [[RES]]
;
  %rem = srem i32 %n, 2
  %neg = icmp slt i32 %rem, 0
  %res = select i1 %neg, i32 1, i32 %rem
  ret i32 %res
}

define i32 @rem_euclid_pow2_false_arm_folded(i32 %n) {
; CHECK-LABEL: @rem_euclid_pow2_false_arm_folded(
; CHECK-NEXT:    [[RES:%.*]] = and i32 [[N:%.*]], 1
; CHECK-NEXT:    ret i32 [[RES]]
;
  %rem = srem i32 %n, 2
  %nonneg = icmp sge i32 %rem, 0
  %res = select i1 %nonneg, i32 %rem, i32 1
  ret i32 %res
}

define i8 @pr89516(i8 %n, i8 %x) {
; CHECK-LABEL: @pr89516(
; CHECK-NEXT:    [[COND:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    [[POW2:%.*]] = shl nuw i8 1, [[N:%.*]]
; CHECK-NEXT:    [[SREM:%.*]] = srem i8 1, [[POW2]]
; CHECK-NEXT:    [[ADD:%.*]] = select i1 [[COND]], i8 [[POW2]], i8 0
; CHECK-NEXT:    [[RES:%.*]] = add nuw i8 [[SREM]], [[ADD]]
; CHECK-NEXT:    ret i8 [[RES]]
;
  %cond = icmp slt i8 %x, 0
  %pow2 = shl nuw i8 1, %n
  %srem = srem i8 1, %pow2
  %add = add nuw i8 %srem, %pow2
  %res = select i1 %cond, i8 %add, i8 %srem
  ret i8 %res
}

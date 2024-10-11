; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Should fold
;   (%x + %y) u>= %x
; or
;   (%x + %y) u>= %y
; to
;   @llvm.uadd.with.overflow(%x, %y) + extractvalue + not

define i1 @t0_basic(i8 %x, i8 %y) {
; CHECK-LABEL: @t0_basic(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp uge i8 %t0, %y
  ret i1 %r
}

define <2 x i1> @t1_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @t1_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i8> [[Y:%.*]], <i8 -1, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = icmp ule <2 x i8> [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %t0 = add <2 x i8> %x, %y
  %r = icmp uge <2 x i8> %t0, %y
  ret <2 x i1> %r
}

; Commutativity

define i1 @t2_symmetry(i8 %x, i8 %y) {
; CHECK-LABEL: @t2_symmetry(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[Y:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp uge i8 %t0, %x ; can check against either of `add` arguments
  ret i1 %r
}

declare i8 @gen8()

define i1 @t3_commutative(i8 %x) {
; CHECK-LABEL: @t3_commutative(
; CHECK-NEXT:    [[Y:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = call i8 @gen8()
  %t0 = add i8 %y, %x ; swapped
  %r = icmp uge i8 %t0, %y
  ret i1 %r
}

define i1 @t4_commutative(i8 %x, i8 %y) {
; CHECK-LABEL: @t4_commutative(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp ule i8 %y, %t0 ; swapped
  ret i1 %r
}

define i1 @t5_commutative(i8 %x) {
; CHECK-LABEL: @t5_commutative(
; CHECK-NEXT:    [[Y:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = call i8 @gen8()
  %t0 = add i8 %y, %x ; swapped
  %r = icmp ule i8 %y, %t0 ; swapped
  ret i1 %r
}

; Extra-use tests

declare void @use8(i8)

define i1 @t6_extrause(i8 %x, i8 %y) {
; CHECK-LABEL: @t6_extrause(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[T0]])
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  call void @use8(i8 %t0)
  %r = icmp uge i8 %t0, %y
  ret i1 %r
}

; Negative tests

define i1 @n7_different_y(i8 %x, i8 %y0, i8 %y1) {
; CHECK-LABEL: @n7_different_y(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y0:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[T0]], [[Y1:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y0
  %r = icmp uge i8 %t0, %y1
  ret i1 %r
}

define i1 @n8_wrong_pred0(i8 %x, i8 %y) {
; CHECK-LABEL: @n8_wrong_pred0(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp ule i8 %t0, %y
  ret i1 %r
}

define i1 @n9_wrong_pred1(i8 %x, i8 %y) {
; CHECK-LABEL: @n9_wrong_pred1(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp ugt i8 %t0, %y
  ret i1 %r
}

define i1 @n10_wrong_pred2(i8 %x, i8 %y) {
; CHECK-LABEL: @n10_wrong_pred2(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp eq i8 %t0, %y
  ret i1 %r
}

define i1 @n11_wrong_pred3(i8 %x, i8 %y) {
; CHECK-LABEL: @n11_wrong_pred3(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp ne i8 %t0, %y
  ret i1 %r
}

define i1 @n12_wrong_pred4(i8 %x, i8 %y) {
; CHECK-LABEL: @n12_wrong_pred4(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp slt i8 %t0, %y
  ret i1 %r
}

define i1 @n13_wrong_pred5(i8 %x, i8 %y) {
; CHECK-LABEL: @n13_wrong_pred5(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sle i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp sle i8 %t0, %y
  ret i1 %r
}

define i1 @n14_wrong_pred6(i8 %x, i8 %y) {
; CHECK-LABEL: @n14_wrong_pred6(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp sgt i8 %t0, %y
  ret i1 %r
}

define i1 @n15_wrong_pred7(i8 %x, i8 %y) {
; CHECK-LABEL: @n15_wrong_pred7(
; CHECK-NEXT:    [[T0:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sge i8 [[T0]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = add i8 %x, %y
  %r = icmp sge i8 %t0, %y
  ret i1 %r
}

define i1 @low_bitmask_ult(i8 %x) {
; CHECK-LABEL: @low_bitmask_ult(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %a = add i8 %x, 31
  %m = and i8 %a, 31
  %r = icmp ult i8 %m, %x
  ret i1 %r
}

define <2 x i1> @low_bitmask_uge(<2 x i8> %x) {
; CHECK-LABEL: @low_bitmask_uge(
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %a = add <2 x i8> %x, <i8 15, i8 poison>
  %m = and <2 x i8> %a, <i8 15, i8 15>
  %r = icmp uge <2 x i8> %m, %x
  ret <2 x i1> %r
}

define i1 @low_bitmask_ugt(i8 %px) {
; CHECK-LABEL: @low_bitmask_ugt(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = mul i8 %px, %px
  %a = add i8 %x, 127
  %m = and i8 %a, 127
  %r = icmp ugt i8 %x, %m
  ret i1 %r
}

define <2 x i1> @low_bitmask_ule(<2 x i8> %px) {
; CHECK-LABEL: @low_bitmask_ule(
; CHECK-NEXT:    [[X:%.*]] = mul <2 x i8> [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i8> [[X]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %x = mul <2 x i8> %px, %px
  %a = add <2 x i8> %x, <i8 3, i8 3>
  %m = and <2 x i8> %a, <i8 3, i8 3>
  %r = icmp ule <2 x i8> %x, %m
  ret <2 x i1> %r
}

define i1 @low_bitmask_ult_use(i8 %x) {
; CHECK-LABEL: @low_bitmask_ult_use(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X:%.*]], 7
; CHECK-NEXT:    [[M:%.*]] = and i8 [[A]], 7
; CHECK-NEXT:    call void @use8(i8 [[M]])
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %a = add i8 %x, 7
  %m = and i8 %a, 7
  call void @use8(i8 %m)
  %r = icmp ult i8 %m, %x
  ret i1 %r
}

define i1 @low_bitmask_ugt_use(i8 %px) {
; CHECK-LABEL: @low_bitmask_ugt_use(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X]], 3
; CHECK-NEXT:    call void @use8(i8 [[A]])
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = mul i8 %px, %px
  %a = add i8 %x, 3
  call void @use8(i8 %a)
  %m = and i8 %a, 3
  %r = icmp ugt i8 %x, %m
  ret i1 %r
}

; negative test - need same low bitmask

define i1 @low_bitmask_ult_wrong_mask1(i8 %x) {
; CHECK-LABEL: @low_bitmask_ult_wrong_mask1(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X:%.*]], 30
; CHECK-NEXT:    [[M:%.*]] = and i8 [[A]], 31
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[M]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %a = add i8 %x, 30
  %m = and i8 %a, 31
  %r = icmp ult i8 %m, %x
  ret i1 %r
}

; negative test - need same low bitmask

define i1 @low_bitmask_uge_wrong_mask2(i8 %x) {
; CHECK-LABEL: @low_bitmask_uge_wrong_mask2(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X:%.*]], 31
; CHECK-NEXT:    [[M:%.*]] = and i8 [[A]], 63
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[M]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %a = add i8 %x, 31
  %m = and i8 %a, 63
  %r = icmp uge i8 %m, %x
  ret i1 %r
}

; negative test - predicate mandates operand order

define i1 @low_bitmask_ugt_swapped(i8 %x) {
; CHECK-LABEL: @low_bitmask_ugt_swapped(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X:%.*]], 127
; CHECK-NEXT:    [[M:%.*]] = and i8 [[A]], 127
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[M]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %a = add i8 %x, 127
  %m = and i8 %a, 127
  %r = icmp ugt i8 %m, %x
  ret i1 %r
}

; negative test - unsigned preds only

define i1 @low_bitmask_sgt(i8 %px) {
; CHECK-LABEL: @low_bitmask_sgt(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[PX:%.*]], [[PX]]
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X]], 127
; CHECK-NEXT:    [[M:%.*]] = and i8 [[A]], 127
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[X]], [[M]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = mul i8 %px, %px
  %a = add i8 %x, 127
  %m = and i8 %a, 127
  %r = icmp sgt i8 %x, %m
  ret i1 %r
}

; negative test - specific operand must match

define i1 @low_bitmask_ult_specific_op(i8 %x, i8 %y) {
; CHECK-LABEL: @low_bitmask_ult_specific_op(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[X:%.*]], 31
; CHECK-NEXT:    [[M:%.*]] = and i8 [[A]], 31
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[M]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %a = add i8 %x, 31
  %m = and i8 %a, 31
  %r = icmp ult i8 %m, %y
  ret i1 %r
}

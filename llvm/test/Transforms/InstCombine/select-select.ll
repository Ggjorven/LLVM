; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

define float @foo1(float %a) {
; CHECK-LABEL: @foo1(
; CHECK-NEXT:    [[B:%.*]] = fcmp ogt float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B]], float [[A]], float 0.000000e+00
; CHECK-NEXT:    [[D:%.*]] = fcmp olt float [[C]], 1.000000e+00
; CHECK-NEXT:    [[F:%.*]] = select i1 [[D]], float [[C]], float 1.000000e+00
; CHECK-NEXT:    ret float [[F]]
;
  %b = fcmp ogt float %a, 0.0
  %c = select i1 %b, float %a, float 0.0
  %d = fcmp olt float %c, 1.0
  %f = select i1 %d, float %c, float 1.0
  ret float %f
}

define float @foo2(float %a) {
; CHECK-LABEL: @foo2(
; CHECK-NEXT:    [[B:%.*]] = fcmp ule float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp olt float [[A]], 1.000000e+00
; CHECK-NEXT:    [[E:%.*]] = select i1 [[TMP1]], float [[A]], float 1.000000e+00
; CHECK-NEXT:    [[F:%.*]] = select i1 [[B]], float 0.000000e+00, float [[E]]
; CHECK-NEXT:    ret float [[F]]
;
  %b = fcmp ogt float %a, 0.0
  %c = select i1 %b, float %a, float 0.0
  %d = fcmp olt float %c, 1.0
  %e = select i1 %b, float %a, float 0.0
  %f = select i1 %d, float %e, float 1.0
  ret float %f
}

define <2 x i32> @foo3(<2 x i1> %vec_bool, i1 %bool, <2 x i32> %V) {
; CHECK-LABEL: @foo3(
; CHECK-NEXT:    [[SEL0:%.*]] = select <2 x i1> [[VEC_BOOL:%.*]], <2 x i32> zeroinitializer, <2 x i32> [[V:%.*]]
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 [[BOOL:%.*]], <2 x i32> [[SEL0]], <2 x i32> [[V]]
; CHECK-NEXT:    ret <2 x i32> [[SEL1]]
;
  %sel0 = select <2 x i1> %vec_bool, <2 x i32> zeroinitializer, <2 x i32> %V
  %sel1 = select i1 %bool, <2 x i32> %sel0, <2 x i32> %V
  ret <2 x i32> %sel1
}

; Four variations of (select (select-shuffle)) with a common operand.

define <4 x i8> @sel_shuf_commute0(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_commute0(
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[Y:%.*]], <4 x i8> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x i8> [[X]], <4 x i8> [[SEL]], <4 x i32> <i32 0, i32 5, i32 2, i32 7>
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  %r = select <4 x i1> %cmp, <4 x i8> %blend, <4 x i8> %x
  ret <4 x i8> %r
}

; Weird types are ok.

define <5 x i9> @sel_shuf_commute1(<5 x i9> %x, <5 x i9> %y, <5 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_commute1(
; CHECK-NEXT:    [[SEL:%.*]] = select <5 x i1> [[CMP:%.*]], <5 x i9> [[X:%.*]], <5 x i9> [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <5 x i9> [[SEL]], <5 x i9> [[Y]], <5 x i32> <i32 0, i32 6, i32 2, i32 8, i32 9>
; CHECK-NEXT:    ret <5 x i9> [[R]]
;
  %blend = shufflevector <5 x i9> %x, <5 x i9> %y, <5 x i32> <i32 0, i32 6, i32 2, i32 8, i32 9>
  %r = select <5 x i1> %cmp, <5 x i9> %blend, <5 x i9> %y
  ret <5 x i9> %r
}

define <4 x float> @sel_shuf_commute2(<4 x float> %x, <4 x float> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_commute2(
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x float> [[X:%.*]], <4 x float> [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x float> [[X]], <4 x float> [[SEL]], <4 x i32> <i32 0, i32 1, i32 2, i32 7>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %blend = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %r = select <4 x i1> %cmp, <4 x float> %x, <4 x float> %blend
  ret <4 x float> %r
}

; Scalar condition is ok.

define <4 x i8> @sel_shuf_commute3(<4 x i8> %x, <4 x i8> %y, i1 %cmp) {
; CHECK-LABEL: @sel_shuf_commute3(
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], <4 x i8> [[Y:%.*]], <4 x i8> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x i8> [[SEL]], <4 x i8> [[Y]], <4 x i32> <i32 0, i32 5, i32 2, i32 3>
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  %r = select i1 %cmp, <4 x i8> %y, <4 x i8> %blend
  ret <4 x i8> %r
}

declare void @use(<4 x i8>)

; Negative test - extra use would require another instruction.

define <4 x i8> @sel_shuf_use(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_use(
; CHECK-NEXT:    [[BLEND:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <4 x i32> <i32 0, i32 5, i32 2, i32 7>
; CHECK-NEXT:    call void @use(<4 x i8> [[BLEND]])
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[BLEND]], <4 x i8> [[X]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  call void @use(<4 x i8> %blend)
  %r = select <4 x i1> %cmp, <4 x i8> %blend, <4 x i8> %x
  ret <4 x i8> %r
}

; Negative test - undef in shuffle mask prevents transform.

define <4 x i8> @sel_shuf_undef(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_undef(
; CHECK-NEXT:    [[BLEND:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <4 x i32> <i32 0, i32 5, i32 2, i32 poison>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[BLEND]], <4 x i8> [[Y]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 2, i32 undef>
  %r = select <4 x i1> %cmp, <4 x i8> %blend, <4 x i8> %y
  ret <4 x i8> %r
}

; Negative test - not a "select shuffle"

define <4 x i8> @sel_shuf_not(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_not(
; CHECK-NEXT:    [[NOTBLEND:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <4 x i32> <i32 0, i32 5, i32 2, i32 6>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[NOTBLEND]], <4 x i8> [[Y]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %notblend = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 2, i32 6>
  %r = select <4 x i1> %cmp, <4 x i8> %notblend, <4 x i8> %y
  ret <4 x i8> %r
}

; Negative test - must shuffle one of the select operands

define <4 x i8> @sel_shuf_no_common_operand(<4 x i8> %x, <4 x i8> %y, <4 x i1> %cmp, <4 x i8> %z) {
; CHECK-LABEL: @sel_shuf_no_common_operand(
; CHECK-NEXT:    [[BLEND:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <4 x i32> <i32 0, i32 5, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[CMP:%.*]], <4 x i8> [[Z:%.*]], <4 x i8> [[BLEND]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  %r = select <4 x i1> %cmp, <4 x i8> %z, <4 x i8> %blend
  ret <4 x i8> %r
}

; Negative test - don't crash (this is not a select shuffle because it changes vector length)

define <2 x i8> @sel_shuf_narrowing_commute1(<4 x i8> %x, <4 x i8> %y, <2 x i8> %x2, <2 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_narrowing_commute1(
; CHECK-NEXT:    [[BLEND:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <2 x i32> <i32 0, i32 5>
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[CMP:%.*]], <2 x i8> [[BLEND]], <2 x i8> [[X2:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <2 x i32> <i32 0, i32 5>
  %r = select <2 x i1> %cmp, <2 x i8> %blend, <2 x i8> %x2
  ret <2 x i8> %r
}

; Negative test - don't crash (this is not a select shuffle because it changes vector length)

define <2 x i8> @sel_shuf_narrowing_commute2(<4 x i8> %x, <4 x i8> %y, <2 x i8> %x2, <2 x i1> %cmp) {
; CHECK-LABEL: @sel_shuf_narrowing_commute2(
; CHECK-NEXT:    [[BLEND:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <2 x i32> <i32 0, i32 5>
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[CMP:%.*]], <2 x i8> [[X2:%.*]], <2 x i8> [[BLEND]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %blend = shufflevector <4 x i8> %x, <4 x i8> %y, <2 x i32> <i32 0, i32 5>
  %r = select <2 x i1> %cmp, <2 x i8> %x2, <2 x i8> %blend
  ret <2 x i8> %r
}

define i8 @strong_order_cmp_slt_eq(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_slt_eq(
; CHECK-NEXT:    [[SEL_EQ:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.lt = icmp slt i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 1
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.lt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_ult_eq(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ult_eq(
; CHECK-NEXT:    [[SEL_EQ:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.lt = icmp ult i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 1
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.lt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_slt_eq_wrong_const(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_slt_eq_wrong_const(
; CHECK-NEXT:    [[CMP_LT:%.*]] = icmp slt i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL_LT:%.*]] = select i1 [[CMP_LT]], i8 -2, i8 1
; CHECK-NEXT:    [[CMP_EQ:%.*]] = icmp eq i32 [[A]], [[B]]
; CHECK-NEXT:    [[SEL_EQ:%.*]] = select i1 [[CMP_EQ]], i8 0, i8 [[SEL_LT]]
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.lt = icmp slt i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -2, i8 1
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.lt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_ult_eq_wrong_const(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ult_eq_wrong_const(
; CHECK-NEXT:    [[CMP_LT:%.*]] = icmp ult i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL_LT:%.*]] = select i1 [[CMP_LT]], i8 -1, i8 3
; CHECK-NEXT:    [[CMP_EQ:%.*]] = icmp eq i32 [[A]], [[B]]
; CHECK-NEXT:    [[SEL_EQ:%.*]] = select i1 [[CMP_EQ]], i8 0, i8 [[SEL_LT]]
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.lt = icmp ult i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 3
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.lt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_slt_ult_wrong_pred(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_slt_ult_wrong_pred(
; CHECK-NEXT:    [[CMP_LT:%.*]] = icmp slt i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL_LT:%.*]] = select i1 [[CMP_LT]], i8 -1, i8 1
; CHECK-NEXT:    [[CMP_EQ:%.*]] = icmp ult i32 [[A]], [[B]]
; CHECK-NEXT:    [[SEL_EQ:%.*]] = select i1 [[CMP_EQ]], i8 0, i8 [[SEL_LT]]
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.lt = icmp slt i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 1
  %cmp.eq = icmp ult i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.lt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_sgt_eq(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_sgt_eq(
; CHECK-NEXT:    [[SEL_EQ:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.gt = icmp sgt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 -1
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.gt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_ugt_eq(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ugt_eq(
; CHECK-NEXT:    [[SEL_EQ:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.gt = icmp ugt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 -1
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.gt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_eq_slt(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_eq_slt(
; CHECK-NEXT:    [[SEL_LT:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_LT]]
;
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 1
  %cmp.lt = icmp slt i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 %sel.eq
  ret i8 %sel.lt
}

define i8 @strong_order_cmp_eq_sgt(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_eq_sgt(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 -1
  %cmp.gt = icmp sgt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sel.eq
  ret i8 %sel.gt
}

define i8 @strong_order_cmp_eq_ult(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ult(
; CHECK-NEXT:    [[SEL_LT:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_LT]]
;
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 1
  %cmp.lt = icmp ult i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 %sel.eq
  ret i8 %sel.lt
}

define i8 @strong_order_cmp_eq_ugt(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ugt(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 -1
  %cmp.gt = icmp ugt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sel.eq
  ret i8 %sel.gt
}

define i8 @strong_order_cmp_slt_sgt(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_slt_sgt(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.lt = icmp slt i32 %a, %b
  %sext = sext i1 %cmp.lt to i8
  %cmp.gt = icmp sgt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sext
  ret i8 %sel.gt
}

define i8 @strong_order_cmp_ult_ugt(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ult_ugt(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.lt = icmp ult i32 %a, %b
  %sext = sext i1 %cmp.lt to i8
  %cmp.gt = icmp ugt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sext
  ret i8 %sel.gt
}

define i8 @strong_order_cmp_sgt_slt(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_sgt_slt(
; CHECK-NEXT:    [[SEL_LT:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_LT]]
;
  %cmp.gt = icmp sgt i32 %a, %b
  %zext = zext i1 %cmp.gt to i8
  %cmp.lt = icmp slt i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 %zext
  ret i8 %sel.lt
}

define i8 @strong_order_cmp_ugt_ult(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ugt_ult(
; CHECK-NEXT:    [[SEL_LT:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i8 [[SEL_LT]]
;
  %cmp.gt = icmp ugt i32 %a, %b
  %zext = zext i1 %cmp.gt to i8
  %cmp.lt = icmp ult i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 %zext
  ret i8 %sel.lt
}

define i8 @strong_order_cmp_ne_ugt_ne_not_one_use(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ne_ugt_ne_not_one_use(
; CHECK-NEXT:    [[CMP_NE:%.*]] = icmp ne i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[CMP_NE]])
; CHECK-NEXT:    [[SEL_GT:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.ne = icmp ne i32 %a, %b
  call void @use1(i1 %cmp.ne)
  %sel.eq = sext i1 %cmp.ne to i8
  %cmp.gt = icmp ugt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sel.eq
  ret i8 %sel.gt
}

define i8 @strong_order_cmp_slt_eq_slt_not_oneuse(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_slt_eq_slt_not_oneuse(
; CHECK-NEXT:    [[CMP_LT:%.*]] = icmp slt i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[CMP_LT]])
; CHECK-NEXT:    [[SEL_EQ:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.lt = icmp slt i32 %a, %b
  call void @use1(i1 %cmp.lt)
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 1
  %cmp.eq = icmp eq i32 %a, %b
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.lt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_sgt_eq_eq_not_oneuse(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_sgt_eq_eq_not_oneuse(
; CHECK-NEXT:    [[CMP_EQ:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[CMP_EQ]])
; CHECK-NEXT:    [[SEL_EQ:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i8 [[SEL_EQ]]
;
  %cmp.gt = icmp sgt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 -1
  %cmp.eq = icmp eq i32 %a, %b
  call void @use1(i1 %cmp.eq)
  %sel.eq = select i1 %cmp.eq, i8 0, i8 %sel.gt
  ret i8 %sel.eq
}

define i8 @strong_order_cmp_eq_ugt_eq_not_oneuse(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ugt_eq_not_oneuse(
; CHECK-NEXT:    [[CMP_EQ:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[CMP_EQ]])
; CHECK-NEXT:    [[NOT_CMP_EQ:%.*]] = xor i1 [[CMP_EQ]], true
; CHECK-NEXT:    [[SEL_EQ:%.*]] = sext i1 [[NOT_CMP_EQ]] to i8
; CHECK-NEXT:    [[CMP_GT:%.*]] = icmp ugt i32 [[A]], [[B]]
; CHECK-NEXT:    [[SEL_GT:%.*]] = select i1 [[CMP_GT]], i8 1, i8 [[SEL_EQ]]
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.eq = icmp eq i32 %a, %b
  call void @use1(i1 %cmp.eq)
  %sel.eq = select i1 %cmp.eq, i8 0, i8 -1
  %cmp.gt = icmp ugt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sel.eq
  ret i8 %sel.gt
}

define i8 @strong_order_cmp_ugt_ult_zext_not_oneuse(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_ugt_ult_zext_not_oneuse(
; CHECK-NEXT:    [[CMP_GT:%.*]] = icmp ugt i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i1 [[CMP_GT]] to i8
; CHECK-NEXT:    call void @use8(i8 [[ZEXT]])
; CHECK-NEXT:    [[SEL_LT:%.*]] = call i8 @llvm.ucmp.i8.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i8 [[SEL_LT]]
;
  %cmp.gt = icmp ugt i32 %a, %b
  %zext = zext i1 %cmp.gt to i8
  call void @use8(i8 %zext)
  %cmp.lt = icmp ult i32 %a, %b
  %sel.lt = select i1 %cmp.lt, i8 -1, i8 %zext
  ret i8 %sel.lt
}

define i8 @strong_order_cmp_slt_sgt_sext_not_oneuse(i32 %a, i32 %b) {
; CHECK-LABEL: @strong_order_cmp_slt_sgt_sext_not_oneuse(
; CHECK-NEXT:    [[CMP_LT:%.*]] = icmp slt i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[CMP_LT]] to i8
; CHECK-NEXT:    call void @use8(i8 [[SEXT]])
; CHECK-NEXT:    [[SEL_GT:%.*]] = call i8 @llvm.scmp.i8.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i8 [[SEL_GT]]
;
  %cmp.lt = icmp slt i32 %a, %b
  %sext = sext i1 %cmp.lt to i8
  call void @use8(i8 %sext)
  %cmp.gt = icmp sgt i32 %a, %b
  %sel.gt = select i1 %cmp.gt, i8 1, i8 %sext
  ret i8 %sel.gt
}

define <2 x i8> @strong_order_cmp_ugt_ult_vector(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @strong_order_cmp_ugt_ult_vector(
; CHECK-NEXT:    [[SEL_LT:%.*]] = call <2 x i8> @llvm.ucmp.v2i8.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[SEL_LT]]
;
  %cmp.gt = icmp ugt <2 x i32> %a, %b
  %zext = zext <2 x i1> %cmp.gt to <2 x i8>
  %cmp.lt = icmp ult <2 x i32> %a, %b
  %sel.lt = select <2 x i1> %cmp.lt, <2 x i8> <i8 -1, i8 -1>, <2 x i8> %zext
  ret <2 x i8> %sel.lt
}

define <2 x i8> @strong_order_cmp_ugt_ult_vector_poison(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @strong_order_cmp_ugt_ult_vector_poison(
; CHECK-NEXT:    [[SEL_LT:%.*]] = call <2 x i8> @llvm.ucmp.v2i8.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[SEL_LT]]
;
  %cmp.gt = icmp ugt <2 x i32> %a, %b
  %zext = zext <2 x i1> %cmp.gt to <2 x i8>
  %cmp.lt = icmp ult <2 x i32> %a, %b
  %sel.lt = select <2 x i1> %cmp.lt, <2 x i8> <i8 poison, i8 -1>, <2 x i8> %zext
  ret <2 x i8> %sel.lt
}

define <2 x i8> @strong_order_cmp_eq_ugt_vector(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ugt_vector(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call <2 x i8> @llvm.ucmp.v2i8.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[SEL_GT]]
;
  %cmp.eq = icmp eq <2 x i32> %a, %b
  %sel.eq = select <2 x i1> %cmp.eq, <2 x i8> <i8 0, i8 0>, <2 x i8> <i8 -1, i8 -1>
  %cmp.gt = icmp ugt <2 x i32> %a, %b
  %sel.gt = select <2 x i1> %cmp.gt, <2 x i8> <i8 1, i8 1>, <2 x i8> %sel.eq
  ret <2 x i8> %sel.gt
}

define <2 x i8> @strong_order_cmp_eq_ugt_vector_poison1(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ugt_vector_poison1(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call <2 x i8> @llvm.ucmp.v2i8.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[SEL_GT]]
;
  %cmp.eq = icmp eq <2 x i32> %a, %b
  %sel.eq = select <2 x i1> %cmp.eq, <2 x i8> <i8 0, i8 poison>, <2 x i8> <i8 -1, i8 -1>
  %cmp.gt = icmp ugt <2 x i32> %a, %b
  %sel.gt = select <2 x i1> %cmp.gt, <2 x i8> <i8 1, i8 1>, <2 x i8> %sel.eq
  ret <2 x i8> %sel.gt
}

define <2 x i8> @strong_order_cmp_eq_ugt_vector_poison2(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ugt_vector_poison2(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call <2 x i8> @llvm.ucmp.v2i8.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[SEL_GT]]
;
  %cmp.eq = icmp eq <2 x i32> %a, %b
  %sel.eq = select <2 x i1> %cmp.eq, <2 x i8> <i8 0, i8 0>, <2 x i8> <i8 poison, i8 -1>
  %cmp.gt = icmp ugt <2 x i32> %a, %b
  %sel.gt = select <2 x i1> %cmp.gt, <2 x i8> <i8 1, i8 1>, <2 x i8> %sel.eq
  ret <2 x i8> %sel.gt
}

define <2 x i8> @strong_order_cmp_eq_ugt_vector_poison3(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @strong_order_cmp_eq_ugt_vector_poison3(
; CHECK-NEXT:    [[SEL_GT:%.*]] = call <2 x i8> @llvm.ucmp.v2i8.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[SEL_GT]]
;
  %cmp.eq = icmp eq <2 x i32> %a, %b
  %sel.eq = select <2 x i1> %cmp.eq, <2 x i8> <i8 0, i8 0>, <2 x i8> <i8 -1, i8 -1>
  %cmp.gt = icmp ugt <2 x i32> %a, %b
  %sel.gt = select <2 x i1> %cmp.gt, <2 x i8> <i8 1, i8 poison>, <2 x i8> %sel.eq
  ret <2 x i8> %sel.gt
}



declare void @use1(i1)
declare void @use8(i8)

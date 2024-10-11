; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i8 @llvm.smin.i8(i8, i8)
declare i8 @llvm.umin.i8(i8, i8)
declare i8 @llvm.smax.i8(i8, i8)
declare i8 @llvm.umax.i8(i8, i8)
declare <2 x i8> @llvm.smin.v2i8(<2 x i8>, <2 x i8>)
declare <2 x i8> @llvm.umin.v2i8(<2 x i8>, <2 x i8>)
declare <2 x i8> @llvm.smax.v2i8(<2 x i8>, <2 x i8>)
declare <2 x i8> @llvm.umax.v2i8(<2 x i8>, <2 x i8>)

declare void @llvm.assume(i1)
declare void @barrier()

define <2 x i8> @umax_xor_Cpow2(<2 x i8> %x) {
; CHECK-LABEL: @umax_xor_Cpow2(
; CHECK-NEXT:    [[R:%.*]] = or <2 x i8> [[X:%.*]], <i8 -128, i8 -128>
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %x_xor = xor <2 x i8> %x, <i8 128, i8 128>
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %x, <2 x i8> %x_xor)
  ret <2 x i8> %r
}

define i8 @umin_xor_Cpow2(i8 %x) {
; CHECK-LABEL: @umin_xor_Cpow2(
; CHECK-NEXT:    [[R:%.*]] = and i8 [[X:%.*]], -65
; CHECK-NEXT:    ret i8 [[R]]
;
  %x_xor = xor i8 %x, 64
  %r = call i8 @llvm.umin.i8(i8 %x, i8 %x_xor)
  ret i8 %r
}

define i8 @smax_xor_Cpow2_pos(i8 %x) {
; CHECK-LABEL: @smax_xor_Cpow2_pos(
; CHECK-NEXT:    [[R:%.*]] = or i8 [[X:%.*]], 32
; CHECK-NEXT:    ret i8 [[R]]
;
  %x_xor = xor i8 %x, 32
  %r = call i8 @llvm.smax.i8(i8 %x, i8 %x_xor)
  ret i8 %r
}

define <2 x i8> @smin_xor_Cpow2_pos(<2 x i8> %x) {
; CHECK-LABEL: @smin_xor_Cpow2_pos(
; CHECK-NEXT:    [[R:%.*]] = and <2 x i8> [[X:%.*]], <i8 -17, i8 -17>
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %x_xor = xor <2 x i8> %x, <i8 16, i8 16>
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> %x_xor)
  ret <2 x i8> %r
}

define <2 x i8> @smax_xor_Cpow2_neg(<2 x i8> %x) {
; CHECK-LABEL: @smax_xor_Cpow2_neg(
; CHECK-NEXT:    [[R:%.*]] = and <2 x i8> [[X:%.*]], <i8 127, i8 127>
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %x_xor = xor <2 x i8> %x, <i8 128, i8 128>
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> %x, <2 x i8> %x_xor)
  ret <2 x i8> %r
}

define i8 @smin_xor_Cpow2_neg(i8 %x) {
; CHECK-LABEL: @smin_xor_Cpow2_neg(
; CHECK-NEXT:    [[R:%.*]] = or i8 [[X:%.*]], -128
; CHECK-NEXT:    ret i8 [[R]]
;
  %x_xor = xor i8 %x, 128
  %r = call i8 @llvm.smin.i8(i8 %x, i8 %x_xor)
  ret i8 %r
}

define i8 @umax_xor_pow2(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_xor_pow2(
; CHECK-NEXT:    [[NY:%.*]] = sub i8 0, [[Y:%.*]]
; CHECK-NEXT:    [[YP2:%.*]] = and i8 [[Y]], [[NY]]
; CHECK-NEXT:    [[R:%.*]] = or i8 [[X:%.*]], [[YP2]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %ny = sub i8 0, %y
  %yp2 = and i8 %y, %ny
  %x_xor = xor i8 %x, %yp2
  %r = call i8 @llvm.umax.i8(i8 %x, i8 %x_xor)
  ret i8 %r
}

define <2 x i8> @umin_xor_pow2(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @umin_xor_pow2(
; CHECK-NEXT:    [[NY:%.*]] = sub <2 x i8> zeroinitializer, [[Y:%.*]]
; CHECK-NEXT:    [[YP2:%.*]] = and <2 x i8> [[Y]], [[NY]]
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i8> [[YP2]], <i8 -1, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = and <2 x i8> [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %ny = sub <2 x i8> <i8 0, i8 0>, %y
  %yp2 = and <2 x i8> %y, %ny
  %x_xor = xor <2 x i8> %x, %yp2
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> %x_xor)
  ret <2 x i8> %r
}

define i8 @smax_xor_pow2_unk(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_xor_pow2_unk(
; CHECK-NEXT:    [[NY:%.*]] = sub i8 0, [[Y:%.*]]
; CHECK-NEXT:    [[YP2:%.*]] = and i8 [[Y]], [[NY]]
; CHECK-NEXT:    [[X_XOR:%.*]] = xor i8 [[X:%.*]], [[YP2]]
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.smax.i8(i8 [[X]], i8 [[X_XOR]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %ny = sub i8 0, %y
  %yp2 = and i8 %y, %ny
  %x_xor = xor i8 %x, %yp2
  %r = call i8 @llvm.smax.i8(i8 %x, i8 %x_xor)
  ret i8 %r
}

define <2 x i8> @smin_xor_pow2_unk(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @smin_xor_pow2_unk(
; CHECK-NEXT:    [[NY:%.*]] = sub <2 x i8> zeroinitializer, [[Y:%.*]]
; CHECK-NEXT:    [[YP2:%.*]] = and <2 x i8> [[Y]], [[NY]]
; CHECK-NEXT:    [[X_XOR:%.*]] = xor <2 x i8> [[X:%.*]], [[YP2]]
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> [[X]], <2 x i8> [[X_XOR]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %ny = sub <2 x i8> <i8 0, i8 0>, %y
  %yp2 = and <2 x i8> %y, %ny
  %x_xor = xor <2 x i8> %x, %yp2
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> %x_xor)
  ret <2 x i8> %r
}

define i8 @smax_xor_pow2_neg(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_xor_pow2_neg(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[Y:%.*]], -128
; CHECK-NEXT:    br i1 [[CMP]], label [[NEG:%.*]], label [[POS:%.*]]
; CHECK:       neg:
; CHECK-NEXT:    [[R:%.*]] = and i8 [[X:%.*]], 127
; CHECK-NEXT:    ret i8 [[R]]
; CHECK:       pos:
; CHECK-NEXT:    call void @barrier()
; CHECK-NEXT:    ret i8 0
;
  %ny = sub i8 0, %y
  %yp2 = and i8 %y, %ny
  %cmp = icmp slt i8 %yp2, 0
  br i1 %cmp, label %neg, label %pos
neg:
  %x_xor = xor i8 %x, %yp2
  %r = call i8 @llvm.smax.i8(i8 %x, i8 %x_xor)
  ret i8 %r
pos:
  call void @barrier()
  ret i8 0
}

define i8 @smin_xor_pow2_pos(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_xor_pow2_pos(
; CHECK-NEXT:    [[NY:%.*]] = sub i8 0, [[Y:%.*]]
; CHECK-NEXT:    [[YP2:%.*]] = and i8 [[Y]], [[NY]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[YP2]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[NEG:%.*]], label [[POS:%.*]]
; CHECK:       neg:
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[YP2]], -1
; CHECK-NEXT:    [[R:%.*]] = and i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i8 [[R]]
; CHECK:       pos:
; CHECK-NEXT:    call void @barrier()
; CHECK-NEXT:    ret i8 0
;
  %ny = sub i8 0, %y
  %yp2 = and i8 %y, %ny
  %cmp = icmp sgt i8 %yp2, 0
  br i1 %cmp, label %neg, label %pos
neg:
  %x_xor = xor i8 %x, %yp2
  %r = call i8 @llvm.smin.i8(i8 %x, i8 %x_xor)
  ret i8 %r
pos:
  call void @barrier()
  ret i8 0
}

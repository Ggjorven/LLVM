; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=instsimplify < %s | FileCheck %s

; Just make sure that we don't assert.
define i32 @test(<2 x i16> %a, i32 %b) {
; CHECK-LABEL: define i32 @test(
; CHECK-SAME: <2 x i16> [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:    [[MUL:%.*]] = mul <2 x i16> [[A]], <i16 -1, i16 poison>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <2 x i16> [[MUL]] to i32
; CHECK-NEXT:    [[LSHR:%.*]] = lshr i32 [[B]], [[BC]]
; CHECK-NEXT:    ret i32 [[LSHR]]
;
  %mul = mul <2 x i16> %a, <i16 -1, i16 poison>
  %bc = bitcast <2 x i16> %mul to i32
  %lshr = lshr i32 %b, %bc
  ret i32 %lshr
}

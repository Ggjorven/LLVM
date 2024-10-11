; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -passes=rewrite-statepoints-for-gc -S | FileCheck %s

declare i8 @callee(ptr, i8, float, ptr)

define i8 @test(ptr %arg) gc "statepoint-example" {
; CHECK-LABEL: define i8 @test(
; CHECK-SAME: ptr [[ARG:%.*]]) gc "statepoint-example" {
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(i8 (ptr, i8, float, ptr)) @callee, i32 4, i32 0, ptr nocapture sret({ i64, i64 }) align 8 null, i8 signext 8, float inreg 1.000000e+00, ptr [[ARG]], i32 0, i32 0)
; CHECK-NEXT:    [[R1:%.*]] = call zeroext i8 @llvm.experimental.gc.result.i8(token [[STATEPOINT_TOKEN]])
; CHECK-NEXT:    ret i8 [[R1]]
;
  %r = call zeroext i8 @callee(ptr sret({i64, i64}) noalias align 8 nocapture null, i8 signext 8, float inreg 1.0, ptr writeonly %arg)
  ret i8 %r
}

declare i32 @personality_function()

define i8 @test_invoke(ptr %arg) gc "statepoint-example" personality ptr @personality_function {
; CHECK-LABEL: define i8 @test_invoke(
; CHECK-SAME: ptr [[ARG:%.*]]) gc "statepoint-example" personality ptr @personality_function {
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = invoke token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(i8 (ptr, i8, float, ptr)) @callee, i32 4, i32 0, ptr nocapture sret({ i64, i64 }) align 8 null, i8 signext 8, float inreg 1.000000e+00, ptr [[ARG]], i32 0, i32 0)
; CHECK-NEXT:    to label [[NORMAL_RETURN:%.*]] unwind label [[EXCEPTIONAL_RETURN:%.*]]
; CHECK:       normal_return:
; CHECK-NEXT:    [[R1:%.*]] = call zeroext i8 @llvm.experimental.gc.result.i8(token [[STATEPOINT_TOKEN]])
; CHECK-NEXT:    ret i8 [[R1]]
; CHECK:       exceptional_return:
; CHECK-NEXT:    [[LANDING_PAD4:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    ret i8 0
;
  %r = invoke zeroext i8 @callee(ptr sret({i64, i64}) noalias align 8 nocapture null, i8 signext 8, float inreg 1.0, ptr writeonly %arg)
  to label %normal_return unwind label %exceptional_return

normal_return:
  ret i8 %r

exceptional_return:
  %landing_pad4 = landingpad token
  cleanup
  ret i8 0
}

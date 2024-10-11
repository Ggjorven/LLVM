; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=rewrite-statepoints-for-gc < %s | FileCheck %s

declare void @f()
declare i32 @personality_function()

define void @test_id() gc "statepoint-example" personality ptr @personality_function {
; CHECK-LABEL: @test_id(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = invoke token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 100, i32 0, ptr elementtype(void ()) @f, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    to label [[NORMAL_RETURN:%.*]] unwind label [[EXCEPTIONAL_RETURN:%.*]]
; CHECK:       normal_return:
; CHECK-NEXT:    ret void
; CHECK:       exceptional_return:
; CHECK-NEXT:    [[LANDING_PAD4:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()  "statepoint-id"="100" to label %normal_return unwind label %exceptional_return

normal_return:
  ret void

exceptional_return:
  %landing_pad4 = landingpad {ptr, i32} cleanup
  ret void
}

define void @test_num_patch_bytes() gc "statepoint-example" personality ptr @personality_function {
; CHECK-LABEL: @test_num_patch_bytes(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = invoke token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 99, ptr elementtype(void ()) @f, i32 0, i32 0, i32 0, i32 0)
; CHECK-NEXT:    to label [[NORMAL_RETURN:%.*]] unwind label [[EXCEPTIONAL_RETURN:%.*]]
; CHECK:       normal_return:
; CHECK-NEXT:    ret void
; CHECK:       exceptional_return:
; CHECK-NEXT:    [[LANDING_PAD4:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()  "statepoint-num-patch-bytes"="99" to label %normal_return unwind label %exceptional_return

normal_return:
  ret void

exceptional_return:
  %landing_pad4 = landingpad {ptr, i32} cleanup
  ret void
}

declare void @do_safepoint()
define void @gc.safepoint_poll() {
; CHECK-LABEL: @gc.safepoint_poll(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @do_safepoint()
; CHECK-NEXT:    ret void
;
entry:
  call void @do_safepoint()
  ret void
}

; CHECK-NOT: statepoint-id
; CHECK-NOT: statepoint-num-patch_bytes

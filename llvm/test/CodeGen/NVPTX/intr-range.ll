; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --version 5
; RUN: opt < %s -S -mtriple=nvptx-nvidia-cuda -mcpu=sm_20 -passes=nvvm-intr-range | FileCheck %s

define i32 @test_maxntid() {
; CHECK-LABEL: define i32 @test_maxntid(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call range(i32 0, 96) i32 @llvm.nvvm.read.ptx.sreg.tid.x()
; CHECK-NEXT:    [[TMP3:%.*]] = call range(i32 0, 96) i32 @llvm.nvvm.read.ptx.sreg.tid.y()
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 64) i32 @llvm.nvvm.read.ptx.sreg.tid.z()
; CHECK-NEXT:    [[TMP11:%.*]] = call range(i32 1, 97) i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
; CHECK-NEXT:    [[TMP4:%.*]] = call range(i32 1, 97) i32 @llvm.nvvm.read.ptx.sreg.ntid.y()
; CHECK-NEXT:    [[TMP6:%.*]] = call range(i32 1, 65) i32 @llvm.nvvm.read.ptx.sreg.ntid.z()
; CHECK-NEXT:    [[TMP7:%.*]] = add i32 [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP7]], [[TMP2]]
; CHECK-NEXT:    [[TMP9:%.*]] = add i32 [[TMP8]], [[TMP11]]
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[TMP9]], [[TMP4]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[TMP10]], [[TMP6]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
  %1 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %2 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y()
  %3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.z()
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.y()
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.z()
  %7 = add i32 %1, %2
  %8 = add i32 %7, %3
  %9 = add i32 %8, %4
  %10 = add i32 %9, %5
  %11 = add i32 %10, %6
  ret i32 %11
}

define i32 @test_reqntid() {
; CHECK-LABEL: define i32 @test_reqntid(
; CHECK-SAME: ) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call range(i32 0, 20) i32 @llvm.nvvm.read.ptx.sreg.tid.x()
; CHECK-NEXT:    [[TMP5:%.*]] = call range(i32 0, 20) i32 @llvm.nvvm.read.ptx.sreg.tid.y()
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i32 0, 20) i32 @llvm.nvvm.read.ptx.sreg.tid.z()
; CHECK-NEXT:    [[TMP4:%.*]] = call range(i32 1, 21) i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
; CHECK-NEXT:    [[TMP3:%.*]] = call range(i32 1, 21) i32 @llvm.nvvm.read.ptx.sreg.ntid.y()
; CHECK-NEXT:    [[TMP6:%.*]] = call range(i32 1, 21) i32 @llvm.nvvm.read.ptx.sreg.ntid.z()
; CHECK-NEXT:    [[TMP7:%.*]] = add i32 [[TMP1]], [[TMP5]]
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP7]], [[TMP2]]
; CHECK-NEXT:    [[TMP9:%.*]] = add i32 [[TMP8]], [[TMP4]]
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[TMP9]], [[TMP3]]
; CHECK-NEXT:    [[TMP11:%.*]] = add i32 [[TMP10]], [[TMP6]]
; CHECK-NEXT:    ret i32 [[TMP3]]
;
  %1 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %2 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y()
  %3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.z()
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.y()
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.z()
  %7 = add i32 %1, %2
  %8 = add i32 %7, %3
  %9 = add i32 %8, %4
  %10 = add i32 %9, %5
  %11 = add i32 %10, %6
  ret i32 %5
}

;; A case like this could occur if a function with the sreg intrinsic was
;; inlined into a kernel where the tid metadata is present, ensure the range is
;; updated.
define i32 @test_inlined() {
; CHECK-LABEL: define i32 @test_inlined(
; CHECK-SAME: ) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call range(i32 0, 4) i32 @llvm.nvvm.read.ptx.sreg.tid.x()
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call range(i32 0, 1024) i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  ret i32 %1
}

declare i32 @llvm.nvvm.read.ptx.sreg.tid.x()
declare i32 @llvm.nvvm.read.ptx.sreg.tid.y()
declare i32 @llvm.nvvm.read.ptx.sreg.tid.z()

declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.y()
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.z()

!nvvm.annotations = !{!0, !1, !2}
!0 = !{ptr @test_maxntid, !"kernel", i32 1, !"maxntidx", i32 32, !"maxntidz", i32 3}
!1 = !{ptr @test_reqntid, !"kernel", i32 1, !"reqntidx", i32 20}
!2 = !{ptr @test_inlined, !"kernel", i32 1, !"maxntidx", i32 4}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes="require<profile-summary>,function(codegenprepare)" < %s | FileCheck %s --check-prefix=SLOW
; RUN: opt -S -passes="require<profile-summary>,function(codegenprepare)" -mattr=+bmi < %s | FileCheck %s --check-prefix=FAST_TZ
; RUN: opt -S -passes="require<profile-summary>,function(codegenprepare)" -mattr=+lzcnt < %s | FileCheck %s --check-prefix=FAST_LZ

; RUN: opt -S -enable-debugify -passes="require<profile-summary>,function(codegenprepare)" < %s | FileCheck %s --check-prefix=DEBUGINFO
; RUN: opt -S -enable-debugify -passes="require<profile-summary>,function(codegenprepare)" --try-experimental-debuginfo-iterators < %s | FileCheck %s --check-prefix=DEBUGINFO

target triple = "x86_64-unknown-unknown"
target datalayout = "e-n32:64"

; If the intrinsic is cheap, nothing should change.
; If the intrinsic is expensive, check if the input is zero to avoid the call.
; This is undoing speculation that may have been created by SimplifyCFG + InstCombine.

define i64 @cttz(i64 %A) {
; SLOW-LABEL: @cttz(
; SLOW-NEXT:  entry:
; SLOW-NEXT:    [[Z:%.*]] = call i64 @llvm.cttz.i64(i64 [[A:%.*]], i1 false)
; SLOW-NEXT:    ret i64 [[Z]]
;
; FAST_TZ-LABEL: @cttz(
; FAST_TZ-NEXT:  entry:
; FAST_TZ-NEXT:    [[Z:%.*]] = call i64 @llvm.cttz.i64(i64 [[A:%.*]], i1 false)
; FAST_TZ-NEXT:    ret i64 [[Z]]
;
; FAST_LZ-LABEL: @cttz(
; FAST_LZ-NEXT:  entry:
; FAST_LZ-NEXT:    [[Z:%.*]] = call i64 @llvm.cttz.i64(i64 [[A:%.*]], i1 false)
; FAST_LZ-NEXT:    ret i64 [[Z]]
;
; DEBUGINFO-LABEL: @cttz(
; DEBUGINFO-NEXT:  entry:
; DEBUGINFO-NEXT:    [[Z:%.*]] = call i64 @llvm.cttz.i64(i64 [[A:%.*]], i1 false), !dbg [[DBG11:![0-9]+]]
; DEBUGINFO-NEXT:      #dbg_value(i64 [[Z]], [[META9:![0-9]+]], !DIExpression(), [[DBG11]])
; DEBUGINFO-NEXT:    ret i64 [[Z]], !dbg [[DBG12:![0-9]+]]
;
entry:
  %z = call i64 @llvm.cttz.i64(i64 %A, i1 false)
  ret i64 %z
}

define i64 @ctlz(i64 %A) {
; SLOW-LABEL: @ctlz(
; SLOW-NEXT:  entry:
; SLOW-NEXT:    [[Z:%.*]] = call i64 @llvm.ctlz.i64(i64 [[A:%.*]], i1 false)
; SLOW-NEXT:    ret i64 [[Z]]
;
; FAST_TZ-LABEL: @ctlz(
; FAST_TZ-NEXT:  entry:
; FAST_TZ-NEXT:    [[Z:%.*]] = call i64 @llvm.ctlz.i64(i64 [[A:%.*]], i1 false)
; FAST_TZ-NEXT:    ret i64 [[Z]]
;
; FAST_LZ-LABEL: @ctlz(
; FAST_LZ-NEXT:  entry:
; FAST_LZ-NEXT:    [[Z:%.*]] = call i64 @llvm.ctlz.i64(i64 [[A:%.*]], i1 false)
; FAST_LZ-NEXT:    ret i64 [[Z]]
;
; DEBUGINFO-LABEL: @ctlz(
; DEBUGINFO-NEXT:  entry:
; DEBUGINFO-NEXT:    [[Z:%.*]] = call i64 @llvm.ctlz.i64(i64 [[A:%.*]], i1 false), !dbg [[DBG16:![0-9]+]]
; DEBUGINFO-NEXT:      #dbg_value(i64 [[Z]], [[META15:![0-9]+]], !DIExpression(), [[DBG16]])
; DEBUGINFO-NEXT:    ret i64 [[Z]], !dbg [[DBG17:![0-9]+]]
;
entry:
  %z = call i64 @llvm.ctlz.i64(i64 %A, i1 false)
  ret i64 %z
}

declare i64 @llvm.cttz.i64(i64, i1)
declare i64 @llvm.ctlz.i64(i64, i1)


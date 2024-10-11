; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer,dce -S -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global ptr null, align 8

; Function Attrs: nounwind uwtable
define i32 @fn1() {
; CHECK-LABEL: @fn1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr @a, align 8
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[ADD_PTR]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 2
; CHECK-NEXT:    store i64 [[TMP1]], ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[ARRAYIDX]] to i64
; CHECK-NEXT:    store i64 [[TMP2]], ptr [[ADD_PTR]], align 8
; CHECK-NEXT:    ret i32 undef
;
entry:
  %0 = load ptr, ptr @a, align 8
  %add.ptr = getelementptr inbounds i64, ptr %0, i64 1
  %1 = ptrtoint ptr %add.ptr to i64
  %arrayidx = getelementptr inbounds i64, ptr %0, i64 2
  store i64 %1, ptr %arrayidx, align 8
  %2 = ptrtoint ptr %arrayidx to i64
  store i64 %2, ptr %add.ptr, align 8
  ret i32 undef
}

define void @PR43799() {
; CHECK-LABEL: @PR43799(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BODY:%.*]]
; CHECK:       body:
; CHECK-NEXT:    br label [[BODY]]
; CHECK:       epilog:
; CHECK-NEXT:    ret void
;
entry:
  br label %body

body:
  %p.1.i19 = phi ptr [ undef, %entry ], [ %incdec.ptr.i.7, %body ]
  %lsr.iv17 = phi ptr [ undef, %entry ], [ %scevgep113.7, %body ]
  %incdec.ptr.i.7 = getelementptr inbounds i8, ptr undef, i32 1
  %scevgep113.7 = getelementptr i8, ptr undef, i64 1
  br label %body

epilog:
  ret void
}

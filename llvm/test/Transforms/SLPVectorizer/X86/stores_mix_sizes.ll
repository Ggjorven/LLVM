; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux < %s | FileCheck %s
define void @test(ptr %p) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr [[P:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[IDX1:%.*]] = getelementptr i8, ptr [[P]], i64 1
; CHECK-NEXT:    [[IDX_64_9:%.*]] = getelementptr i64, ptr [[P]], i64 9
; CHECK-NEXT:    store i64 1, ptr [[IDX_64_9]], align 8
; CHECK-NEXT:    store <8 x i8> zeroinitializer, ptr [[IDX1]], align 4
; CHECK-NEXT:    ret void
;
  entry:
  %idx1 = getelementptr i8, ptr %p, i64 1
  store i8 0, ptr %idx1, align 4
  %idx.64.9 = getelementptr i64, ptr %p, i64 9
  store i64 1, ptr %idx.64.9, align 8
  %idx2 = getelementptr i8, ptr %p, i64 2
  store i8 0, ptr %idx2, align 4
  %idx3 = getelementptr i8, ptr %p, i64 3
  store i8 0, ptr %idx3, align 4
  %idx4 = getelementptr i8, ptr %p, i64 4
  store i8 0, ptr %idx4, align 4
  %idx5 = getelementptr i8, ptr %p, i64 5
  store i8 0, ptr %idx5, align 4
  %idx6 = getelementptr i8, ptr %p, i64 6
  store i8 0, ptr %idx6, align 4
  %idx7 = getelementptr i8, ptr %p, i64 7
  store i8 0, ptr %idx7, align 4
  %idx8 = getelementptr i8, ptr %p, i64 8
  store i8 0, ptr %idx8, align 4
  ret void
}

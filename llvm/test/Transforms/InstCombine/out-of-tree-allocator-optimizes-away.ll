; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine %s | FileCheck %s

define void @alloc_elides_test(i32 %data) {
; CHECK-LABEL: @alloc_elides_test(
; CHECK-NEXT:  start:
; CHECK-NEXT:    ret void
;
start:
  %alloc = call ptr @__rust_alloc(i64 4, i64 32)
  store i32 0, ptr %alloc
  %alloc2 = call ptr @__rust_realloc(ptr %alloc, i64 4, i64 32, i64 8)
  store i32 1, ptr %alloc2
  call void @__rust_dealloc(ptr %alloc2, i64 4, i64 32)
  ret void
}

define void @alloc_elides_test_virtual(i32 %data, ptr %alloc, ptr %realloc, ptr %dealloc) {
; CHECK-LABEL: @alloc_elides_test_virtual(
; CHECK-NEXT:  start:
; CHECK-NEXT:    ret void
;
start:
  %a = call noalias ptr %alloc(i64 4, i64 allocalign 32) nounwind allocsize(0) allockind("alloc,uninitialized,aligned") "alloc-family"="__rust_alloc"
  store i32 0, ptr %a
  %a2 = call noalias ptr %realloc(ptr allocptr %a, i64 4, i64 allocalign 32, i64 8) nounwind allocsize(3) allockind("alloc,uninitialized,aligned") "alloc-family"="__rust_alloc"
  store i32 1, ptr %a2
  call void %dealloc(ptr allocptr %a2, i64 4, i64 32) nounwind allockind("free") "alloc-family"="__rust_alloc"
  ret void
}

declare noalias ptr @__rust_alloc(i64, i64 allocalign) nounwind allocsize(0) allockind("alloc,uninitialized,aligned") "alloc-family"="__rust_alloc"

declare noalias ptr @__rust_realloc(ptr allocptr, i64, i64 allocalign, i64) nounwind allocsize(3) allockind("alloc,uninitialized,aligned") "alloc-family"="__rust_alloc"

declare void @__rust_dealloc(ptr allocptr, i64, i64) nounwind allockind("free") "alloc-family"="__rust_alloc"

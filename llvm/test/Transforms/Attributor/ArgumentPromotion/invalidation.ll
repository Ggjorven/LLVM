; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; Check that when argument promotion changes a function in some parent node of
; the call graph, any analyses that happened to be cached for that function are
; actually invalidated. We are using `demanded-bits` here because when printed
; it will end up caching a value for every instruction, making it easy to
; detect the instruction-level changes that will fail here. With improper
; invalidation this will crash in the second printer as it tries to reuse
; now-invalid demanded bits.
;
; RUN: opt < %s -passes='function(print<demanded-bits>),attributor,function(print<demanded-bits>)' -S | FileCheck %s

@G = constant i32 0

;.
; CHECK: @G = constant i32 0
;.
define internal i32 @a(ptr %x) {
entry:
  %v = load i32, ptr %x
  ret i32 %v
}

define i32 @b() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@b
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i32 0
;
entry:
  %v = call i32 @a(ptr @G)
  ret i32 %v
}

define i32 @c() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@c
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i32 0
;
entry:
  %v1 = call i32 @a(ptr @G)
  %v2 = call i32 @b()
  %result = add i32 %v1, %v2
  ret i32 %result
}
;.
; CHECK: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
;.

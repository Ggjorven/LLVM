; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

;; FIXME: support for extractvalue and insertvalue missing.

%0 = type { i32, i32 }

define internal %0 @foo(i1 %Q) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@foo
; CHECK-SAME: (i1 noundef [[Q:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    br i1 [[Q]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       T:
; CHECK-NEXT:    [[MRV:%.*]] = insertvalue [[TMP0:%.*]] undef, i32 21, 0
; CHECK-NEXT:    [[MRV1:%.*]] = insertvalue [[TMP0]] [[MRV]], i32 22, 1
; CHECK-NEXT:    ret [[TMP0]] [[MRV1]]
; CHECK:       F:
; CHECK-NEXT:    [[MRV2:%.*]] = insertvalue [[TMP0]] undef, i32 21, 0
; CHECK-NEXT:    [[MRV3:%.*]] = insertvalue [[TMP0]] [[MRV2]], i32 23, 1
; CHECK-NEXT:    ret [[TMP0]] [[MRV3]]
;
  br i1 %Q, label %T, label %F

T:                                                ; preds = %0
  %mrv = insertvalue %0 undef, i32 21, 0
  %mrv1 = insertvalue %0 %mrv, i32 22, 1
  ret %0 %mrv1

F:                                                ; preds = %0
  %mrv2 = insertvalue %0 undef, i32 21, 0
  %mrv3 = insertvalue %0 %mrv2, i32 23, 1
  ret %0 %mrv3
}

define internal %0 @bar(i1 %Q) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@bar
; CHECK-SAME: (i1 noundef [[Q:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[A:%.*]] = insertvalue [[TMP0:%.*]] undef, i32 21, 0
; CHECK-NEXT:    br i1 [[Q]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       T:
; CHECK-NEXT:    [[B:%.*]] = insertvalue [[TMP0]] [[A]], i32 22, 1
; CHECK-NEXT:    ret [[TMP0]] [[B]]
; CHECK:       F:
; CHECK-NEXT:    [[C:%.*]] = insertvalue [[TMP0]] [[A]], i32 23, 1
; CHECK-NEXT:    ret [[TMP0]] [[C]]
;
  %A = insertvalue %0 undef, i32 21, 0
  br i1 %Q, label %T, label %F

T:                                                ; preds = %0
  %B = insertvalue %0 %A, i32 22, 1
  ret %0 %B

F:                                                ; preds = %0
  %C = insertvalue %0 %A, i32 23, 1
  ret %0 %C
}

define %0 @caller(i1 %Q) {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@caller
; TUNIT-SAME: (i1 [[Q:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[X:%.*]] = call [[TMP0:%.*]] @[[FOO:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i1 noundef [[Q]]) #[[ATTR1:[0-9]+]]
; TUNIT-NEXT:    ret [[TMP0]] [[X]]
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@caller
; CGSCC-SAME: (i1 noundef [[Q:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:    [[X:%.*]] = call [[TMP0:%.*]] @[[FOO:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i1 noundef [[Q]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret [[TMP0]] [[X]]
;
  %X = call %0 @foo(i1 %Q)
  %A = extractvalue %0 %X, 0
  %B = extractvalue %0 %X, 1
  %Y = call %0 @bar(i1 %Q)
  %C = extractvalue %0 %Y, 0
  %D = extractvalue %0 %Y, 1
  %M = add i32 %A, %C
  %N = add i32 %B, %D
  ret %0 %X
}

; Similar to @caller but the result of both calls are actually used.
define i32 @caller2(i1 %Q) {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@caller2
; TUNIT-SAME: (i1 [[Q:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[X:%.*]] = call [[TMP0:%.*]] @[[FOO]](i1 noundef [[Q]]) #[[ATTR1]]
; TUNIT-NEXT:    [[A:%.*]] = extractvalue [[TMP0]] [[X]], 0
; TUNIT-NEXT:    [[B:%.*]] = extractvalue [[TMP0]] [[X]], 1
; TUNIT-NEXT:    [[Y:%.*]] = call [[TMP0]] @[[BAR:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i1 noundef [[Q]]) #[[ATTR1]]
; TUNIT-NEXT:    [[C:%.*]] = extractvalue [[TMP0]] [[Y]], 0
; TUNIT-NEXT:    [[D:%.*]] = extractvalue [[TMP0]] [[Y]], 1
; TUNIT-NEXT:    [[M:%.*]] = add i32 [[A]], [[C]]
; TUNIT-NEXT:    [[N:%.*]] = add i32 [[B]], [[D]]
; TUNIT-NEXT:    [[R:%.*]] = add i32 [[N]], [[M]]
; TUNIT-NEXT:    ret i32 [[R]]
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@caller2
; CGSCC-SAME: (i1 noundef [[Q:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[X:%.*]] = call [[TMP0:%.*]] @[[FOO]](i1 noundef [[Q]]) #[[ATTR2]]
; CGSCC-NEXT:    [[A:%.*]] = extractvalue [[TMP0]] [[X]], 0
; CGSCC-NEXT:    [[B:%.*]] = extractvalue [[TMP0]] [[X]], 1
; CGSCC-NEXT:    [[Y:%.*]] = call [[TMP0]] @[[BAR:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i1 noundef [[Q]]) #[[ATTR2]]
; CGSCC-NEXT:    [[C:%.*]] = extractvalue [[TMP0]] [[Y]], 0
; CGSCC-NEXT:    [[D:%.*]] = extractvalue [[TMP0]] [[Y]], 1
; CGSCC-NEXT:    [[M:%.*]] = add i32 [[A]], [[C]]
; CGSCC-NEXT:    [[N:%.*]] = add i32 [[B]], [[D]]
; CGSCC-NEXT:    [[R:%.*]] = add i32 [[N]], [[M]]
; CGSCC-NEXT:    ret i32 [[R]]
;
  %X = call %0 @foo(i1 %Q)
  %A = extractvalue %0 %X, 0
  %B = extractvalue %0 %X, 1
  %Y = call %0 @bar(i1 %Q)
  %C = extractvalue %0 %Y, 0
  %D = extractvalue %0 %Y, 1
  %M = add i32 %A, %C
;; Check that the second return values didn't get propagated
  %N = add i32 %B, %D
  %R = add i32 %N, %M
  ret i32 %R
}
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; TUNIT: attributes #[[ATTR1]] = { nofree nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2]] = { nofree nosync willreturn }
;.

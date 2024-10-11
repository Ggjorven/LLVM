; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=atomic-expand -codegen-opt-level=1 -S -mtriple=thumbv7s-apple-ios7.0 %s | FileCheck %s

; Intrinsic for "dmb ishst" is then expected
define i32 @test_cmpxchg_seq_cst(ptr %addr, i32 %desired, i32 %new) {
; CHECK-LABEL: define i32 @test_cmpxchg_seq_cst(
; CHECK-SAME: ptr [[ADDR:%.*]], i32 [[DESIRED:%.*]], i32 [[NEW:%.*]]) {
; CHECK-NEXT:    br label %[[CMPXCHG_START:.*]]
; CHECK:       [[CMPXCHG_START]]:
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.arm.ldrex.p0(ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SHOULD_STORE:%.*]] = icmp eq i32 [[TMP1]], [[DESIRED]]
; CHECK-NEXT:    br i1 [[SHOULD_STORE]], label %[[CMPXCHG_FENCEDSTORE:.*]], label %[[CMPXCHG_NOSTORE:.*]]
; CHECK:       [[CMPXCHG_FENCEDSTORE]]:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 10)
; CHECK-NEXT:    br label %[[CMPXCHG_TRYSTORE:.*]]
; CHECK:       [[CMPXCHG_TRYSTORE]]:
; CHECK-NEXT:    [[LOADED_TRYSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_FENCEDSTORE]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.strex.p0(i32 [[NEW]], ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SUCCESS:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[SUCCESS]], label %[[CMPXCHG_SUCCESS:.*]], label %[[CMPXCHG_FAILURE:.*]]
; CHECK:       [[CMPXCHG_RELEASEDLOAD:.*:]]
; CHECK-NEXT:    unreachable
; CHECK:       [[CMPXCHG_SUCCESS]]:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    br label %[[CMPXCHG_END:.*]]
; CHECK:       [[CMPXCHG_NOSTORE]]:
; CHECK-NEXT:    [[LOADED_NOSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_START]] ]
; CHECK-NEXT:    call void @llvm.arm.clrex()
; CHECK-NEXT:    br label %[[CMPXCHG_FAILURE]]
; CHECK:       [[CMPXCHG_FAILURE]]:
; CHECK-NEXT:    [[LOADED_FAILURE:%.*]] = phi i32 [ [[LOADED_NOSTORE]], %[[CMPXCHG_NOSTORE]] ], [ [[LOADED_TRYSTORE]], %[[CMPXCHG_TRYSTORE]] ]
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    br label %[[CMPXCHG_END]]
; CHECK:       [[CMPXCHG_END]]:
; CHECK-NEXT:    [[LOADED_EXIT:%.*]] = phi i32 [ [[LOADED_TRYSTORE]], %[[CMPXCHG_SUCCESS]] ], [ [[LOADED_FAILURE]], %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    [[SUCCESS1:%.*]] = phi i1 [ true, %[[CMPXCHG_SUCCESS]] ], [ false, %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    ret i32 [[LOADED_EXIT]]
;
  %pair = cmpxchg weak ptr %addr, i32 %desired, i32 %new seq_cst seq_cst
  %oldval = extractvalue { i32, i1 } %pair, 0
  ret i32 %oldval
}

define i1 @test_cmpxchg_weak_fail(ptr %addr, i32 %desired, i32 %new) {
; CHECK-LABEL: define i1 @test_cmpxchg_weak_fail(
; CHECK-SAME: ptr [[ADDR:%.*]], i32 [[DESIRED:%.*]], i32 [[NEW:%.*]]) {
; CHECK-NEXT:    br label %[[CMPXCHG_START:.*]]
; CHECK:       [[CMPXCHG_START]]:
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.arm.ldrex.p0(ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SHOULD_STORE:%.*]] = icmp eq i32 [[TMP1]], [[DESIRED]]
; CHECK-NEXT:    br i1 [[SHOULD_STORE]], label %[[CMPXCHG_FENCEDSTORE:.*]], label %[[CMPXCHG_NOSTORE:.*]]
; CHECK:       [[CMPXCHG_FENCEDSTORE]]:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 10)
; CHECK-NEXT:    br label %[[CMPXCHG_TRYSTORE:.*]]
; CHECK:       [[CMPXCHG_TRYSTORE]]:
; CHECK-NEXT:    [[LOADED_TRYSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_FENCEDSTORE]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.strex.p0(i32 [[NEW]], ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SUCCESS:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[SUCCESS]], label %[[CMPXCHG_SUCCESS:.*]], label %[[CMPXCHG_FAILURE:.*]]
; CHECK:       [[CMPXCHG_RELEASEDLOAD:.*:]]
; CHECK-NEXT:    unreachable
; CHECK:       [[CMPXCHG_SUCCESS]]:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    br label %[[CMPXCHG_END:.*]]
; CHECK:       [[CMPXCHG_NOSTORE]]:
; CHECK-NEXT:    [[LOADED_NOSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_START]] ]
; CHECK-NEXT:    call void @llvm.arm.clrex()
; CHECK-NEXT:    br label %[[CMPXCHG_FAILURE]]
; CHECK:       [[CMPXCHG_FAILURE]]:
; CHECK-NEXT:    [[LOADED_FAILURE:%.*]] = phi i32 [ [[LOADED_NOSTORE]], %[[CMPXCHG_NOSTORE]] ], [ [[LOADED_TRYSTORE]], %[[CMPXCHG_TRYSTORE]] ]
; CHECK-NEXT:    br label %[[CMPXCHG_END]]
; CHECK:       [[CMPXCHG_END]]:
; CHECK-NEXT:    [[LOADED_EXIT:%.*]] = phi i32 [ [[LOADED_TRYSTORE]], %[[CMPXCHG_SUCCESS]] ], [ [[LOADED_FAILURE]], %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    [[SUCCESS1:%.*]] = phi i1 [ true, %[[CMPXCHG_SUCCESS]] ], [ false, %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    ret i1 [[SUCCESS1]]
;
  %pair = cmpxchg weak ptr %addr, i32 %desired, i32 %new seq_cst monotonic
  %oldval = extractvalue { i32, i1 } %pair, 1
  ret i1 %oldval
}

define i32 @test_cmpxchg_monotonic(ptr %addr, i32 %desired, i32 %new) {
; CHECK-LABEL: define i32 @test_cmpxchg_monotonic(
; CHECK-SAME: ptr [[ADDR:%.*]], i32 [[DESIRED:%.*]], i32 [[NEW:%.*]]) {
; CHECK-NEXT:    br label %[[CMPXCHG_START:.*]]
; CHECK:       [[CMPXCHG_START]]:
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.arm.ldrex.p0(ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SHOULD_STORE:%.*]] = icmp eq i32 [[TMP1]], [[DESIRED]]
; CHECK-NEXT:    br i1 [[SHOULD_STORE]], label %[[CMPXCHG_FENCEDSTORE:.*]], label %[[CMPXCHG_NOSTORE:.*]]
; CHECK:       [[CMPXCHG_FENCEDSTORE]]:
; CHECK-NEXT:    br label %[[CMPXCHG_TRYSTORE:.*]]
; CHECK:       [[CMPXCHG_TRYSTORE]]:
; CHECK-NEXT:    [[LOADED_TRYSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_FENCEDSTORE]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.strex.p0(i32 [[NEW]], ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SUCCESS:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[SUCCESS]], label %[[CMPXCHG_SUCCESS:.*]], label %[[CMPXCHG_FAILURE:.*]]
; CHECK:       [[CMPXCHG_RELEASEDLOAD:.*:]]
; CHECK-NEXT:    unreachable
; CHECK:       [[CMPXCHG_SUCCESS]]:
; CHECK-NEXT:    br label %[[CMPXCHG_END:.*]]
; CHECK:       [[CMPXCHG_NOSTORE]]:
; CHECK-NEXT:    [[LOADED_NOSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_START]] ]
; CHECK-NEXT:    call void @llvm.arm.clrex()
; CHECK-NEXT:    br label %[[CMPXCHG_FAILURE]]
; CHECK:       [[CMPXCHG_FAILURE]]:
; CHECK-NEXT:    [[LOADED_FAILURE:%.*]] = phi i32 [ [[LOADED_NOSTORE]], %[[CMPXCHG_NOSTORE]] ], [ [[LOADED_TRYSTORE]], %[[CMPXCHG_TRYSTORE]] ]
; CHECK-NEXT:    br label %[[CMPXCHG_END]]
; CHECK:       [[CMPXCHG_END]]:
; CHECK-NEXT:    [[LOADED_EXIT:%.*]] = phi i32 [ [[LOADED_TRYSTORE]], %[[CMPXCHG_SUCCESS]] ], [ [[LOADED_FAILURE]], %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    [[SUCCESS1:%.*]] = phi i1 [ true, %[[CMPXCHG_SUCCESS]] ], [ false, %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    ret i32 [[LOADED_EXIT]]
;
  %pair = cmpxchg weak ptr %addr, i32 %desired, i32 %new monotonic monotonic
  %oldval = extractvalue { i32, i1 } %pair, 0
  ret i32 %oldval
}

define i32 @test_cmpxchg_seq_cst_minsize(ptr %addr, i32 %desired, i32 %new) minsize {
; CHECK-LABEL: define i32 @test_cmpxchg_seq_cst_minsize(
; CHECK-SAME: ptr [[ADDR:%.*]], i32 [[DESIRED:%.*]], i32 [[NEW:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    br label %[[CMPXCHG_START:.*]]
; CHECK:       [[CMPXCHG_START]]:
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.arm.ldrex.p0(ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SHOULD_STORE:%.*]] = icmp eq i32 [[TMP1]], [[DESIRED]]
; CHECK-NEXT:    br i1 [[SHOULD_STORE]], label %[[CMPXCHG_FENCEDSTORE:.*]], label %[[CMPXCHG_NOSTORE:.*]]
; CHECK:       [[CMPXCHG_FENCEDSTORE]]:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 10)
; CHECK-NEXT:    br label %[[CMPXCHG_TRYSTORE:.*]]
; CHECK:       [[CMPXCHG_TRYSTORE]]:
; CHECK-NEXT:    [[LOADED_TRYSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_FENCEDSTORE]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.strex.p0(i32 [[NEW]], ptr elementtype(i32) [[ADDR]])
; CHECK-NEXT:    [[SUCCESS:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[SUCCESS]], label %[[CMPXCHG_SUCCESS:.*]], label %[[CMPXCHG_FAILURE:.*]]
; CHECK:       [[CMPXCHG_RELEASEDLOAD:.*:]]
; CHECK-NEXT:    unreachable
; CHECK:       [[CMPXCHG_SUCCESS]]:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    br label %[[CMPXCHG_END:.*]]
; CHECK:       [[CMPXCHG_NOSTORE]]:
; CHECK-NEXT:    [[LOADED_NOSTORE:%.*]] = phi i32 [ [[TMP1]], %[[CMPXCHG_START]] ]
; CHECK-NEXT:    call void @llvm.arm.clrex()
; CHECK-NEXT:    br label %[[CMPXCHG_FAILURE]]
; CHECK:       [[CMPXCHG_FAILURE]]:
; CHECK-NEXT:    [[LOADED_FAILURE:%.*]] = phi i32 [ [[LOADED_NOSTORE]], %[[CMPXCHG_NOSTORE]] ], [ [[LOADED_TRYSTORE]], %[[CMPXCHG_TRYSTORE]] ]
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    br label %[[CMPXCHG_END]]
; CHECK:       [[CMPXCHG_END]]:
; CHECK-NEXT:    [[LOADED_EXIT:%.*]] = phi i32 [ [[LOADED_TRYSTORE]], %[[CMPXCHG_SUCCESS]] ], [ [[LOADED_FAILURE]], %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    [[SUCCESS1:%.*]] = phi i1 [ true, %[[CMPXCHG_SUCCESS]] ], [ false, %[[CMPXCHG_FAILURE]] ]
; CHECK-NEXT:    ret i32 [[LOADED_EXIT]]
;
  %pair = cmpxchg weak ptr %addr, i32 %desired, i32 %new seq_cst seq_cst
  %oldval = extractvalue { i32, i1 } %pair, 0
  ret i32 %oldval
}

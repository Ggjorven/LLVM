; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S -passes=separate-const-offset-from-gep < %s | FileCheck %s

define void @illegal_addr_mode(ptr %in.ptr, i64 %in.idx0, i64 %in.idx1) {
; CHECK-LABEL: define void @illegal_addr_mode(
; CHECK-SAME: ptr [[IN_PTR:%.*]], i64 [[IN_IDX0:%.*]], i64 [[IN_IDX1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BASE:%.*]] = getelementptr i64, ptr [[IN_PTR]], i64 [[IN_IDX0]]
; CHECK-NEXT:    [[IDX0:%.*]] = getelementptr i64, ptr [[BASE]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST1:%.*]] = getelementptr i64, ptr [[BASE]], i64 256
; CHECK-NEXT:    [[IDX1:%.*]] = getelementptr i64, ptr [[CONST1]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST2:%.*]] = getelementptr i64, ptr [[BASE]], i64 512
; CHECK-NEXT:    [[IDX2:%.*]] = getelementptr i64, ptr [[CONST2]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST3:%.*]] = getelementptr i64, ptr [[BASE]], i64 768
; CHECK-NEXT:    [[IDX3:%.*]] = getelementptr i64, ptr [[CONST3]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CMP0:%.*]] = icmp eq i64 [[IN_IDX0]], 0
; CHECK-NEXT:    br i1 [[CMP0]], label [[BB_1:%.*]], label [[END:%.*]]
; CHECK:       bb.1:
; CHECK-NEXT:    [[VAL0:%.*]] = load <8 x i64>, ptr [[IDX0]], align 16
; CHECK-NEXT:    [[VAL1:%.*]] = load <8 x i64>, ptr [[IDX1]], align 16
; CHECK-NEXT:    [[VAL2:%.*]] = load <8 x i64>, ptr [[IDX2]], align 16
; CHECK-NEXT:    [[VAL3:%.*]] = load <8 x i64>, ptr [[IDX3]], align 16
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    ret void
;
entry:
  %base = getelementptr i64, ptr %in.ptr, i64 %in.idx0
  %idx0 = getelementptr i64, ptr %base, i64 %in.idx1
  %const1 = getelementptr i64, ptr %base, i64 256
  %idx1 = getelementptr i64, ptr %const1, i64 %in.idx1
  %const2 = getelementptr i64, ptr %base, i64 512
  %idx2 = getelementptr i64, ptr %const2, i64 %in.idx1
  %const3 = getelementptr i64, ptr %base, i64 768
  %idx3 = getelementptr i64, ptr %const3, i64 %in.idx1
  %cmp0 = icmp eq i64 %in.idx0, 0
  br i1 %cmp0, label %bb.1, label %end

bb.1:
  %val0 = load <8 x i64>, ptr %idx0, align 16
  %val1 = load <8 x i64>, ptr %idx1, align 16
  %val2 = load <8 x i64>, ptr %idx2, align 16
  %val3 = load <8 x i64>, ptr %idx3, align 16
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val0)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val1)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val2)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val3)
  br label %end

end:
  call void asm sideeffect "; use $0", "v"(ptr %idx0)
  call void asm sideeffect "; use $0", "v"(ptr %idx1)
  call void asm sideeffect "; use $0", "v"(ptr %idx2)
  call void asm sideeffect "; use $0", "v"(ptr %idx3)
  ret void
}


define void @multi_index_reorder(ptr %in.ptr, i64 %in.idx0, i64 %in.idx1) {
; CHECK-LABEL: define void @multi_index_reorder(
; CHECK-SAME: ptr [[IN_PTR:%.*]], i64 [[IN_IDX0:%.*]], i64 [[IN_IDX1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[IDX0:%.*]] = getelementptr [8192 x i64], ptr [[IN_PTR]], i64 0, i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST1:%.*]] = getelementptr [8192 x i64], ptr [[IN_PTR]], i64 0, i64 256
; CHECK-NEXT:    [[IDX1:%.*]] = getelementptr i64, ptr [[CONST1]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST2:%.*]] = getelementptr [8192 x i64], ptr [[IN_PTR]], i64 0, i64 512
; CHECK-NEXT:    [[IDX2:%.*]] = getelementptr i64, ptr [[CONST2]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST3:%.*]] = getelementptr [8192 x i64], ptr [[IN_PTR]], i64 0, i64 768
; CHECK-NEXT:    [[IDX3:%.*]] = getelementptr i64, ptr [[CONST3]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CMP0:%.*]] = icmp eq i64 [[IN_IDX0]], 0
; CHECK-NEXT:    br i1 [[CMP0]], label [[BB_1:%.*]], label [[END:%.*]]
; CHECK:       bb.1:
; CHECK-NEXT:    [[VAL0:%.*]] = load <8 x i64>, ptr [[IDX0]], align 16
; CHECK-NEXT:    [[VAL1:%.*]] = load <8 x i64>, ptr [[IDX1]], align 16
; CHECK-NEXT:    [[VAL2:%.*]] = load <8 x i64>, ptr [[IDX2]], align 16
; CHECK-NEXT:    [[VAL3:%.*]] = load <8 x i64>, ptr [[IDX3]], align 16
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    ret void
;
entry:
  %idx0 = getelementptr [8192 x i64], ptr %in.ptr, i64 0, i64 %in.idx1
  %const1 = getelementptr [8192 x i64], ptr %in.ptr, i64 0, i64 256
  %idx1 = getelementptr i64, ptr %const1, i64 %in.idx1
  %const2 = getelementptr [8192 x i64], ptr %in.ptr, i64 0, i64 512
  %idx2 = getelementptr i64, ptr %const2, i64 %in.idx1
  %const3 = getelementptr [8192 x i64], ptr %in.ptr, i64 0, i64 768
  %idx3 = getelementptr i64, ptr %const3, i64 %in.idx1
  %cmp0 = icmp eq i64 %in.idx0, 0
  br i1 %cmp0, label %bb.1, label %end

bb.1:
  %val0 = load <8 x i64>, ptr %idx0, align 16
  %val1 = load <8 x i64>, ptr %idx1, align 16
  %val2 = load <8 x i64>, ptr %idx2, align 16
  %val3 = load <8 x i64>, ptr %idx3, align 16
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val0)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val1)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val2)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val3)
  br label %end

end:
  call void asm sideeffect "; use $0", "v"(ptr %idx0)
  call void asm sideeffect "; use $0", "v"(ptr %idx1)
  call void asm sideeffect "; use $0", "v"(ptr %idx2)
  call void asm sideeffect "; use $0", "v"(ptr %idx3)
  ret void
}


define void @different_type_reorder(ptr %in.ptr, i64 %in.idx0, i64 %in.idx1) {
; CHECK-LABEL: define void @different_type_reorder(
; CHECK-SAME: ptr [[IN_PTR:%.*]], i64 [[IN_IDX0:%.*]], i64 [[IN_IDX1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BASE:%.*]] = getelementptr i64, ptr [[IN_PTR]], i64 [[IN_IDX0]]
; CHECK-NEXT:    [[IDX0:%.*]] = getelementptr i64, ptr [[BASE]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST1:%.*]] = getelementptr i8, ptr [[BASE]], i64 256
; CHECK-NEXT:    [[IDX1:%.*]] = getelementptr i64, ptr [[CONST1]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST2:%.*]] = getelementptr i8, ptr [[BASE]], i64 512
; CHECK-NEXT:    [[IDX2:%.*]] = getelementptr i64, ptr [[CONST2]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST3:%.*]] = getelementptr i8, ptr [[BASE]], i64 768
; CHECK-NEXT:    [[IDX3:%.*]] = getelementptr i64, ptr [[CONST3]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CMP0:%.*]] = icmp eq i64 [[IN_IDX0]], 0
; CHECK-NEXT:    br i1 [[CMP0]], label [[BB_1:%.*]], label [[END:%.*]]
; CHECK:       bb.1:
; CHECK-NEXT:    [[VAL0:%.*]] = load <8 x i64>, ptr [[IDX0]], align 16
; CHECK-NEXT:    [[VAL1:%.*]] = load <8 x i64>, ptr [[IDX1]], align 16
; CHECK-NEXT:    [[VAL2:%.*]] = load <8 x i64>, ptr [[IDX2]], align 16
; CHECK-NEXT:    [[VAL3:%.*]] = load <8 x i64>, ptr [[IDX3]], align 16
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    ret void
;
entry:
  %base = getelementptr i64, ptr %in.ptr, i64 %in.idx0
  %idx0 = getelementptr i64, ptr %base, i64 %in.idx1
  %const1 = getelementptr i8, ptr %base, i64 256
  %idx1 = getelementptr i64, ptr %const1, i64 %in.idx1
  %const2 = getelementptr i8, ptr %base, i64 512
  %idx2 = getelementptr i64, ptr %const2, i64 %in.idx1
  %const3 = getelementptr i8, ptr %base, i64 768
  %idx3 = getelementptr i64, ptr %const3, i64 %in.idx1
  %cmp0 = icmp eq i64 %in.idx0, 0
  br i1 %cmp0, label %bb.1, label %end

bb.1:
  %val0 = load <8 x i64>, ptr %idx0, align 16
  %val1 = load <8 x i64>, ptr %idx1, align 16
  %val2 = load <8 x i64>, ptr %idx2, align 16
  %val3 = load <8 x i64>, ptr %idx3, align 16
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val0)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val1)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val2)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val3)
  br label %end

end:
  call void asm sideeffect "; use $0", "v"(ptr %idx0)
  call void asm sideeffect "; use $0", "v"(ptr %idx1)
  call void asm sideeffect "; use $0", "v"(ptr %idx2)
  call void asm sideeffect "; use $0", "v"(ptr %idx3)
  ret void
}


define void @different_type_reorder2(ptr %in.ptr, i64 %in.idx0, i64 %in.idx1) {
; CHECK-LABEL: define void @different_type_reorder2(
; CHECK-SAME: ptr [[IN_PTR:%.*]], i64 [[IN_IDX0:%.*]], i64 [[IN_IDX1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BASE:%.*]] = getelementptr i8, ptr [[IN_PTR]], i64 [[IN_IDX0]]
; CHECK-NEXT:    [[IDX0:%.*]] = getelementptr i8, ptr [[BASE]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST1:%.*]] = getelementptr i64, ptr [[BASE]], i64 256
; CHECK-NEXT:    [[IDX1:%.*]] = getelementptr i8, ptr [[CONST1]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST2:%.*]] = getelementptr i64, ptr [[BASE]], i64 512
; CHECK-NEXT:    [[IDX2:%.*]] = getelementptr i8, ptr [[CONST2]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CONST3:%.*]] = getelementptr i64, ptr [[BASE]], i64 768
; CHECK-NEXT:    [[IDX3:%.*]] = getelementptr i8, ptr [[CONST3]], i64 [[IN_IDX1]]
; CHECK-NEXT:    [[CMP0:%.*]] = icmp eq i64 [[IN_IDX0]], 0
; CHECK-NEXT:    br i1 [[CMP0]], label [[BB_1:%.*]], label [[END:%.*]]
; CHECK:       bb.1:
; CHECK-NEXT:    [[VAL0:%.*]] = load <8 x i64>, ptr [[IDX0]], align 16
; CHECK-NEXT:    [[VAL1:%.*]] = load <8 x i64>, ptr [[IDX1]], align 16
; CHECK-NEXT:    [[VAL2:%.*]] = load <8 x i64>, ptr [[IDX2]], align 16
; CHECK-NEXT:    [[VAL3:%.*]] = load <8 x i64>, ptr [[IDX3]], align 16
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    ret void
;
entry:
  %base = getelementptr i8, ptr %in.ptr, i64 %in.idx0
  %idx0 = getelementptr i8, ptr %base, i64 %in.idx1
  %const1 = getelementptr i64, ptr %base, i64 256
  %idx1 = getelementptr i8, ptr %const1, i64 %in.idx1
  %const2 = getelementptr i64, ptr %base, i64 512
  %idx2 = getelementptr i8, ptr %const2, i64 %in.idx1
  %const3 = getelementptr i64, ptr %base, i64 768
  %idx3 = getelementptr i8, ptr %const3, i64 %in.idx1
  %cmp0 = icmp eq i64 %in.idx0, 0
  br i1 %cmp0, label %bb.1, label %end

bb.1:
  %val0 = load <8 x i64>, ptr %idx0, align 16
  %val1 = load <8 x i64>, ptr %idx1, align 16
  %val2 = load <8 x i64>, ptr %idx2, align 16
  %val3 = load <8 x i64>, ptr %idx3, align 16
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val0)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val1)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val2)
  call void asm sideeffect "; use $0", "v"(<8 x i64> %val3)
  br label %end

end:
  call void asm sideeffect "; use $0", "v"(ptr %idx0)
  call void asm sideeffect "; use $0", "v"(ptr %idx1)
  call void asm sideeffect "; use $0", "v"(ptr %idx2)
  call void asm sideeffect "; use $0", "v"(ptr %idx3)
  ret void
}

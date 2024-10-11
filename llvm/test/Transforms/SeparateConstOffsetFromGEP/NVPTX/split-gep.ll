; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -mtriple=nvptx64-nvidia-cuda -passes=separate-const-offset-from-gep \
; RUN:       -reassociate-geps-verify-no-dead-code -S | FileCheck %s

; Several unit tests for separate-const-offset-from-gep. The transformation
; heavily relies on TargetTransformInfo, so we put these tests under
; target-specific folders.

%struct.S = type { float, double }

@struct_array = global [1024 x %struct.S] zeroinitializer, align 16
@float_2d_array = global [32 x [32 x float]] zeroinitializer, align 4

; We should not extract any struct field indices, because fields in a struct
; may have different types.
define ptr @struct(i32 %i) {
; CHECK-LABEL: define ptr @struct(
; CHECK-SAME: i32 [[I:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [1024 x %struct.S], ptr @struct_array, i64 0, i64 [[TMP0]], i32 1
; CHECK-NEXT:    [[P2:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 80
; CHECK-NEXT:    ret ptr [[P2]]
;
entry:
  %add = add nsw i32 %i, 5
  %idxprom = sext i32 %add to i64
  %p = getelementptr inbounds [1024 x %struct.S], ptr @struct_array, i64 0, i64 %idxprom, i32 1
  ret ptr %p
}

; We should be able to trace into sext(a + b) if a + b is non-negative
; (e.g., used as an index of an inbounds GEP) and one of a and b is
; non-negative.
define ptr @sext_add(i32 %i, i32 %j) {
; CHECK-LABEL: define ptr @sext_add(
; CHECK-SAME: i32 [[I:%.*]], i32 [[J:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[J]], -2
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[TMP2]], i64 [[TMP1]]
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i64 128
; CHECK-NEXT:    ret ptr [[P1]]
;
entry:
  %0 = add i32 %i, 1
  %1 = sext i32 %0 to i64  ; inbound sext(i + 1) = sext(i) + 1
  %2 = add i32 %j, -2
  ; However, inbound sext(j + -2) != sext(j) + -2, e.g., j = INT_MIN
  %3 = sext i32 %2 to i64
  %p = getelementptr inbounds [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %1, i64 %3
  ret ptr %p
}

; We should be able to trace into sext/zext if it can be distributed to both
; operands, e.g., sext (add nsw a, b) == add nsw (sext a), (sext b)
;
; This test verifies we can transform
;   gep base, a + sext(b +nsw 1), c + zext(d +nuw 1)
; to
;   gep base, a + sext(b), c + zext(d); gep ..., 1 * 32 + 1
define ptr @ext_add_no_overflow(i64 %a, i32 %b, i64 %c, i32 %d) {
; CHECK-LABEL: define ptr @ext_add_no_overflow(
; CHECK-SAME: i64 [[A:%.*]], i32 [[B:%.*]], i64 [[C:%.*]], i32 [[D:%.*]]) {
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[B]] to i64
; CHECK-NEXT:    [[I2:%.*]] = add i64 [[A]], [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[D]] to i64
; CHECK-NEXT:    [[J4:%.*]] = add i64 [[C]], [[TMP2]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[I2]], i64 [[J4]]
; CHECK-NEXT:    [[P5:%.*]] = getelementptr inbounds i8, ptr [[TMP3]], i64 132
; CHECK-NEXT:    ret ptr [[P5]]
;
  %b1 = add nsw i32 %b, 1
  %b2 = sext i32 %b1 to i64
  %i = add i64 %a, %b2       ; i = a + sext(b +nsw 1)
  %d1 = add nuw i32 %d, 1
  %d2 = zext i32 %d1 to i64
  %j = add i64 %c, %d2       ; j = c + zext(d +nuw 1)
  %p = getelementptr inbounds [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %i, i64 %j
  ret ptr %p
}

; Verifies we handle nested sext/zext correctly.
define void @sext_zext(i32 %a, i32 %b, ptr %out1, ptr %out2) {
; CHECK-LABEL: define void @sext_zext(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], ptr [[OUT1:%.*]], ptr [[OUT2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i32 [[B]], 2
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[TMP0]] to i48
; CHECK-NEXT:    [[TMP2:%.*]] = zext i48 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = sext i32 [[A]] to i48
; CHECK-NEXT:    [[TMP4:%.*]] = zext i48 [[TMP3]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[TMP4]], i64 [[TMP2]]
; CHECK-NEXT:    [[P11:%.*]] = getelementptr i8, ptr [[TMP5]], i64 128
; CHECK-NEXT:    store ptr [[P11]], ptr [[OUT1]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = add nsw i32 [[B]], 4
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP6]] to i48
; CHECK-NEXT:    [[TMP8:%.*]] = sext i48 [[TMP7]] to i64
; CHECK-NEXT:    [[TMP9:%.*]] = zext i32 [[A]] to i48
; CHECK-NEXT:    [[TMP10:%.*]] = sext i48 [[TMP9]] to i64
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[TMP10]], i64 [[TMP8]]
; CHECK-NEXT:    [[P22:%.*]] = getelementptr i8, ptr [[TMP11]], i64 384
; CHECK-NEXT:    store ptr [[P22]], ptr [[OUT2]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %0 = add nsw nuw i32 %a, 1
  %1 = sext i32 %0 to i48
  %2 = zext i48 %1 to i64    ; zext(sext(a +nsw nuw 1)) = zext(sext(a)) + 1
  %3 = add nsw i32 %b, 2
  %4 = sext i32 %3 to i48
  %5 = zext i48 %4 to i64    ; zext(sext(b +nsw 2)) != zext(sext(b)) + 2
  %p1 = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %2, i64 %5
  store ptr %p1, ptr %out1
  %6 = add nuw i32 %a, 3
  %7 = zext i32 %6 to i48
  %8 = sext i48 %7 to i64 ; sext(zext(a +nuw 3)) = zext(a +nuw 3) = zext(a) + 3
  %9 = add nsw i32 %b, 4
  %10 = zext i32 %9 to i48
  %11 = sext i48 %10 to i64  ; sext(zext(b +nsw 4)) != zext(b) + 4
  %p2 = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %8, i64 %11
  store ptr %p2, ptr %out2
  ret void
}

; Similar to @ext_add_no_overflow, we should be able to trace into s/zext if
; its operand is an OR and the two operands of the OR have no common bits.
define ptr @sext_or(i64 %a, i32 %b) {
; CHECK-LABEL: define ptr @sext_or(
; CHECK-SAME: i64 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B1:%.*]] = shl i32 [[B]], 2
; CHECK-NEXT:    [[B3:%.*]] = or i32 [[B1]], 4
; CHECK-NEXT:    [[B3_EXT:%.*]] = sext i32 [[B3]] to i64
; CHECK-NEXT:    [[J:%.*]] = add i64 [[A]], [[B3_EXT]]
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[B1]] to i64
; CHECK-NEXT:    [[I2:%.*]] = add i64 [[A]], [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[I2]], i64 [[J]]
; CHECK-NEXT:    [[P3:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 128
; CHECK-NEXT:    ret ptr [[P3]]
;
entry:
  %b1 = shl i32 %b, 2
  %b2 = or disjoint i32 %b1, 1 ; (b << 2) and 1 have no common bits
  %b3 = or i32 %b1, 4 ; (b << 2) and 4 may have common bits
  %b2.ext = zext i32 %b2 to i64
  %b3.ext = sext i32 %b3 to i64
  %i = add i64 %a, %b2.ext
  %j = add i64 %a, %b3.ext
  %p = getelementptr inbounds [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %i, i64 %j
  ret ptr %p
}

; The subexpression (b + 5) is used in both "i = a + (b + 5)" and "*out = b +
; 5". When extracting the constant offset 5, make sure "*out = b + 5" isn't
; affected.
define ptr @expr(i64 %a, i64 %b, ptr %out) {
; CHECK-LABEL: define ptr @expr(
; CHECK-SAME: i64 [[A:%.*]], i64 [[B:%.*]], ptr [[OUT:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B5:%.*]] = add i64 [[B]], 5
; CHECK-NEXT:    [[I2:%.*]] = add i64 [[B]], [[A]]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[I2]], i64 0
; CHECK-NEXT:    [[P3:%.*]] = getelementptr inbounds i8, ptr [[TMP0]], i64 640
; CHECK-NEXT:    store i64 [[B5]], ptr [[OUT]], align 8
; CHECK-NEXT:    ret ptr [[P3]]
;
entry:
  %b5 = add i64 %b, 5
  %i = add i64 %b5, %a
  %p = getelementptr inbounds [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %i, i64 0
  store i64 %b5, ptr %out
  ret ptr %p
}

; d + sext(a +nsw (b +nsw (c +nsw 8))) => (d + sext(a) + sext(b) + sext(c)) + 8
define ptr @sext_expr(i32 %a, i32 %b, i32 %c, i64 %d) {
; CHECK-LABEL: define ptr @sext_expr(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i32 [[C:%.*]], i64 [[D:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[A]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[B]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = sext i32 [[C]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP0]], [[TMP3]]
; CHECK-NEXT:    [[I1:%.*]] = add i64 [[D]], [[TMP4]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 [[I1]]
; CHECK-NEXT:    [[P2:%.*]] = getelementptr inbounds i8, ptr [[TMP5]], i64 32
; CHECK-NEXT:    ret ptr [[P2]]
;
entry:
  %0 = add nsw i32 %c, 8
  %1 = add nsw i32 %b, %0
  %2 = add nsw i32 %a, %1
  %3 = sext i32 %2 to i64
  %i = add i64 %d, %3
  %p = getelementptr inbounds [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 %i
  ret ptr %p
}

; Verifies we handle "sub" correctly.
define ptr @sub(i64 %i, i64 %j) {
; CHECK-LABEL: define ptr @sub(
; CHECK-SAME: i64 [[I:%.*]], i64 [[J:%.*]]) {
; CHECK-NEXT:    [[J22:%.*]] = sub i64 0, [[J]]
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 [[I]], i64 [[J22]]
; CHECK-NEXT:    [[P3:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 -620
; CHECK-NEXT:    ret ptr [[P3]]
;
  %i2 = sub i64 %i, 5 ; i - 5
  %j2 = sub i64 5, %j ; 5 - i
  %p = getelementptr inbounds [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 %i2, i64 %j2
  ret ptr %p
}

%struct.Packed = type <{ [3 x i32], [8 x i64] }> ; <> means packed

; Verifies we can emit correct uglygep if the address is not natually aligned.
define ptr @packed_struct(i32 %i, i32 %j) {
; CHECK-LABEL: define ptr @packed_struct(
; CHECK-SAME: i32 [[I:%.*]], i32 [[J:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[S:%.*]] = alloca [1024 x %struct.Packed], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[J]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr [1024 x %struct.Packed], ptr [[S]], i64 0, i64 [[TMP0]], i32 1, i64 [[TMP1]]
; CHECK-NEXT:    [[ARRAYIDX33:%.*]] = getelementptr inbounds i8, ptr [[TMP2]], i64 100
; CHECK-NEXT:    ret ptr [[ARRAYIDX33]]
;
entry:
  %s = alloca [1024 x %struct.Packed], align 16
  %add = add nsw i32 %j, 3
  %idxprom = sext i32 %add to i64
  %add1 = add nsw i32 %i, 1
  %idxprom2 = sext i32 %add1 to i64
  %arrayidx3 = getelementptr inbounds [1024 x %struct.Packed], ptr %s, i64 0, i64 %idxprom2, i32 1, i64 %idxprom
  ret ptr %arrayidx3
}

; We shouldn't be able to extract the 8 from "zext(a +nuw (b + 8))",
; because "zext(b + 8) != zext(b) + 8"
define ptr @zext_expr(i32 %a, i32 %b) {
; CHECK-LABEL: define ptr @zext_expr(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[B]], 8
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw i32 [[A]], [[TMP0]]
; CHECK-NEXT:    [[I:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[P:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 [[I]]
; CHECK-NEXT:    ret ptr [[P]]
;
entry:
  %0 = add i32 %b, 8
  %1 = add nuw i32 %a, %0
  %i = zext i32 %1 to i64
  %p = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 %i
  ret ptr %p
}

; Per http://llvm.org/docs/LangRef.html#id181, the indices of a off-bound gep
; should be considered sign-extended to the pointer size. Therefore,
;   gep base, (add i32 a, b) != gep (gep base, i32 a), i32 b
; because
;   sext(a + b) != sext(a) + sext(b)
;
; This test verifies we do not illegitimately extract the 8 from
;   gep base, (i32 a + 8)
define ptr @i32_add(i32 %a) {
; CHECK-LABEL: define ptr @i32_add(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = add i32 [[A]], 8
; CHECK-NEXT:    [[IDXPROM:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[P:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 [[IDXPROM]]
; CHECK-NEXT:    ret ptr [[P]]
;
entry:
  %i = add i32 %a, 8
  %p = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i32 %i
  ret ptr %p
}

; Verifies that we compute the correct constant offset when the index is
; sign-extended and then zero-extended. The old version of our code failed to
; handle this case because it simply computed the constant offset as the
; sign-extended value of the constant part of the GEP index.
define ptr @apint(i1 %a) {
; CHECK-LABEL: define ptr @apint(
; CHECK-SAME: i1 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sext i1 [[A]] to i4
; CHECK-NEXT:    [[TMP1:%.*]] = zext i4 [[TMP0]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[P1:%.*]] = getelementptr i8, ptr [[TMP2]], i64 60
; CHECK-NEXT:    ret ptr [[P1]]
;
entry:
  %0 = add nsw nuw i1 %a, 1
  %1 = sext i1 %0 to i4
  %2 = zext i4 %1 to i64         ; zext (sext i1 1 to i4) to i64 = 15
  %p = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 %2
  ret ptr %p
}

; Do not trace into binary operators other than ADD, SUB, and OR.
define ptr @and(i64 %a) {
; CHECK-LABEL: define ptr @and(
; CHECK-SAME: i64 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = shl i64 [[A]], 2
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 1
; CHECK-NEXT:    [[P:%.*]] = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 [[TMP1]]
; CHECK-NEXT:    ret ptr [[P]]
;
entry:
  %0 = shl i64 %a, 2
  %1 = and i64 %0, 1
  %p = getelementptr [32 x [32 x float]], ptr @float_2d_array, i64 0, i64 0, i64 %1
  ret ptr %p
}

; The code that rebuilds an OR expression used to be buggy, and failed on this
; test.
define ptr @shl_add_or(i64 %a, ptr %ptr) {
; CHECK-LABEL: define ptr @shl_add_or(
; CHECK-SAME: i64 [[A:%.*]], ptr [[PTR:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SHL:%.*]] = shl i64 [[A]], 2
; CHECK-NEXT:    [[OR2:%.*]] = add i64 [[SHL]], 1
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr float, ptr [[PTR]], i64 [[OR2]]
; CHECK-NEXT:    [[P3:%.*]] = getelementptr i8, ptr [[TMP0]], i64 48
; CHECK-NEXT:    ret ptr [[P3]]
;
entry:
  %shl = shl i64 %a, 2
  %add = add i64 %shl, 12
  %or = or disjoint i64 %add, 1
  ; ((a << 2) + 12) and 1 have no common bits. Therefore,
  ; SeparateConstOffsetFromGEP is able to extract the 12.
  ; TODO(jingyue): We could reassociate the expression to combine 12 and 1.
  %p = getelementptr float, ptr %ptr, i64 %or
  ret ptr %p
}

; The source code used to be buggy in checking
; (AccumulativeByteOffset % ElementTypeSizeOfGEP == 0)
; where AccumulativeByteOffset is signed but ElementTypeSizeOfGEP is unsigned.
; The compiler would promote AccumulativeByteOffset to unsigned, causing
; unexpected results. For example, while -64 % (int64_t)24 != 0,
; -64 % (uint64_t)24 == 0.
%struct3 = type { i64, i32 }
%struct2 = type { %struct3, i32 }
%struct1 = type { i64, %struct2 }
%struct0 = type { i32, i32, ptr, [100 x %struct1] }
define ptr @sign_mod_unsign(ptr %ptr, i64 %idx) {
; CHECK-LABEL: define ptr @sign_mod_unsign(
; CHECK-SAME: ptr [[PTR:%.*]], i64 [[IDX:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT0:%.*]], ptr [[PTR]], i64 0, i32 3, i64 [[IDX]], i32 1
; CHECK-NEXT:    [[PTR22:%.*]] = getelementptr inbounds i8, ptr [[TMP0]], i64 -64
; CHECK-NEXT:    ret ptr [[PTR22]]
;
entry:
  %arrayidx = add nsw i64 %idx, -2
  %ptr2 = getelementptr inbounds %struct0, ptr %ptr, i64 0, i32 3, i64 %arrayidx, i32 1
  ret ptr %ptr2
}

; Check that we can see through explicit trunc() instruction.
define ptr @trunk_explicit(ptr %ptr, i64 %idx) {
; CHECK-LABEL: define ptr @trunk_explicit(
; CHECK-SAME: ptr [[PTR:%.*]], i64 [[IDX:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT0:%.*]], ptr [[PTR]], i64 0, i32 3, i64 [[IDX]], i32 1
; CHECK-NEXT:    [[PTR21:%.*]] = getelementptr inbounds i8, ptr [[TMP0]], i64 3216
; CHECK-NEXT:    ret ptr [[PTR21]]
;
entry:
  %idx0 = trunc i64 1 to i32
  %ptr2 = getelementptr inbounds %struct0, ptr %ptr, i32 %idx0, i32 3, i64 %idx, i32 1
  ret ptr %ptr2
}

; Check that we can deal with trunc inserted by
; canonicalizeArrayIndicesToPointerSize() if size of an index is larger than
; that of the pointer.
define ptr @trunk_long_idx(ptr %ptr, i64 %idx) {
; CHECK-LABEL: define ptr @trunk_long_idx(
; CHECK-SAME: ptr [[PTR:%.*]], i64 [[IDX:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr [[STRUCT0:%.*]], ptr [[PTR]], i64 0, i32 3, i64 [[IDX]], i32 1
; CHECK-NEXT:    [[PTR21:%.*]] = getelementptr inbounds i8, ptr [[TMP0]], i64 3216
; CHECK-NEXT:    ret ptr [[PTR21]]
;
entry:
  %ptr2 = getelementptr inbounds %struct0, ptr %ptr, i65 1, i32 3, i64 %idx, i32 1
  ret ptr %ptr2
}

; Do not extract large constant offset that cannot be folded in to PTX
; addressing mode
define void @large_offset(ptr %out, i32 %in) {
; CHECK-LABEL: define void @large_offset(
; CHECK-SAME: ptr [[OUT:%.*]], i32 [[IN:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[TMP0]], 536870912
; CHECK-NEXT:    [[IDX:%.*]] = zext nneg i32 [[ADD]] to i64
; CHECK-NEXT:    [[GETELEM:%.*]] = getelementptr inbounds i32, ptr [[OUT]], i64 [[IDX]]
; CHECK-NEXT:    store i32 [[IN]], ptr [[GETELEM]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x()
  %add = add nuw nsw i32 %0, 536870912
  %idx = zext nneg i32 %add to i64
  %getElem = getelementptr inbounds i32, ptr %out, i64 %idx
  store i32 %in, ptr %getElem, align 4
  ret void
}

declare i32 @llvm.nvvm.read.ptx.sreg.tid.x()

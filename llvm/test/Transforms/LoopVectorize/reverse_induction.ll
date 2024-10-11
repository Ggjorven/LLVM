; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=loop-vectorize -force-vector-interleave=2 -force-vector-width=4 -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

; Make sure consecutive vector generates correct negative indices.
; PR15882

define i32 @reverse_induction_i64(i64 %startval, ptr %ptr) {
; CHECK-LABEL: define i32 @reverse_induction_i64(
; CHECK-SAME: i64 [[STARTVAL:%.*]], ptr [[PTR:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[IND_END:%.*]] = sub i64 [[STARTVAL]], 1024
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP10:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP11:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = sub i64 [[STARTVAL]], [[INDEX]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP0]], -1
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[TMP14]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 -3
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[TMP14]], i32 -4
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP8]], i32 -3
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <4 x i32>, ptr [[TMP9]], align 4
; CHECK-NEXT:    [[REVERSE4:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD3]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP10]] = add <4 x i32> [[REVERSE]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP11]] = add <4 x i32> [[REVERSE4]], [[VEC_PHI2]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; CHECK-NEXT:    br i1 [[TMP12]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP11]], [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX]])
; CHECK-NEXT:    br i1 true, label %[[LOOPEND:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], %[[MIDDLE_BLOCK]] ], [ [[STARTVAL]], %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i32 [ 1024, %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP13]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[ADD_I7:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[ADD_I:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[I_06:%.*]] = phi i32 [ [[BC_RESUME_VAL1]], %[[SCALAR_PH]] ], [ [[INC4:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[REDUX5:%.*]] = phi i32 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[INC_REDUX:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD_I]] = add i64 [[ADD_I7]], -1
; CHECK-NEXT:    [[KIND__I:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i64 [[ADD_I]]
; CHECK-NEXT:    [[TMP_I1:%.*]] = load i32, ptr [[KIND__I]], align 4
; CHECK-NEXT:    [[INC_REDUX]] = add i32 [[TMP_I1]], [[REDUX5]]
; CHECK-NEXT:    [[INC4]] = add i32 [[I_06]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC4]], 1024
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_BODY]], label %[[LOOPEND]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[LOOPEND]]:
; CHECK-NEXT:    [[INC_REDUX_LCSSA:%.*]] = phi i32 [ [[INC_REDUX]], %[[FOR_BODY]] ], [ [[TMP13]], %[[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[INC_REDUX_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %add.i7 = phi i64 [ %startval, %entry ], [ %add.i, %for.body ]
  %i.06 = phi i32 [ 0, %entry ], [ %inc4, %for.body ]
  %redux5 = phi i32 [ 0, %entry ], [ %inc.redux, %for.body ]
  %add.i = add i64 %add.i7, -1
  %kind_.i = getelementptr inbounds i32, ptr %ptr, i64 %add.i
  %tmp.i1 = load i32, ptr %kind_.i, align 4
  %inc.redux = add i32 %tmp.i1, %redux5
  %inc4 = add i32 %i.06, 1
  %exitcond = icmp ne i32 %inc4, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret i32 %inc.redux
}


define i32 @reverse_induction_i128(i128 %startval, ptr %ptr) {
; CHECK-LABEL: define i32 @reverse_induction_i128(
; CHECK-SAME: i128 [[STARTVAL:%.*]], ptr [[PTR:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[IND_END:%.*]] = sub i128 [[STARTVAL]], 1024
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i128 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP10:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP11:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = sub i128 [[STARTVAL]], [[INDEX]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i128 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i128 [[TMP0]], -1
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i128 [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[TMP14]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 -3
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[TMP14]], i32 -4
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP8]], i32 -3
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <4 x i32>, ptr [[TMP9]], align 4
; CHECK-NEXT:    [[REVERSE4:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD3]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP10]] = add <4 x i32> [[REVERSE]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP11]] = add <4 x i32> [[REVERSE4]], [[VEC_PHI2]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i128 [[INDEX]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i128 [[INDEX_NEXT]], 1024
; CHECK-NEXT:    br i1 [[TMP12]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP11]], [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX]])
; CHECK-NEXT:    br i1 true, label %[[LOOPEND:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i128 [ [[IND_END]], %[[MIDDLE_BLOCK]] ], [ [[STARTVAL]], %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i32 [ 1024, %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP13]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[ADD_I7:%.*]] = phi i128 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[ADD_I:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[I_06:%.*]] = phi i32 [ [[BC_RESUME_VAL1]], %[[SCALAR_PH]] ], [ [[INC4:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[REDUX5:%.*]] = phi i32 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[INC_REDUX:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD_I]] = add i128 [[ADD_I7]], -1
; CHECK-NEXT:    [[KIND__I:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i128 [[ADD_I]]
; CHECK-NEXT:    [[TMP_I1:%.*]] = load i32, ptr [[KIND__I]], align 4
; CHECK-NEXT:    [[INC_REDUX]] = add i32 [[TMP_I1]], [[REDUX5]]
; CHECK-NEXT:    [[INC4]] = add i32 [[I_06]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC4]], 1024
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_BODY]], label %[[LOOPEND]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       [[LOOPEND]]:
; CHECK-NEXT:    [[INC_REDUX_LCSSA:%.*]] = phi i32 [ [[INC_REDUX]], %[[FOR_BODY]] ], [ [[TMP13]], %[[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[INC_REDUX_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %add.i7 = phi i128 [ %startval, %entry ], [ %add.i, %for.body ]
  %i.06 = phi i32 [ 0, %entry ], [ %inc4, %for.body ]
  %redux5 = phi i32 [ 0, %entry ], [ %inc.redux, %for.body ]
  %add.i = add i128 %add.i7, -1
  %kind_.i = getelementptr inbounds i32, ptr %ptr, i128 %add.i
  %tmp.i1 = load i32, ptr %kind_.i, align 4
  %inc.redux = add i32 %tmp.i1, %redux5
  %inc4 = add i32 %i.06, 1
  %exitcond = icmp ne i32 %inc4, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret i32 %inc.redux
}


define i32 @reverse_induction_i16(i16 %startval, ptr %ptr) {
; CHECK-LABEL: define i32 @reverse_induction_i16(
; CHECK-SAME: i16 [[STARTVAL:%.*]], ptr [[PTR:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_SCEVCHECK:.*]]
; CHECK:       [[VECTOR_SCEVCHECK]]:
; CHECK-NEXT:    [[TMP0:%.*]] = add i16 [[STARTVAL]], -1
; CHECK-NEXT:    [[MUL:%.*]] = call { i16, i1 } @llvm.umul.with.overflow.i16(i16 1, i16 1023)
; CHECK-NEXT:    [[MUL_RESULT:%.*]] = extractvalue { i16, i1 } [[MUL]], 0
; CHECK-NEXT:    [[MUL_OVERFLOW:%.*]] = extractvalue { i16, i1 } [[MUL]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = sub i16 [[TMP0]], [[MUL_RESULT]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i16 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = or i1 [[TMP2]], [[MUL_OVERFLOW]]
; CHECK-NEXT:    br i1 [[TMP3]], label %[[SCALAR_PH]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[IND_END:%.*]] = sub i16 [[STARTVAL]], 1024
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP14:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP15:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[DOTCAST:%.*]] = trunc i32 [[INDEX]] to i16
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = sub i16 [[STARTVAL]], [[DOTCAST]]
; CHECK-NEXT:    [[TMP4:%.*]] = add i16 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP8:%.*]] = add i16 [[TMP4]], -1
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i16 [[TMP8]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i32, ptr [[TMP18]], i32 0
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, ptr [[TMP10]], i32 -3
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i32, ptr [[TMP18]], i32 -4
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, ptr [[TMP12]], i32 -3
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP11]], align 4
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <4 x i32>, ptr [[TMP13]], align 4
; CHECK-NEXT:    [[REVERSE4:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD3]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP14]] = add <4 x i32> [[REVERSE]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP15]] = add <4 x i32> [[REVERSE4]], [[VEC_PHI2]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 8
; CHECK-NEXT:    [[TMP16:%.*]] = icmp eq i32 [[INDEX_NEXT]], 1024
; CHECK-NEXT:    br i1 [[TMP16]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP15]], [[TMP14]]
; CHECK-NEXT:    [[TMP17:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX]])
; CHECK-NEXT:    br i1 true, label %[[LOOPEND:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i16 [ [[IND_END]], %[[MIDDLE_BLOCK]] ], [ [[STARTVAL]], %[[ENTRY]] ], [ [[STARTVAL]], %[[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i32 [ 1024, %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ], [ 0, %[[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP17]], %[[MIDDLE_BLOCK]] ], [ 0, %[[VECTOR_SCEVCHECK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[ADD_I7:%.*]] = phi i16 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[ADD_I:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[I_06:%.*]] = phi i32 [ [[BC_RESUME_VAL1]], %[[SCALAR_PH]] ], [ [[INC4:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[REDUX5:%.*]] = phi i32 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[INC_REDUX:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD_I]] = add i16 [[ADD_I7]], -1
; CHECK-NEXT:    [[KIND__I:%.*]] = getelementptr inbounds i32, ptr [[PTR]], i16 [[ADD_I]]
; CHECK-NEXT:    [[TMP_I1:%.*]] = load i32, ptr [[KIND__I]], align 4
; CHECK-NEXT:    [[INC_REDUX]] = add i32 [[TMP_I1]], [[REDUX5]]
; CHECK-NEXT:    [[INC4]] = add i32 [[I_06]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[INC4]], 1024
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_BODY]], label %[[LOOPEND]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       [[LOOPEND]]:
; CHECK-NEXT:    [[INC_REDUX_LCSSA:%.*]] = phi i32 [ [[INC_REDUX]], %[[FOR_BODY]] ], [ [[TMP17]], %[[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[INC_REDUX_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %add.i7 = phi i16 [ %startval, %entry ], [ %add.i, %for.body ]
  %i.06 = phi i32 [ 0, %entry ], [ %inc4, %for.body ]
  %redux5 = phi i32 [ 0, %entry ], [ %inc.redux, %for.body ]
  %add.i = add i16 %add.i7, -1
  %kind_.i = getelementptr inbounds i32, ptr %ptr, i16 %add.i
  %tmp.i1 = load i32, ptr %kind_.i, align 4
  %inc.redux = add i32 %tmp.i1, %redux5
  %inc4 = add i32 %i.06, 1
  %exitcond = icmp ne i32 %inc4, 1024
  br i1 %exitcond, label %for.body, label %loopend

loopend:
  ret i32 %inc.redux
}


@a = common global [1024 x i32] zeroinitializer, align 16

; We incorrectly transformed this loop into an empty one because we left the
; induction variable in i8 type and truncated the exit value 1024 to 0.
; int a[1024];
;
; void fail() {
;   int reverse_induction = 1023;
;   unsigned char forward_induction = 0;
;   while ((reverse_induction) >= 0) {
;     forward_induction++;
;     a[reverse_induction] = forward_induction;
;     --reverse_induction;
;   }
; }


define void @reverse_forward_induction_i64_i8() {
; CHECK-LABEL: define void @reverse_forward_induction_i64_i8() {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i8> [ <i8 0, i8 1, i8 2, i8 3>, %[[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[STEP_ADD:%.*]] = add <4 x i8> [[VEC_IND]], <i8 4, i8 4, i8 4, i8 4>
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = sub i64 1023, [[INDEX]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = add <4 x i8> [[VEC_IND]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP3:%.*]] = add <4 x i8> [[STEP_ADD]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP4:%.*]] = zext <4 x i8> [[TMP2]] to <4 x i32>
; CHECK-NEXT:    [[TMP5:%.*]] = zext <4 x i8> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [1024 x i32], ptr @a, i64 0, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP8]], i32 -3
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 -4
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, ptr [[TMP10]], i32 -3
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i32> [[TMP4]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    store <4 x i32> [[REVERSE]], ptr [[TMP9]], align 4
; CHECK-NEXT:    [[REVERSE2:%.*]] = shufflevector <4 x i32> [[TMP5]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    store <4 x i32> [[REVERSE2]], ptr [[TMP11]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i8> [[STEP_ADD]], <i8 4, i8 4, i8 4, i8 4>
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; CHECK-NEXT:    br i1 [[TMP12]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[WHILE_END:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ -1, %[[MIDDLE_BLOCK]] ], [ 1023, %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i8 [ 0, %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[WHILE_BODY:.*]]
; CHECK:       [[WHILE_BODY]]:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], %[[WHILE_BODY]] ]
; CHECK-NEXT:    [[FORWARD_INDUCTION_05:%.*]] = phi i8 [ [[BC_RESUME_VAL1]], %[[SCALAR_PH]] ], [ [[INC:%.*]], %[[WHILE_BODY]] ]
; CHECK-NEXT:    [[INC]] = add i8 [[FORWARD_INDUCTION_05]], 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[INC]] to i32
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1024 x i32], ptr @a, i64 0, i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[TMP13:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP13]], 0
; CHECK-NEXT:    br i1 [[CMP]], label %[[WHILE_BODY]], label %[[WHILE_END]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       [[WHILE_END]]:
; CHECK-NEXT:    ret void
;
entry:
  br label %while.body

while.body:
  %indvars.iv = phi i64 [ 1023, %entry ], [ %indvars.iv.next, %while.body ]
  %forward_induction.05 = phi i8 [ 0, %entry ], [ %inc, %while.body ]
  %inc = add i8 %forward_induction.05, 1
  %conv = zext i8 %inc to i32
  %arrayidx = getelementptr inbounds [1024 x i32], ptr @a, i64 0, i64 %indvars.iv
  store i32 %conv, ptr %arrayidx, align 4
  %indvars.iv.next = add i64 %indvars.iv, -1
  %0 = trunc i64 %indvars.iv to i32
  %cmp = icmp sgt i32 %0, 0
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}


define void @reverse_forward_induction_i64_i8_signed() {
; CHECK-LABEL: define void @reverse_forward_induction_i64_i8_signed() {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i8> [ <i8 -127, i8 -126, i8 -125, i8 -124>, %[[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[STEP_ADD:%.*]] = add <4 x i8> [[VEC_IND]], <i8 4, i8 4, i8 4, i8 4>
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = sub i64 1023, [[INDEX]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = add <4 x i8> [[VEC_IND]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP3:%.*]] = add <4 x i8> [[STEP_ADD]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP4:%.*]] = sext <4 x i8> [[TMP2]] to <4 x i32>
; CHECK-NEXT:    [[TMP5:%.*]] = sext <4 x i8> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [1024 x i32], ptr @a, i64 0, i64 [[TMP0]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, ptr [[TMP8]], i32 -3
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i32, ptr [[TMP6]], i32 -4
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, ptr [[TMP10]], i32 -3
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i32> [[TMP4]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    store <4 x i32> [[REVERSE]], ptr [[TMP9]], align 4
; CHECK-NEXT:    [[REVERSE2:%.*]] = shufflevector <4 x i32> [[TMP5]], <4 x i32> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    store <4 x i32> [[REVERSE2]], ptr [[TMP11]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i8> [[STEP_ADD]], <i8 4, i8 4, i8 4, i8 4>
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; CHECK-NEXT:    br i1 [[TMP12]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP10:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[WHILE_END:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ -1, %[[MIDDLE_BLOCK]] ], [ 1023, %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i8 [ -127, %[[MIDDLE_BLOCK]] ], [ -127, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[WHILE_BODY:.*]]
; CHECK:       [[WHILE_BODY]]:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], %[[WHILE_BODY]] ]
; CHECK-NEXT:    [[FORWARD_INDUCTION_05:%.*]] = phi i8 [ [[BC_RESUME_VAL1]], %[[SCALAR_PH]] ], [ [[INC:%.*]], %[[WHILE_BODY]] ]
; CHECK-NEXT:    [[INC]] = add i8 [[FORWARD_INDUCTION_05]], 1
; CHECK-NEXT:    [[CONV:%.*]] = sext i8 [[INC]] to i32
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1024 x i32], ptr @a, i64 0, i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[CONV]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[TMP13:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP13]], 0
; CHECK-NEXT:    br i1 [[CMP]], label %[[WHILE_BODY]], label %[[WHILE_END]], !llvm.loop [[LOOP11:![0-9]+]]
; CHECK:       [[WHILE_END]]:
; CHECK-NEXT:    ret void
;
entry:
  br label %while.body

while.body:
  %indvars.iv = phi i64 [ 1023, %entry ], [ %indvars.iv.next, %while.body ]
  %forward_induction.05 = phi i8 [ -127, %entry ], [ %inc, %while.body ]
  %inc = add i8 %forward_induction.05, 1
  %conv = sext i8 %inc to i32
  %arrayidx = getelementptr inbounds [1024 x i32], ptr @a, i64 0, i64 %indvars.iv
  store i32 %conv, ptr %arrayidx, align 4
  %indvars.iv.next = add i64 %indvars.iv, -1
  %0 = trunc i64 %indvars.iv to i32
  %cmp = icmp sgt i32 %0, 0
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
; CHECK: [[LOOP4]] = distinct !{[[LOOP4]], [[META1]], [[META2]]}
; CHECK: [[LOOP5]] = distinct !{[[LOOP5]], [[META2]], [[META1]]}
; CHECK: [[LOOP6]] = distinct !{[[LOOP6]], [[META1]], [[META2]]}
; CHECK: [[LOOP7]] = distinct !{[[LOOP7]], [[META1]]}
; CHECK: [[LOOP8]] = distinct !{[[LOOP8]], [[META1]], [[META2]]}
; CHECK: [[LOOP9]] = distinct !{[[LOOP9]], [[META2]], [[META1]]}
; CHECK: [[LOOP10]] = distinct !{[[LOOP10]], [[META1]], [[META2]]}
; CHECK: [[LOOP11]] = distinct !{[[LOOP11]], [[META2]], [[META1]]}
;.

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize,instcombine,simplifycfg < %s -S -o - | FileCheck %s --check-prefix=CHECK
; RUN: opt -passes=loop-vectorize -debug-only=loop-vectorize -disable-output < %s 2>&1 | FileCheck %s --check-prefix=CHECK-COST
; REQUIRES: asserts

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv8.1m.main-arm-none-eabi"

; CHECK-COST-LABEL: test
; CHECK-COST: LV: Found an estimated cost of 1 for VF 1 For instruction:   %or.cond = select i1 %cmp2, i1 true, i1 %cmp3
; CHECK-COST: LV: Found an estimated cost of 26 for VF 2 For instruction:   %or.cond = select i1 %cmp2, i1 true, i1 %cmp3
; CHECK-COST: LV: Found an estimated cost of 2 for VF 4 For instruction:   %or.cond = select i1 %cmp2, i1 true, i1 %cmp3

define float @test(ptr nocapture readonly %pA, ptr nocapture readonly %pB, i32 %blockSize) #0 {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_NOT16:%.*]] = icmp eq i32 [[BLOCKSIZE:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP_NOT16]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; CHECK:       while.body.preheader:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[BLOCKSIZE]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i32 [[BLOCKSIZE]], -4
; CHECK-NEXT:    [[TMP0:%.*]] = shl i32 [[N_VEC]], 2
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[PA:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = shl i32 [[N_VEC]], 2
; CHECK-NEXT:    [[IND_END1:%.*]] = getelementptr i8, ptr [[PB:%.*]], i32 [[TMP1]]
; CHECK-NEXT:    [[IND_END3:%.*]] = and i32 [[BLOCKSIZE]], 3
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[PREDPHI:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = shl i32 [[INDEX]], 2
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[PA]], i32 [[OFFSET_IDX]]
; CHECK-NEXT:    [[OFFSET_IDX5:%.*]] = shl i32 [[INDEX]], 2
; CHECK-NEXT:    [[NEXT_GEP6:%.*]] = getelementptr i8, ptr [[PB]], i32 [[OFFSET_IDX5]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, ptr [[NEXT_GEP]], align 4
; CHECK-NEXT:    [[WIDE_LOAD7:%.*]] = load <4 x float>, ptr [[NEXT_GEP6]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = fcmp fast oeq <4 x float> [[WIDE_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = fcmp fast oeq <4 x float> [[WIDE_LOAD7]], zeroinitializer
; CHECK-NEXT:    [[DOTNOT9:%.*]] = select <4 x i1> [[TMP2]], <4 x i1> [[TMP3]], <4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = call fast <4 x float> @llvm.fabs.v4f32(<4 x float> [[WIDE_LOAD]])
; CHECK-NEXT:    [[TMP5:%.*]] = call fast <4 x float> @llvm.fabs.v4f32(<4 x float> [[WIDE_LOAD7]])
; CHECK-NEXT:    [[TMP6:%.*]] = fadd fast <4 x float> [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = fsub fast <4 x float> [[WIDE_LOAD]], [[WIDE_LOAD7]]
; CHECK-NEXT:    [[TMP8:%.*]] = call fast <4 x float> @llvm.fabs.v4f32(<4 x float> [[TMP7]])
; CHECK-NEXT:    [[TMP9:%.*]] = fdiv fast <4 x float> [[TMP8]], [[TMP6]]
; CHECK-NEXT:    [[TMP10:%.*]] = fadd fast <4 x float> [[TMP9]], [[VEC_PHI]]
; CHECK-NEXT:    [[PREDPHI]] = select <4 x i1> [[DOTNOT9]], <4 x float> [[VEC_PHI]], <4 x float> [[TMP10]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP12:%.*]] = call fast float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> [[PREDPHI]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[BLOCKSIZE]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[WHILE_END]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[PA]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi ptr [ [[IND_END1]], [[MIDDLE_BLOCK]] ], [ [[PB]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL4:%.*]] = phi i32 [ [[IND_END3]], [[MIDDLE_BLOCK]] ], [ [[BLOCKSIZE]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ [[TMP12]], [[MIDDLE_BLOCK]] ], [ 0.000000e+00, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[PA_ADDR_020:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[IF_END:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[PB_ADDR_019:%.*]] = phi ptr [ [[INCDEC_PTR1:%.*]], [[IF_END]] ], [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[BLOCKSIZE_ADDR_018:%.*]] = phi i32 [ [[DEC:%.*]], [[IF_END]] ], [ [[BC_RESUME_VAL4]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ACCUM_017:%.*]] = phi float [ [[ACCUM_1:%.*]], [[IF_END]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i8, ptr [[PA_ADDR_020]], i32 4
; CHECK-NEXT:    [[TMP13:%.*]] = load float, ptr [[PA_ADDR_020]], align 4
; CHECK-NEXT:    [[INCDEC_PTR1]] = getelementptr inbounds i8, ptr [[PB_ADDR_019]], i32 4
; CHECK-NEXT:    [[TMP14:%.*]] = load float, ptr [[PB_ADDR_019]], align 4
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp fast une float [[TMP13]], 0.000000e+00
; CHECK-NEXT:    [[CMP3:%.*]] = fcmp fast une float [[TMP14]], 0.000000e+00
; CHECK-NEXT:    [[OR_COND:%.*]] = select i1 [[CMP2]], i1 true, i1 [[CMP3]]
; CHECK-NEXT:    br i1 [[OR_COND]], label [[IF_THEN:%.*]], label [[IF_END]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TMP15:%.*]] = tail call fast float @llvm.fabs.f32(float [[TMP13]])
; CHECK-NEXT:    [[TMP16:%.*]] = tail call fast float @llvm.fabs.f32(float [[TMP14]])
; CHECK-NEXT:    [[ADD:%.*]] = fadd fast float [[TMP16]], [[TMP15]]
; CHECK-NEXT:    [[SUB:%.*]] = fsub fast float [[TMP13]], [[TMP14]]
; CHECK-NEXT:    [[TMP17:%.*]] = tail call fast float @llvm.fabs.f32(float [[SUB]])
; CHECK-NEXT:    [[DIV:%.*]] = fdiv fast float [[TMP17]], [[ADD]]
; CHECK-NEXT:    [[ADD4:%.*]] = fadd fast float [[DIV]], [[ACCUM_017]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ACCUM_1]] = phi float [ [[ADD4]], [[IF_THEN]] ], [ [[ACCUM_017]], [[WHILE_BODY]] ]
; CHECK-NEXT:    [[DEC]] = add i32 [[BLOCKSIZE_ADDR_018]], -1
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[DEC]], 0
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[WHILE_END]], label [[WHILE_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       while.end:
; CHECK-NEXT:    [[ACCUM_0_LCSSA:%.*]] = phi float [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[ACCUM_1]], [[IF_END]] ], [ [[TMP12]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[ACCUM_0_LCSSA]]
;
entry:
  %cmp.not16 = icmp eq i32 %blockSize, 0
  br i1 %cmp.not16, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %if.end
  %pA.addr.020 = phi ptr [ %incdec.ptr, %if.end ], [ %pA, %entry ]
  %pB.addr.019 = phi ptr [ %incdec.ptr1, %if.end ], [ %pB, %entry ]
  %blockSize.addr.018 = phi i32 [ %dec, %if.end ], [ %blockSize, %entry ]
  %accum.017 = phi float [ %accum.1, %if.end ], [ 0.000000e+00, %entry ]
  %incdec.ptr = getelementptr inbounds float, ptr %pA.addr.020, i32 1
  %0 = load float, ptr %pA.addr.020, align 4
  %incdec.ptr1 = getelementptr inbounds float, ptr %pB.addr.019, i32 1
  %1 = load float, ptr %pB.addr.019, align 4
  %cmp2 = fcmp fast une float %0, 0.000000e+00
  %cmp3 = fcmp fast une float %1, 0.000000e+00
  %or.cond = select i1 %cmp2, i1 true, i1 %cmp3
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %2 = tail call fast float @llvm.fabs.f32(float %0)
  %3 = tail call fast float @llvm.fabs.f32(float %1)
  %add = fadd fast float %3, %2
  %sub = fsub fast float %0, %1
  %4 = tail call fast float @llvm.fabs.f32(float %sub)
  %div = fdiv fast float %4, %add
  %add4 = fadd fast float %div, %accum.017
  br label %if.end

if.end:                                           ; preds = %while.body, %if.then
  %accum.1 = phi float [ %add4, %if.then ], [ %accum.017, %while.body ]
  %dec = add i32 %blockSize.addr.018, -1
  %cmp.not = icmp eq i32 %dec, 0
  br i1 %cmp.not, label %while.end, label %while.body

while.end:                                        ; preds = %if.end, %entry
  %accum.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %accum.1, %if.end ]
  ret float %accum.0.lcssa
}

declare float @llvm.fabs.f32(float)

attributes #0 = { "target-features"="+mve.fp" }
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-COST: {{.*}}

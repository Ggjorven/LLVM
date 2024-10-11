; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-vectorize,dce,instcombine < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128-ni:1"
target triple = "x86_64-unknown-linux-gnu"

; Ensure that the 'inbounds' is preserved on the GEPs that feed the load and store in the loop.
define void @foo(ptr addrspace(1) align 8 dereferenceable_or_null(16), ptr addrspace(1) align 8 dereferenceable_or_null(8), i64) #0 {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[DOT10:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP0:%.*]], i64 16
; CHECK-NEXT:    [[DOT12:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP1:%.*]], i64 16
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP2:%.*]], 16
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP2]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP3]], 16
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr addrspace(1) [[TMP0]], i64 [[TMP4]]
; CHECK-NEXT:    [[SCEVGEP1:%.*]] = getelementptr i8, ptr addrspace(1) [[TMP1]], i64 [[TMP4]]
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr addrspace(1) [[DOT10]], [[SCEVGEP1]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr addrspace(1) [[DOT12]], [[SCEVGEP]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[TMP2]], -16
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) [[DOT12]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP5]], i64 32
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP5]], i64 64
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP5]], i64 96
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x ptr addrspace(1)>, ptr addrspace(1) [[TMP5]], align 8, !alias.scope [[META0:![0-9]+]]
; CHECK-NEXT:    [[WIDE_LOAD3:%.*]] = load <4 x ptr addrspace(1)>, ptr addrspace(1) [[TMP6]], align 8, !alias.scope [[META0]]
; CHECK-NEXT:    [[WIDE_LOAD4:%.*]] = load <4 x ptr addrspace(1)>, ptr addrspace(1) [[TMP7]], align 8, !alias.scope [[META0]]
; CHECK-NEXT:    [[WIDE_LOAD5:%.*]] = load <4 x ptr addrspace(1)>, ptr addrspace(1) [[TMP8]], align 8, !alias.scope [[META0]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) [[DOT10]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP9]], i64 32
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP9]], i64 64
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP9]], i64 96
; CHECK-NEXT:    store <4 x ptr addrspace(1)> [[WIDE_LOAD]], ptr addrspace(1) [[TMP9]], align 8, !alias.scope [[META3:![0-9]+]], !noalias [[META0]]
; CHECK-NEXT:    store <4 x ptr addrspace(1)> [[WIDE_LOAD3]], ptr addrspace(1) [[TMP10]], align 8, !alias.scope [[META3]], !noalias [[META0]]
; CHECK-NEXT:    store <4 x ptr addrspace(1)> [[WIDE_LOAD4]], ptr addrspace(1) [[TMP11]], align 8, !alias.scope [[META3]], !noalias [[META0]]
; CHECK-NEXT:    store <4 x ptr addrspace(1)> [[WIDE_LOAD5]], ptr addrspace(1) [[TMP12]], align 8, !alias.scope [[META3]], !noalias [[META0]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP13]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP2]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[PREHEADER]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV3:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT4:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[DOT18:%.*]] = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) [[DOT12]], i64 [[INDVARS_IV3]]
; CHECK-NEXT:    [[V:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[DOT18]], align 8
; CHECK-NEXT:    [[DOT20:%.*]] = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) [[DOT10]], i64 [[INDVARS_IV3]]
; CHECK-NEXT:    store ptr addrspace(1) [[V]], ptr addrspace(1) [[DOT20]], align 8
; CHECK-NEXT:    [[INDVARS_IV_NEXT4]] = add nuw nsw i64 [[INDVARS_IV3]], 1
; CHECK-NEXT:    [[DOT21:%.*]] = icmp ult i64 [[INDVARS_IV_NEXT4]], [[TMP2]]
; CHECK-NEXT:    br i1 [[DOT21]], label [[LOOP]], label [[LOOPEXIT]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %preheader

preheader:                                       ; preds = %4
  %.10 = getelementptr inbounds i8, ptr addrspace(1) %0, i64 16
  %.12 = getelementptr inbounds i8, ptr addrspace(1) %1, i64 16
  br label %loop

loop:
  %indvars.iv3 = phi i64 [ 0, %preheader ], [ %indvars.iv.next4, %loop ]
  %.18 = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) %.12, i64 %indvars.iv3
  %v = load ptr addrspace(1), ptr addrspace(1) %.18, align 8
  %.20 = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) %.10, i64 %indvars.iv3
  store ptr addrspace(1) %v, ptr addrspace(1) %.20, align 8
  %indvars.iv.next4 = add nuw nsw i64 %indvars.iv3, 1
  %.21 = icmp ult i64 %indvars.iv.next4, %2
  br i1 %.21, label %loop, label %loopexit

loopexit:
  ret void
}

attributes #0 = { uwtable "target-cpu"="skylake" "target-features"="+sse2,+cx16,+sahf,-tbm,-avx512ifma,-sha,-gfni,-fma4,-vpclmulqdq,+prfchw,+bmi2,-cldemote,+fsgsbase,+xsavec,+popcnt,+aes,-avx512bitalg,+xsaves,-avx512vnni,-avx512vpopcntdq,-clwb,-avx512f,-clzero,-pku,+mmx,-lwp,-rdpid,-xop,+rdseed,-waitpkg,-sse4a,-avx512bw,+clflushopt,+xsave,-avx512vbmi2,-avx512vl,-avx512cd,+avx,-vaes,+rtm,+fma,+bmi,+rdrnd,-mwaitx,+sse4.1,+sse4.2,+avx2,-wbnoinvd,+sse,+lzcnt,+pclmul,+f16c,+ssse3,+sgx,-shstk,+cmov,-avx512vbmi,+movbe,+xsaveopt,-avx512dq,+adx,-avx512pf,+sse3" }

!0 = !{i32 0, i32 2147483646}
!1 = !{}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -passes=slp-vectorizer,dce < %s | FileCheck -check-prefixes=GCN,GFX9 %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -passes=slp-vectorizer,dce < %s | FileCheck -check-prefixes=GCN,VI %s

define half @reduction_half4(<4 x half> %a) {
; GCN-LABEL: @reduction_half4(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[TMP0:%.*]] = call fast half @llvm.vector.reduce.fadd.v4f16(half 0xH0000, <4 x half> [[A:%.*]])
; GCN-NEXT:    ret half [[TMP0]]
;
entry:
  %elt0 = extractelement <4 x half> %a, i64 0
  %elt1 = extractelement <4 x half> %a, i64 1
  %elt2 = extractelement <4 x half> %a, i64 2
  %elt3 = extractelement <4 x half> %a, i64 3

  %add1 = fadd fast half %elt1, %elt0
  %add2 = fadd fast half %elt2, %add1
  %add3 = fadd fast half %elt3, %add2

  ret half %add3
}

define half @reduction_half8(<8 x half> %vec8) {
; GCN-LABEL: @reduction_half8(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[TMP0:%.*]] = call fast half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> [[VEC8:%.*]])
; GCN-NEXT:    ret half [[TMP0]]
;
entry:
  %elt0 = extractelement <8 x half> %vec8, i64 0
  %elt1 = extractelement <8 x half> %vec8, i64 1
  %elt2 = extractelement <8 x half> %vec8, i64 2
  %elt3 = extractelement <8 x half> %vec8, i64 3
  %elt4 = extractelement <8 x half> %vec8, i64 4
  %elt5 = extractelement <8 x half> %vec8, i64 5
  %elt6 = extractelement <8 x half> %vec8, i64 6
  %elt7 = extractelement <8 x half> %vec8, i64 7

  %add1 = fadd fast half %elt1, %elt0
  %add2 = fadd fast half %elt2, %add1
  %add3 = fadd fast half %elt3, %add2
  %add4 = fadd fast half %elt4, %add3
  %add5 = fadd fast half %elt5, %add4
  %add6 = fadd fast half %elt6, %add5
  %add7 = fadd fast half %elt7, %add6

  ret half %add7
}

define half @reduction_half16(<16 x half> %vec16) {
; GFX9-LABEL: @reduction_half16(
; GFX9-NEXT:  entry:
; GFX9-NEXT:    [[TMP0:%.*]] = call fast half @llvm.vector.reduce.fadd.v16f16(half 0xH0000, <16 x half> [[VEC16:%.*]])
; GFX9-NEXT:    ret half [[TMP0]]
;
; VI-LABEL: @reduction_half16(
; VI-NEXT:  entry:
; VI-NEXT:    [[TMP0:%.*]] = shufflevector <16 x half> [[VEC16:%.*]], <16 x half> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; VI-NEXT:    [[TMP1:%.*]] = call fast half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> [[TMP0]])
; VI-NEXT:    [[TMP2:%.*]] = shufflevector <16 x half> [[VEC16]], <16 x half> poison, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; VI-NEXT:    [[TMP3:%.*]] = call fast half @llvm.vector.reduce.fadd.v8f16(half 0xH0000, <8 x half> [[TMP2]])
; VI-NEXT:    [[OP_RDX:%.*]] = fadd fast half [[TMP1]], [[TMP3]]
; VI-NEXT:    ret half [[OP_RDX]]
;
entry:
  %elt0 = extractelement <16 x half> %vec16, i64 0
  %elt1 = extractelement <16 x half> %vec16, i64 1
  %elt2 = extractelement <16 x half> %vec16, i64 2
  %elt3 = extractelement <16 x half> %vec16, i64 3
  %elt4 = extractelement <16 x half> %vec16, i64 4
  %elt5 = extractelement <16 x half> %vec16, i64 5
  %elt6 = extractelement <16 x half> %vec16, i64 6
  %elt7 = extractelement <16 x half> %vec16, i64 7
  %elt8 = extractelement <16 x half> %vec16, i64 8
  %elt9 = extractelement <16 x half> %vec16, i64 9
  %elt10 = extractelement <16 x half> %vec16, i64 10
  %elt11 = extractelement <16 x half> %vec16, i64 11
  %elt12 = extractelement <16 x half> %vec16, i64 12
  %elt13 = extractelement <16 x half> %vec16, i64 13
  %elt14 = extractelement <16 x half> %vec16, i64 14
  %elt15 = extractelement <16 x half> %vec16, i64 15

  %add1 = fadd fast half %elt1, %elt0
  %add2 = fadd fast half %elt2, %add1
  %add3 = fadd fast half %elt3, %add2
  %add4 = fadd fast half %elt4, %add3
  %add5 = fadd fast half %elt5, %add4
  %add6 = fadd fast half %elt6, %add5
  %add7 = fadd fast half %elt7, %add6
  %add8 = fadd fast half %elt8, %add7
  %add9 = fadd fast half %elt9, %add8
  %add10 = fadd fast half %elt10, %add9
  %add11 = fadd fast half %elt11, %add10
  %add12 = fadd fast half %elt12, %add11
  %add13 = fadd fast half %elt13, %add12
  %add14 = fadd fast half %elt14, %add13
  %add15 = fadd fast half %elt15, %add14

  ret half %add15
}

; FIXME: support vectorization;
define half @reduction_sub_half4(<4 x half> %a) {
; GCN-LABEL: @reduction_sub_half4(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[ELT0:%.*]] = extractelement <4 x half> [[A:%.*]], i64 0
; GCN-NEXT:    [[ELT1:%.*]] = extractelement <4 x half> [[A]], i64 1
; GCN-NEXT:    [[ELT2:%.*]] = extractelement <4 x half> [[A]], i64 2
; GCN-NEXT:    [[ELT3:%.*]] = extractelement <4 x half> [[A]], i64 3
; GCN-NEXT:    [[ADD1:%.*]] = fsub fast half [[ELT1]], [[ELT0]]
; GCN-NEXT:    [[ADD2:%.*]] = fsub fast half [[ELT2]], [[ADD1]]
; GCN-NEXT:    [[ADD3:%.*]] = fsub fast half [[ELT3]], [[ADD2]]
; GCN-NEXT:    ret half [[ADD3]]
;
entry:
  %elt0 = extractelement <4 x half> %a, i64 0
  %elt1 = extractelement <4 x half> %a, i64 1
  %elt2 = extractelement <4 x half> %a, i64 2
  %elt3 = extractelement <4 x half> %a, i64 3

  %add1 = fsub fast half %elt1, %elt0
  %add2 = fsub fast half %elt2, %add1
  %add3 = fsub fast half %elt3, %add2

  ret half %add3
}

define i16 @reduction_v4i16(<4 x i16> %a) {
; GCN-LABEL: @reduction_v4i16(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> [[A:%.*]])
; GCN-NEXT:    ret i16 [[TMP0]]
;
entry:
  %elt0 = extractelement <4 x i16> %a, i64 0
  %elt1 = extractelement <4 x i16> %a, i64 1
  %elt2 = extractelement <4 x i16> %a, i64 2
  %elt3 = extractelement <4 x i16> %a, i64 3

  %add1 = add i16 %elt1, %elt0
  %add2 = add i16 %elt2, %add1
  %add3 = add i16 %elt3, %add2

  ret i16 %add3
}

define i16 @reduction_v8i16(<8 x i16> %vec8) {
; GCN-LABEL: @reduction_v8i16(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> [[VEC8:%.*]])
; GCN-NEXT:    ret i16 [[TMP0]]
;
entry:
  %elt0 = extractelement <8 x i16> %vec8, i64 0
  %elt1 = extractelement <8 x i16> %vec8, i64 1
  %elt2 = extractelement <8 x i16> %vec8, i64 2
  %elt3 = extractelement <8 x i16> %vec8, i64 3
  %elt4 = extractelement <8 x i16> %vec8, i64 4
  %elt5 = extractelement <8 x i16> %vec8, i64 5
  %elt6 = extractelement <8 x i16> %vec8, i64 6
  %elt7 = extractelement <8 x i16> %vec8, i64 7

  %add1 = add i16 %elt1, %elt0
  %add2 = add i16 %elt2, %add1
  %add3 = add i16 %elt3, %add2
  %add4 = add i16 %elt4, %add3
  %add5 = add i16 %elt5, %add4
  %add6 = add i16 %elt6, %add5
  %add7 = add i16 %elt7, %add6

  ret i16 %add7
}

define i16 @reduction_umin_v4i16(<4 x i16> %vec4) {
; GFX9-LABEL: @reduction_umin_v4i16(
; GFX9-NEXT:  entry:
; GFX9-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.umin.v4i16(<4 x i16> [[VEC4:%.*]])
; GFX9-NEXT:    ret i16 [[TMP0]]
;
; VI-LABEL: @reduction_umin_v4i16(
; VI-NEXT:  entry:
; VI-NEXT:    [[ELT0:%.*]] = extractelement <4 x i16> [[VEC4:%.*]], i64 0
; VI-NEXT:    [[ELT1:%.*]] = extractelement <4 x i16> [[VEC4]], i64 1
; VI-NEXT:    [[ELT2:%.*]] = extractelement <4 x i16> [[VEC4]], i64 2
; VI-NEXT:    [[ELT3:%.*]] = extractelement <4 x i16> [[VEC4]], i64 3
; VI-NEXT:    [[CMP1:%.*]] = icmp ult i16 [[ELT1]], [[ELT0]]
; VI-NEXT:    [[MIN1:%.*]] = select i1 [[CMP1]], i16 [[ELT1]], i16 [[ELT0]]
; VI-NEXT:    [[CMP2:%.*]] = icmp ult i16 [[ELT2]], [[MIN1]]
; VI-NEXT:    [[MIN2:%.*]] = select i1 [[CMP2]], i16 [[ELT2]], i16 [[MIN1]]
; VI-NEXT:    [[CMP3:%.*]] = icmp ult i16 [[ELT3]], [[MIN2]]
; VI-NEXT:    [[MIN3:%.*]] = select i1 [[CMP3]], i16 [[ELT3]], i16 [[MIN2]]
; VI-NEXT:    ret i16 [[MIN3]]
;
entry:
  %elt0 = extractelement <4 x i16> %vec4, i64 0
  %elt1 = extractelement <4 x i16> %vec4, i64 1
  %elt2 = extractelement <4 x i16> %vec4, i64 2
  %elt3 = extractelement <4 x i16> %vec4, i64 3

  %cmp1 = icmp ult i16 %elt1, %elt0
  %min1 = select i1 %cmp1, i16 %elt1, i16 %elt0
  %cmp2 = icmp ult i16 %elt2, %min1
  %min2 = select i1 %cmp2, i16 %elt2, i16 %min1
  %cmp3 = icmp ult i16 %elt3, %min2
  %min3 = select i1 %cmp3, i16 %elt3, i16 %min2

  ret i16 %min3
}

define i16 @reduction_icmp_v8i16(<8 x i16> %vec8) {
; GFX9-LABEL: @reduction_icmp_v8i16(
; GFX9-NEXT:  entry:
; GFX9-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.umin.v8i16(<8 x i16> [[VEC8:%.*]])
; GFX9-NEXT:    ret i16 [[TMP0]]
;
; VI-LABEL: @reduction_icmp_v8i16(
; VI-NEXT:  entry:
; VI-NEXT:    [[ELT0:%.*]] = extractelement <8 x i16> [[VEC8:%.*]], i64 0
; VI-NEXT:    [[ELT1:%.*]] = extractelement <8 x i16> [[VEC8]], i64 1
; VI-NEXT:    [[ELT2:%.*]] = extractelement <8 x i16> [[VEC8]], i64 2
; VI-NEXT:    [[ELT3:%.*]] = extractelement <8 x i16> [[VEC8]], i64 3
; VI-NEXT:    [[ELT4:%.*]] = extractelement <8 x i16> [[VEC8]], i64 4
; VI-NEXT:    [[ELT5:%.*]] = extractelement <8 x i16> [[VEC8]], i64 5
; VI-NEXT:    [[ELT6:%.*]] = extractelement <8 x i16> [[VEC8]], i64 6
; VI-NEXT:    [[ELT7:%.*]] = extractelement <8 x i16> [[VEC8]], i64 7
; VI-NEXT:    [[CMP0:%.*]] = icmp ult i16 [[ELT1]], [[ELT0]]
; VI-NEXT:    [[MIN1:%.*]] = select i1 [[CMP0]], i16 [[ELT1]], i16 [[ELT0]]
; VI-NEXT:    [[CMP1:%.*]] = icmp ult i16 [[ELT2]], [[MIN1]]
; VI-NEXT:    [[MIN2:%.*]] = select i1 [[CMP1]], i16 [[ELT2]], i16 [[MIN1]]
; VI-NEXT:    [[CMP2:%.*]] = icmp ult i16 [[ELT3]], [[MIN2]]
; VI-NEXT:    [[MIN3:%.*]] = select i1 [[CMP2]], i16 [[ELT3]], i16 [[MIN2]]
; VI-NEXT:    [[CMP3:%.*]] = icmp ult i16 [[ELT4]], [[MIN3]]
; VI-NEXT:    [[MIN4:%.*]] = select i1 [[CMP3]], i16 [[ELT4]], i16 [[MIN3]]
; VI-NEXT:    [[CMP4:%.*]] = icmp ult i16 [[ELT5]], [[MIN4]]
; VI-NEXT:    [[MIN5:%.*]] = select i1 [[CMP4]], i16 [[ELT5]], i16 [[MIN4]]
; VI-NEXT:    [[CMP5:%.*]] = icmp ult i16 [[ELT6]], [[MIN5]]
; VI-NEXT:    [[MIN6:%.*]] = select i1 [[CMP5]], i16 [[ELT6]], i16 [[MIN5]]
; VI-NEXT:    [[CMP6:%.*]] = icmp ult i16 [[ELT7]], [[MIN6]]
; VI-NEXT:    [[MIN7:%.*]] = select i1 [[CMP6]], i16 [[ELT7]], i16 [[MIN6]]
; VI-NEXT:    ret i16 [[MIN7]]
;
entry:
  %elt0 = extractelement <8 x i16> %vec8, i64 0
  %elt1 = extractelement <8 x i16> %vec8, i64 1
  %elt2 = extractelement <8 x i16> %vec8, i64 2
  %elt3 = extractelement <8 x i16> %vec8, i64 3
  %elt4 = extractelement <8 x i16> %vec8, i64 4
  %elt5 = extractelement <8 x i16> %vec8, i64 5
  %elt6 = extractelement <8 x i16> %vec8, i64 6
  %elt7 = extractelement <8 x i16> %vec8, i64 7

  %cmp0 = icmp ult i16 %elt1, %elt0
  %min1 = select i1 %cmp0, i16 %elt1, i16 %elt0
  %cmp1 = icmp ult i16 %elt2, %min1
  %min2 = select i1 %cmp1, i16 %elt2, i16 %min1
  %cmp2 = icmp ult i16 %elt3, %min2
  %min3 = select i1 %cmp2, i16 %elt3, i16 %min2

  %cmp3 = icmp ult i16 %elt4, %min3
  %min4 = select i1 %cmp3, i16 %elt4, i16 %min3
  %cmp4 = icmp ult i16 %elt5, %min4
  %min5 = select i1 %cmp4, i16 %elt5, i16 %min4

  %cmp5 = icmp ult i16 %elt6, %min5
  %min6 = select i1 %cmp5, i16 %elt6, i16 %min5
  %cmp6 = icmp ult i16 %elt7, %min6
  %min7 = select i1 %cmp6, i16 %elt7, i16 %min6

  ret i16 %min7
}

define i16 @reduction_smin_v16i16(<16 x i16> %vec16) {
; GFX9-LABEL: @reduction_smin_v16i16(
; GFX9-NEXT:  entry:
; GFX9-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.smin.v16i16(<16 x i16> [[VEC16:%.*]])
; GFX9-NEXT:    ret i16 [[TMP0]]
;
; VI-LABEL: @reduction_smin_v16i16(
; VI-NEXT:  entry:
; VI-NEXT:    [[ELT0:%.*]] = extractelement <16 x i16> [[VEC16:%.*]], i64 0
; VI-NEXT:    [[ELT1:%.*]] = extractelement <16 x i16> [[VEC16]], i64 1
; VI-NEXT:    [[ELT2:%.*]] = extractelement <16 x i16> [[VEC16]], i64 2
; VI-NEXT:    [[ELT3:%.*]] = extractelement <16 x i16> [[VEC16]], i64 3
; VI-NEXT:    [[ELT4:%.*]] = extractelement <16 x i16> [[VEC16]], i64 4
; VI-NEXT:    [[ELT5:%.*]] = extractelement <16 x i16> [[VEC16]], i64 5
; VI-NEXT:    [[ELT6:%.*]] = extractelement <16 x i16> [[VEC16]], i64 6
; VI-NEXT:    [[ELT7:%.*]] = extractelement <16 x i16> [[VEC16]], i64 7
; VI-NEXT:    [[ELT8:%.*]] = extractelement <16 x i16> [[VEC16]], i64 8
; VI-NEXT:    [[ELT9:%.*]] = extractelement <16 x i16> [[VEC16]], i64 9
; VI-NEXT:    [[ELT10:%.*]] = extractelement <16 x i16> [[VEC16]], i64 10
; VI-NEXT:    [[ELT11:%.*]] = extractelement <16 x i16> [[VEC16]], i64 11
; VI-NEXT:    [[ELT12:%.*]] = extractelement <16 x i16> [[VEC16]], i64 12
; VI-NEXT:    [[ELT13:%.*]] = extractelement <16 x i16> [[VEC16]], i64 13
; VI-NEXT:    [[ELT14:%.*]] = extractelement <16 x i16> [[VEC16]], i64 14
; VI-NEXT:    [[ELT15:%.*]] = extractelement <16 x i16> [[VEC16]], i64 15
; VI-NEXT:    [[CMP0:%.*]] = icmp slt i16 [[ELT1]], [[ELT0]]
; VI-NEXT:    [[MIN1:%.*]] = select i1 [[CMP0]], i16 [[ELT1]], i16 [[ELT0]]
; VI-NEXT:    [[CMP1:%.*]] = icmp slt i16 [[ELT2]], [[MIN1]]
; VI-NEXT:    [[MIN2:%.*]] = select i1 [[CMP1]], i16 [[ELT2]], i16 [[MIN1]]
; VI-NEXT:    [[CMP2:%.*]] = icmp slt i16 [[ELT3]], [[MIN2]]
; VI-NEXT:    [[MIN3:%.*]] = select i1 [[CMP2]], i16 [[ELT3]], i16 [[MIN2]]
; VI-NEXT:    [[CMP3:%.*]] = icmp slt i16 [[ELT4]], [[MIN3]]
; VI-NEXT:    [[MIN4:%.*]] = select i1 [[CMP3]], i16 [[ELT4]], i16 [[MIN3]]
; VI-NEXT:    [[CMP4:%.*]] = icmp slt i16 [[ELT5]], [[MIN4]]
; VI-NEXT:    [[MIN5:%.*]] = select i1 [[CMP4]], i16 [[ELT5]], i16 [[MIN4]]
; VI-NEXT:    [[CMP5:%.*]] = icmp slt i16 [[ELT6]], [[MIN5]]
; VI-NEXT:    [[MIN6:%.*]] = select i1 [[CMP5]], i16 [[ELT6]], i16 [[MIN5]]
; VI-NEXT:    [[CMP6:%.*]] = icmp slt i16 [[ELT7]], [[MIN6]]
; VI-NEXT:    [[MIN7:%.*]] = select i1 [[CMP6]], i16 [[ELT7]], i16 [[MIN6]]
; VI-NEXT:    [[CMP7:%.*]] = icmp slt i16 [[ELT8]], [[MIN7]]
; VI-NEXT:    [[MIN8:%.*]] = select i1 [[CMP7]], i16 [[ELT8]], i16 [[MIN7]]
; VI-NEXT:    [[CMP8:%.*]] = icmp slt i16 [[ELT9]], [[MIN8]]
; VI-NEXT:    [[MIN9:%.*]] = select i1 [[CMP8]], i16 [[ELT9]], i16 [[MIN8]]
; VI-NEXT:    [[CMP9:%.*]] = icmp slt i16 [[ELT10]], [[MIN9]]
; VI-NEXT:    [[MIN10:%.*]] = select i1 [[CMP9]], i16 [[ELT10]], i16 [[MIN9]]
; VI-NEXT:    [[CMP10:%.*]] = icmp slt i16 [[ELT11]], [[MIN10]]
; VI-NEXT:    [[MIN11:%.*]] = select i1 [[CMP10]], i16 [[ELT11]], i16 [[MIN10]]
; VI-NEXT:    [[CMP11:%.*]] = icmp slt i16 [[ELT12]], [[MIN11]]
; VI-NEXT:    [[MIN12:%.*]] = select i1 [[CMP11]], i16 [[ELT12]], i16 [[MIN11]]
; VI-NEXT:    [[CMP12:%.*]] = icmp slt i16 [[ELT13]], [[MIN12]]
; VI-NEXT:    [[MIN13:%.*]] = select i1 [[CMP12]], i16 [[ELT13]], i16 [[MIN12]]
; VI-NEXT:    [[CMP13:%.*]] = icmp slt i16 [[ELT14]], [[MIN13]]
; VI-NEXT:    [[MIN14:%.*]] = select i1 [[CMP13]], i16 [[ELT14]], i16 [[MIN13]]
; VI-NEXT:    [[CMP14:%.*]] = icmp slt i16 [[ELT15]], [[MIN14]]
; VI-NEXT:    [[MIN15:%.*]] = select i1 [[CMP14]], i16 [[ELT15]], i16 [[MIN14]]
; VI-NEXT:    ret i16 [[MIN15]]
;
entry:
  %elt0 = extractelement <16 x i16> %vec16, i64 0
  %elt1 = extractelement <16 x i16> %vec16, i64 1
  %elt2 = extractelement <16 x i16> %vec16, i64 2
  %elt3 = extractelement <16 x i16> %vec16, i64 3
  %elt4 = extractelement <16 x i16> %vec16, i64 4
  %elt5 = extractelement <16 x i16> %vec16, i64 5
  %elt6 = extractelement <16 x i16> %vec16, i64 6
  %elt7 = extractelement <16 x i16> %vec16, i64 7

  %elt8 = extractelement <16 x i16> %vec16, i64 8
  %elt9 = extractelement <16 x i16> %vec16, i64 9
  %elt10 = extractelement <16 x i16> %vec16, i64 10
  %elt11 = extractelement <16 x i16> %vec16, i64 11
  %elt12 = extractelement <16 x i16> %vec16, i64 12
  %elt13 = extractelement <16 x i16> %vec16, i64 13
  %elt14 = extractelement <16 x i16> %vec16, i64 14
  %elt15 = extractelement <16 x i16> %vec16, i64 15

  %cmp0 = icmp slt i16 %elt1, %elt0
  %min1 = select i1 %cmp0, i16 %elt1, i16 %elt0
  %cmp1 = icmp slt i16 %elt2, %min1
  %min2 = select i1 %cmp1, i16 %elt2, i16 %min1
  %cmp2 = icmp slt i16 %elt3, %min2
  %min3 = select i1 %cmp2, i16 %elt3, i16 %min2

  %cmp3 = icmp slt i16 %elt4, %min3
  %min4 = select i1 %cmp3, i16 %elt4, i16 %min3
  %cmp4 = icmp slt i16 %elt5, %min4
  %min5 = select i1 %cmp4, i16 %elt5, i16 %min4

  %cmp5 = icmp slt i16 %elt6, %min5
  %min6 = select i1 %cmp5, i16 %elt6, i16 %min5
  %cmp6 = icmp slt i16 %elt7, %min6
  %min7 = select i1 %cmp6, i16 %elt7, i16 %min6

  %cmp7 = icmp slt i16 %elt8, %min7
  %min8 = select i1 %cmp7, i16 %elt8, i16 %min7
  %cmp8 = icmp slt i16 %elt9, %min8
  %min9 = select i1 %cmp8, i16 %elt9, i16 %min8

  %cmp9 = icmp slt i16 %elt10, %min9
  %min10 = select i1 %cmp9, i16 %elt10, i16 %min9
  %cmp10 = icmp slt i16 %elt11, %min10
  %min11 = select i1 %cmp10, i16 %elt11, i16 %min10

  %cmp11 = icmp slt i16 %elt12, %min11
  %min12 = select i1 %cmp11, i16 %elt12, i16 %min11
  %cmp12 = icmp slt i16 %elt13, %min12
  %min13 = select i1 %cmp12, i16 %elt13, i16 %min12

  %cmp13 = icmp slt i16 %elt14, %min13
  %min14 = select i1 %cmp13, i16 %elt14, i16 %min13
  %cmp14 = icmp slt i16 %elt15, %min14
  %min15 = select i1 %cmp14, i16 %elt15, i16 %min14


  ret i16 %min15
}

define i16 @reduction_umax_v4i16(<4 x i16> %vec4) {
; GFX9-LABEL: @reduction_umax_v4i16(
; GFX9-NEXT:  entry:
; GFX9-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.umax.v4i16(<4 x i16> [[VEC4:%.*]])
; GFX9-NEXT:    ret i16 [[TMP0]]
;
; VI-LABEL: @reduction_umax_v4i16(
; VI-NEXT:  entry:
; VI-NEXT:    [[ELT0:%.*]] = extractelement <4 x i16> [[VEC4:%.*]], i64 0
; VI-NEXT:    [[ELT1:%.*]] = extractelement <4 x i16> [[VEC4]], i64 1
; VI-NEXT:    [[ELT2:%.*]] = extractelement <4 x i16> [[VEC4]], i64 2
; VI-NEXT:    [[ELT3:%.*]] = extractelement <4 x i16> [[VEC4]], i64 3
; VI-NEXT:    [[CMP1:%.*]] = icmp ugt i16 [[ELT1]], [[ELT0]]
; VI-NEXT:    [[MAX1:%.*]] = select i1 [[CMP1]], i16 [[ELT1]], i16 [[ELT0]]
; VI-NEXT:    [[CMP2:%.*]] = icmp ugt i16 [[ELT2]], [[MAX1]]
; VI-NEXT:    [[MAX2:%.*]] = select i1 [[CMP2]], i16 [[ELT2]], i16 [[MAX1]]
; VI-NEXT:    [[CMP3:%.*]] = icmp ugt i16 [[ELT3]], [[MAX2]]
; VI-NEXT:    [[MAX3:%.*]] = select i1 [[CMP3]], i16 [[ELT3]], i16 [[MAX2]]
; VI-NEXT:    ret i16 [[MAX3]]
;
entry:
  %elt0 = extractelement <4 x i16> %vec4, i64 0
  %elt1 = extractelement <4 x i16> %vec4, i64 1
  %elt2 = extractelement <4 x i16> %vec4, i64 2
  %elt3 = extractelement <4 x i16> %vec4, i64 3

  %cmp1 = icmp ugt i16 %elt1, %elt0
  %max1 = select i1 %cmp1, i16 %elt1, i16 %elt0
  %cmp2 = icmp ugt i16 %elt2, %max1
  %max2 = select i1 %cmp2, i16 %elt2, i16 %max1
  %cmp3 = icmp ugt i16 %elt3, %max2
  %max3 = select i1 %cmp3, i16 %elt3, i16 %max2

  ret i16 %max3
}

define i16 @reduction_smax_v4i16(<4 x i16> %vec4) {
; GFX9-LABEL: @reduction_smax_v4i16(
; GFX9-NEXT:  entry:
; GFX9-NEXT:    [[TMP0:%.*]] = call i16 @llvm.vector.reduce.smax.v4i16(<4 x i16> [[VEC4:%.*]])
; GFX9-NEXT:    ret i16 [[TMP0]]
;
; VI-LABEL: @reduction_smax_v4i16(
; VI-NEXT:  entry:
; VI-NEXT:    [[ELT0:%.*]] = extractelement <4 x i16> [[VEC4:%.*]], i64 0
; VI-NEXT:    [[ELT1:%.*]] = extractelement <4 x i16> [[VEC4]], i64 1
; VI-NEXT:    [[ELT2:%.*]] = extractelement <4 x i16> [[VEC4]], i64 2
; VI-NEXT:    [[ELT3:%.*]] = extractelement <4 x i16> [[VEC4]], i64 3
; VI-NEXT:    [[CMP1:%.*]] = icmp sgt i16 [[ELT1]], [[ELT0]]
; VI-NEXT:    [[MAX1:%.*]] = select i1 [[CMP1]], i16 [[ELT1]], i16 [[ELT0]]
; VI-NEXT:    [[CMP2:%.*]] = icmp sgt i16 [[ELT2]], [[MAX1]]
; VI-NEXT:    [[MAX2:%.*]] = select i1 [[CMP2]], i16 [[ELT2]], i16 [[MAX1]]
; VI-NEXT:    [[CMP3:%.*]] = icmp sgt i16 [[ELT3]], [[MAX2]]
; VI-NEXT:    [[MAX3:%.*]] = select i1 [[CMP3]], i16 [[ELT3]], i16 [[MAX2]]
; VI-NEXT:    ret i16 [[MAX3]]
;
entry:
  %elt0 = extractelement <4 x i16> %vec4, i64 0
  %elt1 = extractelement <4 x i16> %vec4, i64 1
  %elt2 = extractelement <4 x i16> %vec4, i64 2
  %elt3 = extractelement <4 x i16> %vec4, i64 3

  %cmp1 = icmp sgt i16 %elt1, %elt0
  %max1 = select i1 %cmp1, i16 %elt1, i16 %elt0
  %cmp2 = icmp sgt i16 %elt2, %max1
  %max2 = select i1 %cmp2, i16 %elt2, i16 %max1
  %cmp3 = icmp sgt i16 %elt3, %max2
  %max3 = select i1 %cmp3, i16 %elt3, i16 %max2

  ret i16 %max3
}

; FIXME: Use fmaxnum intrinsics to match what InstCombine creates for fcmp+select
; with fastmath on the select.
define half @reduction_fmax_v4half(<4 x half> %vec4) {
; GCN-LABEL: @reduction_fmax_v4half(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[ELT0:%.*]] = extractelement <4 x half> [[VEC4:%.*]], i64 0
; GCN-NEXT:    [[ELT1:%.*]] = extractelement <4 x half> [[VEC4]], i64 1
; GCN-NEXT:    [[ELT2:%.*]] = extractelement <4 x half> [[VEC4]], i64 2
; GCN-NEXT:    [[ELT3:%.*]] = extractelement <4 x half> [[VEC4]], i64 3
; GCN-NEXT:    [[CMP1:%.*]] = fcmp fast ogt half [[ELT1]], [[ELT0]]
; GCN-NEXT:    [[MAX1:%.*]] = select i1 [[CMP1]], half [[ELT1]], half [[ELT0]]
; GCN-NEXT:    [[CMP2:%.*]] = fcmp fast ogt half [[ELT2]], [[MAX1]]
; GCN-NEXT:    [[MAX2:%.*]] = select i1 [[CMP2]], half [[ELT2]], half [[MAX1]]
; GCN-NEXT:    [[CMP3:%.*]] = fcmp fast ogt half [[ELT3]], [[MAX2]]
; GCN-NEXT:    [[MAX3:%.*]] = select i1 [[CMP3]], half [[ELT3]], half [[MAX2]]
; GCN-NEXT:    ret half [[MAX3]]
;
entry:
  %elt0 = extractelement <4 x half> %vec4, i64 0
  %elt1 = extractelement <4 x half> %vec4, i64 1
  %elt2 = extractelement <4 x half> %vec4, i64 2
  %elt3 = extractelement <4 x half> %vec4, i64 3

  %cmp1 = fcmp fast ogt half %elt1, %elt0
  %max1 = select i1 %cmp1, half %elt1, half %elt0
  %cmp2 = fcmp fast ogt half %elt2, %max1
  %max2 = select i1 %cmp2, half %elt2, half %max1
  %cmp3 = fcmp fast ogt half %elt3, %max2
  %max3 = select i1 %cmp3, half %elt3, half %max2

  ret half %max3
}

; FIXME: Use fmaxnum intrinsics to match what InstCombine creates for fcmp+select
; with fastmath on the select.
define half @reduction_fmin_v4half(<4 x half> %vec4) {
; GCN-LABEL: @reduction_fmin_v4half(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[ELT0:%.*]] = extractelement <4 x half> [[VEC4:%.*]], i64 0
; GCN-NEXT:    [[ELT1:%.*]] = extractelement <4 x half> [[VEC4]], i64 1
; GCN-NEXT:    [[ELT2:%.*]] = extractelement <4 x half> [[VEC4]], i64 2
; GCN-NEXT:    [[ELT3:%.*]] = extractelement <4 x half> [[VEC4]], i64 3
; GCN-NEXT:    [[CMP1:%.*]] = fcmp fast olt half [[ELT1]], [[ELT0]]
; GCN-NEXT:    [[MIN1:%.*]] = select i1 [[CMP1]], half [[ELT1]], half [[ELT0]]
; GCN-NEXT:    [[CMP2:%.*]] = fcmp fast olt half [[ELT2]], [[MIN1]]
; GCN-NEXT:    [[MIN2:%.*]] = select i1 [[CMP2]], half [[ELT2]], half [[MIN1]]
; GCN-NEXT:    [[CMP3:%.*]] = fcmp fast olt half [[ELT3]], [[MIN2]]
; GCN-NEXT:    [[MIN3:%.*]] = select i1 [[CMP3]], half [[ELT3]], half [[MIN2]]
; GCN-NEXT:    ret half [[MIN3]]
;
entry:
  %elt0 = extractelement <4 x half> %vec4, i64 0
  %elt1 = extractelement <4 x half> %vec4, i64 1
  %elt2 = extractelement <4 x half> %vec4, i64 2
  %elt3 = extractelement <4 x half> %vec4, i64 3

  %cmp1 = fcmp fast olt half %elt1, %elt0
  %min1 = select i1 %cmp1, half %elt1, half %elt0
  %cmp2 = fcmp fast olt half %elt2, %min1
  %min2 = select i1 %cmp2, half %elt2, half %min1
  %cmp3 = fcmp fast olt half %elt3, %min2
  %min3 = select i1 %cmp3, half %elt3, half %min2

  ret half %min3
}

; Tests to make sure reduction does not kick in. vega does not support packed math for types larger than 16 bits.
define float @reduction_v4float(<4 x float> %a) {
; GCN-LABEL: @reduction_v4float(
; GCN-NEXT:  entry:
; GCN-NEXT:    [[ELT0:%.*]] = extractelement <4 x float> [[A:%.*]], i64 0
; GCN-NEXT:    [[ELT1:%.*]] = extractelement <4 x float> [[A]], i64 1
; GCN-NEXT:    [[ELT2:%.*]] = extractelement <4 x float> [[A]], i64 2
; GCN-NEXT:    [[ELT3:%.*]] = extractelement <4 x float> [[A]], i64 3
; GCN-NEXT:    [[ADD1:%.*]] = fadd fast float [[ELT1]], [[ELT0]]
; GCN-NEXT:    [[ADD2:%.*]] = fadd fast float [[ELT2]], [[ADD1]]
; GCN-NEXT:    [[ADD3:%.*]] = fadd fast float [[ELT3]], [[ADD2]]
; GCN-NEXT:    ret float [[ADD3]]
;
entry:
  %elt0 = extractelement <4 x float> %a, i64 0
  %elt1 = extractelement <4 x float> %a, i64 1
  %elt2 = extractelement <4 x float> %a, i64 2
  %elt3 = extractelement <4 x float> %a, i64 3

  %add1 = fadd fast float %elt1, %elt0
  %add2 = fadd fast float %elt2, %add1
  %add3 = fadd fast float %elt3, %add2

  ret float %add3
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake -S | FileCheck %s

; Check no vectorization triggered with any portion of
; insertelement <8 x i32> instructions that build entire vector.
; Vectorization triggered by cost bias caused by subtracting
; the cost of entire "aggregate build" sequence while
; building vectorizable tree from only a portion of it.

define void @test(ptr nocapture %t2) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[T3:%.*]] = load i32, ptr [[T2:%.*]], align 4
; CHECK-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 7
; CHECK-NEXT:    [[T5:%.*]] = load i32, ptr [[T4]], align 4
; CHECK-NEXT:    [[T8:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 1
; CHECK-NEXT:    [[T10:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 6
; CHECK-NEXT:    [[T11:%.*]] = load i32, ptr [[T10]], align 4
; CHECK-NEXT:    [[T14:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 2
; CHECK-NEXT:    [[T16:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 5
; CHECK-NEXT:    [[T17:%.*]] = load i32, ptr [[T16]], align 4
; CHECK-NEXT:    [[T20:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 3
; CHECK-NEXT:    [[T21:%.*]] = load i32, ptr [[T20]], align 4
; CHECK-NEXT:    [[T22:%.*]] = getelementptr inbounds i32, ptr [[T2]], i64 4
; CHECK-NEXT:    [[T23:%.*]] = load i32, ptr [[T22]], align 4
; CHECK-NEXT:    [[T24:%.*]] = add nsw i32 [[T23]], [[T21]]
; CHECK-NEXT:    [[T25:%.*]] = sub nsw i32 [[T21]], [[T23]]
; CHECK-NEXT:    [[T27:%.*]] = sub nsw i32 [[T3]], [[T24]]
; CHECK-NEXT:    [[T32:%.*]] = mul nsw i32 [[T27]], 6270
; CHECK-NEXT:    [[T37:%.*]] = add nsw i32 [[T25]], [[T11]]
; CHECK-NEXT:    [[T38:%.*]] = add nsw i32 [[T17]], [[T5]]
; CHECK-NEXT:    [[T39:%.*]] = add nsw i32 [[T37]], [[T38]]
; CHECK-NEXT:    [[T40:%.*]] = mul nsw i32 [[T39]], 9633
; CHECK-NEXT:    [[T41:%.*]] = mul nsw i32 [[T25]], 2446
; CHECK-NEXT:    [[T42:%.*]] = mul nsw i32 [[T17]], 16819
; CHECK-NEXT:    [[T47:%.*]] = mul nsw i32 [[T37]], -16069
; CHECK-NEXT:    [[T48:%.*]] = mul nsw i32 [[T38]], -3196
; CHECK-NEXT:    [[T49:%.*]] = add nsw i32 [[T40]], [[T47]]
; CHECK-NEXT:    [[T15:%.*]] = load i32, ptr [[T14]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i32>, ptr [[T8]], align 4
; CHECK-NEXT:    [[T9:%.*]] = load i32, ptr [[T8]], align 4
; CHECK-NEXT:    [[T29:%.*]] = sub nsw i32 [[T9]], [[T15]]
; CHECK-NEXT:    [[T30:%.*]] = add nsw i32 [[T27]], [[T29]]
; CHECK-NEXT:    [[T31:%.*]] = mul nsw i32 [[T30]], 4433
; CHECK-NEXT:    [[T34:%.*]] = mul nsw i32 [[T29]], -15137
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <2 x i32> <i32 1, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x i32> [[TMP2]], i32 [[T40]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x i32> [[TMP1]], i32 [[T48]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = add nsw <2 x i32> [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x i32> [[TMP5]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[T67:%.*]] = insertelement <8 x i32> [[TMP6]], i32 [[T32]], i32 2
; CHECK-NEXT:    [[T68:%.*]] = insertelement <8 x i32> [[T67]], i32 [[T49]], i32 3
; CHECK-NEXT:    [[T701:%.*]] = shufflevector <8 x i32> [[T68]], <8 x i32> [[TMP6]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 poison, i32 poison>
; CHECK-NEXT:    [[T71:%.*]] = insertelement <8 x i32> [[T701]], i32 [[T34]], i32 6
; CHECK-NEXT:    [[T72:%.*]] = insertelement <8 x i32> [[T71]], i32 [[T49]], i32 7
; CHECK-NEXT:    [[T76:%.*]] = shl <8 x i32> [[T72]], <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    store <8 x i32> [[T76]], ptr [[T2]], align 4
; CHECK-NEXT:    ret void
;
  %t3 = load i32, ptr %t2, align 4
  %t4 = getelementptr inbounds i32, ptr %t2, i64 7
  %t5 = load i32, ptr %t4, align 4
  %t8 = getelementptr inbounds i32, ptr %t2, i64 1
  %t9 = load i32, ptr %t8, align 4
  %t10 = getelementptr inbounds i32, ptr %t2, i64 6
  %t11 = load i32, ptr %t10, align 4
  %t14 = getelementptr inbounds i32, ptr %t2, i64 2
  %t15 = load i32, ptr %t14, align 4
  %t16 = getelementptr inbounds i32, ptr %t2, i64 5
  %t17 = load i32, ptr %t16, align 4
  %t20 = getelementptr inbounds i32, ptr %t2, i64 3
  %t21 = load i32, ptr %t20, align 4
  %t22 = getelementptr inbounds i32, ptr %t2, i64 4
  %t23 = load i32, ptr %t22, align 4
  %t24 = add nsw i32 %t23, %t21
  %t25 = sub nsw i32 %t21, %t23
  %t27 = sub nsw i32 %t3, %t24
  %t28 = add nsw i32 %t15, %t9
  %t29 = sub nsw i32 %t9, %t15
  %t30 = add nsw i32 %t27, %t29
  %t31 = mul nsw i32 %t30, 4433
  %t32 = mul nsw i32 %t27, 6270
  %t34 = mul nsw i32 %t29, -15137
  %t37 = add nsw i32 %t25, %t11
  %t38 = add nsw i32 %t17, %t5
  %t39 = add nsw i32 %t37, %t38
  %t40 = mul nsw i32 %t39, 9633
  %t41 = mul nsw i32 %t25, 2446
  %t42 = mul nsw i32 %t17, 16819
  %t47 = mul nsw i32 %t37, -16069
  %t48 = mul nsw i32 %t38, -3196
  %t49 = add nsw i32 %t40, %t47
  %t50 = add nsw i32 %t40, %t48
  %t65 = insertelement <8 x i32> poison, i32 %t28, i32 0
  %t66 = insertelement <8 x i32> %t65, i32 %t50, i32 1
  %t67 = insertelement <8 x i32> %t66, i32 %t32, i32 2
  %t68 = insertelement <8 x i32> %t67, i32 %t49, i32 3
  %t69 = insertelement <8 x i32> %t68, i32 %t28, i32 4
  %t70 = insertelement <8 x i32> %t69, i32 %t50, i32 5
  %t71 = insertelement <8 x i32> %t70, i32 %t34, i32 6
  %t72 = insertelement <8 x i32> %t71, i32 %t49, i32 7
  %t76 = shl <8 x i32> %t72, <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>
  store <8 x i32> %t76, ptr %t2, align 4
  ret void
}

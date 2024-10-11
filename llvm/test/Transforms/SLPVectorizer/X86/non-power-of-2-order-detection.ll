; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -slp-threshold=-1000 < %s | FileCheck %s

define void @e(ptr %c, i64 %0) {
; CHECK-LABEL: define void @e(
; CHECK-SAME: ptr [[C:%.*]], i64 [[TMP0:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[C]], align 8
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i8, ptr [[TMP1]], i64 96
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr i8, ptr [[TMP1]], i64 112
; CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[C]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x ptr>, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x ptr> poison, ptr [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x ptr> [[TMP5]], <2 x ptr> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <6 x ptr> poison, ptr [[TMP2]], i32 2
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <6 x ptr> [[TMP7]], ptr [[TMP1]], i32 3
; CHECK-NEXT:    [[TMP9:%.*]] = call <6 x ptr> @llvm.vector.insert.v6p0.v2p0(<6 x ptr> [[TMP8]], <2 x ptr> [[TMP4]], i64 0)
; CHECK-NEXT:    [[TMP10:%.*]] = call <6 x ptr> @llvm.vector.insert.v6p0.v2p0(<6 x ptr> [[TMP9]], <2 x ptr> [[TMP6]], i64 4)
; CHECK-NEXT:    [[TMP11:%.*]] = ptrtoint <6 x ptr> [[TMP10]] to <6 x i64>
; CHECK-NEXT:    [[TMP12:%.*]] = shufflevector <6 x i64> [[TMP11]], <6 x i64> poison, <32 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 3, i32 3, i32 3, i32 3, i32 4, i32 4, i32 4, i32 4, i32 5, i32 5, i32 5>
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <32 x i64> poison, i64 [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP14:%.*]] = shufflevector <32 x i64> [[TMP13]], <32 x i64> poison, <32 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP15:%.*]] = or <32 x i64> [[TMP14]], [[TMP12]]
; CHECK-NEXT:    [[TMP16:%.*]] = icmp ult <32 x i64> [[TMP15]], <i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16>
; CHECK-NEXT:    [[TMP17:%.*]] = call i1 @llvm.vector.reduce.or.v32i1(<32 x i1> [[TMP16]])
; CHECK-NEXT:    br i1 [[TMP17]], label %[[FOR_BODY:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    ret void
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    ret void
;
entry:
  %1 = load ptr, ptr %c, align 8
  %arrayidx = getelementptr i8, ptr %1, i64 96
  %arrayidx1 = getelementptr i8, ptr %1, i64 112
  %2 = load ptr, ptr %arrayidx1, align 8
  %arrayidx5 = getelementptr i8, ptr %1, i64 104
  %3 = load ptr, ptr %arrayidx5, align 8
  %4 = load ptr, ptr %arrayidx, align 8
  %5 = load ptr, ptr %c, align 8
  %6 = ptrtoint ptr %5 to i64
  %7 = ptrtoint ptr %5 to i64
  %8 = ptrtoint ptr %1 to i64
  %9 = ptrtoint ptr %4 to i64
  %10 = ptrtoint ptr %3 to i64
  %11 = ptrtoint ptr %2 to i64
  %12 = or i64 %0, %11
  %dc64 = icmp ult i64 %12, 16
  %13 = or i64 %0, %11
  %dc65 = icmp ult i64 %13, 16
  %cr66 = or i1 %dc64, %dc65
  %14 = or i64 %0, %11
  %dc67 = icmp ult i64 %14, 16
  %cr68 = or i1 %cr66, %dc67
  %15 = or i64 %0, %11
  %dc69 = icmp ult i64 %15, 16
  %cr70 = or i1 %cr68, %dc69
  %16 = or i64 %0, %11
  %dc71 = icmp ult i64 %16, 16
  %cr72 = or i1 %cr70, %dc71
  %17 = or i64 %0, %11
  %dc73 = icmp ult i64 %17, 16
  %cr74 = or i1 %cr72, %dc73
  %18 = or i64 %0, %11
  %dc75 = icmp ult i64 %18, 16
  %cr76 = or i1 %cr74, %dc75
  %19 = or i64 %0, %10
  %dc77 = icmp ult i64 %19, 16
  %cr78 = or i1 %cr76, %dc77
  %20 = or i64 %0, %10
  %dc79 = icmp ult i64 %20, 16
  %cr80 = or i1 %cr78, %dc79
  %21 = or i64 %0, %10
  %dc81 = icmp ult i64 %21, 16
  %cr82 = or i1 %cr80, %dc81
  %22 = or i64 %0, %10
  %dc83 = icmp ult i64 %22, 16
  %cr84 = or i1 %cr82, %dc83
  %23 = or i64 %0, %10
  %dc85 = icmp ult i64 %23, 16
  %cr86 = or i1 %cr84, %dc85
  %24 = or i64 %0, %10
  %dc87 = icmp ult i64 %24, 16
  %cr88 = or i1 %cr86, %dc87
  %25 = or i64 %0, %10
  %dc89 = icmp ult i64 %25, 16
  %cr90 = or i1 %cr88, %dc89
  %26 = or i64 %0, %9
  %dc91 = icmp ult i64 %26, 16
  %cr92 = or i1 %cr90, %dc91
  %27 = or i64 %0, %9
  %dc93 = icmp ult i64 %27, 16
  %cr94 = or i1 %cr92, %dc93
  %28 = or i64 %0, %9
  %dc95 = icmp ult i64 %28, 16
  %cr96 = or i1 %cr94, %dc95
  %29 = or i64 %0, %9
  %dc97 = icmp ult i64 %29, 16
  %cr98 = or i1 %cr96, %dc97
  %30 = or i64 %0, %9
  %dc99 = icmp ult i64 %30, 16
  %cr100 = or i1 %cr98, %dc99
  %31 = or i64 %0, %9
  %dc101 = icmp ult i64 %31, 16
  %cr102 = or i1 %cr100, %dc101
  %32 = or i64 %0, %8
  %dc103 = icmp ult i64 %32, 16
  %cr104 = or i1 %cr102, %dc103
  %33 = or i64 %0, %8
  %dc105 = icmp ult i64 %33, 16
  %cr106 = or i1 %cr104, %dc105
  %34 = or i64 %0, %8
  %dc107 = icmp ult i64 %34, 16
  %cr108 = or i1 %cr106, %dc107
  %35 = or i64 %0, %8
  %dc109 = icmp ult i64 %35, 16
  %cr110 = or i1 %cr108, %dc109
  %36 = or i64 %0, %8
  %dc111 = icmp ult i64 %36, 16
  %cr112 = or i1 %cr110, %dc111
  %37 = or i64 %0, %7
  %dc113 = icmp ult i64 %37, 16
  %cr114 = or i1 %cr112, %dc113
  %38 = or i64 %0, %7
  %dc115 = icmp ult i64 %38, 16
  %cr116 = or i1 %cr114, %dc115
  %39 = or i64 %0, %7
  %dc117 = icmp ult i64 %39, 16
  %cr118 = or i1 %cr116, %dc117
  %40 = or i64 %0, %7
  %dc119 = icmp ult i64 %40, 16
  %cr120 = or i1 %cr118, %dc119
  %41 = or i64 %0, %6
  %dc121 = icmp ult i64 %41, 16
  %cr122 = or i1 %cr120, %dc121
  %42 = or i64 %0, %6
  %dc123 = icmp ult i64 %42, 16
  %cr124 = or i1 %cr122, %dc123
  %43 = or i64 %0, %6
  %dc125 = icmp ult i64 %43, 16
  %cr126 = or i1 %cr124, %dc125
  br i1 %cr126, label %for.body, label %vector.ph

vector.ph:
  ret void

for.body:
  ret void
}

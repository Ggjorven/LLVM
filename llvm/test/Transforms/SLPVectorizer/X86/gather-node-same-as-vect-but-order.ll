; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -mcpu=x86-64-v4 < %s | FileCheck %s

%struct.rect = type { float, float, float, float }

define void @foo(ptr %i7, i32 %0, i1 %tobool62.not) {
; CHECK-LABEL: define void @foo(
; CHECK-SAME: ptr [[I7:%.*]], i32 [[TMP0:%.*]], i1 [[TOBOOL62_NOT:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RC21:%.*]] = alloca [0 x [0 x %struct.rect]], i32 0, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i32> poison, i32 [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x i32> [[TMP2]], <2 x i32> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = sitofp <2 x i32> [[TMP3]] to <2 x float>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <4 x i32> <i32 1, i32 0, i32 1, i32 0>
; CHECK-NEXT:    [[Y0:%.*]] = getelementptr i8, ptr [[RC21]], i64 8
; CHECK-NEXT:    [[TMP6:%.*]] = load float, ptr [[Y0]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load float, ptr [[I7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = load <2 x float>, ptr [[RC21]], align 4
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <4 x float> poison, float [[TMP6]], i32 2
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x float> [[TMP10]], float [[TMP7]], i32 3
; CHECK-NEXT:    [[TMP13:%.*]] = call <4 x float> @llvm.vector.insert.v4f32.v2f32(<4 x float> [[TMP11]], <2 x float> [[TMP8]], i64 0)
; CHECK-NEXT:    [[TMP12:%.*]] = fcmp olt <4 x float> [[TMP13]], zeroinitializer
; CHECK-NEXT:    [[TMP14:%.*]] = fcmp olt <4 x float> [[TMP5]], zeroinitializer
; CHECK-NEXT:    [[TMP15:%.*]] = select <4 x i1> [[TMP14]], <4 x float> [[TMP5]], <4 x float> zeroinitializer
; CHECK-NEXT:    [[TMP16:%.*]] = select <4 x i1> [[TMP12]], <4 x float> zeroinitializer, <4 x float> [[TMP15]]
; CHECK-NEXT:    store <4 x float> [[TMP16]], ptr [[RC21]], align 4
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       entry.if.end72_crit_edge:
; CHECK-NEXT:    br label [[IF_END72:%.*]]
; CHECK:       if.then63:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[TMP17:%.*]] = phi <4 x float> [ poison, [[IF_THEN63:%.*]] ], [ [[TMP16]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = call <4 x float> @llvm.round.v4f32(<4 x float> [[TMP17]])
; CHECK-NEXT:    [[TMP19:%.*]] = fptosi <4 x float> [[TMP18]] to <4 x i32>
; CHECK-NEXT:    br label [[IF_END72]]
; CHECK:       if.end72:
; CHECK-NEXT:    [[TMP20:%.*]] = phi <4 x i32> [ poison, [[ENTRY_IF_END72_CRIT_EDGE:%.*]] ], [ [[TMP19]], [[IF_END]] ]
; CHECK-NEXT:    [[TMP21:%.*]] = shufflevector <4 x i32> [[TMP20]], <4 x i32> poison, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:    br i1 [[TOBOOL62_NOT]], label [[IF_END75:%.*]], label [[IF_THEN74:%.*]]
; CHECK:       if.then74:
; CHECK-NEXT:    br label [[IF_END75]]
; CHECK:       if.end75:
; CHECK-NEXT:    [[TMP22:%.*]] = phi <4 x i32> [ [[TMP20]], [[IF_THEN74]] ], [ [[TMP21]], [[IF_END72]] ]
; CHECK-NEXT:    [[TMP23:%.*]] = or <4 x i32> [[TMP22]], <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[TMP24:%.*]] = shufflevector <2 x i32> [[TMP3]], <2 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP25:%.*]] = mul <4 x i32> [[TMP23]], [[TMP24]]
; CHECK-NEXT:    [[TMP26:%.*]] = sitofp <4 x i32> [[TMP25]] to <4 x float>
; CHECK-NEXT:    [[TMP27:%.*]] = shufflevector <4 x float> [[TMP26]], <4 x float> poison, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:    store <4 x float> [[TMP27]], ptr [[RC21]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %rc21 = alloca [0 x [0 x %struct.rect]], i32 0, align 4
  %1 = load float, ptr %rc21, align 4
  %cmp = fcmp olt float %1, 0.000000e+00
  %conv = sitofp i32 %0 to float
  %cmp2 = fcmp olt float %conv, 0.000000e+00
  %cond = select i1 %cmp2, float %conv, float 0.000000e+00
  %cond9 = select i1 %cmp, float 0.000000e+00, float %cond
  store float %cond9, ptr %rc21, align 4
  %x1 = getelementptr i8, ptr %rc21, i64 4
  %2 = load float, ptr %x1, align 4
  %cmp11 = fcmp olt float %2, 0.000000e+00
  %conv16 = sitofp i32 %0 to float
  %cmp17 = fcmp olt float %conv16, 0.000000e+00
  %cond24 = select i1 %cmp17, float %conv16, float 0.000000e+00
  %cond26 = select i1 %cmp11, float 0.000000e+00, float %cond24
  store float %cond26, ptr %x1, align 4
  %y0 = getelementptr i8, ptr %rc21, i64 8
  %3 = load float, ptr %y0, align 4
  %cmp28 = fcmp olt float %3, 0.000000e+00
  %cmp34 = fcmp olt float %conv, 0.000000e+00
  %cond41 = select i1 %cmp34, float %conv, float 0.000000e+00
  %cond43 = select i1 %cmp28, float 0.000000e+00, float %cond41
  store float %cond43, ptr %y0, align 4
  %y11 = getelementptr i8, ptr %rc21, i64 12
  %4 = load float, ptr %i7, align 4
  %cmp45 = fcmp olt float %4, 0.000000e+00
  %cmp51 = fcmp olt float %conv16, 0.000000e+00
  %cond58 = select i1 %cmp51, float %conv16, float 0.000000e+00
  %cond60 = select i1 %cmp45, float 0.000000e+00, float %cond58
  store float %cond60, ptr %y11, align 4
  br label %if.end

entry.if.end72_crit_edge:
  br label %if.end72

if.then63:
  br label %if.end

if.end:
  %5 = phi float [ 0.000000e+00, %if.then63 ], [ %cond60, %entry ]
  %6 = phi float [ 0.000000e+00, %if.then63 ], [ %cond26, %entry ]
  %7 = phi float [ 0.000000e+00, %if.then63 ], [ %cond43, %entry ]
  %8 = phi float [ 0.000000e+00, %if.then63 ], [ %cond9, %entry ]
  %9 = call float @llvm.round.f32(float %8)
  %conv65 = fptosi float %9 to i32
  %10 = call float @llvm.round.f32(float %7)
  %conv67 = fptosi float %10 to i32
  %11 = call float @llvm.round.f32(float %6)
  %conv69 = fptosi float %11 to i32
  %12 = call float @llvm.round.f32(float %5)
  %conv71 = fptosi float %12 to i32
  br label %if.end72

if.end72:
  %.pre100 = phi i32 [ 0, %entry.if.end72_crit_edge ], [ %conv71, %if.end ]
  %.pre99 = phi i32 [ 0, %entry.if.end72_crit_edge ], [ %conv67, %if.end ]
  %.pre98 = phi i32 [ 0, %entry.if.end72_crit_edge ], [ %conv69, %if.end ]
  %.pre97 = phi i32 [ 0, %entry.if.end72_crit_edge ], [ %conv65, %if.end ]
  br i1 %tobool62.not, label %if.end75, label %if.then74

if.then74:
  br label %if.end75

if.end75:
  %13 = phi i32 [ %.pre99, %if.then74 ], [ %.pre100, %if.end72 ]
  %14 = phi i32 [ %.pre100, %if.then74 ], [ %.pre99, %if.end72 ]
  %15 = phi i32 [ %.pre97, %if.then74 ], [ %.pre98, %if.end72 ]
  %16 = phi i32 [ %.pre98, %if.then74 ], [ %.pre97, %if.end72 ]
  %sub = or i32 %16, 1
  %mul = mul i32 %sub, %0
  %conv77 = sitofp i32 %mul to float
  store float %conv77, ptr %rc21, align 4
  %x178 = getelementptr i8, ptr %rc21, i64 4
  %sub79 = or i32 %15, 1
  %mul80 = mul i32 %sub79, %0
  %conv81 = sitofp i32 %mul80 to float
  store float %conv81, ptr %x178, align 4
  %y082 = getelementptr i8, ptr %rc21, i64 8
  %sub83 = or i32 %14, 1
  %mul84 = mul i32 %sub83, %0
  %conv85 = sitofp i32 %mul84 to float
  store float %conv85, ptr %y082, align 4
  %y186 = getelementptr i8, ptr %rc21, i64 12
  %sub87 = or i32 %13, 1
  %mul88 = mul i32 %sub87, %0
  %conv89 = sitofp i32 %mul88 to float
  store float %conv89, ptr %y186, align 4
  ret void
}

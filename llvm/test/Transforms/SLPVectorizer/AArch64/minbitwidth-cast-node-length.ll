; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=arm64-apple-macosx11.0.0 < %s | FileCheck %s

define void @test(ptr %pDst, i32 %stride, i8 %0, ptr %p1, ptr %p2, ptr %p4, ptr %p3) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr [[PDST:%.*]], i32 [[STRIDE:%.*]], i8 [[TMP0:%.*]], ptr [[P1:%.*]], ptr [[P2:%.*]], ptr [[P4:%.*]], ptr [[P3:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[MUL100:%.*]] = mul i32 [[STRIDE]], 9
; CHECK-NEXT:    [[MUL101:%.*]] = mul i32 [[STRIDE]], 7
; CHECK-NEXT:    [[MUL102:%.*]] = mul i32 [[STRIDE]], 5
; CHECK-NEXT:    [[MUL103:%.*]] = mul i32 [[STRIDE]], 3
; CHECK-NEXT:    [[CONV111:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL112:%.*]] = mul i32 [[CONV111]], 14
; CHECK-NEXT:    [[CONV117:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL118:%.*]] = mul i32 [[CONV117]], 14
; CHECK-NEXT:    [[CONV124:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL125:%.*]] = mul i32 [[CONV124]], 14
; CHECK-NEXT:    [[CONV131:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL132:%.*]] = mul i32 [[CONV131]], 14
; CHECK-NEXT:    [[CMP139:%.*]] = icmp uge i32 [[MUL112]], [[MUL100]]
; CHECK-NEXT:    [[CMP142:%.*]] = icmp uge i32 [[MUL112]], [[MUL101]]
; CHECK-NEXT:    [[ADD1441:%.*]] = or i1 [[CMP139]], [[CMP142]]
; CHECK-NEXT:    [[CMP145:%.*]] = icmp uge i32 [[MUL112]], [[MUL102]]
; CHECK-NEXT:    [[ADD1472:%.*]] = or i1 [[ADD1441]], [[CMP145]]
; CHECK-NEXT:    [[CMP148:%.*]] = icmp uge i32 [[MUL112]], [[MUL103]]
; CHECK-NEXT:    [[ADD1504:%.*]] = or i1 [[ADD1472]], [[CMP148]]
; CHECK-NEXT:    [[ADD151:%.*]] = zext i1 [[ADD1504]] to i64
; CHECK-NEXT:    [[ARRAYIDX156:%.*]] = getelementptr [8 x i32], ptr [[P1]], i64 0, i64 [[ADD151]]
; CHECK-NEXT:    [[TMP18:%.*]] = load i32, ptr [[ARRAYIDX156]], align 4
; CHECK-NEXT:    [[CMP165:%.*]] = icmp uge i32 [[MUL118]], [[MUL101]]
; CHECK-NEXT:    [[CMP171:%.*]] = icmp uge i32 [[MUL118]], [[MUL103]]
; CHECK-NEXT:    [[ADD1734:%.*]] = or i1 [[CMP165]], [[CMP171]]
; CHECK-NEXT:    [[ADD173:%.*]] = zext i1 [[ADD1734]] to i64
; CHECK-NEXT:    [[ARRAYIDX178:%.*]] = getelementptr [8 x i32], ptr [[P2]], i64 0, i64 [[ADD173]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[ARRAYIDX178]], align 4
; CHECK-NEXT:    [[CMP185:%.*]] = icmp uge i32 [[MUL125]], [[MUL100]]
; CHECK-NEXT:    [[CMP188:%.*]] = icmp uge i32 [[MUL125]], [[MUL101]]
; CHECK-NEXT:    [[ADD1905:%.*]] = or i1 [[CMP185]], [[CMP188]]
; CHECK-NEXT:    [[CMP191:%.*]] = icmp uge i32 [[MUL125]], [[MUL102]]
; CHECK-NEXT:    [[ADD1936:%.*]] = or i1 [[ADD1905]], [[CMP191]]
; CHECK-NEXT:    [[ADD193:%.*]] = zext i1 [[ADD1936]] to i64
; CHECK-NEXT:    [[ARRAYIDX201:%.*]] = getelementptr [8 x i32], ptr [[P4]], i64 0, i64 [[ADD193]]
; CHECK-NEXT:    [[TMP19:%.*]] = load i32, ptr [[ARRAYIDX201]], align 4
; CHECK-NEXT:    [[CMP208:%.*]] = icmp uge i32 [[MUL132]], [[MUL100]]
; CHECK-NEXT:    [[CMP211:%.*]] = icmp uge i32 [[MUL132]], [[MUL101]]
; CHECK-NEXT:    [[ADD2137:%.*]] = or i1 [[CMP208]], [[CMP211]]
; CHECK-NEXT:    [[CMP214:%.*]] = icmp uge i32 [[MUL132]], [[MUL102]]
; CHECK-NEXT:    [[ADD2168:%.*]] = or i1 [[ADD2137]], [[CMP214]]
; CHECK-NEXT:    [[CMP217:%.*]] = icmp uge i32 [[MUL132]], [[MUL103]]
; CHECK-NEXT:    [[ADD2199:%.*]] = or i1 [[ADD2168]], [[CMP217]]
; CHECK-NEXT:    [[ADD219:%.*]] = zext i1 [[ADD2199]] to i64
; CHECK-NEXT:    [[ARRAYIDX224:%.*]] = getelementptr [8 x i32], ptr [[P3]], i64 0, i64 [[ADD219]]
; CHECK-NEXT:    [[TMP20:%.*]] = load i32, ptr [[ARRAYIDX224]], align 4
; CHECK-NEXT:    [[CONV230:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL231:%.*]] = mul i32 [[CONV230]], 14
; CHECK-NEXT:    [[CONV237:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL238:%.*]] = mul i32 [[CONV237]], 14
; CHECK-NEXT:    [[CONV244:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL245:%.*]] = mul i32 [[CONV244]], 14
; CHECK-NEXT:    [[CONV484:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL485:%.*]] = mul i32 [[CONV484]], 14
; CHECK-NEXT:    [[CMP262:%.*]] = icmp uge i32 [[MUL231]], [[MUL101]]
; CHECK-NEXT:    [[CMP268:%.*]] = icmp uge i32 [[MUL231]], [[MUL103]]
; CHECK-NEXT:    [[ADD1503:%.*]] = or i1 [[CMP262]], [[CMP268]]
; CHECK-NEXT:    [[ADD150:%.*]] = zext i1 [[ADD1503]] to i64
; CHECK-NEXT:    [[ARRAYIDX155:%.*]] = getelementptr [8 x i32], ptr [[P1]], i64 0, i64 [[ADD150]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr [[ARRAYIDX155]], align 4
; CHECK-NEXT:    [[OR951:%.*]] = or i32 [[TMP13]], [[TMP18]]
; CHECK-NEXT:    [[CMP282:%.*]] = icmp uge i32 [[MUL238]], [[MUL100]]
; CHECK-NEXT:    [[CMP285:%.*]] = icmp uge i32 [[MUL238]], [[MUL101]]
; CHECK-NEXT:    [[ADD28711:%.*]] = or i1 [[CMP282]], [[CMP285]]
; CHECK-NEXT:    [[CMP288:%.*]] = icmp uge i32 [[MUL238]], [[MUL102]]
; CHECK-NEXT:    [[ADD29012:%.*]] = or i1 [[ADD28711]], [[CMP288]]
; CHECK-NEXT:    [[CMP291:%.*]] = icmp uge i32 [[MUL238]], [[MUL103]]
; CHECK-NEXT:    [[ADD29313:%.*]] = or i1 [[ADD29012]], [[CMP291]]
; CHECK-NEXT:    [[ADD293:%.*]] = zext i1 [[ADD29313]] to i64
; CHECK-NEXT:    [[ARRAYIDX298:%.*]] = getelementptr [8 x i32], ptr [[P2]], i64 0, i64 [[ADD293]]
; CHECK-NEXT:    [[TMP21:%.*]] = load i32, ptr [[ARRAYIDX298]], align 4
; CHECK-NEXT:    [[OR301952:%.*]] = or i32 [[TMP21]], [[TMP12]]
; CHECK-NEXT:    [[CMP310:%.*]] = icmp uge i32 [[MUL245]], [[MUL101]]
; CHECK-NEXT:    [[CMP316:%.*]] = icmp uge i32 [[MUL245]], [[MUL103]]
; CHECK-NEXT:    [[ADD31814:%.*]] = or i1 [[CMP310]], [[CMP316]]
; CHECK-NEXT:    [[ADD318:%.*]] = zext i1 [[ADD31814]] to i64
; CHECK-NEXT:    [[ARRAYIDX323:%.*]] = getelementptr [8 x i32], ptr [[P4]], i64 0, i64 [[ADD318]]
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, ptr [[ARRAYIDX323]], align 4
; CHECK-NEXT:    [[OR326953:%.*]] = or i32 [[TMP14]], [[TMP19]]
; CHECK-NEXT:    [[CMP332:%.*]] = icmp uge i32 [[MUL485]], [[MUL100]]
; CHECK-NEXT:    [[CMP335:%.*]] = icmp uge i32 [[MUL485]], [[MUL101]]
; CHECK-NEXT:    [[ADD33715:%.*]] = or i1 [[CMP332]], [[CMP335]]
; CHECK-NEXT:    [[CMP338:%.*]] = icmp uge i32 [[MUL485]], [[MUL102]]
; CHECK-NEXT:    [[ADD34016:%.*]] = or i1 [[ADD33715]], [[CMP338]]
; CHECK-NEXT:    [[CMP341:%.*]] = icmp uge i32 [[MUL485]], [[MUL103]]
; CHECK-NEXT:    [[ADD34317:%.*]] = or i1 [[ADD34016]], [[CMP341]]
; CHECK-NEXT:    [[ADD343:%.*]] = zext i1 [[ADD34317]] to i64
; CHECK-NEXT:    [[ARRAYIDX348:%.*]] = getelementptr [8 x i32], ptr [[P3]], i64 0, i64 [[ADD343]]
; CHECK-NEXT:    [[TMP22:%.*]] = load i32, ptr [[ARRAYIDX348]], align 4
; CHECK-NEXT:    [[OR351954:%.*]] = or i32 [[TMP22]], [[TMP20]]
; CHECK-NEXT:    [[CONV485:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL486:%.*]] = mul i32 [[CONV485]], 14
; CHECK-NEXT:    [[CONV491:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL492:%.*]] = mul i32 [[CONV491]], 14
; CHECK-NEXT:    [[CONV498:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL499:%.*]] = mul i32 [[CONV498]], 14
; CHECK-NEXT:    [[CONV505:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL506:%.*]] = mul i32 [[CONV505]], 14
; CHECK-NEXT:    [[CMP519:%.*]] = icmp uge i32 [[MUL486]], [[MUL102]]
; CHECK-NEXT:    [[CMP522:%.*]] = icmp uge i32 [[MUL486]], [[MUL103]]
; CHECK-NEXT:    [[ADD52418:%.*]] = or i1 [[CMP519]], [[CMP522]]
; CHECK-NEXT:    [[ADD524:%.*]] = zext i1 [[ADD52418]] to i64
; CHECK-NEXT:    [[ARRAYIDX529:%.*]] = getelementptr [8 x i32], ptr [[P1]], i64 0, i64 [[ADD524]]
; CHECK-NEXT:    [[TMP23:%.*]] = load i32, ptr [[ARRAYIDX529]], align 4
; CHECK-NEXT:    [[CMP541:%.*]] = icmp uge i32 [[MUL492]], [[MUL101]]
; CHECK-NEXT:    [[CMP544:%.*]] = icmp uge i32 [[MUL492]], [[MUL102]]
; CHECK-NEXT:    [[ADD54619:%.*]] = or i1 [[CMP541]], [[CMP544]]
; CHECK-NEXT:    [[CMP547:%.*]] = icmp uge i32 [[MUL492]], [[MUL103]]
; CHECK-NEXT:    [[ADD54920:%.*]] = or i1 [[ADD54619]], [[CMP547]]
; CHECK-NEXT:    [[ADD549:%.*]] = zext i1 [[ADD54920]] to i64
; CHECK-NEXT:    [[ARRAYIDX554:%.*]] = getelementptr [8 x i32], ptr [[P2]], i64 0, i64 [[ADD549]]
; CHECK-NEXT:    [[TMP25:%.*]] = load i32, ptr [[ARRAYIDX554]], align 4
; CHECK-NEXT:    [[CMP572:%.*]] = icmp uge i32 [[MUL499]], [[MUL103]]
; CHECK-NEXT:    [[CONV573:%.*]] = zext i1 [[CMP572]] to i64
; CHECK-NEXT:    [[ARRAYIDX579:%.*]] = getelementptr [8 x i32], ptr [[P4]], i64 0, i64 [[CONV573]]
; CHECK-NEXT:    [[TMP27:%.*]] = load i32, ptr [[ARRAYIDX579]], align 4
; CHECK-NEXT:    [[CMP594:%.*]] = icmp uge i32 [[MUL506]], [[MUL102]]
; CHECK-NEXT:    [[CONV595:%.*]] = zext i1 [[CMP594]] to i64
; CHECK-NEXT:    [[ARRAYIDX604:%.*]] = getelementptr [8 x i32], ptr [[P3]], i64 0, i64 [[CONV595]]
; CHECK-NEXT:    [[TMP29:%.*]] = load i32, ptr [[ARRAYIDX604]], align 4
; CHECK-NEXT:    [[OR4791159:%.*]] = or i32 [[OR301952]], [[OR951]]
; CHECK-NEXT:    [[OR6071160:%.*]] = or i32 [[OR4791159]], [[OR326953]]
; CHECK-NEXT:    [[OR4541161:%.*]] = or i32 [[OR6071160]], [[OR351954]]
; CHECK-NEXT:    [[SHL58111621163:%.*]] = or i32 [[TMP27]], [[TMP29]]
; CHECK-NEXT:    [[SHL55611641165:%.*]] = or i32 [[TMP25]], [[SHL58111621163]]
; CHECK-NEXT:    [[SHL53111661167:%.*]] = or i32 [[TMP23]], [[SHL55611641165]]
; CHECK-NEXT:    [[SHL5311166:%.*]] = trunc i32 [[SHL53111661167]] to i8
; CHECK-NEXT:    [[CONV616:%.*]] = trunc i32 [[OR4541161]] to i8
; CHECK-NEXT:    [[ARRAYIDX617:%.*]] = getelementptr i8, ptr [[PDST]], i64 4
; CHECK-NEXT:    store i8 [[CONV616]], ptr [[ARRAYIDX617]], align 1
; CHECK-NEXT:    store i8 [[SHL5311166]], ptr [[PDST]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %mul100 = mul i32 %stride, 9
  %mul101 = mul i32 %stride, 7
  %mul102 = mul i32 %stride, 5
  %mul103 = mul i32 %stride, 3
  %conv111 = zext i8 %0 to i32
  %mul112 = mul i32 %conv111, 14
  %conv117 = zext i8 %0 to i32
  %mul118 = mul i32 %conv117, 14
  %conv124 = zext i8 %0 to i32
  %mul125 = mul i32 %conv124, 14
  %conv131 = zext i8 %0 to i32
  %mul132 = mul i32 %conv131, 14
  %cmp139 = icmp uge i32 %mul112, %mul100
  %cmp142 = icmp uge i32 %mul112, %mul101
  %add1441 = or i1 %cmp139, %cmp142
  %cmp145 = icmp uge i32 %mul112, %mul102
  %add1472 = or i1 %add1441, %cmp145
  %cmp148 = icmp uge i32 %mul112, %mul103
  %add1503 = or i1 %add1472, %cmp148
  %add150 = zext i1 %add1503 to i64
  %arrayidx155 = getelementptr [8 x i32], ptr %p1, i64 0, i64 %add150
  %1 = load i32, ptr %arrayidx155, align 4
  %cmp165 = icmp uge i32 %mul118, %mul101
  %cmp171 = icmp uge i32 %mul118, %mul103
  %add1734 = or i1 %cmp165, %cmp171
  %add173 = zext i1 %add1734 to i64
  %arrayidx178 = getelementptr [8 x i32], ptr %p2, i64 0, i64 %add173
  %2 = load i32, ptr %arrayidx178, align 4
  %cmp185 = icmp uge i32 %mul125, %mul100
  %cmp188 = icmp uge i32 %mul125, %mul101
  %add1905 = or i1 %cmp185, %cmp188
  %cmp191 = icmp uge i32 %mul125, %mul102
  %add1936 = or i1 %add1905, %cmp191
  %add193 = zext i1 %add1936 to i64
  %arrayidx201 = getelementptr [8 x i32], ptr %p4, i64 0, i64 %add193
  %3 = load i32, ptr %arrayidx201, align 4
  %cmp208 = icmp uge i32 %mul132, %mul100
  %cmp211 = icmp uge i32 %mul132, %mul101
  %add2137 = or i1 %cmp208, %cmp211
  %cmp214 = icmp uge i32 %mul132, %mul102
  %add2168 = or i1 %add2137, %cmp214
  %cmp217 = icmp uge i32 %mul132, %mul103
  %add2199 = or i1 %add2168, %cmp217
  %add219 = zext i1 %add2199 to i64
  %arrayidx224 = getelementptr [8 x i32], ptr %p3, i64 0, i64 %add219
  %4 = load i32, ptr %arrayidx224, align 4
  %conv230 = zext i8 %0 to i32
  %mul231 = mul i32 %conv230, 14
  %conv237 = zext i8 %0 to i32
  %mul238 = mul i32 %conv237, 14
  %conv244 = zext i8 %0 to i32
  %mul245 = mul i32 %conv244, 14
  %conv251 = zext i8 %0 to i32
  %mul252 = mul i32 %conv251, 14
  %cmp262 = icmp uge i32 %mul231, %mul101
  %cmp268 = icmp uge i32 %mul231, %mul103
  %add27010 = or i1 %cmp262, %cmp268
  %add270 = zext i1 %add27010 to i64
  %arrayidx275 = getelementptr [8 x i32], ptr %p1, i64 0, i64 %add270
  %5 = load i32, ptr %arrayidx275, align 4
  %or951 = or i32 %5, %1
  %cmp282 = icmp uge i32 %mul238, %mul100
  %cmp285 = icmp uge i32 %mul238, %mul101
  %add28711 = or i1 %cmp282, %cmp285
  %cmp288 = icmp uge i32 %mul238, %mul102
  %add29012 = or i1 %add28711, %cmp288
  %cmp291 = icmp uge i32 %mul238, %mul103
  %add29313 = or i1 %add29012, %cmp291
  %add293 = zext i1 %add29313 to i64
  %arrayidx298 = getelementptr [8 x i32], ptr %p2, i64 0, i64 %add293
  %6 = load i32, ptr %arrayidx298, align 4
  %or301952 = or i32 %6, %2
  %cmp310 = icmp uge i32 %mul245, %mul101
  %cmp316 = icmp uge i32 %mul245, %mul103
  %add31814 = or i1 %cmp310, %cmp316
  %add318 = zext i1 %add31814 to i64
  %arrayidx323 = getelementptr [8 x i32], ptr %p4, i64 0, i64 %add318
  %7 = load i32, ptr %arrayidx323, align 4
  %or326953 = or i32 %7, %3
  %cmp332 = icmp uge i32 %mul252, %mul100
  %cmp335 = icmp uge i32 %mul252, %mul101
  %add33715 = or i1 %cmp332, %cmp335
  %cmp338 = icmp uge i32 %mul252, %mul102
  %add34016 = or i1 %add33715, %cmp338
  %cmp341 = icmp uge i32 %mul252, %mul103
  %add34317 = or i1 %add34016, %cmp341
  %add343 = zext i1 %add34317 to i64
  %arrayidx348 = getelementptr [8 x i32], ptr %p3, i64 0, i64 %add343
  %8 = load i32, ptr %arrayidx348, align 4
  %or351954 = or i32 %8, %4
  %conv484 = zext i8 %0 to i32
  %mul485 = mul i32 %conv484, 14
  %conv491 = zext i8 %0 to i32
  %mul492 = mul i32 %conv491, 14
  %conv498 = zext i8 %0 to i32
  %mul499 = mul i32 %conv498, 14
  %conv505 = zext i8 %0 to i32
  %mul506 = mul i32 %conv505, 14
  %cmp519 = icmp uge i32 %mul485, %mul102
  %cmp522 = icmp uge i32 %mul485, %mul103
  %add52418 = or i1 %cmp519, %cmp522
  %add524 = zext i1 %add52418 to i64
  %arrayidx529 = getelementptr [8 x i32], ptr %p1, i64 0, i64 %add524
  %9 = load i32, ptr %arrayidx529, align 4
  %cmp541 = icmp uge i32 %mul492, %mul101
  %cmp544 = icmp uge i32 %mul492, %mul102
  %add54619 = or i1 %cmp541, %cmp544
  %cmp547 = icmp uge i32 %mul492, %mul103
  %add54920 = or i1 %add54619, %cmp547
  %add549 = zext i1 %add54920 to i64
  %arrayidx554 = getelementptr [8 x i32], ptr %p2, i64 0, i64 %add549
  %10 = load i32, ptr %arrayidx554, align 4
  %cmp572 = icmp uge i32 %mul499, %mul103
  %conv573 = zext i1 %cmp572 to i64
  %arrayidx579 = getelementptr [8 x i32], ptr %p4, i64 0, i64 %conv573
  %11 = load i32, ptr %arrayidx579, align 4
  %cmp594 = icmp uge i32 %mul506, %mul102
  %conv595 = zext i1 %cmp594 to i64
  %arrayidx604 = getelementptr [8 x i32], ptr %p3, i64 0, i64 %conv595
  %12 = load i32, ptr %arrayidx604, align 4
  %or4791159 = or i32 %or301952, %or951
  %or6071160 = or i32 %or4791159, %or326953
  %or4541161 = or i32 %or6071160, %or351954
  %shl58111621163 = or i32 %11, %12
  %shl55611641165 = or i32 %10, %shl58111621163
  %shl53111661167 = or i32 %9, %shl55611641165
  %shl5311166 = trunc i32 %shl53111661167 to i8
  %conv616 = trunc i32 %or4541161 to i8
  %arrayidx617 = getelementptr i8, ptr %pDst, i64 4
  store i8 %conv616, ptr %arrayidx617, align 1
  store i8 %shl5311166, ptr %pDst, align 1
  ret void
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='sroa<preserve-cfg>' -S | FileCheck %s --check-prefixes=CHECK,CHECK-PRESERVE-CFG
; RUN: opt < %s -passes='sroa<modify-cfg>' -S | FileCheck %s --check-prefixes=CHECK,CHECK-MODIFY-CFG
; RUN: opt -passes='debugify,function(sroa<preserve-cfg>)' -S < %s | FileCheck %s -check-prefix CHECK-DEBUGLOC
; RUN: opt -passes='debugify,function(sroa<preserve-cfg>)' -S < %s --try-experimental-debuginfo-iterators | FileCheck %s -check-prefix CHECK-DEBUGLOC

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-n8:16:32:64"

declare void @llvm.memcpy.p0.p0.i32(ptr, ptr, i32, i1)

define void @test1(ptr %a, ptr %b) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr { i8, i8 }, ptr [[A:%.*]], i32 0, i32 0
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr { i8, i8 }, ptr [[B:%.*]], i32 0, i32 0
; CHECK-NEXT:    [[ALLOCA_SROA_0_0_COPYLOAD:%.*]] = load i8, ptr [[GEP_A]], align 16
; CHECK-NEXT:    [[ALLOCA_SROA_3_0_GEP_A_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[GEP_A]], i64 1
; CHECK-NEXT:    [[ALLOCA_SROA_3_0_COPYLOAD:%.*]] = load i8, ptr [[ALLOCA_SROA_3_0_GEP_A_SROA_IDX]], align 1
; CHECK-NEXT:    store i8 [[ALLOCA_SROA_0_0_COPYLOAD]], ptr [[GEP_B]], align 16
; CHECK-NEXT:    [[ALLOCA_SROA_3_0_GEP_B_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[GEP_B]], i64 1
; CHECK-NEXT:    store i8 [[ALLOCA_SROA_3_0_COPYLOAD]], ptr [[ALLOCA_SROA_3_0_GEP_B_SROA_IDX]], align 1
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test1(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META9:![0-9]+]], !DIExpression(DW_OP_LLVM_fragment, 0, 8), [[META14:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META9]], !DIExpression(DW_OP_LLVM_fragment, 8, 8), [[META14]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META9]], !DIExpression(), [[META14]])
; CHECK-DEBUGLOC-NEXT:    [[GEP_A:%.*]] = getelementptr { i8, i8 }, ptr [[A:%.*]], i32 0, i32 0, !dbg [[DBG15:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[GEP_A]], [[META11:![0-9]+]], !DIExpression(), [[DBG15]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META12:![0-9]+]], !DIExpression(), [[META16:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[GEP_B:%.*]] = getelementptr { i8, i8 }, ptr [[B:%.*]], i32 0, i32 0, !dbg [[DBG17:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[GEP_B]], [[META13:![0-9]+]], !DIExpression(), [[DBG17]])
; CHECK-DEBUGLOC-NEXT:    [[ALLOCA_SROA_0_0_COPYLOAD:%.*]] = load i8, ptr [[GEP_A]], align 16, !dbg [[DBG18:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[ALLOCA_SROA_3_0_GEP_A_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[GEP_A]], i64 1, !dbg [[DBG18]]
; CHECK-DEBUGLOC-NEXT:    [[ALLOCA_SROA_3_0_COPYLOAD:%.*]] = load i8, ptr [[ALLOCA_SROA_3_0_GEP_A_SROA_IDX]], align 1, !dbg [[DBG18]]
; CHECK-DEBUGLOC-NEXT:    store i8 [[ALLOCA_SROA_0_0_COPYLOAD]], ptr [[GEP_B]], align 16, !dbg [[DBG19:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[ALLOCA_SROA_3_0_GEP_B_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[GEP_B]], i64 1, !dbg [[DBG19]]
; CHECK-DEBUGLOC-NEXT:    store i8 [[ALLOCA_SROA_3_0_COPYLOAD]], ptr [[ALLOCA_SROA_3_0_GEP_B_SROA_IDX]], align 1, !dbg [[DBG19]]
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG20:![0-9]+]]
;
entry:
  %alloca = alloca { i8, i8 }, align 16
  %gep_a = getelementptr { i8, i8 }, ptr %a, i32 0, i32 0
  %gep_alloca = getelementptr { i8, i8 }, ptr %alloca, i32 0, i32 0
  %gep_b = getelementptr { i8, i8 }, ptr %b, i32 0, i32 0

  store i8 420, ptr %gep_alloca, align 16

  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %gep_alloca, ptr align 16 %gep_a, i32 2, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 16 %gep_b, ptr align 16 %gep_alloca, i32 2, i1 false)
  ret void
}

define void @test2() {
; Check that when sroa rewrites the alloca partition
; it preserves the original debuglocation.
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca i16, align 2
; CHECK-NEXT:    store volatile i16 0, ptr [[A_SROA_0]], align 2
; CHECK-NEXT:    [[A_SROA_0_1_GEP2_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_0]], i64 1
; CHECK-NEXT:    [[A_SROA_0_1_A_SROA_0_2_RESULT:%.*]] = load i8, ptr [[A_SROA_0_1_GEP2_SROA_IDX]], align 1
; CHECK-NEXT:    [[A_SROA_0_1_GEP2_SROA_IDX2:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_0]], i64 1
; CHECK-NEXT:    store i8 42, ptr [[A_SROA_0_1_GEP2_SROA_IDX2]], align 1
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test2(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0:%.*]] = alloca i16, align 2, !dbg [[DBG28:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[A_SROA_0]], [[META23:![0-9]+]], !DIExpression(DW_OP_LLVM_fragment, 8, 16), [[DBG28]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META23]], !DIExpression(), [[DBG28]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META24:![0-9]+]], !DIExpression(), [[META29:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    store volatile i16 0, ptr [[A_SROA_0]], align 2, !dbg [[DBG30:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META25:![0-9]+]], !DIExpression(), [[META31:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_1_GEP2_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_0]], i64 1, !dbg [[DBG32:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_1_A_SROA_0_2_RESULT:%.*]] = load i8, ptr [[A_SROA_0_1_GEP2_SROA_IDX]], align 1, !dbg [[DBG32]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(i8 [[A_SROA_0_1_A_SROA_0_2_RESULT]], [[META26:![0-9]+]], !DIExpression(), [[DBG32]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_1_GEP2_SROA_IDX2:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_0]], i64 1, !dbg [[DBG33:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    store i8 42, ptr [[A_SROA_0_1_GEP2_SROA_IDX2]], align 1, !dbg [[DBG33]]
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG34:![0-9]+]]
;
entry:
  %a = alloca { i8, i8, i8, i8 }, align 2      ; "line 9" to -debugify
  %gep1 = getelementptr { i8, i8, i8, i8 }, ptr %a, i32 0, i32 1
  store volatile i16 0, ptr %gep1
  %gep2 = getelementptr { i8, i8, i8, i8 }, ptr %a, i32 0, i32 2
  %result = load i8, ptr %gep2
  store i8 42, ptr %gep2
  ret void
}

define void @PR13920(ptr %a, ptr %b) {
; Test that alignments on memcpy intrinsics get propagated to loads and stores.
;
;
; CHECK-LABEL: @PR13920(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[AA_0_COPYLOAD:%.*]] = load <2 x i64>, ptr [[A:%.*]], align 2
; CHECK-NEXT:    store <2 x i64> [[AA_0_COPYLOAD]], ptr [[B:%.*]], align 2
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @PR13920(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META37:![0-9]+]], !DIExpression(), [[META38:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[AA_0_COPYLOAD:%.*]] = load <2 x i64>, ptr [[A:%.*]], align 2, !dbg [[DBG39:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    store <2 x i64> [[AA_0_COPYLOAD]], ptr [[B:%.*]], align 2, !dbg [[DBG40:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG41:![0-9]+]]
;
entry:
  %aa = alloca <2 x i64>, align 16
  call void @llvm.memcpy.p0.p0.i32(ptr align 2 %aa, ptr align 2 %a, i32 16, i1 false)
  call void @llvm.memcpy.p0.p0.i32(ptr align 2 %b, ptr align 2 %aa, i32 16, i1 false)
  ret void
}

define void @test3(ptr %x) {
; Test that when we promote an alloca to a type with lower ABI alignment, we
; provide the needed explicit alignment that code using the alloca may be
; expecting. However, also check that any offset within an alloca can in turn
; reduce the alignment.
;
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca [22 x i8], align 8
; CHECK-NEXT:    [[B_SROA_0:%.*]] = alloca [18 x i8], align 2
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 8 [[A_SROA_0]], ptr align 8 [[X:%.*]], i32 22, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 2 [[B_SROA_0]], ptr align 2 [[X]], i32 18, i1 false)
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test3(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0:%.*]] = alloca [22 x i8], align 8, !dbg [[DBG47:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[A_SROA_0]], [[META44:![0-9]+]], !DIExpression(), [[DBG47]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META44]], !DIExpression(), [[DBG47]])
; CHECK-DEBUGLOC-NEXT:    [[B_SROA_0:%.*]] = alloca [18 x i8], align 2, !dbg [[DBG48:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[B_SROA_0]], [[META45:![0-9]+]], !DIExpression(DW_OP_LLVM_fragment, 48, 16), [[DBG48]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META45]], !DIExpression(), [[DBG48]])
; CHECK-DEBUGLOC-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 8 [[A_SROA_0]], ptr align 8 [[X:%.*]], i32 22, i1 false), !dbg [[DBG49:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META46:![0-9]+]], !DIExpression(), [[META50:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 2 [[B_SROA_0]], ptr align 2 [[X]], i32 18, i1 false), !dbg [[DBG51:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG52:![0-9]+]]
;
entry:
  %a = alloca { ptr, ptr, ptr }
  %b = alloca { ptr, ptr, ptr }
  call void @llvm.memcpy.p0.p0.i32(ptr align 8 %a, ptr align 8 %x, i32 22, i1 false)
  %b_gep = getelementptr i8, ptr %b, i32 6
  call void @llvm.memcpy.p0.p0.i32(ptr align 2 %b_gep, ptr align 2 %x, i32 18, i1 false)
  ret void
}

define void @test5() {
; Test that we preserve underaligned loads and stores when splitting. The use
; of volatile in this test case is just to force the loads and stores to not be
; split or promoted out of existence.
;
;
;
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca [9 x i8], align 1
; CHECK-NEXT:    [[A_SROA_3:%.*]] = alloca [9 x i8], align 1
; CHECK-NEXT:    store volatile double 0.000000e+00, ptr [[A_SROA_0]], align 1
; CHECK-NEXT:    [[A_SROA_0_7_WEIRD_GEP1_SROA_IDX1:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_0]], i64 7
; CHECK-NEXT:    [[A_SROA_0_7_A_SROA_0_7_WEIRD_LOAD1:%.*]] = load volatile i16, ptr [[A_SROA_0_7_WEIRD_GEP1_SROA_IDX1]], align 1
; CHECK-NEXT:    [[A_SROA_0_0_A_SROA_0_0_D1:%.*]] = load double, ptr [[A_SROA_0]], align 1
; CHECK-NEXT:    store volatile double [[A_SROA_0_0_A_SROA_0_0_D1]], ptr [[A_SROA_3]], align 1
; CHECK-NEXT:    [[A_SROA_3_7_WEIRD_GEP2_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_3]], i64 7
; CHECK-NEXT:    [[A_SROA_3_7_A_SROA_3_16_WEIRD_LOAD2:%.*]] = load volatile i16, ptr [[A_SROA_3_7_WEIRD_GEP2_SROA_IDX]], align 1
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test5(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0:%.*]] = alloca [9 x i8], align 1, !dbg [[DBG63:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_3:%.*]] = alloca [9 x i8], align 1, !dbg [[DBG63]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[A_SROA_0]], [[META55:![0-9]+]], !DIExpression(), [[DBG63]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META55]], !DIExpression(), [[DBG63]])
; CHECK-DEBUGLOC-NEXT:    store volatile double 0.000000e+00, ptr [[A_SROA_0]], align 1, !dbg [[DBG64:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META56:![0-9]+]], !DIExpression(), [[META65:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_7_WEIRD_GEP1_SROA_IDX1:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_0]], i64 7, !dbg [[DBG66:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_7_A_SROA_0_7_WEIRD_LOAD1:%.*]] = load volatile i16, ptr [[A_SROA_0_7_WEIRD_GEP1_SROA_IDX1]], align 1, !dbg [[DBG66]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(i16 [[A_SROA_0_7_A_SROA_0_7_WEIRD_LOAD1]], [[META57:![0-9]+]], !DIExpression(), [[DBG66]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META59:![0-9]+]], !DIExpression(), [[META67:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_0_A_SROA_0_0_D1:%.*]] = load double, ptr [[A_SROA_0]], align 1, !dbg [[DBG68:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(double [[A_SROA_0_0_A_SROA_0_0_D1]], [[META60:![0-9]+]], !DIExpression(), [[DBG68]])
; CHECK-DEBUGLOC-NEXT:    store volatile double [[A_SROA_0_0_A_SROA_0_0_D1]], ptr [[A_SROA_3]], align 1, !dbg [[DBG69:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META61:![0-9]+]], !DIExpression(), [[META70:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_3_7_WEIRD_GEP2_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[A_SROA_3]], i64 7, !dbg [[DBG71:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_3_7_A_SROA_3_16_WEIRD_LOAD2:%.*]] = load volatile i16, ptr [[A_SROA_3_7_WEIRD_GEP2_SROA_IDX]], align 1, !dbg [[DBG71]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(i16 [[A_SROA_3_7_A_SROA_3_16_WEIRD_LOAD2]], [[META62:![0-9]+]], !DIExpression(), [[DBG71]])
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG72:![0-9]+]]
;
entry:
  %a = alloca [18 x i8]
  store volatile double 0.0, ptr %a, align 1
  %weird_gep1 = getelementptr inbounds [18 x i8], ptr %a, i32 0, i32 7
  %weird_load1 = load volatile i16, ptr %weird_gep1, align 1

  %raw2 = getelementptr inbounds [18 x i8], ptr %a, i32 0, i32 9
  %d1 = load double, ptr %a, align 1
  store volatile double %d1, ptr %raw2, align 1
  %weird_gep2 = getelementptr inbounds [18 x i8], ptr %a, i32 0, i32 16
  %weird_load2 = load volatile i16, ptr %weird_gep2, align 1

  ret void
}

define void @test6() {
; We should set the alignment on all load and store operations; make sure
; we choose an appropriate alignment.
;
;
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca double, align 8
; CHECK-NEXT:    [[A_SROA_2:%.*]] = alloca double, align 8
; CHECK-NEXT:    store volatile double 0.000000e+00, ptr [[A_SROA_0]], align 8
; CHECK-NEXT:    [[A_SROA_0_0_A_SROA_0_0_VAL:%.*]] = load double, ptr [[A_SROA_0]], align 8
; CHECK-NEXT:    store volatile double [[A_SROA_0_0_A_SROA_0_0_VAL]], ptr [[A_SROA_2]], align 8
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test6(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0:%.*]] = alloca double, align 8, !dbg [[DBG78:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_2:%.*]] = alloca double, align 8, !dbg [[DBG78]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[A_SROA_0]], [[META75:![0-9]+]], !DIExpression(), [[DBG78]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META75]], !DIExpression(), [[DBG78]])
; CHECK-DEBUGLOC-NEXT:    store volatile double 0.000000e+00, ptr [[A_SROA_0]], align 8, !dbg [[DBG79:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META76:![0-9]+]], !DIExpression(), [[META80:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_0_A_SROA_0_0_VAL:%.*]] = load double, ptr [[A_SROA_0]], align 8, !dbg [[DBG81:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(double [[A_SROA_0_0_A_SROA_0_0_VAL]], [[META77:![0-9]+]], !DIExpression(), [[DBG81]])
; CHECK-DEBUGLOC-NEXT:    store volatile double [[A_SROA_0_0_A_SROA_0_0_VAL]], ptr [[A_SROA_2]], align 8, !dbg [[DBG82:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG83:![0-9]+]]
;
entry:
  %a = alloca [16 x i8]
  store volatile double 0.0, ptr %a, align 1

  %raw2 = getelementptr inbounds [16 x i8], ptr %a, i32 0, i32 8
  %val = load double, ptr %a, align 1
  store volatile double %val, ptr %raw2, align 1

  ret void
}

define void @test7(ptr %out) {
; Test that we properly compute the destination alignment when rewriting
; memcpys as direct loads or stores.
;
;
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_0_COPYLOAD:%.*]] = load double, ptr [[OUT:%.*]], align 1
; CHECK-NEXT:    [[A_SROA_4_0_OUT_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[OUT]], i64 8
; CHECK-NEXT:    [[A_SROA_4_0_COPYLOAD:%.*]] = load double, ptr [[A_SROA_4_0_OUT_SROA_IDX]], align 1
; CHECK-NEXT:    store double [[A_SROA_4_0_COPYLOAD]], ptr [[OUT]], align 1
; CHECK-NEXT:    [[A_SROA_4_0_OUT_SROA_IDX2:%.*]] = getelementptr inbounds i8, ptr [[OUT]], i64 8
; CHECK-NEXT:    store double [[A_SROA_0_0_COPYLOAD]], ptr [[A_SROA_4_0_OUT_SROA_IDX2]], align 1
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test7(
; CHECK-DEBUGLOC-NEXT:  entry:
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META86:![0-9]+]], !DIExpression(), [[META90:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META86]], !DIExpression(), [[META90]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META87:![0-9]+]], !DIExpression(), [[META91:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_0_0_COPYLOAD:%.*]] = load double, ptr [[OUT:%.*]], align 1, !dbg [[DBG92:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_4_0_OUT_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[OUT]], i64 8, !dbg [[DBG92]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_4_0_COPYLOAD:%.*]] = load double, ptr [[A_SROA_4_0_OUT_SROA_IDX]], align 1, !dbg [[DBG92]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(double [[A_SROA_4_0_COPYLOAD]], [[META88:![0-9]+]], !DIExpression(), [[META93:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(double [[A_SROA_0_0_COPYLOAD]], [[META89:![0-9]+]], !DIExpression(), [[META94:![0-9]+]])
; CHECK-DEBUGLOC-NEXT:    store double [[A_SROA_4_0_COPYLOAD]], ptr [[OUT]], align 1, !dbg [[DBG95:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[A_SROA_4_0_OUT_SROA_IDX2:%.*]] = getelementptr inbounds i8, ptr [[OUT]], i64 8, !dbg [[DBG95]]
; CHECK-DEBUGLOC-NEXT:    store double [[A_SROA_0_0_COPYLOAD]], ptr [[A_SROA_4_0_OUT_SROA_IDX2]], align 1, !dbg [[DBG95]]
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG96:![0-9]+]]
;
entry:
  %a = alloca [16 x i8]
  %raw2 = getelementptr inbounds [16 x i8], ptr %a, i32 0, i32 8

  call void @llvm.memcpy.p0.p0.i32(ptr %a, ptr %out, i32 16, i1 false)

  %val1 = load double, ptr %raw2, align 1
  %val2 = load double, ptr %a, align 1

  store double %val1, ptr %a, align 1
  store double %val2, ptr %raw2, align 1

  call void @llvm.memcpy.p0.p0.i32(ptr %out, ptr %a, i32 16, i1 false)

  ret void
}

define void @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[PTR:%.*]] = alloca [5 x i32], align 1
; CHECK-NEXT:    call void @populate(ptr [[PTR]])
; CHECK-NEXT:    [[VAL_FCA_0_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 0
; CHECK-NEXT:    [[VAL_FCA_0_LOAD:%.*]] = load i32, ptr [[VAL_FCA_0_GEP]], align 1
; CHECK-NEXT:    [[VAL_FCA_0_INSERT:%.*]] = insertvalue [5 x i32] poison, i32 [[VAL_FCA_0_LOAD]], 0
; CHECK-NEXT:    [[VAL_FCA_1_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 1
; CHECK-NEXT:    [[VAL_FCA_1_LOAD:%.*]] = load i32, ptr [[VAL_FCA_1_GEP]], align 1
; CHECK-NEXT:    [[VAL_FCA_1_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_0_INSERT]], i32 [[VAL_FCA_1_LOAD]], 1
; CHECK-NEXT:    [[VAL_FCA_2_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 2
; CHECK-NEXT:    [[VAL_FCA_2_LOAD:%.*]] = load i32, ptr [[VAL_FCA_2_GEP]], align 1
; CHECK-NEXT:    [[VAL_FCA_2_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_1_INSERT]], i32 [[VAL_FCA_2_LOAD]], 2
; CHECK-NEXT:    [[VAL_FCA_3_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 3
; CHECK-NEXT:    [[VAL_FCA_3_LOAD:%.*]] = load i32, ptr [[VAL_FCA_3_GEP]], align 1
; CHECK-NEXT:    [[VAL_FCA_3_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_2_INSERT]], i32 [[VAL_FCA_3_LOAD]], 3
; CHECK-NEXT:    [[VAL_FCA_4_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 4
; CHECK-NEXT:    [[VAL_FCA_4_LOAD:%.*]] = load i32, ptr [[VAL_FCA_4_GEP]], align 1
; CHECK-NEXT:    [[VAL_FCA_4_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_3_INSERT]], i32 [[VAL_FCA_4_LOAD]], 4
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test8(
; CHECK-DEBUGLOC-NEXT:    [[PTR:%.*]] = alloca [5 x i32], align 1, !dbg [[DBG102:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[PTR]], [[META99:![0-9]+]], !DIExpression(), [[DBG102]])
; CHECK-DEBUGLOC-NEXT:    call void @populate(ptr [[PTR]]), !dbg [[DBG103:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 0, !dbg [[DBG104:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_LOAD:%.*]] = load i32, ptr [[VAL_FCA_0_GEP]], align 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_INSERT:%.*]] = insertvalue [5 x i32] poison, i32 [[VAL_FCA_0_LOAD]], 0, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_LOAD:%.*]] = load i32, ptr [[VAL_FCA_1_GEP]], align 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_0_INSERT]], i32 [[VAL_FCA_1_LOAD]], 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 2, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_LOAD:%.*]] = load i32, ptr [[VAL_FCA_2_GEP]], align 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_1_INSERT]], i32 [[VAL_FCA_2_LOAD]], 2, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 3, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_LOAD:%.*]] = load i32, ptr [[VAL_FCA_3_GEP]], align 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_2_INSERT]], i32 [[VAL_FCA_3_LOAD]], 3, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_4_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 4, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_4_LOAD:%.*]] = load i32, ptr [[VAL_FCA_4_GEP]], align 1, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_4_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_3_INSERT]], i32 [[VAL_FCA_4_LOAD]], 4, !dbg [[DBG104]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value([5 x i32] [[VAL_FCA_4_INSERT]], [[META100:![0-9]+]], !DIExpression(), [[DBG104]])
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG105:![0-9]+]]
;
  %ptr = alloca [5 x i32], align 1
  call void @populate(ptr %ptr)
  %val = load [5 x i32], ptr %ptr, align 1
  ret void
}

define void @test9() {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[PTR:%.*]] = alloca [5 x i32], align 8
; CHECK-NEXT:    call void @populate(ptr [[PTR]])
; CHECK-NEXT:    [[VAL_FCA_0_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 0
; CHECK-NEXT:    [[VAL_FCA_0_LOAD:%.*]] = load i32, ptr [[VAL_FCA_0_GEP]], align 8
; CHECK-NEXT:    [[VAL_FCA_0_INSERT:%.*]] = insertvalue [5 x i32] poison, i32 [[VAL_FCA_0_LOAD]], 0
; CHECK-NEXT:    [[VAL_FCA_1_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 1
; CHECK-NEXT:    [[VAL_FCA_1_LOAD:%.*]] = load i32, ptr [[VAL_FCA_1_GEP]], align 4
; CHECK-NEXT:    [[VAL_FCA_1_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_0_INSERT]], i32 [[VAL_FCA_1_LOAD]], 1
; CHECK-NEXT:    [[VAL_FCA_2_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 2
; CHECK-NEXT:    [[VAL_FCA_2_LOAD:%.*]] = load i32, ptr [[VAL_FCA_2_GEP]], align 8
; CHECK-NEXT:    [[VAL_FCA_2_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_1_INSERT]], i32 [[VAL_FCA_2_LOAD]], 2
; CHECK-NEXT:    [[VAL_FCA_3_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 3
; CHECK-NEXT:    [[VAL_FCA_3_LOAD:%.*]] = load i32, ptr [[VAL_FCA_3_GEP]], align 4
; CHECK-NEXT:    [[VAL_FCA_3_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_2_INSERT]], i32 [[VAL_FCA_3_LOAD]], 3
; CHECK-NEXT:    [[VAL_FCA_4_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 4
; CHECK-NEXT:    [[VAL_FCA_4_LOAD:%.*]] = load i32, ptr [[VAL_FCA_4_GEP]], align 8
; CHECK-NEXT:    [[VAL_FCA_4_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_3_INSERT]], i32 [[VAL_FCA_4_LOAD]], 4
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test9(
; CHECK-DEBUGLOC-NEXT:    [[PTR:%.*]] = alloca [5 x i32], align 8, !dbg [[DBG110:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[PTR]], [[META108:![0-9]+]], !DIExpression(), [[DBG110]])
; CHECK-DEBUGLOC-NEXT:    call void @populate(ptr [[PTR]]), !dbg [[DBG111:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 0, !dbg [[DBG112:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_LOAD:%.*]] = load i32, ptr [[VAL_FCA_0_GEP]], align 8, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_INSERT:%.*]] = insertvalue [5 x i32] poison, i32 [[VAL_FCA_0_LOAD]], 0, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 1, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_LOAD:%.*]] = load i32, ptr [[VAL_FCA_1_GEP]], align 4, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_0_INSERT]], i32 [[VAL_FCA_1_LOAD]], 1, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 2, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_LOAD:%.*]] = load i32, ptr [[VAL_FCA_2_GEP]], align 8, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_1_INSERT]], i32 [[VAL_FCA_2_LOAD]], 2, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 3, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_LOAD:%.*]] = load i32, ptr [[VAL_FCA_3_GEP]], align 4, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_2_INSERT]], i32 [[VAL_FCA_3_LOAD]], 3, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_4_GEP:%.*]] = getelementptr inbounds [5 x i32], ptr [[PTR]], i32 0, i32 4, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_4_LOAD:%.*]] = load i32, ptr [[VAL_FCA_4_GEP]], align 8, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_4_INSERT:%.*]] = insertvalue [5 x i32] [[VAL_FCA_3_INSERT]], i32 [[VAL_FCA_4_LOAD]], 4, !dbg [[DBG112]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value([5 x i32] [[VAL_FCA_4_INSERT]], [[META109:![0-9]+]], !DIExpression(), [[DBG112]])
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG113:![0-9]+]]
;
  %ptr = alloca [5 x i32], align 8
  call void @populate(ptr %ptr)
  %val = load [5 x i32], ptr %ptr, align 8
  ret void
}

define void @test10() {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[PTR:%.*]] = alloca { i32, i8, i8, { i8, i16 } }, align 2
; CHECK-NEXT:    call void @populate(ptr [[PTR]])
; CHECK-NEXT:    [[VAL_FCA_0_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 0
; CHECK-NEXT:    [[VAL_FCA_0_LOAD:%.*]] = load i32, ptr [[VAL_FCA_0_GEP]], align 2
; CHECK-NEXT:    [[VAL_FCA_0_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } poison, i32 [[VAL_FCA_0_LOAD]], 0
; CHECK-NEXT:    [[VAL_FCA_1_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 1
; CHECK-NEXT:    [[VAL_FCA_1_LOAD:%.*]] = load i8, ptr [[VAL_FCA_1_GEP]], align 2
; CHECK-NEXT:    [[VAL_FCA_1_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_0_INSERT]], i8 [[VAL_FCA_1_LOAD]], 1
; CHECK-NEXT:    [[VAL_FCA_2_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 2
; CHECK-NEXT:    [[VAL_FCA_2_LOAD:%.*]] = load i8, ptr [[VAL_FCA_2_GEP]], align 1
; CHECK-NEXT:    [[VAL_FCA_2_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_1_INSERT]], i8 [[VAL_FCA_2_LOAD]], 2
; CHECK-NEXT:    [[VAL_FCA_3_0_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 3, i32 0
; CHECK-NEXT:    [[VAL_FCA_3_0_LOAD:%.*]] = load i8, ptr [[VAL_FCA_3_0_GEP]], align 2
; CHECK-NEXT:    [[VAL_FCA_3_0_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_2_INSERT]], i8 [[VAL_FCA_3_0_LOAD]], 3, 0
; CHECK-NEXT:    [[VAL_FCA_3_1_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 3, i32 1
; CHECK-NEXT:    [[VAL_FCA_3_1_LOAD:%.*]] = load i16, ptr [[VAL_FCA_3_1_GEP]], align 2
; CHECK-NEXT:    [[VAL_FCA_3_1_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_3_0_INSERT]], i16 [[VAL_FCA_3_1_LOAD]], 3, 1
; CHECK-NEXT:    ret void
;
; CHECK-DEBUGLOC-LABEL: @test10(
; CHECK-DEBUGLOC-NEXT:    [[PTR:%.*]] = alloca { i32, i8, i8, { i8, i16 } }, align 2, !dbg [[DBG119:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[PTR]], [[META116:![0-9]+]], !DIExpression(), [[DBG119]])
; CHECK-DEBUGLOC-NEXT:    call void @populate(ptr [[PTR]]), !dbg [[DBG120:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 0, !dbg [[DBG121:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_LOAD:%.*]] = load i32, ptr [[VAL_FCA_0_GEP]], align 2, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_0_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } poison, i32 [[VAL_FCA_0_LOAD]], 0, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 1, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_LOAD:%.*]] = load i8, ptr [[VAL_FCA_1_GEP]], align 2, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_1_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_0_INSERT]], i8 [[VAL_FCA_1_LOAD]], 1, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 2, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_LOAD:%.*]] = load i8, ptr [[VAL_FCA_2_GEP]], align 1, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_2_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_1_INSERT]], i8 [[VAL_FCA_2_LOAD]], 2, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_0_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 3, i32 0, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_0_LOAD:%.*]] = load i8, ptr [[VAL_FCA_3_0_GEP]], align 2, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_0_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_2_INSERT]], i8 [[VAL_FCA_3_0_LOAD]], 3, 0, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_1_GEP:%.*]] = getelementptr inbounds { i32, i8, i8, { i8, i16 } }, ptr [[PTR]], i32 0, i32 3, i32 1, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_1_LOAD:%.*]] = load i16, ptr [[VAL_FCA_3_1_GEP]], align 2, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:    [[VAL_FCA_3_1_INSERT:%.*]] = insertvalue { i32, i8, i8, { i8, i16 } } [[VAL_FCA_3_0_INSERT]], i16 [[VAL_FCA_3_1_LOAD]], 3, 1, !dbg [[DBG121]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value({ i32, i8, i8, { i8, i16 } } [[VAL_FCA_3_1_INSERT]], [[META117:![0-9]+]], !DIExpression(), [[DBG121]])
; CHECK-DEBUGLOC-NEXT:    ret void, !dbg [[DBG122:![0-9]+]]
;
  %ptr = alloca {i32, i8, i8, {i8, i16}}, align 2
  call void @populate(ptr %ptr)
  %val = load {i32, i8, i8, {i8, i16}}, ptr %ptr, align 2
  ret void
}

%struct = type { i32, i32 }
define dso_local i32 @pr45010(ptr %A) {
; CHECK-LABEL: @pr45010(
; CHECK-NEXT:    [[B_SROA_0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[A:%.*]], align 4
; CHECK-NEXT:    store atomic volatile i32 [[TMP1]], ptr [[B_SROA_0]] release, align 4
; CHECK-NEXT:    [[B_SROA_0_0_B_SROA_0_0_X:%.*]] = load atomic volatile i32, ptr [[B_SROA_0]] acquire, align 4
; CHECK-NEXT:    ret i32 [[B_SROA_0_0_B_SROA_0_0_X]]
;
; CHECK-DEBUGLOC-LABEL: @pr45010(
; CHECK-DEBUGLOC-NEXT:    [[B_SROA_0:%.*]] = alloca i32, align 4, !dbg [[DBG129:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr [[B_SROA_0]], [[META125:![0-9]+]], !DIExpression(DW_OP_LLVM_fragment, 0, 32), [[DBG129]])
; CHECK-DEBUGLOC-NEXT:      #dbg_value(ptr undef, [[META125]], !DIExpression(), [[DBG129]])
; CHECK-DEBUGLOC-NEXT:    [[TMP1:%.*]] = load i32, ptr [[A:%.*]], align 4, !dbg [[DBG130:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(i32 [[TMP1]], [[META126:![0-9]+]], !DIExpression(), [[DBG130]])
; CHECK-DEBUGLOC-NEXT:    store atomic volatile i32 [[TMP1]], ptr [[B_SROA_0]] release, align 4, !dbg [[DBG131:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:    [[B_SROA_0_0_B_SROA_0_0_X:%.*]] = load atomic volatile i32, ptr [[B_SROA_0]] acquire, align 4, !dbg [[DBG132:![0-9]+]]
; CHECK-DEBUGLOC-NEXT:      #dbg_value(i32 [[B_SROA_0_0_B_SROA_0_0_X]], [[META128:![0-9]+]], !DIExpression(), [[DBG132]])
; CHECK-DEBUGLOC-NEXT:    ret i32 [[B_SROA_0_0_B_SROA_0_0_X]], !dbg [[DBG133:![0-9]+]]
;
  %B = alloca %struct, align 4
  %1 = load i32, ptr %A, align 4
  store atomic volatile i32 %1, ptr %B release, align 4
  %x = load atomic volatile i32, ptr %B acquire, align 4
  ret i32 %x
}

declare void @populate(ptr)
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-MODIFY-CFG: {{.*}}
; CHECK-PRESERVE-CFG: {{.*}}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=vector-combine -S %s | FileCheck %s

target triple = "aarch64"

define i32 @reducebase_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reducebase_v4i32(
; CHECK-NEXT:    [[X:%.*]] = xor <4 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = xor <4 x i32> %a, %b
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_onein_v4i32(<4 x i32> %a) {
; CHECK-LABEL: @reduceshuffle_onein_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_onein_const_v4i32(<4 x i32> %a) {
; CHECK-LABEL: @reduceshuffle_onein_const_v4i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[X:%.*]] = xor <4 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %x = xor <4 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_onein_argin_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_onein_argin_v4i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
; CHECK-NEXT:    [[X:%.*]] = xor <4 x i32> [[S]], [[B:%.*]]
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %x = xor <4 x i32> %s, %b
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_onein_constnonsplat_v4i32(<4 x i32> %a) {
; CHECK-LABEL: @reduceshuffle_onein_constnonsplat_v4i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
; CHECK-NEXT:    [[X:%.*]] = xor <4 x i32> [[S]], <i32 -1, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %x = xor <4 x i32> %s, <i32 -1, i32 1, i32 2, i32 3>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_OK_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_OK_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_concat_v4i32(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_concat_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <2 x i32> %a, <2 x i32> %b, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_lowelts_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_lowelts_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 5, i32 1, i32 4>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_notlowelts_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_notlowelts_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 4, i32 6>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 6, i32 1, i32 4>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_repeat_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_repeat_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 4, i32 1, i32 4>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 4, i32 1, i32 4>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_uneven_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_uneven_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 4>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 2, i32 1, i32 4>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_undef_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_undef_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 poison, i32 1, i32 5>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 undef, i32 1, i32 5>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_undef2_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_undef2_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 4, i32 poison>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 4, i32 undef, i32 1, i32 0>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_multiundef_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_multiundef_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 undef, i32 undef, i32 1>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_extrashuffleuse_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_extrashuffleuse_v4i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 5, i32 1, i32 4>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    call void @use(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 5, i32 1, i32 4>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  call void @use(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_extraotheruse_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_extraotheruse_v4i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 5, i32 1, i32 4>
; CHECK-NEXT:    [[X:%.*]] = xor <4 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    call void @use(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 5, i32 1, i32 4>
  %x = xor <4 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  call void @use(<4 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_splat_v4i32(<4 x i32> %a, <4 x i32> %b, i32 %c) {
; CHECK-LABEL: @reduceshuffle_twoin_splat_v4i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; CHECK-NEXT:    [[INSERT:%.*]] = insertelement <4 x i32> poison, i32 [[C:%.*]], i32 0
; CHECK-NEXT:    [[SPLAT:%.*]] = shufflevector <4 x i32> [[INSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[X:%.*]] = xor <4 x i32> [[S]], [[SPLAT]]
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 5, i32 1, i32 4>
  %insert = insertelement <4 x i32> poison, i32 %c, i32 0
  %splat = shufflevector <4 x i32> %insert, <4 x i32> poison, <4 x i32> zeroinitializer
  %x = xor <4 x i32> %s, %splat
  %r = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %r
}


define i32 @reducebase_v16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: @reducebase_v16i32(
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = xor <16 x i32> %a, %b
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_onein_v16i32(<16 x i32> %a) {
; CHECK-LABEL: @reduceshuffle_onein_v16i32(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %x = shufflevector <16 x i32> %a, <16 x i32> undef, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_onein_ext_v16i32(<16 x i32> %a) {
; CHECK-LABEL: @reduceshuffle_onein_ext_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <16 x i32> %a, <16 x i32> undef, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %x = xor <16 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_concat_v16i32(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_concat_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <8 x i32> %a, <8 x i32> %b, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %x = xor <16 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_lowelt_v16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_lowelt_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <16 x i32> %a, <16 x i32> %b, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 16, i32 18, i32 20, i32 22, i32 1, i32 3, i32 5, i32 7, i32 17, i32 19, i32 21, i32 23>
  %x = xor <16 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_notlowelt_v16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_notlowelt_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 21, i32 22, i32 7, i32 24, i32 25, i32 10, i32 27, i32 28, i32 13, i32 30, i32 31>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <16 x i32> %a, <16 x i32> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 21, i32 22, i32 7, i32 24, i32 25, i32 10, i32 27, i32 28, i32 13, i32 30, i32 31>
  %x = xor <16 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_uneven_v16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_uneven_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i32> [[S]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[X]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <16 x i32> %a, <16 x i32> %b, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 16, i32 18, i32 20, i32 22, i32 1, i32 3, i32 5, i32 7, i32 17, i32 19, i32 21, i32 8>
  %x = xor <16 x i32> %s, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %x)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_shr1_v16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_shr1_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; CHECK-NEXT:    [[A1:%.*]] = lshr <16 x i32> [[S]], <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
; CHECK-NEXT:    [[A2:%.*]] = and <16 x i32> [[A1]], <i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537>
; CHECK-NEXT:    [[A3:%.*]] = mul nuw <16 x i32> [[A2]], <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
; CHECK-NEXT:    [[A4:%.*]] = add <16 x i32> [[A3]], [[S]]
; CHECK-NEXT:    [[A5:%.*]] = xor <16 x i32> [[A4]], [[A3]]
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[A5]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <16 x i32> %a, <16 x i32> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 16, i32 17, i32 5, i32 18, i32 19, i32 6, i32 20, i32 21, i32 7, i32 22, i32 23>
  %a1 = lshr <16 x i32> %s, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %a2 = and <16 x i32> %a1, <i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537>
  %a3 = mul nuw <16 x i32> %a2, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  %a4 = add <16 x i32> %a3, %s
  %a5 = xor <16 x i32> %a4, %a3
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %a5)
  ret i32 %r
}

define i32 @reduceshuffle_twoin_shr2_v16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_shr2_v16i32(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i32> [[A:%.*]], <16 x i32> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; CHECK-NEXT:    [[A1:%.*]] = lshr <16 x i32> <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>, [[S]]
; CHECK-NEXT:    [[A2:%.*]] = and <16 x i32> [[A1]], <i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537>
; CHECK-NEXT:    [[A3:%.*]] = mul nuw <16 x i32> [[A2]], <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
; CHECK-NEXT:    [[A4:%.*]] = add <16 x i32> [[A3]], [[S]]
; CHECK-NEXT:    [[A5:%.*]] = xor <16 x i32> [[A4]], [[A3]]
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> [[A5]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %s = shufflevector <16 x i32> %a, <16 x i32> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 16, i32 17, i32 5, i32 18, i32 19, i32 6, i32 20, i32 21, i32 7, i32 22, i32 23>
  %a1 = lshr <16 x i32> <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>, %s
  %a2 = and <16 x i32> %a1, <i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537, i32 65537>
  %a3 = mul nuw <16 x i32> %a2, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  %a4 = add <16 x i32> %a3, %s
  %a5 = xor <16 x i32> %a4, %a3
  %r = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %a5)
  ret i32 %r
}

; i16

define i16 @reducebase_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: @reducebase_v16i16(
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i16> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %x = xor <16 x i16> %a, %b
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_onein_v16i16(<16 x i16> %a) {
; CHECK-LABEL: @reduceshuffle_onein_v16i16(
; CHECK-NEXT:    [[X:%.*]] = shufflevector <16 x i16> [[A:%.*]], <16 x i16> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %x = shufflevector <16 x i16> %a, <16 x i16> undef, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_onein_ext_v16i16(<16 x i16> %a) {
; CHECK-LABEL: @reduceshuffle_onein_ext_v16i16(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i16> [[A:%.*]], <16 x i16> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i16> [[S]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %s = shufflevector <16 x i16> %a, <16 x i16> undef, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %x = xor <16 x i16> %s, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_twoin_concat_v16i16(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_concat_v16i16(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <8 x i16> [[A:%.*]], <8 x i16> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i16> [[S]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %s = shufflevector <8 x i16> %a, <8 x i16> %b, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %x = xor <16 x i16> %s, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_twoin_lowelt_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_lowelt_v16i16(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i16> [[A:%.*]], <16 x i16> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i16> [[S]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %s = shufflevector <16 x i16> %a, <16 x i16> %b, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 16, i32 18, i32 20, i32 22, i32 1, i32 3, i32 5, i32 7, i32 17, i32 19, i32 21, i32 23>
  %x = xor <16 x i16> %s, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_twoin_notlowelt_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_notlowelt_v16i16(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i16> [[A:%.*]], <16 x i16> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 21, i32 22, i32 7, i32 24, i32 25, i32 10, i32 27, i32 28, i32 13, i32 30, i32 31>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i16> [[S]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %s = shufflevector <16 x i16> %a, <16 x i16> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 21, i32 22, i32 7, i32 24, i32 25, i32 10, i32 27, i32 28, i32 13, i32 30, i32 31>
  %x = xor <16 x i16> %s, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_twoin_uneven_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_uneven_v16i16(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i16> [[A:%.*]], <16 x i16> [[B:%.*]], <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 16, i32 18, i32 20, i32 22, i32 1, i32 3, i32 5, i32 7, i32 17, i32 19, i32 21, i32 8>
; CHECK-NEXT:    [[X:%.*]] = xor <16 x i16> [[S]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[X]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %s = shufflevector <16 x i16> %a, <16 x i16> %b, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 16, i32 18, i32 20, i32 22, i32 1, i32 3, i32 5, i32 7, i32 17, i32 19, i32 21, i32 8>
  %x = xor <16 x i16> %s, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %x)
  ret i16 %r
}

define i16 @reduceshuffle_twoin_ext_v16i16(<16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: @reduceshuffle_twoin_ext_v16i16(
; CHECK-NEXT:    [[S:%.*]] = shufflevector <16 x i16> [[A:%.*]], <16 x i16> [[B:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
; CHECK-NEXT:    [[A1:%.*]] = lshr <16 x i16> [[S]], <i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7>
; CHECK-NEXT:    [[A2:%.*]] = and <16 x i16> [[A1]], <i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257>
; CHECK-NEXT:    [[A3:%.*]] = mul nuw <16 x i16> [[A2]], <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
; CHECK-NEXT:    [[A4:%.*]] = add <16 x i16> [[A3]], [[S]]
; CHECK-NEXT:    [[A5:%.*]] = xor <16 x i16> [[A4]], [[A3]]
; CHECK-NEXT:    [[R:%.*]] = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> [[A5]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %s = shufflevector <16 x i16> %a, <16 x i16> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 16, i32 17, i32 5, i32 18, i32 19, i32 6, i32 20, i32 21, i32 7, i32 22, i32 23>
  %a1 = lshr <16 x i16> %s, <i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7, i16 7>
  %a2 = and <16 x i16> %a1, <i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257>
  %a3 = mul nuw <16 x i16> %a2, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %a4 = add <16 x i16> %a3, %s
  %a5 = xor <16 x i16> %a4, %a3
  %r = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %a5)
  ret i16 %r
}

declare void @use(<4 x i32>)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>)
declare i16 @llvm.vector.reduce.add.v16i16(<16 x i16>)

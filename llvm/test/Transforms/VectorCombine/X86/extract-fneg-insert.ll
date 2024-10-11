; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=SSE2 | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=AVX2 | FileCheck %s --check-prefixes=CHECK,AVX

declare void @use(float)

; TODO: The insert is costed as free, so creating a shuffle appears to be a loss.

define <4 x float> @ext0_v4f32(<4 x float> %x, <4 x float> %y) {
; CHECK-LABEL: @ext0_v4f32(
; CHECK-NEXT:    [[TMP1:%.*]] = fneg <4 x float> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x float> [[Y:%.*]], <4 x float> [[TMP1]], <4 x i32> <i32 4, i32 1, i32 2, i32 3>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %e = extractelement <4 x float> %x, i32 0
  %n = fneg float %e
  %r = insertelement <4 x float> %y, float %n, i32 0
  ret <4 x float> %r
}

; Eliminating extract/insert is profitable.

define <4 x float> @ext2_v4f32(<4 x float> %x, <4 x float> %y) {
; CHECK-LABEL: @ext2_v4f32(
; CHECK-NEXT:    [[TMP1:%.*]] = fneg <4 x float> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <4 x float> [[Y:%.*]], <4 x float> [[TMP1]], <4 x i32> <i32 0, i32 1, i32 6, i32 3>
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %e = extractelement <4 x float> %x, i32 2
  %n = fneg float %e
  %r = insertelement <4 x float> %y, float %n, i32 2
  ret <4 x float> %r
}

; Eliminating extract/insert is still profitable. Flags propagate.

define <2 x double> @ext1_v2f64(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext1_v2f64(
; CHECK-NEXT:    [[TMP1:%.*]] = fneg nsz <2 x double> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <2 x double> [[Y:%.*]], <2 x double> [[TMP1]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    ret <2 x double> [[R]]
;
  %e = extractelement <2 x double> %x, i32 1
  %n = fneg nsz double %e
  %r = insertelement <2 x double> %y, double %n, i32 1
  ret <2 x double> %r
}

; The vector fneg would cost twice as much as the scalar op with SSE,
; so we don't transform there (the shuffle would also be more expensive).

define <8 x float> @ext7_v8f32(<8 x float> %x, <8 x float> %y) {
; SSE-LABEL: @ext7_v8f32(
; SSE-NEXT:    [[E:%.*]] = extractelement <8 x float> [[X:%.*]], i32 7
; SSE-NEXT:    [[N:%.*]] = fneg float [[E]]
; SSE-NEXT:    [[R:%.*]] = insertelement <8 x float> [[Y:%.*]], float [[N]], i32 7
; SSE-NEXT:    ret <8 x float> [[R]]
;
; AVX-LABEL: @ext7_v8f32(
; AVX-NEXT:    [[TMP1:%.*]] = fneg <8 x float> [[X:%.*]]
; AVX-NEXT:    [[R:%.*]] = shufflevector <8 x float> [[Y:%.*]], <8 x float> [[TMP1]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 15>
; AVX-NEXT:    ret <8 x float> [[R]]
;
  %e = extractelement <8 x float> %x, i32 7
  %n = fneg float %e
  %r = insertelement <8 x float> %y, float %n, i32 7
  ret <8 x float> %r
}

; Same as above with an extra use of the extracted element.

define <8 x float> @ext7_v8f32_use1(<8 x float> %x, <8 x float> %y) {
; SSE-LABEL: @ext7_v8f32_use1(
; SSE-NEXT:    [[E:%.*]] = extractelement <8 x float> [[X:%.*]], i32 5
; SSE-NEXT:    call void @use(float [[E]])
; SSE-NEXT:    [[N:%.*]] = fneg float [[E]]
; SSE-NEXT:    [[R:%.*]] = insertelement <8 x float> [[Y:%.*]], float [[N]], i32 5
; SSE-NEXT:    ret <8 x float> [[R]]
;
; AVX-LABEL: @ext7_v8f32_use1(
; AVX-NEXT:    [[E:%.*]] = extractelement <8 x float> [[X:%.*]], i32 5
; AVX-NEXT:    call void @use(float [[E]])
; AVX-NEXT:    [[TMP1:%.*]] = fneg <8 x float> [[X]]
; AVX-NEXT:    [[R:%.*]] = shufflevector <8 x float> [[Y:%.*]], <8 x float> [[TMP1]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 13, i32 6, i32 7>
; AVX-NEXT:    ret <8 x float> [[R]]
;
  %e = extractelement <8 x float> %x, i32 5
  call void @use(float %e)
  %n = fneg float %e
  %r = insertelement <8 x float> %y, float %n, i32 5
  ret <8 x float> %r
}

; Negative test - the transform is likely not profitable if the fneg has another use.

define <8 x float> @ext7_v8f32_use2(<8 x float> %x, <8 x float> %y) {
; CHECK-LABEL: @ext7_v8f32_use2(
; CHECK-NEXT:    [[E:%.*]] = extractelement <8 x float> [[X:%.*]], i32 3
; CHECK-NEXT:    [[N:%.*]] = fneg float [[E]]
; CHECK-NEXT:    call void @use(float [[N]])
; CHECK-NEXT:    [[R:%.*]] = insertelement <8 x float> [[Y:%.*]], float [[N]], i32 3
; CHECK-NEXT:    ret <8 x float> [[R]]
;
  %e = extractelement <8 x float> %x, i32 3
  %n = fneg float %e
  call void @use(float %n)
  %r = insertelement <8 x float> %y, float %n, i32 3
  ret <8 x float> %r
}

; Negative test - can't convert variable index to a shuffle.

define <2 x double> @ext_index_var_v2f64(<2 x double> %x, <2 x double> %y, i32 %index) {
; CHECK-LABEL: @ext_index_var_v2f64(
; CHECK-NEXT:    [[E:%.*]] = extractelement <2 x double> [[X:%.*]], i32 [[INDEX:%.*]]
; CHECK-NEXT:    [[N:%.*]] = fneg nsz double [[E]]
; CHECK-NEXT:    [[R:%.*]] = insertelement <2 x double> [[Y:%.*]], double [[N]], i32 [[INDEX]]
; CHECK-NEXT:    ret <2 x double> [[R]]
;
  %e = extractelement <2 x double> %x, i32 %index
  %n = fneg nsz double %e
  %r = insertelement <2 x double> %y, double %n, i32 %index
  ret <2 x double> %r
}

; Negative test - require same extract/insert index for simple shuffle.
; TODO: We could handle this by adjusting the cost calculation.

define <2 x double> @ext1_v2f64_ins0(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext1_v2f64_ins0(
; CHECK-NEXT:    [[E:%.*]] = extractelement <2 x double> [[X:%.*]], i32 1
; CHECK-NEXT:    [[N:%.*]] = fneg nsz double [[E]]
; CHECK-NEXT:    [[R:%.*]] = insertelement <2 x double> [[Y:%.*]], double [[N]], i32 0
; CHECK-NEXT:    ret <2 x double> [[R]]
;
  %e = extractelement <2 x double> %x, i32 1
  %n = fneg nsz double %e
  %r = insertelement <2 x double> %y, double %n, i32 0
  ret <2 x double> %r
}

; Negative test - avoid changing poison ops

define <4 x float> @ext12_v4f32(<4 x float> %x, <4 x float> %y) {
; CHECK-LABEL: @ext12_v4f32(
; CHECK-NEXT:    [[E:%.*]] = extractelement <4 x float> [[X:%.*]], i32 12
; CHECK-NEXT:    [[N:%.*]] = fneg float [[E]]
; CHECK-NEXT:    [[R:%.*]] = insertelement <4 x float> [[Y:%.*]], float [[N]], i32 12
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %e = extractelement <4 x float> %x, i32 12
  %n = fneg float %e
  %r = insertelement <4 x float> %y, float %n, i32 12
  ret <4 x float> %r
}

; This used to crash because we assumed matching a true, unary fneg instruction.

define <2 x float> @ext1_v2f32_fsub(<2 x float> %x) {
; CHECK-LABEL: @ext1_v2f32_fsub(
; CHECK-NEXT:    [[TMP1:%.*]] = fneg <2 x float> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <2 x float> [[X]], <2 x float> [[TMP1]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %e = extractelement <2 x float> %x, i32 1
  %s = fsub float -0.0, %e
  %r = insertelement <2 x float> %x, float %s, i32 1
  ret <2 x float> %r
}

; This used to crash because we assumed matching a true, unary fneg instruction.

define <2 x float> @ext1_v2f32_fsub_fmf(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @ext1_v2f32_fsub_fmf(
; CHECK-NEXT:    [[TMP1:%.*]] = fneg nnan nsz <2 x float> [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = shufflevector <2 x float> [[Y:%.*]], <2 x float> [[TMP1]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %e = extractelement <2 x float> %x, i32 1
  %s = fsub nsz nnan float 0.0, %e
  %r = insertelement <2 x float> %y, float %s, i32 1
  ret <2 x float> %r
}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown %s | FileCheck %s

define i32 @test(ptr %isec, float %0) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x float>, ptr [[ISEC:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x float> <float 0.000000e+00, float poison>, float [[TMP0:%.*]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = fmul fast <2 x float> [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[CMP61:%.*]] = fcmp fast oge float 0.000000e+00, 0.000000e+00
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x float> [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <2 x float> [[TMP3]], i32 1
; CHECK-NEXT:    [[CMP63:%.*]] = fcmp fast ogt float [[TMP4]], [[TMP5]]
; CHECK-NEXT:    br i1 [[CMP63]], label [[CLEANUP:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    ret i32 0
;
entry:
  %1 = load float, ptr %isec, align 4
  %arrayidx10 = getelementptr inbounds float, ptr %isec, i64 1
  %2 = load float, ptr %arrayidx10, align 4
  %mul16 = fmul fast float %0, %2
  %mul55 = fmul fast float 0.000000e+00, %1
  %cmp61 = fcmp fast oge float 0.000000e+00, 0.000000e+00
  %cmp63 = fcmp fast ogt float %mul55, %mul16
  br i1 %cmp63, label %cleanup, label %if.end

if.end:
  br label %cleanup

cleanup:
  ret i32 0
}

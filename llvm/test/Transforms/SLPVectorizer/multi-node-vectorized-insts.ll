; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: %if x86-registered-target %{ opt -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -passes=slp-vectorizer -S -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s %}

define void @test(double %0) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: double [[TMP0:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x double> poison, double [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    br label [[TMP4:%.*]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = fsub <2 x double> zeroinitializer, [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = fsub <2 x double> zeroinitializer, [[TMP3]]
; CHECK-NEXT:    br label [[DOTBACKEDGE:%.*]]
; CHECK:       .backedge:
; CHECK-NEXT:    [[TMP7:%.*]] = fmul <2 x double> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = fcmp olt <2 x double> [[TMP7]], zeroinitializer
; CHECK-NEXT:    br label [[TMP4]]
;
  br label %2

2:
  %3 = fsub double 0.000000e+00, %0
  %4 = fsub double 0.000000e+00, %0
  %5 = fsub double 0.000000e+00, %0
  br label %.backedge

.backedge:
  %6 = fmul double %4, %5
  %7 = fcmp olt double %6, 0.000000e+00
  %8 = fmul double %5, %3
  %9 = fcmp olt double %8, 0.000000e+00
  br label %2
}

define void @test1(double %0, <4 x double> %v) {
; CHECK-LABEL: define void @test1(
; CHECK-SAME: double [[TMP0:%.*]], <4 x double> [[V:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x double> [[V]], <4 x double> poison, <2 x i32> <i32 poison, i32 0>
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x double> [[TMP2]], double [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x double> [[TMP3]], <2 x double> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 0>
; CHECK-NEXT:    br label [[TMP5:%.*]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = fsub <4 x double> <double 1.000000e+00, double 2.000000e+00, double 3.000000e+00, double 4.000000e+00>, [[V]]
; CHECK-NEXT:    [[TMP7:%.*]] = fsub <4 x double> <double 0.000000e+00, double 1.000000e+00, double 0.000000e+00, double 0.000000e+00>, [[TMP4]]
; CHECK-NEXT:    br label [[DOTBACKEDGE:%.*]]
; CHECK:       .backedge:
; CHECK-NEXT:    [[TMP8:%.*]] = fmul <4 x double> [[TMP7]], [[TMP6]]
; CHECK-NEXT:    [[TMP9:%.*]] = fcmp olt <4 x double> [[TMP8]], zeroinitializer
; CHECK-NEXT:    br label [[TMP5]]
;
  %e0 = extractelement <4 x double> %v, i32 0
  %e1 = extractelement <4 x double> %v, i32 1
  %e2 = extractelement <4 x double> %v, i32 2
  %e3 = extractelement <4 x double> %v, i32 3
  br label %2

2:
  %m1 = fsub double 1.000000e+00, %e0
  %m2 = fsub double 2.000000e+00, %e1
  %m3 = fsub double 3.000000e+00, %e2
  %m4 = fsub double 4.000000e+00, %e3
  %3 = fsub double 0.000000e+00, %0
  %4 = fsub double 0.000000e+00, %0
  %5 = fsub double 0.000000e+00, %0
  br label %.backedge

.backedge:
  %6 = fmul double %m1, %m2
  %7 = fcmp olt double %6, 0.000000e+00
  %8 = fmul double %3, %m1
  %9 = fcmp olt double %8, 0.000000e+00
  %10 = fmul double %4, %m3
  %11 = fcmp olt double %10, 0.000000e+00
  %12 = fmul double %5, %m4
  %13 = fcmp olt double %12, 0.000000e+00
  br label %2
}

define void @test2(double %0) {
; CHECK-LABEL: define void @test2(
; CHECK-SAME: double [[TMP0:%.*]]) {
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x double> poison, double [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    br label [[TMP4:%.*]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = fsub <2 x double> <double 3.000000e+00, double 2.000000e+00>, [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = fsub <2 x double> <double 3.000000e+00, double 1.000000e+00>, [[TMP3]]
; CHECK-NEXT:    br label [[DOTBACKEDGE:%.*]]
; CHECK:       .backedge:
; CHECK-NEXT:    [[TMP7:%.*]] = fmul <2 x double> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = fcmp olt <2 x double> [[TMP7]], zeroinitializer
; CHECK-NEXT:    br label [[TMP4]]
;
  br label %2

2:
  %3 = fsub double 1.000000e+00, %0
  %4 = fsub double 2.000000e+00, %0
  %5 = fsub double 3.000000e+00, %0
  br label %.backedge

.backedge:
  %6 = fmul double %4, %3
  %7 = fcmp olt double %6, 0.000000e+00
  %8 = fmul double %5, %5
  %9 = fcmp olt double %8, 0.000000e+00
  br label %2
}


; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: %if x86-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s %}

define void @test(ptr %block, ptr noalias %pixels, i1 %b) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr [[BLOCK:%.*]], ptr noalias [[PIXELS:%.*]], i1 [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x i1> <i1 true, i1 poison, i1 false, i1 false>, i1 [[B]], i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = sext <4 x i1> [[TMP0]] to <4 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i16>, ptr [[BLOCK]], align 2
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult <4 x i16> [[TMP2]], zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = trunc <4 x i16> [[TMP2]] to <4 x i8>
; CHECK-NEXT:    [[TMP5:%.*]] = select <4 x i1> [[TMP3]], <4 x i8> [[TMP4]], <4 x i8> [[TMP1]]
; CHECK-NEXT:    store <4 x i8> [[TMP5]], ptr [[PIXELS]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i16, ptr %block, align 2
  %tobool.not.i78 = icmp ult i16 %0, 0
  %conv.i80 = sext i1 true to i8
  %conv1.i81 = trunc i16 %0 to i8
  %retval.0.i82 = select i1 %tobool.not.i78, i8 %conv1.i81, i8 %conv.i80
  store i8 %retval.0.i82, ptr %pixels, align 1
  %arrayidx2 = getelementptr i8, ptr %block, i64 2
  %1 = load i16, ptr %arrayidx2, align 2
  %tobool.not.i73 = icmp ult i16 %1, 0
  %conv.i75 = sext i1 %b to i8
  %conv1.i76 = trunc i16 %1 to i8
  %retval.0.i77 = select i1 %tobool.not.i73, i8 %conv1.i76, i8 %conv.i75
  %arrayidx5 = getelementptr i8, ptr %pixels, i64 1
  store i8 %retval.0.i77, ptr %arrayidx5, align 1
  %arrayidx6 = getelementptr i8, ptr %block, i64 4
  %2 = load i16, ptr %arrayidx6, align 2
  %tobool.not.i68 = icmp ult i16 %2, 0
  %conv.i70 = sext i1 false to i8
  %conv1.i71 = trunc i16 %2 to i8
  %retval.0.i72 = select i1 %tobool.not.i68, i8 %conv1.i71, i8 %conv.i70
  %arrayidx9 = getelementptr i8, ptr %pixels, i64 2
  store i8 %retval.0.i72, ptr %arrayidx9, align 1
  %arrayidx10 = getelementptr i8, ptr %block, i64 6
  %3 = load i16, ptr %arrayidx10, align 2
  %tobool.not.i63 = icmp ult i16 %3, 0
  %conv.i65 = sext i1 false to i8
  %conv1.i66 = trunc i16 %3 to i8
  %retval.0.i67 = select i1 %tobool.not.i63, i8 %conv1.i66, i8 %conv.i65
  %arrayidx13 = getelementptr i8, ptr %pixels, i64 3
  store i8 %retval.0.i67, ptr %arrayidx13, align 1
  ret void
}

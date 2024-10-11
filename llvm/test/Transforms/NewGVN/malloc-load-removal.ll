; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=newgvn < %s | FileCheck %s
; PR13694

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"

declare ptr @malloc(i64) nounwind allockind("alloc,uninitialized") allocsize(0) "alloc-family"="malloc"

define noalias ptr @test1() nounwind uwtable ssp {
; CHECK-LABEL: define noalias ptr @test1(
; CHECK-SAME: ) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @malloc(i64 100) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    br i1 undef, label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i8 0, ptr [[CALL]], align 1
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = tail call ptr @malloc(i64 100) nounwind
  %0 = load i8, ptr %call, align 1
  %tobool = icmp eq i8 %0, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i8 0, ptr %call, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr %call

}

declare ptr @_Znwm(i64) nounwind

define noalias ptr @test2() nounwind uwtable ssp {
; CHECK-LABEL: define noalias ptr @test2(
; CHECK-SAME: ) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @_Znwm(i64 100) #[[ATTR2]]
; CHECK-NEXT:    br i1 undef, label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i8 0, ptr [[CALL]], align 1
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = tail call ptr @_Znwm(i64 100) nounwind
  %0 = load i8, ptr %call, align 1
  %tobool = icmp eq i8 %0, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i8 0, ptr %call, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr %call

}

declare ptr @aligned_alloc(i64 allocalign, i64) nounwind allockind("alloc,uninitialized,aligned") allocsize(1) "alloc-family"="malloc"

define noalias ptr @test3() nounwind uwtable ssp {
; CHECK-LABEL: define noalias ptr @test3(
; CHECK-SAME: ) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @aligned_alloc(i64 256, i64 32) #[[ATTR2]]
; CHECK-NEXT:    br i1 undef, label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i8 0, ptr [[CALL]], align 1
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = tail call ptr @aligned_alloc(i64 256, i64 32) nounwind
  %0 = load i8, ptr %call, align 32
  %tobool = icmp eq i8 %0, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i8 0, ptr %call, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr %call

}

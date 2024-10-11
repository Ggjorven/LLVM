; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s
;
; rdar:13349374
;
; SimplifyCFG should not eliminate blocks with volatile stores.
; Essentially, volatile needs to be backdoor that tells the optimizer
; it can no longer use language standard as an excuse. The compiler
; needs to expose the volatile access to the platform.

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

define void @test(ptr nocapture %PeiServices) #0 {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call i32 (...) @Trace() #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[CALL]], 0
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[WHILE_BODY:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CALL1:%.*]] = tail call i32 (...) @Trace() #[[ATTR2]]
; CHECK-NEXT:    br label [[WHILE_BODY]]
; CHECK:       while.body:
; CHECK-NEXT:    [[ADDR_017:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[WHILE_BODY]] ], [ null, [[IF_THEN]] ], [ null, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[X_016:%.*]] = phi i8 [ [[INC:%.*]], [[WHILE_BODY]] ], [ 0, [[IF_THEN]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    [[INC]] = add i8 [[X_016]], 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i8, ptr [[ADDR_017]], i64 1
; CHECK-NEXT:    store volatile i8 [[X_016]], ptr [[ADDR_017]], align 1
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[INCDEC_PTR]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[TMP1]], 4096
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  %call = tail call i32 (...) @Trace() #2
  %tobool = icmp eq i32 %call, 0
  br i1 %tobool, label %while.body, label %if.then

if.then:                                          ; preds = %entry
  %call1 = tail call i32 (...) @Trace() #2
  br label %while.body

while.body:                                       ; preds = %entry, %if.then, %while.body
  %Addr.017 = phi ptr [ %incdec.ptr, %while.body ], [ null, %if.then ], [ null, %entry ]
  %x.016 = phi i8 [ %inc, %while.body ], [ 0, %if.then ], [ 0, %entry ]
  %inc = add i8 %x.016, 1
  %incdec.ptr = getelementptr inbounds i8, ptr %Addr.017, i64 1
  store volatile i8 %x.016, ptr %Addr.017, align 1
  %0 = ptrtoint ptr %incdec.ptr to i64
  %1 = trunc i64 %0 to i32
  %cmp = icmp ult i32 %1, 4096
  br i1 %cmp, label %while.body, label %end

end:
  ret void
}
declare i32 @Trace(...) #1

attributes #0 = { nounwind ssp uwtable "fp-contract-model"="standard" "frame-pointer"="non-leaf" "relocation-model"="pic" "ssp-buffers-size"="8" }
attributes #1 = { "fp-contract-model"="standard" "frame-pointer"="non-leaf" "relocation-model"="pic" "ssp-buffers-size"="8" }
attributes #2 = { nounwind }

!0 = !{i32 1039}

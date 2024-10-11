; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

@.str = private unnamed_addr constant [3 x i8] c"12\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"4294967296\00", align 1
@.str.3 = private unnamed_addr constant [24 x i8] c"10000000000000000000000\00", align 1
@.str.4 = private unnamed_addr constant [20 x i8] c"9923372036854775807\00", align 1
@.str.5 = private unnamed_addr constant [11 x i8] c"4994967295\00", align 1
@.str.6 = private unnamed_addr constant [10 x i8] c"499496729\00", align 1
@.str.7 = private unnamed_addr constant [11 x i8] c"4994967295\00", align 1

declare i32 @strtol(ptr, ptr, i32)
declare i32 @atoi(ptr)
declare i32 @atol(ptr)
declare i64 @atoll(ptr)
declare i64 @strtoll(ptr, ptr, i32)

define i32 @strtol_dec() #0 {
; CHECK-LABEL: @strtol_dec(
; CHECK-NEXT:    ret i32 12
;
  %call = call i32 @strtol(ptr @.str, ptr null, i32 10) #2
  ret i32 %call
}

define i32 @strtol_base_zero() #0 {
; CHECK-LABEL: @strtol_base_zero(
; CHECK-NEXT:    ret i32 12
;
  %call = call i32 @strtol(ptr @.str, ptr null, i32 0) #2
  ret i32 %call
}

define i32 @strtol_hex() #0 {
; CHECK-LABEL: @strtol_hex(
; CHECK-NEXT:    ret i32 18
;
  %call = call i32 @strtol(ptr @.str, ptr null, i32 16) #2
  ret i32 %call
}

; Fold a call to strtol with an endptr known to be nonnull (the result
; of pointer increment).

define i32 @strtol_endptr_not_null(ptr %pend) {
; CHECK-LABEL: @strtol_endptr_not_null(
; CHECK-NEXT:    [[ENDP1:%.*]] = getelementptr inbounds i8, ptr [[PEND:%.*]], i64 8
; CHECK-NEXT:    store ptr getelementptr inbounds (i8, ptr @.str, i64 2), ptr [[ENDP1]], align 8
; CHECK-NEXT:    ret i32 12
;
  %endp1 = getelementptr inbounds ptr, ptr %pend, i32 1
  %call = call i32 @strtol(ptr @.str, ptr %endp1, i32 10)
  ret i32 %call
}

; Don't fold a call to strtol with an endptr that's not known to be nonnull.

define i32 @strtol_endptr_maybe_null(ptr %end) {
; CHECK-LABEL: @strtol_endptr_maybe_null(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @strtol(ptr nonnull @.str.1, ptr [[END:%.*]], i32 10)
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @strtol(ptr @.str.1, ptr %end, i32 10)
  ret i32 %call
}

define i32 @atoi_test() #0 {
; CHECK-LABEL: @atoi_test(
; CHECK-NEXT:    ret i32 12
;
  %call = call i32 @atoi(ptr @.str) #4
  ret i32 %call
}

define i32 @strtol_not_const_str(ptr %s) #0 {
; CHECK-LABEL: @strtol_not_const_str(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @strtol(ptr nocapture [[S:%.*]], ptr null, i32 10)
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @strtol(ptr %s, ptr null, i32 10) #3
  ret i32 %call
}

define i32 @atoi_not_const_str(ptr %s) #0 {
; CHECK-LABEL: @atoi_not_const_str(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @atoi(ptr nocapture [[S:%.*]])
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @atoi(ptr %s) #4
  ret i32 %call
}

define i32 @strtol_not_const_base(i32 %b) #0 {
; CHECK-LABEL: @strtol_not_const_base(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @strtol(ptr nocapture nonnull @.str, ptr null, i32 [[B:%.*]])
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @strtol(ptr @.str, ptr null, i32 %b) #2
  ret i32 %call
}

define i32 @strtol_long_int() #0 {
; CHECK-LABEL: @strtol_long_int(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @strtol(ptr nocapture nonnull @.str.2, ptr null, i32 10)
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @strtol(ptr @.str.2, ptr null, i32 10) #3
  ret i32 %call
}


define i32 @strtol_big_overflow() #0 {
; CHECK-LABEL: @strtol_big_overflow(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @strtol(ptr nocapture nonnull @.str.3, ptr null, i32 10)
; CHECK-NEXT:    ret i32 [[CALL]]
;
  %call = call i32 @strtol(ptr nocapture @.str.3, ptr null, i32 10) #2
  ret i32 %call
}

define i32 @atol_test() #0 {
; CHECK-LABEL: @atol_test(
; CHECK-NEXT:    ret i32 499496729
;
; CHECK-NEXT
  %call = call i32 @atol(ptr @.str.6) #4
  ret i32 %call
}

define i64 @atoll_test() #0 {
; CHECK-LABEL: @atoll_test(
; CHECK-NEXT:    ret i64 4994967295
;
  %call = call i64 @atoll(ptr @.str.5) #3
  ret i64 %call
}

define i64 @strtoll_test() #0 {
; CHECK-LABEL: @strtoll_test(
; CHECK-NEXT:    ret i64 4994967295
;
; CHECK-NEXT
  %call = call i64 @strtoll(ptr @.str.7, ptr null, i32 10) #5
  ret i64 %call
}

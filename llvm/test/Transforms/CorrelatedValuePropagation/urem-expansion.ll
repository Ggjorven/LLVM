; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=correlated-propagation -S | FileCheck %s

declare void @llvm.assume(i1)

; Divisor is constant. X's range is known

define i8 @constant.divisor.v3(i8 %x) {
; CHECK-LABEL: @constant.divisor.v3(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    ret i8 [[X]]
;
  %cmp.x.upper = icmp ult i8 %x, 3
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}
define i8 @constant.divisor.v4(i8 %x) {
; CHECK-LABEL: @constant.divisor.v4(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 4
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}
define i8 @constant.divisor.x.range.v4(ptr %x.ptr) {
; CHECK-LABEL: @constant.divisor.x.range.v4(
; CHECK-NEXT:    [[X:%.*]] = load i8, ptr [[X_PTR:%.*]], align 1, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %x = load i8, ptr %x.ptr, !range !{ i8 0, i8 4 }
  %rem = urem i8 %x, 3
  ret i8 %rem
}
define i8 @constant.divisor.x.mask.v4(i8 %x) {
; CHECK-LABEL: @constant.divisor.x.mask.v4(
; CHECK-NEXT:    [[X_MASKED:%.*]] = and i8 [[X:%.*]], 3
; CHECK-NEXT:    [[X_MASKED_FROZEN:%.*]] = freeze i8 [[X_MASKED]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_MASKED_FROZEN]], 3
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_MASKED_FROZEN]], 3
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_MASKED_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %x.masked = and i8 %x, 3
  %rem = urem i8 %x.masked, 3
  ret i8 %rem
}
define i8 @constant.divisor.v5(i8 %x) {
; CHECK-LABEL: @constant.divisor.v5(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 5
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 5
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}
define i8 @constant.divisor.v6(i8 %x) {
; CHECK-LABEL: @constant.divisor.v6(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], 3
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 6
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}
define i8 @constant.divisor.v7(i8 %x) {
; CHECK-LABEL: @constant.divisor.v7(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 7
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], 3
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 7
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}

define i8 @constant.divisor.v6to8(i8 %x) {
; CHECK-LABEL: @constant.divisor.v6to8(
; CHECK-NEXT:    [[CMP_X_LOWER:%.*]] = icmp uge i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_LOWER]])
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X]], 9
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], 3
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.lower = icmp uge i8 %x, 6
  call void @llvm.assume(i1 %cmp.x.lower)
  %cmp.x.upper = icmp ult i8 %x, 9
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}

define i8 @constant.divisor.v9to11(i8 %x) {
; CHECK-LABEL: @constant.divisor.v9to11(
; CHECK-NEXT:    [[CMP_X_LOWER:%.*]] = icmp uge i8 [[X:%.*]], 9
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_LOWER]])
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X]], 12
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], 3
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.lower = icmp uge i8 %x, 9
  call void @llvm.assume(i1 %cmp.x.lower)
  %cmp.x.upper = icmp ult i8 %x, 12
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}

define i8 @constant.divisor.v12to14(i8 %x) {
; CHECK-LABEL: @constant.divisor.v12to14(
; CHECK-NEXT:    [[CMP_X_LOWER:%.*]] = icmp uge i8 [[X:%.*]], 12
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_LOWER]])
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X]], 15
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], 3
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.lower = icmp uge i8 %x, 12
  call void @llvm.assume(i1 %cmp.x.lower)
  %cmp.x.upper = icmp ult i8 %x, 15
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}

define i8 @constant.divisor.v6to11(i8 %x) {
; CHECK-LABEL: @constant.divisor.v6to11(
; CHECK-NEXT:    [[CMP_X_LOWER:%.*]] = icmp uge i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_LOWER]])
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X]], 12
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], 3
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.lower = icmp uge i8 %x, 6
  call void @llvm.assume(i1 %cmp.x.lower)
  %cmp.x.upper = icmp ult i8 %x, 12
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  ret i8 %rem
}

; Both are variable. Bounds are known

define i8 @variable.v3(i8 %x, i8 %y) {
; CHECK-LABEL: @variable.v3(
; CHECK-NEXT:    [[CMP_X:%.*]] = icmp ult i8 [[X:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X]])
; CHECK-NEXT:    [[CMP_Y_LOWER:%.*]] = icmp uge i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_LOWER]])
; CHECK-NEXT:    [[CMP_Y_UPPER:%.*]] = icmp ule i8 [[Y]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_UPPER]])
; CHECK-NEXT:    ret i8 [[X]]
;
  %cmp.x = icmp ult i8 %x, 3
  call void @llvm.assume(i1 %cmp.x)
  %cmp.y.lower = icmp uge i8 %y, 3
  call void @llvm.assume(i1 %cmp.y.lower)
  %cmp.y.upper = icmp ule i8 %y, 4
  call void @llvm.assume(i1 %cmp.y.upper)
  %rem = urem i8 %x, %y
  ret i8 %rem
}
define i8 @variable.v4(i8 %x, i8 %y) {
; CHECK-LABEL: @variable.v4(
; CHECK-NEXT:    [[CMP_X:%.*]] = icmp ult i8 [[X:%.*]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X]])
; CHECK-NEXT:    [[CMP_Y_LOWER:%.*]] = icmp uge i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_LOWER]])
; CHECK-NEXT:    [[CMP_Y_UPPER:%.*]] = icmp ule i8 [[Y]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[Y_FROZEN:%.*]] = freeze i8 [[Y]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x = icmp ult i8 %x, 4
  call void @llvm.assume(i1 %cmp.x)
  %cmp.y.lower = icmp uge i8 %y, 3
  call void @llvm.assume(i1 %cmp.y.lower)
  %cmp.y.upper = icmp ule i8 %y, 4
  call void @llvm.assume(i1 %cmp.y.upper)
  %rem = urem i8 %x, %y
  ret i8 %rem
}
define i8 @variable.v4.range(ptr %x.ptr, ptr %y.ptr) {
; CHECK-LABEL: @variable.v4.range(
; CHECK-NEXT:    [[X:%.*]] = load i8, ptr [[X_PTR:%.*]], align 1, !range [[RNG0]]
; CHECK-NEXT:    [[Y:%.*]] = load i8, ptr [[Y_PTR:%.*]], align 1, !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[Y_FROZEN:%.*]] = freeze i8 [[Y]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %x = load i8, ptr %x.ptr, !range !{ i8 0, i8 4 }
  %y = load i8, ptr %y.ptr, !range !{ i8 3, i8 5 }
  %rem = urem i8 %x, %y
  ret i8 %rem
}
define i8 @variable.v5(i8 %x, i8 %y) {
; CHECK-LABEL: @variable.v5(
; CHECK-NEXT:    [[CMP_X:%.*]] = icmp ult i8 [[X:%.*]], 5
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X]])
; CHECK-NEXT:    [[CMP_Y_LOWER:%.*]] = icmp uge i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_LOWER]])
; CHECK-NEXT:    [[CMP_Y_UPPER:%.*]] = icmp ule i8 [[Y]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[Y_FROZEN:%.*]] = freeze i8 [[Y]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x = icmp ult i8 %x, 5
  call void @llvm.assume(i1 %cmp.x)
  %cmp.y.lower = icmp uge i8 %y, 3
  call void @llvm.assume(i1 %cmp.y.lower)
  %cmp.y.upper = icmp ule i8 %y, 4
  call void @llvm.assume(i1 %cmp.y.upper)
  %rem = urem i8 %x, %y
  ret i8 %rem
}
define i8 @variable.v6(i8 %x, i8 %y) {
; CHECK-LABEL: @variable.v6(
; CHECK-NEXT:    [[CMP_X:%.*]] = icmp ult i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X]])
; CHECK-NEXT:    [[CMP_Y_LOWER:%.*]] = icmp uge i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_LOWER]])
; CHECK-NEXT:    [[CMP_Y_UPPER:%.*]] = icmp ule i8 [[Y]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[Y_FROZEN:%.*]] = freeze i8 [[Y]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], [[Y_FROZEN]]
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x = icmp ult i8 %x, 6
  call void @llvm.assume(i1 %cmp.x)
  %cmp.y.lower = icmp uge i8 %y, 3
  call void @llvm.assume(i1 %cmp.y.lower)
  %cmp.y.upper = icmp ule i8 %y, 4
  call void @llvm.assume(i1 %cmp.y.upper)
  %rem = urem i8 %x, %y
  ret i8 %rem
}
define i8 @variable.v7(i8 %x, i8 %y) {
; CHECK-LABEL: @variable.v7(
; CHECK-NEXT:    [[CMP_X:%.*]] = icmp ult i8 [[X:%.*]], 7
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X]])
; CHECK-NEXT:    [[CMP_Y_LOWER:%.*]] = icmp uge i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_LOWER]])
; CHECK-NEXT:    [[CMP_Y_UPPER:%.*]] = icmp ule i8 [[Y]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], [[Y]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x = icmp ult i8 %x, 7
  call void @llvm.assume(i1 %cmp.x)
  %cmp.y.lower = icmp uge i8 %y, 3
  call void @llvm.assume(i1 %cmp.y.lower)
  %cmp.y.upper = icmp ule i8 %y, 4
  call void @llvm.assume(i1 %cmp.y.upper)
  %rem = urem i8 %x, %y
  ret i8 %rem
}

define i8 @variable.v6to8.v3to4(i8 %x, i8 %y) {
; CHECK-LABEL: @variable.v6to8.v3to4(
; CHECK-NEXT:    [[CMP_X_LOWER:%.*]] = icmp uge i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_LOWER]])
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X]], 8
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[CMP_Y_LOWER:%.*]] = icmp uge i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_LOWER]])
; CHECK-NEXT:    [[CMP_Y_UPPER:%.*]] = icmp ule i8 [[Y]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_Y_UPPER]])
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X]], [[Y]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.lower = icmp uge i8 %x, 6
  call void @llvm.assume(i1 %cmp.x.lower)
  %cmp.x.upper = icmp ult i8 %x, 8
  call void @llvm.assume(i1 %cmp.x.upper)
  %cmp.y.lower = icmp uge i8 %y, 3
  call void @llvm.assume(i1 %cmp.y.lower)
  %cmp.y.upper = icmp ule i8 %y, 4
  call void @llvm.assume(i1 %cmp.y.upper)
  %rem = urem i8 %x, %y
  ret i8 %rem
}

; Constant divisor

define i8 @large.divisor.v0(i8 %x) {
; CHECK-LABEL: @large.divisor.v0(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 127
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    ret i8 [[X]]
;
  %cmp.x.upper = icmp ult i8 %x, 127
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 127
  ret i8 %rem
}
define i8 @large.divisor.v1(i8 %x) {
; CHECK-LABEL: @large.divisor.v1(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], -128
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], 127
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], 127
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 128
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 127
  ret i8 %rem
}
define i8 @large.divisor.v1.range(ptr %x.ptr) {
; CHECK-LABEL: @large.divisor.v1.range(
; CHECK-NEXT:    [[X:%.*]] = load i8, ptr [[X_PTR:%.*]], align 1, !range [[RNG2:![0-9]+]]
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], 127
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], 127
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %x = load i8, ptr %x.ptr, !range !{ i8 0, i8 128 }
  %rem = urem i8 %x, 127
  ret i8 %rem
}
define i8 @large.divisor.v2.unbound.x(i8 %x) {
; CHECK-LABEL: @large.divisor.v2.unbound.x(
; CHECK-NEXT:    [[REM:%.*]] = urem i8 [[X:%.*]], 127
; CHECK-NEXT:    ret i8 [[REM]]
;
  %rem = urem i8 %x, 127
  ret i8 %rem
}

define i8 @large.divisor.with.overflow.v0(i8 %x) {
; CHECK-LABEL: @large.divisor.with.overflow.v0(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], -128
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    ret i8 [[X]]
;
  %cmp.x.upper = icmp ult i8 %x, 128
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 128
  ret i8 %rem
}
define i8 @large.divisor.with.overflow.v1(i8 %x) {
; CHECK-LABEL: @large.divisor.with.overflow.v1(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], -127
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], -128
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], -128
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 129
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 128
  ret i8 %rem
}
define i8 @large.divisor.with.overflow.v1.range(ptr %x.ptr) {
; CHECK-LABEL: @large.divisor.with.overflow.v1.range(
; CHECK-NEXT:    [[X:%.*]] = load i8, ptr [[X_PTR:%.*]], align 1, !range [[RNG3:![0-9]+]]
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], -128
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], -128
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %x = load i8, ptr %x.ptr, !range !{ i8 0, i8 129 }
  %rem = urem i8 %x, 128
  ret i8 %rem
}
define i8 @large.divisor.with.overflow.v2.unbound.x(i8 %x) {
; CHECK-LABEL: @large.divisor.with.overflow.v2.unbound.x(
; CHECK-NEXT:    [[X_FROZEN:%.*]] = freeze i8 [[X:%.*]]
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X_FROZEN]], -128
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X_FROZEN]], -128
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X_FROZEN]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i8 [[REM]]
;
  %rem = urem i8 %x, 128
  ret i8 %rem
}

define i1 @icmp_after_expansion(i8 noundef %x) {
; CHECK-LABEL: @icmp_after_expansion(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[REM_UREM:%.*]] = sub nuw i8 [[X]], 3
; CHECK-NEXT:    [[REM_CMP:%.*]] = icmp ult i8 [[X]], 3
; CHECK-NEXT:    [[REM:%.*]] = select i1 [[REM_CMP]], i8 [[X]], i8 [[REM_UREM]]
; CHECK-NEXT:    ret i1 false
;
  %cmp.x.upper = icmp ult i8 %x, 6
  call void @llvm.assume(i1 %cmp.x.upper)
  %rem = urem i8 %x, 3
  %cmp = icmp eq i8 %rem, 3
  ret i1 %cmp
}

define i8 @known_uge(i8 noundef %x) {
; CHECK-LABEL: @known_uge(
; CHECK-NEXT:    [[CMP_X_UPPER:%.*]] = icmp ult i8 [[X:%.*]], 6
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_UPPER]])
; CHECK-NEXT:    [[CMP_X_LOWER:%.*]] = icmp uge i8 [[X]], 3
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP_X_LOWER]])
; CHECK-NEXT:    [[REM:%.*]] = sub nuw i8 [[X]], 3
; CHECK-NEXT:    ret i8 [[REM]]
;
  %cmp.x.upper = icmp ult i8 %x, 6
  call void @llvm.assume(i1 %cmp.x.upper)
  %cmp.x.lower = icmp uge i8 %x, 3
  call void @llvm.assume(i1 %cmp.x.lower)
  %rem = urem i8 %x, 3
  ret i8 %rem
}

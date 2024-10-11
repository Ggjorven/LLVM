; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=aggressive-instcombine < %s | FileCheck %s

; check whether we generate the right IR

declare i32 @strncmp(ptr nocapture, ptr nocapture, i64)
declare i32 @strcmp(ptr nocapture, ptr nocapture)

@s2 = constant [2 x i8] c"a\00"
@s3 = constant [3 x i8] c"ab\00"
@s3ff = constant [3 x i8] c"\FE\FF\00"

define i1 @test_strncmp_1(ptr %s) {
; CHECK-LABEL: define i1 @test_strncmp_1(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 97, [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = sub i32 98, [[TMP6]]
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP8:%.*]] = phi i32 [ [[TMP2]], [[SUB]] ], [ [[TMP7]], [[SUB1]] ]
; CHECK-NEXT:    br label [[ENTRY:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP8]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strncmp(ptr nonnull dereferenceable(3) @s3, ptr nonnull dereferenceable(1) %s, i64 2)
  %cmp = icmp eq i32 %call, 0
  ret i1 %cmp
}

define i1 @test_strncmp_2(ptr %s) {
; CHECK-LABEL: define i1 @test_strncmp_2(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 97, [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = sub i32 98, [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-NEXT:    br i1 [[TMP8]], label [[NE]], label [[SUB2:%.*]]
; CHECK:       sub_2:
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 2
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, ptr [[TMP9]], align 1
; CHECK-NEXT:    [[TMP11:%.*]] = zext i8 [[TMP10]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = sub i32 0, [[TMP11]]
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i32 [ [[TMP2]], [[SUB]] ], [ [[TMP7]], [[SUB1]] ], [ [[TMP12]], [[SUB2]] ]
; CHECK-NEXT:    br label [[ENTRY:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[TMP13]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strncmp(ptr nonnull dereferenceable(3) @s3, ptr nonnull dereferenceable(1) %s, i64 3)
  %cmp = icmp slt i32 %call, 0
  ret i1 %cmp
}

define i1 @test_strncmp_3(ptr %s) {
; CHECK-LABEL: define i1 @test_strncmp_3(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 97, [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = sub i32 98, [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-NEXT:    br i1 [[TMP8]], label [[NE]], label [[SUB2:%.*]]
; CHECK:       sub_2:
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 2
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, ptr [[TMP9]], align 1
; CHECK-NEXT:    [[TMP11:%.*]] = zext i8 [[TMP10]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = sub i32 0, [[TMP11]]
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i32 [ [[TMP2]], [[SUB]] ], [ [[TMP7]], [[SUB1]] ], [ [[TMP12]], [[SUB2]] ]
; CHECK-NEXT:    br label [[ENTRY:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP13]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strncmp(ptr nonnull dereferenceable(3) @s3, ptr nonnull dereferenceable(1) %s, i64 4)
  %cmp = icmp sgt i32 %call, 0
  ret i1 %cmp
}

define i1 @test_strcmp_1(ptr %s) {
; CHECK-LABEL: define i1 @test_strcmp_1(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 [[TMP1]], 97
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP7:%.*]] = phi i32 [ [[TMP2]], [[SUB]] ], [ [[TMP6]], [[SUB1]] ]
; CHECK-NEXT:    br label [[ENTRY:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strcmp(ptr nonnull dereferenceable(1) %s, ptr nonnull dereferenceable(2) @s2)
  %cmp = icmp ne i32 %call, 0
  ret i1 %cmp
}

define i1 @test_strcmp_2(ptr %s) {
; CHECK-LABEL: define i1 @test_strcmp_2(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 [[TMP1]], 97
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = sub i32 [[TMP6]], 98
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-NEXT:    br i1 [[TMP8]], label [[NE]], label [[SUB2:%.*]]
; CHECK:       sub_2:
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 2
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, ptr [[TMP9]], align 1
; CHECK-NEXT:    [[TMP11:%.*]] = zext i8 [[TMP10]] to i32
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP12:%.*]] = phi i32 [ [[TMP2]], [[SUB]] ], [ [[TMP7]], [[SUB1]] ], [ [[TMP11]], [[SUB2]] ]
; CHECK-NEXT:    br label [[ENTRY:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i32 [[TMP12]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strcmp(ptr nonnull dereferenceable(1) %s, ptr nonnull dereferenceable(3) @s3)
  %cmp = icmp sge i32 %call, 0
  ret i1 %cmp
}

define i1 @test_strcmp_3(ptr %s) {
; CHECK-LABEL: define i1 @test_strcmp_3(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 97, [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = sub i32 98, [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-NEXT:    br i1 [[TMP8]], label [[NE]], label [[SUB2:%.*]]
; CHECK:       sub_2:
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 2
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, ptr [[TMP9]], align 1
; CHECK-NEXT:    [[TMP11:%.*]] = zext i8 [[TMP10]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = sub i32 0, [[TMP11]]
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i32 [ [[TMP2]], [[SUB]] ], [ [[TMP7]], [[SUB1]] ], [ [[TMP12]], [[SUB2]] ]
; CHECK-NEXT:    br label [[ENTRY:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[TMP13]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strcmp(ptr nonnull dereferenceable(3) @s3, ptr nonnull dereferenceable(1) %s)
  %cmp = icmp sle i32 %call, 0
  ret i1 %cmp
}

define i1 @test_strcmp_4(ptr %s) {
; CHECK-LABEL: define i1 @test_strcmp_4(
; CHECK-SAME: ptr [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[SUB_0:%.*]]
; CHECK:       sub_0:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[S]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 254, [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[NE:%.*]], label [[SUB_1:%.*]]
; CHECK:       sub_1:
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = sub i32 255, [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ne i32 [[TMP7]], 0
; CHECK-NEXT:    br i1 [[TMP8]], label [[NE]], label [[SUB_2:%.*]]
; CHECK:       sub_2:
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[S]], i64 2
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, ptr [[TMP9]], align 1
; CHECK-NEXT:    [[TMP11:%.*]] = zext i8 [[TMP10]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = sub i32 0, [[TMP11]]
; CHECK-NEXT:    br label [[NE]]
; CHECK:       ne:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i32 [ [[TMP2]], [[SUB_0]] ], [ [[TMP7]], [[SUB_1]] ], [ [[TMP12]], [[SUB_2]] ]
; CHECK-NEXT:    br label [[ENTRY_TAIL:%.*]]
; CHECK:       entry.tail:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP13]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %call = tail call i32 @strcmp(ptr nonnull dereferenceable(3) @s3ff, ptr nonnull dereferenceable(1) %s)
  %cmp = icmp eq i32 %call, 0
  ret i1 %cmp
}

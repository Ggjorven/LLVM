; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define i1 @test() {
; CHECK-LABEL: define i1 @test() {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i64 0 to i32
; CHECK-NEXT:    [[CONV85_22_I333_I_I:%.*]] = or i32 0, [[TMP0]]
; CHECK-NEXT:    [[CMP3_I_22_I334_I_I:%.*]] = icmp ugt i32 [[CONV85_22_I333_I_I]], 0
; CHECK-NEXT:    [[SHL_I111_22_I335_I_I:%.*]] = select i1 [[CMP3_I_22_I334_I_I]], i32 0, i32 0
; CHECK-NEXT:    [[C22_I336_I_I:%.*]] = shl i32 [[CONV85_22_I333_I_I]], [[SHL_I111_22_I335_I_I]]
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 0 to i32
; CHECK-NEXT:    [[CONV85_23_I340_I_I:%.*]] = or i32 0, [[TMP1]]
; CHECK-NEXT:    [[CMP3_I_23_I341_I_I:%.*]] = icmp ugt i32 [[CONV85_23_I340_I_I]], 0
; CHECK-NEXT:    [[SHL_I111_23_I342_I_I:%.*]] = select i1 [[CMP3_I_23_I341_I_I]], i32 0, i32 0
; CHECK-NEXT:    [[C23_I343_I_I:%.*]] = shl i32 [[CONV85_23_I340_I_I]], [[SHL_I111_23_I342_I_I]]
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 0 to i32
; CHECK-NEXT:    [[CONV85_24_I347_I_I:%.*]] = or i32 0, [[TMP2]]
; CHECK-NEXT:    [[CMP3_I_24_I348_I_I:%.*]] = icmp ugt i32 [[CONV85_24_I347_I_I]], 0
; CHECK-NEXT:    [[SHL_I111_24_I349_I_I:%.*]] = select i1 [[CMP3_I_24_I348_I_I]], i32 0, i32 0
; CHECK-NEXT:    [[C24_I350_I_I:%.*]] = shl i32 [[CONV85_24_I347_I_I]], [[SHL_I111_24_I349_I_I]]
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i64 0 to i32
; CHECK-NEXT:    [[CONV85_25_I354_I_I:%.*]] = or i32 0, [[TMP3]]
; CHECK-NEXT:    [[CMP3_I_25_I355_I_I:%.*]] = icmp ugt i32 [[CONV85_25_I354_I_I]], 0
; CHECK-NEXT:    [[SHL_I111_25_I356_I_I:%.*]] = select i1 [[CMP3_I_25_I355_I_I]], i32 0, i32 0
; CHECK-NEXT:    [[C25_I357_I_I:%.*]] = shl i32 [[CONV85_25_I354_I_I]], [[SHL_I111_25_I356_I_I]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> zeroinitializer)
; CHECK-NEXT:    [[OP_RDX:%.*]] = and i32 [[TMP4]], [[C22_I336_I_I]]
; CHECK-NEXT:    [[OP_RDX1:%.*]] = and i32 [[C23_I343_I_I]], [[C24_I350_I_I]]
; CHECK-NEXT:    [[OP_RDX2:%.*]] = and i32 [[OP_RDX]], [[OP_RDX1]]
; CHECK-NEXT:    [[OP_RDX3:%.*]] = and i32 [[OP_RDX2]], [[C25_I357_I_I]]
; CHECK-NEXT:    [[CONV109_I_I:%.*]] = trunc i32 [[OP_RDX3]] to i8
; CHECK-NEXT:    [[CMP_I_I54_I:%.*]] = icmp eq i8 [[CONV109_I_I]], 0
; CHECK-NEXT:    ret i1 [[CMP_I_I54_I]]
;
entry:
  %c18.i308.i.i = shl i32 0, 0
  %c19.i315.i.i = shl i32 0, 0
  %and.19.i316.i.i = and i32 %c18.i308.i.i, %c19.i315.i.i
  %c20.i322.i.i = shl i32 0, 0
  %and.20.i323.i.i = and i32 %and.19.i316.i.i, %c20.i322.i.i
  %c21.i329.i.i = shl i32 0, 0
  %and.21.i330.i.i = and i32 %and.20.i323.i.i, %c21.i329.i.i
  %0 = trunc i64 0 to i32
  %conv85.22.i333.i.i = or i32 0, %0
  %cmp3.i.22.i334.i.i = icmp ugt i32 %conv85.22.i333.i.i, 0
  %shl.i111.22.i335.i.i = select i1 %cmp3.i.22.i334.i.i, i32 0, i32 0
  %c22.i336.i.i = shl i32 %conv85.22.i333.i.i, %shl.i111.22.i335.i.i
  %and.22.i337.i.i = and i32 %and.21.i330.i.i, %c22.i336.i.i
  %1 = trunc i64 0 to i32
  %conv85.23.i340.i.i = or i32 0, %1
  %cmp3.i.23.i341.i.i = icmp ugt i32 %conv85.23.i340.i.i, 0
  %shl.i111.23.i342.i.i = select i1 %cmp3.i.23.i341.i.i, i32 0, i32 0
  %c23.i343.i.i = shl i32 %conv85.23.i340.i.i, %shl.i111.23.i342.i.i
  %and.23.i344.i.i = and i32 %and.22.i337.i.i, %c23.i343.i.i
  %2 = trunc i64 0 to i32
  %conv85.24.i347.i.i = or i32 0, %2
  %cmp3.i.24.i348.i.i = icmp ugt i32 %conv85.24.i347.i.i, 0
  %shl.i111.24.i349.i.i = select i1 %cmp3.i.24.i348.i.i, i32 0, i32 0
  %c24.i350.i.i = shl i32 %conv85.24.i347.i.i, %shl.i111.24.i349.i.i
  %and.24.i351.i.i = and i32 %and.23.i344.i.i, %c24.i350.i.i
  %3 = trunc i64 0 to i32
  %conv85.25.i354.i.i = or i32 0, %3
  %cmp3.i.25.i355.i.i = icmp ugt i32 %conv85.25.i354.i.i, 0
  %shl.i111.25.i356.i.i = select i1 %cmp3.i.25.i355.i.i, i32 0, i32 0
  %c25.i357.i.i = shl i32 %conv85.25.i354.i.i, %shl.i111.25.i356.i.i
  %and.25.i358.i.i = and i32 %and.24.i351.i.i, %c25.i357.i.i
  %conv109.i.i = trunc i32 %and.25.i358.i.i to i8
  %cmp.i.i54.i = icmp eq i8 %conv109.i.i, 0
  ret i1 %cmp.i.i54.i
}

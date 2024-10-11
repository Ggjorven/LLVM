; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; REQUIRES: aarch64-registered-target

; RUN: opt < %s -passes=licm -S   | FileCheck %s

target triple = "aarch64"

define ptr @test1(i32 %j, ptr readonly %P, ptr readnone %Q) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp slt i32 0, [[J:%.*]]
; CHECK-NEXT:    br i1 [[CMP0]], label [[FOR_BODY_LR_PH:%.*]], label [[RETURN:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[P_ADDR:%.*]] = phi ptr [ [[P:%.*]], [[FOR_BODY_LR_PH]] ], [ [[ARRAYIDX0:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[I0:%.*]] = phi i32 [ 0, [[FOR_BODY_LR_PH]] ], [ [[I_ADD:%.*]], [[IF_END]] ]
; CHECK-NEXT:    [[I0_EXT:%.*]] = sext i32 [[I0]] to i64
; CHECK-NEXT:    [[ARRAYIDX0]] = getelementptr inbounds ptr, ptr [[P_ADDR]], i64 [[I0_EXT]]
; CHECK-NEXT:    [[L0:%.*]] = load ptr, ptr [[ARRAYIDX0]], align 8
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ugt ptr [[L0]], [[Q:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOPEXIT0:%.*]], label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds ptr, ptr [[ARRAYIDX0]], i64 1
; CHECK-NEXT:    [[L1:%.*]] = load ptr, ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    [[CMP4:%.*]] = icmp ugt ptr [[L1]], [[Q]]
; CHECK-NEXT:    [[I_ADD]] = add nsw i32 [[I0]], 2
; CHECK-NEXT:    br i1 [[CMP4]], label [[LOOPEXIT1:%.*]], label [[FOR_BODY]]
; CHECK:       loopexit0:
; CHECK-NEXT:    [[P1:%.*]] = phi ptr [ [[ARRAYIDX0]], [[FOR_BODY]] ]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       loopexit1:
; CHECK-NEXT:    [[ARRAYIDX0_LCSSA:%.*]] = phi ptr [ [[ARRAYIDX0]], [[IF_END]] ]
; CHECK-NEXT:    [[ARRAYIDX1_LE:%.*]] = getelementptr inbounds ptr, ptr [[ARRAYIDX0_LCSSA]], i64 1
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ [[P1]], [[LOOPEXIT0]] ], [ [[ARRAYIDX1_LE]], [[LOOPEXIT1]] ], [ null, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  %cmp0 = icmp slt i32 0, %j
  br i1 %cmp0, label %for.body.lr.ph, label %return

for.body.lr.ph:
  br label %for.body

for.body:
  %P.addr = phi ptr [ %P, %for.body.lr.ph ], [ %arrayidx0, %if.end  ]
  %i0 = phi i32 [ 0, %for.body.lr.ph ], [ %i.add, %if.end]

  %i0.ext = sext i32 %i0 to i64
  %arrayidx0 = getelementptr inbounds ptr, ptr %P.addr, i64 %i0.ext
  %l0 = load ptr, ptr %arrayidx0, align 8
  %cmp1 = icmp ugt ptr %l0, %Q
  br i1 %cmp1, label %loopexit0, label %if.end

if.end:                                           ; preds = %for.body
  %arrayidx1 = getelementptr inbounds ptr, ptr %arrayidx0, i64 1
  %l1 = load ptr, ptr %arrayidx1, align 8
  %cmp4 = icmp ugt ptr %l1, %Q
  %i.add = add nsw i32 %i0, 2
  br i1 %cmp4, label %loopexit1, label %for.body

loopexit0:
  %p1 = phi ptr [%arrayidx0, %for.body]
  br label %return

loopexit1:
  %p2 = phi ptr [%arrayidx1, %if.end]
  br label  %return

return:
  %retval.0 = phi ptr [ %p1, %loopexit0 ], [%p2, %loopexit1], [ null, %entry ]
  ret ptr %retval.0
}

define ptr @test2(i32 %j, ptr readonly %P, ptr readnone %Q) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[I_ADDR_0:%.*]] = phi i32 [ [[ADD_REASS:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[P_ADDR_0:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[IF_END]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I_ADDR_0]], [[J:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[LOOPEXIT0:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[P_ADDR:%.*]] = phi ptr [ [[P:%.*]], [[ENTRY:%.*]] ], [ [[P_ADDR_0]], [[FOR_COND:%.*]] ]
; CHECK-NEXT:    [[I_ADDR:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[I_ADDR_0]], [[FOR_COND]] ]
; CHECK-NEXT:    [[IDX_EXT:%.*]] = sext i32 [[I_ADDR]] to i64
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds ptr, ptr [[P_ADDR]], i64 [[IDX_EXT]]
; CHECK-NEXT:    [[L0:%.*]] = load ptr, ptr [[ADD_PTR]], align 8
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ugt ptr [[L0]], [[Q:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOPEXIT1:%.*]], label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ADD_I:%.*]] = add i32 [[I_ADDR]], 1
; CHECK-NEXT:    [[IDX2_EXT:%.*]] = sext i32 [[ADD_I]] to i64
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds ptr, ptr [[ADD_PTR]], i64 [[IDX2_EXT]]
; CHECK-NEXT:    [[L1:%.*]] = load ptr, ptr [[ARRAYIDX2]], align 8
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt ptr [[L1]], [[Q]]
; CHECK-NEXT:    [[ADD_REASS]] = add i32 [[I_ADDR]], 2
; CHECK-NEXT:    br i1 [[CMP2]], label [[LOOPEXIT2:%.*]], label [[FOR_COND]]
; CHECK:       loopexit0:
; CHECK-NEXT:    [[P0:%.*]] = phi ptr [ null, [[FOR_COND]] ]
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       loopexit1:
; CHECK-NEXT:    [[P1:%.*]] = phi ptr [ [[ADD_PTR]], [[FOR_BODY]] ]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       loopexit2:
; CHECK-NEXT:    [[IDX2_EXT_LCSSA:%.*]] = phi i64 [ [[IDX2_EXT]], [[IF_END]] ]
; CHECK-NEXT:    [[ADD_PTR_LCSSA:%.*]] = phi ptr [ [[ADD_PTR]], [[IF_END]] ]
; CHECK-NEXT:    [[ARRAYIDX2_LE:%.*]] = getelementptr inbounds ptr, ptr [[ADD_PTR_LCSSA]], i64 [[IDX2_EXT_LCSSA]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ [[P1]], [[LOOPEXIT1]] ], [ [[ARRAYIDX2_LE]], [[LOOPEXIT2]] ], [ [[P0]], [[LOOPEXIT0]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  br label %for.body

for.cond:
  %i.addr.0 = phi i32 [ %add, %if.end ]
  %P.addr.0 = phi ptr [ %add.ptr, %if.end ]
  %cmp = icmp slt i32 %i.addr.0, %j
  br i1 %cmp, label %for.body, label %loopexit0

for.body:
  %P.addr = phi ptr [ %P, %entry ], [ %P.addr.0, %for.cond ]
  %i.addr = phi i32 [ 0, %entry ], [ %i.addr.0, %for.cond ]

  %idx.ext = sext i32 %i.addr to i64
  %add.ptr = getelementptr inbounds ptr, ptr %P.addr, i64 %idx.ext
  %l0 = load ptr, ptr %add.ptr, align 8

  %cmp1 = icmp ugt ptr %l0, %Q
  br i1 %cmp1, label %loopexit1, label %if.end

if.end:
  %add.i = add i32 %i.addr, 1
  %idx2.ext = sext i32 %add.i to i64
  %arrayidx2 = getelementptr inbounds ptr, ptr %add.ptr, i64 %idx2.ext
  %l1 = load ptr, ptr %arrayidx2, align 8
  %cmp2 = icmp ugt ptr %l1, %Q
  %add = add nsw i32 %add.i, 1
  br i1 %cmp2, label %loopexit2, label %for.cond

loopexit0:
  %p0 = phi ptr [ null, %for.cond ]
  br label %return

loopexit1:
  %p1 = phi ptr [ %add.ptr, %for.body ]
  br label %return

loopexit2:
  %p2 = phi ptr [ %arrayidx2, %if.end ]
  br label %return

return:
  %retval.0 = phi ptr [ %p1, %loopexit1 ], [ %p2, %loopexit2 ], [ %p0, %loopexit0 ]
  ret ptr %retval.0
}


define ptr @test3(i64 %j, ptr readonly %P, ptr readnone %Q) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp slt i64 0, [[J:%.*]]
; CHECK-NEXT:    br i1 [[CMP0]], label [[FOR_BODY_LR_PH:%.*]], label [[RETURN:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[P_ADDR:%.*]] = phi ptr [ [[P:%.*]], [[FOR_BODY_LR_PH]] ], [ [[ARRAYIDX0:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[I0:%.*]] = phi i32 [ 0, [[FOR_BODY_LR_PH]] ], [ [[I_ADD:%.*]], [[IF_END]] ]
; CHECK-NEXT:    [[I0_EXT:%.*]] = sext i32 [[I0]] to i64
; CHECK-NEXT:    [[ARRAYIDX0]] = getelementptr inbounds ptr, ptr [[P_ADDR]], i64 [[I0_EXT]]
; CHECK-NEXT:    [[L0:%.*]] = load ptr, ptr [[ARRAYIDX0]], align 8
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ugt ptr [[L0]], [[Q:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOPEXIT0:%.*]], label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ADD:%.*]] = add i64 [[I0_EXT]], 1
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[ADD]] to i32
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds ptr, ptr [[P_ADDR]], i32 [[TRUNC]]
; CHECK-NEXT:    [[L1:%.*]] = load ptr, ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    [[CMP4:%.*]] = icmp ugt ptr [[L1]], [[Q]]
; CHECK-NEXT:    [[I_ADD]] = add nsw i32 [[I0]], 2
; CHECK-NEXT:    br i1 [[CMP4]], label [[LOOPEXIT1:%.*]], label [[FOR_BODY]]
; CHECK:       loopexit0:
; CHECK-NEXT:    [[P1:%.*]] = phi ptr [ [[ARRAYIDX0]], [[FOR_BODY]] ]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       loopexit1:
; CHECK-NEXT:    [[TRUNC_LCSSA1:%.*]] = phi i32 [ [[TRUNC]], [[IF_END]] ]
; CHECK-NEXT:    [[P_ADDR_LCSSA:%.*]] = phi ptr [ [[P_ADDR]], [[IF_END]] ]
; CHECK-NEXT:    [[TRUNC_LCSSA:%.*]] = phi i32 [ [[TRUNC]], [[IF_END]] ]
; CHECK-NEXT:    [[ARRAYIDX1_LE:%.*]] = getelementptr inbounds ptr, ptr [[P_ADDR_LCSSA]], i32 [[TRUNC_LCSSA1]]
; CHECK-NEXT:    call void @dummy(i32 [[TRUNC_LCSSA]])
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi ptr [ [[P1]], [[LOOPEXIT0]] ], [ [[ARRAYIDX1_LE]], [[LOOPEXIT1]] ], [ null, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret ptr [[RETVAL_0]]
;
entry:
  %cmp0 = icmp slt i64 0, %j
  br i1 %cmp0, label %for.body.lr.ph, label %return

for.body.lr.ph:
  br label %for.body

for.body:
  %P.addr = phi ptr [ %P, %for.body.lr.ph ], [ %arrayidx0, %if.end  ]
  %i0 = phi i32 [ 0, %for.body.lr.ph ], [ %i.add, %if.end]

  %i0.ext = sext i32 %i0 to i64
  %arrayidx0 = getelementptr inbounds ptr, ptr %P.addr, i64 %i0.ext
  %l0 = load ptr, ptr %arrayidx0, align 8
  %cmp1 = icmp ugt ptr %l0, %Q
  br i1 %cmp1, label %loopexit0, label %if.end

if.end:                                           ; preds = %for.body
  %add = add i64 %i0.ext, 1
  %trunc = trunc i64 %add to i32
  %arrayidx1 = getelementptr inbounds ptr, ptr %P.addr, i32 %trunc
  %l1 = load ptr, ptr %arrayidx1, align 8
  %cmp4 = icmp ugt ptr %l1, %Q
  %i.add = add nsw i32 %i0, 2
  br i1 %cmp4, label %loopexit1, label %for.body

loopexit0:
  %p1 = phi ptr [%arrayidx0, %for.body]
  br label %return

loopexit1:
  %p2 = phi ptr [%arrayidx1, %if.end]
  call void @dummy(i32 %trunc)
  br label  %return

return:
  %retval.0 = phi ptr [ %p1, %loopexit0 ], [%p2, %loopexit1], [ null, %entry ]
  ret ptr %retval.0
}

declare void @dummy(i32)

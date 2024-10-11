; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-idiom -mtriple=x86_64 -mcpu=core-avx2 < %s -S | FileCheck %s -check-prefixes=ALL,LZCNT
; RUN: opt -passes=loop-idiom -mtriple=x86_64 -mcpu=corei7 < %s -S | FileCheck %s -check-prefixes=ALL,NOLZCNT

; Recognize CTLZ builtin pattern.
; Here we'll just convert loop to countable,
; so do not insert builtin if CPU do not support CTLZ
;
; int ctlz_and_other(int n, char *a)
; {
;   n = n >= 0 ? n : -n;
;   int i = 0, n0 = n;
;   while(n >>= 1) {
;     a[i] = (n0 & (1 << i)) ? 1 : 0;
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_and_other(i32 %n, ptr nocapture %a) {
; LZCNT-LABEL: @ctlz_and_other(
; LZCNT-NEXT:  entry:
; LZCNT-NEXT:    [[ABS_N:%.*]] = call i32 @llvm.abs.i32(i32 [[N:%.*]], i1 true)
; LZCNT-NEXT:    [[SHR8:%.*]] = lshr i32 [[ABS_N]], 1
; LZCNT-NEXT:    [[TOBOOL9:%.*]] = icmp eq i32 [[SHR8]], 0
; LZCNT-NEXT:    br i1 [[TOBOOL9]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; LZCNT:       while.body.preheader:
; LZCNT-NEXT:    [[TMP0:%.*]] = call i32 @llvm.ctlz.i32(i32 [[SHR8]], i1 true)
; LZCNT-NEXT:    [[TMP1:%.*]] = sub i32 32, [[TMP0]]
; LZCNT-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
; LZCNT-NEXT:    br label [[WHILE_BODY:%.*]]
; LZCNT:       while.body:
; LZCNT-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP1]], [[WHILE_BODY_PREHEADER]] ], [ [[TCDEC:%.*]], [[WHILE_BODY]] ]
; LZCNT-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; LZCNT-NEXT:    [[SHR11:%.*]] = phi i32 [ [[SHR:%.*]], [[WHILE_BODY]] ], [ [[SHR8]], [[WHILE_BODY_PREHEADER]] ]
; LZCNT-NEXT:    [[TMP3:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; LZCNT-NEXT:    [[SHL:%.*]] = shl i32 1, [[TMP3]]
; LZCNT-NEXT:    [[AND:%.*]] = and i32 [[SHL]], [[ABS_N]]
; LZCNT-NEXT:    [[TOBOOL1:%.*]] = icmp ne i32 [[AND]], 0
; LZCNT-NEXT:    [[CONV:%.*]] = zext i1 [[TOBOOL1]] to i8
; LZCNT-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; LZCNT-NEXT:    store i8 [[CONV]], ptr [[ARRAYIDX]], align 1
; LZCNT-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; LZCNT-NEXT:    [[SHR]] = ashr i32 [[SHR11]], 1
; LZCNT-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; LZCNT-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; LZCNT-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; LZCNT:       while.end.loopexit:
; LZCNT-NEXT:    [[INDVARS_IV_NEXT_LCSSA:%.*]] = phi i64 [ [[TMP2]], [[WHILE_BODY]] ]
; LZCNT-NEXT:    [[TMP4:%.*]] = trunc i64 [[INDVARS_IV_NEXT_LCSSA]] to i32
; LZCNT-NEXT:    br label [[WHILE_END]]
; LZCNT:       while.end:
; LZCNT-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[TMP4]], [[WHILE_END_LOOPEXIT]] ]
; LZCNT-NEXT:    ret i32 [[I_0_LCSSA]]
;
; NOLZCNT-LABEL: @ctlz_and_other(
; NOLZCNT-NEXT:  entry:
; NOLZCNT-NEXT:    [[ABS_N:%.*]] = call i32 @llvm.abs.i32(i32 [[N:%.*]], i1 true)
; NOLZCNT-NEXT:    [[SHR8:%.*]] = lshr i32 [[ABS_N]], 1
; NOLZCNT-NEXT:    [[TOBOOL9:%.*]] = icmp eq i32 [[SHR8]], 0
; NOLZCNT-NEXT:    br i1 [[TOBOOL9]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; NOLZCNT:       while.body.preheader:
; NOLZCNT-NEXT:    br label [[WHILE_BODY:%.*]]
; NOLZCNT:       while.body:
; NOLZCNT-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; NOLZCNT-NEXT:    [[SHR11:%.*]] = phi i32 [ [[SHR:%.*]], [[WHILE_BODY]] ], [ [[SHR8]], [[WHILE_BODY_PREHEADER]] ]
; NOLZCNT-NEXT:    [[TMP0:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; NOLZCNT-NEXT:    [[SHL:%.*]] = shl i32 1, [[TMP0]]
; NOLZCNT-NEXT:    [[AND:%.*]] = and i32 [[SHL]], [[ABS_N]]
; NOLZCNT-NEXT:    [[TOBOOL1:%.*]] = icmp ne i32 [[AND]], 0
; NOLZCNT-NEXT:    [[CONV:%.*]] = zext i1 [[TOBOOL1]] to i8
; NOLZCNT-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; NOLZCNT-NEXT:    store i8 [[CONV]], ptr [[ARRAYIDX]], align 1
; NOLZCNT-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; NOLZCNT-NEXT:    [[SHR]] = ashr i32 [[SHR11]], 1
; NOLZCNT-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[SHR]], 0
; NOLZCNT-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; NOLZCNT:       while.end.loopexit:
; NOLZCNT-NEXT:    [[INDVARS_IV_NEXT_LCSSA:%.*]] = phi i64 [ [[INDVARS_IV_NEXT]], [[WHILE_BODY]] ]
; NOLZCNT-NEXT:    [[TMP1:%.*]] = trunc i64 [[INDVARS_IV_NEXT_LCSSA]] to i32
; NOLZCNT-NEXT:    br label [[WHILE_END]]
; NOLZCNT:       while.end:
; NOLZCNT-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[TMP1]], [[WHILE_END_LOOPEXIT]] ]
; NOLZCNT-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %abs_n = call i32 @llvm.abs.i32(i32 %n, i1 true)
  %shr8 = lshr i32 %abs_n, 1
  %tobool9 = icmp eq i32 %shr8, 0
  br i1 %tobool9, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %while.body ], [ 0, %while.body.preheader ]
  %shr11 = phi i32 [ %shr, %while.body ], [ %shr8, %while.body.preheader ]
  %0 = trunc i64 %indvars.iv to i32
  %shl = shl i32 1, %0
  %and = and i32 %shl, %abs_n
  %tobool1 = icmp ne i32 %and, 0
  %conv = zext i1 %tobool1 to i8
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %indvars.iv
  store i8 %conv, ptr %arrayidx, align 1
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %shr = ashr i32 %shr11, 1
  %tobool = icmp eq i32 %shr, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  %1 = trunc i64 %indvars.iv.next to i32
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %i.0.lcssa = phi i32 [ 0, %entry ], [ %1, %while.end.loopexit ]
  ret i32 %i.0.lcssa
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_zero_check(int n)
; {
;   n = n >= 0 ? n : -n;
;   int i = 0;
;   while(n) {
;     n >>= 1;
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_zero_check(i32 %n) {
; ALL-LABEL: @ctlz_zero_check(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[ABS_N:%.*]] = call i32 @llvm.abs.i32(i32 [[N:%.*]], i1 true)
; ALL-NEXT:    [[TOBOOL4:%.*]] = icmp eq i32 [[ABS_N]], 0
; ALL-NEXT:    br i1 [[TOBOOL4]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; ALL:       while.body.preheader:
; ALL-NEXT:    [[TMP0:%.*]] = call i32 @llvm.ctlz.i32(i32 [[ABS_N]], i1 true)
; ALL-NEXT:    [[TMP1:%.*]] = sub i32 32, [[TMP0]]
; ALL-NEXT:    br label [[WHILE_BODY:%.*]]
; ALL:       while.body:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP1]], [[WHILE_BODY_PREHEADER]] ], [ [[TCDEC:%.*]], [[WHILE_BODY]] ]
; ALL-NEXT:    [[I_06:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; ALL-NEXT:    [[N_ADDR_05:%.*]] = phi i32 [ [[SHR:%.*]], [[WHILE_BODY]] ], [ [[ABS_N]], [[WHILE_BODY_PREHEADER]] ]
; ALL-NEXT:    [[SHR]] = ashr i32 [[N_ADDR_05]], 1
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_06]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; ALL:       while.end.loopexit:
; ALL-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[TMP1]], [[WHILE_BODY]] ]
; ALL-NEXT:    br label [[WHILE_END]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC_LCSSA]], [[WHILE_END_LOOPEXIT]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %abs_n = call i32 @llvm.abs.i32(i32 %n, i1 true)
  %tobool4 = icmp eq i32 %abs_n, 0
  br i1 %tobool4, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %i.06 = phi i32 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %n.addr.05 = phi i32 [ %shr, %while.body ], [ %abs_n, %while.body.preheader ]
  %shr = ashr i32 %n.addr.05, 1
  %inc = add nsw i32 %i.06, 1
  %tobool = icmp eq i32 %shr, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %i.0.lcssa = phi i32 [ 0, %entry ], [ %inc, %while.end.loopexit ]
  ret i32 %i.0.lcssa
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_zero_check_lshr(int n)
; {
;   int i = 0;
;   while(n) {
;     n >>= 1;
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_zero_check_lshr(i32 %n) {
; ALL-LABEL: @ctlz_zero_check_lshr(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TOBOOL4:%.*]] = icmp eq i32 [[N:%.*]], 0
; ALL-NEXT:    br i1 [[TOBOOL4]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; ALL:       while.body.preheader:
; ALL-NEXT:    [[TMP0:%.*]] = call i32 @llvm.ctlz.i32(i32 [[N]], i1 true)
; ALL-NEXT:    [[TMP1:%.*]] = sub i32 32, [[TMP0]]
; ALL-NEXT:    br label [[WHILE_BODY:%.*]]
; ALL:       while.body:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP1]], [[WHILE_BODY_PREHEADER]] ], [ [[TCDEC:%.*]], [[WHILE_BODY]] ]
; ALL-NEXT:    [[I_06:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; ALL-NEXT:    [[N_ADDR_05:%.*]] = phi i32 [ [[SHR:%.*]], [[WHILE_BODY]] ], [ [[N]], [[WHILE_BODY_PREHEADER]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_05]], 1
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_06]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; ALL:       while.end.loopexit:
; ALL-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[TMP1]], [[WHILE_BODY]] ]
; ALL-NEXT:    br label [[WHILE_END]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC_LCSSA]], [[WHILE_END_LOOPEXIT]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %tobool4 = icmp eq i32 %n, 0
  br i1 %tobool4, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %i.06 = phi i32 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %n.addr.05 = phi i32 [ %shr, %while.body ], [ %n, %while.body.preheader ]
  %shr = lshr i32 %n.addr.05, 1
  %inc = add nsw i32 %i.06, 1
  %tobool = icmp eq i32 %shr, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %i.0.lcssa = phi i32 [ 0, %entry ], [ %inc, %while.end.loopexit ]
  ret i32 %i.0.lcssa
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz(int n)
; {
;   n = n >= 0 ? n : -n;
;   int i = 0;
;   while(n >>= 1) {
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz(i32 %n) {
; ALL-LABEL: @ctlz(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[ABS_N:%.*]] = call i32 @llvm.abs.i32(i32 [[N:%.*]], i1 true)
; ALL-NEXT:    [[TMP0:%.*]] = ashr i32 [[ABS_N]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[ABS_N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = ashr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP2]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %abs_n = call i32 @llvm.abs.i32(i32 %n, i1 true)
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %abs_n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %while.cond ]
  %shr = ashr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_lshr(int n)
; {
;   int i = 0;
;   while(n >>= 1) {
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_lshr(i32 %n) {
; ALL-LABEL: @ctlz_lshr(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TMP0:%.*]] = lshr i32 [[N:%.*]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP2]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %while.cond ]
  %shr = lshr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_add(int n, int i0)
; {
;   n = n >= 0 ? n : -n;
;   int i = i0;
;   while(n >>= 1) {
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_add(i32 %n, i32 %i0) {
; ALL-LABEL: @ctlz_add(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[ABS_N:%.*]] = call i32 @llvm.abs.i32(i32 [[N:%.*]], i1 true)
; ALL-NEXT:    [[TMP0:%.*]] = ashr i32 [[ABS_N]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    [[TMP4:%.*]] = add i32 [[TMP2]], [[I0:%.*]]
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[ABS_N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ [[I0]], [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = ashr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP4]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %abs_n = call i32 @llvm.abs.i32(i32 %n, i1 true)
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %abs_n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ %i0, %entry ], [ %inc, %while.cond ]
  %shr = ashr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_add_lshr(int n, int i0)
; {
;   int i = i0;
;   while(n >>= 1) {
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_add_lshr(i32 %n, i32 %i0) {
; ALL-LABEL: @ctlz_add_lshr(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TMP0:%.*]] = lshr i32 [[N:%.*]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    [[TMP4:%.*]] = add i32 [[TMP2]], [[I0:%.*]]
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ [[I0]], [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP4]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ %i0, %entry ], [ %inc, %while.cond ]
  %shr = lshr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_sext(short in)
; {
;   int n = in;
;   if (in < 0)
;     n = -n;
;   int i = 0;
;   while(n >>= 1) {
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_sext(i16 %in) {
; ALL-LABEL: @ctlz_sext(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[ABS:%.*]] = call i16 @llvm.abs.i16(i16 [[IN:%.*]], i1 false)
; ALL-NEXT:    [[ABS_N:%.*]] = zext i16 [[ABS]] to i32
; ALL-NEXT:    [[TMP0:%.*]] = ashr i32 [[ABS_N]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[ABS_N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = ashr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP2]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %abs = call i16 @llvm.abs.i16(i16 %in, i1 false)
  %abs_n = zext i16 %abs to i32
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %abs_n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %while.cond ]
  %shr = ashr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_sext_lshr(short in)
; {
;   int i = 0;
;   while(in >>= 1) {
;     i++;
;   }
;   return i;
; }
;
define i32 @ctlz_sext_lshr(i16 %in) {
; ALL-LABEL: @ctlz_sext_lshr(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[N:%.*]] = sext i16 [[IN:%.*]] to i32
; ALL-NEXT:    [[TMP0:%.*]] = lshr i32 [[N]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP2]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %n = sext i16 %in to i32
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %while.cond ]
  %shr = lshr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

; This loop contains a volatile store. If x is initially negative,
; the code will be an infinite loop because the ashr will eventually produce
; all ones and continue doing so. This prevents the loop from terminating. If
; we convert this to a countable loop using ctlz that loop will only run 32
; times. This is different than the infinite number of times of the original.
define i32 @foo(i32 %x) {
; ALL-LABEL: @foo(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[V:%.*]] = alloca i8, align 1
; ALL-NEXT:    [[TOBOOL4:%.*]] = icmp eq i32 [[X:%.*]], 0
; ALL-NEXT:    br i1 [[TOBOOL4]], label [[WHILE_END:%.*]], label [[WHILE_BODY_LR_PH:%.*]]
; ALL:       while.body.lr.ph:
; ALL-NEXT:    br label [[WHILE_BODY:%.*]]
; ALL:       while.body:
; ALL-NEXT:    [[CNT_06:%.*]] = phi i32 [ 0, [[WHILE_BODY_LR_PH]] ], [ [[INC:%.*]], [[WHILE_BODY]] ]
; ALL-NEXT:    [[X_ADDR_05:%.*]] = phi i32 [ [[X]], [[WHILE_BODY_LR_PH]] ], [ [[SHR:%.*]], [[WHILE_BODY]] ]
; ALL-NEXT:    [[SHR]] = ashr i32 [[X_ADDR_05]], 1
; ALL-NEXT:    [[INC]] = add i32 [[CNT_06]], 1
; ALL-NEXT:    store volatile i8 42, ptr [[V]], align 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[SHR]], 0
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_COND_WHILE_END_CRIT_EDGE:%.*]], label [[WHILE_BODY]]
; ALL:       while.cond.while.end_crit_edge:
; ALL-NEXT:    [[SPLIT:%.*]] = phi i32 [ [[INC]], [[WHILE_BODY]] ]
; ALL-NEXT:    br label [[WHILE_END]]
; ALL:       while.end:
; ALL-NEXT:    [[CNT_0_LCSSA:%.*]] = phi i32 [ [[SPLIT]], [[WHILE_COND_WHILE_END_CRIT_EDGE]] ], [ 0, [[ENTRY:%.*]] ]
; ALL-NEXT:    ret i32 [[CNT_0_LCSSA]]
;
entry:
  %v = alloca i8, align 1
  %tobool4 = icmp eq i32 %x, 0
  br i1 %tobool4, label %while.end, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.lr.ph, %while.body
  %cnt.06 = phi i32 [ 0, %while.body.lr.ph ], [ %inc, %while.body ]
  %x.addr.05 = phi i32 [ %x, %while.body.lr.ph ], [ %shr, %while.body ]
  %shr = ashr i32 %x.addr.05, 1
  %inc = add i32 %cnt.06, 1
  store volatile i8 42, ptr %v, align 1
  %tobool = icmp eq i32 %shr, 0
  br i1 %tobool, label %while.cond.while.end_crit_edge, label %while.body

while.cond.while.end_crit_edge:                   ; preds = %while.body
  %split = phi i32 [ %inc, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %entry
  %cnt.0.lcssa = phi i32 [ %split, %while.cond.while.end_crit_edge ], [ 0, %entry ]
  ret i32 %cnt.0.lcssa
}

; We can't easily transform this loop. It returns 1 for an input of both
; 0 and 1.
;
; int ctlz_bad(unsigned n)
; {
;   int i = 0;
;   do {
;     i++;
;     n >>= 1;
;   } while(n != 0) {
;   return i;
; }
;
define i32 @ctlz_bad(i32 %n) {
; ALL-LABEL: @ctlz_bad(
; ALL-NEXT:  entry:
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[N:%.*]], [[ENTRY:%.*]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[SHR]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], 1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[INC]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[INC_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %while.cond ]
  %shr = lshr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %inc
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_decrement(int n)
; {
;   int i = 32;
;   while(n) {
;     n >>= 1;
;     i--;
;   }
;   return i;
; }
;
define i32 @ctlz_decrement(i32 %n) {
; ALL-LABEL: @ctlz_decrement(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TOBOOL4:%.*]] = icmp eq i32 [[N:%.*]], 0
; ALL-NEXT:    br i1 [[TOBOOL4]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; ALL:       while.body.preheader:
; ALL-NEXT:    [[TMP0:%.*]] = call i32 @llvm.ctlz.i32(i32 [[N]], i1 true)
; ALL-NEXT:    [[TMP1:%.*]] = sub i32 32, [[TMP0]]
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    br label [[WHILE_BODY:%.*]]
; ALL:       while.body:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP1]], [[WHILE_BODY_PREHEADER]] ], [ [[TCDEC:%.*]], [[WHILE_BODY]] ]
; ALL-NEXT:    [[I_06:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_BODY]] ], [ 32, [[WHILE_BODY_PREHEADER]] ]
; ALL-NEXT:    [[N_ADDR_05:%.*]] = phi i32 [ [[SHR:%.*]], [[WHILE_BODY]] ], [ [[N]], [[WHILE_BODY_PREHEADER]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_05]], 1
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_06]], -1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END_LOOPEXIT:%.*]], label [[WHILE_BODY]]
; ALL:       while.end.loopexit:
; ALL-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[TMP2]], [[WHILE_BODY]] ]
; ALL-NEXT:    br label [[WHILE_END]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ 32, [[ENTRY:%.*]] ], [ [[INC_LCSSA]], [[WHILE_END_LOOPEXIT]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %tobool4 = icmp eq i32 %n, 0
  br i1 %tobool4, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %i.06 = phi i32 [ %inc, %while.body ], [ 32, %while.body.preheader ]
  %n.addr.05 = phi i32 [ %shr, %while.body ], [ %n, %while.body.preheader ]
  %shr = lshr i32 %n.addr.05, 1
  %inc = add nsw i32 %i.06, -1
  %tobool = icmp eq i32 %shr, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %i.0.lcssa = phi i32 [ 32, %entry ], [ %inc, %while.end.loopexit ]
  ret i32 %i.0.lcssa
}

; Recognize CTLZ builtin pattern.
; Here it will replace the loop -
; assume builtin is always profitable.
;
; int ctlz_lshr_decrement(int n)
; {
;   int i = 31;
;   while(n >>= 1) {
;     i--;
;   }
;   return i;
; }
;
define i32 @ctlz_lshr_decrement(i32 %n) {
; ALL-LABEL: @ctlz_lshr_decrement(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TMP0:%.*]] = lshr i32 [[N:%.*]], 1
; ALL-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctlz.i32(i32 [[TMP0]], i1 false)
; ALL-NEXT:    [[TMP2:%.*]] = sub i32 32, [[TMP1]]
; ALL-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 1
; ALL-NEXT:    [[TMP4:%.*]] = sub i32 31, [[TMP2]]
; ALL-NEXT:    br label [[WHILE_COND:%.*]]
; ALL:       while.cond:
; ALL-NEXT:    [[TCPHI:%.*]] = phi i32 [ [[TMP3]], [[ENTRY:%.*]] ], [ [[TCDEC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[N_ADDR_0:%.*]] = phi i32 [ [[N]], [[ENTRY]] ], [ [[SHR:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[I_0:%.*]] = phi i32 [ 31, [[ENTRY]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; ALL-NEXT:    [[SHR]] = lshr i32 [[N_ADDR_0]], 1
; ALL-NEXT:    [[TCDEC]] = sub nsw i32 [[TCPHI]], 1
; ALL-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TCDEC]], 0
; ALL-NEXT:    [[INC]] = add nsw i32 [[I_0]], -1
; ALL-NEXT:    br i1 [[TOBOOL]], label [[WHILE_END:%.*]], label [[WHILE_COND]]
; ALL:       while.end:
; ALL-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ [[TMP4]], [[WHILE_COND]] ]
; ALL-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %n.addr.0 = phi i32 [ %n, %entry ], [ %shr, %while.cond ]
  %i.0 = phi i32 [ 31, %entry ], [ %inc, %while.cond ]
  %shr = lshr i32 %n.addr.0, 1
  %tobool = icmp eq i32 %shr, 0
  %inc = add nsw i32 %i.0, -1
  br i1 %tobool, label %while.end, label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}

declare i32 @llvm.abs.i32(i32, i1)
declare i16 @llvm.abs.i16(i16, i1)

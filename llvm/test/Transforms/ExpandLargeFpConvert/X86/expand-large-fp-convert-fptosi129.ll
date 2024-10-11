; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-- -expand-large-fp-convert < %s | FileCheck %s
; RUN: opt -S -mtriple=x86_64-- -passes=expand-large-fp-convert < %s | FileCheck %s

define i129 @halftosi129(half %a) {
; CHECK-LABEL: @halftosi129(
; CHECK-NEXT:    [[TMP1:%.*]] = fptosi half [[A:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sext i32 [[TMP1]] to i129
; CHECK-NEXT:    ret i129 [[TMP2]]
;
  %conv = fptosi half %a to i129
  ret i129 %conv
}

define i129 @floattosi129(float %a) {
; CHECK-LABEL: @floattosi129(
; CHECK-NEXT:  fp-to-i-entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast float [[A:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[TMP0]] to i129
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP0]], -1
; CHECK-NEXT:    [[TMP3:%.*]] = select i1 [[TMP2]], i129 1, i129 -1
; CHECK-NEXT:    [[TMP4:%.*]] = lshr i129 [[TMP1]], 23
; CHECK-NEXT:    [[TMP5:%.*]] = and i129 [[TMP4]], 255
; CHECK-NEXT:    [[TMP6:%.*]] = and i129 [[TMP1]], 8388607
; CHECK-NEXT:    [[TMP7:%.*]] = or i129 [[TMP6]], 8388608
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ult i129 [[TMP5]], 127
; CHECK-NEXT:    br i1 [[TMP8]], label [[FP_TO_I_CLEANUP:%.*]], label [[FP_TO_I_IF_END:%.*]]
; CHECK:       fp-to-i-if-end:
; CHECK-NEXT:    [[TMP9:%.*]] = add i129 [[TMP5]], -256
; CHECK-NEXT:    [[TMP10:%.*]] = icmp ult i129 [[TMP9]], -129
; CHECK-NEXT:    br i1 [[TMP10]], label [[FP_TO_I_IF_THEN5:%.*]], label [[FP_TO_I_IF_END9:%.*]]
; CHECK:       fp-to-i-if-then5:
; CHECK-NEXT:    [[TMP11:%.*]] = select i1 [[TMP2]], i129 340282366920938463463374607431768211455, i129 -340282366920938463463374607431768211456
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-end9:
; CHECK-NEXT:    [[TMP12:%.*]] = icmp ult i129 [[TMP5]], 150
; CHECK-NEXT:    br i1 [[TMP12]], label [[FP_TO_I_IF_THEN12:%.*]], label [[FP_TO_I_IF_ELSE:%.*]]
; CHECK:       fp-to-i-if-then12:
; CHECK-NEXT:    [[TMP13:%.*]] = sub i129 150, [[TMP5]]
; CHECK-NEXT:    [[TMP14:%.*]] = lshr i129 [[TMP7]], [[TMP13]]
; CHECK-NEXT:    [[TMP15:%.*]] = mul i129 [[TMP14]], [[TMP3]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-else:
; CHECK-NEXT:    [[TMP16:%.*]] = add i129 [[TMP5]], -150
; CHECK-NEXT:    [[TMP17:%.*]] = shl i129 [[TMP7]], [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = mul i129 [[TMP17]], [[TMP3]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-cleanup:
; CHECK-NEXT:    [[TMP19:%.*]] = phi i129 [ [[TMP11]], [[FP_TO_I_IF_THEN5]] ], [ [[TMP15]], [[FP_TO_I_IF_THEN12]] ], [ [[TMP18]], [[FP_TO_I_IF_ELSE]] ], [ 0, [[FP_TO_I_ENTRY:%.*]] ]
; CHECK-NEXT:    ret i129 [[TMP19]]
;
  %conv = fptosi float %a to i129
  ret i129 %conv
}

define i129 @doubletosi129(double %a) {
; CHECK-LABEL: @doubletosi129(
; CHECK-NEXT:  fp-to-i-entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast double [[A:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = zext i64 [[TMP0]] to i129
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i64 [[TMP0]], -1
; CHECK-NEXT:    [[TMP3:%.*]] = select i1 [[TMP2]], i129 1, i129 -1
; CHECK-NEXT:    [[TMP4:%.*]] = lshr i129 [[TMP1]], 52
; CHECK-NEXT:    [[TMP5:%.*]] = and i129 [[TMP4]], 2047
; CHECK-NEXT:    [[TMP6:%.*]] = and i129 [[TMP1]], 4503599627370495
; CHECK-NEXT:    [[TMP7:%.*]] = or i129 [[TMP6]], 4503599627370496
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ult i129 [[TMP5]], 1023
; CHECK-NEXT:    br i1 [[TMP8]], label [[FP_TO_I_CLEANUP:%.*]], label [[FP_TO_I_IF_END:%.*]]
; CHECK:       fp-to-i-if-end:
; CHECK-NEXT:    [[TMP9:%.*]] = add i129 [[TMP5]], -1152
; CHECK-NEXT:    [[TMP10:%.*]] = icmp ult i129 [[TMP9]], -129
; CHECK-NEXT:    br i1 [[TMP10]], label [[FP_TO_I_IF_THEN5:%.*]], label [[FP_TO_I_IF_END9:%.*]]
; CHECK:       fp-to-i-if-then5:
; CHECK-NEXT:    [[TMP11:%.*]] = select i1 [[TMP2]], i129 340282366920938463463374607431768211455, i129 -340282366920938463463374607431768211456
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-end9:
; CHECK-NEXT:    [[TMP12:%.*]] = icmp ult i129 [[TMP5]], 1075
; CHECK-NEXT:    br i1 [[TMP12]], label [[FP_TO_I_IF_THEN12:%.*]], label [[FP_TO_I_IF_ELSE:%.*]]
; CHECK:       fp-to-i-if-then12:
; CHECK-NEXT:    [[TMP13:%.*]] = sub i129 1075, [[TMP5]]
; CHECK-NEXT:    [[TMP14:%.*]] = lshr i129 [[TMP7]], [[TMP13]]
; CHECK-NEXT:    [[TMP15:%.*]] = mul i129 [[TMP14]], [[TMP3]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-else:
; CHECK-NEXT:    [[TMP16:%.*]] = add i129 [[TMP5]], -1075
; CHECK-NEXT:    [[TMP17:%.*]] = shl i129 [[TMP7]], [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = mul i129 [[TMP17]], [[TMP3]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-cleanup:
; CHECK-NEXT:    [[TMP19:%.*]] = phi i129 [ [[TMP11]], [[FP_TO_I_IF_THEN5]] ], [ [[TMP15]], [[FP_TO_I_IF_THEN12]] ], [ [[TMP18]], [[FP_TO_I_IF_ELSE]] ], [ 0, [[FP_TO_I_ENTRY:%.*]] ]
; CHECK-NEXT:    ret i129 [[TMP19]]
;
  %conv = fptosi double %a to i129
  ret i129 %conv
}

define i129 @x86_fp80tosi129(x86_fp80 %a) {
; CHECK-LABEL: @x86_fp80tosi129(
; CHECK-NEXT:  fp-to-i-entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fpext x86_fp80 [[A:%.*]] to fp128
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast fp128 [[TMP0]] to i128
; CHECK-NEXT:    [[TMP2:%.*]] = zext i128 [[TMP1]] to i129
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i128 [[TMP1]], -1
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i129 1, i129 -1
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i129 [[TMP2]], 112
; CHECK-NEXT:    [[TMP6:%.*]] = and i129 [[TMP5]], 32767
; CHECK-NEXT:    [[TMP7:%.*]] = and i129 [[TMP2]], 5192296858534827628530496329220095
; CHECK-NEXT:    [[TMP8:%.*]] = or i129 [[TMP7]], 5192296858534827628530496329220096
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ult i129 [[TMP6]], 16383
; CHECK-NEXT:    br i1 [[TMP9]], label [[FP_TO_I_CLEANUP:%.*]], label [[FP_TO_I_IF_END:%.*]]
; CHECK:       fp-to-i-if-end:
; CHECK-NEXT:    [[TMP10:%.*]] = add i129 [[TMP6]], -16512
; CHECK-NEXT:    [[TMP11:%.*]] = icmp ult i129 [[TMP10]], -129
; CHECK-NEXT:    br i1 [[TMP11]], label [[FP_TO_I_IF_THEN5:%.*]], label [[FP_TO_I_IF_END9:%.*]]
; CHECK:       fp-to-i-if-then5:
; CHECK-NEXT:    [[TMP12:%.*]] = select i1 [[TMP3]], i129 340282366920938463463374607431768211455, i129 -340282366920938463463374607431768211456
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-end9:
; CHECK-NEXT:    [[TMP13:%.*]] = icmp ult i129 [[TMP6]], 16495
; CHECK-NEXT:    br i1 [[TMP13]], label [[FP_TO_I_IF_THEN12:%.*]], label [[FP_TO_I_IF_ELSE:%.*]]
; CHECK:       fp-to-i-if-then12:
; CHECK-NEXT:    [[TMP14:%.*]] = sub i129 16495, [[TMP6]]
; CHECK-NEXT:    [[TMP15:%.*]] = lshr i129 [[TMP8]], [[TMP14]]
; CHECK-NEXT:    [[TMP16:%.*]] = mul i129 [[TMP15]], [[TMP4]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-else:
; CHECK-NEXT:    [[TMP17:%.*]] = add i129 [[TMP6]], -16495
; CHECK-NEXT:    [[TMP18:%.*]] = shl i129 [[TMP8]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = mul i129 [[TMP18]], [[TMP4]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-cleanup:
; CHECK-NEXT:    [[TMP20:%.*]] = phi i129 [ [[TMP12]], [[FP_TO_I_IF_THEN5]] ], [ [[TMP16]], [[FP_TO_I_IF_THEN12]] ], [ [[TMP19]], [[FP_TO_I_IF_ELSE]] ], [ 0, [[FP_TO_I_ENTRY:%.*]] ]
; CHECK-NEXT:    ret i129 [[TMP20]]
;
  %conv = fptosi x86_fp80 %a to i129
  ret i129 %conv
}

define i129 @fp128tosi129(fp128 %a) {
; CHECK-LABEL: @fp128tosi129(
; CHECK-NEXT:  fp-to-i-entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast fp128 [[A:%.*]] to i128
; CHECK-NEXT:    [[TMP1:%.*]] = zext i128 [[TMP0]] to i129
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i128 [[TMP0]], -1
; CHECK-NEXT:    [[TMP3:%.*]] = select i1 [[TMP2]], i129 1, i129 -1
; CHECK-NEXT:    [[TMP4:%.*]] = lshr i129 [[TMP1]], 112
; CHECK-NEXT:    [[TMP5:%.*]] = and i129 [[TMP4]], 32767
; CHECK-NEXT:    [[TMP6:%.*]] = and i129 [[TMP1]], 5192296858534827628530496329220095
; CHECK-NEXT:    [[TMP7:%.*]] = or i129 [[TMP6]], 5192296858534827628530496329220096
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ult i129 [[TMP5]], 16383
; CHECK-NEXT:    br i1 [[TMP8]], label [[FP_TO_I_CLEANUP:%.*]], label [[FP_TO_I_IF_END:%.*]]
; CHECK:       fp-to-i-if-end:
; CHECK-NEXT:    [[TMP9:%.*]] = add i129 [[TMP5]], -16512
; CHECK-NEXT:    [[TMP10:%.*]] = icmp ult i129 [[TMP9]], -129
; CHECK-NEXT:    br i1 [[TMP10]], label [[FP_TO_I_IF_THEN5:%.*]], label [[FP_TO_I_IF_END9:%.*]]
; CHECK:       fp-to-i-if-then5:
; CHECK-NEXT:    [[TMP11:%.*]] = select i1 [[TMP2]], i129 340282366920938463463374607431768211455, i129 -340282366920938463463374607431768211456
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-end9:
; CHECK-NEXT:    [[TMP12:%.*]] = icmp ult i129 [[TMP5]], 16495
; CHECK-NEXT:    br i1 [[TMP12]], label [[FP_TO_I_IF_THEN12:%.*]], label [[FP_TO_I_IF_ELSE:%.*]]
; CHECK:       fp-to-i-if-then12:
; CHECK-NEXT:    [[TMP13:%.*]] = sub i129 16495, [[TMP5]]
; CHECK-NEXT:    [[TMP14:%.*]] = lshr i129 [[TMP7]], [[TMP13]]
; CHECK-NEXT:    [[TMP15:%.*]] = mul i129 [[TMP14]], [[TMP3]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-else:
; CHECK-NEXT:    [[TMP16:%.*]] = add i129 [[TMP5]], -16495
; CHECK-NEXT:    [[TMP17:%.*]] = shl i129 [[TMP7]], [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = mul i129 [[TMP17]], [[TMP3]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-cleanup:
; CHECK-NEXT:    [[TMP19:%.*]] = phi i129 [ [[TMP11]], [[FP_TO_I_IF_THEN5]] ], [ [[TMP15]], [[FP_TO_I_IF_THEN12]] ], [ [[TMP18]], [[FP_TO_I_IF_ELSE]] ], [ 0, [[FP_TO_I_ENTRY:%.*]] ]
; CHECK-NEXT:    ret i129 [[TMP19]]
;
  %conv = fptosi fp128 %a to i129
  ret i129 %conv
}

define <2 x i129> @floattosi129v2(<2 x float> %a) {
; CHECK-LABEL: @floattosi129v2(
; CHECK-NEXT:  fp-to-i-entryfp-to-i-entry:
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x float> [[A:%.*]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i129
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[TMP1]], -1
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i129 1, i129 -1
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i129 [[TMP2]], 23
; CHECK-NEXT:    [[TMP6:%.*]] = and i129 [[TMP5]], 255
; CHECK-NEXT:    [[TMP7:%.*]] = and i129 [[TMP2]], 8388607
; CHECK-NEXT:    [[TMP8:%.*]] = or i129 [[TMP7]], 8388608
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ult i129 [[TMP6]], 127
; CHECK-NEXT:    br i1 [[TMP9]], label [[FP_TO_I_CLEANUP1:%.*]], label [[FP_TO_I_IF_END2:%.*]]
; CHECK:       fp-to-i-if-end2:
; CHECK-NEXT:    [[TMP10:%.*]] = add i129 [[TMP6]], -256
; CHECK-NEXT:    [[TMP11:%.*]] = icmp ult i129 [[TMP10]], -129
; CHECK-NEXT:    br i1 [[TMP11]], label [[FP_TO_I_IF_THEN53:%.*]], label [[FP_TO_I_IF_END94:%.*]]
; CHECK:       fp-to-i-if-then53:
; CHECK-NEXT:    [[TMP12:%.*]] = select i1 [[TMP3]], i129 340282366920938463463374607431768211455, i129 -340282366920938463463374607431768211456
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP1]]
; CHECK:       fp-to-i-if-end94:
; CHECK-NEXT:    [[TMP13:%.*]] = icmp ult i129 [[TMP6]], 150
; CHECK-NEXT:    br i1 [[TMP13]], label [[FP_TO_I_IF_THEN125:%.*]], label [[FP_TO_I_IF_ELSE6:%.*]]
; CHECK:       fp-to-i-if-then125:
; CHECK-NEXT:    [[TMP14:%.*]] = sub i129 150, [[TMP6]]
; CHECK-NEXT:    [[TMP15:%.*]] = lshr i129 [[TMP8]], [[TMP14]]
; CHECK-NEXT:    [[TMP16:%.*]] = mul i129 [[TMP15]], [[TMP4]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP1]]
; CHECK:       fp-to-i-if-else6:
; CHECK-NEXT:    [[TMP17:%.*]] = add i129 [[TMP6]], -150
; CHECK-NEXT:    [[TMP18:%.*]] = shl i129 [[TMP8]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = mul i129 [[TMP18]], [[TMP4]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP1]]
; CHECK:       fp-to-i-cleanup1:
; CHECK-NEXT:    [[TMP20:%.*]] = phi i129 [ [[TMP12]], [[FP_TO_I_IF_THEN53]] ], [ [[TMP16]], [[FP_TO_I_IF_THEN125]] ], [ [[TMP19]], [[FP_TO_I_IF_ELSE6]] ], [ 0, [[FP_TO_I_ENTRYFP_TO_I_ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <2 x i129> poison, i129 [[TMP20]], i64 0
; CHECK-NEXT:    [[TMP22:%.*]] = extractelement <2 x float> [[A]], i64 1
; CHECK-NEXT:    [[TMP23:%.*]] = bitcast float [[TMP22]] to i32
; CHECK-NEXT:    [[TMP24:%.*]] = zext i32 [[TMP23]] to i129
; CHECK-NEXT:    [[TMP25:%.*]] = icmp sgt i32 [[TMP23]], -1
; CHECK-NEXT:    [[TMP26:%.*]] = select i1 [[TMP25]], i129 1, i129 -1
; CHECK-NEXT:    [[TMP27:%.*]] = lshr i129 [[TMP24]], 23
; CHECK-NEXT:    [[TMP28:%.*]] = and i129 [[TMP27]], 255
; CHECK-NEXT:    [[TMP29:%.*]] = and i129 [[TMP24]], 8388607
; CHECK-NEXT:    [[TMP30:%.*]] = or i129 [[TMP29]], 8388608
; CHECK-NEXT:    [[TMP31:%.*]] = icmp ult i129 [[TMP28]], 127
; CHECK-NEXT:    br i1 [[TMP31]], label [[FP_TO_I_CLEANUP:%.*]], label [[FP_TO_I_IF_END:%.*]]
; CHECK:       fp-to-i-if-end:
; CHECK-NEXT:    [[TMP32:%.*]] = add i129 [[TMP28]], -256
; CHECK-NEXT:    [[TMP33:%.*]] = icmp ult i129 [[TMP32]], -129
; CHECK-NEXT:    br i1 [[TMP33]], label [[FP_TO_I_IF_THEN5:%.*]], label [[FP_TO_I_IF_END9:%.*]]
; CHECK:       fp-to-i-if-then5:
; CHECK-NEXT:    [[TMP34:%.*]] = select i1 [[TMP25]], i129 340282366920938463463374607431768211455, i129 -340282366920938463463374607431768211456
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-end9:
; CHECK-NEXT:    [[TMP35:%.*]] = icmp ult i129 [[TMP28]], 150
; CHECK-NEXT:    br i1 [[TMP35]], label [[FP_TO_I_IF_THEN12:%.*]], label [[FP_TO_I_IF_ELSE:%.*]]
; CHECK:       fp-to-i-if-then12:
; CHECK-NEXT:    [[TMP36:%.*]] = sub i129 150, [[TMP28]]
; CHECK-NEXT:    [[TMP37:%.*]] = lshr i129 [[TMP30]], [[TMP36]]
; CHECK-NEXT:    [[TMP38:%.*]] = mul i129 [[TMP37]], [[TMP26]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-if-else:
; CHECK-NEXT:    [[TMP39:%.*]] = add i129 [[TMP28]], -150
; CHECK-NEXT:    [[TMP40:%.*]] = shl i129 [[TMP30]], [[TMP39]]
; CHECK-NEXT:    [[TMP41:%.*]] = mul i129 [[TMP40]], [[TMP26]]
; CHECK-NEXT:    br label [[FP_TO_I_CLEANUP]]
; CHECK:       fp-to-i-cleanup:
; CHECK-NEXT:    [[TMP42:%.*]] = phi i129 [ [[TMP34]], [[FP_TO_I_IF_THEN5]] ], [ [[TMP38]], [[FP_TO_I_IF_THEN12]] ], [ [[TMP41]], [[FP_TO_I_IF_ELSE]] ], [ 0, [[FP_TO_I_CLEANUP1]] ]
; CHECK-NEXT:    [[TMP43:%.*]] = insertelement <2 x i129> [[TMP21]], i129 [[TMP42]], i64 1
; CHECK-NEXT:    ret <2 x i129> [[TMP43]]
;
  %conv = fptosi <2 x float> %a to <2 x i129>
  ret <2 x i129> %conv
}

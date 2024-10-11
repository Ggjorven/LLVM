; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -codegenprepare %s | FileCheck %s
; Make sure BypassSlowDivision doesn't drop debug info

define i64 @sdiv64(i64 %a, i64 %b) {
; CHECK-LABEL: @sdiv64(
; CHECK-NEXT:    [[TMP1:%.*]] = or i64 [[A:%.*]], [[B:%.*]], [[DBG6:!dbg !.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], -4294967296, [[DBG6]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[TMP2]], 0, [[DBG6]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP4:%.*]], label [[TMP9:%.*]], [[DBG6]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i64 [[B]] to i32, [[DBG6]]
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i64 [[A]] to i32, [[DBG6]]
; CHECK-NEXT:    [[TMP7:%.*]] = udiv i32 [[TMP6]], [[TMP5]], [[DBG6]]
; CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64, [[DBG6]]
; CHECK-NEXT:    br label [[TMP11:%.*]], [[DBG6]]
; CHECK:       9:
; CHECK-NEXT:    [[TMP10:%.*]] = sdiv i64 [[A]], [[B]], [[DBG6]]
; CHECK-NEXT:    br label [[TMP11]], [[DBG6]]
; CHECK:       11:
; CHECK-NEXT:    [[TMP12:%.*]] = phi i64 [ [[TMP8]], [[TMP4]] ], [ [[TMP10]], [[TMP9]] ], [[DBG6]]
; CHECK-NEXT:    ret i64 [[TMP12]]
;
  %d = sdiv i64 %a, %b, !dbg !6
  ret i64 %d
}

; FIXME: The debugloc for the rem parts end up with the dbg of the
; division.
define <2 x i64> @sdivrem64(i64 %a, i64 %b) {
; CHECK-LABEL: @sdivrem64(
; CHECK-NEXT:    [[TMP1:%.*]] = or i64 [[A:%.*]], [[B:%.*]], [[DBG6]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], -4294967296, [[DBG6]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[TMP2]], 0, [[DBG6]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP4:%.*]], label [[TMP11:%.*]], [[DBG6]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i64 [[B]] to i32, [[DBG6]]
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i64 [[A]] to i32, [[DBG6]]
; CHECK-NEXT:    [[TMP7:%.*]] = udiv i32 [[TMP6]], [[TMP5]], [[DBG6]]
; CHECK-NEXT:    [[TMP8:%.*]] = urem i32 [[TMP6]], [[TMP5]], [[DBG6]]
; CHECK-NEXT:    [[TMP9:%.*]] = zext i32 [[TMP7]] to i64, [[DBG6]]
; CHECK-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP8]] to i64, [[DBG6]]
; CHECK-NEXT:    br label [[TMP14:%.*]], [[DBG6]]
; CHECK:       11:
; CHECK-NEXT:    [[TMP12:%.*]] = sdiv i64 [[A]], [[B]], [[DBG6]]
; CHECK-NEXT:    [[TMP13:%.*]] = srem i64 [[A]], [[B]], [[DBG6]]
; CHECK-NEXT:    br label [[TMP14]], [[DBG6]]
; CHECK:       14:
; CHECK-NEXT:    [[TMP15:%.*]] = phi i64 [ [[TMP9]], [[TMP4]] ], [ [[TMP12]], [[TMP11]] ], [[DBG6]]
; CHECK-NEXT:    [[TMP16:%.*]] = phi i64 [ [[TMP10]], [[TMP4]] ], [ [[TMP13]], [[TMP11]] ], [[DBG6]]
; CHECK-NEXT:    [[INS0:%.*]] = insertelement <2 x i64> poison, i64 [[TMP15]], i32 0
; CHECK-NEXT:    [[INS1:%.*]] = insertelement <2 x i64> [[INS0]], i64 [[TMP16]], i32 1
; CHECK-NEXT:    ret <2 x i64> [[INS1]]
;
  %d = sdiv i64 %a, %b, !dbg !6
  %r = srem i64 %a, %b, !dbg !10
  %ins0 = insertelement <2 x i64> poison, i64 %d, i32 0
  %ins1 = insertelement <2 x i64> %ins0, i64 %r, i32 1
  ret <2 x i64> %ins1
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 3.5 ", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, enums: !2, retainedTypes: !2, globals: !2, imports: !2)
!1 = !DIFile(filename: "basic.c", directory: ".")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 1, !"Debug Info Version", i32 3}
!5 = !{!"clang version 3.5 "}
!6 = !DILocation(line: 3, scope: !7)
!7 = distinct !DILexicalBlock(scope: !8, file: !1, line: 3)
!8 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !9, scopeLine: 1, virtualIndex: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !2)
!10 = !DILocation(line: 4, scope: !7)

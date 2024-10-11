; RUN: opt -passes=sroa -S %s -o - \
; RUN: | FileCheck %s --implicit-check-not="call void @llvm.dbg"
; RUN: opt --try-experimental-debuginfo-iterators -passes=sroa -S %s -o - \
; RUN: | FileCheck %s --implicit-check-not="call void @llvm.dbg"

;; Check that sroa removes redundant debug intrinsics after it makes a
;; change. This has a significant positive impact on peak memory and compiler
;; run time.

; CHECK: #dbg_assign(i32 1

define dso_local void @_Z3funv() local_unnamed_addr !dbg !7 {
entry:
  %sroa-remove-me = alloca i32
  call void @llvm.dbg.assign(metadata i32 undef, metadata !11, metadata !DIExpression(), metadata !13, metadata ptr undef, metadata !DIExpression()), !dbg !14
  call void @_Z3extv(), !dbg !15
  call void @llvm.dbg.assign(metadata i32 0, metadata !11, metadata !DIExpression(), metadata !13, metadata ptr undef, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.assign(metadata i32 1, metadata !11, metadata !DIExpression(), metadata !13, metadata ptr undef, metadata !DIExpression()), !dbg !14
  ret void, !dbg !16
}

declare !dbg !17 dso_local void @_Z3extv() local_unnamed_addr
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !1000}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 14.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test.cpp", directory: "/")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{!"clang version 14.0.0)"}
!7 = distinct !DISubprogram(name: "fun", linkageName: "_Z3funv", scope: !1, file: !1, line: 2, type: !8, scopeLine: 2, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !10)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !{!11}
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 2, type: !12)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = distinct !DIAssignID()
!14 = !DILocation(line: 0, scope: !7)
!15 = !DILocation(line: 2, column: 25, scope: !7)
!16 = !DILocation(line: 2, column: 32, scope: !7)
!17 = !DISubprogram(name: "ext", linkageName: "_Z3extv", scope: !1, file: !1, line: 1, type: !8, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !18)
!18 = !{}
!1000 = !{i32 7, !"debug-info-assignment-tracking", i1 true}

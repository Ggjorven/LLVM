; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='instcombine' -S | FileCheck %s
; RUN: opt < %s -passes='instcombine' -S --try-experimental-debuginfo-iterators | FileCheck %s


define i32 @foo(<vscale x 2 x i32> %x) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARR:%.*]] = alloca i32, align 4
; CHECK-NEXT:      #dbg_value(<vscale x 2 x i32> poison, [[META8:![0-9]+]], !DIExpression(), [[META14:![0-9]+]])
; CHECK-NEXT:    store <vscale x 2 x i32> [[X:%.*]], ptr [[ARR]], align 4
; CHECK-NEXT:    [[RES:%.*]] = load i32, ptr [[ARR]], align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %arr = alloca i32, align 4
  call void @llvm.dbg.declare(metadata ptr %arr, metadata !8, metadata !DIExpression()), !dbg !14
  store <vscale x 2 x i32> %x, ptr %arr, align 4
  %res = load i32, ptr %arr
  ret i32 %res
}

define i32 @foo2(<vscale x 2 x i32> %x) {
; CHECK-LABEL: @foo2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARR:%.*]] = alloca [4 x i32], align 4
; CHECK-NEXT:      #dbg_declare(ptr [[ARR]], [[META15:![0-9]+]], !DIExpression(), [[META17:![0-9]+]])
; CHECK-NEXT:    store <vscale x 2 x i32> [[X:%.*]], ptr [[ARR]], align 4
; CHECK-NEXT:    [[RES:%.*]] = load i32, ptr [[ARR]], align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %arr = alloca [4 x i32], align 4
  call void @llvm.dbg.declare(metadata ptr %arr, metadata !15, metadata !DIExpression()), !dbg !17
  store <vscale x 2 x i32> %x, ptr %arr, align 4
  %res = load i32, ptr %arr
  ret i32 %res
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 17.0.0 (git@github.com:llvm/llvm-project.git a489e11439e36c7e0ec83b28a6fb1596a5c21faa)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "u.cpp", directory: "/path/to/test", checksumkind: CSK_MD5, checksum: "42f62c17fb0f0110f515890bc6d69cb5")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 5}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 1, !"target-abi", !"lp64d"}
!7 = !{i32 8, !"SmallDataLimit", i32 8}
!8 = !DILocalVariable(name: "arr", scope: !9, file: !1, line: 3, type: !12)
!9 = distinct !DISubprogram(name: "foo", linkageName: "foo", scope: !1, file: !1, line: 2, type: !10, scopeLine: 2, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null}
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 128, elements: !2)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocation(line: 3, column: 7, scope: !9)
!15 = !DILocalVariable(name: "arr", scope: !16, file: !1, line: 6, type: !12)
!16 = distinct !DISubprogram(name: "foo2", linkageName: "foo2", scope: !1, file: !1, line: 5, type: !10, scopeLine: 5, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!17 = !DILocation(line: 6, column: 7, scope: !16)

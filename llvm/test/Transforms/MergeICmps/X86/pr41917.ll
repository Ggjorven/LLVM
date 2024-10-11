; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=mergeicmps -verify-dom-info -S | FileCheck %s

target datalayout = "e-m:x-p:32:32-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i386-pc-windows-msvc19.11.0"

%class.a = type { i32, i32, i32, i32, i32 }

; Function Attrs: nounwind optsize
define dso_local zeroext i1 @pr41917(ptr byval(%class.a) nocapture readonly align 4 %g, ptr byval(%class.a) nocapture readonly align 4 %p2) local_unnamed_addr #0 {
; CHECK-LABEL: @pr41917(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call zeroext i1 @f2() #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    br i1 [[CALL]], label [[LAND_RHS:%.*]], label %"land.end+land.rhs3"
; CHECK:       land.rhs:
; CHECK-NEXT:    [[CALL1:%.*]] = tail call zeroext i1 @f2() #[[ATTR3]]
; CHECK-NEXT:    br label %"land.end+land.rhs3"
; CHECK:       "land.end+land.rhs3":
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[CLASS_A:%.*]], ptr [[G:%.*]], i32 0, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[CLASS_A]], ptr [[P2:%.*]], i32 0, i32 1
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(ptr [[TMP0]], ptr [[TMP1]], i32 8)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[MEMCMP]], 0
; CHECK-NEXT:    br label [[LAND_END6:%.*]]
; CHECK:       land.end6:
; CHECK-NEXT:    ret i1 [[TMP2]]
;
entry:
  %call = tail call zeroext i1 @f2() #2
  br i1 %call, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  %call1 = tail call zeroext i1 @f2() #2
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %c = getelementptr inbounds %class.a, ptr %g, i32 0, i32 1
  %0 = load i32, ptr %c, align 4, !tbaa !3
  %c2 = getelementptr inbounds %class.a, ptr %p2, i32 0, i32 1
  %1 = load i32, ptr %c2, align 4, !tbaa !3
  %cmp = icmp eq i32 %0, %1
  br i1 %cmp, label %land.rhs3, label %land.end6

land.rhs3:                                        ; preds = %land.end
  %h = getelementptr inbounds %class.a, ptr %g, i32 0, i32 2
  %2 = load i32, ptr %h, align 4, !tbaa !8
  %h4 = getelementptr inbounds %class.a, ptr %p2, i32 0, i32 2
  %3 = load i32, ptr %h4, align 4, !tbaa !8
  %cmp5 = icmp eq i32 %2, %3
  br label %land.end6

land.end6:                                        ; preds = %land.rhs3, %land.end
  %4 = phi i1 [ false, %land.end ], [ %cmp5, %land.rhs3 ]
  ret i1 %4
}

declare dso_local zeroext i1 @f2() local_unnamed_addr #1

attributes #0 = { nounwind optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "frame-pointer"="none" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+cx8,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { optsize "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "frame-pointer"="none" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+cx8,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 1a8630ac2839d0e73fd3b15dc38501e4c6525a7e)"}
!3 = !{!4, !5, i64 4}
!4 = !{!"?AVa@@", !5, i64 0, !5, i64 4, !5, i64 8, !5, i64 12, !5, i64 16}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
!8 = !{!4, !5, i64 8}

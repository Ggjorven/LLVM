; RUN: opt --bpf-check-and-opt-ir -mtriple=bpf-pc-linux -S -o - %s | FileCheck %s
;
; Check that unroll of getelementptr.and.load restores volatile.
;
; Source:
;    #define __ctx __attribute__((preserve_static_offset))
;    
;    struct foo {
;      int a;
;      volatile int b;
;    } __ctx;
;    
;    extern void consume(int);
;    
;    void bar(struct foo *p){
;      consume(p->b);
;    }
;
; Compilation flag:
;   clang -cc1 -O2 -triple bpf -S -emit-llvm -disable-llvm-passes -o - \
;       | opt -passes=sroa,bpf-preserve-static-offset -S -o -

%struct.foo = type { i32, i32 }

; Function Attrs: nounwind
define dso_local void @bar(ptr noundef %p) #0 {
entry:
  %b1 = call i32 (ptr, i1, i8, i8, i8, i1, ...)
    @llvm.bpf.getelementptr.and.load.i32
      (ptr elementtype(%struct.foo) %p,
       i1 true, i8 0, i8 1, i8 2, i1 true, i32 immarg 0, i32 immarg 1),
    !tbaa !2
  call void @consume(i32 noundef %b1)
  ret void
}

; CHECK: define dso_local void @bar(ptr noundef %[[p:.*]])
; CHECK:   %[[b11:.*]] = getelementptr inbounds %struct.foo, ptr %[[p]], i32 0, i32 1
; CHECK:   %[[v2:.*]] = load volatile i32, ptr %[[b11]], align 4
; CHECK:   call void @consume(i32 noundef %[[v2]])

declare void @consume(i32 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare ptr @llvm.preserve.static.offset(ptr readnone) #2

; Function Attrs: nocallback nofree nounwind willreturn
declare i32 @llvm.bpf.getelementptr.and.load.i32(ptr nocapture, i1 immarg, i8 immarg, i8 immarg, i8 immarg, i1 immarg, ...) #3

attributes #0 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang"}
!2 = !{!3, !4, i64 4}
!3 = !{!"foo", !4, i64 0, !4, i64 4}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}

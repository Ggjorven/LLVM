; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu  < %s | FileCheck %s

define void @test() {
; CHECK-LABEL: define void @test() {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br label %[[CONT608:.*]]
; CHECK:       [[CONT221_THREAD781:.*]]:
; CHECK-NEXT:    br label %[[CONT608]]
; CHECK:       [[CONT608]]:
; CHECK-NEXT:    [[TMP0:%.*]] = phi <2 x i1> [ poison, %[[CONT221_THREAD781]] ], [ zeroinitializer, %[[ENTRY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <2 x i1> [[TMP0]], <2 x i1> poison, <4 x i32> <i32 0, i32 0, i32 0, i32 1>
; CHECK-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP1]], <4 x i1> zeroinitializer, <4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = call <8 x i1> @llvm.vector.insert.v8i1.v4i1(<8 x i1> <i1 poison, i1 poison, i1 poison, i1 poison, i1 false, i1 false, i1 false, i1 false>, <4 x i1> [[TMP3]], i64 0)
; CHECK-NEXT:    [[TMP5:%.*]] = select <8 x i1> [[TMP4]], <8 x i64> zeroinitializer, <8 x i64> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = call i64 @llvm.vector.reduce.or.v8i64(<8 x i64> [[TMP5]])
; CHECK-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP6]], 0
; CHECK-NEXT:    store i64 [[OP_RDX]], ptr null, align 8
; CHECK-NEXT:    ret void
;
entry:
  br label %cont608

cont221.thread781:
  %cmp215784 = icmp eq i32 0, 0
  br label %cont608

cont608:
  %0 = phi i1 [ %cmp215784, %cont221.thread781 ], [ false, %entry ]
  %1 = phi i1 [ false, %cont221.thread781 ], [ false, %entry ]
  %bf.shl242 = select i1 false, i64 0, i64 0
  %bf.shl260 = select i1 false, i64 0, i64 0
  %bf.set262 = or i64 %bf.shl242, %bf.shl260
  %2 = select i1 %1, i1 false, i1 false
  %bf.shl292 = select i1 %2, i64 0, i64 0
  %bf.set305 = or i64 %bf.shl292, 0
  %bf.set316 = or i64 %bf.set305, %bf.set262
  %bf.shl362 = select i1 false, i64 0, i64 0
  %bf.shl380 = select i1 false, i64 0, i64 0
  %3 = select i1 %0, i1 false, i1 false
  %bf.shl416 = select i1 %3, i64 0, i64 0
  %4 = select i1 %0, i1 false, i1 false
  %bf.shl434 = select i1 %4, i64 0, i64 0
  %bf.set418 = or i64 %bf.shl416, %bf.shl434
  %5 = select i1 %0, i1 false, i1 false
  %bf.shl560 = select i1 %5, i64 0, i64 0
  %bf.set584 = or i64 %bf.shl560, 0
  %bf1 = or i64 %bf.set316, %bf.shl362
  %bf2 = or i64 %bf1, %bf.shl380
  %bf3 = or i64 %bf.set418, %bf2
  %bf.clear612 = or i64 %bf.set584, %bf3
  store i64 %bf.clear612, ptr null, align 8
  ret void
}

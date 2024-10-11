; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=x86_64-- -O2 | FileCheck %s

; This test verifies the fix for PR33368.
;
; The expected outcome of the operation is to store bytes 0 and 2 of the incoming
; parameter into c2 (a 2 x i8 vector). DAGCombine converts shuffles into a
; sequence of extend and subsequent truncate operations. The bug was that an extension
; by 4 followed by a truncation by 8 was completely eliminated.

; The test checks for the correct sequence of operations that results from the
; preservation of the extend/truncate operations mentioned above (2 extend and
; 3 truncate instructions).
;
; NOTE: This operation could be collapsed in to a single truncate. Once that is done
; this test will have to be adjusted.

define void @test(double %vec.coerce) local_unnamed_addr {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-NEXT:    packuswb %xmm0, %xmm0
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    retq
entry:
  %c2 = alloca <2 x i8>, align 2
  %0 = bitcast double %vec.coerce to <8 x i8>
  %1 = shufflevector <8 x i8> %0, <8 x i8> undef, <4 x i32> <i32 2, i32 undef, i32 undef, i32 0>
  %2 = shufflevector <4 x i8> %1, <4 x i8> undef, <2 x i32> <i32 3, i32 0>
  store volatile <2 x i8> %2, ptr %c2, align 2
  br label %if.end

if.end:
  %3 = bitcast <2 x i8> %2 to i16
  ret void
}

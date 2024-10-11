; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck %s --check-prefix=LA64

declare void @bar()

define void @bnez_i32(i32 signext %0) nounwind {
; LA32-LABEL: bnez_i32:
; LA32:       # %bb.0: # %start
; LA32-NEXT:    beqz $a0, .LBB0_2
; LA32-NEXT:  # %bb.1: # %f
; LA32-NEXT:    ret
; LA32-NEXT:  .LBB0_2: # %t
; LA32-NEXT:    b %plt(bar)
;
; LA64-LABEL: bnez_i32:
; LA64:       # %bb.0: # %start
; LA64-NEXT:    beqz $a0, .LBB0_2
; LA64-NEXT:  # %bb.1: # %f
; LA64-NEXT:    ret
; LA64-NEXT:  .LBB0_2: # %t
; LA64-NEXT:    b %plt(bar)
start:
  %1 = icmp eq i32 %0, 0
  br i1 %1, label %t, label %f

t:
  tail call void @bar()
  br label %f

f:
  ret void
}

define void @beqz_i32(i32 signext %0) nounwind {
; LA32-LABEL: beqz_i32:
; LA32:       # %bb.0: # %start
; LA32-NEXT:    beqz $a0, .LBB1_2
; LA32-NEXT:  # %bb.1: # %t
; LA32-NEXT:    b %plt(bar)
; LA32-NEXT:  .LBB1_2: # %f
; LA32-NEXT:    ret
;
; LA64-LABEL: beqz_i32:
; LA64:       # %bb.0: # %start
; LA64-NEXT:    beqz $a0, .LBB1_2
; LA64-NEXT:  # %bb.1: # %t
; LA64-NEXT:    b %plt(bar)
; LA64-NEXT:  .LBB1_2: # %f
; LA64-NEXT:    ret
start:
  %1 = icmp ne i32 %0, 0
  br i1 %1, label %t, label %f

t:
  tail call void @bar()
  br label %f

f:
  ret void
}

define void @bnez_i64(i64 %0) nounwind {
; LA32-LABEL: bnez_i64:
; LA32:       # %bb.0: # %start
; LA32-NEXT:    or $a0, $a0, $a1
; LA32-NEXT:    beqz $a0, .LBB2_2
; LA32-NEXT:  # %bb.1: # %f
; LA32-NEXT:    ret
; LA32-NEXT:  .LBB2_2: # %t
; LA32-NEXT:    b %plt(bar)
;
; LA64-LABEL: bnez_i64:
; LA64:       # %bb.0: # %start
; LA64-NEXT:    beqz $a0, .LBB2_2
; LA64-NEXT:  # %bb.1: # %f
; LA64-NEXT:    ret
; LA64-NEXT:  .LBB2_2: # %t
; LA64-NEXT:    b %plt(bar)
start:
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %t, label %f

t:
  tail call void @bar()
  br label %f

f:
  ret void
}

define void @beqz_i64(i64 %0) nounwind {
; LA32-LABEL: beqz_i64:
; LA32:       # %bb.0: # %start
; LA32-NEXT:    or $a0, $a0, $a1
; LA32-NEXT:    beqz $a0, .LBB3_2
; LA32-NEXT:  # %bb.1: # %t
; LA32-NEXT:    b %plt(bar)
; LA32-NEXT:  .LBB3_2: # %f
; LA32-NEXT:    ret
;
; LA64-LABEL: beqz_i64:
; LA64:       # %bb.0: # %start
; LA64-NEXT:    beqz $a0, .LBB3_2
; LA64-NEXT:  # %bb.1: # %t
; LA64-NEXT:    b %plt(bar)
; LA64-NEXT:  .LBB3_2: # %f
; LA64-NEXT:    ret
start:
  %1 = icmp ne i64 %0, 0
  br i1 %1, label %t, label %f

t:
  tail call void @bar()
  br label %f

f:
  ret void
}

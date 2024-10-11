; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d --verify-machineinstrs < %s \
; RUN:    | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 -mattr=+d --verify-machineinstrs < %s \
; RUN:    | FileCheck %s --check-prefix=LA64

declare void @foo(ptr %p);
declare void @bar(ptr %p);
declare dso_local i32 @__gxx_personality_v0(...)

;; Before getExceptionPointerRegister() and getExceptionSelectorRegister()
;; lowering hooks were defined this would trigger an assertion during live
;; variable analysis.

define void @caller(ptr %p) personality ptr @__gxx_personality_v0 {
; LA32-LABEL: caller:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    st.w $fp, $sp, 8 # 4-byte Folded Spill
; LA32-NEXT:    st.w $s0, $sp, 4 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    .cfi_offset 22, -8
; LA32-NEXT:    .cfi_offset 23, -12
; LA32-NEXT:    move $fp, $a0
; LA32-NEXT:    beqz $a0, .LBB0_2
; LA32-NEXT:  # %bb.1: # %bb2
; LA32-NEXT:  .Ltmp0:
; LA32-NEXT:    move $a0, $fp
; LA32-NEXT:    bl %plt(bar)
; LA32-NEXT:  .Ltmp1:
; LA32-NEXT:    b .LBB0_3
; LA32-NEXT:  .LBB0_2: # %bb1
; LA32-NEXT:  .Ltmp2:
; LA32-NEXT:    move $a0, $fp
; LA32-NEXT:    bl %plt(foo)
; LA32-NEXT:  .Ltmp3:
; LA32-NEXT:  .LBB0_3: # %end2
; LA32-NEXT:    ld.w $s0, $sp, 4 # 4-byte Folded Reload
; LA32-NEXT:    ld.w $fp, $sp, 8 # 4-byte Folded Reload
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
; LA32-NEXT:  .LBB0_4: # %lpad
; LA32-NEXT:  .Ltmp4:
; LA32-NEXT:    move $s0, $a0
; LA32-NEXT:    move $a0, $fp
; LA32-NEXT:    bl callee
; LA32-NEXT:    move $a0, $s0
; LA32-NEXT:    bl %plt(_Unwind_Resume)
;
; LA64-LABEL: caller:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    addi.d $sp, $sp, -32
; LA64-NEXT:    .cfi_def_cfa_offset 32
; LA64-NEXT:    st.d $ra, $sp, 24 # 8-byte Folded Spill
; LA64-NEXT:    st.d $fp, $sp, 16 # 8-byte Folded Spill
; LA64-NEXT:    st.d $s0, $sp, 8 # 8-byte Folded Spill
; LA64-NEXT:    .cfi_offset 1, -8
; LA64-NEXT:    .cfi_offset 22, -16
; LA64-NEXT:    .cfi_offset 23, -24
; LA64-NEXT:    move $fp, $a0
; LA64-NEXT:    beqz $a0, .LBB0_2
; LA64-NEXT:  # %bb.1: # %bb2
; LA64-NEXT:  .Ltmp0:
; LA64-NEXT:    move $a0, $fp
; LA64-NEXT:    bl %plt(bar)
; LA64-NEXT:  .Ltmp1:
; LA64-NEXT:    b .LBB0_3
; LA64-NEXT:  .LBB0_2: # %bb1
; LA64-NEXT:  .Ltmp2:
; LA64-NEXT:    move $a0, $fp
; LA64-NEXT:    bl %plt(foo)
; LA64-NEXT:  .Ltmp3:
; LA64-NEXT:  .LBB0_3: # %end2
; LA64-NEXT:    ld.d $s0, $sp, 8 # 8-byte Folded Reload
; LA64-NEXT:    ld.d $fp, $sp, 16 # 8-byte Folded Reload
; LA64-NEXT:    ld.d $ra, $sp, 24 # 8-byte Folded Reload
; LA64-NEXT:    addi.d $sp, $sp, 32
; LA64-NEXT:    ret
; LA64-NEXT:  .LBB0_4: # %lpad
; LA64-NEXT:  .Ltmp4:
; LA64-NEXT:    move $s0, $a0
; LA64-NEXT:    move $a0, $fp
; LA64-NEXT:    bl callee
; LA64-NEXT:    move $a0, $s0
; LA64-NEXT:    bl %plt(_Unwind_Resume)
entry:
  %0 = icmp eq ptr %p, null
  br i1 %0, label %bb1, label %bb2

bb1:
  invoke void @foo(ptr %p) to label %end1 unwind label %lpad

bb2:
  invoke void @bar(ptr %p) to label %end2 unwind label %lpad

lpad:
  %1 = landingpad { ptr, i32 } cleanup
  call void @callee(ptr %p)
  resume { ptr, i32 } %1

end1:
  ret void

end2:
  ret void
}

define internal void @callee(ptr %p) {
; LA32-LABEL: callee:
; LA32:       # %bb.0:
; LA32-NEXT:    ret
;
; LA64-LABEL: callee:
; LA64:       # %bb.0:
; LA64-NEXT:    ret
  ret void
}

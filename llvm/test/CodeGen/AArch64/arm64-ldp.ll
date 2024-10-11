; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-eabi -verify-machineinstrs | FileCheck %s

define i32 @ldp_int(ptr %p) nounwind {
; CHECK-LABEL: ldp_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w8, w9, [x0]
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
  %tmp = load i32, ptr %p, align 4
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  %tmp1 = load i32, ptr %add.ptr, align 4
  %add = add nsw i32 %tmp1, %tmp
  ret i32 %add
}

define i64 @ldp_sext_int(ptr %p) nounwind {
; CHECK-LABEL: ldp_sext_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldpsw x8, x9, [x0]
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %tmp = load i32, ptr %p, align 4
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  %tmp1 = load i32, ptr %add.ptr, align 4
  %sexttmp = sext i32 %tmp to i64
  %sexttmp1 = sext i32 %tmp1 to i64
  %add = add nsw i64 %sexttmp1, %sexttmp
  ret i64 %add
}

define i64 @ldp_half_sext_res0_int(ptr %p) nounwind {
; CHECK-LABEL: ldp_half_sext_res0_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w8, w9, [x0]
; CHECK-NEXT:    // kill: def $w8 killed $w8 def $x8
; CHECK-NEXT:    sxtw x8, w8
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %tmp = load i32, ptr %p, align 4
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  %tmp1 = load i32, ptr %add.ptr, align 4
  %sexttmp = sext i32 %tmp to i64
  %sexttmp1 = zext i32 %tmp1 to i64
  %add = add nsw i64 %sexttmp1, %sexttmp
  ret i64 %add
}

define i64 @ldp_half_sext_res1_int(ptr %p) nounwind {
; CHECK-LABEL: ldp_half_sext_res1_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w8, w9, [x0]
; CHECK-NEXT:    // kill: def $w9 killed $w9 def $x9
; CHECK-NEXT:    sxtw x9, w9
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %tmp = load i32, ptr %p, align 4
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  %tmp1 = load i32, ptr %add.ptr, align 4
  %sexttmp = zext i32 %tmp to i64
  %sexttmp1 = sext i32 %tmp1 to i64
  %add = add nsw i64 %sexttmp1, %sexttmp
  ret i64 %add
}


define i64 @ldp_long(ptr %p) nounwind {
; CHECK-LABEL: ldp_long:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp x8, x9, [x0]
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %tmp = load i64, ptr %p, align 8
  %add.ptr = getelementptr inbounds i64, ptr %p, i64 1
  %tmp1 = load i64, ptr %add.ptr, align 8
  %add = add nsw i64 %tmp1, %tmp
  ret i64 %add
}

define float @ldp_float(ptr %p) nounwind {
; CHECK-LABEL: ldp_float:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp s0, s1, [x0]
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %tmp = load float, ptr %p, align 4
  %add.ptr = getelementptr inbounds float, ptr %p, i64 1
  %tmp1 = load float, ptr %add.ptr, align 4
  %add = fadd float %tmp, %tmp1
  ret float %add
}

define double @ldp_double(ptr %p) nounwind {
; CHECK-LABEL: ldp_double:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp d0, d1, [x0]
; CHECK-NEXT:    fadd d0, d0, d1
; CHECK-NEXT:    ret
  %tmp = load double, ptr %p, align 8
  %add.ptr = getelementptr inbounds double, ptr %p, i64 1
  %tmp1 = load double, ptr %add.ptr, align 8
  %add = fadd double %tmp, %tmp1
  ret double %add
}

define <2 x double> @ldp_doublex2(ptr %p) nounwind {
; CHECK-LABEL: ldp_doublex2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    fadd v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
  %tmp = load <2 x double>, ptr %p, align 16
  %add.ptr = getelementptr inbounds <2 x double>, ptr %p, i64 1
  %tmp1 = load <2 x double>, ptr %add.ptr, align 16
  %add = fadd <2 x double> %tmp, %tmp1
  ret <2 x double> %add
}

; Test the load/store optimizer---combine ldurs into a ldp, if appropriate
define i32 @ldur_int(ptr %a) nounwind {
; CHECK-LABEL: ldur_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w9, w8, [x0, #-8]
; CHECK-NEXT:    add w0, w8, w9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i32 -1
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i32 -2
  %tmp2 = load i32, ptr %p2, align 2
  %tmp3 = add i32 %tmp1, %tmp2
  ret i32 %tmp3
}

define i64 @ldur_sext_int(ptr %a) nounwind {
; CHECK-LABEL: ldur_sext_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldpsw x9, x8, [x0, #-8]
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i32 -1
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i32 -2
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = sext i32 %tmp1 to i64
  %sexttmp2 = sext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}

define i64 @ldur_half_sext_int_res0(ptr %a) nounwind {
; CHECK-LABEL: ldur_half_sext_int_res0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w9, w8, [x0, #-8]
; CHECK-NEXT:    // kill: def $w9 killed $w9 def $x9
; CHECK-NEXT:    sxtw x9, w9
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i32 -1
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i32 -2
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = zext i32 %tmp1 to i64
  %sexttmp2 = sext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}

define i64 @ldur_half_sext_int_res1(ptr %a) nounwind {
; CHECK-LABEL: ldur_half_sext_int_res1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w9, w8, [x0, #-8]
; CHECK-NEXT:    // kill: def $w8 killed $w8 def $x8
; CHECK-NEXT:    sxtw x8, w8
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i32 -1
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i32 -2
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = sext i32 %tmp1 to i64
  %sexttmp2 = zext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}


define i64 @ldur_long(ptr %a) nounwind ssp {
; CHECK-LABEL: ldur_long:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp x9, x8, [x0, #-16]
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i64, ptr %a, i64 -1
  %tmp1 = load i64, ptr %p1, align 2
  %p2 = getelementptr inbounds i64, ptr %a, i64 -2
  %tmp2 = load i64, ptr %p2, align 2
  %tmp3 = add i64 %tmp1, %tmp2
  ret i64 %tmp3
}

define float @ldur_float(ptr %a) {
; CHECK-LABEL: ldur_float:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp s1, s0, [x0, #-8]
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds float, ptr %a, i64 -1
  %tmp1 = load float, ptr %p1, align 2
  %p2 = getelementptr inbounds float, ptr %a, i64 -2
  %tmp2 = load float, ptr %p2, align 2
  %tmp3 = fadd float %tmp1, %tmp2
  ret float %tmp3
}

define double @ldur_double(ptr %a) {
; CHECK-LABEL: ldur_double:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp d1, d0, [x0, #-16]
; CHECK-NEXT:    fadd d0, d0, d1
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds double, ptr %a, i64 -1
  %tmp1 = load double, ptr %p1, align 2
  %p2 = getelementptr inbounds double, ptr %a, i64 -2
  %tmp2 = load double, ptr %p2, align 2
  %tmp3 = fadd double %tmp1, %tmp2
  ret double %tmp3
}

define <2 x double> @ldur_doublex2(ptr %a) {
; CHECK-LABEL: ldur_doublex2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0, #-32]
; CHECK-NEXT:    fadd v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds <2 x double>, ptr %a, i64 -1
  %tmp1 = load <2 x double>, ptr %p1, align 2
  %p2 = getelementptr inbounds <2 x double>, ptr %a, i64 -2
  %tmp2 = load <2 x double>, ptr %p2, align 2
  %tmp3 = fadd <2 x double> %tmp1, %tmp2
  ret <2 x double> %tmp3
}

; Now check some boundary conditions
define i64 @pairUpBarelyIn(ptr %a) nounwind ssp {
; CHECK-LABEL: pairUpBarelyIn:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp x9, x8, [x0, #-256]
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i64, ptr %a, i64 -31
  %tmp1 = load i64, ptr %p1, align 2
  %p2 = getelementptr inbounds i64, ptr %a, i64 -32
  %tmp2 = load i64, ptr %p2, align 2
  %tmp3 = add i64 %tmp1, %tmp2
  ret i64 %tmp3
}

define i64 @pairUpBarelyInSext(ptr %a) nounwind ssp {
; CHECK-LABEL: pairUpBarelyInSext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldpsw x9, x8, [x0, #-256]
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i64 -63
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i64 -64
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = sext i32 %tmp1 to i64
  %sexttmp2 = sext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}

define i64 @pairUpBarelyInHalfSextRes0(ptr %a) nounwind ssp {
; CHECK-LABEL: pairUpBarelyInHalfSextRes0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w9, w8, [x0, #-256]
; CHECK-NEXT:    // kill: def $w9 killed $w9 def $x9
; CHECK-NEXT:    sxtw x9, w9
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i64 -63
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i64 -64
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = zext i32 %tmp1 to i64
  %sexttmp2 = sext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}

define i64 @pairUpBarelyInHalfSextRes1(ptr %a) nounwind ssp {
; CHECK-LABEL: pairUpBarelyInHalfSextRes1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp w9, w8, [x0, #-256]
; CHECK-NEXT:    // kill: def $w8 killed $w8 def $x8
; CHECK-NEXT:    sxtw x8, w8
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i64 -63
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i64 -64
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = sext i32 %tmp1 to i64
  %sexttmp2 = zext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}

define i64 @pairUpBarelyOut(ptr %a) nounwind ssp {
; Don't be fragile about which loads or manipulations of the base register
; are used---just check that there isn't an ldp before the add
; CHECK-LABEL: pairUpBarelyOut:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x0, #264
; CHECK-NEXT:    ldur x9, [x0, #-256]
; CHECK-NEXT:    ldr x8, [x8]
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i64, ptr %a, i64 -32
  %tmp1 = load i64, ptr %p1, align 2
  %p2 = getelementptr inbounds i64, ptr %a, i64 -33
  %tmp2 = load i64, ptr %p2, align 2
  %tmp3 = add i64 %tmp1, %tmp2
  ret i64 %tmp3
}

define i64 @pairUpBarelyOutSext(ptr %a) nounwind ssp {
; Don't be fragile about which loads or manipulations of the base register
; are used---just check that there isn't an ldp before the add
; CHECK-LABEL: pairUpBarelyOutSext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x0, #260
; CHECK-NEXT:    ldursw x9, [x0, #-256]
; CHECK-NEXT:    ldrsw x8, [x8]
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i64 -64
  %tmp1 = load i32, ptr %p1, align 2
  %p2 = getelementptr inbounds i32, ptr %a, i64 -65
  %tmp2 = load i32, ptr %p2, align 2
  %sexttmp1 = sext i32 %tmp1 to i64
  %sexttmp2 = sext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
  ret i64 %tmp3
}

define i64 @pairUpNotAligned(ptr %a) nounwind ssp {
; CHECK-LABEL: pairUpNotAligned:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur x8, [x0, #-143]
; CHECK-NEXT:    ldur x9, [x0, #-135]
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i64, ptr %a, i64 -18
  %bp1 = bitcast ptr %p1 to ptr
  %bp1p1 = getelementptr inbounds i8, ptr %bp1, i64 1
  %dp1 = bitcast ptr %bp1p1 to ptr
  %tmp1 = load i64, ptr %dp1, align 1

  %p2 = getelementptr inbounds i64, ptr %a, i64 -17
  %bp2 = bitcast ptr %p2 to ptr
  %bp2p1 = getelementptr inbounds i8, ptr %bp2, i64 1
  %dp2 = bitcast ptr %bp2p1 to ptr
  %tmp2 = load i64, ptr %dp2, align 1

  %tmp3 = add i64 %tmp1, %tmp2
  ret i64 %tmp3
}

define i64 @pairUpNotAlignedSext(ptr %a) nounwind ssp {
; CHECK-LABEL: pairUpNotAlignedSext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldursw x8, [x0, #-71]
; CHECK-NEXT:    ldursw x9, [x0, #-67]
; CHECK-NEXT:    add x0, x8, x9
; CHECK-NEXT:    ret
  %p1 = getelementptr inbounds i32, ptr %a, i64 -18
  %bp1 = bitcast ptr %p1 to ptr
  %bp1p1 = getelementptr inbounds i8, ptr %bp1, i64 1
  %dp1 = bitcast ptr %bp1p1 to ptr
  %tmp1 = load i32, ptr %dp1, align 1

  %p2 = getelementptr inbounds i32, ptr %a, i64 -17
  %bp2 = bitcast ptr %p2 to ptr
  %bp2p1 = getelementptr inbounds i8, ptr %bp2, i64 1
  %dp2 = bitcast ptr %bp2p1 to ptr
  %tmp2 = load i32, ptr %dp2, align 1

  %sexttmp1 = sext i32 %tmp1 to i64
  %sexttmp2 = sext i32 %tmp2 to i64
  %tmp3 = add i64 %sexttmp1, %sexttmp2
 ret i64 %tmp3
}

declare void @use-ptr(ptr)

define i64 @ldp_sext_int_pre(ptr %p) nounwind {
; CHECK-LABEL: ldp_sext_int_pre:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x30, x19, [sp, #-16]! // 16-byte Folded Spill
; CHECK-NEXT:    mov x19, x0
; CHECK-NEXT:    add x0, x0, #8
; CHECK-NEXT:    bl "use-ptr"
; CHECK-NEXT:    ldpsw x8, x9, [x19, #8]
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ldp x30, x19, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  %ptr = getelementptr inbounds i32, ptr %p, i64 2
  call void @use-ptr(ptr %ptr)
  %add.ptr = getelementptr inbounds i32, ptr %ptr, i64 0
  %tmp = load i32, ptr %add.ptr, align 4
  %add.ptr1 = getelementptr inbounds i32, ptr %ptr, i64 1
  %tmp1 = load i32, ptr %add.ptr1, align 4
  %sexttmp = sext i32 %tmp to i64
  %sexttmp1 = sext i32 %tmp1 to i64
  %add = add nsw i64 %sexttmp1, %sexttmp
  ret i64 %add
}

define i64 @ldp_sext_int_post(ptr %p) nounwind {
; CHECK-LABEL: ldp_sext_int_post:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-32]! // 8-byte Folded Spill
; CHECK-NEXT:    stp x20, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    ldpsw x19, x20, [x0], #8
; CHECK-NEXT:    bl "use-ptr"
; CHECK-NEXT:    add x0, x20, x19
; CHECK-NEXT:    ldp x20, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp], #32 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %tmp = load i32, ptr %p, align 4
  %add.ptr = getelementptr inbounds i32, ptr %p, i64 1
  %tmp1 = load i32, ptr %add.ptr, align 4
  %sexttmp = sext i32 %tmp to i64
  %sexttmp1 = sext i32 %tmp1 to i64
  %ptr = getelementptr inbounds i32, ptr %add.ptr, i64 1
  call void @use-ptr(ptr %ptr)
  %add = add nsw i64 %sexttmp1, %sexttmp
  ret i64 %add
}


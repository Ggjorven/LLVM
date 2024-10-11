; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 -mtriple=riscv32 -mattr=+xcvmem -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK

define <2 x i32> @lb_ri_inc(i8* %a) {
; CHECK-LABEL: lb_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lb a1, (a0), 42
; CHECK-NEXT:    ret
  %1 = load i8, i8* %a
  %2 = sext i8 %1 to i32
  %3 = getelementptr i8, i8* %a, i32 42
  %4 = ptrtoint i8* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define <2 x i32> @lb_rr_inc(i8* %a, i32 %b) {
; CHECK-LABEL: lb_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lb a1, (a0), a1
; CHECK-NEXT:    ret
  %1 = load i8, i8* %a
  %2 = sext i8 %1 to i32
  %3 = getelementptr i8, i8* %a, i32 %b
  %4 = ptrtoint i8* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define i32 @lb_rr(i8* %a, i32 %b) {
; CHECK-LABEL: lb_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lb a0, a1(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i8, i8* %a, i32 %b
  %2 = load i8, i8* %1
  %3 = sext i8 %2 to i32
  ret i32 %3
}

define <2 x i32> @lbu_ri_inc(i8* %a) {
; CHECK-LABEL: lbu_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lbu a1, (a0), 42
; CHECK-NEXT:    ret
  %1 = load i8, i8* %a
  %2 = zext i8 %1 to i32
  %3 = getelementptr i8, i8* %a, i32 42
  %4 = ptrtoint i8* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define <2 x i32> @lbu_rr_inc(i8* %a, i32 %b) {
; CHECK-LABEL: lbu_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lbu a1, (a0), a1
; CHECK-NEXT:    ret
  %1 = load i8, i8* %a
  %2 = zext i8 %1 to i32
  %3 = getelementptr i8, i8* %a, i32 %b
  %4 = ptrtoint i8* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define i32 @lbu_rr(i8* %a, i32 %b) {
; CHECK-LABEL: lbu_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lbu a0, a1(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i8, i8* %a, i32 %b
  %2 = load i8, i8* %1
  %3 = zext i8 %2 to i32
  ret i32 %3
}

define <2 x i32> @lh_ri_inc(i16* %a) {
; CHECK-LABEL: lh_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lh a1, (a0), 84
; CHECK-NEXT:    ret
  %1 = load i16, i16* %a
  %2 = sext i16 %1 to i32
  %3 = getelementptr i16, i16* %a, i32 42
  %4 = ptrtoint i16* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define <2 x i32> @lh_rr_inc(i16* %a, i32 %b) {
; CHECK-LABEL: lh_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    cv.lh a1, (a0), a1
; CHECK-NEXT:    ret
  %1 = load i16, i16* %a
  %2 = sext i16 %1 to i32
  %3 = getelementptr i16, i16* %a, i32 %b
  %4 = ptrtoint i16* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define i32 @lh_rr(i16* %a, i32 %b) {
; CHECK-LABEL: lh_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    cv.lh a0, a1(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i16, i16* %a, i32 %b
  %2 = load i16, i16* %1
  %3 = sext i16 %2 to i32
  ret i32 %3
}

define <2 x i32> @lhu_ri_inc(i16* %a) {
; CHECK-LABEL: lhu_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lhu a1, (a0), 84
; CHECK-NEXT:    ret
  %1 = load i16, i16* %a
  %2 = zext i16 %1 to i32
  %3 = getelementptr i16, i16* %a, i32 42
  %4 = ptrtoint i16* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define <2 x i32> @lhu_rr_inc(i16* %a, i32 %b) {
; CHECK-LABEL: lhu_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    cv.lhu a1, (a0), a1
; CHECK-NEXT:    ret
  %1 = load i16, i16* %a
  %2 = zext i16 %1 to i32
  %3 = getelementptr i16, i16* %a, i32 %b
  %4 = ptrtoint i16* %3 to i32
  %5 = insertelement <2 x i32> undef, i32 %4, i32 0
  %6 = insertelement <2 x i32> %5, i32 %2, i32 1
  ret <2 x i32> %6
}

define i32 @lhu_rr(i16* %a, i32 %b) {
; CHECK-LABEL: lhu_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    cv.lhu a0, a1(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i16, i16* %a, i32 %b
  %2 = load i16, i16* %1
  %3 = zext i16 %2 to i32
  ret i32 %3
}

define <2 x i32> @lw_ri_inc(i32* %a) {
; CHECK-LABEL: lw_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.lw a1, (a0), 168
; CHECK-NEXT:    ret
  %1 = load i32, i32* %a
  %2 = getelementptr i32, i32* %a, i32 42
  %3 = ptrtoint i32* %2 to i32
  %4 = insertelement <2 x i32> undef, i32 %3, i32 0
  %5 = insertelement <2 x i32> %4, i32 %1, i32 1
  ret <2 x i32> %5
}

define <2 x i32> @lw_rr_inc(i32* %a, i32 %b) {
; CHECK-LABEL: lw_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    cv.lw a1, (a0), a1
; CHECK-NEXT:    ret
  %1 = load i32, i32* %a
  %2 = getelementptr i32, i32* %a, i32 %b
  %3 = ptrtoint i32* %2 to i32
  %4 = insertelement <2 x i32> undef, i32 %3, i32 0
  %5 = insertelement <2 x i32> %4, i32 %1, i32 1
  ret <2 x i32> %5
}

define i32 @lw_rr(i32* %a, i32 %b) {
; CHECK-LABEL: lw_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    cv.lw a0, a1(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i32, i32* %a, i32 %b
  %2 = load i32, i32* %1
  ret i32 %2
}

define i8* @sb_ri_inc(i8* %a, i8 %b) {
; CHECK-LABEL: sb_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.sb a1, (a0), 42
; CHECK-NEXT:    ret
  store i8 %b, i8* %a
  %1 = getelementptr i8, i8* %a, i32 42
  ret i8* %1
}

define i8* @sb_rr_inc(i8* %a, i8 %b, i32 %c) {
; CHECK-LABEL: sb_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.sb a1, (a0), a2
; CHECK-NEXT:    ret
  store i8 %b, i8* %a
  %1 = getelementptr i8, i8* %a, i32 %c
  ret i8* %1
}

define void @sb_rr(i8* %a, i8 %b, i32 %c) {
; CHECK-LABEL: sb_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.sb a1, a2(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i8, i8* %a, i32 %c
  store i8 %b, i8* %1
  ret void
}

define i16* @sh_ri_inc(i16* %a, i16 %b) {
; CHECK-LABEL: sh_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.sh a1, (a0), 84
; CHECK-NEXT:    ret
  store i16 %b, i16* %a
  %1 = getelementptr i16, i16* %a, i32 42
  ret i16* %1
}

define i16* @sh_rr_inc(i16* %a, i16 %b, i32 %c) {
; CHECK-LABEL: sh_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    cv.sh a1, (a0), a2
; CHECK-NEXT:    ret
  store i16 %b, i16* %a
  %1 = getelementptr i16, i16* %a, i32 %c
  ret i16* %1
}

define void @sh_rr(i16* %a, i16 %b, i32 %c) {
; CHECK-LABEL: sh_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    cv.sh a1, a2(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i16, i16* %a, i32 %c
  store i16 %b, i16* %1
  ret void
}

define i32* @sw_ri_inc(i32* %a, i32 %b) {
; CHECK-LABEL: sw_ri_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.sw a1, (a0), 168
; CHECK-NEXT:    ret
  store i32 %b, i32* %a
  %1 = getelementptr i32, i32* %a, i32 42
  ret i32* %1
}

define i32* @sw_rr_inc(i32* %a, i32 %b, i32 %c) {
; CHECK-LABEL: sw_rr_inc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    cv.sw a1, (a0), a2
; CHECK-NEXT:    ret
  store i32 %b, i32* %a
  %1 = getelementptr i32, i32* %a, i32 %c
  ret i32* %1
}

define void @sw_rr(i32* %a, i32 %b, i32 %c) {
; CHECK-LABEL: sw_rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    cv.sw a1, a2(a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i32, i32* %a, i32 %c
  store i32 %b, i32* %1
  ret void
}

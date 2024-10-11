; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=bpf -mcpu=v1 -- | FileCheck %s

%struct.event = type { i8, [84 x i8] }

define void @foo(ptr %g) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    r1 = *(u64 *)(r1 + 0)
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 83)
; CHECK-NEXT:    *(u8 *)(r10 - 4) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 82)
; CHECK-NEXT:    *(u8 *)(r10 - 5) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 81)
; CHECK-NEXT:    *(u8 *)(r10 - 6) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 80)
; CHECK-NEXT:    *(u8 *)(r10 - 7) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 79)
; CHECK-NEXT:    *(u8 *)(r10 - 8) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 78)
; CHECK-NEXT:    *(u8 *)(r10 - 9) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 77)
; CHECK-NEXT:    *(u8 *)(r10 - 10) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 76)
; CHECK-NEXT:    *(u8 *)(r10 - 11) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 75)
; CHECK-NEXT:    *(u8 *)(r10 - 12) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 74)
; CHECK-NEXT:    *(u8 *)(r10 - 13) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 73)
; CHECK-NEXT:    *(u8 *)(r10 - 14) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 72)
; CHECK-NEXT:    *(u8 *)(r10 - 15) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 71)
; CHECK-NEXT:    *(u8 *)(r10 - 16) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 70)
; CHECK-NEXT:    *(u8 *)(r10 - 17) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 69)
; CHECK-NEXT:    *(u8 *)(r10 - 18) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 68)
; CHECK-NEXT:    *(u8 *)(r10 - 19) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 67)
; CHECK-NEXT:    *(u8 *)(r10 - 20) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 66)
; CHECK-NEXT:    *(u8 *)(r10 - 21) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 65)
; CHECK-NEXT:    *(u8 *)(r10 - 22) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 64)
; CHECK-NEXT:    *(u8 *)(r10 - 23) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 63)
; CHECK-NEXT:    *(u8 *)(r10 - 24) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 62)
; CHECK-NEXT:    *(u8 *)(r10 - 25) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 61)
; CHECK-NEXT:    *(u8 *)(r10 - 26) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 60)
; CHECK-NEXT:    *(u8 *)(r10 - 27) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 59)
; CHECK-NEXT:    *(u8 *)(r10 - 28) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 58)
; CHECK-NEXT:    *(u8 *)(r10 - 29) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 57)
; CHECK-NEXT:    *(u8 *)(r10 - 30) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 56)
; CHECK-NEXT:    *(u8 *)(r10 - 31) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 55)
; CHECK-NEXT:    *(u8 *)(r10 - 32) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 54)
; CHECK-NEXT:    *(u8 *)(r10 - 33) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 53)
; CHECK-NEXT:    *(u8 *)(r10 - 34) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 52)
; CHECK-NEXT:    *(u8 *)(r10 - 35) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 51)
; CHECK-NEXT:    *(u8 *)(r10 - 36) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 50)
; CHECK-NEXT:    *(u8 *)(r10 - 37) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 49)
; CHECK-NEXT:    *(u8 *)(r10 - 38) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 48)
; CHECK-NEXT:    *(u8 *)(r10 - 39) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 47)
; CHECK-NEXT:    *(u8 *)(r10 - 40) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 46)
; CHECK-NEXT:    *(u8 *)(r10 - 41) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 45)
; CHECK-NEXT:    *(u8 *)(r10 - 42) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 44)
; CHECK-NEXT:    *(u8 *)(r10 - 43) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 43)
; CHECK-NEXT:    *(u8 *)(r10 - 44) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 42)
; CHECK-NEXT:    *(u8 *)(r10 - 45) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 41)
; CHECK-NEXT:    *(u8 *)(r10 - 46) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 40)
; CHECK-NEXT:    *(u8 *)(r10 - 47) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 39)
; CHECK-NEXT:    *(u8 *)(r10 - 48) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 38)
; CHECK-NEXT:    *(u8 *)(r10 - 49) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 37)
; CHECK-NEXT:    *(u8 *)(r10 - 50) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 36)
; CHECK-NEXT:    *(u8 *)(r10 - 51) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 35)
; CHECK-NEXT:    *(u8 *)(r10 - 52) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 34)
; CHECK-NEXT:    *(u8 *)(r10 - 53) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 33)
; CHECK-NEXT:    *(u8 *)(r10 - 54) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 32)
; CHECK-NEXT:    *(u8 *)(r10 - 55) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 31)
; CHECK-NEXT:    *(u8 *)(r10 - 56) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 30)
; CHECK-NEXT:    *(u8 *)(r10 - 57) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 29)
; CHECK-NEXT:    *(u8 *)(r10 - 58) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 28)
; CHECK-NEXT:    *(u8 *)(r10 - 59) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 27)
; CHECK-NEXT:    *(u8 *)(r10 - 60) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 26)
; CHECK-NEXT:    *(u8 *)(r10 - 61) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 25)
; CHECK-NEXT:    *(u8 *)(r10 - 62) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 24)
; CHECK-NEXT:    *(u8 *)(r10 - 63) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 23)
; CHECK-NEXT:    *(u8 *)(r10 - 64) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 22)
; CHECK-NEXT:    *(u8 *)(r10 - 65) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 21)
; CHECK-NEXT:    *(u8 *)(r10 - 66) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 20)
; CHECK-NEXT:    *(u8 *)(r10 - 67) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 19)
; CHECK-NEXT:    *(u8 *)(r10 - 68) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 18)
; CHECK-NEXT:    *(u8 *)(r10 - 69) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 17)
; CHECK-NEXT:    *(u8 *)(r10 - 70) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 16)
; CHECK-NEXT:    *(u8 *)(r10 - 71) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 15)
; CHECK-NEXT:    *(u8 *)(r10 - 72) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 14)
; CHECK-NEXT:    *(u8 *)(r10 - 73) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 13)
; CHECK-NEXT:    *(u8 *)(r10 - 74) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 12)
; CHECK-NEXT:    *(u8 *)(r10 - 75) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 11)
; CHECK-NEXT:    *(u8 *)(r10 - 76) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 10)
; CHECK-NEXT:    *(u8 *)(r10 - 77) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 9)
; CHECK-NEXT:    *(u8 *)(r10 - 78) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 8)
; CHECK-NEXT:    *(u8 *)(r10 - 79) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 7)
; CHECK-NEXT:    *(u8 *)(r10 - 80) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 6)
; CHECK-NEXT:    *(u8 *)(r10 - 81) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 5)
; CHECK-NEXT:    *(u8 *)(r10 - 82) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 4)
; CHECK-NEXT:    *(u8 *)(r10 - 83) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 3)
; CHECK-NEXT:    *(u8 *)(r10 - 84) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 2)
; CHECK-NEXT:    *(u8 *)(r10 - 85) = r2
; CHECK-NEXT:    r2 = *(u8 *)(r1 + 1)
; CHECK-NEXT:    *(u8 *)(r10 - 86) = r2
; CHECK-NEXT:    r1 = *(u8 *)(r1 + 0)
; CHECK-NEXT:    *(u8 *)(r10 - 87) = r1
; CHECK-NEXT:    r1 = r10
; CHECK-NEXT:    r1 += -88
; CHECK-NEXT:    call bar
; CHECK-NEXT:    exit
entry:
  %event = alloca %struct.event, align 8
  %hostname = getelementptr inbounds %struct.event, ptr %event, i64 0, i32 1
  %0 = load ptr, ptr %g, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(84) %hostname, ptr noundef nonnull align 1 dereferenceable(84) %0, i64 84, i1 false)
  call void @bar(ptr noundef nonnull %event)
  ret void
}

declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2
declare void @bar(ptr noundef)

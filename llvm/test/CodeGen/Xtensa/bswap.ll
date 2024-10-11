; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=xtensa -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=XTENSA %s

declare i16 @llvm.bswap.i16(i16)
declare i32 @llvm.bswap.i32(i32)
declare i64 @llvm.bswap.i64(i64)
declare i8 @llvm.bitreverse.i8(i8)
declare i16 @llvm.bitreverse.i16(i16)
declare i32 @llvm.bitreverse.i32(i32)
declare i64 @llvm.bitreverse.i64(i64)

define i16 @test_bswap_i16(i16 %a) nounwind {
; XTENSA-LABEL: test_bswap_i16:
; XTENSA:         l32r a8, .LCPI0_0
; XTENSA-NEXT:    and a8, a2, a8
; XTENSA-NEXT:    srli a8, a8, 8
; XTENSA-NEXT:    slli a9, a2, 8
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i16 @llvm.bswap.i16(i16 %a)
  ret i16 %tmp
}

define i32 @test_bswap_i32(i32 %a) nounwind {
; XTENSA-LABEL: test_bswap_i32:
; XTENSA:         srli a8, a2, 8
; XTENSA-NEXT:    l32r a9, .LCPI1_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    extui a10, a2, 24, 8
; XTENSA-NEXT:    or a8, a8, a10
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 8
; XTENSA-NEXT:    slli a10, a2, 24
; XTENSA-NEXT:    or a9, a10, a9
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i32 @llvm.bswap.i32(i32 %a)
  ret i32 %tmp
}

define i64 @test_bswap_i64(i64 %a) nounwind {
; XTENSA-LABEL: test_bswap_i64:
; XTENSA:         srli a8, a3, 8
; XTENSA-NEXT:    l32r a9, .LCPI2_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    extui a10, a3, 24, 8
; XTENSA-NEXT:    or a8, a8, a10
; XTENSA-NEXT:    and a10, a3, a9
; XTENSA-NEXT:    slli a10, a10, 8
; XTENSA-NEXT:    slli a11, a3, 24
; XTENSA-NEXT:    or a10, a11, a10
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a2, 8
; XTENSA-NEXT:    and a10, a10, a9
; XTENSA-NEXT:    extui a11, a2, 24, 8
; XTENSA-NEXT:    or a10, a10, a11
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 8
; XTENSA-NEXT:    slli a11, a2, 24
; XTENSA-NEXT:    or a9, a11, a9
; XTENSA-NEXT:    or a3, a9, a10
; XTENSA-NEXT:    or a2, a8, a8
; XTENSA-NEXT:    ret
  %tmp = call i64 @llvm.bswap.i64(i64 %a)
  ret i64 %tmp
}

define i8 @test_bitreverse_i8(i8 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_i8:
; XTENSA:         movi a8, 15
; XTENSA-NEXT:    and a8, a2, a8
; XTENSA-NEXT:    slli a8, a8, 4
; XTENSA-NEXT:    movi a9, 240
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    srli a9, a9, 4
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    movi a10, 51
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    movi a10, 85
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i8 @llvm.bitreverse.i8(i8 %a)
  ret i8 %tmp
}

define i16 @test_bitreverse_i16(i16 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_i16:
; XTENSA:         l32r a8, .LCPI4_0
; XTENSA-NEXT:    and a8, a2, a8
; XTENSA-NEXT:    srli a8, a8, 8
; XTENSA-NEXT:    slli a9, a2, 8
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 4
; XTENSA-NEXT:    l32r a10, .LCPI4_1
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 4
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    l32r a10, .LCPI4_2
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    l32r a10, .LCPI4_3
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i16 @llvm.bitreverse.i16(i16 %a)
  ret i16 %tmp
}

define i32 @test_bitreverse_i32(i32 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_i32:
; XTENSA:         srli a8, a2, 8
; XTENSA-NEXT:    l32r a9, .LCPI5_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    extui a10, a2, 24, 8
; XTENSA-NEXT:    or a8, a8, a10
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 8
; XTENSA-NEXT:    slli a10, a2, 24
; XTENSA-NEXT:    or a9, a10, a9
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 4
; XTENSA-NEXT:    l32r a10, .LCPI5_1
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 4
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    l32r a10, .LCPI5_2
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    l32r a10, .LCPI5_3
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i32 @llvm.bitreverse.i32(i32 %a)
  ret i32 %tmp
}

define i64 @test_bitreverse_i64(i64 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_i64:
; XTENSA:         srli a8, a3, 8
; XTENSA-NEXT:    l32r a9, .LCPI6_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    extui a10, a3, 24, 8
; XTENSA-NEXT:    or a8, a8, a10
; XTENSA-NEXT:    and a10, a3, a9
; XTENSA-NEXT:    slli a10, a10, 8
; XTENSA-NEXT:    slli a11, a3, 24
; XTENSA-NEXT:    or a10, a11, a10
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a8, 4
; XTENSA-NEXT:    l32r a11, .LCPI6_1
; XTENSA-NEXT:    and a10, a10, a11
; XTENSA-NEXT:    and a8, a8, a11
; XTENSA-NEXT:    slli a8, a8, 4
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a8, 2
; XTENSA-NEXT:    l32r a7, .LCPI6_2
; XTENSA-NEXT:    and a10, a10, a7
; XTENSA-NEXT:    and a8, a8, a7
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a8, 1
; XTENSA-NEXT:    l32r a6, .LCPI6_3
; XTENSA-NEXT:    and a10, a10, a6
; XTENSA-NEXT:    and a8, a8, a6
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a2, 8
; XTENSA-NEXT:    and a10, a10, a9
; XTENSA-NEXT:    extui a5, a2, 24, 8
; XTENSA-NEXT:    or a10, a10, a5
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 8
; XTENSA-NEXT:    slli a5, a2, 24
; XTENSA-NEXT:    or a9, a5, a9
; XTENSA-NEXT:    or a9, a9, a10
; XTENSA-NEXT:    srli a10, a9, 4
; XTENSA-NEXT:    and a10, a10, a11
; XTENSA-NEXT:    and a9, a9, a11
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a9, a10, a9
; XTENSA-NEXT:    srli a10, a9, 2
; XTENSA-NEXT:    and a10, a10, a7
; XTENSA-NEXT:    and a9, a9, a7
; XTENSA-NEXT:    slli a9, a9, 2
; XTENSA-NEXT:    or a9, a10, a9
; XTENSA-NEXT:    srli a10, a9, 1
; XTENSA-NEXT:    and a10, a10, a6
; XTENSA-NEXT:    and a9, a9, a6
; XTENSA-NEXT:    slli a9, a9, 1
; XTENSA-NEXT:    or a3, a10, a9
; XTENSA-NEXT:    or a2, a8, a8
; XTENSA-NEXT:    ret
  %tmp = call i64 @llvm.bitreverse.i64(i64 %a)
  ret i64 %tmp
}

define i16 @test_bswap_bitreverse_i16(i16 %a) nounwind {
; XTENSA-LABEL: test_bswap_bitreverse_i16:
; XTENSA:         srli a8, a2, 4
; XTENSA-NEXT:    l32r a9, .LCPI7_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a8, a8, a9
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    l32r a10, .LCPI7_1
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    l32r a10, .LCPI7_2
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i16 @llvm.bswap.i16(i16 %a)
  %tmp2 = call i16 @llvm.bitreverse.i16(i16 %tmp)
  ret i16 %tmp2
}

define i32 @test_bswap_bitreverse_i32(i32 %a) nounwind {
; XTENSA-LABEL: test_bswap_bitreverse_i32:
; XTENSA:         srli a8, a2, 4
; XTENSA-NEXT:    l32r a9, .LCPI8_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a8, a8, a9
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    l32r a10, .LCPI8_1
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    l32r a10, .LCPI8_2
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i32 @llvm.bswap.i32(i32 %a)
  %tmp2 = call i32 @llvm.bitreverse.i32(i32 %tmp)
  ret i32 %tmp2
}

define i64 @test_bswap_bitreverse_i64(i64 %a) nounwind {
; XTENSA-LABEL: test_bswap_bitreverse_i64:
; XTENSA:         srli a8, a2, 4
; XTENSA-NEXT:    l32r a9, .LCPI9_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a10, a2, a9
; XTENSA-NEXT:    slli a10, a10, 4
; XTENSA-NEXT:    or a8, a8, a10
; XTENSA-NEXT:    srli a10, a8, 2
; XTENSA-NEXT:    l32r a11, .LCPI9_1
; XTENSA-NEXT:    and a10, a10, a11
; XTENSA-NEXT:    and a8, a8, a11
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a8, 1
; XTENSA-NEXT:    l32r a7, .LCPI9_2
; XTENSA-NEXT:    and a10, a10, a7
; XTENSA-NEXT:    and a8, a8, a7
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a10, a8
; XTENSA-NEXT:    srli a8, a3, 4
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a9, a3, a9
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a8, a8, a9
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    and a9, a9, a11
; XTENSA-NEXT:    and a8, a8, a11
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    and a9, a9, a7
; XTENSA-NEXT:    and a8, a8, a7
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a3, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i64 @llvm.bswap.i64(i64 %a)
  %tmp2 = call i64 @llvm.bitreverse.i64(i64 %tmp)
  ret i64 %tmp2
}

define i16 @test_bitreverse_bswap_i16(i16 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_bswap_i16:
; XTENSA:         srli a8, a2, 4
; XTENSA-NEXT:    l32r a9, .LCPI10_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a8, a8, a9
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    l32r a10, .LCPI10_1
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    l32r a10, .LCPI10_2
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i16 @llvm.bitreverse.i16(i16 %a)
  %tmp2 = call i16 @llvm.bswap.i16(i16 %tmp)
  ret i16 %tmp2
}

define i32 @test_bitreverse_bswap_i32(i32 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_bswap_i32:
; XTENSA:         srli a8, a2, 4
; XTENSA-NEXT:    l32r a9, .LCPI11_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a9, a2, a9
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a8, a8, a9
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    l32r a10, .LCPI11_1
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    l32r a10, .LCPI11_2
; XTENSA-NEXT:    and a9, a9, a10
; XTENSA-NEXT:    and a8, a8, a10
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i32 @llvm.bitreverse.i32(i32 %a)
  %tmp2 = call i32 @llvm.bswap.i32(i32 %tmp)
  ret i32 %tmp2
}

define i64 @test_bitreverse_bswap_i64(i64 %a) nounwind {
; XTENSA-LABEL: test_bitreverse_bswap_i64:
; XTENSA:         srli a8, a2, 4
; XTENSA-NEXT:    l32r a9, .LCPI12_0
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a10, a2, a9
; XTENSA-NEXT:    slli a10, a10, 4
; XTENSA-NEXT:    or a8, a8, a10
; XTENSA-NEXT:    srli a10, a8, 2
; XTENSA-NEXT:    l32r a11, .LCPI12_1
; XTENSA-NEXT:    and a10, a10, a11
; XTENSA-NEXT:    and a8, a8, a11
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a10, a8
; XTENSA-NEXT:    srli a10, a8, 1
; XTENSA-NEXT:    l32r a7, .LCPI12_2
; XTENSA-NEXT:    and a10, a10, a7
; XTENSA-NEXT:    and a8, a8, a7
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a2, a10, a8
; XTENSA-NEXT:    srli a8, a3, 4
; XTENSA-NEXT:    and a8, a8, a9
; XTENSA-NEXT:    and a9, a3, a9
; XTENSA-NEXT:    slli a9, a9, 4
; XTENSA-NEXT:    or a8, a8, a9
; XTENSA-NEXT:    srli a9, a8, 2
; XTENSA-NEXT:    and a9, a9, a11
; XTENSA-NEXT:    and a8, a8, a11
; XTENSA-NEXT:    slli a8, a8, 2
; XTENSA-NEXT:    or a8, a9, a8
; XTENSA-NEXT:    srli a9, a8, 1
; XTENSA-NEXT:    and a9, a9, a7
; XTENSA-NEXT:    and a8, a8, a7
; XTENSA-NEXT:    slli a8, a8, 1
; XTENSA-NEXT:    or a3, a9, a8
; XTENSA-NEXT:    ret
  %tmp = call i64 @llvm.bitreverse.i64(i64 %a)
  %tmp2 = call i64 @llvm.bswap.i64(i64 %tmp)
  ret i64 %tmp2
}

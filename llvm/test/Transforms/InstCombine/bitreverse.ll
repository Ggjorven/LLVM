; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128-n8:16:32"

declare i16 @llvm.bitreverse.i16(i16)
declare i32 @llvm.bitreverse.i32(i32)
declare i64 @llvm.bitreverse.i64(i64)
declare <2 x i8> @llvm.bitreverse.v2i8(<2 x i8>)
declare <2 x i32> @llvm.bitreverse.v2i32(<2 x i32>)
declare void @use_i32(i32)
declare void @use_i64(i64)

;pairwise reverse
;template <typename T>
;T reverse(T v) {
;  T s = sizeof(v) * 8;
;  T mask = ~(T)0;
;  while ((s >>= 1) > 0) {
;    mask ^= (mask << s);
;    v = ((v >> s) & mask) | ((v << s) & ~mask);
;  }
;  return v;
;}
define i8 @rev8(i8 %v) {
; CHECK-LABEL: @rev8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OR_2:%.*]] = call i8 @llvm.bitreverse.i8(i8 [[V:%.*]])
; CHECK-NEXT:    ret i8 [[OR_2]]
;
entry:
  %shr4 = lshr i8 %v, 4
  %shl7 = shl i8 %v, 4
  %or = or i8 %shr4, %shl7
  %shr4.1 = lshr i8 %or, 2
  %and.1 = and i8 %shr4.1, 51
  %shl7.1 = shl i8 %or, 2
  %and9.1 = and i8 %shl7.1, -52
  %or.1 = or i8 %and.1, %and9.1
  %shr4.2 = lshr i8 %or.1, 1
  %and.2 = and i8 %shr4.2, 85
  %shl7.2 = shl i8 %or.1, 1
  %and9.2 = and i8 %shl7.2, -86
  %or.2 = or i8 %and.2, %and9.2
  ret i8 %or.2
}

define i16 @rev16(i16 %v) {
; CHECK-LABEL: @rev16(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OR_3:%.*]] = call i16 @llvm.bitreverse.i16(i16 [[V:%.*]])
; CHECK-NEXT:    ret i16 [[OR_3]]
;
entry:
  %shr4 = lshr i16 %v, 8
  %shl7 = shl i16 %v, 8
  %or = or i16 %shr4, %shl7
  %shr4.1 = lshr i16 %or, 4
  %and.1 = and i16 %shr4.1, 3855
  %shl7.1 = shl i16 %or, 4
  %and9.1 = and i16 %shl7.1, -3856
  %or.1 = or i16 %and.1, %and9.1
  %shr4.2 = lshr i16 %or.1, 2
  %and.2 = and i16 %shr4.2, 13107
  %shl7.2 = shl i16 %or.1, 2
  %and9.2 = and i16 %shl7.2, -13108
  %or.2 = or i16 %and.2, %and9.2
  %shr4.3 = lshr i16 %or.2, 1
  %and.3 = and i16 %shr4.3, 21845
  %shl7.3 = shl i16 %or.2, 1
  %and9.3 = and i16 %shl7.3, -21846
  %or.3 = or i16 %and.3, %and9.3
  ret i16 %or.3
}

define i32 @rev32(i32 %v) {
; CHECK-LABEL: @rev32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OR_4:%.*]] = call i32 @llvm.bitreverse.i32(i32 [[V:%.*]])
; CHECK-NEXT:    ret i32 [[OR_4]]
;
entry:
  %shr1 = lshr i32 %v, 16
  %shl2 = shl i32 %v, 16
  %or = or i32 %shr1, %shl2
  %shr1.1 = lshr i32 %or, 8
  %and.1 = and i32 %shr1.1, 16711935
  %shl2.1 = shl i32 %or, 8
  %and3.1 = and i32 %shl2.1, -16711936
  %or.1 = or i32 %and.1, %and3.1
  %shr1.2 = lshr i32 %or.1, 4
  %and.2 = and i32 %shr1.2, 252645135
  %shl2.2 = shl i32 %or.1, 4
  %and3.2 = and i32 %shl2.2, -252645136
  %or.2 = or i32 %and.2, %and3.2
  %shr1.3 = lshr i32 %or.2, 2
  %and.3 = and i32 %shr1.3, 858993459
  %shl2.3 = shl i32 %or.2, 2
  %and3.3 = and i32 %shl2.3, -858993460
  %or.3 = or i32 %and.3, %and3.3
  %shr1.4 = lshr i32 %or.3, 1
  %and.4 = and i32 %shr1.4, 1431655765
  %shl2.4 = shl i32 %or.3, 1
  %and3.4 = and i32 %shl2.4, -1431655766
  %or.4 = or i32 %and.4, %and3.4
  ret i32 %or.4
}

define i32 @rev32_bswap(i32 %v) {
; CHECK-LABEL: @rev32_bswap(
; CHECK-NEXT:    [[RET:%.*]] = call i32 @llvm.bitreverse.i32(i32 [[V:%.*]])
; CHECK-NEXT:    ret i32 [[RET]]
;
  %and.i = lshr i32 %v, 1
  %shr.i = and i32 %and.i, 1431655765
  %and1.i = shl i32 %v, 1
  %shl.i = and i32 %and1.i, -1431655766
  %or.i = or disjoint i32 %shr.i, %shl.i
  %and2.i = lshr i32 %or.i, 2
  %shr3.i = and i32 %and2.i, 858993459
  %and4.i = shl i32 %or.i, 2
  %shl5.i = and i32 %and4.i, -858993460
  %or6.i = or disjoint i32 %shr3.i, %shl5.i
  %and7.i = lshr i32 %or6.i, 4
  %shr8.i = and i32 %and7.i, 252645135
  %and9.i = shl i32 %or6.i, 4
  %shl10.i = and i32 %and9.i, -252645136
  %or11.i = or disjoint i32 %shr8.i, %shl10.i
  %ret = call i32 @llvm.bswap.i32(i32 %or11.i)
  ret i32 %ret
}

define i64 @rev64(i64 %v) {
; CHECK-LABEL: @rev64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OR_5:%.*]] = call i64 @llvm.bitreverse.i64(i64 [[V:%.*]])
; CHECK-NEXT:    ret i64 [[OR_5]]
;
entry:
  %shr2 = lshr i64 %v, 32
  %shl4 = shl i64 %v, 32
  %or = or i64 %shr2, %shl4
  %shr2.1 = lshr i64 %or, 16
  %and.1 = and i64 %shr2.1, 281470681808895
  %shl4.1 = shl i64 %or, 16
  %and5.1 = and i64 %shl4.1, -281470681808896
  %or.1 = or i64 %and.1, %and5.1
  %shr2.2 = lshr i64 %or.1, 8
  %and.2 = and i64 %shr2.2, 71777214294589695
  %shl4.2 = shl i64 %or.1, 8
  %and5.2 = and i64 %shl4.2, -71777214294589696
  %or.2 = or i64 %and.2, %and5.2
  %shr2.3 = lshr i64 %or.2, 4
  %and.3 = and i64 %shr2.3, 1085102592571150095
  %shl4.3 = shl i64 %or.2, 4
  %and5.3 = and i64 %shl4.3, -1085102592571150096
  %or.3 = or i64 %and.3, %and5.3
  %shr2.4 = lshr i64 %or.3, 2
  %and.4 = and i64 %shr2.4, 3689348814741910323
  %shl4.4 = shl i64 %or.3, 2
  %and5.4 = and i64 %shl4.4, -3689348814741910324
  %or.4 = or i64 %and.4, %and5.4
  %shr2.5 = lshr i64 %or.4, 1
  %and.5 = and i64 %shr2.5, 6148914691236517205
  %shl4.5 = shl i64 %or.4, 1
  %and5.5 = and i64 %shl4.5, -6148914691236517206
  %or.5 = or i64 %and.5, %and5.5
  ret i64 %or.5
}

;unsigned char rev8_xor(unsigned char x) {
;  unsigned char y;
;  y = x&0x55; x ^= y; x |= (y<<2)|(y>>6);
;  y = x&0x66; x ^= y; x |= (y<<4)|(y>>4);
;  return (x<<1)|(x>>7);
;}

define i8 @rev8_xor(i8 %0) {
; CHECK-LABEL: @rev8_xor(
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.bitreverse.i8(i8 [[TMP0:%.*]])
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %2 = and i8 %0, 85
  %3 = xor i8 %0, %2
  %4 = shl i8 %2, 2
  %5 = lshr i8 %2, 6
  %6 = or i8 %5, %3
  %7 = or i8 %6, %4
  %8 = and i8 %7, 102
  %9 = xor i8 %7, %8
  %10 = lshr i8 %8, 4
  %11 = or i8 %10, %9
  %12 = shl i8 %8, 5
  %13 = shl i8 %11, 1
  %14 = or i8 %12, %13
  %15 = lshr i8 %0, 7
  %16 = or i8 %14, %15
  ret i8 %16
}

define <2 x i8> @rev8_xor_vector(<2 x i8> %0) {
; CHECK-LABEL: @rev8_xor_vector(
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i8> @llvm.bitreverse.v2i8(<2 x i8> [[TMP0:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[TMP2]]
;
  %2 = and <2 x i8> %0, <i8 85, i8 85>
  %3 = xor <2 x i8> %0, %2
  %4 = shl <2 x i8> %2, <i8 2, i8 2>
  %5 = lshr <2 x i8> %2, <i8 6, i8 6>
  %6 = or <2 x i8> %5, %3
  %7 = or <2 x i8> %6, %4
  %8 = and <2 x i8> %7, <i8 102, i8 102>
  %9 = xor <2 x i8> %7, %8
  %10 = lshr <2 x i8> %8, <i8 4, i8 4>
  %11 = or <2 x i8> %10, %9
  %12 = shl <2 x i8> %8, <i8 5, i8 5>
  %13 = shl <2 x i8> %11, <i8 1, i8 1>
  %14 = or <2 x i8> %12, %13
  %15 = lshr <2 x i8> %0, <i8 7, i8 7>
  %16 = or <2 x i8> %14, %15
  ret <2 x i8> %16
}

; bitreverse8(x) = ((x * 0x0202020202ULL) & 0x010884422010ULL) % 1023
define i8 @rev8_mul_and_urem(i8 %0) {
; CHECK-LABEL: @rev8_mul_and_urem(
; CHECK-NEXT:    [[TMP2:%.*]] = zext i8 [[TMP0:%.*]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = mul nuw nsw i64 [[TMP2]], 8623620610
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 1136090292240
; CHECK-NEXT:    [[TMP5:%.*]] = urem i64 [[TMP4]], 1023
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i64 [[TMP5]] to i8
; CHECK-NEXT:    ret i8 [[TMP6]]
;
  %2 = zext i8 %0 to i64
  %3 = mul nuw nsw i64 %2, 8623620610
  %4 = and i64 %3, 1136090292240
  %5 = urem i64 %4, 1023
  %6 = trunc i64 %5 to i8
  ret i8 %6
}

; bitreverse8(x) = ((x * 0x80200802ULL) & 0x0884422110ULL) * 0x0101010101ULL >> 32
define i8 @rev8_mul_and_mul(i8 %0) {
; CHECK-LABEL: @rev8_mul_and_mul(
; CHECK-NEXT:    [[TMP2:%.*]] = zext i8 [[TMP0:%.*]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = mul nuw nsw i64 [[TMP2]], 2149582850
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 36578664720
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 4311810305
; CHECK-NEXT:    [[TMP6:%.*]] = lshr i64 [[TMP5]], 32
; CHECK-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i8
; CHECK-NEXT:    ret i8 [[TMP7]]
;
  %2 = zext i8 %0 to i64
  %3 = mul nuw nsw i64 %2, 2149582850
  %4 = and i64 %3, 36578664720
  %5 = mul i64 %4, 4311810305
  %6 = lshr i64 %5, 32
  %7 = trunc i64 %6 to i8
  ret i8 %7
}

; bitreverse8(x) = (((x * 0x0802LU) & 0x22110LU) | ((x * 0x8020LU) & 0x88440LU)) * 0x10101LU >> 16
define i8 @rev8_mul_and_lshr(i8 %0) {
; CHECK-LABEL: @rev8_mul_and_lshr(
; CHECK-NEXT:    [[TMP2:%.*]] = zext i8 [[TMP0:%.*]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = mul nuw nsw i64 [[TMP2]], 2050
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 139536
; CHECK-NEXT:    [[TMP5:%.*]] = mul nuw nsw i64 [[TMP2]], 32800
; CHECK-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 558144
; CHECK-NEXT:    [[TMP7:%.*]] = or disjoint i64 [[TMP4]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = mul nuw nsw i64 [[TMP7]], 65793
; CHECK-NEXT:    [[TMP9:%.*]] = lshr i64 [[TMP8]], 16
; CHECK-NEXT:    [[TMP10:%.*]] = trunc i64 [[TMP9]] to i8
; CHECK-NEXT:    ret i8 [[TMP10]]
;
  %2 = zext i8 %0 to i64
  %3 = mul nuw nsw i64 %2, 2050
  %4 = and i64 %3, 139536
  %5 = mul nuw nsw i64 %2, 32800
  %6 = and i64 %5, 558144
  %7 = or i64 %4, %6
  %8 = mul nuw nsw i64 %7, 65793
  %9 = lshr i64 %8, 16
  %10 = trunc i64 %9 to i8
  ret i8 %10
}

define i4 @shuf_4bits(<4 x i1> %x) {
; CHECK-LABEL: @shuf_4bits(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i1> [[X:%.*]] to i4
; CHECK-NEXT:    [[CAST:%.*]] = call i4 @llvm.bitreverse.i4(i4 [[TMP1]])
; CHECK-NEXT:    ret i4 [[CAST]]
;
  %bitreverse = shufflevector <4 x i1> %x, <4 x i1> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %cast = bitcast <4 x i1> %bitreverse to i4
  ret i4 %cast
}

define i4 @shuf_load_4bits(ptr %p) {
; CHECK-LABEL: @shuf_load_4bits(
; CHECK-NEXT:    [[X1:%.*]] = load i4, ptr [[P:%.*]], align 1
; CHECK-NEXT:    [[CAST:%.*]] = call i4 @llvm.bitreverse.i4(i4 [[X1]])
; CHECK-NEXT:    ret i4 [[CAST]]
;
  %x = load <4 x i1>, ptr %p
  %bitreverse = shufflevector <4 x i1> %x, <4 x i1> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %cast = bitcast <4 x i1> %bitreverse to i4
  ret i4 %cast
}

define i4 @shuf_bitcast_twice_4bits(i4 %x) {
; CHECK-LABEL: @shuf_bitcast_twice_4bits(
; CHECK-NEXT:    [[CAST2:%.*]] = call i4 @llvm.bitreverse.i4(i4 [[X:%.*]])
; CHECK-NEXT:    ret i4 [[CAST2]]
;
  %cast1 = bitcast i4 %x to <4 x i1>
  %bitreverse = shufflevector <4 x i1> %cast1, <4 x i1> undef, <4 x i32> <i32 poison, i32 2, i32 1, i32 0>
  %cast2 = bitcast <4 x i1> %bitreverse to i4
  ret i4 %cast2
}

; Negative tests - not reverse
define i4 @shuf_4bits_not_reverse(<4 x i1> %x) {
; CHECK-LABEL: @shuf_4bits_not_reverse(
; CHECK-NEXT:    [[BITREVERSE:%.*]] = shufflevector <4 x i1> [[X:%.*]], <4 x i1> poison, <4 x i32> <i32 3, i32 1, i32 2, i32 0>
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <4 x i1> [[BITREVERSE]] to i4
; CHECK-NEXT:    ret i4 [[CAST]]
;
  %bitreverse = shufflevector <4 x i1> %x, <4 x i1> undef, <4 x i32> <i32 3, i32 1, i32 2, i32 0>
  %cast = bitcast <4 x i1> %bitreverse to i4
  ret i4 %cast
}

; Negative test - extra use
declare void @use(<4 x i1>)

define i4 @shuf_4bits_extra_use(<4 x i1> %x) {
; CHECK-LABEL: @shuf_4bits_extra_use(
; CHECK-NEXT:    [[BITREVERSE:%.*]] = shufflevector <4 x i1> [[X:%.*]], <4 x i1> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    call void @use(<4 x i1> [[BITREVERSE]])
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <4 x i1> [[BITREVERSE]] to i4
; CHECK-NEXT:    ret i4 [[CAST]]
;
  %bitreverse = shufflevector <4 x i1> %x, <4 x i1> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  call void @use(<4 x i1> %bitreverse)
  %cast = bitcast <4 x i1> %bitreverse to i4
  ret i4 %cast
}

define i32 @rev_i1(i1 %x) {
; CHECK-LABEL: @rev_i1(
; CHECK-NEXT:    [[Z:%.*]] = zext i1 [[X:%.*]] to i32
; CHECK-NEXT:    call void @use_i32(i32 [[Z]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[X]], i32 -2147483648, i32 0
; CHECK-NEXT:    ret i32 [[R]]
;
  %z = zext i1 %x to i32
  call void @use_i32(i32 %z)
  %r = call i32 @llvm.bitreverse.i32(i32 %z)
  ret i32 %r
}

define <2 x i8> @rev_v2i1(<2 x i1> %x) {
; CHECK-LABEL: @rev_v2i1(
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[X:%.*]], <2 x i8> <i8 -128, i8 -128>, <2 x i8> zeroinitializer
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %z = zext <2 x i1> %x to <2 x i8>
  %r = call <2 x i8> @llvm.bitreverse.v2i8(<2 x i8> %z)
  ret <2 x i8> %r
}

define i32 @rev_i2(i2 %x) {
; CHECK-LABEL: @rev_i2(
; CHECK-NEXT:    [[Z:%.*]] = zext i2 [[X:%.*]] to i32
; CHECK-NEXT:    [[R:%.*]] = call i32 @llvm.bitreverse.i32(i32 [[Z]])
; CHECK-NEXT:    ret i32 [[R]]
;
  %z = zext i2 %x to i32
  %r = call i32 @llvm.bitreverse.i32(i32 %z)
  ret i32 %r
}

; This used to infinite loop.

define i64 @PR59897(i1 %X1_2) {
; CHECK-LABEL: @PR59897(
; CHECK-NEXT:    [[NOT_X1_2:%.*]] = xor i1 [[X1_2:%.*]], true
; CHECK-NEXT:    [[X0_3X2X5X0:%.*]] = zext i1 [[NOT_X1_2]] to i64
; CHECK-NEXT:    ret i64 [[X0_3X2X5X0]]
;
  %X1_3 = zext i1 %X1_2 to i32
  %X8_3x2x2x0 = call i32 @llvm.bitreverse.i32(i32 %X1_3)
  %X8_4x2x3x0 = xor i32 %X8_3x2x2x0, -1
  %X0_3x2x4x0 = lshr i32 %X8_4x2x3x0, 31
  %X0_3x2x5x0 = zext i32 %X0_3x2x4x0 to i64
  ret i64 %X0_3x2x5x0
}

; Issue#62236
; Fold: BITREVERSE( OP( BITREVERSE(x), y ) ) -> OP( x, BITREVERSE(y) )

define i16 @rev_xor_lhs_rev16(i16 %a, i16 %b) #0 {
; CHECK-LABEL: @rev_xor_lhs_rev16(
; CHECK-NEXT:    [[TMP1:%.*]] = call i16 @llvm.bitreverse.i16(i16 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = xor i16 [[A:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i16 [[TMP2]]
;
  %1 = tail call i16 @llvm.bitreverse.i16(i16 %a)
  %2 = xor i16 %1, %b
  %3 = tail call i16 @llvm.bitreverse.i16(i16 %2)
  ret i16 %3
}

define i32 @rev_and_rhs_rev32(i32 %a, i32 %b) #0 {
; CHECK-LABEL: @rev_and_rhs_rev32(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.bitreverse.i32(i32 [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = tail call i32 @llvm.bitreverse.i32(i32 %b)
  %2 = and i32 %a, %1
  %3 = tail call i32 @llvm.bitreverse.i32(i32 %2)
  ret i32 %3
}

define i32 @rev_or_rhs_rev32(i32 %a, i32 %b) #0 {
; CHECK-LABEL: @rev_or_rhs_rev32(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.bitreverse.i32(i32 [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = or i32 [[TMP1]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = tail call i32 @llvm.bitreverse.i32(i32 %b)
  %2 = or i32 %a, %1
  %3 = tail call i32 @llvm.bitreverse.i32(i32 %2)
  ret i32 %3
}

define i64 @rev_or_rhs_rev64(i64 %a, i64 %b) #0 {
; CHECK-LABEL: @rev_or_rhs_rev64(
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.bitreverse.i64(i64 [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = or i64 [[TMP1]], [[B:%.*]]
; CHECK-NEXT:    ret i64 [[TMP2]]
;
  %1 = tail call i64 @llvm.bitreverse.i64(i64 %b)
  %2 = or i64 %a, %1
  %3 = tail call i64 @llvm.bitreverse.i64(i64 %2)
  ret i64 %3
}

define i64 @rev_xor_rhs_rev64(i64 %a, i64 %b) #0 {
; CHECK-LABEL: @rev_xor_rhs_rev64(
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.bitreverse.i64(i64 [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = xor i64 [[TMP1]], [[B:%.*]]
; CHECK-NEXT:    ret i64 [[TMP2]]
;
  %1 = tail call i64 @llvm.bitreverse.i64(i64 %b)
  %2 = xor i64 %a, %1
  %3 = tail call i64 @llvm.bitreverse.i64(i64 %2)
  ret i64 %3
}

define <2 x i32> @rev_xor_rhs_i32vec(<2 x i32> %a, <2 x i32> %b) #0 {
; CHECK-LABEL: @rev_xor_rhs_i32vec(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = xor <2 x i32> [[TMP1]], [[B:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %1 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %b)
  %2 = xor <2 x i32> %a, %1
  %3 = tail call <2 x i32> @llvm.bitreverse.v2i32(<2 x i32> %2)
  ret <2 x i32> %3
}

define i64 @rev_and_rhs_rev64_multiuse1(i64 %a, i64 %b) #0 {
; CHECK-LABEL: @rev_and_rhs_rev64_multiuse1(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call i64 @llvm.bitreverse.i64(i64 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[A:%.*]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i64 @llvm.bitreverse.i64(i64 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    ret i64 [[TMP4]]
;
  %1 = tail call i64 @llvm.bitreverse.i64(i64 %b)
  %2 = and i64 %a, %1
  %3 = tail call i64 @llvm.bitreverse.i64(i64 %2)
  %4 = mul i64 %2, %3 ;increase use of logical op
  ret i64 %4
}

define i64 @rev_and_rhs_rev64_multiuse2(i64 %a, i64 %b) #0 {
; CHECK-LABEL: @rev_and_rhs_rev64_multiuse2(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call i64 @llvm.bitreverse.i64(i64 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[A:%.*]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i64 @llvm.bitreverse.i64(i64 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP1]], [[TMP3]]
; CHECK-NEXT:    ret i64 [[TMP4]]
;
  %1 = tail call i64 @llvm.bitreverse.i64(i64 %b)
  %2 = and i64 %a, %1
  %3 = tail call i64 @llvm.bitreverse.i64(i64 %2)
  %4 = mul i64 %1, %3 ;increase use of inner bitreverse
  ret i64 %4
}

define i64 @rev_all_operand64(i64 %a, i64 %b) #0 {
; CHECK-LABEL: @rev_all_operand64(
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i64 [[TMP1]]
;
  %1 = tail call i64 @llvm.bitreverse.i64(i64 %a)
  %2 = tail call i64 @llvm.bitreverse.i64(i64 %b)
  %3 = and i64 %1, %2
  %4 = tail call i64 @llvm.bitreverse.i64(i64 %3)
  ret i64 %4
}

define i64 @rev_all_operand64_multiuse_both(i64 %a, i64 %b) #0 {
; CHECK-LABEL: @rev_all_operand64_multiuse_both(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call i64 @llvm.bitreverse.i64(i64 [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = tail call i64 @llvm.bitreverse.i64(i64 [[B:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = and i64 [[A]], [[B]]
; CHECK-NEXT:    call void @use_i64(i64 [[TMP1]])
; CHECK-NEXT:    call void @use_i64(i64 [[TMP2]])
; CHECK-NEXT:    ret i64 [[TMP3]]
;
  %1 = tail call i64 @llvm.bitreverse.i64(i64 %a)
  %2 = tail call i64 @llvm.bitreverse.i64(i64 %b)
  %3 = and i64 %1, %2
  %4 = tail call i64 @llvm.bitreverse.i64(i64 %3)

  call void @use_i64(i64 %1)
  call void @use_i64(i64 %2)
  ret i64 %4
}

declare i32 @llvm.bswap.i32(i32 %or11.i)

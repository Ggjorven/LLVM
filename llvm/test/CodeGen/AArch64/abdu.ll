; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s

;
; trunc(abs(sub(zext(a),zext(b)))) -> abdu(a,b)
;

define i8 @abd_ext_i8(i8 %a, i8 %b) nounwind {
; CHECK-LABEL: abd_ext_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    sub w8, w8, w1, uxtb
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %aext = zext i8 %a to i64
  %bext = zext i8 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i8
  ret i8 %trunc
}

define i8 @abd_ext_i8_i16(i8 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_ext_i8_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    sub w8, w8, w1, uxth
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %aext = zext i8 %a to i64
  %bext = zext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i8
  ret i8 %trunc
}

define i8 @abd_ext_i8_undef(i8 %a, i8 %b) nounwind {
; CHECK-LABEL: abd_ext_i8_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    sub w8, w8, w1, uxtb
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %aext = zext i8 %a to i64
  %bext = zext i8 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  %trunc = trunc i64 %abs to i8
  ret i8 %trunc
}

define i16 @abd_ext_i16(i16 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_ext_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w8, w8, w1, uxth
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %aext = zext i16 %a to i64
  %bext = zext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i16
  ret i16 %trunc
}

define i16 @abd_ext_i16_i32(i16 %a, i32 %b) nounwind {
; CHECK-LABEL: abd_ext_i16_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w9, w1, w8
; CHECK-NEXT:    subs w8, w8, w1
; CHECK-NEXT:    csel w0, w8, w9, hi
; CHECK-NEXT:    ret
  %aext = zext i16 %a to i64
  %bext = zext i32 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i16
  ret i16 %trunc
}

define i16 @abd_ext_i16_undef(i16 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_ext_i16_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w8, w8, w1, uxth
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %aext = zext i16 %a to i64
  %bext = zext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  %trunc = trunc i64 %abs to i16
  ret i16 %trunc
}

define i32 @abd_ext_i32(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: abd_ext_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    subs w9, w0, w1
; CHECK-NEXT:    csel w0, w9, w8, hi
; CHECK-NEXT:    ret
  %aext = zext i32 %a to i64
  %bext = zext i32 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i32
  ret i32 %trunc
}

define i32 @abd_ext_i32_i16(i32 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_ext_i32_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w1, #0xffff
; CHECK-NEXT:    sub w9, w8, w0
; CHECK-NEXT:    subs w8, w0, w8
; CHECK-NEXT:    csel w0, w8, w9, hi
; CHECK-NEXT:    ret
  %aext = zext i32 %a to i64
  %bext = zext i16 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 false)
  %trunc = trunc i64 %abs to i32
  ret i32 %trunc
}

define i32 @abd_ext_i32_undef(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: abd_ext_i32_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    subs w9, w0, w1
; CHECK-NEXT:    csel w0, w9, w8, hi
; CHECK-NEXT:    ret
  %aext = zext i32 %a to i64
  %bext = zext i32 %b to i64
  %sub = sub i64 %aext, %bext
  %abs = call i64 @llvm.abs.i64(i64 %sub, i1 true)
  %trunc = trunc i64 %abs to i32
  ret i32 %trunc
}

define i64 @abd_ext_i64(i64 %a, i64 %b) nounwind {
; CHECK-LABEL: abd_ext_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x1, x0
; CHECK-NEXT:    subs x9, x0, x1
; CHECK-NEXT:    csel x0, x9, x8, hi
; CHECK-NEXT:    ret
  %aext = zext i64 %a to i128
  %bext = zext i64 %b to i128
  %sub = sub i128 %aext, %bext
  %abs = call i128 @llvm.abs.i128(i128 %sub, i1 false)
  %trunc = trunc i128 %abs to i64
  ret i64 %trunc
}

define i64 @abd_ext_i64_undef(i64 %a, i64 %b) nounwind {
; CHECK-LABEL: abd_ext_i64_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x1, x0
; CHECK-NEXT:    subs x9, x0, x1
; CHECK-NEXT:    csel x0, x9, x8, hi
; CHECK-NEXT:    ret
  %aext = zext i64 %a to i128
  %bext = zext i64 %b to i128
  %sub = sub i128 %aext, %bext
  %abs = call i128 @llvm.abs.i128(i128 %sub, i1 true)
  %trunc = trunc i128 %abs to i64
  ret i64 %trunc
}

define i128 @abd_ext_i128(i128 %a, i128 %b) nounwind {
; CHECK-LABEL: abd_ext_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x0, x2
; CHECK-NEXT:    sbcs x9, x1, x3
; CHECK-NEXT:    cset w10, lo
; CHECK-NEXT:    sbfx x10, x10, #0, #1
; CHECK-NEXT:    eor x8, x8, x10
; CHECK-NEXT:    eor x9, x9, x10
; CHECK-NEXT:    subs x0, x8, x10
; CHECK-NEXT:    sbc x1, x9, x10
; CHECK-NEXT:    ret
  %aext = zext i128 %a to i256
  %bext = zext i128 %b to i256
  %sub = sub i256 %aext, %bext
  %abs = call i256 @llvm.abs.i256(i256 %sub, i1 false)
  %trunc = trunc i256 %abs to i128
  ret i128 %trunc
}

define i128 @abd_ext_i128_undef(i128 %a, i128 %b) nounwind {
; CHECK-LABEL: abd_ext_i128_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x0, x2
; CHECK-NEXT:    sbcs x9, x1, x3
; CHECK-NEXT:    cset w10, lo
; CHECK-NEXT:    sbfx x10, x10, #0, #1
; CHECK-NEXT:    eor x8, x8, x10
; CHECK-NEXT:    eor x9, x9, x10
; CHECK-NEXT:    subs x0, x8, x10
; CHECK-NEXT:    sbc x1, x9, x10
; CHECK-NEXT:    ret
  %aext = zext i128 %a to i256
  %bext = zext i128 %b to i256
  %sub = sub i256 %aext, %bext
  %abs = call i256 @llvm.abs.i256(i256 %sub, i1 true)
  %trunc = trunc i256 %abs to i128
  ret i128 %trunc
}

;
; sub(umax(a,b),umin(a,b)) -> abdu(a,b)
;

define i8 @abd_minmax_i8(i8 %a, i8 %b) nounwind {
; CHECK-LABEL: abd_minmax_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    sub w8, w8, w1, uxtb
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %min = call i8 @llvm.umin.i8(i8 %a, i8 %b)
  %max = call i8 @llvm.umax.i8(i8 %a, i8 %b)
  %sub = sub i8 %max, %min
  ret i8 %sub
}

define i16 @abd_minmax_i16(i16 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_minmax_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w8, w8, w1, uxth
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %min = call i16 @llvm.umin.i16(i16 %a, i16 %b)
  %max = call i16 @llvm.umax.i16(i16 %a, i16 %b)
  %sub = sub i16 %max, %min
  ret i16 %sub
}

define i32 @abd_minmax_i32(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: abd_minmax_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    subs w9, w0, w1
; CHECK-NEXT:    csel w0, w9, w8, hi
; CHECK-NEXT:    ret
  %min = call i32 @llvm.umin.i32(i32 %a, i32 %b)
  %max = call i32 @llvm.umax.i32(i32 %a, i32 %b)
  %sub = sub i32 %max, %min
  ret i32 %sub
}

define i64 @abd_minmax_i64(i64 %a, i64 %b) nounwind {
; CHECK-LABEL: abd_minmax_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x1, x0
; CHECK-NEXT:    subs x9, x0, x1
; CHECK-NEXT:    csel x0, x9, x8, hi
; CHECK-NEXT:    ret
  %min = call i64 @llvm.umin.i64(i64 %a, i64 %b)
  %max = call i64 @llvm.umax.i64(i64 %a, i64 %b)
  %sub = sub i64 %max, %min
  ret i64 %sub
}

define i128 @abd_minmax_i128(i128 %a, i128 %b) nounwind {
; CHECK-LABEL: abd_minmax_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x0, x2
; CHECK-NEXT:    sbcs x9, x1, x3
; CHECK-NEXT:    cset w10, lo
; CHECK-NEXT:    sbfx x10, x10, #0, #1
; CHECK-NEXT:    eor x8, x8, x10
; CHECK-NEXT:    eor x9, x9, x10
; CHECK-NEXT:    subs x0, x8, x10
; CHECK-NEXT:    sbc x1, x9, x10
; CHECK-NEXT:    ret
  %min = call i128 @llvm.umin.i128(i128 %a, i128 %b)
  %max = call i128 @llvm.umax.i128(i128 %a, i128 %b)
  %sub = sub i128 %max, %min
  ret i128 %sub
}

;
; select(icmp(a,b),sub(a,b),sub(b,a)) -> abdu(a,b)
;

define i8 @abd_cmp_i8(i8 %a, i8 %b) nounwind {
; CHECK-LABEL: abd_cmp_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    sub w8, w8, w1, uxtb
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %cmp = icmp ugt i8 %a, %b
  %ab = sub i8 %a, %b
  %ba = sub i8 %b, %a
  %sel = select i1 %cmp, i8 %ab, i8 %ba
  ret i8 %sel
}

define i16 @abd_cmp_i16(i16 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_cmp_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w8, w8, w1, uxth
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cneg w0, w8, mi
; CHECK-NEXT:    ret
  %cmp = icmp uge i16 %a, %b
  %ab = sub i16 %a, %b
  %ba = sub i16 %b, %a
  %sel = select i1 %cmp, i16 %ab, i16 %ba
  ret i16 %sel
}

define i32 @abd_cmp_i32(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: abd_cmp_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    subs w9, w0, w1
; CHECK-NEXT:    csel w0, w9, w8, hi
; CHECK-NEXT:    ret
  %cmp = icmp ult i32 %a, %b
  %ab = sub i32 %a, %b
  %ba = sub i32 %b, %a
  %sel = select i1 %cmp, i32 %ba, i32 %ab
  ret i32 %sel
}

define i64 @abd_cmp_i64(i64 %a, i64 %b) nounwind {
; CHECK-LABEL: abd_cmp_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x1, x0
; CHECK-NEXT:    subs x9, x0, x1
; CHECK-NEXT:    csel x0, x9, x8, hi
; CHECK-NEXT:    ret
  %cmp = icmp uge i64 %a, %b
  %ab = sub i64 %a, %b
  %ba = sub i64 %b, %a
  %sel = select i1 %cmp, i64 %ab, i64 %ba
  ret i64 %sel
}

define i128 @abd_cmp_i128(i128 %a, i128 %b) nounwind {
; CHECK-LABEL: abd_cmp_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x0, x2
; CHECK-NEXT:    sbcs x9, x1, x3
; CHECK-NEXT:    cset w10, lo
; CHECK-NEXT:    sbfx x10, x10, #0, #1
; CHECK-NEXT:    eor x8, x8, x10
; CHECK-NEXT:    eor x9, x9, x10
; CHECK-NEXT:    subs x0, x8, x10
; CHECK-NEXT:    sbc x1, x9, x10
; CHECK-NEXT:    ret
  %cmp = icmp uge i128 %a, %b
  %ab = sub i128 %a, %b
  %ba = sub i128 %b, %a
  %sel = select i1 %cmp, i128 %ab, i128 %ba
  ret i128 %sel
}

;
; negative tests
;

define i64 @vector_legalized(i16 %a, i16 %b) {
; CHECK-LABEL: vector_legalized:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    sub w8, w8, w1, uxth
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    addp d0, v0.2d
; CHECK-NEXT:    cneg w8, w8, mi
; CHECK-NEXT:    fmov x9, d0
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    ret
  %ea = zext i16 %a to i32
  %eb = zext i16 %b to i32
  %s = sub i32 %ea, %eb
  %ab = call i32 @llvm.abs.i32(i32 %s, i1 false)
  %e = zext i32 %ab to i64
  %red = call i64 @llvm.vector.reduce.add.v32i64(<32 x i64> zeroinitializer)
  %z = add i64 %red, %e
  ret i64 %z
}

;
; sub(select(icmp(a,b),a,b),select(icmp(a,b),b,a)) -> abdu(a,b)
;

define i8 @abd_select_i8(i8 %a, i8 %b) nounwind {
; CHECK-LABEL: abd_select_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    cmp w8, w1, uxtb
; CHECK-NEXT:    csel w8, w0, w1, lo
; CHECK-NEXT:    csel w9, w1, w0, lo
; CHECK-NEXT:    sub w0, w9, w8
; CHECK-NEXT:    ret
  %cmp = icmp ult i8 %a, %b
  %ab = select i1 %cmp, i8 %a, i8 %b
  %ba = select i1 %cmp, i8 %b, i8 %a
  %sub = sub i8 %ba, %ab
  ret i8 %sub
}

define i16 @abd_select_i16(i16 %a, i16 %b) nounwind {
; CHECK-LABEL: abd_select_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    cmp w8, w1, uxth
; CHECK-NEXT:    csel w8, w0, w1, ls
; CHECK-NEXT:    csel w9, w1, w0, ls
; CHECK-NEXT:    sub w0, w9, w8
; CHECK-NEXT:    ret
  %cmp = icmp ule i16 %a, %b
  %ab = select i1 %cmp, i16 %a, i16 %b
  %ba = select i1 %cmp, i16 %b, i16 %a
  %sub = sub i16 %ba, %ab
  ret i16 %sub
}

define i32 @abd_select_i32(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: abd_select_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, w1
; CHECK-NEXT:    csel w8, w0, w1, hi
; CHECK-NEXT:    csel w9, w1, w0, hi
; CHECK-NEXT:    sub w0, w8, w9
; CHECK-NEXT:    ret
  %cmp = icmp ugt i32 %a, %b
  %ab = select i1 %cmp, i32 %a, i32 %b
  %ba = select i1 %cmp, i32 %b, i32 %a
  %sub = sub i32 %ab, %ba
  ret i32 %sub
}

define i64 @abd_select_i64(i64 %a, i64 %b) nounwind {
; CHECK-LABEL: abd_select_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp x0, x1
; CHECK-NEXT:    csel x8, x0, x1, hs
; CHECK-NEXT:    csel x9, x1, x0, hs
; CHECK-NEXT:    sub x0, x8, x9
; CHECK-NEXT:    ret
  %cmp = icmp uge i64 %a, %b
  %ab = select i1 %cmp, i64 %a, i64 %b
  %ba = select i1 %cmp, i64 %b, i64 %a
  %sub = sub i64 %ab, %ba
  ret i64 %sub
}

define i128 @abd_select_i128(i128 %a, i128 %b) nounwind {
; CHECK-LABEL: abd_select_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp x0, x2
; CHECK-NEXT:    sbcs xzr, x1, x3
; CHECK-NEXT:    csel x8, x0, x2, lo
; CHECK-NEXT:    csel x9, x2, x0, lo
; CHECK-NEXT:    csel x10, x1, x3, lo
; CHECK-NEXT:    csel x11, x3, x1, lo
; CHECK-NEXT:    subs x0, x9, x8
; CHECK-NEXT:    sbc x1, x11, x10
; CHECK-NEXT:    ret
  %cmp = icmp ult i128 %a, %b
  %ab = select i1 %cmp, i128 %a, i128 %b
  %ba = select i1 %cmp, i128 %b, i128 %a
  %sub = sub i128 %ba, %ab
  ret i128 %sub
}

declare i8 @llvm.abs.i8(i8, i1)
declare i16 @llvm.abs.i16(i16, i1)
declare i32 @llvm.abs.i32(i32, i1)
declare i64 @llvm.abs.i64(i64, i1)
declare i128 @llvm.abs.i128(i128, i1)

declare i8 @llvm.umax.i8(i8, i8)
declare i16 @llvm.umax.i16(i16, i16)
declare i32 @llvm.umax.i32(i32, i32)
declare i64 @llvm.umax.i64(i64, i64)

declare i8 @llvm.umin.i8(i8, i8)
declare i16 @llvm.umin.i16(i16, i16)
declare i32 @llvm.umin.i32(i32, i32)
declare i64 @llvm.umin.i64(i64, i64)

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-CVT
; RUN: llc < %s -mtriple=aarch64 -mattr=+fullfp16 | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-FP16
; RUN: llc < %s -mtriple=aarch64 -global-isel -global-isel-abort=2 2>&1 | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-CVT
; RUN: llc < %s -mtriple=aarch64 -mattr=+fullfp16 -global-isel -global-isel-abort=2 2>&1 | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-FP16

;
; 32-bit float to unsigned integer
;

declare   i1 @llvm.fptoui.sat.i1.f32  (float)
declare   i8 @llvm.fptoui.sat.i8.f32  (float)
declare  i13 @llvm.fptoui.sat.i13.f32 (float)
declare  i16 @llvm.fptoui.sat.i16.f32 (float)
declare  i19 @llvm.fptoui.sat.i19.f32 (float)
declare  i32 @llvm.fptoui.sat.i32.f32 (float)
declare  i50 @llvm.fptoui.sat.i50.f32 (float)
declare  i64 @llvm.fptoui.sat.i64.f32 (float)
declare i100 @llvm.fptoui.sat.i100.f32(float)
declare i128 @llvm.fptoui.sat.i128.f32(float)

define i1 @test_unsigned_i1_f32(float %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i1_f32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    fcvtzu w8, s0
; CHECK-SD-NEXT:    cmp w8, #1
; CHECK-SD-NEXT:    csinc w0, w8, wzr, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_i1_f32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fcvtzu w8, s0
; CHECK-GI-NEXT:    cmp w8, #1
; CHECK-GI-NEXT:    csinc w8, w8, wzr, lo
; CHECK-GI-NEXT:    and w0, w8, #0x1
; CHECK-GI-NEXT:    ret
    %x = call i1 @llvm.fptoui.sat.i1.f32(float %f)
    ret i1 %x
}

define i8 @test_unsigned_i8_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i8_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w9, s0
; CHECK-NEXT:    mov w8, #255 // =0xff
; CHECK-NEXT:    cmp w9, #255
; CHECK-NEXT:    csel w0, w9, w8, lo
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptoui.sat.i8.f32(float %f)
    ret i8 %x
}

define i13 @test_unsigned_i13_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i13_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    mov w9, #8191 // =0x1fff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptoui.sat.i13.f32(float %f)
    ret i13 %x
}

define i16 @test_unsigned_i16_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i16_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptoui.sat.i16.f32(float %f)
    ret i16 %x
}

define i19 @test_unsigned_i19_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i19_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    mov w9, #524287 // =0x7ffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptoui.sat.i19.f32(float %f)
    ret i19 %x
}

define i32 @test_unsigned_i32_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i32_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptoui.sat.i32.f32(float %f)
    ret i32 %x
}

define i50 @test_unsigned_i50_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i50_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu x8, s0
; CHECK-NEXT:    mov x9, #1125899906842623 // =0x3ffffffffffff
; CHECK-NEXT:    cmp x8, x9
; CHECK-NEXT:    csel x0, x8, x9, lo
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptoui.sat.i50.f32(float %f)
    ret i50 %x
}

define i64 @test_unsigned_i64_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i64_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu x0, s0
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptoui.sat.i64.f32(float %f)
    ret i64 %x
}

define i100 @test_unsigned_i100_f32(float %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i100_f32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-SD-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-SD-NEXT:    fmov s8, s0
; CHECK-SD-NEXT:    bl __fixunssfti
; CHECK-SD-NEXT:    mov w8, #1904214015 // =0x717fffff
; CHECK-SD-NEXT:    fcmp s8, #0.0
; CHECK-SD-NEXT:    mov x10, #68719476735 // =0xfffffffff
; CHECK-SD-NEXT:    fmov s0, w8
; CHECK-SD-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-SD-NEXT:    csel x8, xzr, x0, lt
; CHECK-SD-NEXT:    csel x9, xzr, x1, lt
; CHECK-SD-NEXT:    fcmp s8, s0
; CHECK-SD-NEXT:    csel x1, x10, x9, gt
; CHECK-SD-NEXT:    csinv x0, x8, xzr, le
; CHECK-SD-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_i100_f32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-GI-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-GI-NEXT:    fmov s8, s0
; CHECK-GI-NEXT:    bl __fixunssfti
; CHECK-GI-NEXT:    mov w8, #1904214015 // =0x717fffff
; CHECK-GI-NEXT:    fcmp s8, #0.0
; CHECK-GI-NEXT:    mov x10, #68719476735 // =0xfffffffff
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-GI-NEXT:    csel x8, xzr, x0, lt
; CHECK-GI-NEXT:    csel x9, xzr, x1, lt
; CHECK-GI-NEXT:    fcmp s8, s0
; CHECK-GI-NEXT:    csinv x0, x8, xzr, le
; CHECK-GI-NEXT:    csel x1, x10, x9, gt
; CHECK-GI-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-GI-NEXT:    ret
    %x = call i100 @llvm.fptoui.sat.i100.f32(float %f)
    ret i100 %x
}

define i128 @test_unsigned_i128_f32(float %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i128_f32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-SD-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-SD-NEXT:    fmov s8, s0
; CHECK-SD-NEXT:    bl __fixunssfti
; CHECK-SD-NEXT:    mov w8, #2139095039 // =0x7f7fffff
; CHECK-SD-NEXT:    fcmp s8, #0.0
; CHECK-SD-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-SD-NEXT:    fmov s0, w8
; CHECK-SD-NEXT:    csel x8, xzr, x1, lt
; CHECK-SD-NEXT:    csel x9, xzr, x0, lt
; CHECK-SD-NEXT:    fcmp s8, s0
; CHECK-SD-NEXT:    csinv x0, x9, xzr, le
; CHECK-SD-NEXT:    csinv x1, x8, xzr, le
; CHECK-SD-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_i128_f32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-GI-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-GI-NEXT:    fmov s8, s0
; CHECK-GI-NEXT:    bl __fixunssfti
; CHECK-GI-NEXT:    mov w8, #2139095039 // =0x7f7fffff
; CHECK-GI-NEXT:    fcmp s8, #0.0
; CHECK-GI-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    csel x8, xzr, x0, lt
; CHECK-GI-NEXT:    csel x9, xzr, x1, lt
; CHECK-GI-NEXT:    fcmp s8, s0
; CHECK-GI-NEXT:    csinv x0, x8, xzr, le
; CHECK-GI-NEXT:    csinv x1, x9, xzr, le
; CHECK-GI-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-GI-NEXT:    ret
    %x = call i128 @llvm.fptoui.sat.i128.f32(float %f)
    ret i128 %x
}

;
; 64-bit float to unsigned integer
;

declare   i1 @llvm.fptoui.sat.i1.f64  (double)
declare   i8 @llvm.fptoui.sat.i8.f64  (double)
declare  i13 @llvm.fptoui.sat.i13.f64 (double)
declare  i16 @llvm.fptoui.sat.i16.f64 (double)
declare  i19 @llvm.fptoui.sat.i19.f64 (double)
declare  i32 @llvm.fptoui.sat.i32.f64 (double)
declare  i50 @llvm.fptoui.sat.i50.f64 (double)
declare  i64 @llvm.fptoui.sat.i64.f64 (double)
declare i100 @llvm.fptoui.sat.i100.f64(double)
declare i128 @llvm.fptoui.sat.i128.f64(double)

define i1 @test_unsigned_i1_f64(double %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i1_f64:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    fcvtzu w8, d0
; CHECK-SD-NEXT:    cmp w8, #1
; CHECK-SD-NEXT:    csinc w0, w8, wzr, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_i1_f64:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fcvtzu w8, d0
; CHECK-GI-NEXT:    cmp w8, #1
; CHECK-GI-NEXT:    csinc w8, w8, wzr, lo
; CHECK-GI-NEXT:    and w0, w8, #0x1
; CHECK-GI-NEXT:    ret
    %x = call i1 @llvm.fptoui.sat.i1.f64(double %f)
    ret i1 %x
}

define i8 @test_unsigned_i8_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i8_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w9, d0
; CHECK-NEXT:    mov w8, #255 // =0xff
; CHECK-NEXT:    cmp w9, #255
; CHECK-NEXT:    csel w0, w9, w8, lo
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptoui.sat.i8.f64(double %f)
    ret i8 %x
}

define i13 @test_unsigned_i13_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i13_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w8, d0
; CHECK-NEXT:    mov w9, #8191 // =0x1fff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptoui.sat.i13.f64(double %f)
    ret i13 %x
}

define i16 @test_unsigned_i16_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i16_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w8, d0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptoui.sat.i16.f64(double %f)
    ret i16 %x
}

define i19 @test_unsigned_i19_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i19_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w8, d0
; CHECK-NEXT:    mov w9, #524287 // =0x7ffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptoui.sat.i19.f64(double %f)
    ret i19 %x
}

define i32 @test_unsigned_i32_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i32_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptoui.sat.i32.f64(double %f)
    ret i32 %x
}

define i50 @test_unsigned_i50_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i50_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu x8, d0
; CHECK-NEXT:    mov x9, #1125899906842623 // =0x3ffffffffffff
; CHECK-NEXT:    cmp x8, x9
; CHECK-NEXT:    csel x0, x8, x9, lo
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptoui.sat.i50.f64(double %f)
    ret i50 %x
}

define i64 @test_unsigned_i64_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i64_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu x0, d0
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptoui.sat.i64.f64(double %f)
    ret i64 %x
}

define i100 @test_unsigned_i100_f64(double %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i100_f64:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-SD-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-SD-NEXT:    fmov d8, d0
; CHECK-SD-NEXT:    bl __fixunsdfti
; CHECK-SD-NEXT:    mov x8, #5057542381537067007 // =0x462fffffffffffff
; CHECK-SD-NEXT:    fcmp d8, #0.0
; CHECK-SD-NEXT:    mov x10, #68719476735 // =0xfffffffff
; CHECK-SD-NEXT:    fmov d0, x8
; CHECK-SD-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-SD-NEXT:    csel x8, xzr, x0, lt
; CHECK-SD-NEXT:    csel x9, xzr, x1, lt
; CHECK-SD-NEXT:    fcmp d8, d0
; CHECK-SD-NEXT:    csel x1, x10, x9, gt
; CHECK-SD-NEXT:    csinv x0, x8, xzr, le
; CHECK-SD-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_i100_f64:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-GI-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-GI-NEXT:    fmov d8, d0
; CHECK-GI-NEXT:    bl __fixunsdfti
; CHECK-GI-NEXT:    mov x8, #5057542381537067007 // =0x462fffffffffffff
; CHECK-GI-NEXT:    fcmp d8, #0.0
; CHECK-GI-NEXT:    mov x10, #68719476735 // =0xfffffffff
; CHECK-GI-NEXT:    fmov d0, x8
; CHECK-GI-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-GI-NEXT:    csel x8, xzr, x0, lt
; CHECK-GI-NEXT:    csel x9, xzr, x1, lt
; CHECK-GI-NEXT:    fcmp d8, d0
; CHECK-GI-NEXT:    csinv x0, x8, xzr, le
; CHECK-GI-NEXT:    csel x1, x10, x9, gt
; CHECK-GI-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-GI-NEXT:    ret
    %x = call i100 @llvm.fptoui.sat.i100.f64(double %f)
    ret i100 %x
}

define i128 @test_unsigned_i128_f64(double %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i128_f64:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-SD-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-SD-NEXT:    fmov d8, d0
; CHECK-SD-NEXT:    bl __fixunsdfti
; CHECK-SD-NEXT:    mov x8, #5183643171103440895 // =0x47efffffffffffff
; CHECK-SD-NEXT:    fcmp d8, #0.0
; CHECK-SD-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-SD-NEXT:    fmov d0, x8
; CHECK-SD-NEXT:    csel x8, xzr, x1, lt
; CHECK-SD-NEXT:    csel x9, xzr, x0, lt
; CHECK-SD-NEXT:    fcmp d8, d0
; CHECK-SD-NEXT:    csinv x0, x9, xzr, le
; CHECK-SD-NEXT:    csinv x1, x8, xzr, le
; CHECK-SD-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_i128_f64:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-GI-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-GI-NEXT:    fmov d8, d0
; CHECK-GI-NEXT:    bl __fixunsdfti
; CHECK-GI-NEXT:    mov x8, #5183643171103440895 // =0x47efffffffffffff
; CHECK-GI-NEXT:    fcmp d8, #0.0
; CHECK-GI-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-GI-NEXT:    fmov d0, x8
; CHECK-GI-NEXT:    csel x8, xzr, x0, lt
; CHECK-GI-NEXT:    csel x9, xzr, x1, lt
; CHECK-GI-NEXT:    fcmp d8, d0
; CHECK-GI-NEXT:    csinv x0, x8, xzr, le
; CHECK-GI-NEXT:    csinv x1, x9, xzr, le
; CHECK-GI-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-GI-NEXT:    ret
    %x = call i128 @llvm.fptoui.sat.i128.f64(double %f)
    ret i128 %x
}

;
; 16-bit float to unsigned integer
;

declare   i1 @llvm.fptoui.sat.i1.f16  (half)
declare   i8 @llvm.fptoui.sat.i8.f16  (half)
declare  i13 @llvm.fptoui.sat.i13.f16 (half)
declare  i16 @llvm.fptoui.sat.i16.f16 (half)
declare  i19 @llvm.fptoui.sat.i19.f16 (half)
declare  i32 @llvm.fptoui.sat.i32.f16 (half)
declare  i50 @llvm.fptoui.sat.i50.f16 (half)
declare  i64 @llvm.fptoui.sat.i64.f16 (half)
declare i100 @llvm.fptoui.sat.i100.f16(half)
declare i128 @llvm.fptoui.sat.i128.f16(half)

define i1 @test_unsigned_i1_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i1_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    fcvtzu w8, s0
; CHECK-SD-CVT-NEXT:    cmp w8, #1
; CHECK-SD-CVT-NEXT:    csinc w0, w8, wzr, lo
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i1_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu w8, h0
; CHECK-SD-FP16-NEXT:    cmp w8, #1
; CHECK-SD-FP16-NEXT:    csinc w0, w8, wzr, lo
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i1_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    fcvtzu w8, s0
; CHECK-GI-CVT-NEXT:    cmp w8, #1
; CHECK-GI-CVT-NEXT:    csinc w8, w8, wzr, lo
; CHECK-GI-CVT-NEXT:    and w0, w8, #0x1
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i1_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu w8, h0
; CHECK-GI-FP16-NEXT:    cmp w8, #1
; CHECK-GI-FP16-NEXT:    csinc w8, w8, wzr, lo
; CHECK-GI-FP16-NEXT:    and w0, w8, #0x1
; CHECK-GI-FP16-NEXT:    ret
    %x = call i1 @llvm.fptoui.sat.i1.f16(half %f)
    ret i1 %x
}

define i8 @test_unsigned_i8_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i8_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    mov w8, #255 // =0xff
; CHECK-SD-CVT-NEXT:    fcvtzu w9, s0
; CHECK-SD-CVT-NEXT:    cmp w9, #255
; CHECK-SD-CVT-NEXT:    csel w0, w9, w8, lo
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i8_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu w9, h0
; CHECK-SD-FP16-NEXT:    mov w8, #255 // =0xff
; CHECK-SD-FP16-NEXT:    cmp w9, #255
; CHECK-SD-FP16-NEXT:    csel w0, w9, w8, lo
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i8_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov w8, #255 // =0xff
; CHECK-GI-CVT-NEXT:    fcvtzu w9, s0
; CHECK-GI-CVT-NEXT:    cmp w9, #255
; CHECK-GI-CVT-NEXT:    csel w0, w9, w8, lo
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i8_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu w9, h0
; CHECK-GI-FP16-NEXT:    mov w8, #255 // =0xff
; CHECK-GI-FP16-NEXT:    cmp w9, #255
; CHECK-GI-FP16-NEXT:    csel w0, w9, w8, lo
; CHECK-GI-FP16-NEXT:    ret
    %x = call i8 @llvm.fptoui.sat.i8.f16(half %f)
    ret i8 %x
}

define i13 @test_unsigned_i13_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i13_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    mov w9, #8191 // =0x1fff
; CHECK-SD-CVT-NEXT:    fcvtzu w8, s0
; CHECK-SD-CVT-NEXT:    cmp w8, w9
; CHECK-SD-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i13_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu w8, h0
; CHECK-SD-FP16-NEXT:    mov w9, #8191 // =0x1fff
; CHECK-SD-FP16-NEXT:    cmp w8, w9
; CHECK-SD-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i13_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov w9, #8191 // =0x1fff
; CHECK-GI-CVT-NEXT:    fcvtzu w8, s0
; CHECK-GI-CVT-NEXT:    cmp w8, w9
; CHECK-GI-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i13_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu w8, h0
; CHECK-GI-FP16-NEXT:    mov w9, #8191 // =0x1fff
; CHECK-GI-FP16-NEXT:    cmp w8, w9
; CHECK-GI-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-GI-FP16-NEXT:    ret
    %x = call i13 @llvm.fptoui.sat.i13.f16(half %f)
    ret i13 %x
}

define i16 @test_unsigned_i16_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i16_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    mov w9, #65535 // =0xffff
; CHECK-SD-CVT-NEXT:    fcvtzu w8, s0
; CHECK-SD-CVT-NEXT:    cmp w8, w9
; CHECK-SD-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i16_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu w8, h0
; CHECK-SD-FP16-NEXT:    mov w9, #65535 // =0xffff
; CHECK-SD-FP16-NEXT:    cmp w8, w9
; CHECK-SD-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i16_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov w9, #65535 // =0xffff
; CHECK-GI-CVT-NEXT:    fcvtzu w8, s0
; CHECK-GI-CVT-NEXT:    cmp w8, w9
; CHECK-GI-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i16_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu w8, h0
; CHECK-GI-FP16-NEXT:    mov w9, #65535 // =0xffff
; CHECK-GI-FP16-NEXT:    cmp w8, w9
; CHECK-GI-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-GI-FP16-NEXT:    ret
    %x = call i16 @llvm.fptoui.sat.i16.f16(half %f)
    ret i16 %x
}

define i19 @test_unsigned_i19_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i19_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    mov w9, #524287 // =0x7ffff
; CHECK-SD-CVT-NEXT:    fcvtzu w8, s0
; CHECK-SD-CVT-NEXT:    cmp w8, w9
; CHECK-SD-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i19_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu w8, h0
; CHECK-SD-FP16-NEXT:    mov w9, #524287 // =0x7ffff
; CHECK-SD-FP16-NEXT:    cmp w8, w9
; CHECK-SD-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i19_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov w9, #524287 // =0x7ffff
; CHECK-GI-CVT-NEXT:    fcvtzu w8, s0
; CHECK-GI-CVT-NEXT:    cmp w8, w9
; CHECK-GI-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i19_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu w8, h0
; CHECK-GI-FP16-NEXT:    mov w9, #524287 // =0x7ffff
; CHECK-GI-FP16-NEXT:    cmp w8, w9
; CHECK-GI-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-GI-FP16-NEXT:    ret
    %x = call i19 @llvm.fptoui.sat.i19.f16(half %f)
    ret i19 %x
}

define i32 @test_unsigned_i32_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i32_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    fcvtzu w0, s0
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i32_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu w0, h0
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i32_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    fcvtzu w0, s0
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i32_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu w0, h0
; CHECK-GI-FP16-NEXT:    ret
    %x = call i32 @llvm.fptoui.sat.i32.f16(half %f)
    ret i32 %x
}

define i50 @test_unsigned_i50_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i50_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    mov x9, #1125899906842623 // =0x3ffffffffffff
; CHECK-SD-CVT-NEXT:    fcvtzu x8, s0
; CHECK-SD-CVT-NEXT:    cmp x8, x9
; CHECK-SD-CVT-NEXT:    csel x0, x8, x9, lo
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i50_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu x8, h0
; CHECK-SD-FP16-NEXT:    mov x9, #1125899906842623 // =0x3ffffffffffff
; CHECK-SD-FP16-NEXT:    cmp x8, x9
; CHECK-SD-FP16-NEXT:    csel x0, x8, x9, lo
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i50_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov x9, #1125899906842623 // =0x3ffffffffffff
; CHECK-GI-CVT-NEXT:    fcvtzu x8, s0
; CHECK-GI-CVT-NEXT:    cmp x8, x9
; CHECK-GI-CVT-NEXT:    csel x0, x8, x9, lo
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i50_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu x8, h0
; CHECK-GI-FP16-NEXT:    mov x9, #1125899906842623 // =0x3ffffffffffff
; CHECK-GI-FP16-NEXT:    cmp x8, x9
; CHECK-GI-FP16-NEXT:    csel x0, x8, x9, lo
; CHECK-GI-FP16-NEXT:    ret
    %x = call i50 @llvm.fptoui.sat.i50.f16(half %f)
    ret i50 %x
}

define i64 @test_unsigned_i64_f16(half %f) nounwind {
; CHECK-SD-CVT-LABEL: test_unsigned_i64_f16:
; CHECK-SD-CVT:       // %bb.0:
; CHECK-SD-CVT-NEXT:    fcvt s0, h0
; CHECK-SD-CVT-NEXT:    fcvtzu x0, s0
; CHECK-SD-CVT-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: test_unsigned_i64_f16:
; CHECK-SD-FP16:       // %bb.0:
; CHECK-SD-FP16-NEXT:    fcvtzu x0, h0
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i64_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    fcvtzu x0, s0
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i64_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu x0, h0
; CHECK-GI-FP16-NEXT:    ret
    %x = call i64 @llvm.fptoui.sat.i64.f16(half %f)
    ret i64 %x
}

define i100 @test_unsigned_i100_f16(half %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i100_f16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-SD-NEXT:    fcvt s8, h0
; CHECK-SD-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-SD-NEXT:    fmov s0, s8
; CHECK-SD-NEXT:    bl __fixunssfti
; CHECK-SD-NEXT:    mov w8, #1904214015 // =0x717fffff
; CHECK-SD-NEXT:    fcmp s8, #0.0
; CHECK-SD-NEXT:    mov x10, #68719476735 // =0xfffffffff
; CHECK-SD-NEXT:    fmov s0, w8
; CHECK-SD-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-SD-NEXT:    csel x8, xzr, x0, lt
; CHECK-SD-NEXT:    csel x9, xzr, x1, lt
; CHECK-SD-NEXT:    fcmp s8, s0
; CHECK-SD-NEXT:    csel x1, x10, x9, gt
; CHECK-SD-NEXT:    csinv x0, x8, xzr, le
; CHECK-SD-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i100_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov x1, xzr
; CHECK-GI-CVT-NEXT:    fcvtzu x0, s0
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i100_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu x0, h0
; CHECK-GI-FP16-NEXT:    mov x1, xzr
; CHECK-GI-FP16-NEXT:    ret
    %x = call i100 @llvm.fptoui.sat.i100.f16(half %f)
    ret i100 %x
}

define i128 @test_unsigned_i128_f16(half %f) nounwind {
; CHECK-SD-LABEL: test_unsigned_i128_f16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-SD-NEXT:    fcvt s8, h0
; CHECK-SD-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-SD-NEXT:    fmov s0, s8
; CHECK-SD-NEXT:    bl __fixunssfti
; CHECK-SD-NEXT:    mov w8, #2139095039 // =0x7f7fffff
; CHECK-SD-NEXT:    fcmp s8, #0.0
; CHECK-SD-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-SD-NEXT:    fmov s0, w8
; CHECK-SD-NEXT:    csel x8, xzr, x1, lt
; CHECK-SD-NEXT:    csel x9, xzr, x0, lt
; CHECK-SD-NEXT:    fcmp s8, s0
; CHECK-SD-NEXT:    csinv x0, x9, xzr, le
; CHECK-SD-NEXT:    csinv x1, x8, xzr, le
; CHECK-SD-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-CVT-LABEL: test_unsigned_i128_f16:
; CHECK-GI-CVT:       // %bb.0:
; CHECK-GI-CVT-NEXT:    fcvt s0, h0
; CHECK-GI-CVT-NEXT:    mov x1, xzr
; CHECK-GI-CVT-NEXT:    fcvtzu x0, s0
; CHECK-GI-CVT-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: test_unsigned_i128_f16:
; CHECK-GI-FP16:       // %bb.0:
; CHECK-GI-FP16-NEXT:    fcvtzu x0, h0
; CHECK-GI-FP16-NEXT:    mov x1, xzr
; CHECK-GI-FP16-NEXT:    ret
    %x = call i128 @llvm.fptoui.sat.i128.f16(half %f)
    ret i128 %x
}

define i32 @test_unsigned_f128_i32(fp128 %f) {
; CHECK-SD-LABEL: test_unsigned_f128_i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    sub sp, sp, #32
; CHECK-SD-NEXT:    stp x30, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-SD-NEXT:    .cfi_def_cfa_offset 32
; CHECK-SD-NEXT:    .cfi_offset w19, -8
; CHECK-SD-NEXT:    .cfi_offset w30, -16
; CHECK-SD-NEXT:    adrp x8, .LCPI30_0
; CHECK-SD-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-SD-NEXT:    ldr q1, [x8, :lo12:.LCPI30_0]
; CHECK-SD-NEXT:    bl __getf2
; CHECK-SD-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-SD-NEXT:    mov w19, w0
; CHECK-SD-NEXT:    bl __fixunstfsi
; CHECK-SD-NEXT:    adrp x8, .LCPI30_1
; CHECK-SD-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-SD-NEXT:    cmp w19, #0
; CHECK-SD-NEXT:    ldr q1, [x8, :lo12:.LCPI30_1]
; CHECK-SD-NEXT:    csel w19, wzr, w0, lt
; CHECK-SD-NEXT:    bl __gttf2
; CHECK-SD-NEXT:    cmp w0, #0
; CHECK-SD-NEXT:    csinv w0, w19, wzr, le
; CHECK-SD-NEXT:    ldp x30, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-SD-NEXT:    add sp, sp, #32
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_unsigned_f128_i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    sub sp, sp, #64
; CHECK-GI-NEXT:    stp d9, d8, [sp, #32] // 16-byte Folded Spill
; CHECK-GI-NEXT:    str x30, [sp, #48] // 8-byte Folded Spill
; CHECK-GI-NEXT:    .cfi_def_cfa_offset 64
; CHECK-GI-NEXT:    .cfi_offset w30, -16
; CHECK-GI-NEXT:    .cfi_offset b8, -24
; CHECK-GI-NEXT:    .cfi_offset b9, -32
; CHECK-GI-NEXT:    adrp x8, .LCPI30_1
; CHECK-GI-NEXT:    ldr q1, [x8, :lo12:.LCPI30_1]
; CHECK-GI-NEXT:    stp q0, q1, [sp] // 32-byte Folded Spill
; CHECK-GI-NEXT:    bl __getf2
; CHECK-GI-NEXT:    ldp q3, q2, [sp] // 32-byte Folded Reload
; CHECK-GI-NEXT:    cmp w0, #0
; CHECK-GI-NEXT:    mov d0, v3.d[1]
; CHECK-GI-NEXT:    mov d1, v2.d[1]
; CHECK-GI-NEXT:    fcsel d8, d3, d2, lt
; CHECK-GI-NEXT:    fmov x8, d8
; CHECK-GI-NEXT:    fcsel d9, d0, d1, lt
; CHECK-GI-NEXT:    mov v0.d[0], x8
; CHECK-GI-NEXT:    fmov x8, d9
; CHECK-GI-NEXT:    mov v0.d[1], x8
; CHECK-GI-NEXT:    adrp x8, .LCPI30_0
; CHECK-GI-NEXT:    ldr q1, [x8, :lo12:.LCPI30_0]
; CHECK-GI-NEXT:    str q1, [sp, #16] // 16-byte Folded Spill
; CHECK-GI-NEXT:    bl __gttf2
; CHECK-GI-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; CHECK-GI-NEXT:    cmp w0, #0
; CHECK-GI-NEXT:    ldr x30, [sp, #48] // 8-byte Folded Reload
; CHECK-GI-NEXT:    mov d0, v1.d[1]
; CHECK-GI-NEXT:    fcsel d1, d8, d1, gt
; CHECK-GI-NEXT:    fmov x8, d1
; CHECK-GI-NEXT:    fcsel d2, d9, d0, gt
; CHECK-GI-NEXT:    ldp d9, d8, [sp, #32] // 16-byte Folded Reload
; CHECK-GI-NEXT:    mov v0.d[0], x8
; CHECK-GI-NEXT:    fmov x8, d2
; CHECK-GI-NEXT:    mov v0.d[1], x8
; CHECK-GI-NEXT:    add sp, sp, #64
; CHECK-GI-NEXT:    b __fixunstfsi
    %x = call i32 @llvm.fptoui.sat.i32.f128(fp128 %f)
    ret i32 %x
}

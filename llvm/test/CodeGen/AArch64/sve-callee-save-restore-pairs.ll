; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -aarch64-disable-multivector-spill-fill -verify-machineinstrs -force-streaming < %s | FileCheck %s --check-prefixes=NOPAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1 -aarch64-disable-multivector-spill-fill -verify-machineinstrs < %s |  FileCheck %s --check-prefixes=NOPAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme -verify-machineinstrs -force-streaming < %s | FileCheck %s --check-prefixes=NOPAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=NOPAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -verify-machineinstrs -force-streaming < %s | FileCheck %s --check-prefixes=PAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=PAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -mattr=+sve -verify-machineinstrs < %s | FileCheck %s --check-prefixes=NOPAIR
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2  -mattr=+sve -verify-machineinstrs -force-streaming < %s | FileCheck %s --check-prefixes=PAIR

declare void @my_func()

define void @fbyte(<vscale x 16 x i8> %v){
; NOPAIR-LABEL: fbyte:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-18
; NOPAIR-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; NOPAIR-NEXT:    .cfi_offset w30, -8
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 16 - 32 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 16 - 40 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 16 - 48 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 16 - 56 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 16 - 64 * VG
; NOPAIR-NEXT:    bl my_func
; NOPAIR-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #18
; NOPAIR-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: fbyte:
; PAIR:       // %bb.0:
; PAIR-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-18
; PAIR-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    ptrue pn8.b
; PAIR-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z22.b, z23.b }, pn8, [sp, #2, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    st1b { z20.b, z21.b }, pn8, [sp, #4, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z18.b, z19.b }, pn8, [sp, #6, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    st1b { z16.b, z17.b }, pn8, [sp, #8, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z14.b, z15.b }, pn8, [sp, #10, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    st1b { z12.b, z13.b }, pn8, [sp, #12, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z10.b, z11.b }, pn8, [sp, #14, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; PAIR-NEXT:    .cfi_offset w30, -8
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 16 - 32 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 16 - 40 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 16 - 48 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 16 - 56 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 16 - 64 * VG
; PAIR-NEXT:    bl my_func
; PAIR-NEXT:    ptrue pn8.b
; PAIR-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ld1b { z22.b, z23.b }, pn8/z, [sp, #2, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z20.b, z21.b }, pn8/z, [sp, #4, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z18.b, z19.b }, pn8/z, [sp, #6, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z16.b, z17.b }, pn8/z, [sp, #8, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z14.b, z15.b }, pn8/z, [sp, #10, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z12.b, z13.b }, pn8/z, [sp, #12, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z10.b, z11.b }, pn8/z, [sp, #14, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #18
; PAIR-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; PAIR-NEXT:    ret
  call void @my_func()
  ret void
}

define void @fhalf(<vscale x 8 x half> %v) {
; NOPAIR-LABEL: fhalf:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-18
; NOPAIR-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; NOPAIR-NEXT:    .cfi_offset w30, -8
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 16 - 32 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 16 - 40 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 16 - 48 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 16 - 56 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 16 - 64 * VG
; NOPAIR-NEXT:    bl my_func
; NOPAIR-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #18
; NOPAIR-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: fhalf:
; PAIR:       // %bb.0:
; PAIR-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-18
; PAIR-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    ptrue pn8.b
; PAIR-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z22.b, z23.b }, pn8, [sp, #2, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    st1b { z20.b, z21.b }, pn8, [sp, #4, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z18.b, z19.b }, pn8, [sp, #6, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    st1b { z16.b, z17.b }, pn8, [sp, #8, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z14.b, z15.b }, pn8, [sp, #10, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    st1b { z12.b, z13.b }, pn8, [sp, #12, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    st1b { z10.b, z11.b }, pn8, [sp, #14, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; PAIR-NEXT:    .cfi_offset w30, -8
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 16 - 32 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 16 - 40 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 16 - 48 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 16 - 56 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 16 - 64 * VG
; PAIR-NEXT:    bl my_func
; PAIR-NEXT:    ptrue pn8.b
; PAIR-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ld1b { z22.b, z23.b }, pn8/z, [sp, #2, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z20.b, z21.b }, pn8/z, [sp, #4, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z18.b, z19.b }, pn8/z, [sp, #6, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z16.b, z17.b }, pn8/z, [sp, #8, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z14.b, z15.b }, pn8/z, [sp, #10, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z12.b, z13.b }, pn8/z, [sp, #12, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ld1b { z10.b, z11.b }, pn8/z, [sp, #14, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #18
; PAIR-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; PAIR-NEXT:    ret
  call void @my_func()
  ret void
}

;; Do NOT group Z10
;; DO group Z8 and Z9 and save P8
define aarch64_sve_vector_pcs void @test_clobbers_z_p_regs() {
; NOPAIR-LABEL: test_clobbers_z_p_regs:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-4
; NOPAIR-NEXT:    str p5, [sp, #6, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p4, [sp, #7, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str z10, [sp, #1, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z9, [sp, #2, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z8, [sp, #3, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; NOPAIR-NEXT:    //APP
; NOPAIR-NEXT:    //NO_APP
; NOPAIR-NEXT:    ldr z10, [sp, #1, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z9, [sp, #2, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z8, [sp, #3, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr p5, [sp, #6, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p4, [sp, #7, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #4
; NOPAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: test_clobbers_z_p_regs:
; PAIR:       // %bb.0:
; PAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-4
; PAIR-NEXT:    str p8, [sp, #5, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    ptrue pn8.b
; PAIR-NEXT:    str p5, [sp, #6, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str p4, [sp, #7, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str z10, [sp, #1, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    st1b { z8.b, z9.b }, pn8, [sp, #2, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; PAIR-NEXT:    //APP
; PAIR-NEXT:    //NO_APP
; PAIR-NEXT:    ptrue pn8.b
; PAIR-NEXT:    ldr z10, [sp, #1, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ld1b { z8.b, z9.b }, pn8/z, [sp, #2, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ldr p8, [sp, #5, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p5, [sp, #6, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr p4, [sp, #7, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #4
; PAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; PAIR-NEXT:    ret
  call void asm sideeffect "", "~{p4},~{p5},~{z8},~{z9},~{z10}"()
  ret void
}

;; Do NOT group Z10
;; DO group Z8 and Z9 and use P9
define aarch64_sve_vector_pcs  void @test_clobbers_z_p_regs2() {
; NOPAIR-LABEL: test_clobbers_z_p_regs2:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-4
; NOPAIR-NEXT:    str p10, [sp, #6, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str p9, [sp, #7, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    str z10, [sp, #1, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z9, [sp, #2, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z8, [sp, #3, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; NOPAIR-NEXT:    //APP
; NOPAIR-NEXT:    //NO_APP
; NOPAIR-NEXT:    ldr z10, [sp, #1, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z9, [sp, #2, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z8, [sp, #3, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr p10, [sp, #6, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    ldr p9, [sp, #7, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #4
; NOPAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: test_clobbers_z_p_regs2:
; PAIR:       // %bb.0:
; PAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-4
; PAIR-NEXT:    str p9, [sp, #7, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    ptrue pn9.b
; PAIR-NEXT:    str p10, [sp, #6, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str z10, [sp, #1, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    st1b { z8.b, z9.b }, pn9, [sp, #2, mul vl] // 32-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; PAIR-NEXT:    //APP
; PAIR-NEXT:    //NO_APP
; PAIR-NEXT:    ptrue pn9.b
; PAIR-NEXT:    ldr z10, [sp, #1, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ldr p10, [sp, #6, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ld1b { z8.b, z9.b }, pn9/z, [sp, #2, mul vl] // 32-byte Folded Reload
; PAIR-NEXT:    ldr p9, [sp, #7, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #4
; PAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; PAIR-NEXT:    ret
  call void asm sideeffect "", "~{p9},~{p10},~{z8},~{z9},~{z10}"()
  ret void
}


;; Test order of PRegs and ZRegs when there is no PReg being clobbered
define aarch64_sve_vector_pcs  void @test_clobbers_z_regs() {
; NOPAIR-LABEL: test_clobbers_z_regs:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-2
; NOPAIR-NEXT:    str z9, [sp] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z8, [sp, #1, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; NOPAIR-NEXT:    //APP
; NOPAIR-NEXT:    //NO_APP
; NOPAIR-NEXT:    ldr z9, [sp] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z8, [sp, #1, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #2
; NOPAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: test_clobbers_z_regs:
; PAIR:       // %bb.0:
; PAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-3
; PAIR-NEXT:    str p8, [sp, #7, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    str z9, [sp, #1, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    str z8, [sp, #2, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x18, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 24 * VG
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; PAIR-NEXT:    //APP
; PAIR-NEXT:    //NO_APP
; PAIR-NEXT:    ldr p8, [sp, #7, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    ldr z9, [sp, #1, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    ldr z8, [sp, #2, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #3
; PAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; PAIR-NEXT:    ret
  call void asm sideeffect "", "~{z8},~{z9}"()
  ret void
}

;; DO NOT group Z8 and Z9 and
;; DO NOT save P8
;; It does not belong to the allowed calling conventions
;; NOPAIR and PAIR should have the same assembly
define  void @test_clobbers_z_regs_negative() {
; NOPAIR-LABEL: test_clobbers_z_regs_negative:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    stp d9, d8, [sp, #-16]! // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_def_cfa_offset 16
; NOPAIR-NEXT:    .cfi_offset b8, -8
; NOPAIR-NEXT:    .cfi_offset b9, -16
; NOPAIR-NEXT:    //APP
; NOPAIR-NEXT:    //NO_APP
; NOPAIR-NEXT:    ldp d9, d8, [sp], #16 // 16-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: test_clobbers_z_regs_negative:
; PAIR:       // %bb.0:
; PAIR-NEXT:    stp d9, d8, [sp, #-16]! // 16-byte Folded Spill
; PAIR-NEXT:    .cfi_def_cfa_offset 16
; PAIR-NEXT:    .cfi_offset b8, -8
; PAIR-NEXT:    .cfi_offset b9, -16
; PAIR-NEXT:    //APP
; PAIR-NEXT:    //NO_APP
; PAIR-NEXT:    ldp d9, d8, [sp], #16 // 16-byte Folded Reload
; PAIR-NEXT:    ret
  call void asm sideeffect "", "~{z8},~{z9}"()
  ret void
}

;; Do NOT save P8 and NOT group any Z8 and Z10 register
define aarch64_sve_vector_pcs void @test_clobbers_2_z_regs_negative() {
; NOPAIR-LABEL: test_clobbers_2_z_regs_negative:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-2
; NOPAIR-NEXT:    str z10, [sp] // 16-byte Folded Spill
; NOPAIR-NEXT:    str z8, [sp, #1, mul vl] // 16-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; NOPAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 16 * VG
; NOPAIR-NEXT:    //APP
; NOPAIR-NEXT:    //NO_APP
; NOPAIR-NEXT:    ldr z10, [sp] // 16-byte Folded Reload
; NOPAIR-NEXT:    ldr z8, [sp, #1, mul vl] // 16-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #2
; NOPAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: test_clobbers_2_z_regs_negative:
; PAIR:       // %bb.0:
; PAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-2
; PAIR-NEXT:    str z10, [sp] // 16-byte Folded Spill
; PAIR-NEXT:    str z8, [sp, #1, mul vl] // 16-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; PAIR-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 16 * VG
; PAIR-NEXT:    //APP
; PAIR-NEXT:    //NO_APP
; PAIR-NEXT:    ldr z10, [sp] // 16-byte Folded Reload
; PAIR-NEXT:    ldr z8, [sp, #1, mul vl] // 16-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #2
; PAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; PAIR-NEXT:    ret
  call void asm sideeffect "", "~{z8},~{z10}"()
  ret void
}


;; NOTHING TO DO HERE
;; There is no ZReg pairs to save
define aarch64_sve_vector_pcs  void @test_clobbers_p_reg_negative() {
; NOPAIR-LABEL: test_clobbers_p_reg_negative:
; NOPAIR:       // %bb.0:
; NOPAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; NOPAIR-NEXT:    addvl sp, sp, #-1
; NOPAIR-NEXT:    str p10, [sp, #7, mul vl] // 2-byte Folded Spill
; NOPAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 8 * VG
; NOPAIR-NEXT:    .cfi_offset w29, -16
; NOPAIR-NEXT:    //APP
; NOPAIR-NEXT:    //NO_APP
; NOPAIR-NEXT:    ldr p10, [sp, #7, mul vl] // 2-byte Folded Reload
; NOPAIR-NEXT:    addvl sp, sp, #1
; NOPAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; NOPAIR-NEXT:    ret
;
; PAIR-LABEL: test_clobbers_p_reg_negative:
; PAIR:       // %bb.0:
; PAIR-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; PAIR-NEXT:    addvl sp, sp, #-1
; PAIR-NEXT:    str p10, [sp, #7, mul vl] // 2-byte Folded Spill
; PAIR-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 8 * VG
; PAIR-NEXT:    .cfi_offset w29, -16
; PAIR-NEXT:    //APP
; PAIR-NEXT:    //NO_APP
; PAIR-NEXT:    ldr p10, [sp, #7, mul vl] // 2-byte Folded Reload
; PAIR-NEXT:    addvl sp, sp, #1
; PAIR-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; PAIR-NEXT:    ret
 call void asm sideeffect "", "~{p10}"()
  ret void
}


; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

define <2 x i16> @sextload_v2i1_v2i16(ptr %x) {
; CHECK-LABEL: sextload_v2i1_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vlm.v v0, (a0)
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    ret
  %y = load <2 x i1>, ptr %x
  %z = sext <2 x i1> %y to <2 x i16>
  ret <2 x i16> %z
}

define <2 x i16> @sextload_v2i8_v2i16(ptr %x) {
; CHECK-LABEL: sextload_v2i8_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i8>, ptr %x
  %z = sext <2 x i8> %y to <2 x i16>
  ret <2 x i16> %z
}

define <2 x i16> @zextload_v2i8_v2i16(ptr %x) {
; CHECK-LABEL: zextload_v2i8_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i8>, ptr %x
  %z = zext <2 x i8> %y to <2 x i16>
  ret <2 x i16> %z
}

define <2 x i32> @sextload_v2i8_v2i32(ptr %x) {
; CHECK-LABEL: sextload_v2i8_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i8>, ptr %x
  %z = sext <2 x i8> %y to <2 x i32>
  ret <2 x i32> %z
}

define <2 x i32> @zextload_v2i8_v2i32(ptr %x) {
; CHECK-LABEL: zextload_v2i8_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i8>, ptr %x
  %z = zext <2 x i8> %y to <2 x i32>
  ret <2 x i32> %z
}

define <2 x i64> @sextload_v2i8_v2i64(ptr %x) {
; CHECK-LABEL: sextload_v2i8_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsext.vf8 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i8>, ptr %x
  %z = sext <2 x i8> %y to <2 x i64>
  ret <2 x i64> %z
}

define <2 x i64> @zextload_v2i8_v2i64(ptr %x) {
; CHECK-LABEL: zextload_v2i8_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vzext.vf8 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i8>, ptr %x
  %z = zext <2 x i8> %y to <2 x i64>
  ret <2 x i64> %z
}

define <4 x i16> @sextload_v4i8_v4i16(ptr %x) {
; CHECK-LABEL: sextload_v4i8_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <4 x i8>, ptr %x
  %z = sext <4 x i8> %y to <4 x i16>
  ret <4 x i16> %z
}

define <4 x i16> @zextload_v4i8_v4i16(ptr %x) {
; CHECK-LABEL: zextload_v4i8_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <4 x i8>, ptr %x
  %z = zext <4 x i8> %y to <4 x i16>
  ret <4 x i16> %z
}

define <4 x i32> @sextload_v4i8_v4i32(ptr %x) {
; CHECK-LABEL: sextload_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v9
; CHECK-NEXT:    ret
  %y = load <4 x i8>, ptr %x
  %z = sext <4 x i8> %y to <4 x i32>
  ret <4 x i32> %z
}

define <4 x i32> @zextload_v4i8_v4i32(ptr %x) {
; CHECK-LABEL: zextload_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v9
; CHECK-NEXT:    ret
  %y = load <4 x i8>, ptr %x
  %z = zext <4 x i8> %y to <4 x i32>
  ret <4 x i32> %z
}

define <4 x i64> @sextload_v4i8_v4i64(ptr %x) {
; CHECK-LABEL: sextload_v4i8_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vsext.vf8 v8, v10
; CHECK-NEXT:    ret
  %y = load <4 x i8>, ptr %x
  %z = sext <4 x i8> %y to <4 x i64>
  ret <4 x i64> %z
}

define <4 x i64> @zextload_v4i8_v4i64(ptr %x) {
; CHECK-LABEL: zextload_v4i8_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vzext.vf8 v8, v10
; CHECK-NEXT:    ret
  %y = load <4 x i8>, ptr %x
  %z = zext <4 x i8> %y to <4 x i64>
  ret <4 x i64> %z
}

define <8 x i16> @sextload_v8i8_v8i16(ptr %x) {
; CHECK-LABEL: sextload_v8i8_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <8 x i8>, ptr %x
  %z = sext <8 x i8> %y to <8 x i16>
  ret <8 x i16> %z
}

define <8 x i16> @zextload_v8i8_v8i16(ptr %x) {
; CHECK-LABEL: zextload_v8i8_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <8 x i8>, ptr %x
  %z = zext <8 x i8> %y to <8 x i16>
  ret <8 x i16> %z
}

define <8 x i32> @sextload_v8i8_v8i32(ptr %x) {
; CHECK-LABEL: sextload_v8i8_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v10
; CHECK-NEXT:    ret
  %y = load <8 x i8>, ptr %x
  %z = sext <8 x i8> %y to <8 x i32>
  ret <8 x i32> %z
}

define <8 x i32> @zextload_v8i8_v8i32(ptr %x) {
; CHECK-LABEL: zextload_v8i8_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v10
; CHECK-NEXT:    ret
  %y = load <8 x i8>, ptr %x
  %z = zext <8 x i8> %y to <8 x i32>
  ret <8 x i32> %z
}

define <8 x i64> @sextload_v8i8_v8i64(ptr %x) {
; CHECK-LABEL: sextload_v8i8_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vle8.v v12, (a0)
; CHECK-NEXT:    vsext.vf8 v8, v12
; CHECK-NEXT:    ret
  %y = load <8 x i8>, ptr %x
  %z = sext <8 x i8> %y to <8 x i64>
  ret <8 x i64> %z
}

define <8 x i64> @zextload_v8i8_v8i64(ptr %x) {
; CHECK-LABEL: zextload_v8i8_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vle8.v v12, (a0)
; CHECK-NEXT:    vzext.vf8 v8, v12
; CHECK-NEXT:    ret
  %y = load <8 x i8>, ptr %x
  %z = zext <8 x i8> %y to <8 x i64>
  ret <8 x i64> %z
}

define <16 x i16> @sextload_v16i8_v16i16(ptr %x) {
; CHECK-LABEL: sextload_v16i8_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v10
; CHECK-NEXT:    ret
  %y = load <16 x i8>, ptr %x
  %z = sext <16 x i8> %y to <16 x i16>
  ret <16 x i16> %z
}

define <16 x i16> @zextload_v16i8_v16i16(ptr %x) {
; CHECK-LABEL: zextload_v16i8_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v10
; CHECK-NEXT:    ret
  %y = load <16 x i8>, ptr %x
  %z = zext <16 x i8> %y to <16 x i16>
  ret <16 x i16> %z
}

define <16 x i32> @sextload_v16i8_v16i32(ptr %x) {
; CHECK-LABEL: sextload_v16i8_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle8.v v12, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v12
; CHECK-NEXT:    ret
  %y = load <16 x i8>, ptr %x
  %z = sext <16 x i8> %y to <16 x i32>
  ret <16 x i32> %z
}

define <16 x i32> @zextload_v16i8_v16i32(ptr %x) {
; CHECK-LABEL: zextload_v16i8_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle8.v v12, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v12
; CHECK-NEXT:    ret
  %y = load <16 x i8>, ptr %x
  %z = zext <16 x i8> %y to <16 x i32>
  ret <16 x i32> %z
}

define <16 x i64> @sextload_v16i8_v16i64(ptr %x) {
; CHECK-LABEL: sextload_v16i8_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle8.v v16, (a0)
; CHECK-NEXT:    vsext.vf8 v8, v16
; CHECK-NEXT:    ret
  %y = load <16 x i8>, ptr %x
  %z = sext <16 x i8> %y to <16 x i64>
  ret <16 x i64> %z
}

define <16 x i64> @zextload_v16i8_v16i64(ptr %x) {
; CHECK-LABEL: zextload_v16i8_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle8.v v16, (a0)
; CHECK-NEXT:    vzext.vf8 v8, v16
; CHECK-NEXT:    ret
  %y = load <16 x i8>, ptr %x
  %z = zext <16 x i8> %y to <16 x i64>
  ret <16 x i64> %z
}

define void @truncstore_v2i8_v2i1(<2 x i8> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i8_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vsetivli zero, 2, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.v.v v9, v8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmsne.vi v8, v9, 0
; CHECK-NEXT:    vsm.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i8> %x to <2 x i1>
  store <2 x i1> %y, ptr %z
  ret void
}

define void @truncstore_v2i16_v2i8(<2 x i16> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i16_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i16> %x to <2 x i8>
  store <2 x i8> %y, ptr %z
  ret void
}

define <2 x i32> @sextload_v2i16_v2i32(ptr %x) {
; CHECK-LABEL: sextload_v2i16_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i16>, ptr %x
  %z = sext <2 x i16> %y to <2 x i32>
  ret <2 x i32> %z
}

define <2 x i32> @zextload_v2i16_v2i32(ptr %x) {
; CHECK-LABEL: zextload_v2i16_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i16>, ptr %x
  %z = zext <2 x i16> %y to <2 x i32>
  ret <2 x i32> %z
}

define <2 x i64> @sextload_v2i16_v2i64(ptr %x) {
; CHECK-LABEL: sextload_v2i16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i16>, ptr %x
  %z = sext <2 x i16> %y to <2 x i64>
  ret <2 x i64> %z
}

define <2 x i64> @zextload_v2i16_v2i64(ptr %x) {
; CHECK-LABEL: zextload_v2i16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i16>, ptr %x
  %z = zext <2 x i16> %y to <2 x i64>
  ret <2 x i64> %z
}

define void @truncstore_v4i16_v4i8(<4 x i16> %x, ptr %z) {
; CHECK-LABEL: truncstore_v4i16_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <4 x i16> %x to <4 x i8>
  store <4 x i8> %y, ptr %z
  ret void
}

define <4 x i32> @sextload_v4i16_v4i32(ptr %x) {
; CHECK-LABEL: sextload_v4i16_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <4 x i16>, ptr %x
  %z = sext <4 x i16> %y to <4 x i32>
  ret <4 x i32> %z
}

define <4 x i32> @zextload_v4i16_v4i32(ptr %x) {
; CHECK-LABEL: zextload_v4i16_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <4 x i16>, ptr %x
  %z = zext <4 x i16> %y to <4 x i32>
  ret <4 x i32> %z
}

define <4 x i64> @sextload_v4i16_v4i64(ptr %x) {
; CHECK-LABEL: sextload_v4i16_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v10
; CHECK-NEXT:    ret
  %y = load <4 x i16>, ptr %x
  %z = sext <4 x i16> %y to <4 x i64>
  ret <4 x i64> %z
}

define <4 x i64> @zextload_v4i16_v4i64(ptr %x) {
; CHECK-LABEL: zextload_v4i16_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v10
; CHECK-NEXT:    ret
  %y = load <4 x i16>, ptr %x
  %z = zext <4 x i16> %y to <4 x i64>
  ret <4 x i64> %z
}

define void @truncstore_v8i16_v8i8(<8 x i16> %x, ptr %z) {
; CHECK-LABEL: truncstore_v8i16_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <8 x i16> %x to <8 x i8>
  store <8 x i8> %y, ptr %z
  ret void
}

define <8 x i32> @sextload_v8i16_v8i32(ptr %x) {
; CHECK-LABEL: sextload_v8i16_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v10
; CHECK-NEXT:    ret
  %y = load <8 x i16>, ptr %x
  %z = sext <8 x i16> %y to <8 x i32>
  ret <8 x i32> %z
}

define <8 x i32> @zextload_v8i16_v8i32(ptr %x) {
; CHECK-LABEL: zextload_v8i16_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v10
; CHECK-NEXT:    ret
  %y = load <8 x i16>, ptr %x
  %z = zext <8 x i16> %y to <8 x i32>
  ret <8 x i32> %z
}

define <8 x i64> @sextload_v8i16_v8i64(ptr %x) {
; CHECK-LABEL: sextload_v8i16_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v12
; CHECK-NEXT:    ret
  %y = load <8 x i16>, ptr %x
  %z = sext <8 x i16> %y to <8 x i64>
  ret <8 x i64> %z
}

define <8 x i64> @zextload_v8i16_v8i64(ptr %x) {
; CHECK-LABEL: zextload_v8i16_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v12
; CHECK-NEXT:    ret
  %y = load <8 x i16>, ptr %x
  %z = zext <8 x i16> %y to <8 x i64>
  ret <8 x i64> %z
}

define void @truncstore_v16i16_v16i8(<16 x i16> %x, ptr %z) {
; CHECK-LABEL: truncstore_v16i16_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vse8.v v10, (a0)
; CHECK-NEXT:    ret
  %y = trunc <16 x i16> %x to <16 x i8>
  store <16 x i8> %y, ptr %z
  ret void
}

define <16 x i32> @sextload_v16i16_v16i32(ptr %x) {
; CHECK-LABEL: sextload_v16i16_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v12
; CHECK-NEXT:    ret
  %y = load <16 x i16>, ptr %x
  %z = sext <16 x i16> %y to <16 x i32>
  ret <16 x i32> %z
}

define <16 x i32> @zextload_v16i16_v16i32(ptr %x) {
; CHECK-LABEL: zextload_v16i16_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v12
; CHECK-NEXT:    ret
  %y = load <16 x i16>, ptr %x
  %z = zext <16 x i16> %y to <16 x i32>
  ret <16 x i32> %z
}

define <16 x i64> @sextload_v16i16_v16i64(ptr %x) {
; CHECK-LABEL: sextload_v16i16_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle16.v v16, (a0)
; CHECK-NEXT:    vsext.vf4 v8, v16
; CHECK-NEXT:    ret
  %y = load <16 x i16>, ptr %x
  %z = sext <16 x i16> %y to <16 x i64>
  ret <16 x i64> %z
}

define <16 x i64> @zextload_v16i16_v16i64(ptr %x) {
; CHECK-LABEL: zextload_v16i16_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle16.v v16, (a0)
; CHECK-NEXT:    vzext.vf4 v8, v16
; CHECK-NEXT:    ret
  %y = load <16 x i16>, ptr %x
  %z = zext <16 x i16> %y to <16 x i64>
  ret <16 x i64> %z
}

define void @truncstore_v2i32_v2i8(<2 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i32_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i32> %x to <2 x i8>
  store <2 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v2i32_v2i16(<2 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i32_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i32> %x to <2 x i16>
  store <2 x i16> %y, ptr %z
  ret void
}

define <2 x i64> @sextload_v2i32_v2i64(ptr %x) {
; CHECK-LABEL: sextload_v2i32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i32>, ptr %x
  %z = sext <2 x i32> %y to <2 x i64>
  ret <2 x i64> %z
}

define <2 x i64> @zextload_v2i32_v2i64(ptr %x) {
; CHECK-LABEL: zextload_v2i32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v9
; CHECK-NEXT:    ret
  %y = load <2 x i32>, ptr %x
  %z = zext <2 x i32> %y to <2 x i64>
  ret <2 x i64> %z
}

define void @truncstore_v4i32_v4i8(<4 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v4i32_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <4 x i32> %x to <4 x i8>
  store <4 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v4i32_v4i16(<4 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v4i32_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <4 x i32> %x to <4 x i16>
  store <4 x i16> %y, ptr %z
  ret void
}

define <4 x i64> @sextload_v4i32_v4i64(ptr %x) {
; CHECK-LABEL: sextload_v4i32_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v10
; CHECK-NEXT:    ret
  %y = load <4 x i32>, ptr %x
  %z = sext <4 x i32> %y to <4 x i64>
  ret <4 x i64> %z
}

define <4 x i64> @zextload_v4i32_v4i64(ptr %x) {
; CHECK-LABEL: zextload_v4i32_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v10
; CHECK-NEXT:    ret
  %y = load <4 x i32>, ptr %x
  %z = zext <4 x i32> %y to <4 x i64>
  ret <4 x i64> %z
}

define void @truncstore_v8i32_v8i8(<8 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v8i32_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <8 x i32> %x to <8 x i8>
  store <8 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v8i32_v8i16(<8 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v8i32_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vse16.v v10, (a0)
; CHECK-NEXT:    ret
  %y = trunc <8 x i32> %x to <8 x i16>
  store <8 x i16> %y, ptr %z
  ret void
}

define <8 x i64> @sextload_v8i32_v8i64(ptr %x) {
; CHECK-LABEL: sextload_v8i32_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vle32.v v12, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v12
; CHECK-NEXT:    ret
  %y = load <8 x i32>, ptr %x
  %z = sext <8 x i32> %y to <8 x i64>
  ret <8 x i64> %z
}

define <8 x i64> @zextload_v8i32_v8i64(ptr %x) {
; CHECK-LABEL: zextload_v8i32_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vle32.v v12, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v12
; CHECK-NEXT:    ret
  %y = load <8 x i32>, ptr %x
  %z = zext <8 x i32> %y to <8 x i64>
  ret <8 x i64> %z
}

define void @truncstore_v16i32_v16i8(<16 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v16i32_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <16 x i32> %x to <16 x i8>
  store <16 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v16i32_v16i16(<16 x i32> %x, ptr %z) {
; CHECK-LABEL: truncstore_v16i32_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vse16.v v12, (a0)
; CHECK-NEXT:    ret
  %y = trunc <16 x i32> %x to <16 x i16>
  store <16 x i16> %y, ptr %z
  ret void
}

define <16 x i64> @sextload_v16i32_v16i64(ptr %x) {
; CHECK-LABEL: sextload_v16i32_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle32.v v16, (a0)
; CHECK-NEXT:    vsext.vf2 v8, v16
; CHECK-NEXT:    ret
  %y = load <16 x i32>, ptr %x
  %z = sext <16 x i32> %y to <16 x i64>
  ret <16 x i64> %z
}

define <16 x i64> @zextload_v16i32_v16i64(ptr %x) {
; CHECK-LABEL: zextload_v16i32_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle32.v v16, (a0)
; CHECK-NEXT:    vzext.vf2 v8, v16
; CHECK-NEXT:    ret
  %y = load <16 x i32>, ptr %x
  %z = zext <16 x i32> %y to <16 x i64>
  ret <16 x i64> %z
}

define void @truncstore_v2i64_v2i8(<2 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i64> %x to <2 x i8>
  store <2 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v2i64_v2i16(<2 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i64_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i64> %x to <2 x i16>
  store <2 x i16> %y, ptr %z
  ret void
}

define void @truncstore_v2i64_v2i32(<2 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v2i64_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <2 x i64> %x to <2 x i32>
  store <2 x i32> %y, ptr %z
  ret void
}

define void @truncstore_v4i64_v4i8(<4 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v4i64_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <4 x i64> %x to <4 x i8>
  store <4 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v4i64_v4i16(<4 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v4i64_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <4 x i64> %x to <4 x i16>
  store <4 x i16> %y, ptr %z
  ret void
}

define void @truncstore_v4i64_v4i32(<4 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v4i64_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a0)
; CHECK-NEXT:    ret
  %y = trunc <4 x i64> %x to <4 x i32>
  store <4 x i32> %y, ptr %z
  ret void
}

define void @truncstore_v8i64_v8i8(<8 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v8i64_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <8 x i64> %x to <8 x i8>
  store <8 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v8i64_v8i16(<8 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v8i64_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <8 x i64> %x to <8 x i16>
  store <8 x i16> %y, ptr %z
  ret void
}

define void @truncstore_v8i64_v8i32(<8 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v8i64_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vse32.v v12, (a0)
; CHECK-NEXT:    ret
  %y = trunc <8 x i64> %x to <8 x i32>
  store <8 x i32> %y, ptr %z
  ret void
}

define void @truncstore_v16i64_v16i8(<16 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v16i64_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v16, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vse8.v v10, (a0)
; CHECK-NEXT:    ret
  %y = trunc <16 x i64> %x to <16 x i8>
  store <16 x i8> %y, ptr %z
  ret void
}

define void @truncstore_v16i64_v16i16(<16 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v16i64_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v16, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v16, 0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %y = trunc <16 x i64> %x to <16 x i16>
  store <16 x i16> %y, ptr %z
  ret void
}

define void @truncstore_v16i64_v16i32(<16 x i64> %x, ptr %z) {
; CHECK-LABEL: truncstore_v16i64_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v16, v8, 0
; CHECK-NEXT:    vse32.v v16, (a0)
; CHECK-NEXT:    ret
  %y = trunc <16 x i64> %x to <16 x i32>
  store <16 x i32> %y, ptr %z
  ret void
}

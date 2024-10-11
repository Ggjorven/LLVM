; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFHMIN

define <vscale x 1 x bfloat> @nearbyint_nxv1bf16(<vscale x 1 x bfloat> %x) {
; CHECK-LABEL: nearbyint_nxv1bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfabs.v v8, v9
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v8, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v8, v9, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v9, v8, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x bfloat> @llvm.nearbyint.nxv1bf16(<vscale x 1 x bfloat> %x)
  ret <vscale x 1 x bfloat> %a
}

define <vscale x 2 x bfloat> @nearbyint_nxv2bf16(<vscale x 2 x bfloat> %x) {
; CHECK-LABEL: nearbyint_nxv2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfabs.v v8, v9
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v8, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v8, v9, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v9, v8, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x bfloat> @llvm.nearbyint.nxv2bf16(<vscale x 2 x bfloat> %x)
  ret <vscale x 2 x bfloat> %a
}

define <vscale x 4 x bfloat> @nearbyint_nxv4bf16(<vscale x 4 x bfloat> %x) {
; CHECK-LABEL: nearbyint_nxv4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfabs.v v8, v10
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v8, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v8, v10, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v10, v8, v10, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x bfloat> @llvm.nearbyint.nxv4bf16(<vscale x 4 x bfloat> %x)
  ret <vscale x 4 x bfloat> %a
}

define <vscale x 8 x bfloat> @nearbyint_nxv8bf16(<vscale x 8 x bfloat> %x) {
; CHECK-LABEL: nearbyint_nxv8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfabs.v v8, v12
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v8, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v8, v12, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v12, v8, v12, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v12
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x bfloat> @llvm.nearbyint.nxv8bf16(<vscale x 8 x bfloat> %x)
  ret <vscale x 8 x bfloat> %a
}

define <vscale x 16 x bfloat> @nearbyint_nxv16bf16(<vscale x 16 x bfloat> %x) {
; CHECK-LABEL: nearbyint_nxv16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfabs.v v8, v16
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v8, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v8, v16, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; CHECK-NEXT:    vfsgnj.vv v16, v8, v16, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 16 x bfloat> @llvm.nearbyint.nxv16bf16(<vscale x 16 x bfloat> %x)
  ret <vscale x 16 x bfloat> %a
}

define <vscale x 32 x bfloat> @nearbyint_nxv32bf16(<vscale x 32 x bfloat> %x) {
; CHECK-LABEL: nearbyint_nxv32bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfabs.v v24, v16
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v24, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v24, v16, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v24, v24, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; CHECK-NEXT:    vfsgnj.vv v16, v24, v16, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v12
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfabs.v v8, v24
; CHECK-NEXT:    vmflt.vf v0, v8, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v8, v24, v0.t
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    vl8r.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; CHECK-NEXT:    vfsgnj.vv v24, v16, v24, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v12, v24
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %a = call <vscale x 32 x bfloat> @llvm.nearbyint.nxv32bf16(<vscale x 32 x bfloat> %x)
  ret <vscale x 32 x bfloat> %a
}

define <vscale x 1 x half> @nearbyint_nxv1f16(<vscale x 1 x half> %x) {
; ZVFH-LABEL: nearbyint_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    lui a0, %hi(.LCPI6_0)
; ZVFH-NEXT:    flh fa5, %lo(.LCPI6_0)(a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfabs.v v9, v8
; ZVFH-NEXT:    vmflt.vf v0, v9, fa5
; ZVFH-NEXT:    frflags a0
; ZVFH-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; ZVFH-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, mf4, ta, mu
; ZVFH-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; ZVFH-NEXT:    fsflags a0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: nearbyint_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v8, v9
; ZVFHMIN-NEXT:    lui a0, 307200
; ZVFHMIN-NEXT:    fmv.w.x fa5, a0
; ZVFHMIN-NEXT:    vmflt.vf v0, v8, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v8, v9, v0.t
; ZVFHMIN-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    ret
  %a = call <vscale x 1 x half> @llvm.nearbyint.nxv1f16(<vscale x 1 x half> %x)
  ret <vscale x 1 x half> %a
}
declare <vscale x 1 x half> @llvm.nearbyint.nxv1f16(<vscale x 1 x half>)

define <vscale x 2 x half> @nearbyint_nxv2f16(<vscale x 2 x half> %x) {
; ZVFH-LABEL: nearbyint_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    lui a0, %hi(.LCPI7_0)
; ZVFH-NEXT:    flh fa5, %lo(.LCPI7_0)(a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfabs.v v9, v8
; ZVFH-NEXT:    vmflt.vf v0, v9, fa5
; ZVFH-NEXT:    frflags a0
; ZVFH-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; ZVFH-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, mf2, ta, mu
; ZVFH-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; ZVFH-NEXT:    fsflags a0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: nearbyint_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v8, v9
; ZVFHMIN-NEXT:    lui a0, 307200
; ZVFHMIN-NEXT:    fmv.w.x fa5, a0
; ZVFHMIN-NEXT:    vmflt.vf v0, v8, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v8, v9, v0.t
; ZVFHMIN-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    ret
  %a = call <vscale x 2 x half> @llvm.nearbyint.nxv2f16(<vscale x 2 x half> %x)
  ret <vscale x 2 x half> %a
}
declare <vscale x 2 x half> @llvm.nearbyint.nxv2f16(<vscale x 2 x half>)

define <vscale x 4 x half> @nearbyint_nxv4f16(<vscale x 4 x half> %x) {
; ZVFH-LABEL: nearbyint_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    lui a0, %hi(.LCPI8_0)
; ZVFH-NEXT:    flh fa5, %lo(.LCPI8_0)(a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfabs.v v9, v8
; ZVFH-NEXT:    vmflt.vf v0, v9, fa5
; ZVFH-NEXT:    frflags a0
; ZVFH-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; ZVFH-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, m1, ta, mu
; ZVFH-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; ZVFH-NEXT:    fsflags a0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: nearbyint_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v8, v10
; ZVFHMIN-NEXT:    lui a0, 307200
; ZVFHMIN-NEXT:    fmv.w.x fa5, a0
; ZVFHMIN-NEXT:    vmflt.vf v0, v8, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v8, v10, v0.t
; ZVFHMIN-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v10, v8, v10, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    ret
  %a = call <vscale x 4 x half> @llvm.nearbyint.nxv4f16(<vscale x 4 x half> %x)
  ret <vscale x 4 x half> %a
}
declare <vscale x 4 x half> @llvm.nearbyint.nxv4f16(<vscale x 4 x half>)

define <vscale x 8 x half> @nearbyint_nxv8f16(<vscale x 8 x half> %x) {
; ZVFH-LABEL: nearbyint_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    lui a0, %hi(.LCPI9_0)
; ZVFH-NEXT:    flh fa5, %lo(.LCPI9_0)(a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfabs.v v10, v8
; ZVFH-NEXT:    vmflt.vf v0, v10, fa5
; ZVFH-NEXT:    frflags a0
; ZVFH-NEXT:    vfcvt.x.f.v v10, v8, v0.t
; ZVFH-NEXT:    vfcvt.f.x.v v10, v10, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, m2, ta, mu
; ZVFH-NEXT:    vfsgnj.vv v8, v10, v8, v0.t
; ZVFH-NEXT:    fsflags a0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: nearbyint_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v8, v12
; ZVFHMIN-NEXT:    lui a0, 307200
; ZVFHMIN-NEXT:    fmv.w.x fa5, a0
; ZVFHMIN-NEXT:    vmflt.vf v0, v8, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v8, v12, v0.t
; ZVFHMIN-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v12, v8, v12, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    ret
  %a = call <vscale x 8 x half> @llvm.nearbyint.nxv8f16(<vscale x 8 x half> %x)
  ret <vscale x 8 x half> %a
}
declare <vscale x 8 x half> @llvm.nearbyint.nxv8f16(<vscale x 8 x half>)

define <vscale x 16 x half> @nearbyint_nxv16f16(<vscale x 16 x half> %x) {
; ZVFH-LABEL: nearbyint_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    lui a0, %hi(.LCPI10_0)
; ZVFH-NEXT:    flh fa5, %lo(.LCPI10_0)(a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfabs.v v12, v8
; ZVFH-NEXT:    vmflt.vf v0, v12, fa5
; ZVFH-NEXT:    frflags a0
; ZVFH-NEXT:    vfcvt.x.f.v v12, v8, v0.t
; ZVFH-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, m4, ta, mu
; ZVFH-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; ZVFH-NEXT:    fsflags a0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: nearbyint_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v8, v16
; ZVFHMIN-NEXT:    lui a0, 307200
; ZVFHMIN-NEXT:    fmv.w.x fa5, a0
; ZVFHMIN-NEXT:    vmflt.vf v0, v8, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v8, v16, v0.t
; ZVFHMIN-NEXT:    vfcvt.f.x.v v8, v8, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v16, v8, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    ret
  %a = call <vscale x 16 x half> @llvm.nearbyint.nxv16f16(<vscale x 16 x half> %x)
  ret <vscale x 16 x half> %a
}
declare <vscale x 16 x half> @llvm.nearbyint.nxv16f16(<vscale x 16 x half>)

define <vscale x 32 x half> @nearbyint_nxv32f16(<vscale x 32 x half> %x) {
; ZVFH-LABEL: nearbyint_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    lui a0, %hi(.LCPI11_0)
; ZVFH-NEXT:    flh fa5, %lo(.LCPI11_0)(a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfabs.v v16, v8
; ZVFH-NEXT:    vmflt.vf v0, v16, fa5
; ZVFH-NEXT:    frflags a0
; ZVFH-NEXT:    vfcvt.x.f.v v16, v8, v0.t
; ZVFH-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; ZVFH-NEXT:    vsetvli zero, zero, e16, m8, ta, mu
; ZVFH-NEXT:    vfsgnj.vv v8, v16, v8, v0.t
; ZVFH-NEXT:    fsflags a0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: nearbyint_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    addi sp, sp, -16
; ZVFHMIN-NEXT:    .cfi_def_cfa_offset 16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 3
; ZVFHMIN-NEXT:    sub sp, sp, a0
; ZVFHMIN-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v24, v16
; ZVFHMIN-NEXT:    lui a0, 307200
; ZVFHMIN-NEXT:    fmv.w.x fa5, a0
; ZVFHMIN-NEXT:    vmflt.vf v0, v24, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v24, v16, v0.t
; ZVFHMIN-NEXT:    vfcvt.f.x.v v24, v24, v0.t
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v16, v24, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfabs.v v8, v24
; ZVFHMIN-NEXT:    vmflt.vf v0, v8, fa5
; ZVFHMIN-NEXT:    frflags a0
; ZVFHMIN-NEXT:    vfcvt.x.f.v v8, v24, v0.t
; ZVFHMIN-NEXT:    addi a1, sp, 16
; ZVFHMIN-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    vl8r.v v16, (a1) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; ZVFHMIN-NEXT:    vfsgnj.vv v24, v16, v24, v0.t
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v24
; ZVFHMIN-NEXT:    fsflags a0
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 3
; ZVFHMIN-NEXT:    add sp, sp, a0
; ZVFHMIN-NEXT:    addi sp, sp, 16
; ZVFHMIN-NEXT:    ret
  %a = call <vscale x 32 x half> @llvm.nearbyint.nxv32f16(<vscale x 32 x half> %x)
  ret <vscale x 32 x half> %a
}
declare <vscale x 32 x half> @llvm.nearbyint.nxv32f16(<vscale x 32 x half>)

define <vscale x 1 x float> @nearbyint_nxv1f32(<vscale x 1 x float> %x) {
; CHECK-LABEL: nearbyint_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v9, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x float> @llvm.nearbyint.nxv1f32(<vscale x 1 x float> %x)
  ret <vscale x 1 x float> %a
}
declare <vscale x 1 x float> @llvm.nearbyint.nxv1f32(<vscale x 1 x float>)

define <vscale x 2 x float> @nearbyint_nxv2f32(<vscale x 2 x float> %x) {
; CHECK-LABEL: nearbyint_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v9, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x float> @llvm.nearbyint.nxv2f32(<vscale x 2 x float> %x)
  ret <vscale x 2 x float> %a
}
declare <vscale x 2 x float> @llvm.nearbyint.nxv2f32(<vscale x 2 x float>)

define <vscale x 4 x float> @nearbyint_nxv4f32(<vscale x 4 x float> %x) {
; CHECK-LABEL: nearbyint_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfabs.v v10, v8
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v10, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v10, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v10, v10, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v10, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x float> @llvm.nearbyint.nxv4f32(<vscale x 4 x float> %x)
  ret <vscale x 4 x float> %a
}
declare <vscale x 4 x float> @llvm.nearbyint.nxv4f32(<vscale x 4 x float>)

define <vscale x 8 x float> @nearbyint_nxv8f32(<vscale x 8 x float> %x) {
; CHECK-LABEL: nearbyint_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v12, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v12, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x float> @llvm.nearbyint.nxv8f32(<vscale x 8 x float> %x)
  ret <vscale x 8 x float> %a
}
declare <vscale x 8 x float> @llvm.nearbyint.nxv8f32(<vscale x 8 x float>)

define <vscale x 16 x float> @nearbyint_nxv16f32(<vscale x 16 x float> %x) {
; CHECK-LABEL: nearbyint_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfabs.v v16, v8
; CHECK-NEXT:    lui a0, 307200
; CHECK-NEXT:    fmv.w.x fa5, a0
; CHECK-NEXT:    vmflt.vf v0, v16, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v16, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v16, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 16 x float> @llvm.nearbyint.nxv16f32(<vscale x 16 x float> %x)
  ret <vscale x 16 x float> %a
}
declare <vscale x 16 x float> @llvm.nearbyint.nxv16f32(<vscale x 16 x float>)

define <vscale x 1 x double> @nearbyint_nxv1f64(<vscale x 1 x double> %x) {
; CHECK-LABEL: nearbyint_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI17_0)
; CHECK-NEXT:    fld fa5, %lo(.LCPI17_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 1 x double> @llvm.nearbyint.nxv1f64(<vscale x 1 x double> %x)
  ret <vscale x 1 x double> %a
}
declare <vscale x 1 x double> @llvm.nearbyint.nxv1f64(<vscale x 1 x double>)

define <vscale x 2 x double> @nearbyint_nxv2f64(<vscale x 2 x double> %x) {
; CHECK-LABEL: nearbyint_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI18_0)
; CHECK-NEXT:    fld fa5, %lo(.LCPI18_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfabs.v v10, v8
; CHECK-NEXT:    vmflt.vf v0, v10, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v10, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v10, v10, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v10, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 2 x double> @llvm.nearbyint.nxv2f64(<vscale x 2 x double> %x)
  ret <vscale x 2 x double> %a
}
declare <vscale x 2 x double> @llvm.nearbyint.nxv2f64(<vscale x 2 x double>)

define <vscale x 4 x double> @nearbyint_nxv4f64(<vscale x 4 x double> %x) {
; CHECK-LABEL: nearbyint_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI19_0)
; CHECK-NEXT:    fld fa5, %lo(.LCPI19_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v0, v12, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v12, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 4 x double> @llvm.nearbyint.nxv4f64(<vscale x 4 x double> %x)
  ret <vscale x 4 x double> %a
}
declare <vscale x 4 x double> @llvm.nearbyint.nxv4f64(<vscale x 4 x double>)

define <vscale x 8 x double> @nearbyint_nxv8f64(<vscale x 8 x double> %x) {
; CHECK-LABEL: nearbyint_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI20_0)
; CHECK-NEXT:    fld fa5, %lo(.LCPI20_0)(a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfabs.v v16, v8
; CHECK-NEXT:    vmflt.vf v0, v16, fa5
; CHECK-NEXT:    frflags a0
; CHECK-NEXT:    vfcvt.x.f.v v16, v8, v0.t
; CHECK-NEXT:    vfcvt.f.x.v v16, v16, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m8, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v16, v8, v0.t
; CHECK-NEXT:    fsflags a0
; CHECK-NEXT:    ret
  %a = call <vscale x 8 x double> @llvm.nearbyint.nxv8f64(<vscale x 8 x double> %x)
  ret <vscale x 8 x double> %a
}
declare <vscale x 8 x double> @llvm.nearbyint.nxv8f64(<vscale x 8 x double>)

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v,+zvfbfmin -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v,+zvfbfmin -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 1 x float> @llvm.experimental.constrained.fpext.nxv1f32.nxv1f16(<vscale x 1 x half>, metadata)
define <vscale x 1 x float> @vfpext_nxv1f16_nxv1f32(<vscale x 1 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv1f16_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 1 x float> @llvm.experimental.constrained.fpext.nxv1f32.nxv1f16(<vscale x 1 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 1 x float> %evec
}

declare <vscale x 1 x double> @llvm.experimental.constrained.fpext.nxv1f64.nxv1f16(<vscale x 1 x half>, metadata)
define <vscale x 1 x double> @vfpext_nxv1f16_nxv1f64(<vscale x 1 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv1f16_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 1 x double> @llvm.experimental.constrained.fpext.nxv1f64.nxv1f16(<vscale x 1 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 1 x double> %evec
}

declare <vscale x 2 x float> @llvm.experimental.constrained.fpext.nxv2f32.nxv2f16(<vscale x 2 x half>, metadata)
define <vscale x 2 x float> @vfpext_nxv2f16_nxv2f32(<vscale x 2 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv2f16_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 2 x float> @llvm.experimental.constrained.fpext.nxv2f32.nxv2f16(<vscale x 2 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 2 x float> %evec
}

declare <vscale x 2 x double> @llvm.experimental.constrained.fpext.nxv2f64.nxv2f16(<vscale x 2 x half>, metadata)
define <vscale x 2 x double> @vfpext_nxv2f16_nxv2f64(<vscale x 2 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv2f16_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v10
; CHECK-NEXT:    ret
  %evec = call <vscale x 2 x double> @llvm.experimental.constrained.fpext.nxv2f64.nxv2f16(<vscale x 2 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 2 x double> %evec
}

declare <vscale x 4 x float> @llvm.experimental.constrained.fpext.nxv4f32.nxv4f16(<vscale x 4 x half>, metadata)
define <vscale x 4 x float> @vfpext_nxv4f16_nxv4f32(<vscale x 4 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv4f16_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v10, v8
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %evec = call <vscale x 4 x float> @llvm.experimental.constrained.fpext.nxv4f32.nxv4f16(<vscale x 4 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 4 x float> %evec
}

declare <vscale x 4 x double> @llvm.experimental.constrained.fpext.nxv4f64.nxv4f16(<vscale x 4 x half>, metadata)
define <vscale x 4 x double> @vfpext_nxv4f16_nxv4f64(<vscale x 4 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv4f16_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v12
; CHECK-NEXT:    ret
  %evec = call <vscale x 4 x double> @llvm.experimental.constrained.fpext.nxv4f64.nxv4f16(<vscale x 4 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 4 x double> %evec
}

declare <vscale x 8 x float> @llvm.experimental.constrained.fpext.nxv8f32.nxv8f16(<vscale x 8 x half>, metadata)
define <vscale x 8 x float> @vfpext_nxv8f16_nxv8f32(<vscale x 8 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv8f16_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v12, v8
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    ret
  %evec = call <vscale x 8 x float> @llvm.experimental.constrained.fpext.nxv8f32.nxv8f16(<vscale x 8 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 8 x float> %evec
}

declare <vscale x 8 x double> @llvm.experimental.constrained.fpext.nxv8f64.nxv8f16(<vscale x 8 x half>, metadata)
define <vscale x 8 x double> @vfpext_nxv8f16_nxv8f64(<vscale x 8 x half> %va) strictfp {
; CHECK-LABEL: vfpext_nxv8f16_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v16
; CHECK-NEXT:    ret
  %evec = call <vscale x 8 x double> @llvm.experimental.constrained.fpext.nxv8f64.nxv8f16(<vscale x 8 x half> %va, metadata !"fpexcept.strict")
  ret <vscale x 8 x double> %evec
}

declare <vscale x 1 x double> @llvm.experimental.constrained.fpext.nxv1f64.nxv1f32(<vscale x 1 x float>, metadata)
define <vscale x 1 x double> @vfpext_nxv1f32_nxv1f64(<vscale x 1 x float> %va) strictfp {
; CHECK-LABEL: vfpext_nxv1f32_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 1 x double> @llvm.experimental.constrained.fpext.nxv1f64.nxv1f32(<vscale x 1 x float> %va, metadata !"fpexcept.strict")
  ret <vscale x 1 x double> %evec
}

declare <vscale x 2 x double> @llvm.experimental.constrained.fpext.nxv2f64.nxv2f32(<vscale x 2 x float>, metadata)
define <vscale x 2 x double> @vfpext_nxv2f32_nxv2f64(<vscale x 2 x float> %va) strictfp {
; CHECK-LABEL: vfpext_nxv2f32_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v10, v8
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %evec = call <vscale x 2 x double> @llvm.experimental.constrained.fpext.nxv2f64.nxv2f32(<vscale x 2 x float> %va, metadata !"fpexcept.strict")
  ret <vscale x 2 x double> %evec
}

declare <vscale x 4 x double> @llvm.experimental.constrained.fpext.nxv4f64.nxv4f32(<vscale x 4 x float>, metadata)
define <vscale x 4 x double> @vfpext_nxv4f32_nxv4f64(<vscale x 4 x float> %va) strictfp {
; CHECK-LABEL: vfpext_nxv4f32_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v12, v8
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    ret
  %evec = call <vscale x 4 x double> @llvm.experimental.constrained.fpext.nxv4f64.nxv4f32(<vscale x 4 x float> %va, metadata !"fpexcept.strict")
  ret <vscale x 4 x double> %evec
}

declare <vscale x 8 x double> @llvm.experimental.constrained.fpext.nxv8f64.nxv8f32(<vscale x 8 x float>, metadata)
define <vscale x 8 x double> @vfpext_nxv8f32_nxv8f64(<vscale x 8 x float> %va) strictfp {
; CHECK-LABEL: vfpext_nxv8f32_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v16, v8
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    ret
  %evec = call <vscale x 8 x double> @llvm.experimental.constrained.fpext.nxv8f64.nxv8f32(<vscale x 8 x float> %va, metadata !"fpexcept.strict")
  ret <vscale x 8 x double> %evec
}

declare <vscale x 1 x float> @llvm.experimental.constrained.fpext.nxv1f32.nxv1bf16(<vscale x 1 x bfloat>, metadata)
define <vscale x 1 x float> @vfpext_nxv1bf16_nxv1f32(<vscale x 1 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv1bf16_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 1 x float> @llvm.experimental.constrained.fpext.nxv1f32.nxv1bf16(<vscale x 1 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 1 x float> %evec
}

declare <vscale x 1 x double> @llvm.experimental.constrained.fpext.nxv1f64.nxv1bf16(<vscale x 1 x bfloat>, metadata)
define <vscale x 1 x double> @vfpext_nxv1bf16_nxv1f64(<vscale x 1 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv1bf16_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 1 x double> @llvm.experimental.constrained.fpext.nxv1f64.nxv1bf16(<vscale x 1 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 1 x double> %evec
}

declare <vscale x 2 x float> @llvm.experimental.constrained.fpext.nxv2f32.nxv2bf16(<vscale x 2 x bfloat>, metadata)
define <vscale x 2 x float> @vfpext_nxv2bf16_nxv2f32(<vscale x 2 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv2bf16_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %evec = call <vscale x 2 x float> @llvm.experimental.constrained.fpext.nxv2f32.nxv2bf16(<vscale x 2 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 2 x float> %evec
}

declare <vscale x 2 x double> @llvm.experimental.constrained.fpext.nxv2f64.nxv2bf16(<vscale x 2 x bfloat>, metadata)
define <vscale x 2 x double> @vfpext_nxv2bf16_nxv2f64(<vscale x 2 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv2bf16_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v10
; CHECK-NEXT:    ret
  %evec = call <vscale x 2 x double> @llvm.experimental.constrained.fpext.nxv2f64.nxv2bf16(<vscale x 2 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 2 x double> %evec
}

declare <vscale x 4 x float> @llvm.experimental.constrained.fpext.nxv4f32.nxv4bf16(<vscale x 4 x bfloat>, metadata)
define <vscale x 4 x float> @vfpext_nxv4bf16_nxv4f32(<vscale x 4 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv4bf16_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %evec = call <vscale x 4 x float> @llvm.experimental.constrained.fpext.nxv4f32.nxv4bf16(<vscale x 4 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 4 x float> %evec
}

declare <vscale x 4 x double> @llvm.experimental.constrained.fpext.nxv4f64.nxv4bf16(<vscale x 4 x bfloat>, metadata)
define <vscale x 4 x double> @vfpext_nxv4bf16_nxv4f64(<vscale x 4 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv4bf16_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v12
; CHECK-NEXT:    ret
  %evec = call <vscale x 4 x double> @llvm.experimental.constrained.fpext.nxv4f64.nxv4bf16(<vscale x 4 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 4 x double> %evec
}

declare <vscale x 8 x float> @llvm.experimental.constrained.fpext.nxv8f32.nxv8bf16(<vscale x 8 x bfloat>, metadata)
define <vscale x 8 x float> @vfpext_nxv8bf16_nxv8f32(<vscale x 8 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv8bf16_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    ret
  %evec = call <vscale x 8 x float> @llvm.experimental.constrained.fpext.nxv8f32.nxv8bf16(<vscale x 8 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 8 x float> %evec
}

declare <vscale x 8 x double> @llvm.experimental.constrained.fpext.nxv8f64.nxv8bf16(<vscale x 8 x bfloat>, metadata)
define <vscale x 8 x double> @vfpext_nxv8bf16_nxv8f64(<vscale x 8 x bfloat> %va) strictfp {
; CHECK-LABEL: vfpext_nxv8bf16_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v16
; CHECK-NEXT:    ret
  %evec = call <vscale x 8 x double> @llvm.experimental.constrained.fpext.nxv8f64.nxv8bf16(<vscale x 8 x bfloat> %va, metadata !"fpexcept.strict")
  ret <vscale x 8 x double> %evec
}

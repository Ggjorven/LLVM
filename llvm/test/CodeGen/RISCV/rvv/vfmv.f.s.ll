; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+d,+v,+zfh,+zvfh -target-abi lp64d -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+d,+v,+zfh,+zvfh -target-abi ilp32d -verify-machineinstrs < %s | FileCheck %s

declare half @llvm.riscv.vfmv.f.s.nxv1f16(<vscale x 1 x half>)

define half @intrinsic_vfmv.f.s_s_nxv1f16(<vscale x 1 x half> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv1f16(<vscale x 1 x half> %0)
  ret half %a
}

declare half @llvm.riscv.vfmv.f.s.nxv2f16(<vscale x 2 x half>)

define half @intrinsic_vfmv.f.s_s_nxv2f16(<vscale x 2 x half> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv2f16(<vscale x 2 x half> %0)
  ret half %a
}

declare half @llvm.riscv.vfmv.f.s.nxv4f16(<vscale x 4 x half>)

define half @intrinsic_vfmv.f.s_s_nxv4f16(<vscale x 4 x half> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv4f16(<vscale x 4 x half> %0)
  ret half %a
}

declare half @llvm.riscv.vfmv.f.s.nxv8f16(<vscale x 8 x half>)

define half @intrinsic_vfmv.f.s_s_nxv8f16(<vscale x 8 x half> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv8f16(<vscale x 8 x half> %0)
  ret half %a
}

declare half @llvm.riscv.vfmv.f.s.nxv16f16(<vscale x 16 x half>)

define half @intrinsic_vfmv.f.s_s_nxv16f16(<vscale x 16 x half> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv16f16(<vscale x 16 x half> %0)
  ret half %a
}

declare half @llvm.riscv.vfmv.f.s.nxv32f16(<vscale x 32 x half>)

define half @intrinsic_vfmv.f.s_s_nxv32f16(<vscale x 32 x half> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv32f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv32f16(<vscale x 32 x half> %0)
  ret half %a
}

declare float @llvm.riscv.vfmv.f.s.nxv1f32(<vscale x 1 x float>)

define float @intrinsic_vfmv.f.s_s_nxv1f32(<vscale x 1 x float> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call float @llvm.riscv.vfmv.f.s.nxv1f32(<vscale x 1 x float> %0)
  ret float %a
}

declare float @llvm.riscv.vfmv.f.s.nxv2f32(<vscale x 2 x float>)

define float @intrinsic_vfmv.f.s_s_nxv2f32(<vscale x 2 x float> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv2f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call float @llvm.riscv.vfmv.f.s.nxv2f32(<vscale x 2 x float> %0)
  ret float %a
}

declare float @llvm.riscv.vfmv.f.s.nxv4f32(<vscale x 4 x float>)

define float @intrinsic_vfmv.f.s_s_nxv4f32(<vscale x 4 x float> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call float @llvm.riscv.vfmv.f.s.nxv4f32(<vscale x 4 x float> %0)
  ret float %a
}

declare float @llvm.riscv.vfmv.f.s.nxv8f32(<vscale x 8 x float>)

define float @intrinsic_vfmv.f.s_s_nxv8f32(<vscale x 8 x float> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call float @llvm.riscv.vfmv.f.s.nxv8f32(<vscale x 8 x float> %0)
  ret float %a
}

declare float @llvm.riscv.vfmv.f.s.nxv16f32(<vscale x 16 x float>)

define float @intrinsic_vfmv.f.s_s_nxv16f32(<vscale x 16 x float> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv16f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call float @llvm.riscv.vfmv.f.s.nxv16f32(<vscale x 16 x float> %0)
  ret float %a
}

declare double @llvm.riscv.vfmv.f.s.nxv1f64(<vscale x 1 x double>)

define double @intrinsic_vfmv.f.s_s_nxv1f64(<vscale x 1 x double> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call double @llvm.riscv.vfmv.f.s.nxv1f64(<vscale x 1 x double> %0)
  ret double %a
}

declare double @llvm.riscv.vfmv.f.s.nxv2f64(<vscale x 2 x double>)

define double @intrinsic_vfmv.f.s_s_nxv2f64(<vscale x 2 x double> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call double @llvm.riscv.vfmv.f.s.nxv2f64(<vscale x 2 x double> %0)
  ret double %a
}

declare double @llvm.riscv.vfmv.f.s.nxv4f64(<vscale x 4 x double>)

define double @intrinsic_vfmv.f.s_s_nxv4f64(<vscale x 4 x double> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call double @llvm.riscv.vfmv.f.s.nxv4f64(<vscale x 4 x double> %0)
  ret double %a
}

declare double @llvm.riscv.vfmv.f.s.nxv8f64(<vscale x 8 x double>)

define double @intrinsic_vfmv.f.s_s_nxv8f64(<vscale x 8 x double> %0) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv8f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
entry:
  %a = call double @llvm.riscv.vfmv.f.s.nxv8f64(<vscale x 8 x double> %0)
  ret double %a
}

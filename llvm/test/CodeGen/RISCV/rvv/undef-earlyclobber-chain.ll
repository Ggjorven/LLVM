; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple riscv64 -mattr=+v -enable-subreg-liveness < %s  | FileCheck %s

define <vscale x 2 x float> @vrgather_all_undef(ptr %p) {
; CHECK-LABEL: vrgather_all_undef:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 0, e32, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v8, v9, 0
; CHECK-NEXT:    ret
entry:
  %0 = tail call <vscale x 2 x float> @llvm.riscv.vrgather.vx.nxv2f32.i64(<vscale x 2 x float> undef, <vscale x 2 x float> undef, i64 0, i64 0)
  ret <vscale x 2 x float> %0
}

define dso_local signext i32 @undef_early_clobber_chain() {
; CHECK-LABEL: undef_early_clobber_chain:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -400
; CHECK-NEXT:    .cfi_def_cfa_offset 400
; CHECK-NEXT:    vsetivli zero, 0, e32, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 0
; CHECK-NEXT:    mv a0, sp
; CHECK-NEXT:    vse32.v v9, (a0)
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    addi sp, sp, 400
; CHECK-NEXT:    ret
entry:
  %dst = alloca [100 x float], align 8
  call void @llvm.lifetime.start.p0(i64 400, ptr nonnull %dst) #4
  %0 = tail call <vscale x 2 x float> @llvm.riscv.vrgather.vx.nxv2f32.i64(<vscale x 2 x float> undef, <vscale x 2 x float> undef, i64 0, i64 0)
  call void @llvm.riscv.vse.nxv2f32.i64(<vscale x 2 x float> %0, ptr nonnull %dst, i64 0)
  call void @llvm.lifetime.end.p0(i64 400, ptr nonnull %dst) #4
  ret i32 0
}

define internal void @SubRegLivenessUndefInPhi(i64 %cond) {
; CHECK-LABEL: SubRegLivenessUndefInPhi:
; CHECK:       # %bb.0: # %start
; CHECK-NEXT:    blez a0, .LBB2_2
; CHECK-NEXT:  # %bb.1: # %Cond1
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vi v10, v8, 1
; CHECK-NEXT:    vadd.vi v12, v8, 3
; CHECK-NEXT:    j .LBB2_3
; CHECK-NEXT:  .LBB2_2: # %Cond2
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    add a1, a0, a0
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    vsetvli a2, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vadd.vi v11, v9, 1
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vslideup.vx v10, v11, a0
; CHECK-NEXT:    vsetvli a2, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vadd.vi v9, v9, 3
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vslideup.vx v12, v9, a0
; CHECK-NEXT:  .LBB2_3: # %UseSR
; CHECK-NEXT:    vl1r.v v14, (zero)
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v13, v14, v8
; CHECK-NEXT:    vrgatherei16.vv v8, v14, v10
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vand.vv v8, v13, v8
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v9, v14, v12
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vand.vv v8, v8, v9
; CHECK-NEXT:    vs1r.v v8, (zero)
; CHECK-NEXT:    ret
start:
    %0 = icmp sgt i64 %cond, 0
    br i1 %0, label %Cond1, label %Cond2

Cond1:                             ; preds = %start
    %v15 = tail call <vscale x 1 x i16> @llvm.stepvector.nxv1i16()
    %v17 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %v15, i64 0)
    %vs12.i.i.i = add <vscale x 1 x i16> %v15, splat (i16 1)
    %v18 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %vs12.i.i.i, i64 0)
    %vs16.i.i.i = add <vscale x 1 x i16> %v15, splat (i16 3)
    %v20 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %vs16.i.i.i, i64 0)
    br label %UseSR

Cond2:                           ; preds = %start
    %v15.2 = tail call <vscale x 1 x i16> @llvm.stepvector.nxv1i16()
    %v17.2 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %v15.2, i64 1)
    %vs12.i.i.i.2 = add <vscale x 1 x i16> %v15.2, splat (i16 1)
    %v18.2 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %vs12.i.i.i.2, i64 1)
    %vs16.i.i.i.2 = add <vscale x 1 x i16> %v15.2, splat (i16 3)
    %v20.2 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %vs16.i.i.i.2, i64 1)
    br label %UseSR

UseSR:                                      ; preds = %Cond1, Cond2
    %v17.3 = phi <vscale x 8 x i16> [ %v17, %Cond1 ], [ %v17.2, %Cond2 ]
    %v18.3 = phi <vscale x 8 x i16> [ %v18, %Cond1 ], [ %v18.2, %Cond2 ]
    %v20.3 = phi <vscale x 8 x i16> [ %v20, %Cond1 ], [ %v20.2, %Cond2 ]
    %v37 = load <vscale x 8 x i8>, ptr addrspace(1) null, align 8
    %v38 = tail call <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> %v37, <vscale x 8 x i16> %v17.3, i64 4)
    %v40 = tail call <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> %v37, <vscale x 8 x i16> %v18.3, i64 4)
    %v42 = and <vscale x 8 x i8> %v38, %v40
    %v46 = tail call <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> %v37, <vscale x 8 x i16> %v20.3, i64 4)
    %v60 = and <vscale x 8 x i8> %v42, %v46
    store <vscale x 8 x i8> %v60, ptr addrspace(1) null, align 4
    ret void
}

define internal void @SubRegLivenessUndef() {
; CHECK-LABEL: SubRegLivenessUndef:
; CHECK:       # %bb.0: # %loopIR.preheader.i.i
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vi v10, v8, 1
; CHECK-NEXT:    vadd.vi v12, v8, 3
; CHECK-NEXT:  .LBB3_1: # %loopIR3.i.i
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vl1r.v v14, (zero)
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v13, v14, v8
; CHECK-NEXT:    vrgatherei16.vv v9, v14, v10
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vand.vv v9, v13, v9
; CHECK-NEXT:    vsetivli zero, 4, e8, m1, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v11, v14, v12
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vand.vv v9, v9, v11
; CHECK-NEXT:    vs1r.v v9, (zero)
; CHECK-NEXT:    j .LBB3_1
loopIR.preheader.i.i:
  %v15 = tail call <vscale x 1 x i16> @llvm.stepvector.nxv1i16()
  %v17 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %v15, i64 0)
  %vs12.i.i.i = add <vscale x 1 x i16> %v15, splat (i16 1)
  %v18 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %vs12.i.i.i, i64 0)
  %vs16.i.i.i = add <vscale x 1 x i16> %v15, splat (i16 3)
  %v20 = tail call <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16> poison, <vscale x 1 x i16> %vs16.i.i.i, i64 0)
  br label %loopIR3.i.i

loopIR3.i.i:                                      ; preds = %loopIR3.i.i, %loopIR.preheader.i.i
  %v37 = load <vscale x 8 x i8>, ptr addrspace(1) null, align 8
  %v38 = tail call <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> %v37, <vscale x 8 x i16> %v17, i64 4)
  %v40 = tail call <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> %v37, <vscale x 8 x i16> %v18, i64 4)
  %v42 = and <vscale x 8 x i8> %v38, %v40
  %v46 = tail call <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> %v37, <vscale x 8 x i16> %v20, i64 4)
  %v60 = and <vscale x 8 x i8> %v42, %v46
  store <vscale x 8 x i8> %v60, ptr addrspace(1) null, align 4
  br label %loopIR3.i.i
}

declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture)
declare <vscale x 2 x float> @llvm.riscv.vrgather.vx.nxv2f32.i64(<vscale x 2 x float>, <vscale x 2 x float>, i64, i64) #2
declare void @llvm.riscv.vse.nxv2f32.i64(<vscale x 2 x float>, ptr nocapture, i64)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)
declare <vscale x 1 x i16> @llvm.stepvector.nxv1i16()
declare <vscale x 8 x i16> @llvm.vector.insert.nxv8i16.nxv1i16(<vscale x 8 x i16>, <vscale x 1 x i16>, i64 immarg)
declare <vscale x 8 x i8> @llvm.riscv.vrgatherei16.vv.nxv8i8.i64(<vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i16>, i64)


define void @repeat_shuffle(<2 x double> %v, ptr noalias %q) {
; CHECK-LABEL: repeat_shuffle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v10, v8
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 2
; CHECK-NEXT:    vse64.v v10, (a0)
; CHECK-NEXT:    ret
  %w = shufflevector <2 x double> %v, <2 x double> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  store <4 x double> %w, ptr %q
  ret void
}

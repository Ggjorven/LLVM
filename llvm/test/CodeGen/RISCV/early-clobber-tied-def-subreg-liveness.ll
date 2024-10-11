; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O2 -mtriple riscv64 -mattr=+v,+m,+zbb -enable-subreg-liveness \
; RUN:     -verify-machineinstrs < %s \
; RUN:     | FileCheck %s

@var_47 = dso_local global [2 x i16] [i16 -32732, i16 19439], align 2
@__const._Z3foov.var_49 = private unnamed_addr constant [2 x i16] [i16 157, i16 24062], align 2
@__const._Z3foov.var_48 = private unnamed_addr constant [2 x i8] c"\AEN", align 1
@__const._Z3foov.var_46 = private unnamed_addr constant [2 x i16] [i16 729, i16 -32215], align 2
@__const._Z3foov.var_45 = private unnamed_addr constant [2 x i16] [i16 -27462, i16 -1435], align 2
@__const._Z3foov.var_44 = private unnamed_addr constant [2 x i16] [i16 22611, i16 -18435], align 2
@__const._Z3foov.var_40 = private unnamed_addr constant [2 x i16] [i16 -19932, i16 -26252], align 2

define void @_Z3foov() {
; CHECK-LABEL: _Z3foov:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 3
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x09, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 9 * vlenb
; CHECK-NEXT:    lui a0, %hi(.L__const._Z3foov.var_49)
; CHECK-NEXT:    addi a0, a0, %lo(.L__const._Z3foov.var_49)
; CHECK-NEXT:    vsetivli zero, 2, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    lui a0, %hi(.L__const._Z3foov.var_48)
; CHECK-NEXT:    addi a0, a0, %lo(.L__const._Z3foov.var_48)
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs1r.v v10, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    lui a0, %hi(.L__const._Z3foov.var_46)
; CHECK-NEXT:    addi a0, a0, %lo(.L__const._Z3foov.var_46)
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    lui a0, %hi(.L__const._Z3foov.var_45)
; CHECK-NEXT:    addi a0, a0, %lo(.L__const._Z3foov.var_45)
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    vs2r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vs2r.v v10, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vs2r.v v12, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vs2r.v v14, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lui a0, %hi(.L__const._Z3foov.var_40)
; CHECK-NEXT:    addi a0, a0, %lo(.L__const._Z3foov.var_40)
; CHECK-NEXT:    vsetivli zero, 2, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    lui a0, 1048572
; CHECK-NEXT:    addi a0, a0, 928
; CHECK-NEXT:    vmsbc.vx v0, v8, a0
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    vl2r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vl2r.v v10, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vl2r.v v12, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vl2r.v v14, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl1r.v v14, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, tu, mu
; CHECK-NEXT:    vsext.vf2 v8, v14, v0.t
; CHECK-NEXT:    lui a0, %hi(.L__const._Z3foov.var_44)
; CHECK-NEXT:    addi a0, a0, %lo(.L__const._Z3foov.var_44)
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v14, (a0)
; CHECK-NEXT:    lui a0, %hi(var_47)
; CHECK-NEXT:    addi a0, a0, %lo(var_47)
; CHECK-NEXT:    vsseg4e16.v v8, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 3
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
entry:
  %0 = tail call <vscale x 8 x i16> @llvm.riscv.vle.nxv8i16.i64(<vscale x 8 x i16> undef, ptr nonnull @__const._Z3foov.var_49, i64 2)
  %1 = tail call <vscale x 8 x i8> @llvm.riscv.vle.nxv8i8.i64(<vscale x 8 x i8> undef, ptr nonnull @__const._Z3foov.var_48, i64 2)
  %2 = tail call <vscale x 8 x i16> @llvm.riscv.vle.nxv8i16.i64(<vscale x 8 x i16> undef, ptr nonnull @__const._Z3foov.var_46, i64 2)
  %3 = tail call <vscale x 8 x i16> @llvm.riscv.vle.nxv8i16.i64(<vscale x 8 x i16> undef, ptr nonnull @__const._Z3foov.var_45, i64 2)
  tail call void asm sideeffect "", "~{v0},~{v1},~{v2},~{v3},~{v4},~{v5},~{v6},~{v7},~{v8},~{v9},~{v10},~{v11},~{v12},~{v13},~{v14},~{v15},~{v16},~{v17},~{v18},~{v19},~{v20},~{v21},~{v22},~{v23},~{v24},~{v25},~{v26},~{v27},~{v28},~{v29},~{v30},~{v31}"() #2
  %4 = tail call <vscale x 8 x i16> @llvm.riscv.vle.nxv8i16.i64(<vscale x 8 x i16> undef, ptr nonnull @__const._Z3foov.var_44, i64 2)
  %5 = tail call i64 @llvm.riscv.vsetvli.i64(i64 2, i64 1, i64 1)
  %6 = tail call <vscale x 8 x i16> @llvm.riscv.vle.nxv8i16.i64(<vscale x 8 x i16> undef, ptr nonnull @__const._Z3foov.var_40, i64 2)
  %7 = tail call i64 @llvm.riscv.vsetvli.i64(i64 2, i64 1, i64 1)
  %8 = tail call <vscale x 8 x i1> @llvm.riscv.vmsbc.nxv8i16.i16.i64(<vscale x 8 x i16> %6, i16 -15456, i64 2)
  %9 = tail call i64 @llvm.riscv.vsetvli.i64(i64 2, i64 1, i64 1)
  %10 = tail call <vscale x 8 x i16> @llvm.riscv.vsext.mask.nxv8i16.nxv8i8.i64(<vscale x 8 x i16> %0, <vscale x 8 x i8> %1, <vscale x 8 x i1> %8, i64 2, i64 0)
  %v_0 = call target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv16i8_4t.nxv8i16(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) poison, <vscale x 8 x i16> %10, i32 0)
  %v_1 = call target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv16i8_4t.nxv8i16(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %v_0, <vscale x 8 x i16> %2, i32 1)
  %v_2 = call target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv16i8_4t.nxv8i16(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %v_1, <vscale x 8 x i16> %3, i32 2)
  %v_3 = call target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv16i8_4t.nxv8i16(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %v_2, <vscale x 8 x i16> %4, i32 3)
  tail call void @llvm.riscv.vsseg4.nxv8i16.i64(target("riscv.vector.tuple", <vscale x 16 x i8>, 4) %v_3, ptr nonnull @var_47, i64 2, i64 4)
  ret void
}

declare <vscale x 8 x i16> @llvm.riscv.vle.nxv8i16.i64(<vscale x 8 x i16>, ptr nocapture, i64)

declare <vscale x 8 x i8> @llvm.riscv.vle.nxv8i8.i64(<vscale x 8 x i8>, ptr nocapture, i64)

declare i64 @llvm.riscv.vsetvli.i64(i64, i64 immarg, i64 immarg)

declare <vscale x 8 x i1> @llvm.riscv.vmsbc.nxv8i16.i16.i64(<vscale x 8 x i16>, i16, i64)

declare <vscale x 8 x i16> @llvm.riscv.vsext.mask.nxv8i16.nxv8i8.i64(<vscale x 8 x i16>, <vscale x 8 x i8>, <vscale x 8 x i1>, i64, i64 immarg)

declare target("riscv.vector.tuple", <vscale x 16 x i8>, 4) @llvm.riscv.tuple.insert.triscv.vector.tuple_nxv16i8_4t.nxv8i16(target("riscv.vector.tuple", <vscale x 16 x i8>, 4), <vscale x 8 x i16>, i32)

declare void @llvm.riscv.vsseg4.nxv8i16.i64(target("riscv.vector.tuple", <vscale x 16 x i8>, 4), ptr nocapture, i64, i64)

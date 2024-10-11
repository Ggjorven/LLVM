; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx900 --denormal-fp-math=preserve-sign < %s | FileCheck -check-prefix=GFX9-DENORM %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1010 < %s | FileCheck -check-prefix=GFX10 %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1010 -fp-contract=fast < %s | FileCheck -check-prefix=GFX10-CONTRACT %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1010 --denormal-fp-math=preserve-sign < %s | FileCheck -check-prefix=GFX10-DENORM %s

; fold (fadd (fma x, y, (fpext (fmul u, v))), z) -> (fma x, y, (fma (fpext u), (fpext v), z))
define amdgpu_vs float @test_f16_f32_add_fma_ext_mul(float %x, float %y, float %z, half %u, half %v) {
; GFX9-DENORM-LABEL: test_f16_f32_add_fma_ext_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v2, v3, v4, v2 op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v2, v0, v1
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_f16_f32_add_fma_ext_mul:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-NEXT:    v_fma_mix_f32 v0, v0, v1, v3 op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v2
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_f16_f32_add_fma_ext_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v0, v0, v1, v3 op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v2
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_f16_f32_add_fma_ext_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v0, v0, v1, v3 op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v2
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul half %u, %v
    %b = fpext half %a to float
    %c = call float @llvm.fmuladd.f32(float %x, float %y, float %b)
    %d = fadd float %c, %z
    ret float %d
}

; fold (fadd (fpext (fma x, y, (fmul u, v))), z) -> (fma (fpext x), (fpext y), (fma (fpext u), (fpext v), z))
define amdgpu_vs float @test_f16_f32_add_ext_fma_mul(half %x, half %y, float %z, half %u, half %v) {
; GFX9-DENORM-LABEL: test_f16_f32_add_ext_fma_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v2, v3, v4, v2 op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v0, v0, v1, v2 op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_f16_f32_add_ext_fma_mul:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-NEXT:    v_fmac_f16_e32 v3, v0, v1
; GFX10-NEXT:    v_cvt_f32_f16_e32 v0, v3
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v2
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_f16_f32_add_ext_fma_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f16_e32 v3, v0, v1
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_e32 v0, v3
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v2
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_f16_f32_add_ext_fma_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v0, v0, v1
; GFX10-DENORM-NEXT:    v_add_f16_e32 v0, v0, v3
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v2
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul half %u, %v
    %b = call half @llvm.fmuladd.f16(half %x, half %y, half %a)
    %c = fpext half %b to float
    %d = fadd float %c, %z
    ret float %d
}

; fold (fadd x, (fma y, z, (fpext (fmul u, v))) -> (fma y, z, (fma (fpext u), (fpext v), x))
define amdgpu_vs float @test_f16_f32_add_fma_ext_mul_rhs(float %x, float %y, float %z, half %u, half %v) {
; GFX9-DENORM-LABEL: test_f16_f32_add_fma_ext_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v0, v3, v4, v0 op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v0, v1, v2
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_f16_f32_add_fma_ext_mul_rhs:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-NEXT:    v_fma_mix_f32 v1, v1, v2, v3 op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v1
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_f16_f32_add_fma_ext_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v1, v1, v2, v3 op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v1
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_f16_f32_add_fma_ext_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v1, v1, v2, v3 op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v1
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul half %u, %v
    %b = fpext half %a to float
    %c = call float @llvm.fmuladd.f32(float %y, float %z, float %b)
    %d = fadd float %x, %c
    ret float %d
}

; fold (fadd x, (fpext (fma y, z, (fmul u, v))) -> (fma (fpext y), (fpext z), (fma (fpext u), (fpext v), x))
define amdgpu_vs float @test_f16_f32_add_ext_fma_mul_rhs(float %x, half %y, half %z, half %u, half %v) {
; GFX9-DENORM-LABEL: test_f16_f32_add_ext_fma_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v0, v3, v4, v0 op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v0, v1, v2, v0 op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_f16_f32_add_ext_fma_mul_rhs:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-NEXT:    v_fmac_f16_e32 v3, v1, v2
; GFX10-NEXT:    v_cvt_f32_f16_e32 v1, v3
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v1
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_f16_f32_add_ext_fma_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f16_e32 v3, v1, v2
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_e32 v1, v3
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v1
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_f16_f32_add_ext_fma_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v3, v3, v4
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v1, v1, v2
; GFX10-DENORM-NEXT:    v_add_f16_e32 v1, v1, v3
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v1
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul half %u, %v
    %b = call half @llvm.fmuladd.f16(half %y, half %z, half %a)
    %c = fpext half %b to float
    %d = fadd float %x, %c
    ret float %d
}

; fold (fadd (fma x, y, (fpext (fmul u, v))), z) -> (fma x, y, (fma (fpext u), (fpext v), z))
define amdgpu_vs <4 x float> @test_v4f16_v4f32_add_fma_ext_mul(<4 x float> %x, <4 x float> %y, <4 x float> %z, <4 x half> %u, <4 x half> %v) {
; GFX9-DENORM-LABEL: test_v4f16_v4f32_add_fma_ext_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v0, v0, v4, v12 op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v1, v1, v5, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v2, v2, v6, v13 op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v3, v3, v7, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_add_f32_e32 v0, v0, v8
; GFX9-DENORM-NEXT:    v_add_f32_e32 v1, v1, v9
; GFX9-DENORM-NEXT:    v_add_f32_e32 v2, v2, v10
; GFX9-DENORM-NEXT:    v_add_f32_e32 v3, v3, v11
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_v4f16_v4f32_add_fma_ext_mul:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX10-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX10-NEXT:    v_fma_mix_f32 v0, v0, v4, v12 op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_fma_mix_f32 v1, v1, v5, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_fma_mix_f32 v2, v2, v6, v13 op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_fma_mix_f32 v3, v3, v7, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v8
; GFX10-NEXT:    v_add_f32_e32 v1, v1, v9
; GFX10-NEXT:    v_add_f32_e32 v2, v2, v10
; GFX10-NEXT:    v_add_f32_e32 v3, v3, v11
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_v4f16_v4f32_add_fma_ext_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v0, v0, v4, v12 op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v1, v1, v5, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v2, v2, v6, v13 op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v3, v3, v7, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v8
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v1, v1, v9
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v2, v2, v10
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v3, v3, v11
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_v4f16_v4f32_add_fma_ext_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v0, v0, v4, v12 op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v1, v1, v5, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v2, v2, v6, v13 op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v3, v3, v7, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v8
; GFX10-DENORM-NEXT:    v_add_f32_e32 v1, v1, v9
; GFX10-DENORM-NEXT:    v_add_f32_e32 v2, v2, v10
; GFX10-DENORM-NEXT:    v_add_f32_e32 v3, v3, v11
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul <4 x half> %u, %v
    %b = fpext <4 x half> %a to <4 x float>
    %c = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %x, <4 x float> %y, <4 x float> %b)
    %d = fadd <4 x float> %c, %z
    ret <4 x float> %d
}

; fold (fadd (fpext (fma x, y, (fmul u, v))), z) -> (fma (fpext x), (fpext y), (fma (fpext u), (fpext v), z))
define amdgpu_vs <4 x float> @test_v4f16_v4f32_add_ext_fma_mul(<4 x half> %x, <4 x half> %y, <4 x float> %z, <4 x half> %u, <4 x half> %v) {
; GFX9-DENORM-LABEL: test_v4f16_v4f32_add_ext_fma_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v9, v9, v11
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v0, v0, v2
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v1, v1, v3
; GFX9-DENORM-NEXT:    v_pk_add_f16 v0, v0, v8
; GFX9-DENORM-NEXT:    v_pk_add_f16 v1, v1, v9
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_e32 v2, v0
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_sdwa v3, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_e32 v8, v1
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_sdwa v9, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-DENORM-NEXT:    v_add_f32_e32 v0, v2, v4
; GFX9-DENORM-NEXT:    v_add_f32_e32 v1, v3, v5
; GFX9-DENORM-NEXT:    v_add_f32_e32 v2, v8, v6
; GFX9-DENORM-NEXT:    v_add_f32_e32 v3, v9, v7
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_v4f16_v4f32_add_ext_fma_mul:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX10-NEXT:    v_pk_mul_f16 v9, v9, v11
; GFX10-NEXT:    v_pk_fma_f16 v0, v0, v2, v8
; GFX10-NEXT:    v_pk_fma_f16 v1, v1, v3, v9
; GFX10-NEXT:    v_cvt_f32_f16_e32 v2, v0
; GFX10-NEXT:    v_cvt_f32_f16_sdwa v3, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-NEXT:    v_cvt_f32_f16_e32 v8, v1
; GFX10-NEXT:    v_cvt_f32_f16_sdwa v9, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-NEXT:    v_add_f32_e32 v0, v2, v4
; GFX10-NEXT:    v_add_f32_e32 v1, v3, v5
; GFX10-NEXT:    v_add_f32_e32 v2, v8, v6
; GFX10-NEXT:    v_add_f32_e32 v3, v9, v7
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_v4f16_v4f32_add_ext_fma_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v9, v9, v11
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v0, v0, v2, v8
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v1, v1, v3, v9
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_e32 v2, v0
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_sdwa v3, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_e32 v8, v1
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_sdwa v9, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v2, v4
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v1, v3, v5
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v2, v8, v6
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v3, v9, v7
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_v4f16_v4f32_add_ext_fma_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v0, v0, v2
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v2, v9, v11
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v1, v1, v3
; GFX10-DENORM-NEXT:    v_pk_add_f16 v0, v0, v8
; GFX10-DENORM-NEXT:    v_pk_add_f16 v1, v1, v2
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_e32 v2, v0
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_sdwa v3, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_e32 v8, v1
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_sdwa v9, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v2, v4
; GFX10-DENORM-NEXT:    v_add_f32_e32 v1, v3, v5
; GFX10-DENORM-NEXT:    v_add_f32_e32 v2, v8, v6
; GFX10-DENORM-NEXT:    v_add_f32_e32 v3, v9, v7
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul <4 x half> %u, %v
    %b = call <4 x half> @llvm.fmuladd.v4f16(<4 x half> %x, <4 x half> %y, <4 x half> %a)
    %c = fpext <4 x half> %b to <4 x float>
    %d = fadd <4 x float> %c, %z
    ret <4 x float> %d
}

; fold (fadd x, (fma y, z, (fpext (fmul u, v))) -> (fma y, z, (fma (fpext u), (fpext v), x))
define amdgpu_vs <4 x float> @test_v4f16_v4f32_add_fma_ext_mul_rhs(<4 x float> %x, <4 x float> %y, <4 x float> %z, <4 x half> %u, <4 x half> %v) {
; GFX9-DENORM-LABEL: test_v4f16_v4f32_add_fma_ext_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v4, v4, v8, v12 op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v5, v5, v9, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v6, v6, v10, v13 op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v7, v7, v11, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX9-DENORM-NEXT:    v_add_f32_e32 v0, v0, v4
; GFX9-DENORM-NEXT:    v_add_f32_e32 v1, v1, v5
; GFX9-DENORM-NEXT:    v_add_f32_e32 v2, v2, v6
; GFX9-DENORM-NEXT:    v_add_f32_e32 v3, v3, v7
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_v4f16_v4f32_add_fma_ext_mul_rhs:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX10-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX10-NEXT:    v_fma_mix_f32 v4, v4, v8, v12 op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_fma_mix_f32 v5, v5, v9, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_fma_mix_f32 v6, v6, v10, v13 op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_fma_mix_f32 v7, v7, v11, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v4
; GFX10-NEXT:    v_add_f32_e32 v1, v1, v5
; GFX10-NEXT:    v_add_f32_e32 v2, v2, v6
; GFX10-NEXT:    v_add_f32_e32 v3, v3, v7
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_v4f16_v4f32_add_fma_ext_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v4, v4, v8, v12 op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v5, v5, v9, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v6, v6, v10, v13 op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v7, v7, v11, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v4
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v1, v1, v5
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v2, v2, v6
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v3, v3, v7
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_v4f16_v4f32_add_fma_ext_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v12, v12, v14
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v13, v13, v15
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v4, v4, v8, v12 op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v5, v5, v9, v12 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v6, v6, v10, v13 op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v7, v7, v11, v13 op_sel:[0,0,1] op_sel_hi:[0,0,1]
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v4
; GFX10-DENORM-NEXT:    v_add_f32_e32 v1, v1, v5
; GFX10-DENORM-NEXT:    v_add_f32_e32 v2, v2, v6
; GFX10-DENORM-NEXT:    v_add_f32_e32 v3, v3, v7
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul <4 x half> %u, %v
    %b = fpext <4 x half> %a to <4 x float>
    %c = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %y, <4 x float> %z, <4 x float> %b)
    %d = fadd <4 x float> %x, %c
    ret <4 x float> %d
}

; fold (fadd x, (fpext (fma y, z, (fmul u, v))) -> (fma (fpext y), (fpext z), (fma (fpext u), (fpext v), x))
define amdgpu_vs <4 x float> @test_v4f16_v4f32_add_ext_fma_mul_rhs(<4 x float> %x, <4 x half> %y, <4 x half> %z, <4 x half> %u, <4 x half> %v) {
; GFX9-DENORM-LABEL: test_v4f16_v4f32_add_ext_fma_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v9, v9, v11
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v4, v4, v6
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v5, v5, v7
; GFX9-DENORM-NEXT:    v_pk_add_f16 v4, v4, v8
; GFX9-DENORM-NEXT:    v_pk_add_f16 v5, v5, v9
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_e32 v6, v4
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_sdwa v4, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_e32 v7, v5
; GFX9-DENORM-NEXT:    v_cvt_f32_f16_sdwa v5, v5 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-DENORM-NEXT:    v_add_f32_e32 v0, v0, v6
; GFX9-DENORM-NEXT:    v_add_f32_e32 v1, v1, v4
; GFX9-DENORM-NEXT:    v_add_f32_e32 v2, v2, v7
; GFX9-DENORM-NEXT:    v_add_f32_e32 v3, v3, v5
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_v4f16_v4f32_add_ext_fma_mul_rhs:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX10-NEXT:    v_pk_mul_f16 v9, v9, v11
; GFX10-NEXT:    v_pk_fma_f16 v4, v4, v6, v8
; GFX10-NEXT:    v_pk_fma_f16 v5, v5, v7, v9
; GFX10-NEXT:    v_cvt_f32_f16_e32 v6, v4
; GFX10-NEXT:    v_cvt_f32_f16_sdwa v4, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-NEXT:    v_cvt_f32_f16_e32 v7, v5
; GFX10-NEXT:    v_cvt_f32_f16_sdwa v5, v5 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-NEXT:    v_add_f32_e32 v0, v0, v6
; GFX10-NEXT:    v_add_f32_e32 v1, v1, v4
; GFX10-NEXT:    v_add_f32_e32 v2, v2, v7
; GFX10-NEXT:    v_add_f32_e32 v3, v3, v5
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_v4f16_v4f32_add_ext_fma_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX10-CONTRACT-NEXT:    v_pk_mul_f16 v9, v9, v11
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v4, v4, v6, v8
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v5, v5, v7, v9
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_e32 v6, v4
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_sdwa v4, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_e32 v7, v5
; GFX10-CONTRACT-NEXT:    v_cvt_f32_f16_sdwa v5, v5 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v0, v0, v6
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v1, v1, v4
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v2, v2, v7
; GFX10-CONTRACT-NEXT:    v_add_f32_e32 v3, v3, v5
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_v4f16_v4f32_add_ext_fma_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v8, v8, v10
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v4, v4, v6
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v6, v9, v11
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v5, v5, v7
; GFX10-DENORM-NEXT:    v_pk_add_f16 v4, v4, v8
; GFX10-DENORM-NEXT:    v_pk_add_f16 v5, v5, v6
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_e32 v6, v4
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_sdwa v4, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_e32 v7, v5
; GFX10-DENORM-NEXT:    v_cvt_f32_f16_sdwa v5, v5 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX10-DENORM-NEXT:    v_add_f32_e32 v0, v0, v6
; GFX10-DENORM-NEXT:    v_add_f32_e32 v1, v1, v4
; GFX10-DENORM-NEXT:    v_add_f32_e32 v2, v2, v7
; GFX10-DENORM-NEXT:    v_add_f32_e32 v3, v3, v5
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = fmul <4 x half> %u, %v
    %b = call <4 x half> @llvm.fmuladd.v4f16(<4 x half> %y, <4 x half> %z, <4 x half> %a)
    %c = fpext <4 x half> %b to <4 x float>
    %d = fadd <4 x float> %x, %c
    ret <4 x float> %d
}

define amdgpu_ps float @test_matching_source_from_unmerge(ptr addrspace(3) %aptr, float %b) {
; GFX9-DENORM-LABEL: test_matching_source_from_unmerge:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    ds_read_b64 v[2:3], v0
; GFX9-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_mix_f32 v0, v2, v3, v1 op_sel:[1,1,0] op_sel_hi:[1,1,0]
; GFX9-DENORM-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: test_matching_source_from_unmerge:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    ds_read_b64 v[2:3], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_fma_mix_f32 v0, v2, v3, v1 op_sel:[1,1,0] op_sel_hi:[1,1,0]
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX10-CONTRACT-LABEL: test_matching_source_from_unmerge:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    ds_read_b64 v[2:3], v0
; GFX10-CONTRACT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    v_fma_mix_f32 v0, v2, v3, v1 op_sel:[1,1,0] op_sel_hi:[1,1,0]
; GFX10-CONTRACT-NEXT:    ; return to shader part epilog
;
; GFX10-DENORM-LABEL: test_matching_source_from_unmerge:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    ds_read_b64 v[2:3], v0
; GFX10-DENORM-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-DENORM-NEXT:    v_fma_mix_f32 v0, v2, v3, v1 op_sel:[1,1,0] op_sel_hi:[1,1,0]
; GFX10-DENORM-NEXT:    ; return to shader part epilog
.entry:
    %a = load <4 x half>, ptr addrspace(3) %aptr, align 16
    %a_f32 = fpext <4 x half> %a to <4 x float>
    %.a3_f32 = extractelement <4 x float> %a_f32, i64 3
    %.a1_f32 = extractelement <4 x float> %a_f32, i64 1
    %res = call float @llvm.fmuladd.f32(float %.a1_f32, float %.a3_f32, float %b)
    ret float %res
}

declare float @llvm.fmuladd.f32(float, float, float) #0
declare half @llvm.fmuladd.f16(half, half, half) #0
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #0
declare <4 x half> @llvm.fmuladd.v4f16(<4 x half>, <4 x half>, <4 x half>) #0

attributes #0 = { nounwind readnone }

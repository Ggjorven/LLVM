; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 --mattr=+f,-d < %s | FileCheck %s --check-prefix=LA32F
; RUN: llc --mtriple=loongarch32 --mattr=+d < %s | FileCheck %s --check-prefix=LA32D
; RUN: llc --mtriple=loongarch64 --mattr=+f,-d < %s | FileCheck %s --check-prefix=LA64F
; RUN: llc --mtriple=loongarch64 --mattr=+d < %s | FileCheck %s --check-prefix=LA64D

define signext i8 @convert_float_to_i8(float %a) nounwind {
; LA32F-LABEL: convert_float_to_i8:
; LA32F:       # %bb.0:
; LA32F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32F-NEXT:    movfr2gr.s $a0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_i8:
; LA32D:       # %bb.0:
; LA32D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32D-NEXT:    movfr2gr.s $a0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_i8:
; LA64F:       # %bb.0:
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_i8:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptosi float %a to i8
  ret i8 %1
}

define signext i16 @convert_float_to_i16(float %a) nounwind {
; LA32F-LABEL: convert_float_to_i16:
; LA32F:       # %bb.0:
; LA32F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32F-NEXT:    movfr2gr.s $a0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_i16:
; LA32D:       # %bb.0:
; LA32D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32D-NEXT:    movfr2gr.s $a0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_i16:
; LA64F:       # %bb.0:
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_i16:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptosi float %a to i16
  ret i16 %1
}

define i32 @convert_float_to_i32(float %a) nounwind {
; LA32F-LABEL: convert_float_to_i32:
; LA32F:       # %bb.0:
; LA32F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32F-NEXT:    movfr2gr.s $a0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_i32:
; LA32D:       # %bb.0:
; LA32D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32D-NEXT:    movfr2gr.s $a0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_i32:
; LA64F:       # %bb.0:
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_i32:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.s $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptosi float %a to i32
  ret i32 %1
}

define i64 @convert_float_to_i64(float %a) nounwind {
; LA32F-LABEL: convert_float_to_i64:
; LA32F:       # %bb.0:
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(__fixsfdi)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_i64:
; LA32D:       # %bb.0:
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32D-NEXT:    bl %plt(__fixsfdi)
; LA32D-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_i64:
; LA64F:       # %bb.0:
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_i64:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptosi float %a to i64
  ret i64 %1
}

define zeroext i8 @convert_float_to_u8(float %a) nounwind {
; LA32F-LABEL: convert_float_to_u8:
; LA32F:       # %bb.0:
; LA32F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32F-NEXT:    movfr2gr.s $a0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_u8:
; LA32D:       # %bb.0:
; LA32D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32D-NEXT:    movfr2gr.s $a0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_u8:
; LA64F:       # %bb.0:
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_u8:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptoui float %a to i8
  ret i8 %1
}

define zeroext i16 @convert_float_to_u16(float %a) nounwind {
; LA32F-LABEL: convert_float_to_u16:
; LA32F:       # %bb.0:
; LA32F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32F-NEXT:    movfr2gr.s $a0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_u16:
; LA32D:       # %bb.0:
; LA32D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32D-NEXT:    movfr2gr.s $a0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_u16:
; LA64F:       # %bb.0:
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_u16:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptoui float %a to i16
  ret i16 %1
}

define i32 @convert_float_to_u32(float %a) nounwind {
; LA32F-LABEL: convert_float_to_u32:
; LA32F:       # %bb.0:
; LA32F-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI6_0)
; LA32F-NEXT:    fld.s $fa1, $a0, %pc_lo12(.LCPI6_0)
; LA32F-NEXT:    fcmp.clt.s $fcc0, $fa0, $fa1
; LA32F-NEXT:    fsub.s $fa1, $fa0, $fa1
; LA32F-NEXT:    ftintrz.w.s $fa1, $fa1
; LA32F-NEXT:    movfr2gr.s $a0, $fa1
; LA32F-NEXT:    lu12i.w $a1, -524288
; LA32F-NEXT:    xor $a0, $a0, $a1
; LA32F-NEXT:    movcf2gr $a1, $fcc0
; LA32F-NEXT:    masknez $a0, $a0, $a1
; LA32F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32F-NEXT:    movfr2gr.s $a2, $fa0
; LA32F-NEXT:    maskeqz $a1, $a2, $a1
; LA32F-NEXT:    or $a0, $a1, $a0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_u32:
; LA32D:       # %bb.0:
; LA32D-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI6_0)
; LA32D-NEXT:    fld.s $fa1, $a0, %pc_lo12(.LCPI6_0)
; LA32D-NEXT:    fcmp.clt.s $fcc0, $fa0, $fa1
; LA32D-NEXT:    fsub.s $fa1, $fa0, $fa1
; LA32D-NEXT:    ftintrz.w.s $fa1, $fa1
; LA32D-NEXT:    movfr2gr.s $a0, $fa1
; LA32D-NEXT:    lu12i.w $a1, -524288
; LA32D-NEXT:    xor $a0, $a0, $a1
; LA32D-NEXT:    movcf2gr $a1, $fcc0
; LA32D-NEXT:    masknez $a0, $a0, $a1
; LA32D-NEXT:    ftintrz.w.s $fa0, $fa0
; LA32D-NEXT:    movfr2gr.s $a2, $fa0
; LA32D-NEXT:    maskeqz $a1, $a2, $a1
; LA32D-NEXT:    or $a0, $a1, $a0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_u32:
; LA64F:       # %bb.0:
; LA64F-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI6_0)
; LA64F-NEXT:    fld.s $fa1, $a0, %pc_lo12(.LCPI6_0)
; LA64F-NEXT:    fcmp.clt.s $fcc0, $fa0, $fa1
; LA64F-NEXT:    fsub.s $fa1, $fa0, $fa1
; LA64F-NEXT:    ftintrz.w.s $fa1, $fa1
; LA64F-NEXT:    movfr2gr.s $a0, $fa1
; LA64F-NEXT:    lu12i.w $a1, -524288
; LA64F-NEXT:    xor $a0, $a0, $a1
; LA64F-NEXT:    movcf2gr $a1, $fcc0
; LA64F-NEXT:    masknez $a0, $a0, $a1
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a2, $fa0
; LA64F-NEXT:    maskeqz $a1, $a2, $a1
; LA64F-NEXT:    or $a0, $a1, $a0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_u32:
; LA64D:       # %bb.0:
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a0, $fa0
; LA64D-NEXT:    ret
  %1 = fptoui float %a to i32
  ret i32 %1
}

define i64 @convert_float_to_u64(float %a) nounwind {
; LA32F-LABEL: convert_float_to_u64:
; LA32F:       # %bb.0:
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(__fixunssfdi)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_float_to_u64:
; LA32D:       # %bb.0:
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32D-NEXT:    bl %plt(__fixunssfdi)
; LA32D-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_float_to_u64:
; LA64F:       # %bb.0:
; LA64F-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI7_0)
; LA64F-NEXT:    fld.s $fa1, $a0, %pc_lo12(.LCPI7_0)
; LA64F-NEXT:    fcmp.clt.s $fcc0, $fa0, $fa1
; LA64F-NEXT:    fsub.s $fa1, $fa0, $fa1
; LA64F-NEXT:    ftintrz.w.s $fa1, $fa1
; LA64F-NEXT:    movfr2gr.s $a0, $fa1
; LA64F-NEXT:    lu52i.d $a1, $zero, -2048
; LA64F-NEXT:    xor $a0, $a0, $a1
; LA64F-NEXT:    movcf2gr $a1, $fcc0
; LA64F-NEXT:    masknez $a0, $a0, $a1
; LA64F-NEXT:    ftintrz.w.s $fa0, $fa0
; LA64F-NEXT:    movfr2gr.s $a2, $fa0
; LA64F-NEXT:    maskeqz $a1, $a2, $a1
; LA64F-NEXT:    or $a0, $a1, $a0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_float_to_u64:
; LA64D:       # %bb.0:
; LA64D-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI7_0)
; LA64D-NEXT:    fld.s $fa1, $a0, %pc_lo12(.LCPI7_0)
; LA64D-NEXT:    fcmp.clt.s $fcc0, $fa0, $fa1
; LA64D-NEXT:    fsub.s $fa1, $fa0, $fa1
; LA64D-NEXT:    ftintrz.l.s $fa1, $fa1
; LA64D-NEXT:    movfr2gr.d $a0, $fa1
; LA64D-NEXT:    lu52i.d $a1, $zero, -2048
; LA64D-NEXT:    xor $a0, $a0, $a1
; LA64D-NEXT:    movcf2gr $a1, $fcc0
; LA64D-NEXT:    masknez $a0, $a0, $a1
; LA64D-NEXT:    ftintrz.l.s $fa0, $fa0
; LA64D-NEXT:    movfr2gr.d $a2, $fa0
; LA64D-NEXT:    maskeqz $a1, $a2, $a1
; LA64D-NEXT:    or $a0, $a1, $a0
; LA64D-NEXT:    ret
  %1 = fptoui float %a to i64
  ret i64 %1
}

define float @convert_i8_to_float(i8 signext %a) nounwind {
; LA32F-LABEL: convert_i8_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movgr2fr.w $fa0, $a0
; LA32F-NEXT:    ffint.s.w $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_i8_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movgr2fr.w $fa0, $a0
; LA32D-NEXT:    ffint.s.w $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_i8_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movgr2fr.w $fa0, $a0
; LA64F-NEXT:    ffint.s.w $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_i8_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.w $fa0, $a0
; LA64D-NEXT:    ffint.s.w $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = sitofp i8 %a to float
  ret float %1
}

define float @convert_i16_to_float(i16 signext %a) nounwind {
; LA32F-LABEL: convert_i16_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movgr2fr.w $fa0, $a0
; LA32F-NEXT:    ffint.s.w $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_i16_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movgr2fr.w $fa0, $a0
; LA32D-NEXT:    ffint.s.w $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_i16_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movgr2fr.w $fa0, $a0
; LA64F-NEXT:    ffint.s.w $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_i16_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.w $fa0, $a0
; LA64D-NEXT:    ffint.s.w $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = sitofp i16 %a to float
  ret float %1
}

define float @convert_i32_to_float(i32 %a) nounwind {
; LA32F-LABEL: convert_i32_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movgr2fr.w $fa0, $a0
; LA32F-NEXT:    ffint.s.w $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_i32_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movgr2fr.w $fa0, $a0
; LA32D-NEXT:    ffint.s.w $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_i32_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movgr2fr.w $fa0, $a0
; LA64F-NEXT:    ffint.s.w $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_i32_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.w $fa0, $a0
; LA64D-NEXT:    ffint.s.w $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = sitofp i32 %a to float
  ret float %1
}

define float @convert_i64_to_float(i64 %a) nounwind {
; LA32F-LABEL: convert_i64_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(__floatdisf)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_i64_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32D-NEXT:    bl %plt(__floatdisf)
; LA32D-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_i64_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    addi.d $sp, $sp, -16
; LA64F-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64F-NEXT:    bl %plt(__floatdisf)
; LA64F-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64F-NEXT:    addi.d $sp, $sp, 16
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_i64_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.d $fa0, $a0
; LA64D-NEXT:    ffint.s.l $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = sitofp i64 %a to float
  ret float %1
}

define float @convert_u8_to_float(i8 zeroext %a) nounwind {
; LA32F-LABEL: convert_u8_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movgr2fr.w $fa0, $a0
; LA32F-NEXT:    ffint.s.w $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_u8_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movgr2fr.w $fa0, $a0
; LA32D-NEXT:    ffint.s.w $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_u8_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movgr2fr.w $fa0, $a0
; LA64F-NEXT:    ffint.s.w $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_u8_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.w $fa0, $a0
; LA64D-NEXT:    ffint.s.w $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = uitofp i8 %a to float
  ret float %1
}

define float @convert_u16_to_float(i16 zeroext %a) nounwind {
; LA32F-LABEL: convert_u16_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movgr2fr.w $fa0, $a0
; LA32F-NEXT:    ffint.s.w $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_u16_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movgr2fr.w $fa0, $a0
; LA32D-NEXT:    ffint.s.w $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_u16_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movgr2fr.w $fa0, $a0
; LA64F-NEXT:    ffint.s.w $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_u16_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.w $fa0, $a0
; LA64D-NEXT:    ffint.s.w $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = uitofp i16 %a to float
  ret float %1
}

define float @convert_u32_to_float(i32 %a) nounwind {
; LA32F-LABEL: convert_u32_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    srli.w $a1, $a0, 1
; LA32F-NEXT:    andi $a2, $a0, 1
; LA32F-NEXT:    or $a1, $a2, $a1
; LA32F-NEXT:    movgr2fr.w $fa0, $a1
; LA32F-NEXT:    ffint.s.w $fa0, $fa0
; LA32F-NEXT:    fadd.s $fa0, $fa0, $fa0
; LA32F-NEXT:    slti $a1, $a0, 0
; LA32F-NEXT:    movgr2fr.w $fa1, $a0
; LA32F-NEXT:    ffint.s.w $fa1, $fa1
; LA32F-NEXT:    movgr2cf $fcc0, $a1
; LA32F-NEXT:    fsel $fa0, $fa1, $fa0, $fcc0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_u32_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    lu12i.w $a1, 275200
; LA32D-NEXT:    st.w $a1, $sp, 12
; LA32D-NEXT:    st.w $a0, $sp, 8
; LA32D-NEXT:    fld.d $fa0, $sp, 8
; LA32D-NEXT:    pcalau12i $a0, %pc_hi20(.LCPI14_0)
; LA32D-NEXT:    fld.d $fa1, $a0, %pc_lo12(.LCPI14_0)
; LA32D-NEXT:    fsub.d $fa0, $fa0, $fa1
; LA32D-NEXT:    fcvt.s.d $fa0, $fa0
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_u32_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    addi.d $sp, $sp, -16
; LA64F-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64F-NEXT:    bstrpick.d $a0, $a0, 31, 0
; LA64F-NEXT:    bl %plt(__floatundisf)
; LA64F-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64F-NEXT:    addi.d $sp, $sp, 16
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_u32_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    bstrpick.d $a0, $a0, 31, 0
; LA64D-NEXT:    movgr2fr.d $fa0, $a0
; LA64D-NEXT:    ffint.s.l $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = uitofp i32 %a to float
  ret float %1
}

define float @convert_u64_to_float(i64 %a) nounwind {
; LA32F-LABEL: convert_u64_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(__floatundisf)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: convert_u64_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32D-NEXT:    bl %plt(__floatundisf)
; LA32D-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: convert_u64_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    addi.d $sp, $sp, -16
; LA64F-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64F-NEXT:    bl %plt(__floatundisf)
; LA64F-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64F-NEXT:    addi.d $sp, $sp, 16
; LA64F-NEXT:    ret
;
; LA64D-LABEL: convert_u64_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    srli.d $a1, $a0, 1
; LA64D-NEXT:    andi $a2, $a0, 1
; LA64D-NEXT:    or $a1, $a2, $a1
; LA64D-NEXT:    movgr2fr.d $fa0, $a1
; LA64D-NEXT:    ffint.s.l $fa0, $fa0
; LA64D-NEXT:    fadd.s $fa0, $fa0, $fa0
; LA64D-NEXT:    slti $a1, $a0, 0
; LA64D-NEXT:    movgr2fr.d $fa1, $a0
; LA64D-NEXT:    ffint.s.l $fa1, $fa1
; LA64D-NEXT:    movgr2cf $fcc0, $a1
; LA64D-NEXT:    fsel $fa0, $fa1, $fa0, $fcc0
; LA64D-NEXT:    ret
  %1 = uitofp i64 %a to float
  ret float %1
}

define i32 @bitcast_float_to_i32(float %a) nounwind {
; LA32F-LABEL: bitcast_float_to_i32:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movfr2gr.s $a0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: bitcast_float_to_i32:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movfr2gr.s $a0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: bitcast_float_to_i32:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movfr2gr.s $a0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: bitcast_float_to_i32:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movfr2gr.s $a0, $fa0
; LA64D-NEXT:    ret
  %1 = bitcast float %a to i32
  ret i32 %1
}

define float @bitcast_i32_to_float(i32 %a) nounwind {
; LA32F-LABEL: bitcast_i32_to_float:
; LA32F:       # %bb.0:
; LA32F-NEXT:    movgr2fr.w $fa0, $a0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: bitcast_i32_to_float:
; LA32D:       # %bb.0:
; LA32D-NEXT:    movgr2fr.w $fa0, $a0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: bitcast_i32_to_float:
; LA64F:       # %bb.0:
; LA64F-NEXT:    movgr2fr.w $fa0, $a0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: bitcast_i32_to_float:
; LA64D:       # %bb.0:
; LA64D-NEXT:    movgr2fr.w $fa0, $a0
; LA64D-NEXT:    ret
  %1 = bitcast i32 %a to float
  ret float %1
}

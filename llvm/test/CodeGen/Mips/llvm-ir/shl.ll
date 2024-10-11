; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS2
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r5 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r6 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R6
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS3
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips4 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS4
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64r2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64r3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64r5 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64r6 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R6
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r3 -mattr=+micromips -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MMR3
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r6 -mattr=+micromips -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MMR6

define signext i1 @shl_i1(i1 signext %a, i1 signext %b) {
; MIPS2-LABEL: shl_i1:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    move $2, $4
;
; MIPS32-LABEL: shl_i1:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    move $2, $4
;
; MIPS32R2-LABEL: shl_i1:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    move $2, $4
;
; MIPS32R6-LABEL: shl_i1:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    move $2, $4
;
; MIPS3-LABEL: shl_i1:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    move $2, $4
;
; MIPS4-LABEL: shl_i1:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    move $2, $4
;
; MIPS64-LABEL: shl_i1:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    move $2, $4
;
; MIPS64R2-LABEL: shl_i1:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    move $2, $4
;
; MIPS64R6-LABEL: shl_i1:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    move $2, $4
;
; MMR3-LABEL: shl_i1:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    move $2, $4
; MMR3-NEXT:    jrc $ra
;
; MMR6-LABEL: shl_i1:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    move $2, $4
; MMR6-NEXT:    jrc $ra
entry:

  %r = shl i1 %a, %b
  ret i1 %r
}

define signext i8 @shl_i8(i8 signext %a, i8 signext %b) {
; MIPS2-LABEL: shl_i8:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    sllv $1, $4, $5
; MIPS2-NEXT:    sll $1, $1, 24
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    sra $2, $1, 24
;
; MIPS32-LABEL: shl_i8:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sllv $1, $4, $5
; MIPS32-NEXT:    sll $1, $1, 24
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    sra $2, $1, 24
;
; MIPS32R2-LABEL: shl_i8:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    sllv $1, $4, $5
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    seb $2, $1
;
; MIPS32R6-LABEL: shl_i8:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    sllv $1, $4, $5
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    seb $2, $1
;
; MIPS3-LABEL: shl_i8:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    sllv $1, $4, $5
; MIPS3-NEXT:    sll $1, $1, 24
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    sra $2, $1, 24
;
; MIPS4-LABEL: shl_i8:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    sllv $1, $4, $5
; MIPS4-NEXT:    sll $1, $1, 24
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    sra $2, $1, 24
;
; MIPS64-LABEL: shl_i8:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    sllv $1, $4, $5
; MIPS64-NEXT:    sll $1, $1, 24
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    sra $2, $1, 24
;
; MIPS64R2-LABEL: shl_i8:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    sllv $1, $4, $5
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    seb $2, $1
;
; MIPS64R6-LABEL: shl_i8:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    sllv $1, $4, $5
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    seb $2, $1
;
; MMR3-LABEL: shl_i8:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    andi16 $2, $5, 255
; MMR3-NEXT:    sllv $1, $4, $2
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    seb $2, $1
;
; MMR6-LABEL: shl_i8:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    andi16 $2, $5, 255
; MMR6-NEXT:    sllv $1, $4, $2
; MMR6-NEXT:    seb $2, $1
; MMR6-NEXT:    jrc $ra
entry:

  %r = shl i8 %a, %b
  ret i8 %r
}

define signext i16 @shl_i16(i16 signext %a, i16 signext %b) {
; MIPS2-LABEL: shl_i16:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    sllv $1, $4, $5
; MIPS2-NEXT:    sll $1, $1, 16
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    sra $2, $1, 16
;
; MIPS32-LABEL: shl_i16:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sllv $1, $4, $5
; MIPS32-NEXT:    sll $1, $1, 16
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    sra $2, $1, 16
;
; MIPS32R2-LABEL: shl_i16:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    sllv $1, $4, $5
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    seh $2, $1
;
; MIPS32R6-LABEL: shl_i16:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    sllv $1, $4, $5
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    seh $2, $1
;
; MIPS3-LABEL: shl_i16:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    sllv $1, $4, $5
; MIPS3-NEXT:    sll $1, $1, 16
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    sra $2, $1, 16
;
; MIPS4-LABEL: shl_i16:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    sllv $1, $4, $5
; MIPS4-NEXT:    sll $1, $1, 16
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    sra $2, $1, 16
;
; MIPS64-LABEL: shl_i16:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    sllv $1, $4, $5
; MIPS64-NEXT:    sll $1, $1, 16
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    sra $2, $1, 16
;
; MIPS64R2-LABEL: shl_i16:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    sllv $1, $4, $5
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    seh $2, $1
;
; MIPS64R6-LABEL: shl_i16:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    sllv $1, $4, $5
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    seh $2, $1
;
; MMR3-LABEL: shl_i16:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    andi16 $2, $5, 65535
; MMR3-NEXT:    sllv $1, $4, $2
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    seh $2, $1
;
; MMR6-LABEL: shl_i16:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    andi16 $2, $5, 65535
; MMR6-NEXT:    sllv $1, $4, $2
; MMR6-NEXT:    seh $2, $1
; MMR6-NEXT:    jrc $ra
entry:

  %r = shl i16 %a, %b
  ret i16 %r
}

define signext i32 @shl_i32(i32 signext %a, i32 signext %b) {
; MIPS2-LABEL: shl_i32:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    sllv $2, $4, $5
;
; MIPS32-LABEL: shl_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    sllv $2, $4, $5
;
; MIPS32R2-LABEL: shl_i32:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    sllv $2, $4, $5
;
; MIPS32R6-LABEL: shl_i32:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    sllv $2, $4, $5
;
; MIPS3-LABEL: shl_i32:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    sllv $2, $4, $5
;
; MIPS4-LABEL: shl_i32:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    sllv $2, $4, $5
;
; MIPS64-LABEL: shl_i32:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    sllv $2, $4, $5
;
; MIPS64R2-LABEL: shl_i32:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    sllv $2, $4, $5
;
; MIPS64R6-LABEL: shl_i32:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    sllv $2, $4, $5
;
; MMR3-LABEL: shl_i32:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    sllv $2, $4, $5
;
; MMR6-LABEL: shl_i32:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    sllv $2, $4, $5
; MMR6-NEXT:    jrc $ra
entry:

  %r = shl i32 %a, %b
  ret i32 %r
}

define signext i64 @shl_i64(i64 signext %a, i64 signext %b) {
; MIPS2-LABEL: shl_i64:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    sllv $6, $5, $7
; MIPS2-NEXT:    andi $8, $7, 32
; MIPS2-NEXT:    beqz $8, $BB4_3
; MIPS2-NEXT:    move $2, $6
; MIPS2-NEXT:  # %bb.1: # %entry
; MIPS2-NEXT:    beqz $8, $BB4_4
; MIPS2-NEXT:    addiu $3, $zero, 0
; MIPS2-NEXT:  $BB4_2: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    nop
; MIPS2-NEXT:  $BB4_3: # %entry
; MIPS2-NEXT:    sllv $1, $4, $7
; MIPS2-NEXT:    xori $2, $7, 31
; MIPS2-NEXT:    srl $3, $5, 1
; MIPS2-NEXT:    srlv $2, $3, $2
; MIPS2-NEXT:    or $2, $1, $2
; MIPS2-NEXT:    bnez $8, $BB4_2
; MIPS2-NEXT:    addiu $3, $zero, 0
; MIPS2-NEXT:  $BB4_4: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    move $3, $6
;
; MIPS32-LABEL: shl_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sllv $1, $4, $7
; MIPS32-NEXT:    xori $2, $7, 31
; MIPS32-NEXT:    srl $3, $5, 1
; MIPS32-NEXT:    srlv $2, $3, $2
; MIPS32-NEXT:    or $2, $1, $2
; MIPS32-NEXT:    sllv $3, $5, $7
; MIPS32-NEXT:    andi $1, $7, 32
; MIPS32-NEXT:    movn $2, $3, $1
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    movn $3, $zero, $1
;
; MIPS32R2-LABEL: shl_i64:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    sllv $1, $4, $7
; MIPS32R2-NEXT:    xori $2, $7, 31
; MIPS32R2-NEXT:    srl $3, $5, 1
; MIPS32R2-NEXT:    srlv $2, $3, $2
; MIPS32R2-NEXT:    or $2, $1, $2
; MIPS32R2-NEXT:    sllv $3, $5, $7
; MIPS32R2-NEXT:    andi $1, $7, 32
; MIPS32R2-NEXT:    movn $2, $3, $1
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    movn $3, $zero, $1
;
; MIPS32R6-LABEL: shl_i64:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    sllv $1, $4, $7
; MIPS32R6-NEXT:    xori $2, $7, 31
; MIPS32R6-NEXT:    srl $3, $5, 1
; MIPS32R6-NEXT:    srlv $2, $3, $2
; MIPS32R6-NEXT:    or $1, $1, $2
; MIPS32R6-NEXT:    andi $3, $7, 32
; MIPS32R6-NEXT:    seleqz $1, $1, $3
; MIPS32R6-NEXT:    sllv $4, $5, $7
; MIPS32R6-NEXT:    selnez $2, $4, $3
; MIPS32R6-NEXT:    or $2, $2, $1
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    seleqz $3, $4, $3
;
; MIPS3-LABEL: shl_i64:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    dsllv $2, $4, $5
;
; MIPS4-LABEL: shl_i64:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    dsllv $2, $4, $5
;
; MIPS64-LABEL: shl_i64:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    dsllv $2, $4, $5
;
; MIPS64R2-LABEL: shl_i64:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    dsllv $2, $4, $5
;
; MIPS64R6-LABEL: shl_i64:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    dsllv $2, $4, $5
;
; MMR3-LABEL: shl_i64:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    sllv $3, $4, $7
; MMR3-NEXT:    xori $1, $7, 31
; MMR3-NEXT:    srl16 $2, $5, 1
; MMR3-NEXT:    srlv $2, $2, $1
; MMR3-NEXT:    or16 $2, $3
; MMR3-NEXT:    sllv $3, $5, $7
; MMR3-NEXT:    andi16 $4, $7, 32
; MMR3-NEXT:    movn $2, $3, $4
; MMR3-NEXT:    li16 $5, 0
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    movn $3, $5, $4
;
; MMR6-LABEL: shl_i64:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    sllv $1, $4, $7
; MMR6-NEXT:    xori $2, $7, 31
; MMR6-NEXT:    srl16 $3, $5, 1
; MMR6-NEXT:    srlv $2, $3, $2
; MMR6-NEXT:    or $1, $1, $2
; MMR6-NEXT:    andi16 $3, $7, 32
; MMR6-NEXT:    seleqz $1, $1, $3
; MMR6-NEXT:    sllv $4, $5, $7
; MMR6-NEXT:    selnez $2, $4, $3
; MMR6-NEXT:    or $2, $2, $1
; MMR6-NEXT:    seleqz $3, $4, $3
; MMR6-NEXT:    jrc $ra
entry:

  %r = shl i64 %a, %b
  ret i64 %r
}

define signext i128 @shl_i128(i128 signext %a, i128 signext %b) {
; MIPS2-LABEL: shl_i128:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    addiu $sp, $sp, -32
; MIPS2-NEXT:    .cfi_def_cfa_offset 32
; MIPS2-NEXT:    lw $1, 60($sp)
; MIPS2-NEXT:    srl $2, $1, 3
; MIPS2-NEXT:    sw $7, 12($sp)
; MIPS2-NEXT:    sw $6, 8($sp)
; MIPS2-NEXT:    sw $5, 4($sp)
; MIPS2-NEXT:    sw $4, 0($sp)
; MIPS2-NEXT:    andi $2, $2, 12
; MIPS2-NEXT:    addiu $3, $sp, 0
; MIPS2-NEXT:    addu $4, $3, $2
; MIPS2-NEXT:    sw $zero, 28($sp)
; MIPS2-NEXT:    sw $zero, 24($sp)
; MIPS2-NEXT:    sw $zero, 20($sp)
; MIPS2-NEXT:    sw $zero, 16($sp)
; MIPS2-NEXT:    lw $5, 8($4)
; MIPS2-NEXT:    lw $2, 4($4)
; MIPS2-NEXT:    sllv $3, $2, $1
; MIPS2-NEXT:    srl $6, $5, 1
; MIPS2-NEXT:    andi $7, $1, 31
; MIPS2-NEXT:    xori $7, $7, 31
; MIPS2-NEXT:    srlv $6, $6, $7
; MIPS2-NEXT:    lw $8, 0($4)
; MIPS2-NEXT:    sllv $8, $8, $1
; MIPS2-NEXT:    srl $2, $2, 1
; MIPS2-NEXT:    srlv $2, $2, $7
; MIPS2-NEXT:    or $2, $8, $2
; MIPS2-NEXT:    or $3, $3, $6
; MIPS2-NEXT:    sllv $5, $5, $1
; MIPS2-NEXT:    lw $6, 12($4)
; MIPS2-NEXT:    srl $4, $6, 1
; MIPS2-NEXT:    srlv $4, $4, $7
; MIPS2-NEXT:    or $4, $5, $4
; MIPS2-NEXT:    sllv $5, $6, $1
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    addiu $sp, $sp, 32
;
; MIPS32-LABEL: shl_i128:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -32
; MIPS32-NEXT:    .cfi_def_cfa_offset 32
; MIPS32-NEXT:    lw $1, 60($sp)
; MIPS32-NEXT:    srl $2, $1, 3
; MIPS32-NEXT:    sw $7, 12($sp)
; MIPS32-NEXT:    sw $6, 8($sp)
; MIPS32-NEXT:    sw $5, 4($sp)
; MIPS32-NEXT:    sw $4, 0($sp)
; MIPS32-NEXT:    andi $2, $2, 12
; MIPS32-NEXT:    addiu $3, $sp, 0
; MIPS32-NEXT:    addu $4, $3, $2
; MIPS32-NEXT:    sw $zero, 28($sp)
; MIPS32-NEXT:    sw $zero, 24($sp)
; MIPS32-NEXT:    sw $zero, 20($sp)
; MIPS32-NEXT:    sw $zero, 16($sp)
; MIPS32-NEXT:    lw $5, 8($4)
; MIPS32-NEXT:    lw $2, 4($4)
; MIPS32-NEXT:    sllv $3, $2, $1
; MIPS32-NEXT:    srl $6, $5, 1
; MIPS32-NEXT:    andi $7, $1, 31
; MIPS32-NEXT:    xori $7, $7, 31
; MIPS32-NEXT:    srlv $6, $6, $7
; MIPS32-NEXT:    lw $8, 0($4)
; MIPS32-NEXT:    sllv $8, $8, $1
; MIPS32-NEXT:    srl $2, $2, 1
; MIPS32-NEXT:    srlv $2, $2, $7
; MIPS32-NEXT:    or $2, $8, $2
; MIPS32-NEXT:    or $3, $3, $6
; MIPS32-NEXT:    sllv $5, $5, $1
; MIPS32-NEXT:    lw $6, 12($4)
; MIPS32-NEXT:    srl $4, $6, 1
; MIPS32-NEXT:    srlv $4, $4, $7
; MIPS32-NEXT:    or $4, $5, $4
; MIPS32-NEXT:    sllv $5, $6, $1
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    addiu $sp, $sp, 32
;
; MIPS32R2-LABEL: shl_i128:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    addiu $sp, $sp, -32
; MIPS32R2-NEXT:    .cfi_def_cfa_offset 32
; MIPS32R2-NEXT:    lw $1, 60($sp)
; MIPS32R2-NEXT:    srl $2, $1, 3
; MIPS32R2-NEXT:    sw $7, 12($sp)
; MIPS32R2-NEXT:    sw $6, 8($sp)
; MIPS32R2-NEXT:    sw $5, 4($sp)
; MIPS32R2-NEXT:    sw $4, 0($sp)
; MIPS32R2-NEXT:    andi $2, $2, 12
; MIPS32R2-NEXT:    addiu $3, $sp, 0
; MIPS32R2-NEXT:    addu $4, $3, $2
; MIPS32R2-NEXT:    sw $zero, 28($sp)
; MIPS32R2-NEXT:    sw $zero, 24($sp)
; MIPS32R2-NEXT:    sw $zero, 20($sp)
; MIPS32R2-NEXT:    sw $zero, 16($sp)
; MIPS32R2-NEXT:    lw $5, 8($4)
; MIPS32R2-NEXT:    lw $2, 4($4)
; MIPS32R2-NEXT:    sllv $3, $2, $1
; MIPS32R2-NEXT:    srl $6, $5, 1
; MIPS32R2-NEXT:    andi $7, $1, 31
; MIPS32R2-NEXT:    xori $7, $7, 31
; MIPS32R2-NEXT:    srlv $6, $6, $7
; MIPS32R2-NEXT:    lw $8, 0($4)
; MIPS32R2-NEXT:    sllv $8, $8, $1
; MIPS32R2-NEXT:    srl $2, $2, 1
; MIPS32R2-NEXT:    srlv $2, $2, $7
; MIPS32R2-NEXT:    or $2, $8, $2
; MIPS32R2-NEXT:    or $3, $3, $6
; MIPS32R2-NEXT:    sllv $5, $5, $1
; MIPS32R2-NEXT:    lw $6, 12($4)
; MIPS32R2-NEXT:    srl $4, $6, 1
; MIPS32R2-NEXT:    srlv $4, $4, $7
; MIPS32R2-NEXT:    or $4, $5, $4
; MIPS32R2-NEXT:    sllv $5, $6, $1
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    addiu $sp, $sp, 32
;
; MIPS32R6-LABEL: shl_i128:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    addiu $sp, $sp, -32
; MIPS32R6-NEXT:    .cfi_def_cfa_offset 32
; MIPS32R6-NEXT:    lw $1, 60($sp)
; MIPS32R6-NEXT:    srl $2, $1, 3
; MIPS32R6-NEXT:    sw $7, 12($sp)
; MIPS32R6-NEXT:    sw $6, 8($sp)
; MIPS32R6-NEXT:    sw $5, 4($sp)
; MIPS32R6-NEXT:    sw $4, 0($sp)
; MIPS32R6-NEXT:    andi $2, $2, 12
; MIPS32R6-NEXT:    addiu $3, $sp, 0
; MIPS32R6-NEXT:    addu $4, $3, $2
; MIPS32R6-NEXT:    sw $zero, 28($sp)
; MIPS32R6-NEXT:    sw $zero, 24($sp)
; MIPS32R6-NEXT:    sw $zero, 20($sp)
; MIPS32R6-NEXT:    sw $zero, 16($sp)
; MIPS32R6-NEXT:    lw $5, 8($4)
; MIPS32R6-NEXT:    lw $2, 4($4)
; MIPS32R6-NEXT:    sllv $3, $2, $1
; MIPS32R6-NEXT:    srl $6, $5, 1
; MIPS32R6-NEXT:    andi $7, $1, 31
; MIPS32R6-NEXT:    xori $7, $7, 31
; MIPS32R6-NEXT:    srlv $6, $6, $7
; MIPS32R6-NEXT:    lw $8, 0($4)
; MIPS32R6-NEXT:    sllv $8, $8, $1
; MIPS32R6-NEXT:    srl $2, $2, 1
; MIPS32R6-NEXT:    srlv $2, $2, $7
; MIPS32R6-NEXT:    or $2, $8, $2
; MIPS32R6-NEXT:    or $3, $3, $6
; MIPS32R6-NEXT:    sllv $5, $5, $1
; MIPS32R6-NEXT:    lw $6, 12($4)
; MIPS32R6-NEXT:    srl $4, $6, 1
; MIPS32R6-NEXT:    srlv $4, $4, $7
; MIPS32R6-NEXT:    or $4, $5, $4
; MIPS32R6-NEXT:    sllv $5, $6, $1
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    addiu $sp, $sp, 32
;
; MIPS3-LABEL: shl_i128:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    sll $3, $7, 0
; MIPS3-NEXT:    dsllv $6, $5, $7
; MIPS3-NEXT:    andi $8, $3, 64
; MIPS3-NEXT:    beqz $8, .LBB5_3
; MIPS3-NEXT:    move $2, $6
; MIPS3-NEXT:  # %bb.1: # %entry
; MIPS3-NEXT:    beqz $8, .LBB5_4
; MIPS3-NEXT:    daddiu $3, $zero, 0
; MIPS3-NEXT:  .LBB5_2: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    nop
; MIPS3-NEXT:  .LBB5_3: # %entry
; MIPS3-NEXT:    dsllv $1, $4, $7
; MIPS3-NEXT:    dsrl $2, $5, 1
; MIPS3-NEXT:    xori $3, $3, 63
; MIPS3-NEXT:    dsrlv $2, $2, $3
; MIPS3-NEXT:    or $2, $1, $2
; MIPS3-NEXT:    bnez $8, .LBB5_2
; MIPS3-NEXT:    daddiu $3, $zero, 0
; MIPS3-NEXT:  .LBB5_4: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    move $3, $6
;
; MIPS4-LABEL: shl_i128:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    dsllv $1, $4, $7
; MIPS4-NEXT:    dsrl $2, $5, 1
; MIPS4-NEXT:    sll $4, $7, 0
; MIPS4-NEXT:    xori $3, $4, 63
; MIPS4-NEXT:    dsrlv $2, $2, $3
; MIPS4-NEXT:    or $2, $1, $2
; MIPS4-NEXT:    dsllv $3, $5, $7
; MIPS4-NEXT:    andi $1, $4, 64
; MIPS4-NEXT:    movn $2, $3, $1
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    movn $3, $zero, $1
;
; MIPS64-LABEL: shl_i128:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    dsllv $1, $4, $7
; MIPS64-NEXT:    dsrl $2, $5, 1
; MIPS64-NEXT:    sll $4, $7, 0
; MIPS64-NEXT:    xori $3, $4, 63
; MIPS64-NEXT:    dsrlv $2, $2, $3
; MIPS64-NEXT:    or $2, $1, $2
; MIPS64-NEXT:    dsllv $3, $5, $7
; MIPS64-NEXT:    andi $1, $4, 64
; MIPS64-NEXT:    movn $2, $3, $1
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    movn $3, $zero, $1
;
; MIPS64R2-LABEL: shl_i128:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    dsllv $1, $4, $7
; MIPS64R2-NEXT:    dsrl $2, $5, 1
; MIPS64R2-NEXT:    sll $4, $7, 0
; MIPS64R2-NEXT:    xori $3, $4, 63
; MIPS64R2-NEXT:    dsrlv $2, $2, $3
; MIPS64R2-NEXT:    or $2, $1, $2
; MIPS64R2-NEXT:    dsllv $3, $5, $7
; MIPS64R2-NEXT:    andi $1, $4, 64
; MIPS64R2-NEXT:    movn $2, $3, $1
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    movn $3, $zero, $1
;
; MIPS64R6-LABEL: shl_i128:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    dsllv $1, $4, $7
; MIPS64R6-NEXT:    dsrl $2, $5, 1
; MIPS64R6-NEXT:    sll $3, $7, 0
; MIPS64R6-NEXT:    xori $4, $3, 63
; MIPS64R6-NEXT:    dsrlv $2, $2, $4
; MIPS64R6-NEXT:    or $1, $1, $2
; MIPS64R6-NEXT:    andi $2, $3, 64
; MIPS64R6-NEXT:    sll $3, $2, 0
; MIPS64R6-NEXT:    seleqz $1, $1, $3
; MIPS64R6-NEXT:    dsllv $4, $5, $7
; MIPS64R6-NEXT:    selnez $2, $4, $3
; MIPS64R6-NEXT:    or $2, $2, $1
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    seleqz $3, $4, $3
;
; MMR3-LABEL: shl_i128:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    addiusp -40
; MMR3-NEXT:    .cfi_def_cfa_offset 40
; MMR3-NEXT:    swp $16, 32($sp)
; MMR3-NEXT:    .cfi_offset 17, -4
; MMR3-NEXT:    .cfi_offset 16, -8
; MMR3-NEXT:    li16 $2, 0
; MMR3-NEXT:    sw $2, 28($sp)
; MMR3-NEXT:    sw $2, 24($sp)
; MMR3-NEXT:    sw $2, 20($sp)
; MMR3-NEXT:    sw $2, 16($sp)
; MMR3-NEXT:    swp $6, 8($sp)
; MMR3-NEXT:    swp $4, 0($sp)
; MMR3-NEXT:    lw $2, 68($sp)
; MMR3-NEXT:    srl16 $3, $2, 3
; MMR3-NEXT:    andi $3, $3, 12
; MMR3-NEXT:    addiur1sp $4, 0
; MMR3-NEXT:    addu16 $4, $4, $3
; MMR3-NEXT:    lw16 $6, 8($4)
; MMR3-NEXT:    lw16 $7, 4($4)
; MMR3-NEXT:    andi16 $5, $2, 31
; MMR3-NEXT:    sllv $16, $7, $5
; MMR3-NEXT:    srl16 $2, $6, 1
; MMR3-NEXT:    xori $1, $5, 31
; MMR3-NEXT:    srlv $3, $2, $1
; MMR3-NEXT:    lw16 $2, 0($4)
; MMR3-NEXT:    sllv $17, $2, $5
; MMR3-NEXT:    srl16 $2, $7, 1
; MMR3-NEXT:    srlv $2, $2, $1
; MMR3-NEXT:    or16 $2, $17
; MMR3-NEXT:    or16 $3, $16
; MMR3-NEXT:    sllv $6, $6, $5
; MMR3-NEXT:    lw16 $7, 12($4)
; MMR3-NEXT:    srl16 $4, $7, 1
; MMR3-NEXT:    srlv $4, $4, $1
; MMR3-NEXT:    or16 $4, $6
; MMR3-NEXT:    sllv $5, $7, $5
; MMR3-NEXT:    lwp $16, 32($sp)
; MMR3-NEXT:    addiusp 40
; MMR3-NEXT:    jrc $ra
;
; MMR6-LABEL: shl_i128:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    addiu $sp, $sp, -32
; MMR6-NEXT:    .cfi_def_cfa_offset 32
; MMR6-NEXT:    li16 $2, 0
; MMR6-NEXT:    sw $2, 28($sp)
; MMR6-NEXT:    sw $2, 24($sp)
; MMR6-NEXT:    sw $2, 20($sp)
; MMR6-NEXT:    sw $2, 16($sp)
; MMR6-NEXT:    sw $7, 12($sp)
; MMR6-NEXT:    sw $6, 8($sp)
; MMR6-NEXT:    sw $5, 4($sp)
; MMR6-NEXT:    sw $4, 0($sp)
; MMR6-NEXT:    lw $2, 60($sp)
; MMR6-NEXT:    srl16 $3, $2, 3
; MMR6-NEXT:    andi $3, $3, 12
; MMR6-NEXT:    addiu $4, $sp, 0
; MMR6-NEXT:    addu16 $4, $4, $3
; MMR6-NEXT:    lw16 $5, 8($4)
; MMR6-NEXT:    lw16 $3, 4($4)
; MMR6-NEXT:    andi16 $6, $2, 31
; MMR6-NEXT:    sllv $1, $3, $6
; MMR6-NEXT:    srl16 $2, $5, 1
; MMR6-NEXT:    xori $7, $6, 31
; MMR6-NEXT:    srlv $8, $2, $7
; MMR6-NEXT:    lw16 $2, 0($4)
; MMR6-NEXT:    sllv $2, $2, $6
; MMR6-NEXT:    srl16 $3, $3, 1
; MMR6-NEXT:    srlv $3, $3, $7
; MMR6-NEXT:    or $2, $2, $3
; MMR6-NEXT:    or $3, $1, $8
; MMR6-NEXT:    sllv $1, $5, $6
; MMR6-NEXT:    lw16 $5, 12($4)
; MMR6-NEXT:    srl16 $4, $5, 1
; MMR6-NEXT:    srlv $4, $4, $7
; MMR6-NEXT:    or $4, $1, $4
; MMR6-NEXT:    sllv $5, $5, $6
; MMR6-NEXT:    addiu $sp, $sp, 32
; MMR6-NEXT:    jrc $ra
entry:

; o32 shouldn't use TImode helpers.
; GP32-NOT:       lw        $25, %call16(__ashlti3)($gp)
; MM-NOT:         lw        $25, %call16(__ashlti3)($2)

  %r = shl i128 %a, %b
  ret i128 %r
}

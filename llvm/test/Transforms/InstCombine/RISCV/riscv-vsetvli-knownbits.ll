; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i32 @llvm.riscv.vsetvli.i32(i32, i32, i32)
declare i64 @llvm.riscv.vsetvli.i64(i64, i64, i64)

define i32 @vsetvli_i32() nounwind #0 {
; CHECK-LABEL: @vsetvli_i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.riscv.vsetvli.i32(i32 1, i32 1, i32 1)
; CHECK-NEXT:    ret i32 [[TMP0]]
;
entry:
  %0 = call i32 @llvm.riscv.vsetvli.i32(i32 1, i32 1, i32 1)
  %1 = and i32 %0, 2147483647
  ret i32 %1
}

define i64 @vsetvli_sext_i64() nounwind #0 {
; CHECK-LABEL: @vsetvli_sext_i64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  %0 = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
  %1 = trunc i64 %0 to i32
  %2 = sext i32 %1 to i64
  ret i64 %2
}

define i64 @vsetvli_zext_i64() nounwind #0 {
; CHECK-LABEL: @vsetvli_zext_i64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  %0 = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
  %1 = trunc i64 %0 to i32
  %2 = zext i32 %1 to i64
  ret i64 %2
}

define signext i32 @vsetvl_sext() nounwind #0 {
; CHECK-LABEL: @vsetvl_sext(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
; CHECK-NEXT:    [[B:%.*]] = trunc nuw nsw i64 [[A]] to i32
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 1, i64 1, i64 1)
  %b = trunc i64 %a to i32
  ret i32 %b
}

define zeroext i32 @vsetvl_zext() nounwind #0 {
; CHECK-LABEL: @vsetvl_zext(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
; CHECK-NEXT:    [[B:%.*]] = trunc nuw nsw i64 [[A]] to i32
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 1, i64 1, i64 1)
  %b = trunc i64 %a to i32
  ret i32 %b
}

define i32 @vsetvli_and17_i32() nounwind #0 {
; CHECK-LABEL: @vsetvli_and17_i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.riscv.vsetvli.i32(i32 1, i32 1, i32 1)
; CHECK-NEXT:    ret i32 [[TMP0]]
;
entry:
  %0 = call i32 @llvm.riscv.vsetvli.i32(i32 1, i32 1, i32 1)
  %1 = and i32 %0, 131071
  ret i32 %1
}

define i64 @vsetvli_and17_i64() nounwind #0 {
; CHECK-LABEL: @vsetvli_and17_i64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  %0 = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 1, i64 1)
  %1 = and i64 %0, 131071
  ret i64 %1
}

define i64 @vsetvl_e8m1_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m1_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 0)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 0)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e8m1_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m1_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 0)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 8191
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e8m1_constant_avl() nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m1_constant_avl(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 1, i64 0, i64 0)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 1, i64 0, i64 0)
  %b = and i64 %a, 1
  ret i64 %b
}

define i64 @vsetvl_e8m2_and15bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m2_and15bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 1)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 1)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvl_e8m2_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m2_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 1)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 16383
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e8m4_and16bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m4_and16bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 2)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 2)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvl_e8m4_and15bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m4_and15bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 2)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 32767
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvl_e8m8_and17bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m8_and17bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 3)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 3)
  %b = and i64 %a, 131071
  ret i64 %b
}

define i64 @vsetvl_e8m8_and16bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8m8_and16bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 3)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 65535
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvl_e8mf2_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8mf2_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 5)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 5)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e8mf2_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8mf2_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 5)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 1023
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e8mf4_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8mf4_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 6)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 6)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e8mf4_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8mf4_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 6)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 2047
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e8mf8_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8mf8_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 7)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 7)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e8mf8_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e8mf8_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 0, i64 7)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 4095
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 0, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e16m1_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m1_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 0)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e16m1_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m1_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 0)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 4095
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e16m2_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m2_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 1)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e16m2_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m2_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 1)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 8191
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e16m4_and15bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m4_and15bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 2)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvl_e16m4_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m4_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 2)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 16383
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e16m8_and16bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m8_and16bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 3)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvl_e16m8_and15bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16m8_and15bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 3)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 32767
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvl_e16mf2_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16mf2_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 5)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e16mf2_and9bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16mf2_and9bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 5)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 511
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvl_e16mf4_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16mf4_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 6)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e16mf4_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16mf4_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 6)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 1023
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e16mf8_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16mf8_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 7)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e16mf8_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e16mf8_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 1, i64 7)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 2047
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 1, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e32m1_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m1_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 0)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e32m1_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m1_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 0)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 2047
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e32m2_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m2_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 1)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e32m2_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m2_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 1)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 4095
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e32m4_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m4_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 2)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e32m4_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m4_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 2)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 8191
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e32m8_and15bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m8_and15bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 3)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvl_e32m8_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32m8_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 3)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 16383
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e32mf2_and9bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32mf2_and9bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 5)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvl_e32mf2_and8bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32mf2_and8bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 5)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 255
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvl_e32mf4_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32mf4_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 6)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e32mf4_and9bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32mf4_and9bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 6)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 511
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvl_e32mf8_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32mf8_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 7)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e32mf8_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e32mf8_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 2, i64 7)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 1023
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 2, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e64m1_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m1_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 0)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e64m1_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m1_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 0)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 1023
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 0)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e64m2_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m2_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 1)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e64m2_and11bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m2_and11bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 1)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 2047
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 1)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvl_e64m4_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m4_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 2)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e64m4_and12bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m4_and12bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 2)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 4095
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 2)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvl_e64m8_and14bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m8_and14bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 3)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvl_e64m8_and13bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64m8_and13bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 3)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 8191
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 3)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvl_e64mf2_and8bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64mf2_and8bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 5)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvl_e64mf2_and7bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64mf2_and7bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 5)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 127
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 5)
  %b = and i64 %a, 127
  ret i64 %b
}

define i64 @vsetvl_e64mf4_and9bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64mf4_and9bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 6)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvl_e64mf4_and8bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64mf4_and8bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 6)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 255
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 6)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvl_e64mf8_and10bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64mf8_and10bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 7)
; CHECK-NEXT:    ret i64 [[A]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvl_e64mf8_and9bits(i64 %avl) nounwind #0 {
; CHECK-LABEL: @vsetvl_e64mf8_and9bits(
; CHECK-NEXT:    [[A:%.*]] = call i64 @llvm.riscv.vsetvli.i64(i64 [[AVL:%.*]], i64 3, i64 7)
; CHECK-NEXT:    [[B:%.*]] = and i64 [[A]], 511
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = call i64 @llvm.riscv.vsetvli(i64 %avl, i64 3, i64 7)
  %b = and i64 %a, 511
  ret i64 %b
}

attributes #0 = { vscale_range(2,1024) }

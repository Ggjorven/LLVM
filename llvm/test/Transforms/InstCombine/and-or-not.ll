; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i4)

; PR1510

; (a | b) & ~(a & b) --> a ^ b

define i32 @and_to_xor1(i32 %a, i32 %b) {
; CHECK-LABEL: @and_to_xor1(
; CHECK-NEXT:    [[AND2:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[AND2]]
;
  %or = or i32 %a, %b
  %and = and i32 %a, %b
  %not = xor i32 %and, -1
  %and2 = and i32 %or, %not
  ret i32 %and2
}

; ~(a & b) & (a | b) --> a ^ b

define i32 @and_to_xor2(i32 %a, i32 %b) {
; CHECK-LABEL: @and_to_xor2(
; CHECK-NEXT:    [[AND2:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[AND2]]
;
  %or = or i32 %a, %b
  %and = and i32 %a, %b
  %not = xor i32 %and, -1
  %and2 = and i32 %not, %or
  ret i32 %and2
}

; (a | b) & ~(b & a) --> a ^ b

define i32 @and_to_xor3(i32 %a, i32 %b) {
; CHECK-LABEL: @and_to_xor3(
; CHECK-NEXT:    [[AND2:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[AND2]]
;
  %or = or i32 %a, %b
  %and = and i32 %b, %a
  %not = xor i32 %and, -1
  %and2 = and i32 %or, %not
  ret i32 %and2
}

; ~(a & b) & (b | a) --> a ^ b

define i32 @and_to_xor4(i32 %a, i32 %b) {
; CHECK-LABEL: @and_to_xor4(
; CHECK-NEXT:    [[AND2:%.*]] = xor i32 [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    ret i32 [[AND2]]
;
  %or = or i32 %b, %a
  %and = and i32 %a, %b
  %not = xor i32 %and, -1
  %and2 = and i32 %not, %or
  ret i32 %and2
}

define <4 x i32> @and_to_xor1_vec(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @and_to_xor1_vec(
; CHECK-NEXT:    [[AND2:%.*]] = xor <4 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[AND2]]
;
  %or = or <4 x i32> %a, %b
  %and = and <4 x i32> %a, %b
  %not = xor <4 x i32> %and, < i32 -1, i32 -1, i32 -1, i32 -1 >
  %and2 = and <4 x i32> %or, %not
  ret <4 x i32> %and2
}

; In the next 4 tests, cast instructions are used to thwart operand complexity
; canonicalizations, so we can test all of the commuted patterns.

; (a | ~b) & (~a | b) --> ~(a ^ b)

define i32 @and_to_nxor1(float %fa, float %fb) {
; CHECK-LABEL: @and_to_nxor1(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    [[AND:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[AND]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %notb
  %or2 = or i32 %nota, %b
  %and = and i32 %or1, %or2
  ret i32 %and
}

; (a | ~b) & (b | ~a) --> ~(a ^ b)

define i32 @and_to_nxor2(float %fa, float %fb) {
; CHECK-LABEL: @and_to_nxor2(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    [[AND:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[AND]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %notb
  %or2 = or i32 %b, %nota
  %and = and i32 %or1, %or2
  ret i32 %and
}

; (~a | b) & (a | ~b) --> ~(a ^ b)

define i32 @and_to_nxor3(float %fa, float %fb) {
; CHECK-LABEL: @and_to_nxor3(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    [[AND:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[AND]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %nota, %b
  %or2 = or i32 %a, %notb
  %and = and i32 %or1, %or2
  ret i32 %and
}

; (~a | b) & (~b | a) --> ~(a ^ b)

define i32 @and_to_nxor4(float %fa, float %fb) {
; CHECK-LABEL: @and_to_nxor4(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    [[AND:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[AND]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %nota, %b
  %or2 = or i32 %notb, %a
  %and = and i32 %or1, %or2
  ret i32 %and
}

; (a & ~b) | (~a & b) --> a ^ b

define i32 @or_to_xor1(float %fa, float %fb) {
; CHECK-LABEL: @or_to_xor1(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %a, %notb
  %and2 = and i32 %nota, %b
  %or = or i32 %and1, %and2
  ret i32 %or
}

; (a & ~b) | (b & ~a) --> a ^ b

define i32 @or_to_xor2(float %fa, float %fb) {
; CHECK-LABEL: @or_to_xor2(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %a, %notb
  %and2 = and i32 %b, %nota
  %or = or i32 %and1, %and2
  ret i32 %or
}

; (~a & b) | (~b & a) --> a ^ b

define i32 @or_to_xor3(float %fa, float %fb) {
; CHECK-LABEL: @or_to_xor3(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %nota, %b
  %and2 = and i32 %notb, %a
  %or = or i32 %and1, %and2
  ret i32 %or
}

; (~a & b) | (a & ~b) --> a ^ b

define i32 @or_to_xor4(float %fa, float %fb) {
; CHECK-LABEL: @or_to_xor4(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %nota, %b
  %and2 = and i32 %a, %notb
  %or = or i32 %and1, %and2
  ret i32 %or
}

; (a & b) | ~(a | b) --> ~(a ^ b)

define i32 @or_to_nxor1(i32 %a, i32 %b) {
; CHECK-LABEL: @or_to_nxor1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[OR2:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[OR2]]
;
  %and = and i32 %a, %b
  %or = or i32 %a, %b
  %notor = xor i32 %or, -1
  %or2 = or i32 %and, %notor
  ret i32 %or2
}

; (a & b) | ~(b | a) --> ~(a ^ b)

define i32 @or_to_nxor2(i32 %a, i32 %b) {
; CHECK-LABEL: @or_to_nxor2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[OR2:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[OR2]]
;
  %and = and i32 %a, %b
  %or = or i32 %b, %a
  %notor = xor i32 %or, -1
  %or2 = or i32 %and, %notor
  ret i32 %or2
}

; ~(a | b) | (a & b) --> ~(a ^ b)

define i32 @or_to_nxor3(i32 %a, i32 %b) {
; CHECK-LABEL: @or_to_nxor3(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[OR2:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[OR2]]
;
  %and = and i32 %a, %b
  %or = or i32 %a, %b
  %notor = xor i32 %or, -1
  %or2 = or i32 %notor, %and
  ret i32 %or2
}

; ~(a | b) | (b & a) --> ~(a ^ b)

define i32 @or_to_nxor4(i32 %a, i32 %b) {
; CHECK-LABEL: @or_to_nxor4(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    [[OR2:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[OR2]]
;
  %and = and i32 %b, %a
  %or = or i32 %a, %b
  %notor = xor i32 %or, -1
  %or2 = or i32 %notor, %and
  ret i32 %or2
}

; (a & b) ^ (a | b) --> a ^ b

define i32 @xor_to_xor1(i32 %a, i32 %b) {
; CHECK-LABEL: @xor_to_xor1(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %and = and i32 %a, %b
  %or = or i32 %a, %b
  %xor = xor i32 %and, %or
  ret i32 %xor
}

; (a & b) ^ (b | a) --> a ^ b

define i32 @xor_to_xor2(i32 %a, i32 %b) {
; CHECK-LABEL: @xor_to_xor2(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %and = and i32 %a, %b
  %or = or i32 %b, %a
  %xor = xor i32 %and, %or
  ret i32 %xor
}

; (a | b) ^ (a & b) --> a ^ b

define i32 @xor_to_xor3(i32 %a, i32 %b) {
; CHECK-LABEL: @xor_to_xor3(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %or = or i32 %a, %b
  %and = and i32 %a, %b
  %xor = xor i32 %or, %and
  ret i32 %xor
}

; (a | b) ^ (b & a) --> a ^ b

define i32 @xor_to_xor4(i32 %a, i32 %b) {
; CHECK-LABEL: @xor_to_xor4(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %or = or i32 %a, %b
  %and = and i32 %b, %a
  %xor = xor i32 %or, %and
  ret i32 %xor
}

; (a | ~b) ^ (~a | b) --> a ^ b

; In the next 8 tests, cast instructions are used to thwart operand complexity
; canonicalizations, so we can test all of the commuted patterns.

define i32 @xor_to_xor5(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor5(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %notb
  %or2 = or i32 %nota, %b
  %xor = xor i32 %or1, %or2
  ret i32 %xor
}

; (a | ~b) ^ (b | ~a) --> a ^ b

define i32 @xor_to_xor6(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor6(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %notb
  %or2 = or i32 %b, %nota
  %xor = xor i32 %or1, %or2
  ret i32 %xor
}

; (~a | b) ^ (a | ~b) --> a ^ b

define i32 @xor_to_xor7(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor7(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %notb
  %or2 = or i32 %nota, %b
  %xor = xor i32 %or2, %or1
  ret i32 %xor
}

; (~a | b) ^ (~b | a) --> a ^ b

define i32 @xor_to_xor8(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor8(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %notb, %a
  %or2 = or i32 %nota, %b
  %xor = xor i32 %or2, %or1
  ret i32 %xor
}

; (a & ~b) ^ (~a & b) --> a ^ b

define i32 @xor_to_xor9(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor9(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %a, %notb
  %and2 = and i32 %nota, %b
  %xor = xor i32 %and1, %and2
  ret i32 %xor
}

; (a & ~b) ^ (b & ~a) --> a ^ b

define i32 @xor_to_xor10(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor10(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %a, %notb
  %and2 = and i32 %b, %nota
  %xor = xor i32 %and1, %and2
  ret i32 %xor
}

; (~a & b) ^ (a & ~b) --> a ^ b

define i32 @xor_to_xor11(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor11(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %a, %notb
  %and2 = and i32 %nota, %b
  %xor = xor i32 %and2, %and1
  ret i32 %xor
}

; (~a & b) ^ (~b & a) --> a ^ b

define i32 @xor_to_xor12(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xor12(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %and1 = and i32 %notb, %a
  %and2 = and i32 %nota, %b
  %xor = xor i32 %and2, %and1
  ret i32 %xor
}

; https://bugs.llvm.org/show_bug.cgi?id=32830
; Make sure we're matching operands correctly and not folding things wrongly.

define i64 @PR32830(i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: @PR32830(
; CHECK-NEXT:    [[NOTA:%.*]] = xor i64 [[A:%.*]], -1
; CHECK-NEXT:    [[NOTB:%.*]] = xor i64 [[B:%.*]], -1
; CHECK-NEXT:    [[OR1:%.*]] = or i64 [[A]], [[NOTB]]
; CHECK-NEXT:    [[OR2:%.*]] = or i64 [[C:%.*]], [[NOTA]]
; CHECK-NEXT:    [[AND:%.*]] = and i64 [[OR1]], [[OR2]]
; CHECK-NEXT:    ret i64 [[AND]]
;
  %nota = xor i64 %a, -1
  %notb = xor i64 %b, -1
  %or1 = or i64 %notb, %a
  %or2 = or i64 %nota, %c
  %and = and i64 %or1, %or2
  ret i64 %and
}

; (~a | b) & (~b | a) --> ~(a ^ b)
; TODO: this increases instruction count if the pieces have additional users
define i32 @and_to_nxor_multiuse(float %fa, float %fb) {
; CHECK-LABEL: @and_to_nxor_multiuse(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[NOTA:%.*]] = xor i32 [[A]], -1
; CHECK-NEXT:    [[NOTB:%.*]] = xor i32 [[B]], -1
; CHECK-NEXT:    [[OR1:%.*]] = or i32 [[NOTA]], [[B]]
; CHECK-NEXT:    [[OR2:%.*]] = or i32 [[NOTB]], [[A]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[OR1]], [[OR2]]
; CHECK-NEXT:    [[MUL1:%.*]] = mul i32 [[OR1]], [[OR2]]
; CHECK-NEXT:    [[MUL2:%.*]] = mul i32 [[MUL1]], [[AND]]
; CHECK-NEXT:    ret i32 [[MUL2]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %nota, %b
  %or2 = or i32 %notb, %a
  %and = and i32 %or1, %or2
  %mul1 = mul i32 %or1, %or2 ; here to increase the use count of the inputs to the and
  %mul2 = mul i32 %mul1, %and
  ret i32 %mul2
}

; (a & b) | ~(a | b) --> ~(a ^ b)
; TODO: this increases instruction count if the pieces have additional users
define i32 @or_to_nxor_multiuse(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: @or_to_nxor_multiuse(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[A]], [[B]]
; CHECK-NEXT:    [[NOTOR:%.*]] = xor i32 [[OR]], -1
; CHECK-NEXT:    [[OR2:%.*]] = or disjoint i32 [[AND]], [[NOTOR]]
; CHECK-NEXT:    [[MUL1:%.*]] = mul i32 [[AND]], [[NOTOR]]
; CHECK-NEXT:    [[MUL2:%.*]] = mul i32 [[MUL1]], [[OR2]]
; CHECK-NEXT:    ret i32 [[MUL2]]
;
  %and = and i32 %a, %b
  %or = or i32 %a, %b
  %notor = xor i32 %or, -1
  %or2 = or i32 %and, %notor
  %mul1 = mul i32 %and, %notor ; here to increase the use count of the inputs to the or
  %mul2 = mul i32 %mul1, %or2
  ret i32 %mul2
}

; (a | b) ^ (~a | ~b) --> ~(a ^ b)
define i32 @xor_to_xnor1(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xnor1(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %b
  %or2 = or i32 %nota, %notb
  %xor = xor i32 %or1, %or2
  ret i32 %xor
}

; (a | b) ^ (~b | ~a) --> ~(a ^ b)
define i32 @xor_to_xnor2(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xnor2(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %a, %b
  %or2 = or i32 %notb, %nota
  %xor = xor i32 %or1, %or2
  ret i32 %xor
}

; (~a | ~b) ^ (a | b) --> ~(a ^ b)
define i32 @xor_to_xnor3(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xnor3(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[A]], [[B]]
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %nota, %notb
  %or2 = or i32 %a, %b
  %xor = xor i32 %or1, %or2
  ret i32 %xor
}

; (~a | ~b) ^ (b | a) --> ~(a ^ b)
define i32 @xor_to_xnor4(float %fa, float %fb) {
; CHECK-LABEL: @xor_to_xnor4(
; CHECK-NEXT:    [[A:%.*]] = fptosi float [[FA:%.*]] to i32
; CHECK-NEXT:    [[B:%.*]] = fptosi float [[FB:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[B]], [[A]]
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    ret i32 [[XOR]]
;
  %a = fptosi float %fa to i32
  %b = fptosi float %fb to i32
  %nota = xor i32 %a, -1
  %notb = xor i32 %b, -1
  %or1 = or i32 %nota, %notb
  %or2 = or i32 %b, %a
  %xor = xor i32 %or1, %or2
  ret i32 %xor
}

define i4 @simplify_or_common_op_commute0(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_or_common_op_commute0(
; CHECK-NEXT:    ret i4 -1
;
  %xy = and i4 %x, %y
  %xyz = and i4 %xy, %z
  %not_xyz = xor i4 %xyz, -1
  %r = or i4 %not_xyz, %x
  ret i4 %r
}

define i4 @simplify_or_common_op_commute1(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_or_common_op_commute1(
; CHECK-NEXT:    ret i4 -1
;
  %xy = and i4 %y, %x
  %xyz = and i4 %xy, %z
  %not_xyz = xor i4 %xyz, -1
  %r = or i4 %not_xyz, %x
  ret i4 %r
}

; The common operand may bubble through multiple instructions.

define i4 @simplify_or_common_op_commute2(i4 %x, i4 %y, i4 %p, i4 %q)  {
; CHECK-LABEL: @simplify_or_common_op_commute2(
; CHECK-NEXT:    ret i4 -1
;
  %z = mul i4 %p, %p ; thwart complexity-based canonicalization
  %xy = and i4 %x, %y
  %xyz = and i4 %z, %xy
  %xyzq = and i4 %xyz, %q
  %not_xyzq = xor i4 %xyzq, -1
  %r = or i4 %not_xyzq, %x
  ret i4 %r
}

define <2 x i4> @simplify_or_common_op_commute3(<2 x i4> %x, <2 x i4> %y, <2 x i4> %p)  {
; CHECK-LABEL: @simplify_or_common_op_commute3(
; CHECK-NEXT:    ret <2 x i4> <i4 -1, i4 -1>
;
  %z = mul <2 x i4> %p, %p ; thwart complexity-based canonicalization
  %xy = and <2 x i4> %y, %x
  %xyz = and <2 x i4> %z, %xy
  %not_xyz = xor <2 x i4> %xyz, <i4 -1, i4 -1>
  %r = or <2 x i4> %x, %not_xyz
  ret <2 x i4> %r
}

define i4 @simplify_and_common_op_commute0(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_and_common_op_commute0(
; CHECK-NEXT:    call void @use(i4 [[X:%.*]])
; CHECK-NEXT:    ret i4 0
;
  %xy = or i4 %x, %y
  call void @use(i4 %x)
  %xyz = or i4 %xy, %z
  %not_xyz = xor i4 %xyz, -1
  %r = and i4 %not_xyz, %x
  ret i4 %r
}

define i4 @simplify_and_common_op_commute1(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_and_common_op_commute1(
; CHECK-NEXT:    ret i4 0
;
  %xy = or i4 %y, %x
  %xyz = or i4 %xy, %z
  %not_xyz = xor i4 %xyz, -1
  %r = and i4 %not_xyz, %x
  ret i4 %r
}

; The common operand may bubble through multiple instructions.

define i4 @simplify_and_common_op_commute2(i4 %x, i4 %y, i4 %p, i4 %q)  {
; CHECK-LABEL: @simplify_and_common_op_commute2(
; CHECK-NEXT:    ret i4 0
;
  %z = mul i4 %p, %p ; thwart complexity-based canonicalization
  %xy = or i4 %x, %y
  %xyz = or i4 %z, %xy
  %xyzq = or i4 %xyz, %q
  %not_xyzq = xor i4 %xyzq, -1
  %r = and i4 %not_xyzq, %x
  ret i4 %r
}

define <2 x i4> @simplify_and_common_op_commute3(<2 x i4> %x, <2 x i4> %y, <2 x i4> %p)  {
; CHECK-LABEL: @simplify_and_common_op_commute3(
; CHECK-NEXT:    ret <2 x i4> zeroinitializer
;
  %z = mul <2 x i4> %p, %p ; thwart complexity-based canonicalization
  %xy = or <2 x i4> %y, %x
  %xyz = or <2 x i4> %z, %xy
  %not_xyz = xor <2 x i4> %xyz, <i4 -1, i4 -1>
  %r = and <2 x i4> %x, %not_xyz
  ret <2 x i4> %r
}

define i4 @simplify_and_common_op_use1(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_and_common_op_use1(
; CHECK-NEXT:    call void @use(i4 [[Y:%.*]])
; CHECK-NEXT:    ret i4 0
;
  %xy = or i4 %x, %y
  call void @use(i4 %y)
  %xyz = or i4 %xy, %z
  %not_xyz = xor i4 %xyz, -1
  %r = and i4 %not_xyz, %x
  ret i4 %r
}

; TODO: This should simplify.

define i4 @simplify_and_common_op_use2(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_and_common_op_use2(
; CHECK-NEXT:    call void @use(i4 [[Y:%.*]])
; CHECK-NEXT:    ret i4 0
;
  %xy = or i4 %y, %x
  call void @use(i4 %y)
  %xyz = or i4 %xy, %z
  %not_xyz = xor i4 %xyz, -1
  %r = and i4 %not_xyz, %x
  ret i4 %r
}

; TODO: This should simplify.

define i4 @simplify_and_common_op_use3(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @simplify_and_common_op_use3(
; CHECK-NEXT:    call void @use(i4 [[Z:%.*]])
; CHECK-NEXT:    ret i4 0
;
  %xy = or i4 %x, %y
  %xyz = or i4 %xy, %z
  call void @use(i4 %z)
  %not_xyz = xor i4 %xyz, -1
  %r = and i4 %not_xyz, %x
  ret i4 %r
}

define i4 @reduce_xor_common_op_commute0(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @reduce_xor_common_op_commute0(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i4 [[Y:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[R:%.*]] = or i4 [[TMP1]], [[X:%.*]]
; CHECK-NEXT:    ret i4 [[R]]
;
  %xy = xor i4 %x, %y
  %xyz = xor i4 %xy, %z
  %r = or i4 %xyz, %x
  ret i4 %r
}

define i4 @reduce_xor_common_op_commute1(i4 %x, i4 %y, i4 %z)  {
; CHECK-LABEL: @reduce_xor_common_op_commute1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i4 [[Y:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[R:%.*]] = or i4 [[TMP1]], [[X:%.*]]
; CHECK-NEXT:    ret i4 [[R]]
;
  %xy = xor i4 %y, %x
  %xyz = xor i4 %xy, %z
  %r = or i4 %xyz, %x
  ret i4 %r
}

define i4 @annihilate_xor_common_op_commute2(i4 %x, i4 %y, i4 %p, i4 %q)  {
; CHECK-LABEL: @annihilate_xor_common_op_commute2(
; CHECK-NEXT:    [[Z:%.*]] = mul i4 [[P:%.*]], [[P]]
; CHECK-NEXT:    [[TMP1:%.*]] = xor i4 [[Y:%.*]], [[Z]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i4 [[TMP1]], [[Q:%.*]]
; CHECK-NEXT:    ret i4 [[TMP2]]
;
  %z = mul i4 %p, %p ; thwart complexity-based canonicalization
  %xy = xor i4 %x, %y
  %xyz = xor i4 %z, %xy
  %xyzq = xor i4 %xyz, %q
  %r = xor i4 %xyzq, %x
  ret i4 %r
}

define <2 x i4> @reduce_xor_common_op_commute3(<2 x i4> %x, <2 x i4> %y, <2 x i4> %p)  {
; CHECK-LABEL: @reduce_xor_common_op_commute3(
; CHECK-NEXT:    [[Z:%.*]] = mul <2 x i4> [[P:%.*]], [[P]]
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i4> [[Y:%.*]], [[Z]]
; CHECK-NEXT:    [[R:%.*]] = or <2 x i4> [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i4> [[R]]
;
  %z = mul <2 x i4> %p, %p ; thwart complexity-based canonicalization
  %xy = xor <2 x i4> %y, %x
  %xyz = xor <2 x i4> %z, %xy
  %r = or <2 x i4> %x, %xyz
  ret <2 x i4> %r
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx  | FileCheck %s -check-prefix=CHECK -check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s -check-prefix=CHECK -check-prefix=AVX2

;
; testz(~X,Y) -> testc(X,Y)
;

define i32 @testpsz_128_invert0(<4 x float> %c, <4 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsz_128_invert0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %xmm1, %xmm0
; CHECK-NEXT:    cmovael %esi, %eax
; CHECK-NEXT:    retq
  %t0 = bitcast <4 x float> %c to <2 x i64>
  %t1 = xor <2 x i64> %t0, <i64 -1, i64 -1>
  %t2 = bitcast <2 x i64> %t1 to <4 x float>
  %t3 = call i32 @llvm.x86.avx.vtestz.ps(<4 x float> %t2, <4 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i32 @testpsz_256_invert0(<8 x float> %c, <8 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsz_256_invert0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %ymm1, %ymm0
; CHECK-NEXT:    cmovael %esi, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = bitcast <8 x float> %c to <4 x i64>
  %t1 = xor <4 x i64> %t0, <i64 -1, i64 -1, i64 -1, i64 -1>
  %t2 = bitcast <4 x i64> %t1 to <8 x float>
  %t3 = call i32 @llvm.x86.avx.vtestz.ps.256(<8 x float> %t2, <8 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

;
; testz(X,~Y) -> testc(Y,X)
;

define i32 @testpsz_128_invert1(<4 x float> %c, <4 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsz_128_invert1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %xmm0, %xmm1
; CHECK-NEXT:    cmovael %esi, %eax
; CHECK-NEXT:    retq
  %t0 = bitcast <4 x float> %d to <2 x i64>
  %t1 = xor <2 x i64> %t0, <i64 -1, i64 -1>
  %t2 = bitcast <2 x i64> %t1 to <4 x float>
  %t3 = call i32 @llvm.x86.avx.vtestz.ps(<4 x float> %c, <4 x float> %t2)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i32 @testpsz_256_invert1(<8 x float> %c, <8 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsz_256_invert1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %ymm0, %ymm1
; CHECK-NEXT:    cmovael %esi, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = bitcast <8 x float> %d to <4 x i64>
  %t1 = xor <4 x i64> %t0, <i64 -1, i64 -1, i64 -1, i64 -1>
  %t2 = bitcast <4 x i64> %t1 to <8 x float>
  %t3 = call i32 @llvm.x86.avx.vtestz.ps.256(<8 x float> %c, <8 x float> %t2)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

;
; testc(~X,Y) -> testz(X,Y)
;

define i32 @testpsc_128_invert0(<4 x float> %c, <4 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsc_128_invert0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %xmm1, %xmm0
; CHECK-NEXT:    cmovnel %esi, %eax
; CHECK-NEXT:    retq
  %t0 = bitcast <4 x float> %c to <2 x i64>
  %t1 = xor <2 x i64> %t0, <i64 -1, i64 -1>
  %t2 = bitcast <2 x i64> %t1 to <4 x float>
  %t3 = call i32 @llvm.x86.avx.vtestc.ps(<4 x float> %t2, <4 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i32 @testpsc_256_invert0(<8 x float> %c, <8 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsc_256_invert0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %ymm1, %ymm0
; CHECK-NEXT:    cmovnel %esi, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = bitcast <8 x float> %c to <4 x i64>
  %t1 = xor <4 x i64> %t0, <i64 -1, i64 -1, i64 -1, i64 -1>
  %t2 = bitcast <4 x i64> %t1 to <8 x float>
  %t3 = call i32 @llvm.x86.avx.vtestc.ps.256(<8 x float> %t2, <8 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

;
; testnzc(~X,Y) -> testnzc(X,Y)
;

define i32 @testpsnzc_128_invert0(<4 x float> %c, <4 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsnzc_128_invert0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %xmm1, %xmm0
; CHECK-NEXT:    cmovbel %esi, %eax
; CHECK-NEXT:    retq
  %t0 = bitcast <4 x float> %c to <2 x i64>
  %t1 = xor <2 x i64> %t0, <i64 -1, i64 -1>
  %t2 = bitcast <2 x i64> %t1 to <4 x float>
  %t3 = call i32 @llvm.x86.avx.vtestnzc.ps(<4 x float> %t2, <4 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i32 @testpsnzc_256_invert0(<8 x float> %c, <8 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsnzc_256_invert0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %ymm1, %ymm0
; CHECK-NEXT:    cmovbel %esi, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = bitcast <8 x float> %c to <4 x i64>
  %t1 = xor <4 x i64> %t0, <i64 -1, i64 -1, i64 -1, i64 -1>
  %t2 = bitcast <4 x i64> %t1 to <8 x float>
  %t3 = call i32 @llvm.x86.avx.vtestnzc.ps.256(<8 x float> %t2, <8 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

;
; SimplifyDemandedBits - only the sign bit is required
;

define i32 @testpsz_128_signbit(<4 x float> %c, <4 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsz_128_signbit:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %xmm1, %xmm0
; CHECK-NEXT:    cmovnel %esi, %eax
; CHECK-NEXT:    retq
  %t0 = bitcast <4 x float> %c to <4 x i32>
  %t1 = ashr <4 x i32> %t0, <i32 31, i32 31, i32 31, i32 31>
  %t2 = bitcast <4 x i32> %t1 to <4 x float>
  %t3 = call i32 @llvm.x86.avx.vtestz.ps(<4 x float> %t2, <4 x float> %d)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i32 @testpsnzc_256_signbit(<8 x float> %c, <8 x float> %d, i32 %a, i32 %b) {
; CHECK-LABEL: testpsnzc_256_signbit:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %ymm1, %ymm0
; CHECK-NEXT:    cmovnel %esi, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = bitcast <8 x float> %c to <8 x i32>
  %t1 = icmp sgt <8 x i32> zeroinitializer, %t0
  %t2 = sext <8 x i1> %t1 to <8 x i32>
  %t3 = bitcast <8 x i32> %t2 to <8 x float>
  %t4 = call i32 @llvm.x86.avx.vtestz.ps.256(<8 x float> %t3, <8 x float> %d)
  %t5 = icmp ne i32 %t4, 0
  %t6 = select i1 %t5, i32 %a, i32 %b
  ret i32 %t6
}

define i32 @testpsc_256_signbit_multiuse(<8 x float> %c, i32 %a, i32 %b) {
; CHECK-LABEL: testpsc_256_signbit_multiuse:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    vtestps %ymm0, %ymm0
; CHECK-NEXT:    cmovnel %esi, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %t0 = bitcast <8 x float> %c to <8 x i32>
  %t1 = ashr <8 x i32> %t0, <i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31>
  %t2 = bitcast <8 x i32> %t1 to <8 x float>
  %t3 = call i32 @llvm.x86.avx.vtestz.ps.256(<8 x float> %t2, <8 x float> %t2)
  %t4 = icmp ne i32 %t3, 0
  %t5 = select i1 %t4, i32 %a, i32 %b
  ret i32 %t5
}

define i1 @PR62171(<8 x float> %a0, <8 x float> %a1) {
; CHECK-LABEL: PR62171:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vcmpeqps %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vtestps %ymm0, %ymm0
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %cmp = fcmp oeq <8 x float> %a0, %a1
  %sext = sext <8 x i1> %cmp to <8 x i32>
  %extract = shufflevector <8 x i32> %sext, <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %extract1 = shufflevector <8 x i32> %sext, <8 x i32> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %or = or <4 x i32> %extract, %extract1
  %or1 = bitcast <4 x i32> %or to <16 x i8>
  %msk = icmp slt <16 x i8> %or1, zeroinitializer
  %msk1 = bitcast <16 x i1> %msk to i16
  %not = icmp eq i16 %msk1, 0
  ret i1 %not
}

define void @combine_testp_v8f32(<8 x i32> %x){
; AVX-LABEL: combine_testp_v8f32:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vcmptrueps %ymm1, %ymm1, %ymm1
; AVX-NEXT:    vtestps %ymm1, %ymm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX2-LABEL: combine_testp_v8f32:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vpcmpeqd %ymm1, %ymm1, %ymm1
; AVX2-NEXT:    vtestps %ymm1, %ymm0
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
entry:
  %xor.i.i.i.i.i.i.i.i.i = xor <8 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %.cast.i.i.i.i.i.i = bitcast <8 x i32> %xor.i.i.i.i.i.i.i.i.i to <8 x float>
  %0 = call i32 @llvm.x86.avx.vtestz.ps.256(<8 x float> %.cast.i.i.i.i.i.i, <8 x float> %.cast.i.i.i.i.i.i)
  %cmp.i.not.i.i.i.i.i.i = icmp eq i32 %0, 0
  br i1 %cmp.i.not.i.i.i.i.i.i, label %if.end3.i.i.i.i.i.i, label %end

if.end3.i.i.i.i.i.i:                              ; preds = %entry
  ret void

end: ; preds = %entry
  ret void
}

define i32 @PR88958_1(ptr %0, <4 x float> %1) {
; SSE-LABEL: PR88958_1:
; SSE:       # %bb.0:
; SSE-NEXT:    xorl %eax, %eax
; SSE-NEXT:    ptest (%rdi), %xmm0
; SSE-NEXT:    sete %al
; SSE-NEXT:    retq
;
; CHECK-LABEL: PR88958_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vtestps (%rdi), %xmm0
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %3 = load <4 x float>, ptr %0
  %4 = tail call i32 @llvm.x86.avx.vtestz.ps(<4 x float> %3, <4 x float> %1)
  ret i32 %4
}

define i32 @PR88958_2(ptr %0, <4 x float> %1) {
; SSE-LABEL: PR88958_2:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm1
; SSE-NEXT:    xorl %eax, %eax
; SSE-NEXT:    ptest %xmm0, %xmm1
; SSE-NEXT:    setb %al
; SSE-NEXT:    retq
;
; CHECK-LABEL: PR88958_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovaps (%rdi), %xmm1
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vtestps %xmm0, %xmm1
; CHECK-NEXT:    setb %al
; CHECK-NEXT:    retq
  %3 = load <4 x float>, ptr %0
  %4 = tail call i32 @llvm.x86.avx.vtestc.ps(<4 x float> %3, <4 x float> %1)
  ret i32 %4
}

define i32 @PR88958_3(ptr %0, <8 x float> %1) {
; SSE-LABEL: PR88958_1:
; SSE:       # %bb.0:
; SSE-NEXT:    xorl %eax, %eax
; SSE-NEXT:    ptest (%rdi), %xmm0
; SSE-NEXT:    sete %al
; SSE-NEXT:    retq
;
; CHECK-LABEL: PR88958_3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vtestps (%rdi), %ymm0
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %3 = load <8 x float>, ptr %0
  %4 = tail call i32 @llvm.x86.avx.vtestz.ps.256(<8 x float> %3, <8 x float> %1)
  ret i32 %4
}

define i32 @PR88958_4(ptr %0, <8 x float> %1) {
; SSE-LABEL: PR88958_2:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm1
; SSE-NEXT:    xorl %eax, %eax
; SSE-NEXT:    ptest %xmm0, %xmm1
; SSE-NEXT:    setb %al
; SSE-NEXT:    retq
;
; CHECK-LABEL: PR88958_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovaps (%rdi), %ymm1
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vtestps %ymm0, %ymm1
; CHECK-NEXT:    setb %al
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %3 = load <8 x float>, ptr %0
  %4 = tail call i32 @llvm.x86.avx.vtestc.ps.256(<8 x float> %3, <8 x float> %1)
  ret i32 %4
}

declare i32 @llvm.x86.avx.vtestz.ps(<4 x float>, <4 x float>) nounwind readnone
declare i32 @llvm.x86.avx.vtestc.ps(<4 x float>, <4 x float>) nounwind readnone
declare i32 @llvm.x86.avx.vtestnzc.ps(<4 x float>, <4 x float>) nounwind readnone

declare i32 @llvm.x86.avx.vtestz.ps.256(<8 x float>, <8 x float>) nounwind readnone
declare i32 @llvm.x86.avx.vtestc.ps.256(<8 x float>, <8 x float>) nounwind readnone
declare i32 @llvm.x86.avx.vtestnzc.ps.256(<8 x float>, <8 x float>) nounwind readnone

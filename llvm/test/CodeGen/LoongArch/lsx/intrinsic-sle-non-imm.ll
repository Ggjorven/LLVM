; RUN: not llc --mtriple=loongarch64 --mattr=+lsx < %s 2>&1 | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vslei.b(<16 x i8>, i32)

define <16 x i8> @lsx_vslei_b(<16 x i8> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vslei.b(<16 x i8> %va, i32 %b)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vslei.h(<8 x i16>, i32)

define <8 x i16> @lsx_vslei_h(<8 x i16> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vslei.h(<8 x i16> %va, i32 %b)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vslei.w(<4 x i32>, i32)

define <4 x i32> @lsx_vslei_w(<4 x i32> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vslei.w(<4 x i32> %va, i32 %b)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vslei.d(<2 x i64>, i32)

define <2 x i64> @lsx_vslei_d(<2 x i64> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vslei.d(<2 x i64> %va, i32 %b)
  ret <2 x i64> %res
}

declare <16 x i8> @llvm.loongarch.lsx.vslei.bu(<16 x i8>, i32)

define <16 x i8> @lsx_vslei_bu(<16 x i8> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vslei.bu(<16 x i8> %va, i32 %b)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vslei.hu(<8 x i16>, i32)

define <8 x i16> @lsx_vslei_hu(<8 x i16> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vslei.hu(<8 x i16> %va, i32 %b)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vslei.wu(<4 x i32>, i32)

define <4 x i32> @lsx_vslei_wu(<4 x i32> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vslei.wu(<4 x i32> %va, i32 %b)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vslei.du(<2 x i64>, i32)

define <2 x i64> @lsx_vslei_du(<2 x i64> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vslei.du(<2 x i64> %va, i32 %b)
  ret <2 x i64> %res
}

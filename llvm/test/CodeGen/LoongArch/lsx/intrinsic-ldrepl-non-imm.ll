; RUN: not llc --mtriple=loongarch64 --mattr=+lsx < %s 2>&1 | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vldrepl.b(ptr, i32)

define <16 x i8> @lsx_vldrepl_b(ptr %p, i32 %a) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vldrepl.b(ptr %p, i32 %a)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vldrepl.h(ptr, i32)

define <8 x i16> @lsx_vldrepl_h(ptr %p, i32 %a) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vldrepl.h(ptr %p, i32 %a)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vldrepl.w(ptr, i32)

define <4 x i32> @lsx_vldrepl_w(ptr %p, i32 %a) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vldrepl.w(ptr %p, i32 %a)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vldrepl.d(ptr, i32)

define <2 x i64> @lsx_vldrepl_d(ptr %p, i32 %a) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vldrepl.d(ptr %p, i32 %a)
  ret <2 x i64> %res
}

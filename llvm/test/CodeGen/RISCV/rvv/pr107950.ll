; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -verify-machineinstrs | FileCheck %s

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @m(<vscale x 4 x i1> %0) #0 {
; CHECK-LABEL: m:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vlse32.v v8, (zero), zero, v0.t
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (zero)
; CHECK-NEXT:    ret
entry:
  %broadcast.splatinsert184 = insertelement <vscale x 4 x ptr> zeroinitializer, ptr null, i64 0
  %broadcast.splat185 = shufflevector <vscale x 4 x ptr> %broadcast.splatinsert184, <vscale x 4 x ptr> zeroinitializer, <vscale x 4 x i32> zeroinitializer
  %wide.masked.gather186 = tail call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> %broadcast.splat185, i32 4, <vscale x 4 x i1> %0, <vscale x 4 x i32> zeroinitializer)
  %predphi187 = select <vscale x 4 x i1> %0, <vscale x 4 x i32> %wide.masked.gather186, <vscale x 4 x i32> zeroinitializer
  %1 = extractelement <vscale x 4 x i32> %predphi187, i32 0
  store i32 %1, ptr null, align 4
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr>, i32 immarg, <vscale x 4 x i1>, <vscale x 4 x i32>) #1

attributes #0 = { "target-features"="+64bit,+d,+f,+relax,+v,+xsifivecdiscarddlone,+zicsr,+zve32f,+zve32x,+zve64d,+zve64f,+zve64x,+zvl128b,+zvl32b,+zvl64b,-a,-b,-c,-e,-experimental-smctr,-experimental-smmpm,-experimental-smnpm,-experimental-ssctr,-experimental-ssnpm,-experimental-sspm,-experimental-supm,-experimental-zacas,-experimental-zalasr,-experimental-zicfilp,-experimental-zicfiss,-experimental-zvbc32e,-experimental-zvkgs,-h,-m,-shcounterenw,-shgatpa,-shtvala,-shvsatpa,-shvstvala,-shvstvecd,-smaia,-smcdeleg,-smcsrind,-smepmp,-smstateen,-ssaia,-ssccfg,-ssccptr,-sscofpmf,-sscounterenw,-sscsrind,-ssqosid,-ssstateen,-ssstrict,-sstc,-sstvala,-sstvecd,-ssu64xl,-svade,-svadu,-svbare,-svinval,-svnapot,-svpbmt,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfcease,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xsifivecflushdlone,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-xwchc,-za128rs,-za64rs,-zaamo,-zabha,-zalrsc,-zama16b,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmop,-zcmp,-zcmt,-zdinx,-zfa,-zfbfmin,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zifencei,-zihintntl,-zihintpause,-zihpm,-zimop,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-ztso,-zvbb,-zvbc,-zvfbfmin,-zvfbfwma,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl4096b,-zvl512b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }

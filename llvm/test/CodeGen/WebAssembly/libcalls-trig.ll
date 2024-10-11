; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -disable-wasm-fallthrough-return-opt -wasm-keep-registers | FileCheck %s

; Test a subset of compiler-rt/libm libcalls expected to be emitted by the wasm backend

target triple = "wasm32-unknown-unknown"

declare fp128 @llvm.sin.f128(fp128)
declare fp128 @llvm.cos.f128(fp128)
declare fp128 @llvm.tan.f128(fp128)
declare fp128 @llvm.asin.f128(fp128)
declare fp128 @llvm.acos.f128(fp128)
declare fp128 @llvm.atan.f128.i32(fp128)
declare fp128 @llvm.sinh.f128(fp128)
declare fp128 @llvm.cosh.f128(fp128)
declare fp128 @llvm.tanh.f128(fp128)

declare double @llvm.sin.f64(double)
declare double @llvm.cos.f64(double)
declare double @llvm.tan.f64(double)
declare double @llvm.asin.f64(double)
declare double @llvm.acos.f64(double)
declare double @llvm.atan.f64(double)
declare double @llvm.sinh.f64(double)
declare double @llvm.cosh.f64(double)
declare double @llvm.tanh.f64(double)

declare float @llvm.sin.f32(float)
declare float @llvm.cos.f32(float)
declare float @llvm.tan.f32(float)
declare float @llvm.asin.f32(float)
declare float @llvm.acos.f32(float)
declare float @llvm.atan.f32(float)
declare float @llvm.sinh.f32(float)
declare float @llvm.cosh.f32(float)
declare float @llvm.tanh.f32(float)


define fp128 @fp128libcalls(fp128 %x) {
  ; compiler-rt call
; CHECK-LABEL: fp128libcalls:
; CHECK:         .functype fp128libcalls (i32, i64, i64) -> ()
; CHECK-NEXT:    .local i32
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    global.get      $push28=, __stack_pointer
; CHECK-NEXT:    i32.const       $push29=, 144
; CHECK-NEXT:    i32.sub         $push73=, $pop28, $pop29
; CHECK-NEXT:    local.tee       $push72=, 3, $pop73
; CHECK-NEXT:    global.set      __stack_pointer, $pop72
; CHECK-NEXT:    local.get       $push74=, 3
; CHECK-NEXT:    i32.const       $push62=, 128
; CHECK-NEXT:    i32.add         $push63=, $pop74, $pop62
; CHECK-NEXT:    local.get       $push76=, 1
; CHECK-NEXT:    local.get       $push75=, 2
; CHECK-NEXT:    call    sinl, $pop63, $pop76, $pop75
; CHECK-NEXT:    local.get       $push77=, 3
; CHECK-NEXT:    i32.const       $push58=, 112
; CHECK-NEXT:    i32.add         $push59=, $pop77, $pop58
; CHECK-NEXT:    local.get       $push78=, 3
; CHECK-NEXT:    i64.load        $push3=, 128($pop78)
; CHECK-NEXT:    local.get       $push79=, 3
; CHECK-NEXT:    i32.const       $push60=, 128
; CHECK-NEXT:    i32.add         $push61=, $pop79, $pop60
; CHECK-NEXT:    i32.const       $push0=, 8
; CHECK-NEXT:    i32.add         $push1=, $pop61, $pop0
; CHECK-NEXT:    i64.load        $push2=, 0($pop1)
; CHECK-NEXT:    call    cosl, $pop59, $pop3, $pop2
; CHECK-NEXT:    local.get       $push80=, 3
; CHECK-NEXT:    i32.const       $push54=, 96
; CHECK-NEXT:    i32.add         $push55=, $pop80, $pop54
; CHECK-NEXT:    local.get       $push81=, 3
; CHECK-NEXT:    i64.load        $push6=, 112($pop81)
; CHECK-NEXT:    local.get       $push82=, 3
; CHECK-NEXT:    i32.const       $push56=, 112
; CHECK-NEXT:    i32.add         $push57=, $pop82, $pop56
; CHECK-NEXT:    i32.const       $push71=, 8
; CHECK-NEXT:    i32.add         $push4=, $pop57, $pop71
; CHECK-NEXT:    i64.load        $push5=, 0($pop4)
; CHECK-NEXT:    call    tanl, $pop55, $pop6, $pop5
; CHECK-NEXT:    local.get       $push83=, 3
; CHECK-NEXT:    i32.const       $push50=, 80
; CHECK-NEXT:    i32.add         $push51=, $pop83, $pop50
; CHECK-NEXT:    local.get       $push84=, 3
; CHECK-NEXT:    i64.load        $push9=, 96($pop84)
; CHECK-NEXT:    local.get       $push85=, 3
; CHECK-NEXT:    i32.const       $push52=, 96
; CHECK-NEXT:    i32.add         $push53=, $pop85, $pop52
; CHECK-NEXT:    i32.const       $push70=, 8
; CHECK-NEXT:    i32.add         $push7=, $pop53, $pop70
; CHECK-NEXT:    i64.load        $push8=, 0($pop7)
; CHECK-NEXT:    call    asinl, $pop51, $pop9, $pop8
; CHECK-NEXT:    local.get       $push86=, 3
; CHECK-NEXT:    i32.const       $push46=, 64
; CHECK-NEXT:    i32.add         $push47=, $pop86, $pop46
; CHECK-NEXT:    local.get       $push87=, 3
; CHECK-NEXT:    i64.load        $push12=, 80($pop87)
; CHECK-NEXT:    local.get       $push88=, 3
; CHECK-NEXT:    i32.const       $push48=, 80
; CHECK-NEXT:    i32.add         $push49=, $pop88, $pop48
; CHECK-NEXT:    i32.const       $push69=, 8
; CHECK-NEXT:    i32.add         $push10=, $pop49, $pop69
; CHECK-NEXT:    i64.load        $push11=, 0($pop10)
; CHECK-NEXT:    call    acosl, $pop47, $pop12, $pop11
; CHECK-NEXT:    local.get       $push89=, 3
; CHECK-NEXT:    i32.const       $push42=, 48
; CHECK-NEXT:    i32.add         $push43=, $pop89, $pop42
; CHECK-NEXT:    local.get       $push90=, 3
; CHECK-NEXT:    i64.load        $push15=, 64($pop90)
; CHECK-NEXT:    local.get       $push91=, 3
; CHECK-NEXT:    i32.const       $push44=, 64
; CHECK-NEXT:    i32.add         $push45=, $pop91, $pop44
; CHECK-NEXT:    i32.const       $push68=, 8
; CHECK-NEXT:    i32.add         $push13=, $pop45, $pop68
; CHECK-NEXT:    i64.load        $push14=, 0($pop13)
; CHECK-NEXT:    call    atanl, $pop43, $pop15, $pop14
; CHECK-NEXT:    local.get       $push92=, 3
; CHECK-NEXT:    i32.const       $push38=, 32
; CHECK-NEXT:    i32.add         $push39=, $pop92, $pop38
; CHECK-NEXT:    local.get       $push93=, 3
; CHECK-NEXT:    i64.load        $push18=, 48($pop93)
; CHECK-NEXT:    local.get       $push94=, 3
; CHECK-NEXT:    i32.const       $push40=, 48
; CHECK-NEXT:    i32.add         $push41=, $pop94, $pop40
; CHECK-NEXT:    i32.const       $push67=, 8
; CHECK-NEXT:    i32.add         $push16=, $pop41, $pop67
; CHECK-NEXT:    i64.load        $push17=, 0($pop16)
; CHECK-NEXT:    call    sinhl, $pop39, $pop18, $pop17
; CHECK-NEXT:    local.get       $push95=, 3
; CHECK-NEXT:    i32.const       $push34=, 16
; CHECK-NEXT:    i32.add         $push35=, $pop95, $pop34
; CHECK-NEXT:    local.get       $push96=, 3
; CHECK-NEXT:    i64.load        $push21=, 32($pop96)
; CHECK-NEXT:    local.get       $push97=, 3
; CHECK-NEXT:    i32.const       $push36=, 32
; CHECK-NEXT:    i32.add         $push37=, $pop97, $pop36
; CHECK-NEXT:    i32.const       $push66=, 8
; CHECK-NEXT:    i32.add         $push19=, $pop37, $pop66
; CHECK-NEXT:    i64.load        $push20=, 0($pop19)
; CHECK-NEXT:    call    coshl, $pop35, $pop21, $pop20
; CHECK-NEXT:    local.get       $push100=, 3
; CHECK-NEXT:    local.get       $push98=, 3
; CHECK-NEXT:    i64.load        $push24=, 16($pop98)
; CHECK-NEXT:    local.get       $push99=, 3
; CHECK-NEXT:    i32.const       $push32=, 16
; CHECK-NEXT:    i32.add         $push33=, $pop99, $pop32
; CHECK-NEXT:    i32.const       $push65=, 8
; CHECK-NEXT:    i32.add         $push22=, $pop33, $pop65
; CHECK-NEXT:    i64.load        $push23=, 0($pop22)
; CHECK-NEXT:    call    tanhl, $pop100, $pop24, $pop23
; CHECK-NEXT:    local.get       $push102=, 0
; CHECK-NEXT:    local.get       $push101=, 3
; CHECK-NEXT:    i32.const       $push64=, 8
; CHECK-NEXT:    i32.add         $push25=, $pop101, $pop64
; CHECK-NEXT:    i64.load        $push26=, 0($pop25)
; CHECK-NEXT:    i64.store       8($pop102), $pop26
; CHECK-NEXT:    local.get       $push104=, 0
; CHECK-NEXT:    local.get       $push103=, 3
; CHECK-NEXT:    i64.load        $push27=, 0($pop103)
; CHECK-NEXT:    i64.store       0($pop104), $pop27
; CHECK-NEXT:    local.get       $push105=, 3
; CHECK-NEXT:    i32.const       $push30=, 144
; CHECK-NEXT:    i32.add         $push31=, $pop105, $pop30
; CHECK-NEXT:    global.set      __stack_pointer, $pop31
; CHECK-NEXT:    return
  ; libm calls
  %d = call fp128 @llvm.sin.f128(fp128 %x)
  %e = call fp128 @llvm.cos.f128(fp128 %d)
  %f = call fp128 @llvm.tan.f128(fp128 %e)
  %g = call fp128 @llvm.asin.f128.i32(fp128 %f)
  %h = call fp128 @llvm.acos.f128(fp128 %g)
  %i = call fp128 @llvm.atan.f128(fp128 %h)
  %a = call fp128 @llvm.sinh.f128(fp128 %i)
  %b = call fp128 @llvm.cosh.f128(fp128 %a)
  %c = call fp128 @llvm.tanh.f128(fp128 %b)
  ret fp128 %c
}

define double @f64libcalls(double %x) {
; CHECK-LABEL: f64libcalls:
; CHECK:         .functype f64libcalls (f64) -> (f64)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push9=, 0
; CHECK-NEXT:    call    $push0=, sin, $pop9
; CHECK-NEXT:    call    $push1=, cos, $pop0
; CHECK-NEXT:    call    $push2=, tan, $pop1
; CHECK-NEXT:    call    $push3=, asin, $pop2
; CHECK-NEXT:    call    $push4=, acos, $pop3
; CHECK-NEXT:    call    $push5=, atan, $pop4
; CHECK-NEXT:    call    $push6=, sinh, $pop5
; CHECK-NEXT:    call    $push7=, cosh, $pop6
; CHECK-NEXT:    call    $push8=, tanh, $pop7  
; CHECK-NEXT:    return $pop8


 %k = call double @llvm.sin.f64(double %x)
 %a = call double @llvm.cos.f64(double %k)
 %b = call double @llvm.tan.f64(double %a)
 %c = call double @llvm.asin.f64(double %b)
 %d = call double @llvm.acos.f64(double %c)
 %e = call double @llvm.atan.f64(double %d)
 %f = call double @llvm.sinh.f64(double %e)
 %g = call double @llvm.cosh.f64(double %f)
 %h = call double @llvm.tanh.f64(double %g)
 ret double %h
}

define float @f32libcalls(float %x) {
; CHECK-LABEL: f32libcalls:
; CHECK:         .functype f32libcalls (f32) -> (f32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push9=, 0
; CHECK-NEXT:    call    $push0=, sinf, $pop9
; CHECK-NEXT:    call    $push1=, cosf, $pop0
; CHECK-NEXT:    call    $push2=, tanf, $pop1
; CHECK-NEXT:    call    $push3=, asinf, $pop2
; CHECK-NEXT:    call    $push4=, acosf, $pop3
; CHECK-NEXT:    call    $push5=, atanf, $pop4
; CHECK-NEXT:    call    $push6=, sinhf, $pop5
; CHECK-NEXT:    call    $push7=, coshf, $pop6
; CHECK-NEXT:    call    $push8=, tanhf, $pop7  
; CHECK-NEXT:    return $pop8


 %k = call float @llvm.sin.f32(float %x)
 %a = call float @llvm.cos.f32(float %k)
 %b = call float @llvm.tan.f32(float %a)
 %c = call float @llvm.asin.f32(float %b)
 %d = call float @llvm.acos.f32(float %c)
 %e = call float @llvm.atan.f32(float %d)
 %f = call float @llvm.sinh.f32(float %e)
 %g = call float @llvm.cosh.f32(float %f)
 %h = call float @llvm.tanh.f32(float %g)
 ret float %h
}

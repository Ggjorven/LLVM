; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -passes=infer-address-spaces %s | FileCheck %s

define <32 x i32> @masked_load_v32i32_global_to_flat(ptr addrspace(1) %ptr, <32 x i1> %mask) {
; CHECK-LABEL: define <32 x i32> @masked_load_v32i32_global_to_flat(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]], <32 x i1> [[MASK:%.*]]) {
; CHECK-NEXT:    [[LOAD:%.*]] = call <32 x i32> @llvm.masked.load.v32i32.p1(ptr addrspace(1) [[PTR]], i32 8, <32 x i1> [[MASK]], <32 x i32> zeroinitializer)
; CHECK-NEXT:    ret <32 x i32> [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(1) %ptr to ptr
  %load = call <32 x i32> @llvm.masked.load.v32i32.p0(ptr %cast, i32 8, <32 x i1> %mask, <32 x i32> zeroinitializer)
  ret <32 x i32> %load
}
define <32 x i32> @masked_load_v32i32_local_to_flat(ptr addrspace(3) %ptr, <32 x i1> %mask) {
; CHECK-LABEL: define <32 x i32> @masked_load_v32i32_local_to_flat(
; CHECK-SAME: ptr addrspace(3) [[PTR:%.*]], <32 x i1> [[MASK:%.*]]) {
; CHECK-NEXT:    [[LOAD:%.*]] = call <32 x i32> @llvm.masked.load.v32i32.p3(ptr addrspace(3) [[PTR]], i32 8, <32 x i1> [[MASK]], <32 x i32> zeroinitializer)
; CHECK-NEXT:    ret <32 x i32> [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %ptr to ptr
  %load = call <32 x i32> @llvm.masked.load.v32i32.p0(ptr %cast, i32 8, <32 x i1> %mask, <32 x i32> zeroinitializer)
  ret <32 x i32> %load
}

define <32 x i32> @masked_load_v32i32_private_to_flat(ptr addrspace(5) %ptr, <32 x i1> %mask) {
; CHECK-LABEL: define <32 x i32> @masked_load_v32i32_private_to_flat(
; CHECK-SAME: ptr addrspace(5) [[PTR:%.*]], <32 x i1> [[MASK:%.*]]) {
; CHECK-NEXT:    [[LOAD:%.*]] = call <32 x i32> @llvm.masked.load.v32i32.p5(ptr addrspace(5) [[PTR]], i32 8, <32 x i1> [[MASK]], <32 x i32> zeroinitializer)
; CHECK-NEXT:    ret <32 x i32> [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(5) %ptr to ptr
  %load = call <32 x i32> @llvm.masked.load.v32i32.p0(ptr %cast, i32 8, <32 x i1> %mask, <32 x i32> zeroinitializer)
  ret <32 x i32> %load
}

define void  @masked_store_v32i32_global_to_flat(ptr addrspace(1) %ptr, <32 x i1> %mask) {
; CHECK-LABEL: define void @masked_store_v32i32_global_to_flat(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]], <32 x i1> [[MASK:%.*]]) {
; CHECK-NEXT:    tail call void @llvm.masked.store.v32i32.p1(<32 x i32> zeroinitializer, ptr addrspace(1) [[PTR]], i32 128, <32 x i1> [[MASK]])
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr addrspace(1) %ptr to ptr
  tail call void @llvm.masked.store.v32i32.p0(<32 x i32> zeroinitializer, ptr %cast, i32 128, <32 x i1> %mask)
  ret void
}

define void  @masked_store_v32i32_local_to_flat(ptr addrspace(3) %ptr, <32 x i1> %mask) {
; CHECK-LABEL: define void @masked_store_v32i32_local_to_flat(
; CHECK-SAME: ptr addrspace(3) [[PTR:%.*]], <32 x i1> [[MASK:%.*]]) {
; CHECK-NEXT:    tail call void @llvm.masked.store.v32i32.p3(<32 x i32> zeroinitializer, ptr addrspace(3) [[PTR]], i32 128, <32 x i1> [[MASK]])
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr addrspace(3) %ptr to ptr
  tail call void @llvm.masked.store.v32i32.p0(<32 x i32> zeroinitializer, ptr %cast, i32 128, <32 x i1> %mask)
  ret void
}

define void  @masked_store_v32i32_private_to_flat(ptr addrspace(5) %ptr, <32 x i1> %mask) {
; CHECK-LABEL: define void @masked_store_v32i32_private_to_flat(
; CHECK-SAME: ptr addrspace(5) [[PTR:%.*]], <32 x i1> [[MASK:%.*]]) {
; CHECK-NEXT:    tail call void @llvm.masked.store.v32i32.p5(<32 x i32> zeroinitializer, ptr addrspace(5) [[PTR]], i32 128, <32 x i1> [[MASK]])
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr addrspace(5) %ptr to ptr
  tail call void @llvm.masked.store.v32i32.p0(<32 x i32> zeroinitializer, ptr %cast, i32 128, <32 x i1> %mask)
  ret void
}


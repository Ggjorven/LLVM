; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals all --version 4
; RUN: opt < %s -passes=amdgpu-sw-lower-lds -S -mtriple=amdgcn-amd-amdhsa | FileCheck %s

; Test to check if direct access of dynamic LDS in kernel is lowered correctly.
@lds_1 = external addrspace(3) global [0 x i8]
@lds_2 = external addrspace(3) global [0 x i8]

;.
; CHECK: @llvm.amdgcn.sw.lds.k0 = internal addrspace(3) global ptr poison, no_sanitize_address, align 1, !absolute_symbol [[META0:![0-9]+]]
; CHECK: @llvm.amdgcn.k0.dynlds = external addrspace(3) global [0 x i8], no_sanitize_address, align 1, !absolute_symbol [[META1:![0-9]+]]
; CHECK: @llvm.amdgcn.sw.lds.k0.md = internal addrspace(1) global %llvm.amdgcn.sw.lds.k0.md.type { %llvm.amdgcn.sw.lds.k0.md.item { i32 0, i32 8, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 32, i32 0, i32 32 } }, no_sanitize_address
;.
define amdgpu_kernel void @k0() sanitize_address {
; CHECK-LABEL: define amdgpu_kernel void @k0(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  WId:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.amdgcn.workitem.id.z()
; CHECK-NEXT:    [[TMP3:%.*]] = or i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[MALLOC:%.*]], label [[TMP7:%.*]]
; CHECK:       Malloc:
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, align 4
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE:%.*]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 0, i32 2), align 4
; CHECK-NEXT:    [[TMP24:%.*]] = add i32 [[TMP8]], [[TMP9]]
; CHECK-NEXT:    [[TMP20:%.*]] = call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) [[TMP20]], i64 15
; CHECK-NEXT:    store i32 [[TMP24]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr addrspace(4) [[TMP18]], align 4
; CHECK-NEXT:    store i32 [[TMP13]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 1), align 4
; CHECK-NEXT:    [[TMP14:%.*]] = add i32 [[TMP13]], 0
; CHECK-NEXT:    [[TMP15:%.*]] = udiv i32 [[TMP14]], 1
; CHECK-NEXT:    [[TMP16:%.*]] = mul i32 [[TMP15]], 1
; CHECK-NEXT:    store i32 [[TMP16]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 2), align 4
; CHECK-NEXT:    [[TMP17:%.*]] = add i32 [[TMP24]], [[TMP16]]
; CHECK-NEXT:    [[TMP21:%.*]] = zext i32 [[TMP17]] to i64
; CHECK-NEXT:    [[TMP22:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP23:%.*]] = ptrtoint ptr [[TMP22]] to i64
; CHECK-NEXT:    [[TMP19:%.*]] = call i64 @__asan_malloc_impl(i64 [[TMP21]], i64 [[TMP23]])
; CHECK-NEXT:    [[TMP6:%.*]] = inttoptr i64 [[TMP19]] to ptr addrspace(1)
; CHECK-NEXT:    store ptr addrspace(1) [[TMP6]], ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP42:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP6]], i64 8
; CHECK-NEXT:    [[TMP44:%.*]] = ptrtoint ptr addrspace(1) [[TMP42]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP44]], i64 24)
; CHECK-NEXT:    br label [[TMP7]]
; CHECK:       23:
; CHECK-NEXT:    [[XYZCOND:%.*]] = phi i1 [ false, [[WID:%.*]] ], [ true, [[MALLOC]] ]
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[TMP28:%.*]] = load ptr addrspace(1), ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, i32 [[TMP10]]
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.k0.dynlds) ]
; CHECK-NEXT:    [[TMP45:%.*]] = ptrtoint ptr addrspace(3) [[TMP11]] to i32
; CHECK-NEXT:    [[TMP46:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP28]], i32 [[TMP45]]
; CHECK-NEXT:    [[TMP29:%.*]] = ptrtoint ptr addrspace(1) [[TMP46]] to i64
; CHECK-NEXT:    [[TMP30:%.*]] = lshr i64 [[TMP29]], 3
; CHECK-NEXT:    [[TMP31:%.*]] = add i64 [[TMP30]], 2147450880
; CHECK-NEXT:    [[TMP32:%.*]] = inttoptr i64 [[TMP31]] to ptr
; CHECK-NEXT:    [[TMP33:%.*]] = load i8, ptr [[TMP32]], align 1
; CHECK-NEXT:    [[TMP34:%.*]] = icmp ne i8 [[TMP33]], 0
; CHECK-NEXT:    [[TMP35:%.*]] = and i64 [[TMP29]], 7
; CHECK-NEXT:    [[TMP36:%.*]] = trunc i64 [[TMP35]] to i8
; CHECK-NEXT:    [[TMP37:%.*]] = icmp sge i8 [[TMP36]], [[TMP33]]
; CHECK-NEXT:    [[TMP38:%.*]] = and i1 [[TMP34]], [[TMP37]]
; CHECK-NEXT:    [[TMP39:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP38]])
; CHECK-NEXT:    [[TMP40:%.*]] = icmp ne i64 [[TMP39]], 0
; CHECK-NEXT:    br i1 [[TMP40]], label [[ASAN_REPORT:%.*]], label [[TMP43:%.*]], !prof [[PROF2:![0-9]+]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP38]], label [[TMP41:%.*]], label [[CONDFREE:%.*]]
; CHECK:       41:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP29]]) #[[ATTR6:[0-9]+]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[CONDFREE]]
; CHECK:       42:
; CHECK-NEXT:    br label [[TMP43]]
; CHECK:       43:
; CHECK-NEXT:    store i8 7, ptr addrspace(1) [[TMP46]], align 4
; CHECK-NEXT:    br label [[CONDFREE1:%.*]]
; CHECK:       CondFree:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br i1 [[XYZCOND]], label [[FREE:%.*]], label [[END:%.*]]
; CHECK:       Free:
; CHECK-NEXT:    [[TMP25:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP26:%.*]] = ptrtoint ptr [[TMP25]] to i64
; CHECK-NEXT:    [[TMP27:%.*]] = ptrtoint ptr addrspace(1) [[TMP28]] to i64
; CHECK-NEXT:    call void @__asan_free_impl(i64 [[TMP27]], i64 [[TMP26]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       End:
; CHECK-NEXT:    ret void
;
  store i8 7, ptr addrspace(3) @lds_1, align 4
  ;store i8 8, ptr addrspace(3) @lds_2, align 8
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 4, !"nosanitize_address", i32 1}

;.
; CHECK: attributes #[[ATTR0]] = { sanitize_address "amdgpu-lds-size"="8,8" }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { convergent nocallback nofree nounwind willreturn }
; CHECK: attributes #[[ATTR4:[0-9]+]] = { convergent nocallback nofree nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR5:[0-9]+]] = { convergent nocallback nofree nounwind }
; CHECK: attributes #[[ATTR6]] = { nomerge }
;.
; CHECK: [[META0]] = !{i32 0, i32 1}
; CHECK: [[META1]] = !{i32 8, i32 9}
; CHECK: [[PROF2]] = !{!"branch_weights", i32 1, i32 1048575}
;.

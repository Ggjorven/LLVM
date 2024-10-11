; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals all --version 4
; RUN: opt < %s -passes=amdgpu-sw-lower-lds -S -mtriple=amdgcn-amd-amdhsa | FileCheck %s

; Test to check if static LDS accesses in kernel are lowered correctly.
@lds_1 = internal addrspace(3) global [1 x i8] poison, align 4
@lds_2 = internal addrspace(3) global [1 x i32] poison, align 8

;.
; CHECK: @llvm.amdgcn.sw.lds.k0 = internal addrspace(3) global ptr poison, no_sanitize_address, align 8, !absolute_symbol [[META0:![0-9]+]]
; CHECK: @llvm.amdgcn.sw.lds.k0.md = internal addrspace(1) global %llvm.amdgcn.sw.lds.k0.md.type { %llvm.amdgcn.sw.lds.k0.md.item { i32 0, i32 8, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 32, i32 1, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 64, i32 4, i32 32 } }, no_sanitize_address
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
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE:%.*]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 2), align 4
; CHECK-NEXT:    [[TMP16:%.*]] = add i32 [[TMP13]], [[TMP14]]
; CHECK-NEXT:    [[TMP15:%.*]] = zext i32 [[TMP16]] to i64
; CHECK-NEXT:    [[TMP23:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP11:%.*]] = ptrtoint ptr [[TMP23]] to i64
; CHECK-NEXT:    [[TMP12:%.*]] = call i64 @__asan_malloc_impl(i64 [[TMP15]], i64 [[TMP11]])
; CHECK-NEXT:    [[TMP6:%.*]] = inttoptr i64 [[TMP12]] to ptr addrspace(1)
; CHECK-NEXT:    store ptr addrspace(1) [[TMP6]], ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP6]], i64 8
; CHECK-NEXT:    [[TMP41:%.*]] = ptrtoint ptr addrspace(1) [[TMP25]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP41]], i64 24)
; CHECK-NEXT:    [[TMP61:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP6]], i64 33
; CHECK-NEXT:    [[TMP62:%.*]] = ptrtoint ptr addrspace(1) [[TMP61]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP62]], i64 31)
; CHECK-NEXT:    [[TMP63:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP6]], i64 68
; CHECK-NEXT:    [[TMP64:%.*]] = ptrtoint ptr addrspace(1) [[TMP63]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP64]], i64 28)
; CHECK-NEXT:    br label [[TMP7]]
; CHECK:       20:
; CHECK-NEXT:    [[XYZCOND:%.*]] = phi i1 [ false, [[WID:%.*]] ], [ true, [[MALLOC]] ]
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[TMP19:%.*]] = load ptr addrspace(1), ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, i32 [[TMP10]]
; CHECK-NEXT:    [[TMP17:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, i32 [[TMP17]]
; CHECK-NEXT:    [[TMP26:%.*]] = ptrtoint ptr addrspace(3) [[TMP18]] to i32
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP19]], i32 [[TMP26]]
; CHECK-NEXT:    [[TMP28:%.*]] = ptrtoint ptr addrspace(1) [[TMP27]] to i64
; CHECK-NEXT:    [[TMP29:%.*]] = lshr i64 [[TMP28]], 3
; CHECK-NEXT:    [[TMP30:%.*]] = add i64 [[TMP29]], 2147450880
; CHECK-NEXT:    [[TMP31:%.*]] = inttoptr i64 [[TMP30]] to ptr
; CHECK-NEXT:    [[TMP32:%.*]] = load i8, ptr [[TMP31]], align 1
; CHECK-NEXT:    [[TMP33:%.*]] = icmp ne i8 [[TMP32]], 0
; CHECK-NEXT:    [[TMP34:%.*]] = and i64 [[TMP28]], 7
; CHECK-NEXT:    [[TMP35:%.*]] = trunc i64 [[TMP34]] to i8
; CHECK-NEXT:    [[TMP36:%.*]] = icmp sge i8 [[TMP35]], [[TMP32]]
; CHECK-NEXT:    [[TMP37:%.*]] = and i1 [[TMP33]], [[TMP36]]
; CHECK-NEXT:    [[TMP38:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP37]])
; CHECK-NEXT:    [[TMP39:%.*]] = icmp ne i64 [[TMP38]], 0
; CHECK-NEXT:    br i1 [[TMP39]], label [[ASAN_REPORT:%.*]], label [[TMP42:%.*]], !prof [[PROF2:![0-9]+]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP37]], label [[TMP40:%.*]], label [[CONDFREE:%.*]]
; CHECK:       40:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP28]]) #[[ATTR6:[0-9]+]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[CONDFREE]]
; CHECK:       41:
; CHECK-NEXT:    br label [[TMP42]]
; CHECK:       42:
; CHECK-NEXT:    store i8 7, ptr addrspace(1) [[TMP27]], align 4
; CHECK-NEXT:    [[TMP43:%.*]] = ptrtoint ptr addrspace(3) [[TMP24]] to i32
; CHECK-NEXT:    [[TMP44:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP19]], i32 [[TMP43]]
; CHECK-NEXT:    [[TMP45:%.*]] = ptrtoint ptr addrspace(1) [[TMP44]] to i64
; CHECK-NEXT:    [[TMP51:%.*]] = add i64 [[TMP45]], 3
; CHECK-NEXT:    [[TMP78:%.*]] = inttoptr i64 [[TMP51]] to ptr addrspace(1)
; CHECK-NEXT:    [[TMP79:%.*]] = ptrtoint ptr addrspace(1) [[TMP44]] to i64
; CHECK-NEXT:    [[TMP46:%.*]] = lshr i64 [[TMP79]], 3
; CHECK-NEXT:    [[TMP47:%.*]] = add i64 [[TMP46]], 2147450880
; CHECK-NEXT:    [[TMP48:%.*]] = inttoptr i64 [[TMP47]] to ptr
; CHECK-NEXT:    [[TMP49:%.*]] = load i8, ptr [[TMP48]], align 1
; CHECK-NEXT:    [[TMP50:%.*]] = icmp ne i8 [[TMP49]], 0
; CHECK-NEXT:    [[TMP52:%.*]] = and i64 [[TMP79]], 7
; CHECK-NEXT:    [[TMP53:%.*]] = trunc i64 [[TMP52]] to i8
; CHECK-NEXT:    [[TMP54:%.*]] = icmp sge i8 [[TMP53]], [[TMP49]]
; CHECK-NEXT:    [[TMP55:%.*]] = and i1 [[TMP50]], [[TMP54]]
; CHECK-NEXT:    [[TMP56:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP55]])
; CHECK-NEXT:    [[TMP57:%.*]] = icmp ne i64 [[TMP56]], 0
; CHECK-NEXT:    br i1 [[TMP57]], label [[ASAN_REPORT1:%.*]], label [[TMP60:%.*]], !prof [[PROF2]]
; CHECK:       asan.report1:
; CHECK-NEXT:    br i1 [[TMP55]], label [[TMP58:%.*]], label [[TMP59:%.*]]
; CHECK:       60:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP79]]) #[[ATTR6]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP59]]
; CHECK:       61:
; CHECK-NEXT:    br label [[TMP60]]
; CHECK:       62:
; CHECK-NEXT:    [[TMP80:%.*]] = ptrtoint ptr addrspace(1) [[TMP78]] to i64
; CHECK-NEXT:    [[TMP81:%.*]] = lshr i64 [[TMP80]], 3
; CHECK-NEXT:    [[TMP65:%.*]] = add i64 [[TMP81]], 2147450880
; CHECK-NEXT:    [[TMP66:%.*]] = inttoptr i64 [[TMP65]] to ptr
; CHECK-NEXT:    [[TMP67:%.*]] = load i8, ptr [[TMP66]], align 1
; CHECK-NEXT:    [[TMP68:%.*]] = icmp ne i8 [[TMP67]], 0
; CHECK-NEXT:    [[TMP69:%.*]] = and i64 [[TMP80]], 7
; CHECK-NEXT:    [[TMP70:%.*]] = trunc i64 [[TMP69]] to i8
; CHECK-NEXT:    [[TMP71:%.*]] = icmp sge i8 [[TMP70]], [[TMP67]]
; CHECK-NEXT:    [[TMP72:%.*]] = and i1 [[TMP68]], [[TMP71]]
; CHECK-NEXT:    [[TMP73:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP72]])
; CHECK-NEXT:    [[TMP74:%.*]] = icmp ne i64 [[TMP73]], 0
; CHECK-NEXT:    br i1 [[TMP74]], label [[ASAN_REPORT2:%.*]], label [[TMP77:%.*]], !prof [[PROF2]]
; CHECK:       asan.report2:
; CHECK-NEXT:    br i1 [[TMP72]], label [[TMP75:%.*]], label [[TMP76:%.*]]
; CHECK:       75:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP80]]) #[[ATTR6]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP76]]
; CHECK:       76:
; CHECK-NEXT:    br label [[TMP77]]
; CHECK:       77:
; CHECK-NEXT:    store i32 8, ptr addrspace(1) [[TMP44]], align 2
; CHECK-NEXT:    br label [[CONDFREE1:%.*]]
; CHECK:       CondFree:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br i1 [[XYZCOND]], label [[FREE:%.*]], label [[END:%.*]]
; CHECK:       Free:
; CHECK-NEXT:    [[TMP20:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP21:%.*]] = ptrtoint ptr [[TMP20]] to i64
; CHECK-NEXT:    [[TMP22:%.*]] = ptrtoint ptr addrspace(1) [[TMP19]] to i64
; CHECK-NEXT:    call void @__asan_free_impl(i64 [[TMP22]], i64 [[TMP21]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       End:
; CHECK-NEXT:    ret void
;
  store i8 7, ptr addrspace(3) @lds_1, align 4
  store i32 8, ptr addrspace(3) @lds_2, align 2
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 4, !"nosanitize_address", i32 1}

;.
; CHECK: attributes #[[ATTR0]] = { sanitize_address "amdgpu-lds-size"="8" }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { convergent nocallback nofree nounwind willreturn }
; CHECK: attributes #[[ATTR4:[0-9]+]] = { convergent nocallback nofree nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR5:[0-9]+]] = { convergent nocallback nofree nounwind }
; CHECK: attributes #[[ATTR6]] = { nomerge }
;.
; CHECK: [[META0]] = !{i32 0, i32 1}
; CHECK: [[META1:![0-9]+]] = !{i32 4, !"nosanitize_address", i32 1}
; CHECK: [[PROF2]] = !{!"branch_weights", i32 1, i32 1048575}
;.

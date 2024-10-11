; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --scrub-attributes --version 5
; RUN: opt < %s -mtriple nvptx64 -mcpu=sm_60 -mattr=ptx77 -nvptx-lower-args -S | FileCheck %s --check-prefixes=COMMON,SM_60
; RUN: opt < %s -mtriple nvptx64 -mcpu=sm_70 -mattr=ptx77 -nvptx-lower-args -S | FileCheck %s --check-prefixes=COMMON,SM_70
source_filename = "<stdin>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.S = type { i32, i32 }

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
declare dso_local void @_Z6escapePv(ptr noundef) local_unnamed_addr #0

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
declare dso_local void @_Z6escapei(i32 noundef) local_unnamed_addr #0

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @read_only(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @read_only(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr nocapture noundef readonly byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[I:%.*]] = load i32, ptr addrspace(101) [[S3]], align 4
; COMMON-NEXT:    store i32 [[I]], ptr [[OUT2]], align 4
; COMMON-NEXT:    ret void
;
entry:
  %i = load i32, ptr %s, align 4
  store i32 %i, ptr %out, align 4
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @read_only_gep(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @read_only_gep(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr nocapture noundef readonly byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[B4:%.*]] = getelementptr inbounds i8, ptr addrspace(101) [[S3]], i64 4
; COMMON-NEXT:    [[I:%.*]] = load i32, ptr addrspace(101) [[B4]], align 4
; COMMON-NEXT:    store i32 [[I]], ptr [[OUT2]], align 4
; COMMON-NEXT:    ret void
;
entry:
  %b = getelementptr inbounds nuw i8, ptr %s, i64 4
  %i = load i32, ptr %b, align 4
  store i32 %i, ptr %out, align 4
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @read_only_gep_asc(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @read_only_gep_asc(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr nocapture noundef readonly byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[B4:%.*]] = getelementptr inbounds i8, ptr addrspace(101) [[S3]], i64 4
; COMMON-NEXT:    [[I:%.*]] = load i32, ptr addrspace(101) [[B4]], align 4
; COMMON-NEXT:    store i32 [[I]], ptr [[OUT2]], align 4
; COMMON-NEXT:    ret void
;
entry:
  %b = getelementptr inbounds nuw i8, ptr %s, i64 4
  %asc = addrspacecast ptr %b to ptr addrspace(101)
  %i = load i32, ptr addrspace(101) %asc, align 4
  store i32 %i, ptr %out, align 4
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @read_only_gep_asc0(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @read_only_gep_asc0(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr nocapture noundef readonly byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[B:%.*]] = getelementptr inbounds nuw i8, ptr [[S3]], i64 4
; COMMON-NEXT:    [[ASC:%.*]] = addrspacecast ptr [[B]] to ptr addrspace(101)
; COMMON-NEXT:    [[ASC0:%.*]] = addrspacecast ptr addrspace(101) [[ASC]] to ptr
; COMMON-NEXT:    [[I:%.*]] = load i32, ptr [[ASC0]], align 4
; COMMON-NEXT:    store i32 [[I]], ptr [[OUT2]], align 4
; COMMON-NEXT:    ret void
;
entry:
  %b = getelementptr inbounds nuw i8, ptr %s, i64 4
  %asc = addrspacecast ptr %b to ptr addrspace(101)
  %asc0 = addrspacecast ptr addrspace(101) %asc to ptr
  %i = load i32, ptr %asc0, align 4
  store i32 %i, ptr %out, align 4
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @escape_ptr(ptr nocapture noundef readnone %out, ptr noundef byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @escape_ptr(
; COMMON-SAME: ptr nocapture noundef readnone [[OUT:%.*]], ptr noundef byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    call void @_Z6escapePv(ptr noundef nonnull [[S3]])
; COMMON-NEXT:    ret void
;
entry:
  call void @_Z6escapePv(ptr noundef nonnull %s) #0
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @escape_ptr_gep(ptr nocapture noundef readnone %out, ptr noundef byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @escape_ptr_gep(
; COMMON-SAME: ptr nocapture noundef readnone [[OUT:%.*]], ptr noundef byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[B:%.*]] = getelementptr inbounds nuw i8, ptr [[S3]], i64 4
; COMMON-NEXT:    call void @_Z6escapePv(ptr noundef nonnull [[B]])
; COMMON-NEXT:    ret void
;
entry:
  %b = getelementptr inbounds nuw i8, ptr %s, i64 4
  call void @_Z6escapePv(ptr noundef nonnull %b) #0
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @escape_ptr_store(ptr nocapture noundef writeonly %out, ptr noundef byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @escape_ptr_store(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr noundef byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    store ptr [[S3]], ptr [[OUT2]], align 8
; COMMON-NEXT:    ret void
;
entry:
  store ptr %s, ptr %out, align 8
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @escape_ptr_gep_store(ptr nocapture noundef writeonly %out, ptr noundef byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @escape_ptr_gep_store(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr noundef byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[B:%.*]] = getelementptr inbounds nuw i8, ptr [[S3]], i64 4
; COMMON-NEXT:    store ptr [[B]], ptr [[OUT2]], align 8
; COMMON-NEXT:    ret void
;
entry:
  %b = getelementptr inbounds nuw i8, ptr %s, i64 4
  store ptr %b, ptr %out, align 8
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @escape_ptrtoint(ptr nocapture noundef writeonly %out, ptr noundef byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @escape_ptrtoint(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr noundef byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    [[I:%.*]] = ptrtoint ptr [[S3]] to i64
; COMMON-NEXT:    store i64 [[I]], ptr [[OUT2]], align 8
; COMMON-NEXT:    ret void
;
entry:
  %i = ptrtoint ptr %s to i64
  store i64 %i, ptr %out, align 8
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @memcpy_from_param(ptr nocapture noundef writeonly %out, ptr nocapture noundef readonly byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @memcpy_from_param(
; COMMON-SAME: ptr nocapture noundef writeonly [[OUT:%.*]], ptr nocapture noundef readonly byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; COMMON-NEXT:    call void @llvm.memcpy.p0.p101.i64(ptr [[OUT2]], ptr addrspace(101) [[S3]], i64 16, i1 true)
; COMMON-NEXT:    ret void
;
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %out, ptr %s, i64 16, i1 true)
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @memcpy_to_param(ptr nocapture noundef readonly %in, ptr nocapture noundef readnone byval(%struct.S) align 4 %s) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @memcpy_to_param(
; COMMON-SAME: ptr nocapture noundef readonly [[IN:%.*]], ptr nocapture noundef readnone byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[ENTRY:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[IN1:%.*]] = addrspacecast ptr [[IN]] to ptr addrspace(1)
; COMMON-NEXT:    [[IN2:%.*]] = addrspacecast ptr addrspace(1) [[IN1]] to ptr
; COMMON-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr [[S3]], ptr [[IN2]], i64 16, i1 true)
; COMMON-NEXT:    ret void
;
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s, ptr %in, i64 16, i1 true)
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @copy_on_store(ptr nocapture noundef readonly %in, ptr nocapture noundef byval(%struct.S) align 4 %s, i1 noundef zeroext %b) local_unnamed_addr #0 {
; COMMON-LABEL: define dso_local void @copy_on_store(
; COMMON-SAME: ptr nocapture noundef readonly [[IN:%.*]], ptr nocapture noundef byval([[STRUCT_S:%.*]]) align 4 [[S:%.*]], i1 noundef zeroext [[B:%.*]]) local_unnamed_addr #[[ATTR0]] {
; COMMON-NEXT:  [[BB:.*:]]
; COMMON-NEXT:    [[S3:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[S4:%.*]] = addrspacecast ptr [[S]] to ptr addrspace(101)
; COMMON-NEXT:    [[S5:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[S4]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[S5]], ptr [[S3]], align 4
; COMMON-NEXT:    [[IN1:%.*]] = addrspacecast ptr [[IN]] to ptr addrspace(1)
; COMMON-NEXT:    [[IN2:%.*]] = addrspacecast ptr addrspace(1) [[IN1]] to ptr
; COMMON-NEXT:    [[I:%.*]] = load i32, ptr [[IN2]], align 4
; COMMON-NEXT:    store i32 [[I]], ptr [[S3]], align 4
; COMMON-NEXT:    ret void
;
bb:
  %i = load i32, ptr %in, align 4
  store i32 %i, ptr %s, align 4
  ret void
}

define void @test_select(ptr byval(i32) align 4 %input1, ptr byval(i32) %input2, ptr %out, i1 %cond) {
; SM_60-LABEL: define void @test_select(
; SM_60-SAME: ptr byval(i32) align 4 [[INPUT1:%.*]], ptr byval(i32) [[INPUT2:%.*]], ptr [[OUT:%.*]], i1 [[COND:%.*]]) #[[ATTR3:[0-9]+]] {
; SM_60-NEXT:  [[BB:.*:]]
; SM_60-NEXT:    [[OUT7:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; SM_60-NEXT:    [[OUT8:%.*]] = addrspacecast ptr addrspace(1) [[OUT7]] to ptr
; SM_60-NEXT:    [[INPUT24:%.*]] = alloca i32, align 4
; SM_60-NEXT:    [[INPUT25:%.*]] = addrspacecast ptr [[INPUT2]] to ptr addrspace(101)
; SM_60-NEXT:    [[INPUT26:%.*]] = load i32, ptr addrspace(101) [[INPUT25]], align 4
; SM_60-NEXT:    store i32 [[INPUT26]], ptr [[INPUT24]], align 4
; SM_60-NEXT:    [[INPUT11:%.*]] = alloca i32, align 4
; SM_60-NEXT:    [[INPUT12:%.*]] = addrspacecast ptr [[INPUT1]] to ptr addrspace(101)
; SM_60-NEXT:    [[INPUT13:%.*]] = load i32, ptr addrspace(101) [[INPUT12]], align 4
; SM_60-NEXT:    store i32 [[INPUT13]], ptr [[INPUT11]], align 4
; SM_60-NEXT:    [[PTRNEW:%.*]] = select i1 [[COND]], ptr [[INPUT11]], ptr [[INPUT24]]
; SM_60-NEXT:    [[VALLOADED:%.*]] = load i32, ptr [[PTRNEW]], align 4
; SM_60-NEXT:    store i32 [[VALLOADED]], ptr [[OUT8]], align 4
; SM_60-NEXT:    ret void
;
; SM_70-LABEL: define void @test_select(
; SM_70-SAME: ptr byval(i32) align 4 [[INPUT1:%.*]], ptr byval(i32) [[INPUT2:%.*]], ptr [[OUT:%.*]], i1 [[COND:%.*]]) #[[ATTR3:[0-9]+]] {
; SM_70-NEXT:  [[BB:.*:]]
; SM_70-NEXT:    [[OUT1:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; SM_70-NEXT:    [[OUT2:%.*]] = addrspacecast ptr addrspace(1) [[OUT1]] to ptr
; SM_70-NEXT:    [[INPUT2_PARAM:%.*]] = addrspacecast ptr [[INPUT2]] to ptr addrspace(101)
; SM_70-NEXT:    [[INPUT2_PARAM_GEN:%.*]] = call ptr @llvm.nvvm.ptr.param.to.gen.p0.p101(ptr addrspace(101) [[INPUT2_PARAM]])
; SM_70-NEXT:    [[INPUT1_PARAM:%.*]] = addrspacecast ptr [[INPUT1]] to ptr addrspace(101)
; SM_70-NEXT:    [[INPUT1_PARAM_GEN:%.*]] = call ptr @llvm.nvvm.ptr.param.to.gen.p0.p101(ptr addrspace(101) [[INPUT1_PARAM]])
; SM_70-NEXT:    [[PTRNEW:%.*]] = select i1 [[COND]], ptr [[INPUT1_PARAM_GEN]], ptr [[INPUT2_PARAM_GEN]]
; SM_70-NEXT:    [[VALLOADED:%.*]] = load i32, ptr [[PTRNEW]], align 4
; SM_70-NEXT:    store i32 [[VALLOADED]], ptr [[OUT2]], align 4
; SM_70-NEXT:    ret void
;
bb:
  %ptrnew = select i1 %cond, ptr %input1, ptr %input2
  %valloaded = load i32, ptr %ptrnew, align 4
  store i32 %valloaded, ptr %out, align 4
  ret void
}

define void @test_select_write(ptr byval(i32) align 4 %input1, ptr byval(i32) %input2, ptr %out, i1 %cond) {
; COMMON-LABEL: define void @test_select_write(
; COMMON-SAME: ptr byval(i32) align 4 [[INPUT1:%.*]], ptr byval(i32) [[INPUT2:%.*]], ptr [[OUT:%.*]], i1 [[COND:%.*]]) #[[ATTR3:[0-9]+]] {
; COMMON-NEXT:  [[BB:.*:]]
; COMMON-NEXT:    [[OUT7:%.*]] = addrspacecast ptr [[OUT]] to ptr addrspace(1)
; COMMON-NEXT:    [[OUT8:%.*]] = addrspacecast ptr addrspace(1) [[OUT7]] to ptr
; COMMON-NEXT:    [[INPUT24:%.*]] = alloca i32, align 4
; COMMON-NEXT:    [[INPUT25:%.*]] = addrspacecast ptr [[INPUT2]] to ptr addrspace(101)
; COMMON-NEXT:    [[INPUT26:%.*]] = load i32, ptr addrspace(101) [[INPUT25]], align 4
; COMMON-NEXT:    store i32 [[INPUT26]], ptr [[INPUT24]], align 4
; COMMON-NEXT:    [[INPUT11:%.*]] = alloca i32, align 4
; COMMON-NEXT:    [[INPUT12:%.*]] = addrspacecast ptr [[INPUT1]] to ptr addrspace(101)
; COMMON-NEXT:    [[INPUT13:%.*]] = load i32, ptr addrspace(101) [[INPUT12]], align 4
; COMMON-NEXT:    store i32 [[INPUT13]], ptr [[INPUT11]], align 4
; COMMON-NEXT:    [[PTRNEW:%.*]] = select i1 [[COND]], ptr [[INPUT11]], ptr [[INPUT24]]
; COMMON-NEXT:    store i32 1, ptr [[PTRNEW]], align 4
; COMMON-NEXT:    ret void
;
bb:
  %ptrnew = select i1 %cond, ptr %input1, ptr %input2
  store i32 1, ptr %ptrnew, align 4
  ret void
}

define void @test_phi(ptr byval(%struct.S) align 4 %input1, ptr byval(%struct.S) %input2, ptr %inout, i1 %cond) {
; SM_60-LABEL: define void @test_phi(
; SM_60-SAME: ptr byval([[STRUCT_S:%.*]]) align 4 [[INPUT1:%.*]], ptr byval([[STRUCT_S]]) [[INPUT2:%.*]], ptr [[INOUT:%.*]], i1 [[COND:%.*]]) #[[ATTR3]] {
; SM_60-NEXT:  [[BB:.*:]]
; SM_60-NEXT:    [[INOUT7:%.*]] = addrspacecast ptr [[INOUT]] to ptr addrspace(1)
; SM_60-NEXT:    [[INOUT8:%.*]] = addrspacecast ptr addrspace(1) [[INOUT7]] to ptr
; SM_60-NEXT:    [[INPUT24:%.*]] = alloca [[STRUCT_S]], align 8
; SM_60-NEXT:    [[INPUT25:%.*]] = addrspacecast ptr [[INPUT2]] to ptr addrspace(101)
; SM_60-NEXT:    [[INPUT26:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[INPUT25]], align 8
; SM_60-NEXT:    store [[STRUCT_S]] [[INPUT26]], ptr [[INPUT24]], align 4
; SM_60-NEXT:    [[INPUT11:%.*]] = alloca [[STRUCT_S]], align 4
; SM_60-NEXT:    [[INPUT12:%.*]] = addrspacecast ptr [[INPUT1]] to ptr addrspace(101)
; SM_60-NEXT:    [[INPUT13:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[INPUT12]], align 4
; SM_60-NEXT:    store [[STRUCT_S]] [[INPUT13]], ptr [[INPUT11]], align 4
; SM_60-NEXT:    br i1 [[COND]], label %[[FIRST:.*]], label %[[SECOND:.*]]
; SM_60:       [[FIRST]]:
; SM_60-NEXT:    [[PTR1:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[INPUT11]], i32 0, i32 0
; SM_60-NEXT:    br label %[[MERGE:.*]]
; SM_60:       [[SECOND]]:
; SM_60-NEXT:    [[PTR2:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[INPUT24]], i32 0, i32 1
; SM_60-NEXT:    br label %[[MERGE]]
; SM_60:       [[MERGE]]:
; SM_60-NEXT:    [[PTRNEW:%.*]] = phi ptr [ [[PTR1]], %[[FIRST]] ], [ [[PTR2]], %[[SECOND]] ]
; SM_60-NEXT:    [[VALLOADED:%.*]] = load i32, ptr [[PTRNEW]], align 4
; SM_60-NEXT:    store i32 [[VALLOADED]], ptr [[INOUT8]], align 4
; SM_60-NEXT:    ret void
;
; SM_70-LABEL: define void @test_phi(
; SM_70-SAME: ptr byval([[STRUCT_S:%.*]]) align 4 [[INPUT1:%.*]], ptr byval([[STRUCT_S]]) [[INPUT2:%.*]], ptr [[INOUT:%.*]], i1 [[COND:%.*]]) #[[ATTR3]] {
; SM_70-NEXT:  [[BB:.*:]]
; SM_70-NEXT:    [[INOUT1:%.*]] = addrspacecast ptr [[INOUT]] to ptr addrspace(1)
; SM_70-NEXT:    [[INOUT2:%.*]] = addrspacecast ptr addrspace(1) [[INOUT1]] to ptr
; SM_70-NEXT:    [[INPUT2_PARAM:%.*]] = addrspacecast ptr [[INPUT2]] to ptr addrspace(101)
; SM_70-NEXT:    [[INPUT2_PARAM_GEN:%.*]] = call ptr @llvm.nvvm.ptr.param.to.gen.p0.p101(ptr addrspace(101) [[INPUT2_PARAM]])
; SM_70-NEXT:    [[INPUT1_PARAM:%.*]] = addrspacecast ptr [[INPUT1]] to ptr addrspace(101)
; SM_70-NEXT:    [[INPUT1_PARAM_GEN:%.*]] = call ptr @llvm.nvvm.ptr.param.to.gen.p0.p101(ptr addrspace(101) [[INPUT1_PARAM]])
; SM_70-NEXT:    br i1 [[COND]], label %[[FIRST:.*]], label %[[SECOND:.*]]
; SM_70:       [[FIRST]]:
; SM_70-NEXT:    [[PTR1:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[INPUT1_PARAM_GEN]], i32 0, i32 0
; SM_70-NEXT:    br label %[[MERGE:.*]]
; SM_70:       [[SECOND]]:
; SM_70-NEXT:    [[PTR2:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[INPUT2_PARAM_GEN]], i32 0, i32 1
; SM_70-NEXT:    br label %[[MERGE]]
; SM_70:       [[MERGE]]:
; SM_70-NEXT:    [[PTRNEW:%.*]] = phi ptr [ [[PTR1]], %[[FIRST]] ], [ [[PTR2]], %[[SECOND]] ]
; SM_70-NEXT:    [[VALLOADED:%.*]] = load i32, ptr [[PTRNEW]], align 4
; SM_70-NEXT:    store i32 [[VALLOADED]], ptr [[INOUT2]], align 4
; SM_70-NEXT:    ret void
;
bb:
  br i1 %cond, label %first, label %second

first:                                            ; preds = %bb
  %ptr1 = getelementptr inbounds %struct.S, ptr %input1, i32 0, i32 0
  br label %merge

second:                                           ; preds = %bb
  %ptr2 = getelementptr inbounds %struct.S, ptr %input2, i32 0, i32 1
  br label %merge

merge:                                            ; preds = %second, %first
  %ptrnew = phi ptr [ %ptr1, %first ], [ %ptr2, %second ]
  %valloaded = load i32, ptr %ptrnew, align 4
  store i32 %valloaded, ptr %inout, align 4
  ret void
}

define void @test_phi_write(ptr byval(%struct.S) align 4 %input1, ptr byval(%struct.S) %input2, i1 %cond) {
; COMMON-LABEL: define void @test_phi_write(
; COMMON-SAME: ptr byval([[STRUCT_S:%.*]]) align 4 [[INPUT1:%.*]], ptr byval([[STRUCT_S]]) [[INPUT2:%.*]], i1 [[COND:%.*]]) #[[ATTR3]] {
; COMMON-NEXT:  [[BB:.*:]]
; COMMON-NEXT:    [[INPUT24:%.*]] = alloca [[STRUCT_S]], align 8
; COMMON-NEXT:    [[INPUT25:%.*]] = addrspacecast ptr [[INPUT2]] to ptr addrspace(101)
; COMMON-NEXT:    [[INPUT26:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[INPUT25]], align 8
; COMMON-NEXT:    store [[STRUCT_S]] [[INPUT26]], ptr [[INPUT24]], align 4
; COMMON-NEXT:    [[INPUT11:%.*]] = alloca [[STRUCT_S]], align 4
; COMMON-NEXT:    [[INPUT12:%.*]] = addrspacecast ptr [[INPUT1]] to ptr addrspace(101)
; COMMON-NEXT:    [[INPUT13:%.*]] = load [[STRUCT_S]], ptr addrspace(101) [[INPUT12]], align 4
; COMMON-NEXT:    store [[STRUCT_S]] [[INPUT13]], ptr [[INPUT11]], align 4
; COMMON-NEXT:    br i1 [[COND]], label %[[FIRST:.*]], label %[[SECOND:.*]]
; COMMON:       [[FIRST]]:
; COMMON-NEXT:    [[PTR1:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[INPUT11]], i32 0, i32 0
; COMMON-NEXT:    br label %[[MERGE:.*]]
; COMMON:       [[SECOND]]:
; COMMON-NEXT:    [[PTR2:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[INPUT24]], i32 0, i32 1
; COMMON-NEXT:    br label %[[MERGE]]
; COMMON:       [[MERGE]]:
; COMMON-NEXT:    [[PTRNEW:%.*]] = phi ptr [ [[PTR1]], %[[FIRST]] ], [ [[PTR2]], %[[SECOND]] ]
; COMMON-NEXT:    store i32 1, ptr [[PTRNEW]], align 4
; COMMON-NEXT:    ret void
;
bb:
  br i1 %cond, label %first, label %second

first:                                            ; preds = %bb
  %ptr1 = getelementptr inbounds %struct.S, ptr %input1, i32 0, i32 0
  br label %merge

second:                                           ; preds = %bb
  %ptr2 = getelementptr inbounds %struct.S, ptr %input2, i32 0, i32 1
  br label %merge

merge:                                            ; preds = %second, %first
  %ptrnew = phi ptr [ %ptr1, %first ], [ %ptr2, %second ]
  store i32 1, ptr %ptrnew, align 4
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "no-trapping-math"="true" "target-cpu"="sm_60" "target-features"="+ptx78,+sm_60" "uniform-work-group-size"="true" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0, !1, !2, !3}
!nvvm.annotations = !{!4, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19}
!llvm.ident = !{!20, !21}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 8]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{ptr @read_only, !"kernel", i32 1}
!5 = !{ptr @escape_ptr, !"kernel", i32 1}
!6 = !{ptr @escape_ptr_gep, !"kernel", i32 1}
!7 = !{ptr @escape_ptr_store, !"kernel", i32 1}
!8 = !{ptr @escape_ptr_gep_store, !"kernel", i32 1}
!9 = !{ptr @escape_ptrtoint, !"kernel", i32 1}
!10 = !{ptr @memcpy_from_param, !"kernel", i32 1}
!11 = !{ptr @memcpy_to_param, !"kernel", i32 1}
!12 = !{ptr @copy_on_store, !"kernel", i32 1}
!13 = !{ptr @read_only_gep, !"kernel", i32 1}
!14 = !{ptr @read_only_gep_asc, !"kernel", i32 1}
!15 = !{ptr @read_only_gep_asc0, !"kernel", i32 1}
!16 = !{ptr @test_select, !"kernel", i32 1}
!17 = !{ptr @test_phi, !"kernel", i32 1}
!18 = !{ptr @test_phi_write, !"kernel", i32 1}
!19 = !{ptr @test_select_write, !"kernel", i32 1}
!20 = !{!"clang version 20.0.0git"}
!21 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}

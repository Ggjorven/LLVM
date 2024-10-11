; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --version 2
; RUN: opt -passes=function-attrs -S < %s | FileCheck --check-prefixes=COMMON,FNATTRS %s
; RUN: opt -passes=attributor-light -S < %s | FileCheck --check-prefixes=COMMON,ATTRIBUTOR %s

@g = global ptr null		; <ptr> [#uses=1]

define ptr @c1(ptr %q) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define ptr @c1
; FNATTRS-SAME: (ptr readnone returned [[Q:%.*]]) #[[ATTR0:[0-9]+]] {
; FNATTRS-NEXT:    ret ptr [[Q]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define ptr @c1
; ATTRIBUTOR-SAME: (ptr nofree readnone [[Q:%.*]]) #[[ATTR0:[0-9]+]] {
; ATTRIBUTOR-NEXT:    ret ptr [[Q]]
;
  ret ptr %q
}

; It would also be acceptable to mark %q as readnone. Update @c3 too.
define void @c2(ptr %q) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define void @c2
; FNATTRS-SAME: (ptr [[Q:%.*]]) #[[ATTR1:[0-9]+]] {
; FNATTRS-NEXT:    store ptr [[Q]], ptr @g, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; ATTRIBUTOR-LABEL: define void @c2
; ATTRIBUTOR-SAME: (ptr nofree writeonly [[Q:%.*]]) #[[ATTR1:[0-9]+]] {
; ATTRIBUTOR-NEXT:    store ptr [[Q]], ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  store ptr %q, ptr @g
  ret void
}

define void @c3(ptr %q) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, inaccessiblemem: none)
; FNATTRS-LABEL: define void @c3
; FNATTRS-SAME: (ptr [[Q:%.*]]) #[[ATTR2:[0-9]+]] {
; FNATTRS-NEXT:    call void @c2(ptr [[Q]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; ATTRIBUTOR-LABEL: define void @c3
; ATTRIBUTOR-SAME: (ptr nofree writeonly [[Q:%.*]]) #[[ATTR1]] {
; ATTRIBUTOR-NEXT:    call void @c2(ptr nofree writeonly [[Q]]) #[[ATTR16:[0-9]+]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @c2(ptr %q)
  ret void
}

define i1 @c4(ptr %q, i32 %bitno) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define noundef i1 @c4
; FNATTRS-SAME: (ptr [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; FNATTRS-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; FNATTRS-NEXT:    [[BIT:%.*]] = trunc i32 [[TMP2]] to i1
; FNATTRS-NEXT:    br i1 [[BIT]], label [[L1:%.*]], label [[L0:%.*]]
; FNATTRS:       l0:
; FNATTRS-NEXT:    ret i1 false
; FNATTRS:       l1:
; FNATTRS-NEXT:    ret i1 true
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @c4
; ATTRIBUTOR-SAME: (ptr nofree readnone [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; ATTRIBUTOR-NEXT:    [[BIT:%.*]] = trunc i32 [[TMP2]] to i1
; ATTRIBUTOR-NEXT:    br i1 [[BIT]], label [[L1:%.*]], label [[L0:%.*]]
; ATTRIBUTOR:       l0:
; ATTRIBUTOR-NEXT:    ret i1 false
; ATTRIBUTOR:       l1:
; ATTRIBUTOR-NEXT:    ret i1 true
;
  %tmp = ptrtoint ptr %q to i32
  %tmp2 = lshr i32 %tmp, %bitno
  %bit = trunc i32 %tmp2 to i1
  br i1 %bit, label %l1, label %l0
l0:
  ret i1 0 ; escaping value not caught by def-use chaining.
l1:
  ret i1 1 ; escaping value not caught by def-use chaining.
}

; c4b is c4 but without the escaping part
define i1 @c4b(ptr %q, i32 %bitno) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define noundef i1 @c4b
; FNATTRS-SAME: (ptr [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; FNATTRS-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; FNATTRS-NEXT:    [[BIT:%.*]] = trunc i32 [[TMP2]] to i1
; FNATTRS-NEXT:    br i1 [[BIT]], label [[L1:%.*]], label [[L0:%.*]]
; FNATTRS:       l0:
; FNATTRS-NEXT:    ret i1 false
; FNATTRS:       l1:
; FNATTRS-NEXT:    ret i1 false
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @c4b
; ATTRIBUTOR-SAME: (ptr nofree readnone [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; ATTRIBUTOR-NEXT:    [[BIT:%.*]] = trunc i32 [[TMP2]] to i1
; ATTRIBUTOR-NEXT:    br i1 [[BIT]], label [[L1:%.*]], label [[L0:%.*]]
; ATTRIBUTOR:       l0:
; ATTRIBUTOR-NEXT:    ret i1 false
; ATTRIBUTOR:       l1:
; ATTRIBUTOR-NEXT:    ret i1 false
;
  %tmp = ptrtoint ptr %q to i32
  %tmp2 = lshr i32 %tmp, %bitno
  %bit = trunc i32 %tmp2 to i1
  br i1 %bit, label %l1, label %l0
l0:
  ret i1 0 ; not escaping!
l1:
  ret i1 0 ; not escaping!
}

@lookup_table = global [2 x i1] [ i1 0, i1 1 ]

define i1 @c5(ptr %q, i32 %bitno) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define i1 @c5
; FNATTRS-SAME: (ptr [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR3:[0-9]+]] {
; FNATTRS-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; FNATTRS-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; FNATTRS-NEXT:    [[BIT:%.*]] = and i32 [[TMP2]], 1
; FNATTRS-NEXT:    [[LOOKUP:%.*]] = getelementptr [2 x i1], ptr @lookup_table, i32 0, i32 [[BIT]]
; FNATTRS-NEXT:    [[VAL:%.*]] = load i1, ptr [[LOOKUP]], align 1
; FNATTRS-NEXT:    ret i1 [[VAL]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read)
; ATTRIBUTOR-LABEL: define i1 @c5
; ATTRIBUTOR-SAME: (ptr nofree readonly [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR2:[0-9]+]] {
; ATTRIBUTOR-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; ATTRIBUTOR-NEXT:    [[BIT:%.*]] = and i32 [[TMP2]], 1
; ATTRIBUTOR-NEXT:    [[LOOKUP:%.*]] = getelementptr [2 x i1], ptr @lookup_table, i32 0, i32 [[BIT]]
; ATTRIBUTOR-NEXT:    [[VAL:%.*]] = load i1, ptr [[LOOKUP]], align 1
; ATTRIBUTOR-NEXT:    ret i1 [[VAL]]
;
  %tmp = ptrtoint ptr %q to i32
  %tmp2 = lshr i32 %tmp, %bitno
  %bit = and i32 %tmp2, 1
  ; subtle escape mechanism follows
  %lookup = getelementptr [2 x i1], ptr @lookup_table, i32 0, i32 %bit
  %val = load i1, ptr %lookup
  ret i1 %val
}

declare void @throw_if_bit_set(ptr, i8) readonly

define i1 @c6(ptr %q, i8 %bit) personality ptr @__gxx_personality_v0 {
; FNATTRS: Function Attrs: nofree memory(read)
; FNATTRS-LABEL: define noundef i1 @c6
; FNATTRS-SAME: (ptr readonly [[Q:%.*]], i8 [[BIT:%.*]]) #[[ATTR5:[0-9]+]] personality ptr @__gxx_personality_v0 {
; FNATTRS-NEXT:    invoke void @throw_if_bit_set(ptr [[Q]], i8 [[BIT]])
; FNATTRS-NEXT:            to label [[RET0:%.*]] unwind label [[RET1:%.*]]
; FNATTRS:       ret0:
; FNATTRS-NEXT:    ret i1 false
; FNATTRS:       ret1:
; FNATTRS-NEXT:    [[EXN:%.*]] = landingpad { ptr, i32 }
; FNATTRS-NEXT:            cleanup
; FNATTRS-NEXT:    ret i1 true
;
; ATTRIBUTOR: Function Attrs: nosync memory(read)
; ATTRIBUTOR-LABEL: define i1 @c6
; ATTRIBUTOR-SAME: (ptr readonly [[Q:%.*]], i8 [[BIT:%.*]]) #[[ATTR4:[0-9]+]] personality ptr @__gxx_personality_v0 {
; ATTRIBUTOR-NEXT:    invoke void @throw_if_bit_set(ptr [[Q]], i8 [[BIT]]) #[[ATTR4]]
; ATTRIBUTOR-NEXT:            to label [[RET0:%.*]] unwind label [[RET1:%.*]]
; ATTRIBUTOR:       ret0:
; ATTRIBUTOR-NEXT:    ret i1 false
; ATTRIBUTOR:       ret1:
; ATTRIBUTOR-NEXT:    [[EXN:%.*]] = landingpad { ptr, i32 }
; ATTRIBUTOR-NEXT:            cleanup
; ATTRIBUTOR-NEXT:    ret i1 true
;
  invoke void @throw_if_bit_set(ptr %q, i8 %bit)
  to label %ret0 unwind label %ret1
ret0:
  ret i1 0
ret1:
  %exn = landingpad {ptr, i32}
  cleanup
  ret i1 1
}

declare i32 @__gxx_personality_v0(...)

define ptr @lookup_bit(ptr %q, i32 %bitno) readnone nounwind {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define ptr @lookup_bit
; FNATTRS-SAME: (ptr [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; FNATTRS-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; FNATTRS-NEXT:    [[BIT:%.*]] = and i32 [[TMP2]], 1
; FNATTRS-NEXT:    [[LOOKUP:%.*]] = getelementptr [2 x i1], ptr @lookup_table, i32 0, i32 [[BIT]]
; FNATTRS-NEXT:    ret ptr [[LOOKUP]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define ptr @lookup_bit
; ATTRIBUTOR-SAME: (ptr nofree readnone [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP:%.*]] = ptrtoint ptr [[Q]] to i32
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP]], [[BITNO]]
; ATTRIBUTOR-NEXT:    [[BIT:%.*]] = and i32 [[TMP2]], 1
; ATTRIBUTOR-NEXT:    [[LOOKUP:%.*]] = getelementptr [2 x i1], ptr @lookup_table, i32 0, i32 [[BIT]]
; ATTRIBUTOR-NEXT:    ret ptr [[LOOKUP]]
;
  %tmp = ptrtoint ptr %q to i32
  %tmp2 = lshr i32 %tmp, %bitno
  %bit = and i32 %tmp2, 1
  %lookup = getelementptr [2 x i1], ptr @lookup_table, i32 0, i32 %bit
  ret ptr %lookup
}

define i1 @c7(ptr %q, i32 %bitno) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read, inaccessiblemem: none)
; FNATTRS-LABEL: define i1 @c7
; FNATTRS-SAME: (ptr readonly [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR6:[0-9]+]] {
; FNATTRS-NEXT:    [[PTR:%.*]] = call ptr @lookup_bit(ptr [[Q]], i32 [[BITNO]])
; FNATTRS-NEXT:    [[VAL:%.*]] = load i1, ptr [[PTR]], align 1
; FNATTRS-NEXT:    ret i1 [[VAL]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read)
; ATTRIBUTOR-LABEL: define i1 @c7
; ATTRIBUTOR-SAME: (ptr nofree readonly [[Q:%.*]], i32 [[BITNO:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR-NEXT:    [[PTR:%.*]] = call ptr @lookup_bit(ptr nofree readnone [[Q]], i32 [[BITNO]]) #[[ATTR17:[0-9]+]]
; ATTRIBUTOR-NEXT:    [[VAL:%.*]] = load i1, ptr [[PTR]], align 1
; ATTRIBUTOR-NEXT:    ret i1 [[VAL]]
;
  %ptr = call ptr @lookup_bit(ptr %q, i32 %bitno)
  %val = load i1, ptr %ptr
  ret i1 %val
}


define i32 @nc1(ptr %q, ptr %p, i1 %b) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
; FNATTRS-LABEL: define i32 @nc1
; FNATTRS-SAME: (ptr [[Q:%.*]], ptr nocapture [[P:%.*]], i1 [[B:%.*]]) #[[ATTR7:[0-9]+]] {
; FNATTRS-NEXT:  e:
; FNATTRS-NEXT:    br label [[L:%.*]]
; FNATTRS:       l:
; FNATTRS-NEXT:    [[X:%.*]] = phi ptr [ [[P]], [[E:%.*]] ]
; FNATTRS-NEXT:    [[Y:%.*]] = phi ptr [ [[Q]], [[E]] ]
; FNATTRS-NEXT:    [[TMP2:%.*]] = select i1 [[B]], ptr [[X]], ptr [[Y]]
; FNATTRS-NEXT:    [[VAL:%.*]] = load i32, ptr [[TMP2]], align 4
; FNATTRS-NEXT:    store i32 0, ptr [[X]], align 4
; FNATTRS-NEXT:    store ptr [[Y]], ptr @g, align 8
; FNATTRS-NEXT:    ret i32 [[VAL]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
; ATTRIBUTOR-LABEL: define i32 @nc1
; ATTRIBUTOR-SAME: (ptr nofree [[Q:%.*]], ptr nocapture nofree [[P:%.*]], i1 [[B:%.*]]) #[[ATTR5:[0-9]+]] {
; ATTRIBUTOR-NEXT:  e:
; ATTRIBUTOR-NEXT:    br label [[L:%.*]]
; ATTRIBUTOR:       l:
; ATTRIBUTOR-NEXT:    [[X:%.*]] = phi ptr [ [[P]], [[E:%.*]] ]
; ATTRIBUTOR-NEXT:    [[Y:%.*]] = phi ptr [ [[Q]], [[E]] ]
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = select i1 [[B]], ptr [[X]], ptr [[Y]]
; ATTRIBUTOR-NEXT:    [[VAL:%.*]] = load i32, ptr [[TMP2]], align 4
; ATTRIBUTOR-NEXT:    store i32 0, ptr [[X]], align 4
; ATTRIBUTOR-NEXT:    store ptr [[Y]], ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret i32 [[VAL]]
;
e:
  br label %l
l:
  %x = phi ptr [ %p, %e ]
  %y = phi ptr [ %q, %e ]
  %tmp2 = select i1 %b, ptr %x, ptr %y
  %val = load i32, ptr %tmp2		; <i32> [#uses=1]
  store i32 0, ptr %x
  store ptr %y, ptr @g
  ret i32 %val
}

define i32 @nc1_addrspace(ptr %q, ptr addrspace(1) %p, i1 %b) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
; FNATTRS-LABEL: define i32 @nc1_addrspace
; FNATTRS-SAME: (ptr [[Q:%.*]], ptr addrspace(1) nocapture [[P:%.*]], i1 [[B:%.*]]) #[[ATTR7]] {
; FNATTRS-NEXT:  e:
; FNATTRS-NEXT:    br label [[L:%.*]]
; FNATTRS:       l:
; FNATTRS-NEXT:    [[X:%.*]] = phi ptr addrspace(1) [ [[P]], [[E:%.*]] ]
; FNATTRS-NEXT:    [[Y:%.*]] = phi ptr [ [[Q]], [[E]] ]
; FNATTRS-NEXT:    [[TMP:%.*]] = addrspacecast ptr addrspace(1) [[X]] to ptr
; FNATTRS-NEXT:    [[TMP2:%.*]] = select i1 [[B]], ptr [[TMP]], ptr [[Y]]
; FNATTRS-NEXT:    [[VAL:%.*]] = load i32, ptr [[TMP2]], align 4
; FNATTRS-NEXT:    store i32 0, ptr [[TMP]], align 4
; FNATTRS-NEXT:    store ptr [[Y]], ptr @g, align 8
; FNATTRS-NEXT:    ret i32 [[VAL]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
; ATTRIBUTOR-LABEL: define i32 @nc1_addrspace
; ATTRIBUTOR-SAME: (ptr nofree [[Q:%.*]], ptr addrspace(1) nocapture nofree [[P:%.*]], i1 [[B:%.*]]) #[[ATTR5]] {
; ATTRIBUTOR-NEXT:  e:
; ATTRIBUTOR-NEXT:    br label [[L:%.*]]
; ATTRIBUTOR:       l:
; ATTRIBUTOR-NEXT:    [[X:%.*]] = phi ptr addrspace(1) [ [[P]], [[E:%.*]] ]
; ATTRIBUTOR-NEXT:    [[Y:%.*]] = phi ptr [ [[Q]], [[E]] ]
; ATTRIBUTOR-NEXT:    [[TMP:%.*]] = addrspacecast ptr addrspace(1) [[X]] to ptr
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = select i1 [[B]], ptr [[TMP]], ptr [[Y]]
; ATTRIBUTOR-NEXT:    [[VAL:%.*]] = load i32, ptr [[TMP2]], align 4
; ATTRIBUTOR-NEXT:    store i32 0, ptr [[TMP]], align 4
; ATTRIBUTOR-NEXT:    store ptr [[Y]], ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret i32 [[VAL]]
;
e:
  br label %l
l:
  %x = phi ptr addrspace(1) [ %p, %e ]
  %y = phi ptr [ %q, %e ]
  %tmp = addrspacecast ptr addrspace(1) %x to ptr		; <ptr> [#uses=2]
  %tmp2 = select i1 %b, ptr %tmp, ptr %y
  %val = load i32, ptr %tmp2		; <i32> [#uses=1]
  store i32 0, ptr %tmp
  store ptr %y, ptr @g
  ret i32 %val
}

define void @nc2(ptr %p, ptr %q) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, inaccessiblemem: none)
; FNATTRS-LABEL: define void @nc2
; FNATTRS-SAME: (ptr nocapture [[P:%.*]], ptr [[Q:%.*]]) #[[ATTR7]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = call i32 @nc1(ptr [[Q]], ptr [[P]], i1 false)
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
; ATTRIBUTOR-LABEL: define void @nc2
; ATTRIBUTOR-SAME: (ptr nocapture nofree [[P:%.*]], ptr nofree [[Q:%.*]]) #[[ATTR5]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = call i32 @nc1(ptr nofree [[Q]], ptr nocapture nofree [[P]], i1 false) #[[ATTR18:[0-9]+]]
; ATTRIBUTOR-NEXT:    ret void
;
  %1 = call i32 @nc1(ptr %q, ptr %p, i1 0)		; <i32> [#uses=0]
  ret void
}


define void @nc3(ptr %p) {
; FNATTRS-LABEL: define void @nc3
; FNATTRS-SAME: (ptr nocapture readonly [[P:%.*]]) {
; FNATTRS-NEXT:    call void [[P]]()
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @nc3
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void [[P]]()
; ATTRIBUTOR-NEXT:    ret void
;
  call void %p()
  ret void
}

declare void @external(ptr) readonly nounwind
define void @nc4(ptr %p) {
; FNATTRS: Function Attrs: nofree nounwind memory(read)
; FNATTRS-LABEL: define void @nc4
; FNATTRS-SAME: (ptr nocapture readonly [[P:%.*]]) #[[ATTR9:[0-9]+]] {
; FNATTRS-NEXT:    call void @external(ptr [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: nosync nounwind memory(read)
; ATTRIBUTOR-LABEL: define void @nc4
; ATTRIBUTOR-SAME: (ptr nocapture readonly [[P:%.*]]) #[[ATTR7:[0-9]+]] {
; ATTRIBUTOR-NEXT:    call void @external(ptr nocapture readonly [[P]]) #[[ATTR4]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @external(ptr %p)
  ret void
}

define void @nc5(ptr %f, ptr %p) {
; FNATTRS-LABEL: define void @nc5
; FNATTRS-SAME: (ptr nocapture readonly [[F:%.*]], ptr nocapture [[P:%.*]]) {
; FNATTRS-NEXT:    call void [[F]](ptr [[P]]) #[[ATTR8:[0-9]+]]
; FNATTRS-NEXT:    call void [[F]](ptr nocapture [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @nc5
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[F:%.*]], ptr nocapture [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void [[F]](ptr [[P]]) #[[ATTR6:[0-9]+]]
; ATTRIBUTOR-NEXT:    call void [[F]](ptr nocapture [[P]])
; ATTRIBUTOR-NEXT:    ret void
;
  call void %f(ptr %p) readonly nounwind
  call void %f(ptr nocapture %p)
  ret void
}

; It would be acceptable to add readnone to %y1_1 and %y1_2.
define void @test1_1(ptr %x1_1, ptr %y1_1, i1 %c) {
; FNATTRS: Function Attrs: nofree nosync nounwind memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define void @test1_1
; FNATTRS-SAME: (ptr nocapture readnone [[X1_1:%.*]], ptr [[Y1_1:%.*]], i1 [[C:%.*]]) #[[ATTR10:[0-9]+]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = call ptr @test1_2(ptr [[X1_1]], ptr [[Y1_1]], i1 [[C]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: nofree nosync nounwind memory(write)
; ATTRIBUTOR-LABEL: define void @test1_1
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[X1_1:%.*]], ptr nocapture nofree readnone [[Y1_1:%.*]], i1 [[C:%.*]]) #[[ATTR8:[0-9]+]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = call ptr @test1_2(ptr nocapture nofree readnone [[X1_1]], ptr nofree readnone [[Y1_1]], i1 [[C]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  call ptr @test1_2(ptr %x1_1, ptr %y1_1, i1 %c)
  store ptr null, ptr @g
  ret void
}

define ptr @test1_2(ptr %x1_2, ptr %y1_2, i1 %c) {
; FNATTRS: Function Attrs: nofree nosync nounwind memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define ptr @test1_2
; FNATTRS-SAME: (ptr nocapture readnone [[X1_2:%.*]], ptr returned [[Y1_2:%.*]], i1 [[C:%.*]]) #[[ATTR10]] {
; FNATTRS-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; FNATTRS:       t:
; FNATTRS-NEXT:    call void @test1_1(ptr [[X1_2]], ptr [[Y1_2]], i1 [[C]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    br label [[F]]
; FNATTRS:       f:
; FNATTRS-NEXT:    ret ptr [[Y1_2]]
;
; ATTRIBUTOR: Function Attrs: nofree nosync nounwind memory(write)
; ATTRIBUTOR-LABEL: define ptr @test1_2
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[X1_2:%.*]], ptr nofree readnone [[Y1_2:%.*]], i1 [[C:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; ATTRIBUTOR:       t:
; ATTRIBUTOR-NEXT:    call void @test1_1(ptr nocapture nofree readnone [[X1_2]], ptr nocapture nofree readnone [[Y1_2]], i1 [[C]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    br label [[F]]
; ATTRIBUTOR:       f:
; ATTRIBUTOR-NEXT:    ret ptr [[Y1_2]]
;
  br i1 %c, label %t, label %f
t:
  call void @test1_1(ptr %x1_2, ptr %y1_2, i1 %c)
  store ptr null, ptr @g
  br label %f
f:
  ret ptr %y1_2
}

define void @test2(ptr %x2) {
; FNATTRS: Function Attrs: nofree nosync nounwind memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define void @test2
; FNATTRS-SAME: (ptr nocapture readnone [[X2:%.*]]) #[[ATTR10]] {
; FNATTRS-NEXT:    call void @test2(ptr [[X2]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: nofree nosync nounwind memory(write)
; ATTRIBUTOR-LABEL: define void @test2
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[X2:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    call void @test2(ptr nocapture nofree readnone [[X2]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  call void @test2(ptr %x2)
  store ptr null, ptr @g
  ret void
}

define void @test3(ptr %x3, ptr %y3, ptr %z3) {
; FNATTRS: Function Attrs: nofree nosync nounwind memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define void @test3
; FNATTRS-SAME: (ptr nocapture readnone [[X3:%.*]], ptr nocapture readnone [[Y3:%.*]], ptr nocapture readnone [[Z3:%.*]]) #[[ATTR10]] {
; FNATTRS-NEXT:    call void @test3(ptr [[Z3]], ptr [[Y3]], ptr [[X3]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: nofree nosync nounwind memory(write)
; ATTRIBUTOR-LABEL: define void @test3
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[X3:%.*]], ptr nocapture nofree readnone [[Y3:%.*]], ptr nocapture nofree readnone [[Z3:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    call void @test3(ptr nocapture nofree readnone [[Z3]], ptr nocapture nofree readnone [[Y3]], ptr nocapture nofree readnone [[X3]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  call void @test3(ptr %z3, ptr %y3, ptr %x3)
  store ptr null, ptr @g
  ret void
}

define void @test4_1(ptr %x4_1, i1 %c) {
; FNATTRS: Function Attrs: nofree nosync nounwind memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define void @test4_1
; FNATTRS-SAME: (ptr [[X4_1:%.*]], i1 [[C:%.*]]) #[[ATTR10]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = call ptr @test4_2(ptr [[X4_1]], ptr [[X4_1]], ptr [[X4_1]], i1 [[C]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: nofree nosync nounwind memory(write)
; ATTRIBUTOR-LABEL: define void @test4_1
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[X4_1:%.*]], i1 [[C:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = call ptr @test4_2(ptr nocapture nofree readnone [[X4_1]], ptr nofree readnone [[X4_1]], ptr nocapture nofree readnone [[X4_1]], i1 [[C]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  call ptr @test4_2(ptr %x4_1, ptr %x4_1, ptr %x4_1, i1 %c)
  store ptr null, ptr @g
  ret void
}

define ptr @test4_2(ptr %x4_2, ptr %y4_2, ptr %z4_2, i1 %c) {
; FNATTRS: Function Attrs: nofree nosync nounwind memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define ptr @test4_2
; FNATTRS-SAME: (ptr nocapture readnone [[X4_2:%.*]], ptr readnone returned [[Y4_2:%.*]], ptr nocapture readnone [[Z4_2:%.*]], i1 [[C:%.*]]) #[[ATTR10]] {
; FNATTRS-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; FNATTRS:       t:
; FNATTRS-NEXT:    call void @test4_1(ptr null, i1 [[C]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    br label [[F]]
; FNATTRS:       f:
; FNATTRS-NEXT:    ret ptr [[Y4_2]]
;
; ATTRIBUTOR: Function Attrs: nofree nosync nounwind memory(write)
; ATTRIBUTOR-LABEL: define ptr @test4_2
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[X4_2:%.*]], ptr nofree readnone [[Y4_2:%.*]], ptr nocapture nofree readnone [[Z4_2:%.*]], i1 [[C:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; ATTRIBUTOR:       t:
; ATTRIBUTOR-NEXT:    call void @test4_1(ptr nofree readnone null, i1 [[C]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    br label [[F]]
; ATTRIBUTOR:       f:
; ATTRIBUTOR-NEXT:    ret ptr [[Y4_2]]
;
  br i1 %c, label %t, label %f
t:
  call void @test4_1(ptr null, i1 %c)
  store ptr null, ptr @g
  br label %f
f:
  ret ptr %y4_2
}

declare ptr @test5_1(ptr %x5_1)

define void @test5_2(ptr %x5_2) {
; COMMON-LABEL: define void @test5_2
; COMMON-SAME: (ptr [[X5_2:%.*]]) {
; COMMON-NEXT:    [[TMP1:%.*]] = call ptr @test5_1(ptr [[X5_2]])
; COMMON-NEXT:    store ptr null, ptr @g, align 8
; COMMON-NEXT:    ret void
;
  call ptr @test5_1(ptr %x5_2)
  store ptr null, ptr @g
  ret void
}

declare void @test6_1(ptr %x6_1, ptr nocapture %y6_1, ...)

define void @test6_2(ptr %x6_2, ptr %y6_2, ptr %z6_2) {
; FNATTRS-LABEL: define void @test6_2
; FNATTRS-SAME: (ptr [[X6_2:%.*]], ptr nocapture [[Y6_2:%.*]], ptr [[Z6_2:%.*]]) {
; FNATTRS-NEXT:    call void (ptr, ptr, ...) @test6_1(ptr [[X6_2]], ptr [[Y6_2]], ptr [[Z6_2]])
; FNATTRS-NEXT:    store ptr null, ptr @g, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @test6_2
; ATTRIBUTOR-SAME: (ptr [[X6_2:%.*]], ptr nocapture [[Y6_2:%.*]], ptr [[Z6_2:%.*]]) {
; ATTRIBUTOR-NEXT:    call void (ptr, ptr, ...) @test6_1(ptr [[X6_2]], ptr nocapture [[Y6_2]], ptr [[Z6_2]])
; ATTRIBUTOR-NEXT:    store ptr null, ptr @g, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  call void (ptr, ptr, ...) @test6_1(ptr %x6_2, ptr %y6_2, ptr %z6_2)
  store ptr null, ptr @g
  ret void
}

define void @test_cmpxchg(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; FNATTRS-LABEL: define void @test_cmpxchg
; FNATTRS-SAME: (ptr nocapture [[P:%.*]]) #[[ATTR11:[0-9]+]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = cmpxchg ptr [[P]], i32 0, i32 1 acquire monotonic, align 4
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define void @test_cmpxchg
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[P:%.*]]) #[[ATTR9:[0-9]+]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = cmpxchg ptr [[P]], i32 0, i32 1 acquire monotonic, align 4
; ATTRIBUTOR-NEXT:    ret void
;
  cmpxchg ptr %p, i32 0, i32 1 acquire monotonic
  ret void
}

define void @test_cmpxchg_ptr(ptr %p, ptr %q) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; FNATTRS-LABEL: define void @test_cmpxchg_ptr
; FNATTRS-SAME: (ptr nocapture [[P:%.*]], ptr [[Q:%.*]]) #[[ATTR11]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = cmpxchg ptr [[P]], ptr null, ptr [[Q]] acquire monotonic, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define void @test_cmpxchg_ptr
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[P:%.*]], ptr nofree [[Q:%.*]]) #[[ATTR9]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = cmpxchg ptr [[P]], ptr null, ptr [[Q]] acquire monotonic, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  cmpxchg ptr %p, ptr null, ptr %q acquire monotonic
  ret void
}

define void @test_atomicrmw(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; FNATTRS-LABEL: define void @test_atomicrmw
; FNATTRS-SAME: (ptr nocapture [[P:%.*]]) #[[ATTR11]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[P]], i32 1 seq_cst, align 4
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define void @test_atomicrmw
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[P:%.*]]) #[[ATTR9]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[P]], i32 1 seq_cst, align 4
; ATTRIBUTOR-NEXT:    ret void
;
  atomicrmw add ptr %p, i32 1 seq_cst
  ret void
}

define void @test_volatile(ptr %x) {
; FNATTRS: Function Attrs: nofree norecurse nounwind memory(argmem: readwrite, inaccessiblemem: readwrite)
; FNATTRS-LABEL: define void @test_volatile
; FNATTRS-SAME: (ptr [[X:%.*]]) #[[ATTR12:[0-9]+]] {
; FNATTRS-NEXT:  entry:
; FNATTRS-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr [[X]], i64 1
; FNATTRS-NEXT:    store volatile i32 0, ptr [[GEP]], align 4
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define void @test_volatile
; ATTRIBUTOR-SAME: (ptr nofree [[X:%.*]]) #[[ATTR9]] {
; ATTRIBUTOR-NEXT:  entry:
; ATTRIBUTOR-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr [[X]], i64 1
; ATTRIBUTOR-NEXT:    store volatile i32 0, ptr [[GEP]], align 4
; ATTRIBUTOR-NEXT:    ret void
;
entry:
  %gep = getelementptr i32, ptr %x, i64 1
  store volatile i32 0, ptr %gep, align 4
  ret void
}

define void @nocaptureLaunder(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write, inaccessiblemem: readwrite)
; FNATTRS-LABEL: define void @nocaptureLaunder
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR13:[0-9]+]] {
; FNATTRS-NEXT:  entry:
; FNATTRS-NEXT:    [[B:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[P]])
; FNATTRS-NEXT:    store i8 42, ptr [[B]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
; ATTRIBUTOR-LABEL: define void @nocaptureLaunder
; ATTRIBUTOR-SAME: (ptr nocapture nofree [[P:%.*]]) #[[ATTR10:[0-9]+]] {
; ATTRIBUTOR-NEXT:  entry:
; ATTRIBUTOR-NEXT:    [[B:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[P]]) #[[ATTR19:[0-9]+]]
; ATTRIBUTOR-NEXT:    store i8 42, ptr [[B]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
entry:
  %b = call ptr @llvm.launder.invariant.group.p0(ptr %p)
  store i8 42, ptr %b
  ret void
}

@g2 = global ptr null
define void @captureLaunder(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: readwrite)
; FNATTRS-LABEL: define void @captureLaunder
; FNATTRS-SAME: (ptr [[P:%.*]]) #[[ATTR14:[0-9]+]] {
; FNATTRS-NEXT:    [[B:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[P]])
; FNATTRS-NEXT:    store ptr [[B]], ptr @g2, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
; ATTRIBUTOR-LABEL: define void @captureLaunder
; ATTRIBUTOR-SAME: (ptr nofree [[P:%.*]]) #[[ATTR5]] {
; ATTRIBUTOR-NEXT:    [[B:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[P]]) #[[ATTR19]]
; ATTRIBUTOR-NEXT:    store ptr [[B]], ptr @g2, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  %b = call ptr @llvm.launder.invariant.group.p0(ptr %p)
  store ptr %b, ptr @g2
  ret void
}

define void @nocaptureStrip(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; FNATTRS-LABEL: define void @nocaptureStrip
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR15:[0-9]+]] {
; FNATTRS-NEXT:  entry:
; FNATTRS-NEXT:    [[B:%.*]] = call ptr @llvm.strip.invariant.group.p0(ptr [[P]])
; FNATTRS-NEXT:    store i8 42, ptr [[B]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; ATTRIBUTOR-LABEL: define void @nocaptureStrip
; ATTRIBUTOR-SAME: (ptr nocapture nofree writeonly [[P:%.*]]) #[[ATTR11:[0-9]+]] {
; ATTRIBUTOR-NEXT:  entry:
; ATTRIBUTOR-NEXT:    [[B:%.*]] = call ptr @llvm.strip.invariant.group.p0(ptr [[P]]) #[[ATTR17]]
; ATTRIBUTOR-NEXT:    store i8 42, ptr [[B]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
entry:
  %b = call ptr @llvm.strip.invariant.group.p0(ptr %p)
  store i8 42, ptr %b
  ret void
}

@g3 = global ptr null
define void @captureStrip(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define void @captureStrip
; FNATTRS-SAME: (ptr [[P:%.*]]) #[[ATTR1]] {
; FNATTRS-NEXT:    [[B:%.*]] = call ptr @llvm.strip.invariant.group.p0(ptr [[P]])
; FNATTRS-NEXT:    store ptr [[B]], ptr @g3, align 8
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; ATTRIBUTOR-LABEL: define void @captureStrip
; ATTRIBUTOR-SAME: (ptr nofree writeonly [[P:%.*]]) #[[ATTR1]] {
; ATTRIBUTOR-NEXT:    [[B:%.*]] = call ptr @llvm.strip.invariant.group.p0(ptr [[P]]) #[[ATTR17]]
; ATTRIBUTOR-NEXT:    store ptr [[B]], ptr @g3, align 8
; ATTRIBUTOR-NEXT:    ret void
;
  %b = call ptr @llvm.strip.invariant.group.p0(ptr %p)
  store ptr %b, ptr @g3
  ret void
}

define i1 @captureICmp(ptr %x) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define i1 @captureICmp
; FNATTRS-SAME: (ptr readnone [[X:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = icmp eq ptr [[X]], null
; FNATTRS-NEXT:    ret i1 [[TMP1]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @captureICmp
; ATTRIBUTOR-SAME: (ptr nofree readnone [[X:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = icmp eq ptr [[X]], null
; ATTRIBUTOR-NEXT:    ret i1 [[TMP1]]
;
  %1 = icmp eq ptr %x, null
  ret i1 %1
}

define i1 @captureICmpRev(ptr %x) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define i1 @captureICmpRev
; FNATTRS-SAME: (ptr readnone [[X:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = icmp eq ptr null, [[X]]
; FNATTRS-NEXT:    ret i1 [[TMP1]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @captureICmpRev
; ATTRIBUTOR-SAME: (ptr nofree readnone [[X:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = icmp eq ptr null, [[X]]
; ATTRIBUTOR-NEXT:    ret i1 [[TMP1]]
;
  %1 = icmp eq ptr null, %x
  ret i1 %1
}

define i1 @nocaptureInboundsGEPICmp(ptr %x) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define i1 @nocaptureInboundsGEPICmp
; FNATTRS-SAME: (ptr readnone [[X:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[X]], i32 5
; FNATTRS-NEXT:    [[TMP2:%.*]] = icmp eq ptr [[TMP1]], null
; FNATTRS-NEXT:    ret i1 [[TMP2]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @nocaptureInboundsGEPICmp
; ATTRIBUTOR-SAME: (ptr nofree readnone [[X:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[X]], i32 5
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = icmp eq ptr [[TMP1]], null
; ATTRIBUTOR-NEXT:    ret i1 [[TMP2]]
;
  %1 = getelementptr inbounds i32, ptr %x, i32 5
  %2 = icmp eq ptr %1, null
  ret i1 %2
}

define i1 @nocaptureInboundsGEPICmpRev(ptr %x) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define i1 @nocaptureInboundsGEPICmpRev
; FNATTRS-SAME: (ptr readnone [[X:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[X]], i32 5
; FNATTRS-NEXT:    [[TMP2:%.*]] = icmp eq ptr null, [[TMP1]]
; FNATTRS-NEXT:    ret i1 [[TMP2]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @nocaptureInboundsGEPICmpRev
; ATTRIBUTOR-SAME: (ptr nofree readnone [[X:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[X]], i32 5
; ATTRIBUTOR-NEXT:    [[TMP2:%.*]] = icmp eq ptr null, [[TMP1]]
; ATTRIBUTOR-NEXT:    ret i1 [[TMP2]]
;
  %1 = getelementptr inbounds i32, ptr %x, i32 5
  %2 = icmp eq ptr null, %1
  ret i1 %2
}

define i1 @nocaptureDereferenceableOrNullICmp(ptr dereferenceable_or_null(4) %x) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define noundef i1 @nocaptureDereferenceableOrNullICmp
; FNATTRS-SAME: (ptr nocapture readnone dereferenceable_or_null(4) [[X:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = icmp eq ptr [[X]], null
; FNATTRS-NEXT:    ret i1 [[TMP1]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @nocaptureDereferenceableOrNullICmp
; ATTRIBUTOR-SAME: (ptr nofree readnone dereferenceable_or_null(4) [[X:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = icmp eq ptr [[X]], null
; ATTRIBUTOR-NEXT:    ret i1 [[TMP1]]
;
  %1 = icmp eq ptr %x, null
  ret i1 %1
}

define i1 @captureDereferenceableOrNullICmp(ptr dereferenceable_or_null(4) %x) null_pointer_is_valid {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind null_pointer_is_valid willreturn memory(none)
; FNATTRS-LABEL: define noundef i1 @captureDereferenceableOrNullICmp
; FNATTRS-SAME: (ptr readnone dereferenceable_or_null(4) [[X:%.*]]) #[[ATTR16:[0-9]+]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = icmp eq ptr [[X]], null
; FNATTRS-NEXT:    ret i1 [[TMP1]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind null_pointer_is_valid willreturn memory(none)
; ATTRIBUTOR-LABEL: define i1 @captureDereferenceableOrNullICmp
; ATTRIBUTOR-SAME: (ptr nofree readnone dereferenceable_or_null(4) [[X:%.*]]) #[[ATTR12:[0-9]+]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = icmp eq ptr [[X]], null
; ATTRIBUTOR-NEXT:    ret i1 [[TMP1]]
;
  %1 = icmp eq ptr %x, null
  ret i1 %1
}

declare void @capture(ptr)

define void @nocapture_fptr(ptr %f, ptr %p) {
; FNATTRS-LABEL: define void @nocapture_fptr
; FNATTRS-SAME: (ptr nocapture readonly [[F:%.*]], ptr [[P:%.*]]) {
; FNATTRS-NEXT:    [[RES:%.*]] = call ptr [[F]](ptr [[P]])
; FNATTRS-NEXT:    call void @capture(ptr [[RES]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @nocapture_fptr
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[F:%.*]], ptr [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    [[RES:%.*]] = call ptr [[F]](ptr [[P]])
; ATTRIBUTOR-NEXT:    call void @capture(ptr [[RES]])
; ATTRIBUTOR-NEXT:    ret void
;
  %res = call ptr %f(ptr %p)
  call void @capture(ptr %res)
  ret void
}

define void @recurse_fptr(ptr %f, ptr %p) {
; FNATTRS-LABEL: define void @recurse_fptr
; FNATTRS-SAME: (ptr nocapture readonly [[F:%.*]], ptr [[P:%.*]]) {
; FNATTRS-NEXT:    [[RES:%.*]] = call ptr [[F]](ptr [[P]])
; FNATTRS-NEXT:    store i8 0, ptr [[RES]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @recurse_fptr
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[F:%.*]], ptr [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    [[RES:%.*]] = call ptr [[F]](ptr [[P]])
; ATTRIBUTOR-NEXT:    store i8 0, ptr [[RES]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
  %res = call ptr %f(ptr %p)
  store i8 0, ptr %res
  ret void
}

define void @readnone_indirec(ptr %f, ptr %p) {
; FNATTRS: Function Attrs: nofree nosync memory(none)
; FNATTRS-LABEL: define void @readnone_indirec
; FNATTRS-SAME: (ptr nocapture readonly [[F:%.*]], ptr readnone [[P:%.*]]) #[[ATTR17:[0-9]+]] {
; FNATTRS-NEXT:    call void [[F]](ptr [[P]]) #[[ATTR20:[0-9]+]]
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: nosync memory(none)
; ATTRIBUTOR-LABEL: define void @readnone_indirec
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull readnone [[F:%.*]], ptr readnone [[P:%.*]]) #[[ATTR13:[0-9]+]] {
; ATTRIBUTOR-NEXT:    call void [[F]](ptr [[P]]) #[[ATTR20:[0-9]+]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void %f(ptr %p) readnone
  ret void
}


declare ptr @llvm.launder.invariant.group.p0(ptr)
declare ptr @llvm.strip.invariant.group.p0(ptr)

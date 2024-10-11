; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64-unknown-linux-gnu < %s | FileCheck %s

define i8 @atomicrmw_usub_cond_i8(ptr %ptr, i8 %val) {
; CHECK-LABEL: atomicrmw_usub_cond_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    mr 5, 3
; CHECK-NEXT:    rlwinm 7, 5, 3, 27, 28
; CHECK-NEXT:    lbz 3, 0(3)
; CHECK-NEXT:    xori 7, 7, 24
; CHECK-NEXT:    li 8, 255
; CHECK-NEXT:    clrlwi 6, 4, 24
; CHECK-NEXT:    rldicr 5, 5, 0, 61
; CHECK-NEXT:    slw 8, 8, 7
; CHECK-NEXT:    b .LBB0_2
; CHECK-NEXT:  .LBB0_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    srw 3, 11, 7
; CHECK-NEXT:    cmplw 3, 9
; CHECK-NEXT:    beq 0, .LBB0_7
; CHECK-NEXT:  .LBB0_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB0_5 Depth 2
; CHECK-NEXT:    clrlwi 9, 3, 24
; CHECK-NEXT:    cmplw 9, 6
; CHECK-NEXT:    blt 0, .LBB0_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    sub 3, 3, 4
; CHECK-NEXT:  .LBB0_4: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    slw 3, 3, 7
; CHECK-NEXT:    slw 10, 9, 7
; CHECK-NEXT:    and 3, 3, 8
; CHECK-NEXT:    and 10, 10, 8
; CHECK-NEXT:  .LBB0_5: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB0_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    lwarx 12, 0, 5
; CHECK-NEXT:    and 11, 12, 8
; CHECK-NEXT:    cmpw 11, 10
; CHECK-NEXT:    bne 0, .LBB0_1
; CHECK-NEXT:  # %bb.6: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    andc 12, 12, 8
; CHECK-NEXT:    or 12, 12, 3
; CHECK-NEXT:    stwcx. 12, 0, 5
; CHECK-NEXT:    bne 0, .LBB0_5
; CHECK-NEXT:    b .LBB0_1
; CHECK-NEXT:  .LBB0_7: # %atomicrmw.end
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_cond ptr %ptr, i8 %val seq_cst
  ret i8 %result
}

define i16 @atomicrmw_usub_cond_i16(ptr %ptr, i16 %val) {
; CHECK-LABEL: atomicrmw_usub_cond_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    mr 5, 3
; CHECK-NEXT:    li 8, 0
; CHECK-NEXT:    lhz 3, 0(3)
; CHECK-NEXT:    rlwinm 7, 5, 3, 27, 27
; CHECK-NEXT:    xori 7, 7, 16
; CHECK-NEXT:    ori 8, 8, 65535
; CHECK-NEXT:    clrlwi 6, 4, 16
; CHECK-NEXT:    rldicr 5, 5, 0, 61
; CHECK-NEXT:    slw 8, 8, 7
; CHECK-NEXT:    b .LBB1_2
; CHECK-NEXT:  .LBB1_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    srw 3, 11, 7
; CHECK-NEXT:    cmplw 3, 9
; CHECK-NEXT:    beq 0, .LBB1_7
; CHECK-NEXT:  .LBB1_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB1_5 Depth 2
; CHECK-NEXT:    clrlwi 9, 3, 16
; CHECK-NEXT:    cmplw 9, 6
; CHECK-NEXT:    blt 0, .LBB1_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    sub 3, 3, 4
; CHECK-NEXT:  .LBB1_4: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    slw 3, 3, 7
; CHECK-NEXT:    slw 10, 9, 7
; CHECK-NEXT:    and 3, 3, 8
; CHECK-NEXT:    and 10, 10, 8
; CHECK-NEXT:  .LBB1_5: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB1_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    lwarx 12, 0, 5
; CHECK-NEXT:    and 11, 12, 8
; CHECK-NEXT:    cmpw 11, 10
; CHECK-NEXT:    bne 0, .LBB1_1
; CHECK-NEXT:  # %bb.6: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    andc 12, 12, 8
; CHECK-NEXT:    or 12, 12, 3
; CHECK-NEXT:    stwcx. 12, 0, 5
; CHECK-NEXT:    bne 0, .LBB1_5
; CHECK-NEXT:    b .LBB1_1
; CHECK-NEXT:  .LBB1_7: # %atomicrmw.end
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_cond ptr %ptr, i16 %val seq_cst
  ret i16 %result
}

define i32 @atomicrmw_usub_cond_i32(ptr %ptr, i32 %val) {
; CHECK-LABEL: atomicrmw_usub_cond_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    lwz 6, 0(3)
; CHECK-NEXT:    b .LBB2_2
; CHECK-NEXT:  .LBB2_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    cmplw 5, 6
; CHECK-NEXT:    mr 6, 5
; CHECK-NEXT:    beq 0, .LBB2_7
; CHECK-NEXT:  .LBB2_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB2_5 Depth 2
; CHECK-NEXT:    cmplw 6, 4
; CHECK-NEXT:    bge 0, .LBB2_4
; CHECK-NEXT:  # %bb.3: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    mr 7, 6
; CHECK-NEXT:    b .LBB2_5
; CHECK-NEXT:  .LBB2_4:
; CHECK-NEXT:    sub 7, 6, 4
; CHECK-NEXT:  .LBB2_5: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB2_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    lwarx 5, 0, 3
; CHECK-NEXT:    cmpw 5, 6
; CHECK-NEXT:    bne 0, .LBB2_1
; CHECK-NEXT:  # %bb.6: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    stwcx. 7, 0, 3
; CHECK-NEXT:    bne 0, .LBB2_5
; CHECK-NEXT:    b .LBB2_1
; CHECK-NEXT:  .LBB2_7: # %atomicrmw.end
; CHECK-NEXT:    mr 3, 5
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_cond ptr %ptr, i32 %val seq_cst
  ret i32 %result
}

define i64 @atomicrmw_usub_cond_i64(ptr %ptr, i64 %val) {
; CHECK-LABEL: atomicrmw_usub_cond_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    ld 6, 0(3)
; CHECK-NEXT:    b .LBB3_2
; CHECK-NEXT:  .LBB3_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    cmpld 5, 6
; CHECK-NEXT:    mr 6, 5
; CHECK-NEXT:    beq 0, .LBB3_7
; CHECK-NEXT:  .LBB3_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB3_5 Depth 2
; CHECK-NEXT:    cmpld 6, 4
; CHECK-NEXT:    bge 0, .LBB3_4
; CHECK-NEXT:  # %bb.3: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    mr 7, 6
; CHECK-NEXT:    b .LBB3_5
; CHECK-NEXT:  .LBB3_4:
; CHECK-NEXT:    sub 7, 6, 4
; CHECK-NEXT:  .LBB3_5: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB3_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    ldarx 5, 0, 3
; CHECK-NEXT:    cmpd 5, 6
; CHECK-NEXT:    bne 0, .LBB3_1
; CHECK-NEXT:  # %bb.6: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    stdcx. 7, 0, 3
; CHECK-NEXT:    bne 0, .LBB3_5
; CHECK-NEXT:    b .LBB3_1
; CHECK-NEXT:  .LBB3_7: # %atomicrmw.end
; CHECK-NEXT:    mr 3, 5
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_cond ptr %ptr, i64 %val seq_cst
  ret i64 %result
}

define i8 @atomicrmw_usub_sat_i8(ptr %ptr, i8 %val) {
; CHECK-LABEL: atomicrmw_usub_sat_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    mr 5, 3
; CHECK-NEXT:    rlwinm 6, 5, 3, 27, 28
; CHECK-NEXT:    lbz 3, 0(3)
; CHECK-NEXT:    xori 6, 6, 24
; CHECK-NEXT:    li 7, 255
; CHECK-NEXT:    clrlwi 4, 4, 24
; CHECK-NEXT:    rldicr 5, 5, 0, 61
; CHECK-NEXT:    slw 7, 7, 6
; CHECK-NEXT:    b .LBB4_2
; CHECK-NEXT:  .LBB4_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    srw 3, 10, 6
; CHECK-NEXT:    cmplw 3, 8
; CHECK-NEXT:    beq 0, .LBB4_7
; CHECK-NEXT:  .LBB4_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB4_5 Depth 2
; CHECK-NEXT:    clrlwi 8, 3, 24
; CHECK-NEXT:    sub 3, 8, 4
; CHECK-NEXT:    cmplw 3, 8
; CHECK-NEXT:    li 9, 0
; CHECK-NEXT:    bgt 0, .LBB4_4
; CHECK-NEXT:  # %bb.3: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    mr 9, 3
; CHECK-NEXT:  .LBB4_4: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    slw 3, 9, 6
; CHECK-NEXT:    slw 9, 8, 6
; CHECK-NEXT:    and 3, 3, 7
; CHECK-NEXT:    and 9, 9, 7
; CHECK-NEXT:  .LBB4_5: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB4_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    lwarx 11, 0, 5
; CHECK-NEXT:    and 10, 11, 7
; CHECK-NEXT:    cmpw 10, 9
; CHECK-NEXT:    bne 0, .LBB4_1
; CHECK-NEXT:  # %bb.6: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    andc 11, 11, 7
; CHECK-NEXT:    or 11, 11, 3
; CHECK-NEXT:    stwcx. 11, 0, 5
; CHECK-NEXT:    bne 0, .LBB4_5
; CHECK-NEXT:    b .LBB4_1
; CHECK-NEXT:  .LBB4_7: # %atomicrmw.end
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_sat ptr %ptr, i8 %val seq_cst
  ret i8 %result
}

define i16 @atomicrmw_usub_sat_i16(ptr %ptr, i16 %val) {
; CHECK-LABEL: atomicrmw_usub_sat_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    mr 5, 3
; CHECK-NEXT:    li 7, 0
; CHECK-NEXT:    lhz 3, 0(3)
; CHECK-NEXT:    rlwinm 6, 5, 3, 27, 27
; CHECK-NEXT:    xori 6, 6, 16
; CHECK-NEXT:    ori 7, 7, 65535
; CHECK-NEXT:    clrlwi 4, 4, 16
; CHECK-NEXT:    rldicr 5, 5, 0, 61
; CHECK-NEXT:    slw 7, 7, 6
; CHECK-NEXT:    b .LBB5_2
; CHECK-NEXT:  .LBB5_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    srw 3, 10, 6
; CHECK-NEXT:    cmplw 3, 8
; CHECK-NEXT:    beq 0, .LBB5_7
; CHECK-NEXT:  .LBB5_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB5_5 Depth 2
; CHECK-NEXT:    clrlwi 8, 3, 16
; CHECK-NEXT:    sub 3, 8, 4
; CHECK-NEXT:    cmplw 3, 8
; CHECK-NEXT:    li 9, 0
; CHECK-NEXT:    bgt 0, .LBB5_4
; CHECK-NEXT:  # %bb.3: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    mr 9, 3
; CHECK-NEXT:  .LBB5_4: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    slw 3, 9, 6
; CHECK-NEXT:    slw 9, 8, 6
; CHECK-NEXT:    and 3, 3, 7
; CHECK-NEXT:    and 9, 9, 7
; CHECK-NEXT:  .LBB5_5: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB5_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    lwarx 11, 0, 5
; CHECK-NEXT:    and 10, 11, 7
; CHECK-NEXT:    cmpw 10, 9
; CHECK-NEXT:    bne 0, .LBB5_1
; CHECK-NEXT:  # %bb.6: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    andc 11, 11, 7
; CHECK-NEXT:    or 11, 11, 3
; CHECK-NEXT:    stwcx. 11, 0, 5
; CHECK-NEXT:    bne 0, .LBB5_5
; CHECK-NEXT:    b .LBB5_1
; CHECK-NEXT:  .LBB5_7: # %atomicrmw.end
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_sat ptr %ptr, i16 %val seq_cst
  ret i16 %result
}

define i32 @atomicrmw_usub_sat_i32(ptr %ptr, i32 %val) {
; CHECK-LABEL: atomicrmw_usub_sat_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    lwz 6, 0(3)
; CHECK-NEXT:    b .LBB6_2
; CHECK-NEXT:  .LBB6_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    cmplw 5, 6
; CHECK-NEXT:    mr 6, 5
; CHECK-NEXT:    beq 0, .LBB6_6
; CHECK-NEXT:  .LBB6_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB6_4 Depth 2
; CHECK-NEXT:    sub 5, 6, 4
; CHECK-NEXT:    cmplw 5, 6
; CHECK-NEXT:    li 7, 0
; CHECK-NEXT:    bgt 0, .LBB6_4
; CHECK-NEXT:  # %bb.3: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    mr 7, 5
; CHECK-NEXT:  .LBB6_4: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB6_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    lwarx 5, 0, 3
; CHECK-NEXT:    cmpw 5, 6
; CHECK-NEXT:    bne 0, .LBB6_1
; CHECK-NEXT:  # %bb.5: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    stwcx. 7, 0, 3
; CHECK-NEXT:    bne 0, .LBB6_4
; CHECK-NEXT:    b .LBB6_1
; CHECK-NEXT:  .LBB6_6: # %atomicrmw.end
; CHECK-NEXT:    mr 3, 5
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_sat ptr %ptr, i32 %val seq_cst
  ret i32 %result
}

define i64 @atomicrmw_usub_sat_i64(ptr %ptr, i64 %val) {
; CHECK-LABEL: atomicrmw_usub_sat_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sync
; CHECK-NEXT:    ld 6, 0(3)
; CHECK-NEXT:    b .LBB7_2
; CHECK-NEXT:  .LBB7_1: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    cmpld 5, 6
; CHECK-NEXT:    mr 6, 5
; CHECK-NEXT:    beq 0, .LBB7_6
; CHECK-NEXT:  .LBB7_2: # %atomicrmw.start
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB7_4 Depth 2
; CHECK-NEXT:    sub 5, 6, 4
; CHECK-NEXT:    cmpld 5, 6
; CHECK-NEXT:    li 7, 0
; CHECK-NEXT:    bgt 0, .LBB7_4
; CHECK-NEXT:  # %bb.3: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    mr 7, 5
; CHECK-NEXT:  .LBB7_4: # %atomicrmw.start
; CHECK-NEXT:    # Parent Loop BB7_2 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    ldarx 5, 0, 3
; CHECK-NEXT:    cmpd 5, 6
; CHECK-NEXT:    bne 0, .LBB7_1
; CHECK-NEXT:  # %bb.5: # %atomicrmw.start
; CHECK-NEXT:    #
; CHECK-NEXT:    stdcx. 7, 0, 3
; CHECK-NEXT:    bne 0, .LBB7_4
; CHECK-NEXT:    b .LBB7_1
; CHECK-NEXT:  .LBB7_6: # %atomicrmw.end
; CHECK-NEXT:    mr 3, 5
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    blr
  %result = atomicrmw usub_sat ptr %ptr, i64 %val seq_cst
  ret i64 %result
}

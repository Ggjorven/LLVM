// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump --no-print-imm-hex -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump --no-print-imm-hex -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN

stnt1b  z0.b, p0, [x0]
// CHECK-INST: stnt1b  { z0.b }, p0, [x0]
// CHECK-ENCODING: [0x00,0xe0,0x10,0xe4]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e410e000 <unknown>

stnt1b  { z0.b }, p0, [x0]
// CHECK-INST: stnt1b  { z0.b }, p0, [x0]
// CHECK-ENCODING: [0x00,0xe0,0x10,0xe4]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e410e000 <unknown>

stnt1b  { z23.b }, p3, [x13, #-8, mul vl]
// CHECK-INST: stnt1b  { z23.b }, p3, [x13, #-8, mul vl]
// CHECK-ENCODING: [0xb7,0xed,0x18,0xe4]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e418edb7 <unknown>

stnt1b  { z21.b }, p5, [x10, #7, mul vl]
// CHECK-INST: stnt1b  { z21.b }, p5, [x10, #7, mul vl]
// CHECK-ENCODING: [0x55,0xf5,0x17,0xe4]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e417f555 <unknown>

stnt1b  { z0.b }, p0, [x0, x0]
// CHECK-INST: stnt1b  { z0.b }, p0, [x0, x0]
// CHECK-ENCODING: [0x00,0x60,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: e4006000 <unknown>

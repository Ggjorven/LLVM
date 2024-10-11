// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN

uqdecp  x0, p0.b
// CHECK-INST: uqdecp x0, p0.b
// CHECK-ENCODING: [0x00,0x8c,0x2b,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 252b8c00 <unknown>

uqdecp  x0, p0.h
// CHECK-INST: uqdecp x0, p0.h
// CHECK-ENCODING: [0x00,0x8c,0x6b,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 256b8c00 <unknown>

uqdecp  x0, p0.s
// CHECK-INST: uqdecp x0, p0.s
// CHECK-ENCODING: [0x00,0x8c,0xab,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25ab8c00 <unknown>

uqdecp  x0, p0.d
// CHECK-INST: uqdecp x0, p0.d
// CHECK-ENCODING: [0x00,0x8c,0xeb,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25eb8c00 <unknown>

uqdecp  wzr, p15.b
// CHECK-INST: uqdecp wzr, p15.b
// CHECK-ENCODING: [0xff,0x89,0x2b,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 252b89ff <unknown>

uqdecp  wzr, p15.h
// CHECK-INST: uqdecp wzr, p15.h
// CHECK-ENCODING: [0xff,0x89,0x6b,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 256b89ff <unknown>

uqdecp  wzr, p15.s
// CHECK-INST: uqdecp wzr, p15.s
// CHECK-ENCODING: [0xff,0x89,0xab,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25ab89ff <unknown>

uqdecp  wzr, p15.d
// CHECK-INST: uqdecp wzr, p15.d
// CHECK-ENCODING: [0xff,0x89,0xeb,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25eb89ff <unknown>

uqdecp  z0.h, p0
// CHECK-INST: uqdecp z0.h, p0.h
// CHECK-ENCODING: [0x00,0x80,0x6b,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 256b8000 <unknown>

uqdecp  z0.h, p0.h
// CHECK-INST: uqdecp z0.h, p0.h
// CHECK-ENCODING: [0x00,0x80,0x6b,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 256b8000 <unknown>

uqdecp  z0.s, p0
// CHECK-INST: uqdecp z0.s, p0.s
// CHECK-ENCODING: [0x00,0x80,0xab,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25ab8000 <unknown>

uqdecp  z0.s, p0.s
// CHECK-INST: uqdecp z0.s, p0.s
// CHECK-ENCODING: [0x00,0x80,0xab,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25ab8000 <unknown>

uqdecp  z0.d, p0
// CHECK-INST: uqdecp z0.d, p0.d
// CHECK-ENCODING: [0x00,0x80,0xeb,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25eb8000 <unknown>

uqdecp  z0.d, p0.d
// CHECK-INST: uqdecp z0.d, p0.d
// CHECK-ENCODING: [0x00,0x80,0xeb,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25eb8000 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

uqdecp  z0.d, p0.d
// CHECK-INST: uqdecp	z0.d, p0.d
// CHECK-ENCODING: [0x00,0x80,0xeb,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25eb8000 <unknown>

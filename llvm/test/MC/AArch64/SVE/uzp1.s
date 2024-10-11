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

uzp1    z31.b, z31.b, z31.b
// CHECK-INST: uzp1	z31.b, z31.b, z31.b
// CHECK-ENCODING: [0xff,0x6b,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 053f6bff <unknown>

uzp1    z31.h, z31.h, z31.h
// CHECK-INST: uzp1	z31.h, z31.h, z31.h
// CHECK-ENCODING: [0xff,0x6b,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 057f6bff <unknown>

uzp1    z31.s, z31.s, z31.s
// CHECK-INST: uzp1	z31.s, z31.s, z31.s
// CHECK-ENCODING: [0xff,0x6b,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 05bf6bff <unknown>

uzp1    z31.d, z31.d, z31.d
// CHECK-INST: uzp1	z31.d, z31.d, z31.d
// CHECK-ENCODING: [0xff,0x6b,0xff,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 05ff6bff <unknown>

uzp1    p15.b, p15.b, p15.b
// CHECK-INST: uzp1	p15.b, p15.b, p15.b
// CHECK-ENCODING: [0xef,0x49,0x2f,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 052f49ef <unknown>

uzp1    p15.s, p15.s, p15.s
// CHECK-INST: uzp1	p15.s, p15.s, p15.s
// CHECK-ENCODING: [0xef,0x49,0xaf,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 05af49ef <unknown>

uzp1    p15.h, p15.h, p15.h
// CHECK-INST: uzp1	p15.h, p15.h, p15.h
// CHECK-ENCODING: [0xef,0x49,0x6f,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 056f49ef <unknown>

uzp1    p15.d, p15.d, p15.d
// CHECK-INST: uzp1	p15.d, p15.d, p15.d
// CHECK-ENCODING: [0xef,0x49,0xef,0x05]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 05ef49ef <unknown>

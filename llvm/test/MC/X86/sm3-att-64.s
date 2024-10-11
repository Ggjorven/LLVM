// RUN: llvm-mc -triple x86_64 --show-encoding %s | FileCheck %s

// CHECK: vsm3msg1 %xmm4, %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x10,0xda,0xe4]
          vsm3msg1 %xmm4, %xmm13, %xmm12

// CHECK: vsm3msg1  268435456(%rbp,%r14,8), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x22,0x10,0xda,0xa4,0xf5,0x00,0x00,0x00,0x10]
          vsm3msg1  268435456(%rbp,%r14,8), %xmm13, %xmm12

// CHECK: vsm3msg1  291(%r8,%rax,4), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x42,0x10,0xda,0xa4,0x80,0x23,0x01,0x00,0x00]
          vsm3msg1  291(%r8,%rax,4), %xmm13, %xmm12

// CHECK: vsm3msg1  (%rip), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x10,0xda,0x25,0x00,0x00,0x00,0x00]
          vsm3msg1  (%rip), %xmm13, %xmm12

// CHECK: vsm3msg1  -512(,%rbp,2), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x10,0xda,0x24,0x6d,0x00,0xfe,0xff,0xff]
          vsm3msg1  -512(,%rbp,2), %xmm13, %xmm12

// CHECK: vsm3msg1  2032(%rcx), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x10,0xda,0xa1,0xf0,0x07,0x00,0x00]
          vsm3msg1  2032(%rcx), %xmm13, %xmm12

// CHECK: vsm3msg1  -2048(%rdx), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x10,0xda,0xa2,0x00,0xf8,0xff,0xff]
          vsm3msg1  -2048(%rdx), %xmm13, %xmm12

// CHECK: vsm3msg2 %xmm4, %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x11,0xda,0xe4]
          vsm3msg2 %xmm4, %xmm13, %xmm12

// CHECK: vsm3msg2  268435456(%rbp,%r14,8), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x22,0x11,0xda,0xa4,0xf5,0x00,0x00,0x00,0x10]
          vsm3msg2  268435456(%rbp,%r14,8), %xmm13, %xmm12

// CHECK: vsm3msg2  291(%r8,%rax,4), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x42,0x11,0xda,0xa4,0x80,0x23,0x01,0x00,0x00]
          vsm3msg2  291(%r8,%rax,4), %xmm13, %xmm12

// CHECK: vsm3msg2  (%rip), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x11,0xda,0x25,0x00,0x00,0x00,0x00]
          vsm3msg2  (%rip), %xmm13, %xmm12

// CHECK: vsm3msg2  -512(,%rbp,2), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x11,0xda,0x24,0x6d,0x00,0xfe,0xff,0xff]
          vsm3msg2  -512(,%rbp,2), %xmm13, %xmm12

// CHECK: vsm3msg2  2032(%rcx), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x11,0xda,0xa1,0xf0,0x07,0x00,0x00]
          vsm3msg2  2032(%rcx), %xmm13, %xmm12

// CHECK: vsm3msg2  -2048(%rdx), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x62,0x11,0xda,0xa2,0x00,0xf8,0xff,0xff]
          vsm3msg2  -2048(%rdx), %xmm13, %xmm12

// CHECK: vsm3rnds2 $123, %xmm4, %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x63,0x11,0xde,0xe4,0x7b]
          vsm3rnds2 $123, %xmm4, %xmm13, %xmm12

// CHECK: vsm3rnds2  $123, 268435456(%rbp,%r14,8), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x23,0x11,0xde,0xa4,0xf5,0x00,0x00,0x00,0x10,0x7b]
          vsm3rnds2  $123, 268435456(%rbp,%r14,8), %xmm13, %xmm12

// CHECK: vsm3rnds2  $123, 291(%r8,%rax,4), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x43,0x11,0xde,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
          vsm3rnds2  $123, 291(%r8,%rax,4), %xmm13, %xmm12

// CHECK: vsm3rnds2  $123, (%rip), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x63,0x11,0xde,0x25,0x00,0x00,0x00,0x00,0x7b]
          vsm3rnds2  $123, (%rip), %xmm13, %xmm12

// CHECK: vsm3rnds2  $123, -512(,%rbp,2), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x63,0x11,0xde,0x24,0x6d,0x00,0xfe,0xff,0xff,0x7b]
          vsm3rnds2  $123, -512(,%rbp,2), %xmm13, %xmm12

// CHECK: vsm3rnds2  $123, 2032(%rcx), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x63,0x11,0xde,0xa1,0xf0,0x07,0x00,0x00,0x7b]
          vsm3rnds2  $123, 2032(%rcx), %xmm13, %xmm12

// CHECK: vsm3rnds2  $123, -2048(%rdx), %xmm13, %xmm12
// CHECK: encoding: [0xc4,0x63,0x11,0xde,0xa2,0x00,0xf8,0xff,0xff,0x7b]
          vsm3rnds2  $123, -2048(%rdx), %xmm13, %xmm12


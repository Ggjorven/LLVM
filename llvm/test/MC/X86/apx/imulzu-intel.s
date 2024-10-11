# RUN: llvm-mc -triple x86_64 -show-encoding -x86-asm-syntax=intel -output-asm-variant=1 %s | FileCheck %s

# CHECK: imulzu	dx, dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x18,0x6b,0xd2,0x7b]
         imulzu	dx, dx, 123
# CHECK: imulzu	ecx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x18,0x6b,0xc9,0x7b]
         imulzu	ecx, ecx, 123
# CHECK: imulzu	r9, r9, 123
# CHECK: encoding: [0x62,0x54,0xfc,0x18,0x6b,0xc9,0x7b]
         imulzu	r9, r9, 123
# CHECK: imulzu	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x18,0x6b,0x94,0x80,0x23,0x01,0x00,0x00,0x7b]
         imulzu	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: imulzu	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x18,0x6b,0x8c,0x80,0x23,0x01,0x00,0x00,0x7b]
         imulzu	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: imulzu	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0x54,0xfc,0x18,0x6b,0x8c,0x80,0x23,0x01,0x00,0x00,0x7b]
         imulzu	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: imulzu	dx, dx, 1234
# CHECK: encoding: [0x62,0xf4,0x7d,0x18,0x69,0xd2,0xd2,0x04]
         imulzu	dx, dx, 1234
# CHECK: imulzu	dx, word ptr [r8 + 4*rax + 291], 1234
# CHECK: encoding: [0x62,0xd4,0x7d,0x18,0x69,0x94,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         imulzu	dx, word ptr [r8 + 4*rax + 291], 1234
# CHECK: imulzu	ecx, ecx, 123456
# CHECK: encoding: [0x62,0xf4,0x7c,0x18,0x69,0xc9,0x40,0xe2,0x01,0x00]
         imulzu	ecx, ecx, 123456
# CHECK: imulzu	r9, r9, 123456
# CHECK: encoding: [0x62,0x54,0xfc,0x18,0x69,0xc9,0x40,0xe2,0x01,0x00]
         imulzu	r9, r9, 123456
# CHECK: imulzu	ecx, dword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0x7c,0x18,0x69,0x8c,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         imulzu	ecx, dword ptr [r8 + 4*rax + 291], 123456
# CHECK: imulzu	r9, qword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0x54,0xfc,0x18,0x69,0x8c,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         imulzu	r9, qword ptr [r8 + 4*rax + 291], 123456

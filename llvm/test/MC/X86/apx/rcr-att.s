# RUN: llvm-mc -triple x86_64 -show-encoding %s | FileCheck %s
# RUN: not llvm-mc -triple i386 -show-encoding %s 2>&1 | FileCheck %s --check-prefix=ERROR

# ERROR-COUNT-47: error:
# ERROR-NOT: error:
# CHECK: {evex}	rcrb	$123, %bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xc0,0xdb,0x7b]
         {evex}	rcrb	$123, %bl
# CHECK: rcrb	$123, %bl, %bl
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xc0,0xdb,0x7b]
         rcrb	$123, %bl, %bl
# CHECK: {evex}	rcrw	$123, %dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xc1,0xda,0x7b]
         {evex}	rcrw	$123, %dx
# CHECK: rcrw	$123, %dx, %dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xc1,0xda,0x7b]
         rcrw	$123, %dx, %dx
# CHECK: {evex}	rcrl	$123, %ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xc1,0xd9,0x7b]
         {evex}	rcrl	$123, %ecx
# CHECK: rcrl	$123, %ecx, %ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xc1,0xd9,0x7b]
         rcrl	$123, %ecx, %ecx
# CHECK: {evex}	rcrq	$123, %r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xc1,0xd9,0x7b]
         {evex}	rcrq	$123, %r9
# CHECK: rcrq	$123, %r9, %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xc1,0xd9,0x7b]
         rcrq	$123, %r9, %r9
# CHECK: {evex}	rcrb	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xc0,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rcrb	$123, 291(%r8,%rax,4)
# CHECK: rcrb	$123, 291(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xc0,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         rcrb	$123, 291(%r8,%rax,4), %bl
# CHECK: {evex}	rcrw	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xc1,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rcrw	$123, 291(%r8,%rax,4)
# CHECK: rcrw	$123, 291(%r8,%rax,4), %dx
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xc1,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         rcrw	$123, 291(%r8,%rax,4), %dx
# CHECK: {evex}	rcrl	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xc1,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rcrl	$123, 291(%r8,%rax,4)
# CHECK: rcrl	$123, 291(%r8,%rax,4), %ecx
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xc1,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         rcrl	$123, 291(%r8,%rax,4), %ecx
# CHECK: {evex}	rcrq	$123, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xc1,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	rcrq	$123, 291(%r8,%rax,4)
# CHECK: rcrq	$123, 291(%r8,%rax,4), %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xc1,0x9c,0x80,0x23,0x01,0x00,0x00,0x7b]
         rcrq	$123, 291(%r8,%rax,4), %r9
# CHECK: {evex}	rcrb	%bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd0,0xdb]
         {evex}	rcrb	%bl
# CHECK: {evex}	rcrb	%cl, %bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd2,0xdb]
         {evex}	rcrb	%cl, %bl
# CHECK: rcrb	%cl, %bl, %bl
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd2,0xdb]
         rcrb	%cl, %bl, %bl
# CHECK: {evex}	rcrw	%cl, %dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd3,0xda]
         {evex}	rcrw	%cl, %dx
# CHECK: rcrw	%cl, %dx, %dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xd3,0xda]
         rcrw	%cl, %dx, %dx
# CHECK: {evex}	rcrl	%cl, %ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd3,0xd9]
         {evex}	rcrl	%cl, %ecx
# CHECK: rcrl	%cl, %ecx, %ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xd3,0xd9]
         rcrl	%cl, %ecx, %ecx
# CHECK: {evex}	rcrq	%cl, %r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd3,0xd9]
         {evex}	rcrq	%cl, %r9
# CHECK: rcrq	%cl, %r9, %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd3,0xd9]
         rcrq	%cl, %r9, %r9
# CHECK: {evex}	rcrb	%cl, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd2,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrb	%cl, 291(%r8,%rax,4)
# CHECK: rcrb	%cl, 291(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd2,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrb	%cl, 291(%r8,%rax,4), %bl
# CHECK: {evex}	rcrw	%cl, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd3,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrw	%cl, 291(%r8,%rax,4)
# CHECK: rcrw	%cl, 291(%r8,%rax,4), %dx
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xd3,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrw	%cl, 291(%r8,%rax,4), %dx
# CHECK: {evex}	rcrl	%cl, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd3,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrl	%cl, 291(%r8,%rax,4)
# CHECK: rcrl	%cl, 291(%r8,%rax,4), %ecx
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xd3,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrl	%cl, 291(%r8,%rax,4), %ecx
# CHECK: {evex}	rcrq	%cl, 291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd3,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrq	%cl, 291(%r8,%rax,4)
# CHECK: rcrq	%cl, 291(%r8,%rax,4), %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd3,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrq	%cl, 291(%r8,%rax,4), %r9
# CHECK: {evex}	rcrw	%dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd1,0xda]
         {evex}	rcrw	%dx
# CHECK: rcrw	%dx, %dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xd1,0xda]
         rcrw	%dx, %dx
# CHECK: {evex}	rcrl	%ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd1,0xd9]
         {evex}	rcrl	%ecx
# CHECK: rcrl	%ecx, %ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xd1,0xd9]
         rcrl	%ecx, %ecx
# CHECK: {evex}	rcrq	%r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0xd9]
         {evex}	rcrq	%r9
# CHECK: rcrq	%r9, %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd1,0xd9]
         rcrq	%r9, %r9
# CHECK: {evex}	rcrb	291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd0,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrb	291(%r8,%rax,4)
# CHECK: rcrb	291(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd0,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrb	291(%r8,%rax,4), %bl
# CHECK: {evex}	rcrw	291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd1,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrw	291(%r8,%rax,4)
# CHECK: rcrw	291(%r8,%rax,4), %dx
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xd1,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrw	291(%r8,%rax,4), %dx
# CHECK: {evex}	rcrl	291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd1,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrl	291(%r8,%rax,4)
# CHECK: rcrl	291(%r8,%rax,4), %ecx
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xd1,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrl	291(%r8,%rax,4), %ecx
# CHECK: {evex}	rcrq	291(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	rcrq	291(%r8,%rax,4)
# CHECK: rcrq	291(%r8,%rax,4), %r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd1,0x9c,0x80,0x23,0x01,0x00,0x00]
         rcrq	291(%r8,%rax,4), %r9

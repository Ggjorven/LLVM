# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=alderlake -instruction-tables < %s | FileCheck %s

movbe  %cx, (%rax)
movbe  (%rax), %cx

movbe  %ecx, (%rax)
movbe  (%rax), %ecx

movbe  %rcx, (%rax)
movbe  (%rax), %rcx

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  3      12    0.50           *            movbew	%cx, (%rax)
# CHECK-NEXT:  3      7     0.50    *                   movbew	(%rax), %cx
# CHECK-NEXT:  3      12    1.00           *            movbel	%ecx, (%rax)
# CHECK-NEXT:  2      6     1.00    *                   movbel	(%rax), %ecx
# CHECK-NEXT:  4      12    1.00           *            movbeq	%rcx, (%rax)
# CHECK-NEXT:  3      7     1.00    *                   movbeq	(%rax), %rcx

# CHECK:      Resources:
# CHECK-NEXT: [0]   - ADLPPort00
# CHECK-NEXT: [1]   - ADLPPort01
# CHECK-NEXT: [2]   - ADLPPort02
# CHECK-NEXT: [3]   - ADLPPort03
# CHECK-NEXT: [4]   - ADLPPort04
# CHECK-NEXT: [5]   - ADLPPort05
# CHECK-NEXT: [6]   - ADLPPort06
# CHECK-NEXT: [7]   - ADLPPort07
# CHECK-NEXT: [8]   - ADLPPort08
# CHECK-NEXT: [9]   - ADLPPort09
# CHECK-NEXT: [10]  - ADLPPort10
# CHECK-NEXT: [11]  - ADLPPort11
# CHECK-NEXT: [12]  - ADLPPortInvalid

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]
# CHECK-NEXT: 2.20   4.20   1.00   1.00   1.50   0.20   2.20   1.50   1.50   1.50   0.20   1.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT: 0.50    -      -      -     0.50    -     0.50   0.50   0.50   0.50    -      -      -     movbew	%cx, (%rax)
# CHECK-NEXT: 0.70   0.20   0.33   0.33    -     0.20   0.70    -      -      -     0.20   0.33    -     movbew	(%rax), %cx
# CHECK-NEXT:  -     1.00    -      -     0.50    -      -     0.50   0.50   0.50    -      -      -     movbel	%ecx, (%rax)
# CHECK-NEXT:  -     1.00   0.33   0.33    -      -      -      -      -      -      -     0.33    -     movbel	(%rax), %ecx
# CHECK-NEXT: 0.50   1.00    -      -     0.50    -     0.50   0.50   0.50   0.50    -      -      -     movbeq	%rcx, (%rax)
# CHECK-NEXT: 0.50   1.00   0.33   0.33    -      -     0.50    -      -      -      -     0.33    -     movbeq	(%rax), %rcx

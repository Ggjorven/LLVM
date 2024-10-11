# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=alderlake -instruction-tables < %s | FileCheck %s

adcx        %ebx, %ecx
adcx        (%rbx), %ecx
adcx        %rbx, %rcx
adcx        (%rbx), %rcx

adox        %ebx, %ecx
adox        (%rbx), %ecx
adox        %rbx, %rcx
adox        (%rbx), %rcx

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        adcxl	%ebx, %ecx
# CHECK-NEXT:  2      6     0.50    *                   adcxl	(%rbx), %ecx
# CHECK-NEXT:  1      1     0.50                        adcxq	%rbx, %rcx
# CHECK-NEXT:  2      6     0.50    *                   adcxq	(%rbx), %rcx
# CHECK-NEXT:  1      1     0.50                        adoxl	%ebx, %ecx
# CHECK-NEXT:  2      6     0.50    *                   adoxl	(%rbx), %ecx
# CHECK-NEXT:  1      1     0.50                        adoxq	%rbx, %rcx
# CHECK-NEXT:  2      6     0.50    *                   adoxq	(%rbx), %rcx

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
# CHECK-NEXT: 4.00    -     1.33   1.33    -      -     4.00    -      -      -      -     1.33    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT: 0.50    -      -      -      -      -     0.50    -      -      -      -      -      -     adcxl	%ebx, %ecx
# CHECK-NEXT: 0.50    -     0.33   0.33    -      -     0.50    -      -      -      -     0.33    -     adcxl	(%rbx), %ecx
# CHECK-NEXT: 0.50    -      -      -      -      -     0.50    -      -      -      -      -      -     adcxq	%rbx, %rcx
# CHECK-NEXT: 0.50    -     0.33   0.33    -      -     0.50    -      -      -      -     0.33    -     adcxq	(%rbx), %rcx
# CHECK-NEXT: 0.50    -      -      -      -      -     0.50    -      -      -      -      -      -     adoxl	%ebx, %ecx
# CHECK-NEXT: 0.50    -     0.33   0.33    -      -     0.50    -      -      -      -     0.33    -     adoxl	(%rbx), %ecx
# CHECK-NEXT: 0.50    -      -      -      -      -     0.50    -      -      -      -      -      -     adoxq	%rbx, %rcx
# CHECK-NEXT: 0.50    -     0.33   0.33    -      -     0.50    -      -      -      -     0.33    -     adoxq	(%rbx), %rcx

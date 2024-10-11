# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=sapphirerapids -instruction-tables < %s | FileCheck %s

vgf2p8affineinvqb   $0, %zmm16, %zmm17, %zmm19
vgf2p8affineinvqb   $0, (%rax), %zmm17, %zmm19
vgf2p8affineinvqb   $0, (%rax){1to8}, %zmm17, %zmm19
vgf2p8affineinvqb   $0, %zmm16, %zmm17, %zmm19 {k1}
vgf2p8affineinvqb   $0, (%rax), %zmm17, %zmm19 {k1}
vgf2p8affineinvqb   $0, (%rax){1to8}, %zmm17, %zmm19 {k1}
vgf2p8affineinvqb   $0, %zmm16, %zmm17, %zmm19 {z}{k1}
vgf2p8affineinvqb   $0, (%rax), %zmm17, %zmm19 {z}{k1}
vgf2p8affineinvqb   $0, (%rax){1to8}, %zmm17, %zmm19 {z}{k1}

vgf2p8affineqb      $0, %zmm16, %zmm17, %zmm19
vgf2p8affineqb      $0, (%rax), %zmm17, %zmm19
vgf2p8affineqb      $0, (%rax){1to8}, %zmm17, %zmm19
vgf2p8affineqb      $0, %zmm16, %zmm17, %zmm19
vgf2p8affineqb      $0, (%rax), %zmm17, %zmm19
vgf2p8affineqb      $0, (%rax){1to8}, %zmm17, %zmm19
vgf2p8affineqb      $0, %zmm16, %zmm17, %zmm19 {z}{k1}
vgf2p8affineqb      $0, (%rax), %zmm17, %zmm19 {z}{k1}
vgf2p8affineqb      $0, (%rax){1to8}, %zmm17, %zmm19 {z}{k1}

vgf2p8mulb          %zmm16, %zmm17, %zmm19
vgf2p8mulb          (%rax), %zmm17, %zmm19
vgf2p8mulb          %zmm16, %zmm17, %zmm19 {k1}
vgf2p8mulb          (%rax), %zmm17, %zmm19 {k1}
vgf2p8mulb          %zmm16, %zmm17, %zmm19 {z}{k1}
vgf2p8mulb          (%rax), %zmm17, %zmm19 {z}{k1}

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      5     1.00                        vgf2p8affineinvqb	$0, %zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8affineinvqb	$0, (%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8affineinvqb	$0, (%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      9     1.00                        vgf2p8affineinvqb	$0, %zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8affineinvqb	$0, (%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8affineinvqb	$0, (%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      10    1.00                        vgf2p8affineinvqb	$0, %zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8affineinvqb	$0, (%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8affineinvqb	$0, (%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      5     1.00                        vgf2p8affineqb	$0, %zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8affineqb	$0, (%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8affineqb	$0, (%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      5     1.00                        vgf2p8affineqb	$0, %zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8affineqb	$0, (%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8affineqb	$0, (%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      10    1.00                        vgf2p8affineqb	$0, %zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8affineqb	$0, (%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8affineqb	$0, (%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      5     1.00                        vgf2p8mulb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      12    1.00    *                   vgf2p8mulb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      9     1.00                        vgf2p8mulb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8mulb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      10    1.00                        vgf2p8mulb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      15    1.00    *                   vgf2p8mulb	(%rax), %zmm17, %zmm19 {%k1} {z}

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SPRPort00
# CHECK-NEXT: [1]   - SPRPort01
# CHECK-NEXT: [2]   - SPRPort02
# CHECK-NEXT: [3]   - SPRPort03
# CHECK-NEXT: [4]   - SPRPort04
# CHECK-NEXT: [5]   - SPRPort05
# CHECK-NEXT: [6]   - SPRPort06
# CHECK-NEXT: [7]   - SPRPort07
# CHECK-NEXT: [8]   - SPRPort08
# CHECK-NEXT: [9]   - SPRPort09
# CHECK-NEXT: [10]  - SPRPort10
# CHECK-NEXT: [11]  - SPRPort11
# CHECK-NEXT: [12]  - SPRPortInvalid

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]
# CHECK-NEXT: 24.00   -     5.00   5.00    -      -      -      -      -      -      -     5.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8affineinvqb	$0, %zmm16, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineinvqb	$0, (%rax), %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineinvqb	$0, (%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8affineinvqb	$0, %zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineinvqb	$0, (%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineinvqb	$0, (%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8affineinvqb	$0, %zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineinvqb	$0, (%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineinvqb	$0, (%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8affineqb	$0, %zmm16, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineqb	$0, (%rax), %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineqb	$0, (%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8affineqb	$0, %zmm16, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineqb	$0, (%rax), %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineqb	$0, (%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8affineqb	$0, %zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineqb	$0, (%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8affineqb	$0, (%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8mulb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8mulb	(%rax), %zmm17, %zmm19
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8mulb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8mulb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -     vgf2p8mulb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT: 1.00    -     0.33   0.33    -      -      -      -      -      -      -     0.33    -     vgf2p8mulb	(%rax), %zmm17, %zmm19 {%k1} {z}

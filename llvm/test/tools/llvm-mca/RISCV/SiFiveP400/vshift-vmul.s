
# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=riscv64 -mcpu=sifive-p470 -iterations=1 < %s | FileCheck %s

vsetvli zero, zero, e32, m1, ta, ma

vsll.vv v1, v2, v5
vsll.vx v1, v2, t0
vsll.vi v1, v2, 7

vsrl.vv v1, v2, v5
vsrl.vx v1, v2, t0
vsrl.vi v1, v2, 7

vsra.vv v1, v2, v5
vsra.vx v1, v2, t0
vsra.vi v1, v2, 7

vsetvli zero, zero, e32, mf4, ta, ma

vsll.vv v1, v2, v5
vsll.vx v1, v2, t0
vsll.vi v1, v2, 7

vsrl.vv v1, v2, v5
vsrl.vx v1, v2, t0
vsrl.vi v1, v2, 7

vsra.vv v1, v2, v5
vsra.vx v1, v2, t0
vsra.vi v1, v2, 7

vsetvli zero, zero, e32, m8, ta, ma

vmul.vv v1, v2, v5
vmul.vx v1, v2, t1

vmadd.vv v1, v2, v5
vmadd.vx v1, t1, v2

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      25
# CHECK-NEXT: Total Cycles:      57
# CHECK-NEXT: Total uOps:        25

# CHECK:      Dispatch Width:    3
# CHECK-NEXT: uOps Per Cycle:    0.44
# CHECK-NEXT: IPC:               0.44
# CHECK-NEXT: Block RThroughput: 50.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00                  U     vsetvli zero, zero, e32, m1, ta, ma
# CHECK-NEXT:  1      2     1.00                        vsll.vv v1, v2, v5
# CHECK-NEXT:  1      2     1.00                        vsll.vx v1, v2, t0
# CHECK-NEXT:  1      2     1.00                        vsll.vi v1, v2, 7
# CHECK-NEXT:  1      2     1.00                        vsrl.vv v1, v2, v5
# CHECK-NEXT:  1      2     1.00                        vsrl.vx v1, v2, t0
# CHECK-NEXT:  1      2     1.00                        vsrl.vi v1, v2, 7
# CHECK-NEXT:  1      2     1.00                        vsra.vv v1, v2, v5
# CHECK-NEXT:  1      2     1.00                        vsra.vx v1, v2, t0
# CHECK-NEXT:  1      2     1.00                        vsra.vi v1, v2, 7
# CHECK-NEXT:  1      1     1.00                  U     vsetvli zero, zero, e32, mf4, ta, ma
# CHECK-NEXT:  1      2     1.00                        vsll.vv v1, v2, v5
# CHECK-NEXT:  1      2     1.00                        vsll.vx v1, v2, t0
# CHECK-NEXT:  1      2     1.00                        vsll.vi v1, v2, 7
# CHECK-NEXT:  1      2     1.00                        vsrl.vv v1, v2, v5
# CHECK-NEXT:  1      2     1.00                        vsrl.vx v1, v2, t0
# CHECK-NEXT:  1      2     1.00                        vsrl.vi v1, v2, 7
# CHECK-NEXT:  1      2     1.00                        vsra.vv v1, v2, v5
# CHECK-NEXT:  1      2     1.00                        vsra.vx v1, v2, t0
# CHECK-NEXT:  1      2     1.00                        vsra.vi v1, v2, 7
# CHECK-NEXT:  1      1     1.00                  U     vsetvli zero, zero, e32, m8, ta, ma
# CHECK-NEXT:  1      9     8.00                        vmul.vv v1, v2, v5
# CHECK-NEXT:  1      9     8.00                        vmul.vx v1, v2, t1
# CHECK-NEXT:  1      9     8.00                        vmadd.vv  v1, v2, v5
# CHECK-NEXT:  1      9     8.00                        vmadd.vx  v1, t1, v2

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SiFiveP400Div
# CHECK-NEXT: [1]   - SiFiveP400FEXQ0
# CHECK-NEXT: [2]   - SiFiveP400FloatDiv
# CHECK-NEXT: [3]   - SiFiveP400IEXQ0
# CHECK-NEXT: [4]   - SiFiveP400IEXQ1
# CHECK-NEXT: [5]   - SiFiveP400IEXQ2
# CHECK-NEXT: [6]   - SiFiveP400Load
# CHECK-NEXT: [7]   - SiFiveP400Store
# CHECK-NEXT: [8]   - SiFiveP400VDiv
# CHECK-NEXT: [9]   - SiFiveP400VEXQ0
# CHECK-NEXT: [10]  - SiFiveP400VFloatDiv
# CHECK-NEXT: [11]  - SiFiveP400VLD
# CHECK-NEXT: [12]  - SiFiveP400VST

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]
# CHECK-NEXT:  -      -      -      -     3.00    -      -      -      -     50.00   -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -     vsetvli  zero, zero, e32, m1, ta, ma
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsll.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsll.vx  v1, v2, t0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsll.vi  v1, v2, 7
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsrl.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsrl.vx  v1, v2, t0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsrl.vi  v1, v2, 7
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsra.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsra.vx  v1, v2, t0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsra.vi  v1, v2, 7
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -     vsetvli  zero, zero, e32, mf4, ta, ma
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsll.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsll.vx  v1, v2, t0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsll.vi  v1, v2, 7
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsrl.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsrl.vx  v1, v2, t0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsrl.vi  v1, v2, 7
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsra.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsra.vx  v1, v2, t0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vsra.vi  v1, v2, 7
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -     vsetvli  zero, zero, e32, m8, ta, ma
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     8.00    -      -      -     vmul.vv  v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     8.00    -      -      -     vmul.vx  v1, v2, t1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     8.00    -      -      -     vmadd.vv v1, v2, v5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     8.00    -      -      -     vmadd.vx v1, t1, v2


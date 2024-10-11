# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,BARCELONA %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=bdver2 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,BDVER2 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=btver2 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,BTVER2 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver1 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ZNVER1 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver2 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ZNVER2 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver3 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ZNVER3 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver4 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ZNVER4 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=sandybridge -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,SNB %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=ivybridge -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,IVB %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=haswell -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,HSW %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=broadwell -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,BDW %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=knl -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,KNL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=skylake -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,SKX %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=skylake-avx512 -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,SKX-AVX512 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=icelake-client -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ICX %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=icelake-server -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ICX %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=rocketlake -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ICX %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=tigerlake -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,ICX %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=slm -iterations=1 -all-stats=false -all-views=false -scheduler-stats < %s | FileCheck --check-prefixes=ALL,SLM %s

xor %eax, %ebx

# ALL:             Schedulers - number of cycles where we saw N micro opcodes issued:
# ALL-NEXT:        [# issued], [# cycles]
# ALL-NEXT:         0,          3  (75.0%)
# ALL-NEXT:         1,          1  (25.0%)

# BARCELONA:       Scheduler's queue usage:
# BARCELONA-NEXT:  [1] Resource name.
# BARCELONA-NEXT:  [2] Average number of used buffer entries.
# BARCELONA-NEXT:  [3] Maximum number of used buffer entries.
# BARCELONA-NEXT:  [4] Total number of buffer entries.

# BDVER2:          Scheduler's queue usage:
# BDVER2-NEXT:     [1] Resource name.
# BDVER2-NEXT:     [2] Average number of used buffer entries.
# BDVER2-NEXT:     [3] Maximum number of used buffer entries.
# BDVER2-NEXT:     [4] Total number of buffer entries.

# BDW:             Scheduler's queue usage:
# BDW-NEXT:        [1] Resource name.
# BDW-NEXT:        [2] Average number of used buffer entries.
# BDW-NEXT:        [3] Maximum number of used buffer entries.
# BDW-NEXT:        [4] Total number of buffer entries.

# BTVER2:          Scheduler's queue usage:
# BTVER2-NEXT:     [1] Resource name.
# BTVER2-NEXT:     [2] Average number of used buffer entries.
# BTVER2-NEXT:     [3] Maximum number of used buffer entries.
# BTVER2-NEXT:     [4] Total number of buffer entries.

# HSW:             Scheduler's queue usage:
# HSW-NEXT:        [1] Resource name.
# HSW-NEXT:        [2] Average number of used buffer entries.
# HSW-NEXT:        [3] Maximum number of used buffer entries.
# HSW-NEXT:        [4] Total number of buffer entries.

# ICX:             Scheduler's queue usage:
# ICX-NEXT:        [1] Resource name.
# ICX-NEXT:        [2] Average number of used buffer entries.
# ICX-NEXT:        [3] Maximum number of used buffer entries.
# ICX-NEXT:        [4] Total number of buffer entries.

# IVB:             Scheduler's queue usage:
# IVB-NEXT:        [1] Resource name.
# IVB-NEXT:        [2] Average number of used buffer entries.
# IVB-NEXT:        [3] Maximum number of used buffer entries.
# IVB-NEXT:        [4] Total number of buffer entries.

# KNL:             Scheduler's queue usage:
# KNL-NEXT:        [1] Resource name.
# KNL-NEXT:        [2] Average number of used buffer entries.
# KNL-NEXT:        [3] Maximum number of used buffer entries.
# KNL-NEXT:        [4] Total number of buffer entries.

# SKX:             Scheduler's queue usage:
# SKX-NEXT:        [1] Resource name.
# SKX-NEXT:        [2] Average number of used buffer entries.
# SKX-NEXT:        [3] Maximum number of used buffer entries.
# SKX-NEXT:        [4] Total number of buffer entries.

# SKX-AVX512:      Scheduler's queue usage:
# SKX-AVX512-NEXT: [1] Resource name.
# SKX-AVX512-NEXT: [2] Average number of used buffer entries.
# SKX-AVX512-NEXT: [3] Maximum number of used buffer entries.
# SKX-AVX512-NEXT: [4] Total number of buffer entries.

# SLM:             Scheduler's queue usage:
# SLM-NEXT:        No scheduler resources used.

# SNB:             Scheduler's queue usage:
# SNB-NEXT:        [1] Resource name.
# SNB-NEXT:        [2] Average number of used buffer entries.
# SNB-NEXT:        [3] Maximum number of used buffer entries.
# SNB-NEXT:        [4] Total number of buffer entries.

# ZNVER1:          Scheduler's queue usage:
# ZNVER1-NEXT:     [1] Resource name.
# ZNVER1-NEXT:     [2] Average number of used buffer entries.
# ZNVER1-NEXT:     [3] Maximum number of used buffer entries.
# ZNVER1-NEXT:     [4] Total number of buffer entries.

# ZNVER2:          Scheduler's queue usage:
# ZNVER2-NEXT:     [1] Resource name.
# ZNVER2-NEXT:     [2] Average number of used buffer entries.
# ZNVER2-NEXT:     [3] Maximum number of used buffer entries.
# ZNVER2-NEXT:     [4] Total number of buffer entries.

# ZNVER3:          Scheduler's queue usage:
# ZNVER3-NEXT:     [1] Resource name.
# ZNVER3-NEXT:     [2] Average number of used buffer entries.
# ZNVER3-NEXT:     [3] Maximum number of used buffer entries.
# ZNVER3-NEXT:     [4] Total number of buffer entries.

# ZNVER4:          Scheduler's queue usage:
# ZNVER4-NEXT:     [1] Resource name.
# ZNVER4-NEXT:     [2] Average number of used buffer entries.
# ZNVER4-NEXT:     [3] Maximum number of used buffer entries.
# ZNVER4-NEXT:     [4] Total number of buffer entries.

# BARCELONA:        [1]            [2]        [3]        [4]
# BARCELONA-NEXT:  SBPortAny        0          1          54

# BDVER2:           [1]            [2]        [3]        [4]
# BDVER2-NEXT:     PdEX             0          1          40
# BDVER2-NEXT:     PdFPU            0          0          64
# BDVER2-NEXT:     PdLoad           0          0          40
# BDVER2-NEXT:     PdStore          0          0          24

# BDW:              [1]            [2]        [3]        [4]
# BDW-NEXT:        BWPortAny        0          1          60

# BTVER2:           [1]            [2]        [3]        [4]
# BTVER2-NEXT:     JALU01           0          1          20
# BTVER2-NEXT:     JFPU01           0          0          18
# BTVER2-NEXT:     JLSAGU           0          0          12

# HSW:              [1]            [2]        [3]        [4]
# HSW-NEXT:        HWPortAny        0          1          60

# ICX:              [1]            [2]        [3]        [4]
# ICX-NEXT:        ICXPortAny       0          1          60

# IVB:              [1]            [2]        [3]        [4]
# IVB-NEXT:        SBPortAny        0          1          54

# KNL:              [1]            [2]        [3]        [4]
# KNL-NEXT:        HWPortAny        0          1          60

# SKX:              [1]            [2]        [3]        [4]
# SKX-NEXT:        SKLPortAny       0          1          60

# SKX-AVX512:       [1]            [2]        [3]        [4]
# SKX-AVX512-NEXT: SKXPortAny       0          1          60

# SNB:              [1]            [2]        [3]        [4]
# SNB-NEXT:        SBPortAny        0          1          54

# ZNVER1:           [1]            [2]        [3]        [4]
# ZNVER1-NEXT:     ZnAGU            0          0          28
# ZNVER1-NEXT:     ZnALU            0          1          56
# ZNVER1-NEXT:     ZnFPU            0          0          36

# ZNVER2:           [1]            [2]        [3]        [4]
# ZNVER2-NEXT:     Zn2AGU           0          0          28
# ZNVER2-NEXT:     Zn2ALU           0          1          64
# ZNVER2-NEXT:     Zn2FPU           0          0          36

# ZNVER3:           [1]            [2]        [3]        [4]
# ZNVER3-NEXT:     Zn3FP            0          0          64
# ZNVER3-NEXT:     Zn3Int           0          1          96
# ZNVER3-NEXT:     Zn3Load          0          0          72
# ZNVER3-NEXT:     Zn3Store         0          0          64

# ZNVER4:           [1]            [2]        [3]        [4]
# ZNVER4-NEXT:     Zn4FP            0          0          64
# ZNVER4-NEXT:     Zn4Int           0          1          96
# ZNVER4-NEXT:     Zn4Load          0          0          72
# ZNVER4-NEXT:     Zn4Store         0          0          64

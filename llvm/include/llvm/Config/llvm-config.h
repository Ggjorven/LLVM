/*===------- llvm/Config/llvm-config.h - llvm configuration -------*- C -*-===*/
/*                                                                            */
/* Part of the LLVM Project, under the Apache License v2.0 with LLVM          */
/* Exceptions.                                                                */
/* See https://llvm.org/LICENSE.txt for license information.                  */
/* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    */
/*                                                                            */
/*===----------------------------------------------------------------------===*/

/* This file enumerates variables from the LLVM configuration so that they
   can be in exported headers and won't override package-specific directives.
   This is a C header that can be included in the llvm-c headers. */

#ifndef LLVM_CONFIG_H
#define LLVM_CONFIG_H

/* Define if LLVM_ENABLE_DUMP is enabled */
#if defined(LLVM_ENABLE_DUMP)
#define LLVM_ENABLE_DUMP 1
#endif

/* Target triple LLVM will generate code for by default */
/* Doesn't use `cmakedefine` because it is allowed to be empty. */
#define LLVM_DEFAULT_TARGET_TRIPLE "x86_64-unknown-linux-gnu"

/* Define if threads are enabled */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_WINDOWS)
#define LLVM_ENABLE_THREADS 1
#endif

/* Has gcc/MSVC atomic intrinsics */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_WINDOWS)
#define LLVM_HAS_ATOMICS 1
#endif

/* Host triple LLVM will be executed on */
#define LLVM_HOST_TRIPLE "x86_64-unknown-linux-gnu"

/* LLVM architecture name for the native architecture, if available */
#define LLVM_NATIVE_ARCH "x86_64"

/* LLVM name for the native AsmParser init function, if available */
#define LLVM_NATIVE_ASMPARSER LLVMInitializeX86AsmParser

/* LLVM name for the native AsmPrinter init function, if available */
#define LLVM_NATIVE_ASMPRINTER LLVMInitializeX86AsmPrinter

/* LLVM name for the native Disassembler init function, if available */
#define LLVM_NATIVE_DISASSEMBLER LLVMInitializeX86Disassembler

/* LLVM name for the native Target init function, if available */
#define LLVM_NATIVE_TARGET LLVMInitializeX86Target

/* LLVM name for the native TargetInfo init function, if available */
#define LLVM_NATIVE_TARGETINFO LLVMInitializeX86TargetInfo

/* LLVM name for the native target MC init function, if available */
#define LLVM_NATIVE_TARGETMC LLVMInitializeX86TargetMC

/* LLVM name for the native target MCA init function, if available */
#define LLVM_NATIVE_TARGETMCA LLVMInitializeX86TargetMCA

/* Define if the AArch64 target is built in */
#if defined(LLVM_PLATFORM_AARCH64)
#define LLVM_HAS_AARCH64_TARGET 1
#endif

/* Define if the AMDGPU target is built in */
#if defined(LLVM_PLATFORM_AMDGPU)
#define LLVM_HAS_AMDGPU_TARGET 1
#endif

/* Define if the ARC target is built in */
#if defined(LLVM_PLATFORM_ARC)
#define LLVM_HAS_ARC_TARGET 1
#endif

/* Define if the ARM target is built in */
#if defined(LLVM_PLATFORM_ARM)
#define LLVM_HAS_ARM_TARGET 1
#endif

/* Define if the AVR target is built in */
#if defined(LLVM_PLATFORM_AVR)
#define LLVM_HAS_AVR_TARGET 1
#endif

/* Define if the BPF target is built in */
#if defined(LLVM_PLATFORM_BPF)
#define LLVM_HAS_BPF_TARGET 1
#endif

/* Define if the CSKY target is built in */
#if defined(LLVM_PLATFORM_CSKY)
#define LLVM_HAS_CSKY_TARGET 1
#endif

/* Define if the DirectX target is built in */
#if defined(LLVM_PLATFORM_DIRECTX)
#define LLVM_HAS_DIRECTX_TARGET 1
#endif

/* Define if the Hexagon target is built in */
#if defined(LLVM_PLATFORM_HEXAGON)
#define LLVM_HAS_HEXAGON_TARGET 1
#endif

/* Define if the Lanai target is built in */
#if defined(LLVM_PLATFORM_LANAI)
#define LLVM_HAS_LANAI_TARGET 1
#endif

/* Define if the LoongArch target is built in */
#if defined(LLVM_PLATFORM_LOONGARCH)
#define LLVM_HAS_LOONGARCH_TARGET 1
#endif

/* Define if the M68k target is built in */
#if defined(LLVM_PLATFORM_M68K)
#define LLVM_HAS_M68K_TARGET 1
#endif

/* Define if the Mips target is built in */
#if defined(LLVM_PLATFORM_MIPS)
#define LLVM_HAS_MIPS_TARGET 1
#endif

/* Define if the MSP430 target is built in */
#if defined(LLVM_PLATFORM_MSP430)
#define LLVM_HAS_MSP430_TARGET 1
#endif

/* Define if the NVPTX target is built in */
#if defined(LLVM_PLATFORM_NVPTX)
#define LLVM_HAS_NVPTX_TARGET 1
#endif

/* Define if the PowerPC target is built in */
#if defined(LLVM_PLATFORM_POWERPC)
#define LLVM_HAS_POWERPC_TARGET 1
#endif

/* Define if the RISCV target is built in */
#if defined(LLVM_PLATFORM_RISCV)
#define LLVM_HAS_RISCV_TARGET 1
#endif

/* Define if the Sparc target is built in */
#if defined(LLVM_PLATFORM_SPARC)
#define LLVM_HAS_SPARC_TARGET 1
#endif

/* Define if the SPIRV target is built in */
#if defined(LLVM_PLATFORM_SPIRV)
#define LLVM_HAS_SPIRV_TARGET 1
#endif

/* Define if the SystemZ target is built in */
#if defined(LLVM_PLATFORM_SYSTEMZ)
#define LLVM_HAS_SYSTEMZ_TARGET 1
#endif

/* Define if the VE target is built in */
#if defined(LLVM_PLATFORM_VE)
#define LLVM_HAS_VE_TARGET 1
#endif

/* Define if the WebAssembly target is built in */
#if defined(LLVM_PLATFORM_WEBASSEMBLY)
#define LLVM_HAS_WEBASSEMBLY_TARGET 1
#endif

/* Define if the X86 target is built in */
#if defined(LLVM_PLATFORM_X86)
#define LLVM_HAS_X86_TARGET 1
#endif

/* Define if the XCore target is built in */
#if defined(LLVM_PLATFORM_XCORE)
#define LLVM_HAS_XCORE_TARGET 1
#endif

/* Define if the Xtensa target is built in */
#if defined(LLVM_PLATFORM_XTENSA)
#define LLVM_HAS_XTENSA_TARGET 1
#endif

/* Define if this is a Unix-like LLVM_PLATFORM */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define LLVM_ON_UNIX 1
#endif

/* Define if we have the Intel JIT API runtime support library */
#if defined(LLVM_PLATFORM_INTEL_JIT)
#define LLVM_USE_INTEL_JITEVENTS 1
#endif

/* Define if we have the oprofile JIT-support library */
#if defined(LLVM_PLATFORM_OPROFILE)
#define LLVM_USE_OPROFILE 1
#endif

/* Define if we have the perf JIT-support library */
#if defined(LLVM_PLATFORM_PERF)
#define LLVM_USE_PERF 1
#endif

/* Major version of the LLVM API */
#define LLVM_VERSION_MAJOR 15

/* Minor version of the LLVM API */
#define LLVM_VERSION_MINOR 0

/* Patch version of the LLVM API */
#define LLVM_VERSION_PATCH 1

/* LLVM version string */
#define LLVM_VERSION_STRING "15.0.1"

/* Whether LLVM records statistics for use with GetStatistics(),
 * PrintStatistics() or PrintStatisticsJSON()
 */
#if defined(LLVM_PLATFORM_STATS)
#define LLVM_FORCE_ENABLE_STATS 1
#else
#define LLVM_FORCE_ENABLE_STATS 0
#endif

/* Define if we have z3 and want to build it */
#if defined(LLVM_PLATFORM_Z3)
#define LLVM_WITH_Z3 1
#endif

/* Define if we have curl and want to use it */
#if defined(LLVM_PLATFORM_CURL)
#define LLVM_ENABLE_CURL 1
#endif

#endif

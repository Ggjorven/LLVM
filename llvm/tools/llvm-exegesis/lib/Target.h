//===-- Target.h ------------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
///
/// Classes that handle the creation of target-specific objects. This is
/// similar to Target/TargetRegistry.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_TOOLS_LLVM_EXEGESIS_TARGET_H
#define LLVM_TOOLS_LLVM_EXEGESIS_TARGET_H

#include "BenchmarkResult.h"
#include "BenchmarkRunner.h"
#include "Error.h"
#include "LlvmState.h"
#include "PerfHelper.h"
#include "SnippetGenerator.h"
#include "ValidationEvent.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/CallingConv.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Error.h"
#include "llvm/TargetParser/SubtargetFeature.h"
#include "llvm/TargetParser/Triple.h"

namespace llvm {
namespace exegesis {

extern cl::OptionCategory Options;
extern cl::OptionCategory BenchmarkOptions;
extern cl::OptionCategory AnalysisOptions;

struct PfmCountersInfo {
  // An optional name of a performance counter that can be used to measure
  // cycles.
  const char *CycleCounter;

  // An optional name of a performance counter that can be used to measure
  // uops.
  const char *UopsCounter;

  // An IssueCounter specifies how to measure uops issued to specific proc
  // resources.
  struct IssueCounter {
    const char *Counter;
    // The name of the ProcResource that this counter measures.
    const char *ProcResName;
  };
  // An optional list of IssueCounters.
  const IssueCounter *IssueCounters;
  unsigned NumIssueCounters;

  const std::pair<ValidationEvent, const char *> *ValidationEvents;
  unsigned NumValidationEvents;

  static const PfmCountersInfo Default;
  static const PfmCountersInfo Dummy;
};

struct CpuAndPfmCounters {
  const char *CpuName;
  const PfmCountersInfo *PCI;
  bool operator<(StringRef S) const { return StringRef(CpuName) < S; }
};

class ExegesisTarget {
public:
  typedef bool (*OpcodeAvailabilityChecker)(unsigned, const FeatureBitset &);
  ExegesisTarget(ArrayRef<CpuAndPfmCounters> CpuPfmCounters,
                 OpcodeAvailabilityChecker IsOpcodeAvailable)
      : CpuPfmCounters(CpuPfmCounters), IsOpcodeAvailable(IsOpcodeAvailable) {}

  // Targets can use this to create target-specific perf counters.
  virtual Expected<std::unique_ptr<pfm::CounterGroup>>
  createCounter(StringRef CounterName, const LLVMState &State,
                ArrayRef<const char *> ValidationCounters,
                const pid_t ProcessID = 0) const;

  // Targets can use this to add target-specific passes in assembleToStream();
  virtual void addTargetSpecificPasses(PassManagerBase &PM) const {}

  // Generates code to move a constant into a the given register.
  // Precondition: Value must fit into Reg.
  virtual std::vector<MCInst> setRegTo(const MCSubtargetInfo &STI, unsigned Reg,
                                       const APInt &Value) const = 0;

  // Generates the code for the lower munmap call. The code generated by this
  // function may clobber registers.
  virtual void generateLowerMunmap(std::vector<MCInst> &GeneratedCode) const {
    report_fatal_error(
        "generateLowerMunmap is not implemented on the current architecture");
  }

  // Generates the upper munmap call. The code generated by this function may
  // clobber registers.
  virtual void generateUpperMunmap(std::vector<MCInst> &GeneratedCode) const {
    report_fatal_error(
        "generateUpperMunmap is not implemented on the current architecture");
  }

  // Generates the code for an exit syscall. The code generated by this function
  // may clobber registers.
  virtual std::vector<MCInst> generateExitSyscall(unsigned ExitCode) const {
    report_fatal_error(
        "generateExitSyscall is not implemented on the current architecture");
  }

  // Generates the code to mmap a region of code. The code generated by this
  // function may clobber registers.
  virtual std::vector<MCInst>
  generateMmap(uintptr_t Address, size_t Length,
               uintptr_t FileDescriptorAddress) const {
    report_fatal_error(
        "generateMmap is not implemented on the current architecture");
  }

  // Generates the mmap code for the aux memory. The code generated by this
  // function may clobber registers.
  virtual void generateMmapAuxMem(std::vector<MCInst> &GeneratedCode) const {
    report_fatal_error(
        "generateMmapAuxMem is not implemented on the current architecture\n");
  }

  // Moves argument registers into other registers that won't get clobbered
  // while making syscalls. The code generated by this function may clobber
  // registers.
  virtual void moveArgumentRegisters(std::vector<MCInst> &GeneratedCode) const {
    report_fatal_error("moveArgumentRegisters is not implemented on the "
                       "current architecture\n");
  }

  // Generates code to move argument registers, unmap memory above and below the
  // snippet, and map the auxiliary memory into the subprocess. The code
  // generated by this function may clobber registers.
  virtual std::vector<MCInst> generateMemoryInitialSetup() const {
    report_fatal_error("generateMemoryInitialSetup is not supported on the "
                       "current architecture\n");
  }

  // Returns true if all features are available that are required by Opcode.
  virtual bool isOpcodeAvailable(unsigned Opcode,
                                 const FeatureBitset &Features) const {
    return IsOpcodeAvailable(Opcode, Features);
  }

  // Sets the stack register to the auxiliary memory so that operations
  // requiring the stack can be formed (e.g., setting large registers). The code
  // generated by this function may clobber registers.
  virtual std::vector<MCInst> setStackRegisterToAuxMem() const {
    report_fatal_error("setStackRegisterToAuxMem is not implemented on the "
                       "current architectures");
  }

  virtual uintptr_t getAuxiliaryMemoryStartAddress() const {
    report_fatal_error("getAuxiliaryMemoryStartAddress is not implemented on "
                       "the current architecture");
  }

  // Generates the necessary ioctl system calls to configure the perf counters.
  // The code generated by this function preserves all registers if the
  // parameter SaveRegisters is set to true.
  virtual std::vector<MCInst> configurePerfCounter(long Request,
                                                   bool SaveRegisters) const {
    report_fatal_error(
        "configurePerfCounter is not implemented on the current architecture");
  }

  // Gets the ABI dependent registers that are used to pass arguments in a
  // function call.
  virtual std::vector<unsigned> getArgumentRegisters() const {
    report_fatal_error(
        "getArgumentRegisters is not implemented on the current architecture");
  };

  // Gets the registers that might potentially need to be saved by while
  // the setup in the test harness executes.
  virtual std::vector<unsigned> getRegistersNeedSaving() const {
    report_fatal_error("getRegistersNeedSaving is not implemented on the "
                       "current architecture");
  };

  // Returns the register pointing to scratch memory, or 0 if this target
  // does not support memory operands. The benchmark function uses the
  // default calling convention.
  virtual unsigned getScratchMemoryRegister(const Triple &) const { return 0; }

  // Fills memory operands with references to the address at [Reg] + Offset.
  virtual void fillMemoryOperands(InstructionTemplate &IT, unsigned Reg,
                                  unsigned Offset) const {
    llvm_unreachable(
        "fillMemoryOperands() requires getScratchMemoryRegister() > 0");
  }

  // Returns a counter usable as a loop counter.
  virtual unsigned getDefaultLoopCounterRegister(const Triple &) const {
    return 0;
  }

  // Adds the code to decrement the loop counter and
  virtual void decrementLoopCounterAndJump(MachineBasicBlock &MBB,
                                           MachineBasicBlock &TargetMBB,
                                           const MCInstrInfo &MII,
                                           unsigned LoopRegister) const {
    llvm_unreachable("decrementLoopCounterAndBranch() requires "
                     "getLoopCounterRegister() > 0");
  }

  // Returns a list of unavailable registers.
  // Targets can use this to prevent some registers to be automatically selected
  // for use in snippets.
  virtual ArrayRef<unsigned> getUnavailableRegisters() const { return {}; }

  // Returns the maximum number of bytes a load/store instruction can access at
  // once. This is typically the size of the largest register available on the
  // processor. Note that this only used as a hint to generate independant
  // load/stores to/from memory, so the exact returned value does not really
  // matter as long as it's large enough.
  virtual unsigned getMaxMemoryAccessSize() const { return 0; }

  // Assigns a random operand of the right type to variable Var.
  // The target is responsible for handling any operand starting from
  // OPERAND_FIRST_TARGET.
  virtual Error randomizeTargetMCOperand(const Instruction &Instr,
                                         const Variable &Var,
                                         MCOperand &AssignedValue,
                                         const BitVector &ForbiddenRegs) const {
    return make_error<Failure>(
        "targets with target-specific operands should implement this");
  }

  // Returns true if this instruction is supported as a back-to-back
  // instructions.
  // FIXME: Eventually we should discover this dynamically.
  virtual bool allowAsBackToBack(const Instruction &Instr) const {
    return true;
  }

  // For some instructions, it is interesting to measure how it's performance
  // characteristics differ depending on it's operands.
  // This allows us to produce all the interesting variants.
  virtual std::vector<InstructionTemplate>
  generateInstructionVariants(const Instruction &Instr,
                              unsigned MaxConfigsPerOpcode) const {
    // By default, we're happy with whatever randomizer will give us.
    return {&Instr};
  }

  // Checks hardware and software support for current benchmark mode.
  // Returns an error if the target host does not have support to run the
  // benchmark.
  virtual Error checkFeatureSupport() const { return Error::success(); }

  // Creates a snippet generator for the given mode.
  std::unique_ptr<SnippetGenerator>
  createSnippetGenerator(Benchmark::ModeE Mode,
                         const LLVMState &State,
                         const SnippetGenerator::Options &Opts) const;
  // Creates a benchmark runner for the given mode.
  Expected<std::unique_ptr<BenchmarkRunner>> createBenchmarkRunner(
      Benchmark::ModeE Mode, const LLVMState &State,
      BenchmarkPhaseSelectorE BenchmarkPhaseSelector,
      BenchmarkRunner::ExecutionModeE ExecutionMode,
      unsigned BenchmarkRepeatCount,
      ArrayRef<ValidationEvent> ValidationCounters,
      Benchmark::ResultAggregationModeE ResultAggMode = Benchmark::Min) const;

  // Returns the ExegesisTarget for the given triple or nullptr if the target
  // does not exist.
  static const ExegesisTarget *lookup(Triple TT);
  // Returns the default (unspecialized) ExegesisTarget.
  static const ExegesisTarget &getDefault();
  // Registers a target. Not thread safe.
  static void registerTarget(ExegesisTarget *T);

  virtual ~ExegesisTarget();

  // Returns the Pfm counters for the given CPU (or the default if no pfm
  // counters are defined for this CPU).
  const PfmCountersInfo &getPfmCounters(StringRef CpuName) const;

  // Returns dummy Pfm counters which can be used to execute generated snippet
  // without access to performance counters.
  const PfmCountersInfo &getDummyPfmCounters() const;

  // Saves the CPU state that needs to be preserved when running a benchmark,
  // and returns and RAII object that restores the state on destruction.
  // By default no state is preserved.
  struct SavedState {
    virtual ~SavedState();
  };
  virtual std::unique_ptr<SavedState> withSavedState() const {
    return std::make_unique<SavedState>();
  }

private:
  virtual bool matchesArch(Triple::ArchType Arch) const = 0;

  // Targets can implement their own snippet generators/benchmarks runners by
  // implementing these.
  std::unique_ptr<SnippetGenerator> virtual createSerialSnippetGenerator(
      const LLVMState &State, const SnippetGenerator::Options &Opts) const;
  std::unique_ptr<SnippetGenerator> virtual createParallelSnippetGenerator(
      const LLVMState &State, const SnippetGenerator::Options &Opts) const;
  std::unique_ptr<BenchmarkRunner> virtual createLatencyBenchmarkRunner(
      const LLVMState &State, Benchmark::ModeE Mode,
      BenchmarkPhaseSelectorE BenchmarkPhaseSelector,
      Benchmark::ResultAggregationModeE ResultAggMode,
      BenchmarkRunner::ExecutionModeE ExecutionMode,
      ArrayRef<ValidationEvent> ValidationCounters,
      unsigned BenchmarkRepeatCount) const;
  std::unique_ptr<BenchmarkRunner> virtual createUopsBenchmarkRunner(
      const LLVMState &State, BenchmarkPhaseSelectorE BenchmarkPhaseSelector,
      Benchmark::ResultAggregationModeE ResultAggMode,
      BenchmarkRunner::ExecutionModeE ExecutionMode,
      ArrayRef<ValidationEvent> ValidationCounters) const;

  const ExegesisTarget *Next = nullptr;
  const ArrayRef<CpuAndPfmCounters> CpuPfmCounters;
  const OpcodeAvailabilityChecker IsOpcodeAvailable;
};

} // namespace exegesis
} // namespace llvm

#endif // LLVM_TOOLS_LLVM_EXEGESIS_TARGET_H

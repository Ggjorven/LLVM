#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/MC/TargetRegistry.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Support/InitLLVM.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/TargetParser/Host.h>
#include <llvm/MC/TargetRegistry.h>

#include <lld/Common/Driver.h>

LLD_HAS_DRIVER(elf)
LLD_HAS_DRIVER(coff)

int main(int argc, char** argv)
{
    llvm::InitLLVM X(argc, argv);
    llvm::LLVMContext context;
    llvm::Module module("my_module", context);

    // Create the main function: int main()
    llvm::FunctionType* funcType = llvm::FunctionType::get(llvm::Type::getInt32Ty(context), false);
    llvm::Function* mainFunc = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", module);

    // Create the entry basic block for the main function
    llvm::BasicBlock* entry = llvm::BasicBlock::Create(context, "entry", mainFunc);

    // Build the return instruction: return 23;
    llvm::IRBuilder<> builder(entry);
    builder.CreateRet(llvm::ConstantInt::get(llvm::Type::getInt32Ty(context), 23));

    // Verify the module to ensure it's correct
    if (llvm::verifyModule(module, &llvm::errs()))
    {
        llvm::errs() << "Module verification failed\n";
        return 1;
    }

    // Initialize the target registry and machine
    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmPrinter();
    llvm::InitializeNativeTargetAsmParser();

    // Get the target triple
    std::string targetTriple = llvm::sys::getProcessTriple();
    module.setTargetTriple(targetTriple);

    std::string error;
    const llvm::Target* target = llvm::TargetRegistry::lookupTarget(targetTriple, error);

    if (!target)
    {
        llvm::errs() << "Error: " << error << "\n";
        return 1;
    }

    // Create target machine
    llvm::TargetOptions opt;
    auto CPU = llvm::sys::getHostCPUName();

    llvm::StringMap<bool> Features = llvm::sys::getHostCPUFeatures();
    std::string featuresStr;
    for (auto& Feature : Features)
    {
        if (Feature.second)
            featuresStr += "+" + Feature.first().str() + ",";
    }

    llvm::TargetMachine* targetMachine = target->createTargetMachine(targetTriple, CPU, featuresStr, opt, std::optional<llvm::Reloc::Model>());

    module.setDataLayout(targetMachine->createDataLayout());

    // Create the output .o file
    std::error_code EC;
    llvm::raw_fd_ostream dest("output.o", EC, llvm::sys::fs::OF_None);

    if (EC)
    {
        llvm::errs() << "Could not open file: " << EC.message() << "\n";
        return 1;
    }

    // Emit object file
    llvm::legacy::PassManager pass;
    llvm::CodeGenFileType fileType = llvm::CodeGenFileType::ObjectFile;

    if (targetMachine->addPassesToEmitFile(pass, dest, nullptr, fileType))
    {
        llvm::errs() << "TargetMachine can't emit a file of this type\n";
        return 1;
    }

    pass.run(module);
    dest.flush();

    llvm::outs() << "Object file 'output.o' has been generated.\n";

#if defined(APP_PLATFORM_WINDOWS)
    const char* args[] = {
        "lld",                      // Linking app

        "output.o",                 // Input object file

        "libcmt.lib",               // Static CRT library
        //"kernel32.lib",             // Windows system libraries
        //"user32.lib"                // Windows system libraries (if needed)
    };

    if (!lld::coff::link(args, llvm::outs(), llvm::errs(), false, false))
    {
        llvm::errs() << "Linking failed\n";
        return 1;
    }
    llvm::outs() << "Linking successful\n";

#elif defined(APP_PLATFORM_LINUX)
    const char* args[] = {
        "lld",                      // Linking app

        "output.o",                 // Input object file
    };

    if (!lld::elf::link(args, llvm::outs(), llvm::errs(), false, false))
    {
        llvm::errs() << "Linking failed\n";
        return 1;
    }
    llvm::outs() << "Linking successful\n";
#endif

    return 0;
}

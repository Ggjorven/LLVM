#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>

int main() 
{
    // Initialize LLVM components
    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmPrinter();
    llvm::LLVMContext context;

    // Create a new module
    std::unique_ptr<llvm::Module> module = std::make_unique<llvm::Module>("test_module", context);

    // Create a function signature (int32_t foo())
    llvm::FunctionType* functionType = llvm::FunctionType::get(llvm::Type::getInt32Ty(context), false);
    llvm::Function* fooFunction = llvm::Function::Create(functionType, llvm::Function::ExternalLinkage, "foo", module.get());

    // Create a basic block and set an IR builder to insert instructions
    llvm::BasicBlock* entryBlock = llvm::BasicBlock::Create(context, "entry", fooFunction);
    llvm::IRBuilder<> builder(entryBlock);

    // Return a constant value (e.g., return 42;)
    builder.CreateRet(llvm::ConstantInt::get(llvm::Type::getInt32Ty(context), 42));

    // Verify the generated module
    if (llvm::verifyFunction(*fooFunction, &llvm::errs())) {
        llvm::errs() << "Function verification failed!\n";
        return 1;
    }

    // Print the LLVM IR to stdout
    module->print(llvm::outs(), nullptr);

    return 0;
}

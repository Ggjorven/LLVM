#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/raw_ostream.h"

int main() {
    // Create a new LLVM context, module, and builder
    llvm::LLVMContext context;
    llvm::Module module("test", context);
    llvm::IRBuilder<> builder(context);

    // Define the return type (int) and the function signature (no arguments)
    llvm::FunctionType* funcType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    llvm::Function* mainFunction = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", module);

    // Create a basic block in the function and set the insertion point
    llvm::BasicBlock* block = llvm::BasicBlock::Create(context, "entry", mainFunction);
    builder.SetInsertPoint(block);

    // Add a return instruction (returning 42)
    builder.CreateRet(llvm::ConstantInt::get(context, llvm::APInt(32, 42)));

    // Verify the function and module
    llvm::verifyFunction(*mainFunction);
    llvm::verifyModule(module, &llvm::errs());

    // Print the generated LLVM IR to the standard output
    module.print(llvm::outs(), nullptr);

    return 0;
}

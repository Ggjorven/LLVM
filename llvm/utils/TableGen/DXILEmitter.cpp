//===- DXILEmitter.cpp - DXIL operation Emitter ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// DXILEmitter uses the descriptions of DXIL operation to construct enum and
// helper functions for DXIL operation.
//
//===----------------------------------------------------------------------===//

#include "Basic/SequenceToOffsetTable.h"
#include "Common/CodeGenTarget.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/StringSet.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/Support/DXILABI.h"
#include "llvm/Support/VersionTuple.h"
#include "llvm/TableGen/Error.h"
#include "llvm/TableGen/Record.h"
#include "llvm/TableGen/TableGenBackend.h"

#include <string>
#include <vector>

using namespace llvm;
using namespace llvm::dxil;

namespace {

struct DXILOperationDesc {
  std::string OpName; // name of DXIL operation
  int OpCode;         // ID of DXIL operation
  StringRef OpClass;  // name of the opcode class
  StringRef Doc;      // the documentation description of this instruction
  // Vector of operand type records - return type is at index 0
  SmallVector<const Record *> OpTypes;
  SmallVector<const Record *> OverloadRecs;
  SmallVector<const Record *> StageRecs;
  SmallVector<const Record *> AttrRecs;
  StringRef Intrinsic; // The llvm intrinsic map to OpName. Default is "" which
                       // means no map exists
  SmallVector<StringRef, 4>
      ShaderStages; // shader stages to which this applies, empty for all.
  int OverloadParamIndex;             // Index of parameter with overload type.
                                      //   -1 : no overload types
  SmallVector<StringRef, 4> counters; // counters for this inst.
  DXILOperationDesc(const Record *);
};
} // end anonymous namespace

/// In-place sort TableGen records of class with a field
///    Version dxil_version
/// in the ascending version order.
static void AscendingSortByVersion(std::vector<const Record *> &Recs) {
  sort(Recs, [](const Record *RecA, const Record *RecB) {
    unsigned RecAMaj =
        RecA->getValueAsDef("dxil_version")->getValueAsInt("Major");
    unsigned RecAMin =
        RecA->getValueAsDef("dxil_version")->getValueAsInt("Minor");
    unsigned RecBMaj =
        RecB->getValueAsDef("dxil_version")->getValueAsInt("Major");
    unsigned RecBMin =
        RecB->getValueAsDef("dxil_version")->getValueAsInt("Minor");

    return (VersionTuple(RecAMaj, RecAMin) < VersionTuple(RecBMaj, RecBMin));
  });
}

/// Construct an object using the DXIL Operation records specified
/// in DXIL.td. This serves as the single source of reference of
/// the information extracted from the specified Record R, for
/// C++ code generated by this TableGen backend.
//  \param R Object representing TableGen record of a DXIL Operation
DXILOperationDesc::DXILOperationDesc(const Record *R) {
  OpName = R->getNameInitAsString();
  OpCode = R->getValueAsInt("OpCode");

  Doc = R->getValueAsString("Doc");
  SmallVector<const Record *> ParamTypeRecs;

  ParamTypeRecs.push_back(R->getValueAsDef("result"));

  for (const Record *ArgTy : R->getValueAsListOfDefs("arguments")) {
    ParamTypeRecs.push_back(ArgTy);
  }
  size_t ParamTypeRecsSize = ParamTypeRecs.size();
  // Populate OpTypes with return type and parameter types

  // Parameter indices of overloaded parameters.
  // This vector contains overload parameters in the order used to
  // resolve an LLVMMatchType in accordance with  convention outlined in
  // the comment before the definition of class LLVMMatchType in
  // llvm/IR/Intrinsics.td
  OverloadParamIndex = -1; // A sigil meaning none.
  for (unsigned i = 0; i < ParamTypeRecsSize; i++) {
    const Record *TR = ParamTypeRecs[i];
    // Track operation parameter indices of any overload types
    if (TR->getValueAsInt("isOverload")) {
      if (OverloadParamIndex != -1) {
        assert(TR == ParamTypeRecs[OverloadParamIndex] &&
               "Specification of multiple differing overload parameter types "
               "is not supported");
      }
      // Keep the earliest parameter index we see, but if it was the return type
      // overwrite it with the first overloaded argument.
      if (OverloadParamIndex <= 0)
        OverloadParamIndex = i;
    }
    OpTypes.emplace_back(TR);
  }

  // Get overload records
  std::vector<const Record *> Recs = R->getValueAsListOfConstDefs("overloads");

  // Sort records in ascending order of DXIL version
  AscendingSortByVersion(Recs);

  for (const Record *CR : Recs) {
    OverloadRecs.push_back(CR);
  }

  // Get stage records
  Recs = R->getValueAsListOfConstDefs("stages");

  if (Recs.empty()) {
    PrintFatalError(R, Twine("Atleast one specification of valid stage for ") +
                           OpName + " is required");
  }

  // Sort records in ascending order of DXIL version
  AscendingSortByVersion(Recs);

  for (const Record *CR : Recs) {
    StageRecs.push_back(CR);
  }

  // Get attribute records
  Recs = R->getValueAsListOfConstDefs("attributes");

  // Sort records in ascending order of DXIL version
  AscendingSortByVersion(Recs);

  for (const Record *CR : Recs) {
    AttrRecs.push_back(CR);
  }

  // Get the operation class
  OpClass = R->getValueAsDef("OpClass")->getName();

  if (!OpClass.str().compare("UnknownOpClass")) {
    PrintFatalError(R, Twine("Unspecified DXIL OpClass for DXIL operation - ") +
                           OpName);
  }

  const RecordVal *RV = R->getValue("LLVMIntrinsic");
  if (RV && RV->getValue()) {
    if (DefInit *DI = dyn_cast<DefInit>(RV->getValue())) {
      auto *IntrinsicDef = DI->getDef();
      auto DefName = IntrinsicDef->getName();
      assert(DefName.starts_with("int_") && "invalid intrinsic name");
      // Remove the int_ from intrinsic name.
      Intrinsic = DefName.substr(4);
    }
  }
}

/// Return a string representation of OverloadKind enum that maps to
/// input LLVMType record
/// \param R TableGen def record of class LLVMType
/// \return std::string string representation of OverloadKind

static StringRef getOverloadKindStr(const Record *R) {
  // TODO: This is a hack. We need to rework how we're handling the set of
  // overloads to avoid this business with the separate OverloadKind enum.
  return StringSwitch<StringRef>(R->getName())
      .Case("HalfTy", "OverloadKind::HALF")
      .Case("FloatTy", "OverloadKind::FLOAT")
      .Case("DoubleTy", "OverloadKind::DOUBLE")
      .Case("Int1Ty", "OverloadKind::I1")
      .Case("Int8Ty", "OverloadKind::I8")
      .Case("Int16Ty", "OverloadKind::I16")
      .Case("Int32Ty", "OverloadKind::I32")
      .Case("Int64Ty", "OverloadKind::I64")
      .Case("ResRetHalfTy", "OverloadKind::HALF")
      .Case("ResRetFloatTy", "OverloadKind::FLOAT")
      .Case("ResRetInt16Ty", "OverloadKind::I16")
      .Case("ResRetInt32Ty", "OverloadKind::I32");
}

/// Return a string representation of valid overload information denoted
// by input records
//
/// \param Recs A vector of records of TableGen Overload records
/// \return std::string string representation of overload mask string
///         predicated by DXIL Version. E.g.,
//          {{{1, 0}, Mask1}, {{1, 2}, Mask2}, ...}
static std::string getOverloadMaskString(ArrayRef<const Record *> Recs) {
  std::string MaskString = "";
  std::string Prefix = "";
  MaskString.append("{");
  // If no overload information records were specified, assume the operation
  // a) to be supported in DXIL Version 1.0 and later
  // b) has no overload types
  if (Recs.empty()) {
    MaskString.append("{{1, 0}, OverloadKind::UNDEFINED}}");
  } else {
    for (auto Rec : Recs) {
      unsigned Major =
          Rec->getValueAsDef("dxil_version")->getValueAsInt("Major");
      unsigned Minor =
          Rec->getValueAsDef("dxil_version")->getValueAsInt("Minor");
      MaskString.append(Prefix)
          .append("{{")
          .append(std::to_string(Major))
          .append(", ")
          .append(std::to_string(Minor).append("}, "));

      std::string PipePrefix = "";
      auto Tys = Rec->getValueAsListOfDefs("overload_types");
      if (Tys.empty()) {
        MaskString.append("OverloadKind::UNDEFINED");
      }
      for (const auto *Ty : Tys) {
        MaskString.append(PipePrefix).append(getOverloadKindStr(Ty));
        PipePrefix = " | ";
      }

      MaskString.append("}");
      Prefix = ", ";
    }
    MaskString.append("}");
  }
  return MaskString;
}

/// Return a string representation of valid shader stag information denoted
// by input records
//
/// \param Recs A vector of records of TableGen Stages records
/// \return std::string string representation of stages mask string
///         predicated by DXIL Version. E.g.,
//          {{{1, 0}, Mask1}, {{1, 2}, Mask2}, ...}
static std::string getStageMaskString(ArrayRef<const Record *> Recs) {
  std::string MaskString = "";
  std::string Prefix = "";
  MaskString.append("{");
  // Atleast one stage information record is expected to be specified.
  if (Recs.empty()) {
    PrintFatalError("Atleast one specification of valid stages for "
                    "operation must be specified");
  }

  for (auto Rec : Recs) {
    unsigned Major = Rec->getValueAsDef("dxil_version")->getValueAsInt("Major");
    unsigned Minor = Rec->getValueAsDef("dxil_version")->getValueAsInt("Minor");
    MaskString.append(Prefix)
        .append("{{")
        .append(std::to_string(Major))
        .append(", ")
        .append(std::to_string(Minor).append("}, "));

    std::string PipePrefix = "";
    auto Stages = Rec->getValueAsListOfDefs("shader_stages");
    if (Stages.empty()) {
      PrintFatalError("No valid stages for operation specified");
    }
    for (const auto *S : Stages) {
      MaskString.append(PipePrefix).append("ShaderKind::").append(S->getName());
      PipePrefix = " | ";
    }

    MaskString.append("}");
    Prefix = ", ";
  }
  MaskString.append("}");
  return MaskString;
}

/// Return a string representation of valid attribute information denoted
// by input records
//
/// \param Recs A vector of records of TableGen Attribute records
/// \return std::string string representation of stages mask string
///         predicated by DXIL Version. E.g.,
//          {{{1, 0}, Mask1}, {{1, 2}, Mask2}, ...}
static std::string getAttributeMaskString(ArrayRef<const Record *> Recs) {
  std::string MaskString = "";
  std::string Prefix = "";
  MaskString.append("{");

  for (auto Rec : Recs) {
    unsigned Major = Rec->getValueAsDef("dxil_version")->getValueAsInt("Major");
    unsigned Minor = Rec->getValueAsDef("dxil_version")->getValueAsInt("Minor");
    MaskString.append(Prefix)
        .append("{{")
        .append(std::to_string(Major))
        .append(", ")
        .append(std::to_string(Minor).append("}, "));

    std::string PipePrefix = "";
    auto Attrs = Rec->getValueAsListOfDefs("op_attrs");
    if (Attrs.empty()) {
      MaskString.append("Attribute::None");
    } else {
      for (const auto *Attr : Attrs) {
        MaskString.append(PipePrefix)
            .append("Attribute::")
            .append(Attr->getName());
        PipePrefix = " | ";
      }
    }

    MaskString.append("}");
    Prefix = ", ";
  }
  MaskString.append("}");
  return MaskString;
}

/// Emit a mapping of DXIL opcode to opname
static void emitDXILOpCodes(ArrayRef<DXILOperationDesc> Ops, raw_ostream &OS) {
  OS << "#ifdef DXIL_OPCODE\n";
  for (const DXILOperationDesc &Op : Ops)
    OS << "DXIL_OPCODE(" << Op.OpCode << ", " << Op.OpName << ")\n";
  OS << "#undef DXIL_OPCODE\n";
  OS << "\n";
  OS << "#endif\n\n";
}

/// Emit a list of DXIL op classes
static void emitDXILOpClasses(const RecordKeeper &Records, raw_ostream &OS) {
  OS << "#ifdef DXIL_OPCLASS\n";
  for (const Record *OpClass : Records.getAllDerivedDefinitions("DXILOpClass"))
    OS << "DXIL_OPCLASS(" << OpClass->getName() << ")\n";
  OS << "#undef DXIL_OPCLASS\n";
  OS << "#endif\n\n";
}

/// Emit a list of DXIL op parameter types
static void emitDXILOpParamTypes(const RecordKeeper &Records, raw_ostream &OS) {
  OS << "#ifdef DXIL_OP_PARAM_TYPE\n";
  for (const Record *OpParamType :
       Records.getAllDerivedDefinitions("DXILOpParamType"))
    OS << "DXIL_OP_PARAM_TYPE(" << OpParamType->getName() << ")\n";
  OS << "#undef DXIL_OP_PARAM_TYPE\n";
  OS << "#endif\n\n";
}

/// Emit a list of DXIL op function types
static void emitDXILOpFunctionTypes(ArrayRef<DXILOperationDesc> Ops,
                                    raw_ostream &OS) {
  OS << "#ifndef DXIL_OP_FUNCTION_TYPE\n";
  OS << "#define DXIL_OP_FUNCTION_TYPE(OpCode, RetType, ...)\n";
  OS << "#endif\n";
  for (const DXILOperationDesc &Op : Ops) {
    OS << "DXIL_OP_FUNCTION_TYPE(dxil::OpCode::" << Op.OpName;
    for (const Record *Rec : Op.OpTypes)
      OS << ", dxil::OpParamType::" << Rec->getName();
    // If there are no arguments, we need an empty comma for the varargs
    if (Op.OpTypes.size() == 1)
      OS << ", ";
    OS << ")\n";
  }
  OS << "#undef DXIL_OP_FUNCTION_TYPE\n";
}

/// Emit map of DXIL operation to LLVM or DirectX intrinsic
/// \param A vector of DXIL Ops
/// \param Output stream
static void emitDXILIntrinsicMap(ArrayRef<DXILOperationDesc> Ops,
                                 raw_ostream &OS) {
  OS << "#ifdef DXIL_OP_INTRINSIC\n";
  OS << "\n";
  for (const auto &Op : Ops) {
    if (Op.Intrinsic.empty())
      continue;
    OS << "DXIL_OP_INTRINSIC(dxil::OpCode::" << Op.OpName
       << ", Intrinsic::" << Op.Intrinsic << ")\n";
  }
  OS << "\n";
  OS << "#undef DXIL_OP_INTRINSIC\n";
  OS << "#endif\n\n";
}

/// Emit DXIL operation table
/// \param A vector of DXIL Ops
/// \param Output stream
static void emitDXILOperationTable(ArrayRef<DXILOperationDesc> Ops,
                                   raw_ostream &OS) {
  // Collect Names.
  SequenceToOffsetTable<std::string> OpClassStrings;
  SequenceToOffsetTable<std::string> OpStrings;

  StringSet<> ClassSet;
  for (const auto &Op : Ops) {
    OpStrings.add(Op.OpName);

    if (ClassSet.insert(Op.OpClass).second)
      OpClassStrings.add(Op.OpClass.data());
  }

  // Layout names.
  OpStrings.layout();
  OpClassStrings.layout();

  // Emit access function getOpcodeProperty() that embeds DXIL Operation table
  // with entries of type struct OpcodeProperty.
  OS << "static const OpCodeProperty *getOpCodeProperty(dxil::OpCode Op) "
        "{\n";

  OS << "  static const OpCodeProperty OpCodeProps[] = {\n";
  std::string Prefix = "";
  for (const auto &Op : Ops) {
    OS << Prefix << "  { dxil::OpCode::" << Op.OpName << ", "
       << OpStrings.get(Op.OpName) << ", OpCodeClass::" << Op.OpClass << ", "
       << OpClassStrings.get(Op.OpClass.data()) << ", "
       << getOverloadMaskString(Op.OverloadRecs) << ", "
       << getStageMaskString(Op.StageRecs) << ", "
       << getAttributeMaskString(Op.AttrRecs) << ", " << Op.OverloadParamIndex
       << " }";
    Prefix = ",\n";
  }
  OS << "  };\n";

  OS << "  // FIXME: change search to indexing with\n";
  OS << "  // Op once all DXIL operations are added.\n";
  OS << "  OpCodeProperty TmpProp;\n";
  OS << "  TmpProp.OpCode = Op;\n";
  OS << "  const OpCodeProperty *Prop =\n";
  OS << "      llvm::lower_bound(OpCodeProps, TmpProp,\n";
  OS << "                        [](const OpCodeProperty &A, const "
        "OpCodeProperty &B) {\n";
  OS << "                          return A.OpCode < B.OpCode;\n";
  OS << "                        });\n";
  OS << "  assert(Prop && \"failed to find OpCodeProperty\");\n";
  OS << "  return Prop;\n";
  OS << "}\n\n";

  // Emit the string tables.
  OS << "static const char *getOpCodeName(dxil::OpCode Op) {\n\n";

  OpStrings.emitStringLiteralDef(OS,
                                 "  static const char DXILOpCodeNameTable[]");

  OS << "  auto *Prop = getOpCodeProperty(Op);\n";
  OS << "  unsigned Index = Prop->OpCodeNameOffset;\n";
  OS << "  return DXILOpCodeNameTable + Index;\n";
  OS << "}\n\n";

  OS << "static const char *getOpCodeClassName(const OpCodeProperty &Prop) "
        "{\n\n";

  OpClassStrings.emitStringLiteralDef(
      OS, "  static const char DXILOpCodeClassNameTable[]");

  OS << "  unsigned Index = Prop.OpCodeClassNameOffset;\n";
  OS << "  return DXILOpCodeClassNameTable + Index;\n";
  OS << "}\n\n";
}

static void emitDXILOperationTableDataStructs(const RecordKeeper &Records,
                                              raw_ostream &OS) {
  // Get Shader stage records
  std::vector<const Record *> ShaderKindRecs =
      Records.getAllDerivedDefinitions("DXILShaderStage");
  // Sort records by name
  llvm::sort(ShaderKindRecs, [](const Record *A, const Record *B) {
    return A->getName() < B->getName();
  });

  OS << "// Valid shader kinds\n\n";
  // Choose the type of enum ShaderKind based on the number of stages declared.
  // This gives the flexibility to just add add new stage records in DXIL.td, if
  // needed, with no need to change this backend code.
  size_t ShaderKindCount = ShaderKindRecs.size();
  uint64_t ShaderKindTySz = PowerOf2Ceil(ShaderKindRecs.size() + 1);
  OS << "enum ShaderKind : uint" << ShaderKindTySz << "_t {\n";
  const std::string allStages("all_stages");
  const std::string removed("removed");
  int shiftVal = 1;
  for (auto R : ShaderKindRecs) {
    auto Name = R->getName();
    if (Name.compare(removed) == 0) {
      OS << "  " << Name
         << " =  0,  // Pseudo-stage indicating op not supported in any "
            "stage\n";
    } else if (Name.compare(allStages) == 0) {
      OS << "  " << Name << " =  0x"
         << utohexstr(((1 << ShaderKindCount) - 1), false, 0)
         << ", // Pseudo-stage indicating op is supported in all stages\n";
    } else if (Name.compare(allStages)) {
      OS << "  " << Name << " = 1 << " << std::to_string(shiftVal++) << ",\n";
    }
  }
  OS << "}; // enum ShaderKind\n\n";
}

/// Entry function call that invokes the functionality of this TableGen backend
/// \param Records TableGen records of DXIL Operations defined in DXIL.td
/// \param OS output stream
static void EmitDXILOperation(const RecordKeeper &Records, raw_ostream &OS) {
  OS << "// Generated code, do not edit.\n";
  OS << "\n";
  // Get all DXIL Ops property records
  std::vector<DXILOperationDesc> DXILOps;
  for (const Record *R : Records.getAllDerivedDefinitions("DXILOp")) {
    DXILOps.emplace_back(DXILOperationDesc(R));
  }
  // Sort by opcode.
  llvm::sort(DXILOps,
             [](const DXILOperationDesc &A, const DXILOperationDesc &B) {
               return A.OpCode < B.OpCode;
             });
  int PrevOp = -1;
  for (const DXILOperationDesc &Desc : DXILOps) {
    if (Desc.OpCode == PrevOp)
      PrintFatalError(Twine("Duplicate opcode: ") + Twine(Desc.OpCode));
    PrevOp = Desc.OpCode;
  }

  emitDXILOpCodes(DXILOps, OS);
  emitDXILOpClasses(Records, OS);
  emitDXILOpParamTypes(Records, OS);
  emitDXILOpFunctionTypes(DXILOps, OS);
  emitDXILIntrinsicMap(DXILOps, OS);
  OS << "#ifdef DXIL_OP_OPERATION_TABLE\n\n";
  emitDXILOperationTableDataStructs(Records, OS);
  emitDXILOperationTable(DXILOps, OS);
  OS << "#undef DXIL_OP_OPERATION_TABLE\n";
  OS << "#endif\n\n";
}

static TableGen::Emitter::Opt X("gen-dxil-operation", EmitDXILOperation,
                                "Generate DXIL operation information");

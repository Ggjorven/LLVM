/*===- TableGen'erated file -------------------------------------*- C++ -*-===*\
|*                                                                            *|
|* Intrinsic Function Source Fragment                                         *|
|*                                                                            *|
|* Automatically generated file, do not edit!                                 *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/

#ifndef LLVM_IR_INTRINSIC_DX_ENUMS_H
#define LLVM_IR_INTRINSIC_DX_ENUMS_H
namespace llvm::Intrinsic {
enum DXIntrinsics : unsigned {
// Enum values for intrinsics.
    dx_all = 3661,                                    // llvm.dx.all
    dx_any,                                    // llvm.dx.any
    dx_cast_handle,                            // llvm.dx.cast.handle
    dx_clamp,                                  // llvm.dx.clamp
    dx_dot2,                                   // llvm.dx.dot2
    dx_dot3,                                   // llvm.dx.dot3
    dx_dot4,                                   // llvm.dx.dot4
    dx_fdot,                                   // llvm.dx.fdot
    dx_flattened_thread_id_in_group,           // llvm.dx.flattened.thread.id.in.group
    dx_frac,                                   // llvm.dx.frac
    dx_group_id,                               // llvm.dx.group.id
    dx_handle_fromBinding,                     // llvm.dx.handle.fromBinding
    dx_imad,                                   // llvm.dx.imad
    dx_isinf,                                  // llvm.dx.isinf
    dx_length,                                 // llvm.dx.length
    dx_lerp,                                   // llvm.dx.lerp
    dx_normalize,                              // llvm.dx.normalize
    dx_rsqrt,                                  // llvm.dx.rsqrt
    dx_saturate,                               // llvm.dx.saturate
    dx_sdot,                                   // llvm.dx.sdot
    dx_sign,                                   // llvm.dx.sign
    dx_step,                                   // llvm.dx.step
    dx_thread_id,                              // llvm.dx.thread.id
    dx_thread_id_in_group,                     // llvm.dx.thread.id.in.group
    dx_typedBufferLoad,                        // llvm.dx.typedBufferLoad
    dx_typedBufferLoad_checkbit,               // llvm.dx.typedBufferLoad.checkbit
    dx_typedBufferStore,                       // llvm.dx.typedBufferStore
    dx_uclamp,                                 // llvm.dx.uclamp
    dx_udot,                                   // llvm.dx.udot
    dx_umad,                                   // llvm.dx.umad
    dx_wave_is_first_lane,                     // llvm.dx.wave.is.first.lane
}; // enum
} // namespace llvm::Intrinsic
#endif


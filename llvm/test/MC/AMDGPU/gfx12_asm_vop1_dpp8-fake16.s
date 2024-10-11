// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32,-real-true16 -show-encoding %s | FileCheck --check-prefixes=GFX12 %s
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize64,-real-true16 -show-encoding %s | FileCheck --check-prefixes=GFX12 %s

v_bfrev_b32_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x70,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_bfrev_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x70,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_bfrev_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x70,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_ceil_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xb8,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ceil_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xb8,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ceil_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xb8,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_ceil_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x44,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ceil_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x44,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ceil_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x44,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cls_i32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x76,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cls_i32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x76,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cls_i32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x76,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_clz_i32_u32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x72,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_clz_i32_u32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x72,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_clz_i32_u32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x72,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cos_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xc2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cos_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xc2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cos_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xc2,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cos_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x6c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cos_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x6c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cos_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x6c,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_ctz_i32_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x74,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ctz_i32_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x74,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ctz_i32_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x74,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_f32_fp8 v5, v1 dpp8:[0,1,2,3,4,5,6,7]
// GFX12: encoding: [0xe9,0xd8,0x0a,0x7e,0x01,0x88,0xc6,0xfa]

v_cvt_f32_fp8 v1, v3 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xd8,0x02,0x7e,0x03,0x77,0x39,0x05]

v_cvt_f32_bf8 v5, v1 dpp8:[0,1,2,3,4,5,6,7]
// GFX12: encoding: [0xe9,0xda,0x0a,0x7e,0x01,0x88,0xc6,0xfa]

v_cvt_f32_bf8 v1, v3 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xda,0x02,0x7e,0x03,0x77,0x39,0x05]

v_cvt_f16_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x14,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f16_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x14,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f16_f32 v127, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x14,0xfe,0x7e,0xff,0x00,0x00,0x00]

v_cvt_f16_i16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xa2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f16_i16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xa2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f16_i16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xa2,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cvt_f16_u16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xa0,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f16_u16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xa0,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f16_u16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xa0,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cvt_f32_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x16,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x16,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_f16 v255, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x16,0xfe,0x7f,0x7f,0x00,0x00,0x00]

v_cvt_f32_i32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x0a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_i32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x0a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_i32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x0a,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_f32_u32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x0c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_u32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x0c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_u32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x0c,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte0 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x22,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte0 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x22,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte0 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x22,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte1 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x24,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte1 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x24,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte1 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x24,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte2 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x26,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte2 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x26,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte2 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x26,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte3 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x28,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte3 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x28,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte3 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x28,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_floor_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x1a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_floor_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x1a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_floor_i32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x1a,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_flr_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x1a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_flr_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x1a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_flr_i32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x1a,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_i16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xa6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_i16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xa6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_i16_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xa6,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cvt_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x10,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x10,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_i32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x10,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_i32_i16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xd4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_i32_i16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xd4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_i32_i16 v255, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xd4,0xfe,0x7f,0x7f,0x00,0x00,0x00]

v_cvt_nearest_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x18,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_nearest_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x18,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_nearest_i32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x18,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_norm_i16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xc6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_norm_i16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xc6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_norm_i16_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xc6,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cvt_norm_u16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xc8,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_norm_u16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xc8,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_norm_u16_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xc8,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cvt_off_f32_i4 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x1c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_off_f32_i4 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x1c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_off_f32_i4 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x1c,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_rpi_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x18,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_rpi_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x18,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_rpi_i32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x18,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_u16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xa4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_u16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xa4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_u16_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xa4,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_cvt_u32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x0e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_u32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x0e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_u32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x0e,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_cvt_u32_u16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xd6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_u32_u16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xd6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_cvt_u32_u16 v255, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xd6,0xfe,0x7f,0x7f,0x00,0x00,0x00]

v_exp_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xb0,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_exp_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xb0,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_exp_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xb0,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_exp_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x4a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_exp_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x4a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_exp_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x4a,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_ffbh_i32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x76,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ffbh_i32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x76,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ffbh_i32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x76,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_ffbh_u32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x72,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ffbh_u32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x72,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ffbh_u32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x72,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_ffbl_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x74,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ffbl_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x74,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_ffbl_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x74,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_floor_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xb6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_floor_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xb6,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_floor_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xb6,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_floor_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x48,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_floor_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x48,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_floor_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x48,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_fract_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xbe,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_fract_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xbe,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_fract_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xbe,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_fract_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x40,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_fract_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x40,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_fract_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x40,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_frexp_exp_i16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xb4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_exp_i16_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xb4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_exp_i16_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xb4,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_frexp_exp_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x7e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_exp_i32_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x7e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_exp_i32_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x7e,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_frexp_mant_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xb2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_mant_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xb2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_mant_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xb2,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_frexp_mant_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x80,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_mant_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x80,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_frexp_mant_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x80,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_log_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xae,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_log_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xae,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_log_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xae,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_log_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x4e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_log_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x4e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_log_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x4e,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_mov_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x02,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_mov_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x02,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_mov_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x02,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_movreld_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x84,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movreld_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x84,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movreld_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x84,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_movrels_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x86,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movrels_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x86,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movrels_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x86,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_movrelsd_2_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x90,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movrelsd_2_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x90,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movrelsd_2_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x90,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_movrelsd_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x88,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movrelsd_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x88,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_movrelsd_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x88,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_not_b16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xd2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_not_b16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xd2,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_not_b16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xd2,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_not_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x6e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_not_b32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x6e,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_not_b32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x6e,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_rcp_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xa8,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rcp_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xa8,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rcp_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xa8,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_rcp_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x54,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rcp_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x54,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rcp_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x54,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_rcp_iflag_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x56,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rcp_iflag_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x56,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rcp_iflag_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x56,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_rndne_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xbc,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rndne_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xbc,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rndne_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xbc,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_rndne_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x46,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rndne_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x46,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rndne_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x46,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_rsq_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xac,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rsq_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xac,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rsq_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xac,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_rsq_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x5c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rsq_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x5c,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_rsq_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x5c,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_sat_pk_u8_i16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xc4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sat_pk_u8_i16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xc4,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sat_pk_u8_i16 v127, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xc4,0xfe,0x7e,0xff,0x00,0x00,0x00]

v_sin_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xc0,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sin_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xc0,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sin_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xc0,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_sin_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x6a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sin_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x6a,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sin_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x6a,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_sqrt_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xaa,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sqrt_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xaa,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sqrt_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xaa,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_sqrt_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x66,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sqrt_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x66,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_sqrt_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x66,0xfe,0x7f,0xff,0x00,0x00,0x00]

v_trunc_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0xba,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_trunc_f16 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0xba,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_trunc_f16 v127, v127 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0xba,0xfe,0x7e,0x7f,0x00,0x00,0x00]

v_trunc_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0xe9,0x42,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_trunc_f32 v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: encoding: [0xea,0x42,0x0a,0x7e,0x01,0x77,0x39,0x05]

v_trunc_f32 v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: encoding: [0xe9,0x42,0xfe,0x7f,0xff,0x00,0x00,0x00]

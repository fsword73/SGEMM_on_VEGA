/*
please note that the series of optmiztion technology is not in official document.

All the tests are based on AMD MI25 radeon instict and AMD ROCm.
*/

#include <assert.h>
#include <stdio.h>
#include <algorithm>
#include <stdlib.h>
#include <iostream>
#include "hip/hip_runtime.h"
#include <math.h>

#define HIP_ASSERT(x) (assert((x)==hipSuccess))

__device__ void InitVGPRAllocations()
{

	/*
		VGPR  allocations 	begin	end
		hipThreadIdx_x			0	0
		matrix-A-offset			2	3
		matrix-B-offset			4   5 
		matrix-C-offset         6   7
		matrix-a-data			8	15
		matrix-b-data			16  23
		C_SUM					24  87
		
	*/

	asm volatile(".set hipThreadIdx_x,   0		\n");
	asm volatile(".set v_A_VGPR_OFFSET,    2		\n");
	asm volatile(".set v_B_VGPR_OFFSET,   4      \n");
	asm volatile(".set v_C_VGPR_OFFSET,   6      \n");
	asm volatile(".set v_A_VGPR_DATA,		8		\n");    //4x8 == 32 VGPR ,  8..39
	asm volatile(".set v_B_VGPR_DATA,     40		\n");    //4x8 == 32 VGPR ,  40..63
	asm volatile(".set v_C_SUM,		    64		\n");    //4x4 == 16 VGPR ,  64..79 
	asm volatile(".set v_THREAD_TILE_M,            80  \n");
	asm volatile(".set v_THREAD_TILE_N,            81  \n");
	asm volatile(".set v_LDS_Offset,            2  \n");
	asm volatile(".set v_WAVE_ID,            3  \n");
	asm volatile(".set v_C_SUM_LDS,            8  \n");

}

__device__ void InitSGPRAllocations()
{
	asm volatile(".set hipBlockIdx_x,            6  \n");
	asm volatile(".set hipBlockIdx_y,            7  \n");
	asm volatile(".set s_A_base,					 8  \n");
	asm volatile(".set s_B_base,					 10 \n");
	asm volatile(".set s_C_Base,					 12 \n");
	asm volatile(".set s_H,						 14 \n");
	asm volatile(".set s_W,						 15 \n");
	asm volatile(".set s_C,						 16 \n");
	asm volatile(".set s_K,						 17 \n");
	asm volatile(".set s_KLOOPS,					 18 \n");

	asm volatile(".set s_A_addr,				 20 \n");
	asm volatile(".set s_B_addr,				 22 \n");
	asm volatile(".set s_C_addr,				 24 \n");

	asm volatile(".set s_loop_k,				     26 \n");

	asm volatile(".set s_TILE_M,					 27  \n");
	asm volatile(".set s_TILE_N,					 28  \n");
	asm volatile(".set s_WAVE_TILE_M_offset,		 31   \n");
	asm volatile(".set s_WAVE_TILE_N_offset,		 32   \n");
	asm volatile(".set s_HW_OFFSET,					 33   \n");
	asm volatile(".set s_A_addr_temp,				 34   \n");
	asm volatile(".set s_B_addr_temp,				 36   \n");
	asm volatile(".set s_CHANNEL_C_STEP,			 38	  \n");
	//Matrix C LDS information will be addeded later)
}

__device__ void InitMatrixABInfo()
{
	//Read out all consts
	asm volatile("s_load_dwordx2     s[s_A_base:s_A_base+1],  s[4:5], 0x8\n");
	asm volatile("s_load_dwordx2     s[s_B_base:s_B_base+1],  s[4:5], 0x10\n");
	asm volatile("s_load_dwordx2     s[s_C_Base:s_C_Base+1],  s[4:5], 0x18\n");
	asm volatile("s_load_dwordx2     s[s_H:s_W],      s[4:5], 0x20\n");
	asm volatile("s_load_dwordx2     s[s_C:s_K],      s[4:5], 0x28\n");
	asm volatile("s_load_dword       s[s_KLOOPS],     s[4:5], 0x30\n");

	//Work group size 32x32
	//Wave TIle Size 32x32 
	//Thread Tile Size 4x4
	
	//s[4:5]  Parameters
	
	//asm volatile(" \n");
	
	//Work group size 32x32
	asm volatile("s_lshl_b32  s[s_TILE_M], s[hipBlockIdx_x], 5\n");
	asm volatile("s_lshl_b32  s[s_TILE_N], s[hipBlockIdx_y], 5\n");

	//M--> refer to HW , NCHW is contiunous , every 8x from 0, 4, 8, 12, ..., 28, repeats 8x times for 64 threads
	//N --> refer to Channels,  So Every 8x are same 
	asm volatile("v_lshlrev_b32  v[v_THREAD_TILE_M], 2, v[hipThreadIdx_x] \n");
	asm volatile("v_and_b32		 v[v_THREAD_TILE_M], v[v_THREAD_TILE_M],  0x1f\n");

	asm volatile("v_lshrrev_b32  v[v_THREAD_TILE_N], 3, v[hipThreadIdx_x] \n");
	asm volatile("v_lshlrev_b32  v[v_THREAD_TILE_N], 2, v[v_THREAD_TILE_N] \n");
	asm volatile("v_and_b32      v[v_THREAD_TILE_N], v[v_THREAD_TILE_N], 0x1f\n");

	asm volatile("v_readfirstlane_b32   s[s_WAVE_TILE_M_offset], v[hipThreadIdx_x]\n");
	asm volatile("s_lshr_b32			s[s_WAVE_TILE_M_offset] , s[s_WAVE_TILE_M_offset], 6\n");
	asm volatile("s_waitcnt lgkmcnt(0) \n");
	
	// m* H * W 
	asm volatile("s_mul_i32				s[s_WAVE_TILE_M_offset], s[s_WAVE_TILE_M_offset], s[s_KLOOPS] \n");
	asm volatile("s_mov_b32             s[s_WAVE_TILE_N_offset], s[s_WAVE_TILE_M_offset] \n");

	asm volatile("s_mul_i32				s[s_WAVE_TILE_M_offset], s[s_WAVE_TILE_M_offset], s[s_H] \n");
	asm volatile("s_mul_i32				s[s_WAVE_TILE_M_offset], s[s_WAVE_TILE_M_offset], s[s_W] \n");

	// n is done  
	
	//A formular :  Matrix K = C ,  Matrix  M = H *W 
	//B Formular :  Matrix K = C,   Matrix  N = K
	
	//Compute v_A_VGPR_OFFSET 
	//Compute v_B_VGPR_OFFSET

	//
	asm volatile("v_mov_b32			v[v_A_VGPR_OFFSET],   s[s_TILE_M]  \n");
	asm volatile("v_add_u32			v[v_A_VGPR_OFFSET],   v[v_A_VGPR_OFFSET],  s[s_WAVE_TILE_M_offset] \n");
	asm volatile("v_add_u32			v[v_A_VGPR_OFFSET],   v[v_A_VGPR_OFFSET], v[v_THREAD_TILE_M] \n");
	asm volatile("v_lshlrev_b32		v[v_A_VGPR_OFFSET], 0x2, v[v_A_VGPR_OFFSET]   \n");
	asm volatile("v_mov_b32			v[v_A_VGPR_OFFSET+1] ,0  \n");


	asm volatile("v_mov_b32			v[v_B_VGPR_OFFSET],   s[s_TILE_N]  \n");
	asm volatile("v_add_u32			v[v_B_VGPR_OFFSET],   v[v_B_VGPR_OFFSET],  s[s_WAVE_TILE_N_offset] \n");
	asm volatile("v_add_u32			v[v_B_VGPR_OFFSET],   v[v_B_VGPR_OFFSET], v[v_THREAD_TILE_N] \n");
	asm volatile("v_lshlrev_b32		v[v_B_VGPR_OFFSET], 0x2, v[v_B_VGPR_OFFSET]   \n");
	asm volatile("v_mov_b32			v[v_B_VGPR_OFFSET+1] ,0  \n");

	asm volatile("s_mul_i32   s[s_HW_OFFSET],  s[s_H], s[s_W] \n");
	asm volatile("s_mul_i32   s[s_HW_OFFSET],  s[s_HW_OFFSET], 0x4 \n");

	asm volatile("s_mov_b64   s[s_A_addr:s_A_addr+1],    s[s_A_base:s_A_base+1] \n");
	asm volatile("s_mov_b64   s[s_B_addr:s_B_addr+1],    s[s_B_base:s_B_base+1] \n");

	asm volatile("s_lshl_b32  s[s_CHANNEL_C_STEP], s[s_C],  0x2\n");  //to byte

}

__device__ void InitCSum()
{
	asm volatile("v_mov_b32  v[v_C_SUM + 0] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 1] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 2] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 3] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 4] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 5] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 6] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 7] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 8] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 9] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 10] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 11] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 12] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 13] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 14] , 0 \n ");
	asm volatile("v_mov_b32  v[v_C_SUM + 15] , 0 \n ");
}

__device__ void LoadMatrixAB_Macro()
{
	asm volatile(".macro  LoadMatrixAB voffset \n \
			s_mov_b64 s[s_B_addr_temp:s_B_addr_temp+1], s[s_B_addr:s_B_addr+1] \n \
			global_load_dwordx4 v[v_A_VGPR_DATA+\\voffset:v_A_VGPR_DATA+\\voffset+3], v[v_A_VGPR_OFFSET:v_A_VGPR_OFFSET+1], s[s_A_addr:s_A_addr+1]\n \
			s_add_u32	  s[s_A_addr], s[s_A_addr],  s[s_HW_OFFSET] \n \
			s_addc_u32    s[s_A_addr+1], s[s_A_addr+1], 0 \n \
			global_load_dwordx4 v[v_A_VGPR_DATA+\\voffset+4:v_A_VGPR_DATA+\\voffset +4 +3], v[v_A_VGPR_OFFSET:v_A_VGPR_OFFSET+1], s[s_A_addr:s_A_addr+1]\n  \
			s_add_u32	  s[s_A_addr], s[s_A_addr],  s[s_HW_OFFSET] \n \
			s_addc_u32    s[s_A_addr+1], s[s_A_addr+1], 0 \n \
			global_load_dwordx4 v[v_A_VGPR_DATA+\\voffset+8:v_A_VGPR_DATA+\\voffset +8 +3], v[v_A_VGPR_OFFSET:v_A_VGPR_OFFSET+1], s[s_A_addr:s_A_addr+1]\n \
			s_add_u32	  s[s_A_addr], s[s_A_addr],  s[s_HW_OFFSET] \n \
			s_addc_u32    s[s_A_addr+1], s[s_A_addr+1], 0 \n \
			global_load_dwordx4 v[v_A_VGPR_DATA+\\voffset+12:v_A_VGPR_DATA+\\voffset +12 +3], v[v_A_VGPR_OFFSET:v_A_VGPR_OFFSET+1], s[s_A_addr:s_A_addr+1]\n \
			s_add_u32	  s[s_A_addr], s[s_A_addr],  s[s_HW_OFFSET] \n \
			s_addc_u32    s[s_A_addr+1], s[s_A_addr+1], 0 \n \
			global_load_dwordx4 v[v_B_VGPR_DATA + \\voffset:v_B_VGPR_DATA + \\voffset +3], v[v_B_VGPR_OFFSET:v_B_VGPR_OFFSET+1], s[s_B_addr_temp:s_B_addr_temp +1]	\n \
			s_add_u32	  s[s_B_addr_temp], s[s_B_addr_temp],  s[s_CHANNEL_C_STEP] \n \
			s_addc_u32    s[s_B_addr_temp+1], s[s_B_addr_temp+1], 0 \n \
			global_load_dwordx4 v[v_B_VGPR_DATA + \\voffset+4:v_B_VGPR_DATA + \\voffset +4+3], v[v_B_VGPR_OFFSET:v_B_VGPR_OFFSET+1], s[s_B_addr_temp:s_B_addr_temp +1]	\n \
			s_add_u32	  s[s_B_addr_temp], s[s_B_addr_temp],  s[s_CHANNEL_C_STEP] \n \
			s_addc_u32    s[s_B_addr_temp+1], s[s_B_addr_temp+1], 0 \n \
			global_load_dwordx4 v[v_B_VGPR_DATA + \\voffset+8:v_B_VGPR_DATA + \\voffset +8+3], v[v_B_VGPR_OFFSET:v_B_VGPR_OFFSET+1], s[s_B_addr_temp:s_B_addr_temp +1]	\n \
			s_add_u32	  s[s_B_addr_temp], s[s_B_addr_temp],  s[s_CHANNEL_C_STEP] \n \
			s_addc_u32    s[s_B_addr_temp+1], s[s_B_addr_temp+1], 0 \n \
			global_load_dwordx4 v[v_B_VGPR_DATA + \\voffset+12:v_B_VGPR_DATA + \\voffset +12+3], v[v_B_VGPR_OFFSET:v_B_VGPR_OFFSET+1], s[s_B_addr_temp:s_B_addr_temp +1]	\n \
			s_add_u32	  s[s_B_addr], s[s_B_addr],  0x10 \n \
			s_addc_u32    s[s_B_addr+1], s[s_B_addr+1], 0 \n \
		.endmacro \n"::);

}

__device__ void Gemm4x4Marco()
{
	asm volatile(".macro Gemm4x4  voffset, vcnt\n \
				s_waitcnt vmcnt(\\vcnt+3)				   										\n \
				v_fma_f32 v[v_C_SUM  + 0],   	v[v_A_VGPR_DATA + \\voffset + 0], v[v_B_VGPR_DATA + \\voffset + 0]		,v[v_C_SUM  + 0]       \n \
				v_fma_f32 v[v_C_SUM  + 0],   	v[v_A_VGPR_DATA + \\voffset + 4], v[v_B_VGPR_DATA + \\voffset + 1]		,v[v_C_SUM  + 0]       \n \
				v_fma_f32 v[v_C_SUM  + 0],   	v[v_A_VGPR_DATA + \\voffset + 8], v[v_B_VGPR_DATA + \\voffset + 2]		,v[v_C_SUM  + 0]       \n \
				v_fma_f32 v[v_C_SUM  + 0],   	v[v_A_VGPR_DATA + \\voffset + 12], v[v_B_VGPR_DATA + \\voffset + 3]		,v[v_C_SUM  + 0]       \n \
				v_fma_f32 v[v_C_SUM  + 1],   	v[v_A_VGPR_DATA + \\voffset + 1], v[v_B_VGPR_DATA + \\voffset + 0]		,v[v_C_SUM  + 1]       \n \
				v_fma_f32 v[v_C_SUM  + 1],   	v[v_A_VGPR_DATA + \\voffset + 5], v[v_B_VGPR_DATA + \\voffset + 1]		,v[v_C_SUM  + 1]       \n \
				v_fma_f32 v[v_C_SUM  + 1],   	v[v_A_VGPR_DATA + \\voffset + 9], v[v_B_VGPR_DATA + \\voffset + 2]		,v[v_C_SUM  + 1]       \n \
				v_fma_f32 v[v_C_SUM  + 1],   	v[v_A_VGPR_DATA + \\voffset + 13], v[v_B_VGPR_DATA + \\voffset + 3]		,v[v_C_SUM  + 1]       \n \
				v_fma_f32 v[v_C_SUM  + 2],   	v[v_A_VGPR_DATA + \\voffset + 2], v[v_B_VGPR_DATA + \\voffset + 0]		,v[v_C_SUM  + 2]       \n \
				v_fma_f32 v[v_C_SUM  + 2],   	v[v_A_VGPR_DATA + \\voffset + 6], v[v_B_VGPR_DATA + \\voffset + 1]		,v[v_C_SUM  + 2]       \n \
				v_fma_f32 v[v_C_SUM  + 2],   	v[v_A_VGPR_DATA + \\voffset + 10], v[v_B_VGPR_DATA + \\voffset + 2]		,v[v_C_SUM  + 2]       \n \
				v_fma_f32 v[v_C_SUM  + 2],   	v[v_A_VGPR_DATA + \\voffset + 14], v[v_B_VGPR_DATA + \\voffset + 3]		,v[v_C_SUM  + 2]       \n \
				v_fma_f32 v[v_C_SUM  + 3],   	v[v_A_VGPR_DATA + \\voffset + 3], v[v_B_VGPR_DATA + \\voffset + 0]		,v[v_C_SUM  + 3]       \n \
				v_fma_f32 v[v_C_SUM  + 3],   	v[v_A_VGPR_DATA + \\voffset + 7], v[v_B_VGPR_DATA + \\voffset + 1]		,v[v_C_SUM  + 3]       \n \
				v_fma_f32 v[v_C_SUM  + 3],   	v[v_A_VGPR_DATA + \\voffset + 11], v[v_B_VGPR_DATA + \\voffset + 2]		,v[v_C_SUM  + 3]       \n \
				v_fma_f32 v[v_C_SUM  + 3],   	v[v_A_VGPR_DATA + \\voffset + 15], v[v_B_VGPR_DATA + \\voffset + 3]		,v[v_C_SUM  + 3]       \n \
				s_waitcnt vmcnt(\\vcnt+2)				   										\n \
				v_fma_f32 v[v_C_SUM  + 4],   	v[v_A_VGPR_DATA + \\voffset + 0], v[v_B_VGPR_DATA + \\voffset + 4]		,v[v_C_SUM  + 4]       \n \
				v_fma_f32 v[v_C_SUM  + 4],   	v[v_A_VGPR_DATA + \\voffset + 4], v[v_B_VGPR_DATA + \\voffset + 5]		,v[v_C_SUM  + 4]       \n \
				v_fma_f32 v[v_C_SUM  + 4],   	v[v_A_VGPR_DATA + \\voffset + 8], v[v_B_VGPR_DATA + \\voffset + 6]		,v[v_C_SUM  + 4]       \n \
				v_fma_f32 v[v_C_SUM  + 4],   	v[v_A_VGPR_DATA + \\voffset + 12], v[v_B_VGPR_DATA + \\voffset+ 7]		,v[v_C_SUM  + 4]       \n \
				v_fma_f32 v[v_C_SUM  + 5],   	v[v_A_VGPR_DATA + \\voffset + 1], v[v_B_VGPR_DATA + \\voffset + 4]		,v[v_C_SUM  + 5]       \n \
				v_fma_f32 v[v_C_SUM  + 5],   	v[v_A_VGPR_DATA + \\voffset + 5], v[v_B_VGPR_DATA + \\voffset + 5]		,v[v_C_SUM  + 5]       \n \
				v_fma_f32 v[v_C_SUM  + 5],   	v[v_A_VGPR_DATA + \\voffset + 9], v[v_B_VGPR_DATA + \\voffset + 6]		,v[v_C_SUM  + 5]       \n \
				v_fma_f32 v[v_C_SUM  + 5],   	v[v_A_VGPR_DATA + \\voffset + 13], v[v_B_VGPR_DATA + \\voffset+ 7]		,v[v_C_SUM  + 5]       \n \
				v_fma_f32 v[v_C_SUM  + 6],   	v[v_A_VGPR_DATA + \\voffset + 2], v[v_B_VGPR_DATA + \\voffset + 4]		,v[v_C_SUM  + 6]       \n \
				v_fma_f32 v[v_C_SUM  + 6],   	v[v_A_VGPR_DATA + \\voffset + 6], v[v_B_VGPR_DATA + \\voffset + 5]		,v[v_C_SUM  + 6]       \n \
				v_fma_f32 v[v_C_SUM  + 6],   	v[v_A_VGPR_DATA + \\voffset + 10], v[v_B_VGPR_DATA + \\voffset+ 6]		,v[v_C_SUM  + 6]       \n \
				v_fma_f32 v[v_C_SUM  + 6],   	v[v_A_VGPR_DATA + \\voffset + 14], v[v_B_VGPR_DATA + \\voffset+ 7]		,v[v_C_SUM  + 6]       \n \
				v_fma_f32 v[v_C_SUM  + 7],   	v[v_A_VGPR_DATA + \\voffset + 3], v[v_B_VGPR_DATA + \\voffset + 4]		,v[v_C_SUM  + 7]       \n \
				v_fma_f32 v[v_C_SUM  + 7],   	v[v_A_VGPR_DATA + \\voffset + 7], v[v_B_VGPR_DATA + \\voffset + 5]		,v[v_C_SUM  + 7]       \n \
				v_fma_f32 v[v_C_SUM  + 7],   	v[v_A_VGPR_DATA + \\voffset + 11], v[v_B_VGPR_DATA + \\voffset+ 6]		,v[v_C_SUM  + 7]       \n \
				v_fma_f32 v[v_C_SUM  + 7],   	v[v_A_VGPR_DATA + \\voffset + 15], v[v_B_VGPR_DATA + \\voffset+ 7]		,v[v_C_SUM  + 7]       \n \
				s_waitcnt vmcnt(\\vcnt+1)				   										\n \
				v_fma_f32 v[v_C_SUM  + 8],   	v[v_A_VGPR_DATA + \\voffset + 0], v[v_B_VGPR_DATA + \\voffset + 8 ]		,v[v_C_SUM  + 8]       \n \
				v_fma_f32 v[v_C_SUM  + 8],   	v[v_A_VGPR_DATA + \\voffset + 4], v[v_B_VGPR_DATA + \\voffset + 9 ]		,v[v_C_SUM  + 8]       \n \
				v_fma_f32 v[v_C_SUM  + 8],   	v[v_A_VGPR_DATA + \\voffset + 8], v[v_B_VGPR_DATA + \\voffset + 10]		,v[v_C_SUM  + 8]       \n \
				v_fma_f32 v[v_C_SUM  + 8],   	v[v_A_VGPR_DATA + \\voffset + 12], v[v_B_VGPR_DATA + \\voffset+ 11]		,v[v_C_SUM  + 8]       \n \
				v_fma_f32 v[v_C_SUM  + 9],   	v[v_A_VGPR_DATA + \\voffset + 1], v[v_B_VGPR_DATA + \\voffset + 8 ]		,v[v_C_SUM  + 9]       \n \
				v_fma_f32 v[v_C_SUM  + 9],   	v[v_A_VGPR_DATA + \\voffset + 5], v[v_B_VGPR_DATA + \\voffset + 9 ]		,v[v_C_SUM  + 9]       \n \
				v_fma_f32 v[v_C_SUM  + 9],   	v[v_A_VGPR_DATA + \\voffset + 9], v[v_B_VGPR_DATA + \\voffset + 10]		,v[v_C_SUM  + 9]       \n \
				v_fma_f32 v[v_C_SUM  + 9],   	v[v_A_VGPR_DATA + \\voffset + 13], v[v_B_VGPR_DATA + \\voffset+ 11]		,v[v_C_SUM  + 9]       \n \
				v_fma_f32 v[v_C_SUM  + 10],     v[v_A_VGPR_DATA + \\voffset + 2], v[v_B_VGPR_DATA + \\voffset + 8 ]	    ,v[v_C_SUM  + 10] 	\n \
				v_fma_f32 v[v_C_SUM  + 10],     v[v_A_VGPR_DATA + \\voffset + 6], v[v_B_VGPR_DATA + \\voffset + 9 ]	    ,v[v_C_SUM  + 10] 	\n \
				v_fma_f32 v[v_C_SUM  + 10],     v[v_A_VGPR_DATA + \\voffset + 10], v[v_B_VGPR_DATA + \\voffset+ 10]	    ,v[v_C_SUM  + 10] 	\n \
				v_fma_f32 v[v_C_SUM  + 10],     v[v_A_VGPR_DATA + \\voffset + 14], v[v_B_VGPR_DATA + \\voffset+ 11]	    ,v[v_C_SUM  + 10] 	\n \
				v_fma_f32 v[v_C_SUM  + 11],     v[v_A_VGPR_DATA + \\voffset + 3], v[v_B_VGPR_DATA + \\voffset + 8 ]	    ,v[v_C_SUM  + 11] 	\n \
				v_fma_f32 v[v_C_SUM  + 11],     v[v_A_VGPR_DATA + \\voffset + 7], v[v_B_VGPR_DATA + \\voffset + 9 ]	    ,v[v_C_SUM  + 11] 	\n \
				v_fma_f32 v[v_C_SUM  + 11],     v[v_A_VGPR_DATA + \\voffset + 11], v[v_B_VGPR_DATA + \\voffset+ 10]	    ,v[v_C_SUM  + 11] 	\n \
				v_fma_f32 v[v_C_SUM  + 11],     v[v_A_VGPR_DATA + \\voffset + 15], v[v_B_VGPR_DATA + \\voffset+ 11]	    ,v[v_C_SUM  + 11] 	\n \
				s_waitcnt vmcnt(\\vcnt+0)													\n \
				v_fma_f32 v[v_C_SUM  + 12],		v[v_A_VGPR_DATA + \\voffset + 0], v[v_B_VGPR_DATA + \\voffset + 12]	    ,v[v_C_SUM  + 12] 	\n \
				v_fma_f32 v[v_C_SUM  + 12],		v[v_A_VGPR_DATA + \\voffset + 4], v[v_B_VGPR_DATA + \\voffset + 13]	    ,v[v_C_SUM  + 12] 	\n \
				v_fma_f32 v[v_C_SUM  + 12],		v[v_A_VGPR_DATA + \\voffset + 8], v[v_B_VGPR_DATA + \\voffset + 14]	    ,v[v_C_SUM  + 12] 	\n \
				v_fma_f32 v[v_C_SUM  + 12],		v[v_A_VGPR_DATA + \\voffset + 12], v[v_B_VGPR_DATA + \\voffset+ 15]	    ,v[v_C_SUM  + 12] 	\n \
				v_fma_f32 v[v_C_SUM  + 13],		v[v_A_VGPR_DATA + \\voffset + 1], v[v_B_VGPR_DATA + \\voffset + 12]	    ,v[v_C_SUM  + 13] 	\n \
				v_fma_f32 v[v_C_SUM  + 13],		v[v_A_VGPR_DATA + \\voffset + 5], v[v_B_VGPR_DATA + \\voffset + 13]	    ,v[v_C_SUM  + 13] 	\n \
				v_fma_f32 v[v_C_SUM  + 13],		v[v_A_VGPR_DATA + \\voffset + 9], v[v_B_VGPR_DATA + \\voffset + 14]	    ,v[v_C_SUM  + 13] 	\n \
				v_fma_f32 v[v_C_SUM  + 13],		v[v_A_VGPR_DATA + \\voffset + 13], v[v_B_VGPR_DATA + \\voffset+ 15]	    ,v[v_C_SUM  + 13] 	\n \
				v_fma_f32 v[v_C_SUM  + 14],		v[v_A_VGPR_DATA + \\voffset + 2], v[v_B_VGPR_DATA + \\voffset + 12]	    ,v[v_C_SUM  + 14] 	\n \
				v_fma_f32 v[v_C_SUM  + 14],		v[v_A_VGPR_DATA + \\voffset + 6], v[v_B_VGPR_DATA + \\voffset + 13]	    ,v[v_C_SUM  + 14] 	\n \
				v_fma_f32 v[v_C_SUM  + 14],		v[v_A_VGPR_DATA + \\voffset + 10], v[v_B_VGPR_DATA + \\voffset+ 14]	    ,v[v_C_SUM  + 14] 	\n \
				v_fma_f32 v[v_C_SUM  + 14],		v[v_A_VGPR_DATA + \\voffset + 14], v[v_B_VGPR_DATA + \\voffset+ 15]	    ,v[v_C_SUM  + 14] 	\n \
				v_fma_f32 v[v_C_SUM  + 15],		v[v_A_VGPR_DATA + \\voffset + 3], v[v_B_VGPR_DATA + \\voffset + 12]	    ,v[v_C_SUM  + 15] 	\n \
				v_fma_f32 v[v_C_SUM  + 15],		v[v_A_VGPR_DATA + \\voffset + 7], v[v_B_VGPR_DATA + \\voffset + 13]	    ,v[v_C_SUM  + 15] 	\n \
				v_fma_f32 v[v_C_SUM  + 15],		v[v_A_VGPR_DATA + \\voffset + 11], v[v_B_VGPR_DATA + \\voffset+ 14]	    ,v[v_C_SUM  + 15] 	\n \
				v_fma_f32 v[v_C_SUM  + 15],		v[v_A_VGPR_DATA + \\voffset + 15], v[v_B_VGPR_DATA + \\voffset+ 15]	    ,v[v_C_SUM  + 15] 	\n \
		.endmacro \n"::);
}

__device__ void LoadMatrixAB(int voffset)
{
	if (voffset == 0)
	{
		asm volatile("LoadMatrixAB 0 \n");
	}

	if (voffset == 16)
	{
		asm volatile("LoadMatrixAB 16 \n");
	}
}

__device__ void SGemm4x4(int voffset, int vmcnt)
{
	if (vmcnt == 8) {
		if (voffset == 0)
		{
			asm volatile("Gemm4x4 0,8\n");
		}

		if (voffset == 16)
		{
			asm volatile("Gemm4x4 16,8 \n");
		}
	}
	if (vmcnt == 0) {
		if (voffset == 0)
		{
			asm volatile("Gemm4x4 0, 0 \n");
		}

		if (voffset == 16)
		{
			asm volatile("Gemm4x4 16, 0 \n");
		}
	}
}

__device__ void MajorLoopStart()
{
	asm volatile("s_mov_b32  s[s_loop_k], 0\n");
	asm volatile("s_sub_u32  s[s_KLOOPS], 16\n);
	asm volatile("label_major_loop_begin:\n");
}

__device__ void MajorLoopEnd()
{
	//Unorll K= 16 
	asm volatile("s_add_u32			s[s_loop_k],s[s_loop_k], 16\n");
	asm volatile("s_cmp_ge_u32		s[s_loop_k], s[s_KLOOPS]\n");
	asm volatile("s_cbranch_scc0    label_major_loop_begin\n");
	//asm volatile("label_major_loop:\n");
}

__device__ void LDSReductionAndOutput()
{
	//

	asm volatile("v_lshlrev_b32 v[v_LDS_Offset], 2, v[hipThreadIdx_x] \n");

	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM] offset:0			\n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+1] offset:1024*1		\n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+2] offset:1024*2	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+3] offset:1024*3	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+4] offset:1024*4	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+5] offset:1024*5	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+6] offset:1024*6	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+7] offset:1024*7	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+8] offset:1024*8	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+9] offset:1024*9	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+10] offset:1024*10	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+11] offset:1024*11	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+12] offset:1024*12	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+13] offset:1024*13	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+14] offset:1024*14	    \n");
	asm volatile("ds_write_b32  v[v_LDS_Offset], v[v_C_SUM+15] offset:1024*15	    \n");

	asm volatile("s_waitcnt    0\n");
	asm volatile("s_barrier\n");



	//32x32 jobs splits into 4 waves 
	//so that every thread needs outout 4xM 


	//asm volatile("ds_read_b32  v[v_LDS_Offset], v[v_C_SUM] offset:0			\n");

	asm volatile("v_lshlrev_b32 v[v_LDS_Offset], 2, v[hipThreadIdx_x] \n") ;
	asm volatile("v_and_b32 v[v_LDS_Offset],  0xff, v[v_LDS_Offset] \n");
	asm volatile("v_lshrrev_b32  v[v_WAVE_ID], 6,  v[hipThreadIdx_x]  \n");  //0,1,2,3,4
	asm volatile("v_lshlrev_b32  v[v_WAVE_ID], 12, v[hipThreadIdx_x]  \n");  //4xM = 1024 * 4 
	asm volatile("v_add_u32      v[v_LDS_Offset], v[v_LDS_Offset], v[v_WAVE_ID] \n");


	//read 4x DWORDs
	asm volatile(".set i, 0 \n");
	asm volatile(".rept 4 \n \
			 ds_read_b32  v[v_C_SUM_LDS + i*4+0 ], v[v_LDS_Offset]  offset:1024*i + 256 * 0  \n   \
			 ds_read_b32  v[v_C_SUM_LDS + i*4+1 ], v[v_LDS_Offset]  offset:1024*i + 256 * 1  \n   \
			 ds_read_b32  v[v_C_SUM_LDS + i*4+2 ], v[v_LDS_Offset]  offset:1024*i + 256 * 2  \n   \
			 ds_read_b32  v[v_C_SUM_LDS + i*4+3 ], v[v_LDS_Offset]  offset:1024*i + 256 * 2  \n   \
			.set i, i + 1 \n   \
		.endr  \n");


	//Ouptut Address Computing 
	// (TILE_N + thread_N + waveID ) * HW + (TILE_M + thread_M)

	asm volatile("v_lshrrev_b32  v[v_WAVE_ID], 6,  v[hipThreadIdx_x]  \n");  //0,1,2,3
	asm volatile("v_readfirstlane_b32  s[s_WAVE_TILE_M_offset], v[v_WAVE_ID]  \n");
	asm volatile("s_add_u32      s[s_TILE_N], s[s_TILE_N], s[s_WAVE_TILE_M_offset] \n");
	asm volatile("s_mul_i32      s[s_TILE_N], s[s_TILE_N], s[s_HW_OFFSET] \n");
	asm volatile("s_add_u32      s[s_C_Base], s[s_C_Base],s[s_HW_OFFSET] \n");
	asm volatile("s_addc_u32     s[s_C_Base+1], 0, s[s_C_Base+1]   \n");

	asm volatile("v_mul_u32_u24	 v[v_C_VGPR_OFFSET], s[s_TILE_M], v[v_THREAD_TILE_M] \n");
	asm volatile("v_lshlrev_b32	 v[v_C_VGPR_OFFSET], 2, v[v_C_VGPR_OFFSET] \n");
	asm volatile("v_mov_b32      v[v_C_VGPR_OFFSET+1], 0 \n");
	asm volatile("s_waitcnt lgkmcnt(12)  \n");



	asm volatile("v_add_f32   v[v_C_SUM + 0 ], v[v_C_SUM_LDS + 0*4+0 ], v[v_C_SUM_LDS + 0*4+1 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 0 ], v[v_C_SUM + 0 ], v[v_C_SUM_LDS + 0*4+2 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 0 ], v[v_C_SUM + 0 ], v[v_C_SUM_LDS + 0*4+3 ]  \n");

	asm volatile("s_waitcnt lgkmcnt(8)  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 1 ], v[v_C_SUM_LDS + 1*4+0 ], v[v_C_SUM_LDS + 1*4+1 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 1 ], v[v_C_SUM + 1 ], v[v_C_SUM_LDS + 1*4+2 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 1 ], v[v_C_SUM + 1 ], v[v_C_SUM_LDS + 1*4+3 ]  \n");

	asm volatile("s_waitcnt lgkmcnt(4)  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 2 ], v[v_C_SUM_LDS + 1*4+0 ], v[v_C_SUM_LDS + 1*4+1 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 2 ], v[v_C_SUM + 2 ], v[v_C_SUM_LDS + 1*4+2 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 2 ], v[v_C_SUM + 2 ], v[v_C_SUM_LDS + 1*4+3 ]  \n");

	asm volatile("s_waitcnt lgkmcnt(0)  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 3 ], v[v_C_SUM_LDS + 1*4+0 ], v[v_C_SUM_LDS + 1*4+1 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 3 ], v[v_C_SUM + 3 ], v[v_C_SUM_LDS + 1*4+2 ]  \n");
	asm volatile("v_add_f32   v[v_C_SUM + 3 ], v[v_C_SUM + 3 ], v[v_C_SUM_LDS + 1*4+3 ]  \n");


	//global_store_dwordx4 vgpr_addr[2], vgpr_src[4], sgpr_saddr[2]
	asm volatile("global_store_dwordx4 v[v_C_VGPR_OFFSET:v_C_VGPR_OFFSET+1],  v[v_C_SUM:v_C_SUM+3], s[s_C_Base:s_C_Base+1] \n");
}



__global__ void sconv_32x32_splitK4_NCHW_asm(hipLaunchParm lp,
	const float* __restrict__ in, const float* __restrict__ weights, float* __restrict__ out,
	const int H, const int W, const int C, const int K, const int loops_k)
{
	//Init  GPR Allocations
	InitVGPRAllocations();
	InitSGPRAllocations();

	//Init Matrix AB
	InitMatrixABInfo();

	LoadMatrixAB_Macro();	
	//Load Matrix A, B
	LoadMatrixAB(0);
	Gemm4x4Marco();
	InitCSum();
	//Major Loops
	MajorLoopStart();
	LoadMatrixAB(16);
	SGemm4x4(0, 8);
	LoadMatrixAB(0);
	SGemm4x4(16, 8);
	LoadMatrixAB(16);
	SGemm4x4(0, 8);
	LoadMatrixAB(0);
	SGemm4x4(16, 8);
	MajorLoopEnd();

	//Last K=16 Data 
	LoadMatrixAB(16);
	SGemm4x4(0, 8);
	LoadMatrixAB(0);
	SGemm4x4(16, 8);
	LoadMatrixAB(16);
	SGemm4x4(0, 8);
	//LoadMatrixAB(0);
	SGemm4x4(16, 0);

	//LDS Reduction
	//output
	LDSReductionAndOutput();

}
__global__ void sconv_32x32_splitK4_NCHW(hipLaunchParm lp, 
		const float* __restrict__ in, const float* __restrict__ weights, float* __restrict__ out,
		const int H, const int W, const int C, const int K, const int loops_k16)
{
	//work group size = 256 
	//per thread do 4x4 micro tile 
	//per wave 32x32 macro-tile 
	//Matrix K split 4 times 
	//4 waves does 32x32 super tile 
	

	//Matrix A 4x8 =32 VGPRs
	//Matrix B 4x8 =32 VGPRs.
	//64 VGPRs 
	//4x4 = 16 VGPRs
	//Marix K Unroll = 16 

	//NCHW for Image 
	//KCRS for Weights

	int mat_A_waveOffset = (C / 4) * H * W * (hipThreadIdx_x >> 6);
	int mat_B_waveOffset = (C / 4) * (hipThreadIdx_x >> 6);
	int tile_M = hipBlockIdx_x * 32;
	int tile_N = hipBlockIdx_y * 32;

	//Matrix M is H*W
	//matrix N: K
	//Matrix K: C*R*S
	//M is from 0-3,4-7,8,..28 for every 8 threads
	//N is same for continuous 8 threads

	int thread_tile_M = (hipThreadIdx_x << 2) & 0x1f;
	int thread_tile_N = ((hipThreadIdx_x >> 3) << 2) & 0x1f;

	int mat_A_thread_offset = tile_M +  thread_tile_M + mat_A_waveOffset;
	int mat_B_thread_offset = (tile_N + thread_tile_N) * C + mat_B_waveOffset;

	const float* A_ptr;
	const float* B_ptr;
	float C_SUM[4][4];

	
	float  dataA[4][8];
	float  dataB[4][8];
	
	__shared__ float sum_to_Reduce[256 * 16];
	//first time loading 4x4 

	A_ptr = in + mat_A_thread_offset;
	B_ptr = weights + mat_B_thread_offset;


	for(int k=0; k < 4; k++)
	{
		dataA[0][k] = A_ptr [ 0 ];
		dataA[1][k] = A_ptr [ 1 ];
		dataA[2][k] = A_ptr [ 2 ];
		dataA[3][k] = A_ptr [ 3 ];

		A_ptr += H * W;
	}

	for (int k = 0; k < 4; k++)
	{
		dataB[k][0] = B_ptr [ 0 + k * C];
		dataB[k][1] = B_ptr [ 1 + k * C];
		dataB[k][2] = B_ptr [ 2 + k * C];
		dataB[k][3] = B_ptr [ 3 + k * C];

	}
	B_ptr += 4;

	for (int i = 0; i < 4; i++)
	{
		C_SUM[i][0] = 0;
		C_SUM[i][1] = 0;
		C_SUM[i][2] = 0;
		C_SUM[i][3] = 0;
	}

	for (int i = 0; i < loops_k16-16;i+=16)
	{
		//Prefetch Next 4-7 
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k+4] = A_ptr [ 0];
			dataA[1][k+4] = A_ptr [ 1];
			dataA[2][k+4] = A_ptr [ 2];
			dataA[3][k+4] = A_ptr [ 3];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0+4] = B_ptr[ 0 + k * C];
			dataB[k][1+4] = B_ptr[ 1 + k * C];
			dataB[k][2+4] = B_ptr[ 2 + k * C];
			dataB[k][3+4] = B_ptr[ 3 + k * C];

		}
		B_ptr += 4;

		//Do FMA for first k0-3
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[i][n] += dataA[m][0] * dataB[n][0];
				C_SUM[i][n] += dataA[m][1] * dataB[n][1];
				C_SUM[i][n] += dataA[m][2] * dataB[n][2];
				C_SUM[i][n] += dataA[m][3] * dataB[n][3];
			}		
		}

		//Prefetch Next 8-11 
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k] = A_ptr [ 0];
			dataA[1][k] = A_ptr [ 1];
			dataA[2][k] = A_ptr [ 2];
			dataA[3][k] = A_ptr [ 3];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0] = B_ptr [ 0 + k * C ];
			dataB[k][1] = B_ptr [ 1 + k * C ];
			dataB[k][2] = B_ptr [ 2 + k * C ];
			dataB[k][3] = B_ptr [ 3 + k * C ];

		}
		B_ptr += 4;

		//Do FMA K=4-7
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[i][n] += dataA[m][0+4] * dataB[n][0+4];
				C_SUM[i][n] += dataA[m][1+4] * dataB[n][1+4];
				C_SUM[i][n] += dataA[m][2+4] * dataB[n][2+4];
				C_SUM[i][n] += dataA[m][3+4] * dataB[n][3+4];
			}		
		}

		//Prefetch Next 12-15 
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k + 4] = A_ptr [ 0 ];
			dataA[1][k + 4] = A_ptr [ 1 ];
			dataA[2][k + 4] = A_ptr [ 2 ];
			dataA[3][k + 4] = A_ptr [ 3 ];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0 + 4] = B_ptr [ 0 + k * C ];
			dataB[k][1 + 4] = B_ptr [ 1 + k * C ];
			dataB[k][2 + 4] = B_ptr [ 2 + k * C ];
			dataB[k][3 + 4] = B_ptr [ 3 + k * C ];

		}
		B_ptr += 4;

		//Do FMA K=8-11
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += dataA[m][0] * dataB[n][0];
				C_SUM[m][n] += dataA[m][1] * dataB[n][1];
				C_SUM[m][n] += dataA[m][2] * dataB[n][2];
				C_SUM[m][n] += dataA[m][3] * dataB[n][3];
			}
		}

		//pretch next 0-3
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k] = A_ptr [ 0 ];
			dataA[1][k] = A_ptr [ 1 ];
			dataA[2][k] = A_ptr [ 2 ];
			dataA[3][k] = A_ptr [ 3 ];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0] = B_ptr [ 0 + k * C ];
			dataB[k][1] = B_ptr [ 1 + k * C ];
			dataB[k][2] = B_ptr [ 2 + k * C ];
			dataB[k][3] = B_ptr [ 3 + k * C ];

		}
		B_ptr += 4;

		//FMA K12-15
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += dataA[m][0+4] * dataB[n][0+4];
				C_SUM[m][n] += dataA[m][1+4] * dataB[n][1+4];
				C_SUM[m][n] += dataA[m][2+4] * dataB[n][2+4];
				C_SUM[m][n] += dataA[m][3+4] * dataB[n][3+4];
			}
		}
	}//FOR Matrix K

	//last 16 K
		{
		//Prefetch Next 4-7 
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k + 4] = A_ptr [ 0 ];
			dataA[1][k + 4] = A_ptr [ 1 ];
			dataA[2][k + 4] = A_ptr [ 2 ];
			dataA[3][k + 4] = A_ptr [ 3 ];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0 + 4] = B_ptr [ 0 + k * C ];
			dataB[k][1 + 4] = B_ptr [ 1 + k * C ];
			dataB[k][2 + 4] = B_ptr [ 2 + k * C ];
			dataB[k][3 + 4] = B_ptr [ 3 + k * C ];

		}
		B_ptr += 4;

		//Do FMA for first k0-3
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += dataA[m][0] * dataB[n][0];
				C_SUM[m][n] += dataA[m][1] * dataB[n][1];
				C_SUM[m][n] += dataA[m][2] * dataB[n][2];
				C_SUM[m][n] += dataA[m][3] * dataB[n][3];
			}
		}

		//Prefetch Next 8-11 
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k] = A_ptr [ 0 ];
			dataA[1][k] = A_ptr [ 1 ];
			dataA[2][k] = A_ptr [ 2 ];
			dataA[3][k] = A_ptr [ 3 ];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0] = B_ptr[ 0 + k * C ];
			dataB[k][1] = B_ptr[ 1 + k * C ];
			dataB[k][2] = B_ptr[ 2 + k * C ];
			dataB[k][3] = B_ptr[ 3 + k * C ];

		}
		B_ptr += 4;

		//Do FMA K=4-7
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += dataA[m][0 + 4] * dataB[n][0 + 4];
				C_SUM[m][n] += dataA[m][1 + 4] * dataB[n][1 + 4];
				C_SUM[m][n] += dataA[m][2 + 4] * dataB[n][2 + 4];
				C_SUM[m][n] += dataA[m][3 + 4] * dataB[n][3 + 4];
			}
		}

		//Prefetch Next 12-15 
		for (int k = 0; k < 4; k++)
		{
			dataA[0][k + 4] = A_ptr [ 0 ];
			dataA[1][k + 4] = A_ptr [ 1 ];
			dataA[2][k + 4] = A_ptr [ 2 ];
			dataA[3][k + 4] = A_ptr [ 3 ];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0 + 4] = B_ptr [ 0 + k * C ];
			dataB[k][1 + 4] = B_ptr [ 1 + k * C ];
			dataB[k][2 + 4] = B_ptr [ 2 + k * C ];
			dataB[k][3 + 4] = B_ptr [ 3 + k * C ];

		}
		B_ptr += 4;

		//Do FMA K=8-11
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += dataA[m][0] * dataB[n][0];
				C_SUM[m][n] += dataA[m][1] * dataB[n][1];
				C_SUM[m][n] += dataA[m][2] * dataB[n][2];
				C_SUM[m][n] += dataA[m][3] * dataB[n][3];
			}
		}

		//pretch next 0-3
		/*for (int k = 0; k < 4; k++)
		{
			dataA[0][k] = A_ptr [ 0 ];
			dataA[1][k] = A_ptr [ 1 ];
			dataA[2][k] = A_ptr [ 2 ];
			dataA[3][k] = A_ptr [ 3 ];

			A_ptr += H * W;
		}

		for (int k = 0; k < 4; k++)
		{
			dataB[k][0] = B_ptr + 0 + k * C;
			dataB[k][1] = B_ptr + 1 + k * C;
			dataB[k][2] = B_ptr + 2 + k * C;
			dataB[k][3] = B_ptr + 3 + k * C;

		}
		B_ptr += 4;
		*/
		//FMA K12-15
		for (int m = 0; m < 4; m++)
		{
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += dataA[m][0 + 4] * dataB[n][0 + 4];
				C_SUM[m][n] += dataA[m][1 + 4] * dataB[n][1 + 4];
				C_SUM[m][n] += dataA[m][2 + 4] * dataB[n][2 + 4];
				C_SUM[m][n] += dataA[m][3 + 4] * dataB[n][3 + 4];
			}
		}
	}//FOR Matrix K


	//LDS redution
	if (hipThreadIdx_x >= 64)
	{
		for(int m =0; m < 4; m++)
			for (int n = 0; n < 4; n++)
			{
					sum_to_Reduce[hipThreadIdx_x + (m * 4 + n)* 256 ] = C_SUM[m][n];
			}
	}
	__syncthreads();

	if (hipThreadIdx_x < 64)
	{
		for (int m = 0; m < 4; m++)
			for (int n = 0; n < 4; n++)
			{
				C_SUM[m][n] += sum_to_Reduce[hipThreadIdx_x + 64 * 1 + (m * 4 + n) * 256] + 
							   sum_to_Reduce[hipThreadIdx_x + 64 * 2 + (m * 4 + n) * 256] +
					           sum_to_Reduce[hipThreadIdx_x + 64 * 3 + (m * 4 + n) * 256];
			}
	}

	//output
	if (hipThreadIdx_x < 64)
	{
		int C_offset = (tile_N + thread_tile_N) * H * W + (thread_tile_M + tile_M);

		float* C_ptr = out + C_offset;

		for (int i = 0; i < 4; i++)
		{
			C_ptr[0] = C_SUM[0][i];
			C_ptr[1] = C_SUM[1][i];
			C_ptr[2] = C_SUM[2][i];
			C_ptr[3] = C_SUM[3][i];

			C_ptr += H * W;
		}
	}	
}


__global__ void
test_kernel(hipLaunchParm lp,
	const float* __restrict__  matA, const float* __restrict__ matB, float* __restrict__ matC,
	int M, int N, int K,
	int lda, int ldb, int ldc,
	float alpha, float beta,
	int matrixCTranspose)
{
	int x = hipBlockIdx_x * 64 + hipThreadIdx_x;
	int y = hipBlockIdx_y * 128;
	matC[y * lda + x] = alpha + beta;
}
using namespace std;

void test()
{

	//H, W, C, K, Split 
	int tests[2][5] = {
		{14, 14, 1024, 512, 4 },
		{0,0,0,0,0}
	};



	unsigned int  A_NUM = 4096 * 4096;
	unsigned int  B_NUM = 4096 * 4096;
	unsigned int  C_NUM = 4096 * 4096;


	float* hostA;
	float* hostB;
	float* hostC;

	float* deviceA;
	float* deviceB;
	float* deviceC;

	hipDeviceProp_t devProp;
	hipGetDeviceProperties(&devProp, 0);
	cout << " System minor " << devProp.minor << endl;
	cout << " System major " << devProp.major << endl;
	cout << " agent prop name " << devProp.name << endl;

	cout << "hip Device prop succeeded " << endl;

	hipEvent_t start, stop;

	hipEventCreate(&start);
	hipEventCreate(&stop);
	float eventMs = 1.0f;


	int errors;

	hostA = (float*)malloc(A_NUM * sizeof(float));
	hostB = (float*)malloc(B_NUM * sizeof(float));
	hostC = (float*)malloc(C_NUM * sizeof(float));

	HIP_ASSERT(hipMalloc((void**)& deviceA, A_NUM * sizeof(float)));
	HIP_ASSERT(hipMalloc((void**)& deviceB, B_NUM * sizeof(float)));
	HIP_ASSERT(hipMalloc((void**)& deviceC, C_NUM * sizeof(float)));

	int verify = 1;

	if (verify) {
		for (int j = 0; j < 4096 * 4096 / 256; j++)
		{
			for (int i = 0; i < 256; i++) {
				hostA[j * 256 + i] = j / 4096;
				hostB[j * 256 + i] = j / 4096;
			}

		}
	}
	else
	{
		for (int j = 0; j < 4096; j++)
		{
			for (int i = 0; i < 4096; i++) {
				hostA[j * 256 + i] = sin(j * 256 + i);
				hostB[j * 256 + i] = cos(j * 256 + i);
			}
		}
	}

	HIP_ASSERT(hipMemcpy(deviceA, hostA, A_NUM * sizeof(float), hipMemcpyHostToDevice));
	HIP_ASSERT(hipMemcpy(deviceB, hostB, B_NUM * sizeof(float), hipMemcpyHostToDevice));
	printf("Copied memory A&B\n");

	for (int j = 0; j < 4096; j++)
	{
		for (int i = 0; i < 4096; i++) {
			hostC[j * 4096 + i] = 0;
		}
	}
	HIP_ASSERT(hipMemcpy(deviceC, hostC, C_NUM * sizeof(float), hipMemcpyHostToDevice));
	printf("Copied memory C\n");



	for (int t = 0; t < 1; t++)
	{
		int h, w, c, k, split;

		h = tests[t][0];
		w = tests[t][1];
		c = tests[t][2];
		k = tests[t][3];
		split = tests[t][4];

		{

			int blocks_m = h * w / 32;
			int blocks_n = k / 32;

			hipLaunchKernel(sconv_32x32_splitK4_NCHW,
							dim3(blocks_m, blocks_n, 1),
							dim3(256, 1, 1),
							0, 0,
							(float*)deviceA, (float*)deviceB, (float*)deviceC,
							h, w, c, k, c/split 
						);

			int iterations = 100;

			hipEventRecord(start, NULL);

			for(int i=0; i < iterations; i++)
			{

				hipLaunchKernel(sconv_32x32_splitK4_NCHW,
					dim3(blocks_m, blocks_n, 1),
					dim3(256, 1, 1),
					0, 0,
					(float*)deviceA, (float*)deviceB, (float*)deviceC,
					h, w, c, k, c / split
					);
			}

			hipEventRecord(stop, NULL);
			hipEventSynchronize(stop);

			hipEventElapsedTime(&eventMs, start, stop);

			double total_G_flops = double(h) * double(w) * double(c) * (k)  ;
			total_G_flops = total_G_flops / 1e9 /1e3;

			float eventsecond = eventMs / iterations /1e3;
			float perf_tflops = total_G_flops / eventsecond;

			printf("H, W ,C, K: [%6d, %6d, %6d, %6d] , seconds performance: %6.3f TFlops/s\n", h, w, c, k,  perf_tflops);
		}
	}
	HIP_ASSERT(hipMemcpy(hostC, deviceC, sizeof(float) * C_NUM, hipMemcpyDeviceToHost));

	//CPU Verifying here
	HIP_ASSERT(hipFree(deviceA));
	HIP_ASSERT(hipFree(deviceB));
	HIP_ASSERT(hipFree(deviceC));


	free(hostA);
	free(hostB);
	free(hostC);

	//return errors;
}


int main()
{
	test();
}


/*
please note that the series of optmiztion technology is not in official document.

All the tests are based on AMD MI25 radeon instict and AMD ROCm.
*/

/*
1）HIPCC does not use  s_load_dword for most times
2）The C++ Statemetn can not use the output of inline assembly as operands
4）C++'s operands must come from C++
5）64 bits Address or data is hard to call inside inline assembly
6) inline assembly is a littile hard to control program by C++ variables, if-esle, for-loop等。
7) HIPCC does not allocate SGPR/VGPR very well r
8) GCN Limit: s_load_DWORDx4, x8, X16 SGPR must begins x4 address
9) Inline Assembly is hard to have correct VGPR/SGPR settings:

So: have to use Pure Assembly
Step1:  Build and Dump ISA from Code.
Step2:  Generate .S llvm assembly    :  extractkernel -i ./a.out
Step3:  Generate .co Code Object by  :  /opt/rocm/hcc/bin/clang -x assembler -target amdgcn--amdhsa -mcpu=gfx900 -mno-code-object-v3 a.s -0 a.co
Step4:  Load a.co from test code


*/


/*
	// V0, V1, V2是ThreadIdx_x, ThreadIdx_y, ThreadIdx_z
	//：S[4:5]   parameters from offset 0x8

	//
	//
	//   S6: BlockIdx_X
	//   S7: BlockIdx_Y
	//
*/

/*
	Matrix A Data Storage:
	Eavery 2x Row are packed into 1 Row:  Row0K0, Row1K0, Row0K1, Row1K1, Row0K2, Row1K2

	Matrix B data Storage:
	Transpose Mode
	Eavery 2x Row are packed into 1 Row:  Row0K0, Row1K0, Row0K1, Row1K1, Row0K2, Row1K2

	//This version will send out Constant Loading Command Immediately after it has be used 

*/




#include <assert.h>
#include <stdio.h>
#include <algorithm>
#include <stdlib.h>
#include <iostream>
#include "hip/hip_runtime.h"
#include <math.h>



#define HIP_ASSERT(x) (assert((x)==hipSuccess))


#define THREADS_PER_BLOCK_X  256
#define THREADS_PER_BLOCK_Y  1
#define THREADS_PER_BLOCK_Z  1

__device__ void  JumpToEnd()
{
	asm volatile("s_branch label_end\n");
}


__device__ void vmcnt(int cnt)
{
	if (cnt == 0)
	{
		asm volatile("s_waitcnt vmcnt(0)\n");
	}
	else if (cnt == 1)
	{
		asm volatile("s_waitcnt vmcnt(1)\n");
	}
	else if (cnt == 2)
	{
		asm volatile("s_waitcnt vmcnt(2)\n");
	}
	else if (cnt == 3)
	{
		asm volatile("s_waitcnt vmcnt(3)\n");
	}
	else if (cnt == 4)
	{
		asm volatile("s_waitcnt vmcnt(4)\n");
	}
	else if (cnt == 5)
	{
		asm volatile("s_waitcnt vmcnt(5)\n");
	}
	else if (cnt == 6)
	{
		asm volatile("s_waitcnt vmcnt(6)\n");
	}
	else if (cnt == 7)
	{
		asm volatile("s_waitcnt vmcnt(7)\n");
	}
	else if (cnt == 8)
	{
		asm volatile("s_waitcnt vmcnt(8)\n");
	}
	else if (cnt == 9)
	{
		asm volatile("s_waitcnt vmcnt(9)\n");
	}
	else if (cnt == 10)
	{
		asm volatile("s_waitcnt vmcnt(10)\n");
	}
	else if (cnt == 11)
	{
		asm volatile("s_waitcnt vmcnt(11)\n");
	}
	else if (cnt == 12)
	{
		asm volatile("s_waitcnt vmcnt(12)\n");
	}
	else if (cnt == 13)
	{
		asm volatile("s_waitcnt vmcnt(13)\n");
	}
	else if (cnt == 14)
	{
		asm volatile("s_waitcnt vmcnt(14)\n");
	}
	else if (cnt == 15)
	{
		asm volatile("s_waitcnt vmcnt(15)\n");
	}
	else if (cnt == 31)
	{
		asm volatile("s_waitcnt vmcnt(31)\n");
	}
	else
	{
		assert(false);
	}
}

__device__ void lgkmcnt(int cnt)
{
	if (cnt == 0)
	{
		asm volatile("\n \
                s_waitcnt lgkmcnt(0) \n \
                " ::);
	}
	else if (cnt == 1)
	{
		asm volatile("\n \
                s_waitcnt lgkmcnt(1) \n \
                " ::);
	}
	else if (cnt == 2)
	{
		asm volatile("\n \
                s_waitcnt lgkmcnt(2) \n \
                " ::);
	}
	else if (cnt == 3)
	{
		asm volatile("\n \
                s_waitcnt lgkmcnt(3) \n \
                " ::);
	}
	else if (cnt == 4)
	{
		asm volatile("\n \
                s_waitcnt lgkmcnt(4) \n \
                " ::);
	}
	else if (cnt == 8)
	{
		asm volatile("\n \
                s_waitcnt lgkmcnt(8) \n \
                " ::);

	}
	else
	{
		assert(false);
	}
}


__device__ void InitVGPRAllocations()
{
	/*
			VGPR  allocations 	begin	end
			hipThreadIdx_x			0	0
			matrixB-m-base			2	3
			SUM						4	67	
			AmatrixB-k8A			68	75	+7
			matrixB-k8B				76	83	+7
			matrixC-m-idx			2	3
			matrix-C-pefetch		68	83	+16

	*/

	asm volatile(".set hipThreadIdx_x,		0   \n");
	asm volatile(".set v_matrixB_base,		2   \n");
	asm volatile(".set v_SUM,		        4   \n");
	asm volatile(".set v_matrixB_k8A,		68  \n");
	asm volatile(".set v_matrixB_k8B,		76  \n");
	asm volatile(".set v_matrixC_base,		2   \n");
	asm volatile(".set v_matrix_C_pefetch,	68  \n");
}

__device__ void InitSGPRAllocations()
{
	/*
	SGPR offset
		hipBlockIdx_x		6
		hipBlockIdx_y		7
		M					8
		N					9
		K					10
		matrixA_base		12	13		s_load_dwordx4 sgpr_dst[4], sgpr_base[2], offset,   number a 20-bit integer constant
		matrixB_Base		14	15		global_load_dword vgpr_dst, vgpr_addr[2], sgpr_saddr[2]
		matrixA_koffset		16	16
		matrixB_koffset		17	17
		matrixA_sgpr_addr	18	18
		matrixb_sgpr_addr	20	21
		matixA_tile_offset	22	23
		matixB_tile_offset	24	25
		lda					26	26
		ldb					27	27
		s_loop_k			28	28
		matrixA_m16xk2		32	96		32x FP32 needs 64 SGPRs
		matrixC_base		20	21
		matrixC_addr		22	23
		ldc					24	25
		alpha				26	27
		beta				28	29
		theta				30	31
		matrixC_m_tile_offset	32	33
		matrixC_n_tile_offset	34	35

	*/

	asm volatile(".set hipBlockIdx_x,            6  \n");
	asm volatile(".set hipBlockIdx_y,            7  \n");
	asm volatile(".set s_M,						 8  \n");
	asm volatile(".set s_N,						 9  \n");
	asm volatile(".set s_K,						 10 \n");
	asm volatile(".set s_matrixA_base,			 12	\n");
	asm volatile(".set s_matrixB_base,			 14	\n");
	asm volatile(".set s_matrixA_koffset,		 16	\n");
	asm volatile(".set s_matrixB_koffset,		 17	\n");
	asm volatile(".set s_matrixA_sgpr_addr,		 18 \n");
	asm volatile(".set s_matrixB_sgpr_addr,	     20 \n");
	asm volatile(".set s_matixA_tile_offset,	 22	\n");
	asm volatile(".set s_matixB_tile_offset, 	 24	\n");
	asm volatile(".set s_lda,					 26	\n");
	asm volatile(".set s_ldb, 					 27	\n");
	asm volatile(".set s_loop_k,				 28 \n");
	asm volatile(".set s_matrixA_m16,  			 32 \n");
	asm volatile(".set s_matrixC_base, 		     20	\n");
	asm volatile(".set s_matrixC_addr,      	 22	\n");
	asm volatile(".set s_ldc,                    24	\n");
	asm volatile(".set s_alpha,  				 26	\n");
	asm volatile(".set s_beta,				     27 \n");
	asm volatile(".set s_theta,				     28	\n");
	asm volatile(".set s_matrixC_m_tile_offset,     32 \n");
	asm volatile(".set s_matrixC_n_tile_offset,     34 \n");
	asm volatile(".set s_DWORD2Byte,                4  \n");
	asm volatile(".set s_DWORD2ByteShift,           3  \n");
	asm volatile(".set s_BlockDim_y,                128\n");

}


/*
		s[4:5] offset
		matA:  0x8
		matB:  0x10
		matC:  0x18
		M:	   0x20
		N:	   0x24
		K:     0x28
		lda:   0x2C
		ldb:   0x30
		ldc:   0x34
		alpha: 0x38
		beta:  0x3C
*/

__device__ void InitMatrixABInfo()
{
	//Load Constant from S[4:5]
	asm volatile("s_load_dwordx2  s[s_matrixA_base:s_matrixA_base+1], s[4:5], 0x8  \n");
	asm volatile("s_load_dwordx2  s[s_matrixB_base:s_matrixB_base+1], s[4:5], 0x10 \n");
	asm volatile("s_load_dword    s[s_M],							  s[4:5], 0x20 \n");
	asm volatile("s_load_dword    s[s_N],							  s[4:5], 0x24 \n");
	asm volatile("s_load_dword    s[s_K],							  s[4:5], 0x28 \n");
	asm volatile("s_load_dword	  s[s_lda],							  s[4:5], 0x2c \n");
	asm volatile("s_load_dword	  s[s_ldb],							  s[4:5], 0x30 \n");

	//Compute Matrix A's M offset for 4 waves 
	//Macro-tile-64x256
	//wave_M_ = hipBlockIdx_x * 64 + wavid_+id * 0
	//wave_M_offset  = wave_M * lda * 4 
	//matrix_A_base += wave_m_offset

	asm volatile("s_lshl_b32      s[s_matixA_tile_offset],  s[hipBlockIdx_y], 6 \n");  //macro tile size 64x256

	//Per-wave + 16x FP32 
	//asm volatile("v_readfirstlane_b32	s[s_matixA_tile_offset+1],  v[hipThreadIdx_x]\n");
	//asm volatile("s_lshr_b32			s[s_matixA_tile_offset+1],  s[s_matixA_tile_offset+1], 6\n");  //wave_id
	//asm volatile("s_lshl_b32			s[s_matixA_tile_offset+1],  s[s_matixA_tile_offset+1], 5\n");  //wave_id * 32 
	//asm volatile("s_add_u32				s[s_matixA_tile_offset],    s[s_matixA_tile_offset],  s[s_matixA_tile_offset+1]\n");  //m_base per wave
	asm volatile("s_mov_b32				s[s_matixA_tile_offset+1],  0 \n");


	//Computer Matrix B's N offset for 4 waves 
	//thread_N_offset = hipThreadIdx 
	//asm volatile("v_and_b32		 v[v_matrixB_base],  v[hipThreadIdx_x], 0x3f\n");
	asm volatile("v_mov_b32		 v[v_matrixB_base],  v[hipThreadIdx_x]");
	asm volatile("v_mov_b32		 v[v_matrixB_base+1],  0x0\n");
	//matrix_B_Tile_offset will be added back into SGPR	
	asm volatile("s_lshl_b32	s[s_matixB_tile_offset], s[hipBlockIdx_x], 8\n");  //*Macro tile 64x256

	//init 
	asm volatile("s_mov_b32    s[s_matrixA_koffset], 0\n");
	asm volatile("s_mov_b32    s[s_matrixB_koffset], 0\n");

	asm volatile("s_mov_b32   s[s_matrixA_sgpr_addr], 0\n");
	asm volatile("s_mov_b32   s[s_matrixA_sgpr_addr+1], 0\n");

	asm volatile("s_mov_b32   s[s_matrixB_sgpr_addr], 0\n");
	asm volatile("s_mov_b32   s[s_matrixB_sgpr_addr+1], 0\n");

	asm volatile("v_mov_b32   v[v_SUM + 0 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 1 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 2 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 3 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 4 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 5 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 6 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 7 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 8 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 9 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 10 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 11 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 12 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 13 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 14 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 15 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 16 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 17 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 18 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 19 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 20 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 21 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 22 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 23 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 24 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 25 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 26 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 27 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 28 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 29 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 30 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM + 31 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 0 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 1 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 2 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 3 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 4 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 5 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 6 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 7 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 8 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 9 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 10 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 11 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 12 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 13 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 14 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 15 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 16 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 17 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 18 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 19 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 20 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 21 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 22 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 23 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 24 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 25 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 26 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 27 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 28 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 29 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 30 ], 0.0\n");
	asm volatile("v_mov_b32   v[v_SUM +32+ 31 ], 0.0\n");

	lgkmcnt(0);

	//Add back M_offset and N_Offset to base addr
	//s_matrixA_Base += M_offset * lda
	asm volatile("s_lshl_b32	s[s_lda],  s[s_lda], 2\n");  //FP32 To Byte
	asm volatile("s_mul_i32     s[s_matrixA_sgpr_addr],   s[s_matixA_tile_offset],  s[s_lda]\n");
	asm volatile("s_mul_hi_u32  s[s_matrixA_sgpr_addr+1], s[s_matixA_tile_offset],  s[s_lda]\n");
	asm volatile("s_add_u32		s[s_matrixA_base],    s[s_matrixA_base], s[s_matrixA_sgpr_addr] \n");
	asm volatile("s_addc_u32    s[s_matrixA_base+1],  s[s_matrixA_base+1], s[s_matrixA_sgpr_addr+1] \n");

	//Reset s_matixA_tile_offset to zero
	asm volatile("s_mov_b32     s[s_matixA_tile_offset], 0\n");

	////s_matrixB_Base += N_offset * ldb
	asm volatile("s_mul_i32		s[s_ldb],   s[s_ldb], 4\n");  //FP32 To Byte
	asm volatile("s_mul_i32     s[s_matrixB_sgpr_addr],   s[s_matixB_tile_offset],  s[s_ldb]\n");
	asm volatile("s_mul_hi_u32  s[s_matrixB_sgpr_addr+1], s[s_matixB_tile_offset],  s[s_ldb]\n");
	asm volatile("s_add_u32		s[s_matrixB_base],    s[s_matrixB_base],   s[s_matrixB_sgpr_addr] \n");
	asm volatile("s_addc_u32    s[s_matrixB_base+1],  s[s_matrixB_base+1], s[s_matrixB_sgpr_addr+1] \n");

	asm volatile("v_mul_i32_i24       v[v_matrixB_base],    s[s_ldb], v[v_matrixB_base]\n");
	asm volatile("v_mul_hi_i32_i24    v[v_matrixB_base+1],  s[s_ldb], v[v_matrixB_base]\n");

	asm volatile("s_mov_b32     s[s_matrixB_sgpr_addr],    s[s_matrixB_base]\n");
	asm volatile("s_mov_b32     s[s_matrixB_sgpr_addr+1],  s[s_matrixB_base+1]\n");

}

__device__ void PreConstLoadMatrixA()
{
	asm volatile("s_mov_b32		   s[s_matrixA_sgpr_addr], 	s[s_matrixA_koffset]\n");
}

__device__ void PostConstLoadMatrixA()
{
	asm volatile("s_add_u32  s[s_matrixA_koffset], s[s_matrixA_koffset], 8*4\n");  //FP32 * K8 = 
}


__device__ void  ConstLoadMatrixAOnce()
{
		asm volatile("s_load_dwordx8   s[s_matrixA_m16:s_matrixA_m16+7], s[s_matrixA_base:s_matrixA_base+1],     s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");
		
		asm volatile("s_load_dwordx8   s[s_matrixA_m16+8 : s_matrixA_m16+15], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

		asm volatile("s_load_dwordx8  s[s_matrixA_m16+16 : s_matrixA_m16+23], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

		asm volatile("s_load_dwordx8  s[s_matrixA_m16+24 : s_matrixA_m16+31], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

		asm volatile("s_load_dwordx8  s[s_matrixA_m16+32 : s_matrixA_m16+39], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

		asm volatile("s_load_dwordx8  s[s_matrixA_m16+40 : s_matrixA_m16+47], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

		asm volatile("s_load_dwordx8   s[s_matrixA_m16+48 : s_matrixA_m16+55], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

		asm volatile("s_load_dwordx8  s[s_matrixA_m16+56 : s_matrixA_m16+63], s[s_matrixA_base:s_matrixA_base+1], s[s_matrixA_sgpr_addr]\n");
		asm volatile("s_add_u32        s[s_matrixA_sgpr_addr], 	s[s_matrixA_sgpr_addr], s[s_lda]\n");

}


__device__ void  GlobalLoadMatrixB(int groupIndex)
{
	if (groupIndex == 0)
	{
		//global_load_dwordx4 vgpr_dst[4], vgpr_addr[2], sgpr_saddr[2]
		//Matrix B from TCP only  4 SIMDs has the same data
		asm volatile("global_load_dwordx4 v[v_matrixB_k8A:v_matrixB_k8A+3],  v[v_matrixB_base:v_matrixB_base+1],  s[s_matrixB_sgpr_addr:s_matrixB_sgpr_addr+1]\n");

		//2XFP32 == 4DWORDs = 16 bytes
		asm volatile("s_add_u32			  s[s_matrixB_sgpr_addr],   s[s_matrixB_sgpr_addr], 16\n");
		asm volatile("s_addc_u32		  s[s_matrixB_sgpr_addr+1], s[s_matrixB_sgpr_addr+1], 0\n");
		asm volatile("global_load_dwordx4 v[v_matrixB_k8A+4:v_matrixB_k8A+7],  v[v_matrixB_base:v_matrixB_base+1],  s[s_matrixB_sgpr_addr:s_matrixB_sgpr_addr+1]\n");

		asm volatile("s_add_u32			  s[s_matrixB_sgpr_addr],   s[s_matrixB_sgpr_addr], 16\n");
		asm volatile("s_addc_u32		  s[s_matrixB_sgpr_addr+1], s[s_matrixB_sgpr_addr+1], 0\n");

	}
	else
	{
		asm volatile("global_load_dwordx4 v[v_matrixB_k8B+0:v_matrixB_k8B+3],  v[v_matrixB_base:v_matrixB_base+1],  s[s_matrixB_sgpr_addr:s_matrixB_sgpr_addr+1]\n");

		asm volatile("s_add_u32			  s[s_matrixB_sgpr_addr],   s[s_matrixB_sgpr_addr], 16\n");
		asm volatile("s_addc_u32		  s[s_matrixB_sgpr_addr+1], s[s_matrixB_sgpr_addr+1], 0\n");
		asm volatile("global_load_dwordx4 v[v_matrixB_k8B+4:v_matrixB_k8B+7],  v[v_matrixB_base:v_matrixB_base+1],  s[s_matrixB_sgpr_addr:s_matrixB_sgpr_addr+1]\n");

		asm volatile("s_add_u32			  s[s_matrixB_sgpr_addr],   s[s_matrixB_sgpr_addr], 16\n");
		asm volatile("s_addc_u32		  s[s_matrixB_sgpr_addr+1], s[s_matrixB_sgpr_addr+1], 0\n");

	}
}



__device__ void  MajorLoopBegin()
{
	asm volatile("s_mov_b32  s[s_loop_k], 0\n");
	asm volatile("label_major_loop_begin:\n");
}

__device__ void MajorLoopEnd() {
	//Unorll K= 16 
	asm volatile("s_add_u32			s[s_loop_k],s[s_loop_k], 16\n");
	asm volatile("s_cmp_ge_u32		s[s_loop_k], s[s_K]\n");
	asm volatile("s_cbranch_scc0    label_major_loop_begin\n");
	//asm volatile("label_major_loop:\n");


}

__device__ void DotProductMacros()
{
	asm volatile(".macro outerDotproduct_one_sum sum_offset, v_matB_offset\n \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 0], s[s_matrixA_m16 + 0 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 1], s[s_matrixA_m16 + 1 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 2], s[s_matrixA_m16 + 2 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 3], s[s_matrixA_m16 + 3 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 4], s[s_matrixA_m16 + 4 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 5], s[s_matrixA_m16 + 5 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 6], s[s_matrixA_m16 + 6 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
					v_fma_f32  v[v_SUM + \\sum_offset], v[\\v_matB_offset + 7], s[s_matrixA_m16 + 7 + 8 *(0x7 & \\sum_offset)], v[v_SUM + \\sum_offset]\n  \
	.endmacro \n"::);

	asm volatile(".macro DotProductGroupA groupindex  \n  \
					outerDotproduct_one_sum (\\groupindex * 8 + 0),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 1),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 2),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 3),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 4),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 5),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 6),  v_matrixB_k8A \n   \
					outerDotproduct_one_sum (\\groupindex * 8 + 7),  v_matrixB_k8A \n   \
		.endmacro \n"::);

	asm volatile(".macro DotProductGroupB groupindex \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 0),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 1),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 2),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 3),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 4),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 5),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 6),  v_matrixB_k8B \n \
					outerDotproduct_one_sum (\\groupindex * 8 + 7),  v_matrixB_k8B \n \
	.endmacro \n"::);
}

__device__ void DotProductGroupA(int groupindex)
{
	if (0 == groupindex)
	{
		asm volatile("DotProductGroupA 0 \n");
	}

	if (1 == groupindex)
	{
		asm volatile("DotProductGroupA 1 \n");
	}

	if (2 == groupindex)
	{
		asm volatile("DotProductGroupA 2 \n");
	}

	if (3 == groupindex)
	{
		asm volatile("DotProductGroupA 3 \n");
	}

	if (4 == groupindex)
	{
		asm volatile("DotProductGroupA 4 \n");
	}

	if (5 == groupindex)
	{
		asm volatile("DotProductGroupA 5 \n");
	}

	if (6 == groupindex)
	{
		asm volatile("DotProductGroupA 6 \n");
	}

	if (7 == groupindex)
	{
		asm volatile("DotProductGroupA 7 \n");
	}
}

__device__ void DotProductGroupB(int groupindex)
{
	if (0 == groupindex)
	{
		asm volatile("DotProductGroupB 0 \n");
	}

	if (1 == groupindex)
	{
		asm volatile("DotProductGroupB 1 \n");
	}

	if (2 == groupindex)
	{
		asm volatile("DotProductGroupB 2 \n");
	}

	if (3 == groupindex)
	{
		asm volatile("DotProductGroupB 3 \n");
	}

	if (4 == groupindex)
	{
		asm volatile("DotProductGroupB 4 \n");
	}

	if (5 == groupindex)
	{
		asm volatile("DotProductGroupB 5 \n");
	}

	if (6 == groupindex)
	{
		asm volatile("DotProductGroupB 6 \n");
	}

	if (7 == groupindex)
	{
		asm volatile("DotProductGroupB 7 \n");
	}
}
__device__ void InitMatrixCInfo()
{

	//load 
	asm volatile("s_load_dwordx2   s[s_matrixC_base:s_matrixC_base+1],  s[4:5], 0x18\n");
	asm volatile("s_load_dword     s[s_ldc],							s[4:5], 0x34\n");
	asm volatile("s_load_dwordx2    s[s_alpha:s_beta],					s[4:5], 0x38\n");

	//v_matrixC_base = (M_tile_base  + wave_id* per_wave_M_stride=0) * ldc
	asm volatile("s_lshl_b32			s[s_matrixC_m_tile_offset],     s[hipBlockIdx_y], 6 \n");  //64*256 macro tile size
//	asm volatile("v_readfirstlane_b32	s[s_matrixC_m_tile_offset+1],	 v[hipThreadIdx_x]\n");
//	asm volatile("s_lshr_b32			s[s_matrixC_m_tile_offset+1],   s[s_matrixC_m_tile_offset+1], 6 \n");
//	asm volatile("s_lshl_b32			s[s_matrixC_m_tile_offset+1],   s[s_matrixC_m_tile_offset+1], 5 \n");  //*32
//	asm volatile("s_add_u32			    s[s_matrixC_m_tile_offset],     s[s_matrixC_m_tile_offset], s[s_matrixC_m_tile_offset+1]\n");



	//per-vertex-n offset = hipThreadIdx & 0x3f  
	// n offset = N_TILE_offset + per-vertex_n
	asm volatile("s_lshl_b32      s[s_matrixC_n_tile_offset],   s[hipBlockIdx_x] , 8\n");  //32 * 256 macro tile size
	//asm volatile("v_and_b32       v[v_matrixC_base],  0x3f, v[hipThreadIdx_x]\n");
	asm volatile("v_mov_b32       v[v_matrixC_base],  v[hipThreadIdx_x]\n");
	asm volatile("v_add_i32       v[v_matrixC_base], s[s_matrixC_n_tile_offset], v[v_matrixC_base]\n");
	asm volatile("v_lshlrev_b32   v[v_matrixC_base], 2,  v[v_matrixC_base]\n");  //FP32 * 4 --> Bytes;
	asm volatile("v_mov_b32       v[v_matrixC_base+1],0\n");

	lgkmcnt(0);
	asm volatile("s_mul_i32		s[s_ldc],  s[s_ldc],    4\n");


	asm volatile("s_mul_i32		s[s_matrixC_addr],		s[s_matrixC_m_tile_offset], s[s_ldc]\n");
	asm volatile("s_mul_hi_u32  s[s_matrixC_addr+1] ,	s[s_matrixC_m_tile_offset], s[s_ldc]\n");
	asm volatile("s_add_u32     s[s_matrixC_addr],      s[s_matrixC_addr],       s[s_matrixC_base]\n");
	asm volatile("s_addc_u32    s[s_matrixC_addr+1],    s[s_matrixC_addr+1],     s[s_matrixC_base+1]\n");

	//Rerseve for global store usage
	asm volatile("s_mov_b32     s[s_matrixC_base],      s[s_matrixC_addr]\n");
	asm volatile("s_mov_b32     s[s_matrixC_base+1],    s[s_matrixC_addr+1]\n");

}

__device__ void GlobalLoadMatrixC()
{
	asm volatile(".macro load_matrixc  offset \n \
					global_load_dword  v[v_matrix_C_pefetch +  \\offset],  v[v_matrixC_base:v_matrixC_base+1], s[s_matrixC_addr:s_matrixC_addr+1]\n \
					s_add_u32     s[s_matrixC_addr],      s[s_matrixC_addr],       s[s_ldc]\n \
					s_addc_u32    s[s_matrixC_addr+1],    s[s_matrixC_addr+1],     0\n  \
	.endmacro \n"::);

	asm volatile(" load_matrixc    0\n"); 
	asm volatile(" load_matrixc    1\n");
	asm volatile(" load_matrixc    2\n");
	asm volatile(" load_matrixc    3\n");
	asm volatile(" load_matrixc    4\n");
	asm volatile(" load_matrixc    5\n");
	asm volatile(" load_matrixc    6\n");
	asm volatile(" load_matrixc    7\n");
	asm volatile(" load_matrixc    8\n");
	asm volatile(" load_matrixc    9\n");
	asm volatile(" load_matrixc    10\n");
	asm volatile(" load_matrixc    11\n");
	asm volatile(" load_matrixc    12\n");
	asm volatile(" load_matrixc    13\n");
	asm volatile(" load_matrixc    14\n");
	asm volatile(" load_matrixc    15\n");

}

__device__ void GlboalStoreMatrixC()
{

	//asm volatile("s_mov_b32     s[s_matrixC_addr],      s[s_matrixC_base]      \n");
	//asm volatile("s_mov_b32     s[s_matrixC_addr+1],    s[s_matrixC_base+1]    \n");

	asm volatile(
		".macro m_store_sum_load_grp2  v_sum_offset\n \
				s_waitcnt  vmcnt(15 + \\v_sum_offset) \n \
				v_fma_f32	    v[v_SUM  +  \\v_sum_offset],  s[s_beta], v[v_matrix_C_pefetch +  \\v_sum_offset], v[v_SUM  +  \\v_sum_offset] \n \
				global_load_dword  v[v_matrix_C_pefetch + \\v_sum_offset],  v[v_matrixC_base:v_matrixC_base + 1], s[s_matrixC_addr:s_matrixC_addr+1] \n \
				global_store_dword   v[v_matrixC_base:v_matrixC_base+1],  v[v_SUM  +  \\v_sum_offset], s[s_matrixC_base:s_matrixC_base+1 ] \n \
				s_add_u32     s[s_matrixC_addr],      s[s_matrixC_addr],       s[s_ldc]  \n \
				s_addc_u32    s[s_matrixC_addr+1],    s[s_matrixC_addr+1],       0 \n \
				s_add_u32     s[s_matrixC_base],      s[s_matrixC_base],       s[s_ldc] \n \
				s_addc_u32    s[s_matrixC_base+1],    s[s_matrixC_base+1],     0 \n \
		.endmacro \n \
		":: );

	asm volatile(
		".macro m_store_sum_load_grp3  v_sum_offset\n \
				s_waitcnt  vmcnt(30) \n \
				v_fma_f32	    v[v_SUM  +  \\v_sum_offset + 16],  s[s_beta], v[v_matrix_C_pefetch +  \\v_sum_offset ], v[v_SUM  +  \\v_sum_offset + 16] \n \
				global_load_dword  v[v_matrix_C_pefetch + \\v_sum_offset],  v[v_matrixC_base:v_matrixC_base + 1], s[s_matrixC_addr:s_matrixC_addr+1] \n \
				global_store_dword   v[v_matrixC_base:v_matrixC_base+1],  v[v_SUM  +  \\v_sum_offset + 16], s[s_matrixC_base:s_matrixC_base+1 ] \n \
				s_add_u32     s[s_matrixC_addr],      s[s_matrixC_addr],       s[s_ldc]  \n \
				s_addc_u32    s[s_matrixC_addr+1],    s[s_matrixC_addr+1],       0 \n \
				s_add_u32     s[s_matrixC_base],      s[s_matrixC_base],       s[s_ldc] \n \
				s_addc_u32    s[s_matrixC_base+1],    s[s_matrixC_base+1],     0 \n \
		.endmacro \n \
		"::);

	asm volatile(
		".macro m_store_sum_load_grp4  v_sum_offset\n \
				s_waitcnt  vmcnt(30) \n \
				v_fma_f32	    v[v_SUM  +  \\v_sum_offset + 32],  s[s_beta], v[v_matrix_C_pefetch +  \\v_sum_offset ], v[v_SUM  +  \\v_sum_offset + 32] \n \
				global_load_dword  v[v_matrix_C_pefetch + \\v_sum_offset],  v[v_matrixC_base:v_matrixC_base + 1], s[s_matrixC_addr:s_matrixC_addr+1] \n \
				global_store_dword   v[v_matrixC_base:v_matrixC_base+1],  v[v_SUM  +  \\v_sum_offset + 32], s[s_matrixC_base:s_matrixC_base+1 ] \n \
				s_add_u32     s[s_matrixC_addr],      s[s_matrixC_addr],       s[s_ldc]  \n \
				s_addc_u32    s[s_matrixC_addr+1],    s[s_matrixC_addr+1],       0 \n \
				s_add_u32     s[s_matrixC_base],      s[s_matrixC_base],       s[s_ldc] \n \
				s_addc_u32    s[s_matrixC_base+1],    s[s_matrixC_base+1],     0 \n \
		.endmacro \n \
		"::);

	asm volatile(
		".macro m_store_sum_lastgroup  v_sum_offset\n \
				s_waitcnt  vmcnt(30) \n \
				v_fma_f32	    v[v_SUM  +  \\v_sum_offset + 48],  s[s_beta], v[v_matrix_C_pefetch +  \\v_sum_offset ], v[v_SUM  +  \\v_sum_offset + 48] \n \
				global_store_dword   v[v_matrixC_base:v_matrixC_base+1],  v[v_SUM  +  \\v_sum_offset + 48], s[s_matrixC_base:s_matrixC_base+1 ] \n \
				s_add_u32     s[s_matrixC_base],      s[s_matrixC_base],       s[s_ldc] \n \
				s_addc_u32    s[s_matrixC_base+1],    s[s_matrixC_base+1],     0 \n \
		.endmacro \n \
		"::);


	asm volatile("m_store_sum_load_grp2 0  \n");
	asm volatile("m_store_sum_load_grp2 1   \n");
	asm volatile("m_store_sum_load_grp2 2   \n");
	asm volatile("m_store_sum_load_grp2 3   \n");
	asm volatile("m_store_sum_load_grp2 4   \n");
	asm volatile("m_store_sum_load_grp2 5   \n");
	asm volatile("m_store_sum_load_grp2 6   \n");
	asm volatile("m_store_sum_load_grp2 7   \n");
	asm volatile("m_store_sum_load_grp2 8   \n");
	asm volatile("m_store_sum_load_grp2 9   \n");
	asm volatile("m_store_sum_load_grp2 10   \n");
	asm volatile("m_store_sum_load_grp2 11   \n");
	asm volatile("m_store_sum_load_grp2 12   \n");
	asm volatile("m_store_sum_load_grp2 13   \n");
	asm volatile("m_store_sum_load_grp2 14   \n");
	asm volatile("m_store_sum_load_grp2 15   \n");

	asm volatile("m_store_sum_load_grp3 0  \n");
	asm volatile("m_store_sum_load_grp3 1   \n");
	asm volatile("m_store_sum_load_grp3 2   \n");
	asm volatile("m_store_sum_load_grp3 3   \n");
	asm volatile("m_store_sum_load_grp3 4   \n");
	asm volatile("m_store_sum_load_grp3 5   \n");
	asm volatile("m_store_sum_load_grp3 6   \n");
	asm volatile("m_store_sum_load_grp3 7   \n");
	asm volatile("m_store_sum_load_grp3 8   \n");
	asm volatile("m_store_sum_load_grp3 9   \n");
	asm volatile("m_store_sum_load_grp3 10   \n");
	asm volatile("m_store_sum_load_grp3 11   \n");
	asm volatile("m_store_sum_load_grp3 12   \n");
	asm volatile("m_store_sum_load_grp3 13   \n");
	asm volatile("m_store_sum_load_grp3 14   \n");
	asm volatile("m_store_sum_load_grp3 15   \n");

	asm volatile("m_store_sum_load_grp4 0  \n");
	asm volatile("m_store_sum_load_grp4 1   \n");
	asm volatile("m_store_sum_load_grp4 2   \n");
	asm volatile("m_store_sum_load_grp4 3   \n");
	asm volatile("m_store_sum_load_grp4 4   \n");
	asm volatile("m_store_sum_load_grp4 5   \n");
	asm volatile("m_store_sum_load_grp4 6   \n");
	asm volatile("m_store_sum_load_grp4 7   \n");
	asm volatile("m_store_sum_load_grp4 8   \n");
	asm volatile("m_store_sum_load_grp4 9   \n");
	asm volatile("m_store_sum_load_grp4 10   \n");
	asm volatile("m_store_sum_load_grp4 11   \n");
	asm volatile("m_store_sum_load_grp4 12   \n");
	asm volatile("m_store_sum_load_grp4 13   \n");
	asm volatile("m_store_sum_load_grp4 14   \n");
	asm volatile("m_store_sum_load_grp4 15   \n");

	asm volatile("m_store_sum_lastgroup 0  \n");
	asm volatile("m_store_sum_lastgroup 1   \n");
	asm volatile("m_store_sum_lastgroup 2   \n");
	asm volatile("m_store_sum_lastgroup 3   \n");
	asm volatile("m_store_sum_lastgroup 4   \n");
	asm volatile("m_store_sum_lastgroup 5   \n");
	asm volatile("m_store_sum_lastgroup 6   \n");
	asm volatile("m_store_sum_lastgroup 7   \n");
	asm volatile("m_store_sum_lastgroup 8   \n");
	asm volatile("m_store_sum_lastgroup 9   \n");
	asm volatile("m_store_sum_lastgroup 10   \n");
	asm volatile("m_store_sum_lastgroup 11   \n");
	asm volatile("m_store_sum_lastgroup 12   \n");
	asm volatile("m_store_sum_lastgroup 13   \n");
	asm volatile("m_store_sum_lastgroup 14   \n");
	asm volatile("m_store_sum_lastgroup 15   \n");

}

/*/
__global__ void packed_store(uint32_t inlen, const uint32_t* in, const uint8_t* mask, uint32_t* out, long long* auxBuf) {
	int global_x = hipBlockIdx_x * hipBlockDim_x + hipThreadIdx_x;

	//
	long long append_wk_id   =auxBuf[0];   //Init to 0
	long long append_out_idx = auxBuf[1];  // Init to 1


	/
	int out_idx_in_current_wk;
	if (global_x[mask]) {
		" ds_append out_idx_in_current_wk"
			//如果不使用ds_append，去寻找一个 prefix sum算法

	}

	//DO LDS reduction of Max value  of out_idx_in_current_wk
	// Add LDS reduction function here  
	int wk_total_index = Lds_reduce_max(out_idx_in_current_wk);

	if (wk_total_index == 0)
		return;

	//polling
	while (append_wk_id < hipBlockIdx_x)
	{
		append_wk_id = auxBuf[0];
		append_out_idx = auxBuf[1];
	}

	if (hipThreadIdx == 0)
	{
		atomic_inc(append_wk_id);
		atomic_add(append_out_idx, append_out_idx);
	}
	if (global_x[mask]) {
		out[append_out_idx + out_idx_in_current_wk] = in[i];
	}

}
*/

__global__ void
sgemm_wk256_m64x256_t64x1_SQC(hipLaunchParm lp,
	const float* __restrict__  matA, const float* __restrict__ matB, float* __restrict__ matC,
	int M, int N, int K,
	int lda, int ldb, int ldc,
	float alpha, float beta,
	int matrixCTranspose)
{

	InitVGPRAllocations();

	InitSGPRAllocations();
	InitMatrixABInfo();

	GlobalLoadMatrixB(0);

	PreConstLoadMatrixA();
	//ConstLoadMatrixAOnce();

	//Call Macro defines
	DotProductMacros();
	MajorLoopBegin();
	{
		
		ConstLoadMatrixAOnce();
		GlobalLoadMatrixB(1);
		lgkmcnt(0);
		vmcnt(2);
		DotProductGroupA(0);
		
		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupA(1);
		

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupA(2);
		

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupA(3);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupA(4);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupA(5);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupA(6);


		ConstLoadMatrixAOnce();
		PostConstLoadMatrixA();
		PreConstLoadMatrixA();
		lgkmcnt(0);
		DotProductGroupA(7);

		ConstLoadMatrixAOnce();
		GlobalLoadMatrixB(0);
		vmcnt(2);
		lgkmcnt(0);
		DotProductGroupB(0);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupB(1);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupB(2);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupB(3);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupB(4);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupB(5);

		ConstLoadMatrixAOnce();
		lgkmcnt(0);
		DotProductGroupB(6);

		ConstLoadMatrixAOnce();
		PostConstLoadMatrixA();
		PreConstLoadMatrixA();
		lgkmcnt(0);
		DotProductGroupB(7);
		
	}
	MajorLoopEnd();
	lgkmcnt(0);  // to Avoid SGPR rewrite error  
	InitMatrixCInfo();
	GlobalLoadMatrixC();
	GlboalStoreMatrixC();

	asm volatile ("label_end:\n");
}

/*
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
*/
using namespace std;

void test()
{

	//M_N_Start, END, step, K, +A/B padding 
	//to Debug on Vega10 8GB
	int tests[4][5] = {
		{256,	20736, 256,  256,  16 },
		{384,	20736, 384,  384,  16 },
		{5760,	5760,  5760, 5760, 16 },
		{8192,	8192,  8192, 8192, 16 }
	};


	unsigned int  A_NUM = (8192 + 16) * (8192 + 16);
	unsigned int  B_NUM = (8192 + 16) * (8192 + 16);
	unsigned int  C_NUM = (20736 + 16) * (20736 + 16);


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

	for (int j = 0; j < (8192 + 16); j++)
	{
		for (int i = 0; i < (8192 + 16); i++) {
			hostA[j * (8192) + 16] = sin(j * (8192 + 16) + i);
			hostB[j * (8192) + 16] = cos(j * (8192 + 16) + i);
		}
	}

	HIP_ASSERT(hipMemcpy(deviceA, hostA, A_NUM * sizeof(float), hipMemcpyHostToDevice));
	HIP_ASSERT(hipMemcpy(deviceB, hostB, B_NUM * sizeof(float), hipMemcpyHostToDevice));
	printf("Copied memory A&B\n");

	for (int j = 0; j < (20736 + 16); j++)
	{
		for (int i = 0; i < (20736 + 16); i++) {
			hostC[j * (20736) + 16] = sin(j * (20736 + 16) + i);
		}
	}
	HIP_ASSERT(hipMemcpy(deviceC, hostC, C_NUM * sizeof(float), hipMemcpyHostToDevice));
	printf("Copied memory C\n");



	for (int t = 0; t < 4; t++)
	{
		int blocks_m, blocks_n;
		int test_m, test_n, test_k;
		int lda, ldb, ldc;
		float alpha = 1.0;
		float beta = 1.0;

		for (int m = tests[t][0]; m <= tests[t][1]; m += tests[t][2])
		{


			test_m = m;
			test_n = m;
			test_k = tests[t][3];
			lda = test_m + 16;
			ldb = test_n + 16;
			ldc = test_k + 16;
			blocks_m = test_m / 64;
			blocks_n = test_n / 64;

			hipEventRecord(start, NULL);


			hipLaunchKernel(sgemm_wk256_m64x256_t64x1_SQC,
				dim3(blocks_n, blocks_m, 1),
				dim3(256, 1, 1),
				0, 0,
				(float*)deviceA, (float*)deviceB, (float*)deviceC,
				test_m, test_n, test_k,
				lda, ldb, ldc,
				1.0, 1.0,
				0);

			hipEventRecord(stop, NULL);
			hipEventSynchronize(stop);

			hipEventElapsedTime(&eventMs, start, stop);

			double total_G_flops = double(test_m) * double(test_n) * double(test_k) * 2 + 3 * double(test_m) * double(test_n);
			total_G_flops = total_G_flops / 1e9;

			float eventsecond = eventMs / 1000;
			float perf_tflops = total_G_flops / eventsecond;

			printf("M, N , K: [%6d, %6d, %6d] , total GFlops: %5.3f,  costs: %5.6f seconds performance:%2.3f TFlops/s\n", test_m, test_n, test_k, (float)total_G_flops, eventsecond, perf_tflops);
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


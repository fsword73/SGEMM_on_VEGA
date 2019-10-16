#include <assert.h>
#include <stdio.h>
#include <algorithm>
#include <stdlib.h>
#include <iostream>
#include "hip/hip_runtime.h"
#include <math.h>

//  /opt/rocm/hcc/bin/clang -x assembler -target amdgcn--amdhsa -mcpu=gfx900 -mno-code-object-v3 a.s -o a.co
//command line:  sconv.out 1 512 8 8 2048 10 0

#define HIP_ASSERT(x) (assert((x)==hipSuccess))


#define THREADS_PER_BLOCK_X  256
#define THREADS_PER_BLOCK_Y  1
#define THREADS_PER_BLOCK_Z  1

typedef struct {
	hipModule_t   module;
	hipFunction_t kern[16];
} dgemmOp_t;


hipError_t LoadSconvKernel(hipModule_t& handle , hipFunction_t& kernel)
{
	hipError_t status;
	//VEGA20 will be dgemm_64x64_sqc_gfx906.o
	printf("sconv.co begin\n");
	status = hipModuleLoad(&handle, "sconv.co");

	printf("sconv.co loaded\n");

	if (status != hipSuccess) {
		free(handle); handle = NULL;
		printf("sconv.co not found\n");
		return status;
	}
	status =  hipModuleGetFunction(&kernel, handle, "sconv_32x32_splitk4_asm");
	if (status != hipSuccess) {
		free(handle); handle = NULL;
		printf("sconv_32x32_splitk4_asm kernel not found\n");

		return status;
	}
	return status;
}

//__global__ void sconv_32x32_splitK4_NCHW_asm(hipLaunchParm lp, 	const float* __restrict__ in, const float* __restrict__ weights, float* __restrict__ out,
//const int H, const int W, const int C, const int K, const int loops_k)


hipError_t Sconv(hipFunction_t& kernel, float* in, float* weights, float* out , int h, int w, int c, int k, int loops_k)
{
	char argbuf[68];
	size_t argsize = 0;
	*((void**)& argbuf[argsize]) = (void*)0; argsize += sizeof(void*);  // The first parameter isignored 
	*((void**)& argbuf[argsize]) = (void*)in; argsize += sizeof(void*);
	*((void**)& argbuf[argsize]) = (void*)weights; argsize += sizeof(void*);
	*((void**)& argbuf[argsize]) = (void*)out; argsize += sizeof(void*);
	*((int*)& argbuf[argsize]) = h; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = w; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = c; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = k; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = loops_k; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = 0; argsize += sizeof(int);


	//A formular :  Matrix K = C ,  Matrix  M = H *W 
	//B Formular :  Matrix K = C,   Matrix  N = K

	void* config[] = { HIP_LAUNCH_PARAM_BUFFER_POINTER,argbuf,
					 HIP_LAUNCH_PARAM_BUFFER_SIZE,&argsize,
					 HIP_LAUNCH_PARAM_END };

	uint32_t	m_tile_size = 32; 
	uint32_t	n_tile_size = 32;

	uint32_t gdx = (h*w) / m_tile_size;
	uint32_t gdy = k / n_tile_size;

	//printf("gdX,gdY: %d, %d\n", gdx, gdy);

	return hipModuleLaunchKernel(kernel, gdx, gdy, 1, 256, 1, 1, 0, 0, NULL, &config[0]);

}




hipError_t release_Sconv(hipModule_t& handle)
{
	if (handle != NULL) {
		hipModuleUnload(handle);

	}
	return hipSuccess;
}


using namespace std;

void test(int n, int c, int h, int w, int k, int printout, int iterations=10, int padding = 16)
{
	unsigned int  A_NUM =  n * c * h * w  + padding;
	unsigned int  B_NUM =  c * k + padding;
	unsigned int  C_NUM = n * k * h * w + padding;;


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

	cout << "host allocated \n";
	HIP_ASSERT(hipMalloc((void**)& deviceA, A_NUM * sizeof(float)));
	HIP_ASSERT(hipMalloc((void**)& deviceB, B_NUM * sizeof(float)));
	HIP_ASSERT(hipMalloc((void**)& deviceC, C_NUM * sizeof(float)));

	cout << "device allocated \n";
	if (printout == 0)
	{
		for (int i = 0; i < (A_NUM); i++)
		{
			hostA[i] = sin( i );
		}
		for (int i = 0; i < (B_NUM); i++)
		{
			hostB[i] = cos(i);
		}
		for (int i = 0; i < (C_NUM); i++)
		{
			hostC[i] = 0;
		}

	}
	else
	{
		for (int i = 0; i < (A_NUM); i++)
		{
			hostA[i] = sin(i);
		}
		for (int i = 0; i < (B_NUM); i++)
		{
			hostB[i] = cos(i);
		}
		for (int i = 0; i < (C_NUM); i++)
		{
			hostC[i] = 0;
		}

	}

	HIP_ASSERT(hipMemcpy(deviceA, hostA, A_NUM * sizeof(float), hipMemcpyHostToDevice));
	HIP_ASSERT(hipMemcpy(deviceB, hostB, B_NUM * sizeof(float), hipMemcpyHostToDevice));
	HIP_ASSERT(hipMemcpy(deviceC, hostC, C_NUM * sizeof(float), hipMemcpyHostToDevice));
	
	cout << "Host to Device Copied\n";

	hipModule_t    hModule ;
	hipFunction_t  Sconvkernel ;
	LoadSconvKernel(hModule, Sconvkernel);
	cout << "Kernel Loaded\n";
	cout << "address " << deviceA << "," << deviceB << "," << deviceC << "\n";
	{
	

			hipStreamSynchronize(0);
			//Sconv(hipFunction_t & kernel, float* in, float* weights, float* out, int h, int w, int c, int k, int loops_k)

			Sconv(Sconvkernel, deviceA, deviceB, deviceC, h, w, c, k, c/4);

			hipStreamSynchronize(0);
			HIP_ASSERT(hipMemcpy(hostC, deviceC, sizeof(float)* C_NUM, hipMemcpyDeviceToHost));
			hipStreamSynchronize(0);
			
			if (printout) {
				for (int j = 0; j < (C_NUM); j++)
				{
					
					for (int i = 0; i < (8); i++) {
						float temp = hostC[i  + j * (n + padding)];
						printf("%f ",(float)temp);
					}
					printf("\n");
				}
			}

			hipStreamSynchronize(0);

			hipEventRecord(start, NULL);

			for (int i = 0; i < iterations; i++)
			{

				Sconv(Sconvkernel, deviceA, deviceB, deviceC, h, w, c, k, c / 4);
			}


			hipEventRecord(stop, NULL);
			hipEventSynchronize(stop);
			hipEventElapsedTime(&eventMs, start, stop);

			double total_G_flops = double(c) * double(h * w ) * (k) * 2 ;
			total_G_flops = total_G_flops / 1e9;

			float eventsecond = eventMs / 1000 / iterations;
			float perf_tflops = total_G_flops / eventsecond /1000;

			printf("C, H ,W, K: [%6d, %6d, %6d, %6d] , total GFlops: %5.3f,  costs: %5.6f seconds performance:%2.3f TFlops/s\n", c, h, w, k, (float)total_G_flops, eventsecond, perf_tflops);
	}
	HIP_ASSERT(hipMemcpy(hostC, deviceC, sizeof(float) * C_NUM, hipMemcpyDeviceToHost));

	release_Sconv(hModule);
	//CPU Verifying here
	HIP_ASSERT(hipFree(deviceA));
	HIP_ASSERT(hipFree(deviceB));
	HIP_ASSERT(hipFree(deviceC));


	free(hostA);
	free(hostB);
	free(hostC);

	//return errors;
}


int main(int argc, char** argv)
{
	if (argc != 8 )
	{
		printf("it is to demo Sconv by SQC only:\n");
		printf("    Usaga1:   n  c  h  w  k iterations print_out\n");
		printf("                                    K must be 16x, defaultiterations=10, n must ==1\n");
		printf("                                    Sconv_sqc.co with kernel name Sconv_sqc\n");

		return 0;
	}

	int  n, c, h, w, k, printout = 0;
	int iterations = 10;

	n = atoi(argv[1]);
	c = atoi(argv[2]);
	h = atoi(argv[3]);
	w = atoi(argv[4]);
	k = atoi(argv[5]);
	iterations = atoi(argv[6]);
	printout = atoi(argv[7]);

	int padding = 16;

	n = 1 ;

	test(n, c, h, w, k, printout, iterations, padding);	

	return 0;
}


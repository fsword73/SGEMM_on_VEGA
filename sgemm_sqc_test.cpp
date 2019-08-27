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

typedef struct {
	hipModule_t   module;
	hipFunction_t kern[16];
} dgemmOp_t;


hipError_t LoadSgemmKernel(hipModule_t& handle , hipFunction_t& kernel)
{
	hipError_t status;
	//VEGA20 will be dgemm_64x64_sqc_gfx906.o
	printf("sgemm_sqc.o begin\n");
	status = hipModuleLoad(&handle, "sgemm_sqc.co");

	printf("sgemm_sqc.o loaded\n");

	if (status != hipSuccess) {
		free(handle); handle = NULL;
		printf("sgemm_sqc.o not found\n");
		return status;
	}
	status =  hipModuleGetFunction(&kernel, handle, "sgemm_sqc");
	if (status != hipSuccess) {
		free(handle); handle = NULL;
		printf("sgemm_sqc kernel not found\n");

		return status;
	}
	return status;
}

hipError_t Sgemm(hipFunction_t& kernel, float* A, float* B, float* C, int M, int N, int K, int lda, int ldb, int ldc, float* alpha, float* beta, int isTranspose, int m_tile_size, int n_tile_size)
{
	char argbuf[68];
	size_t argsize = 0;
	*((void**)& argbuf[argsize]) = (void*)0; argsize += sizeof(void*);  // The first parameter isignored 
	*((void**)& argbuf[argsize]) = (void*)A; argsize += sizeof(void*);
	*((void**)& argbuf[argsize]) = (void*)B; argsize += sizeof(void*);
	*((void**)& argbuf[argsize]) = (void*)C; argsize += sizeof(void*);
	*((int*)& argbuf[argsize]) = M; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = N; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = K; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = lda; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = ldb; argsize += sizeof(int);
	*((int*)& argbuf[argsize]) = ldc; argsize += sizeof(int);
	*((float*)& argbuf[argsize]) = *alpha; argsize += sizeof(float);
	*((float*)& argbuf[argsize]) = *beta; argsize += sizeof(float);
	*((int*)& argbuf[argsize]) = 0; argsize += sizeof(int);
	
	void* config[] = { HIP_LAUNCH_PARAM_BUFFER_POINTER,argbuf,
					 HIP_LAUNCH_PARAM_BUFFER_SIZE,&argsize,
					 HIP_LAUNCH_PARAM_END };
	uint32_t gdy = M / m_tile_size;
	uint32_t gdx = N / n_tile_size;

	return hipModuleLaunchKernel(kernel, gdx, gdy, 1, 256, 1, 1, 0, 0, NULL, &config[0]);

}

hipError_t release_sgemm(hipModule_t& handle)
{
	if (handle != NULL) {
		hipModuleUnload(handle);

	}
	return hipSuccess;
}


using namespace std;

void test(int m, int n, int k, int m_tile_size, int n_tile_size, int printout, int iterations=10, int padding = 16)
{
	unsigned int  A_NUM =  m * (k + padding);
	unsigned int  B_NUM =  n * (k + padding);
	unsigned int  C_NUM =  m * (n + padding);


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
		for (int j = 0; j < (m); j++)
		{
			for (int i = 0; i < (k + padding); i++) {
				hostA[j * (k + padding)  + i] = sin( j * (k + padding) + i );
			}
		}
		for (int j = 0; j < (n ); j++)
		{
			for (int i = 0; i < (k + padding); i++) {
				hostB[j * (k + padding)  + i] = cos(j * (k + padding) + i );
			}
		}

		for (int j = 0; j < (m); j++)
		{
			for (int i = 0; i < (n + padding) ; i++) {
				hostC[j * (n + padding) + i] = 0;
			}
		}
	}
	else
	{
		for (int j = 0; j < (m ); j++)
		{
			for (int i = 0; i < (k + padding) ; i++) {
				hostA[j *  (k + padding) +  i] = (float)j/ (float)k;

			}
		}
		for (int j = 0; j < (n ); j++)
		{
			for (int i = 0; i < (k + padding); i++) {
				hostB[j * (k + padding) + i] = (float)j/ (float)k;
			}
		}

		for (int j = 0; j < (m ); j++)
		{
			for (int i = 0; i < (n + padding) ; i++) {
				hostC[j * (n + padding)  + i] = 0;
			}
		}

	}

	HIP_ASSERT(hipMemcpy(deviceA, hostA, A_NUM * sizeof(float), hipMemcpyHostToDevice));
	HIP_ASSERT(hipMemcpy(deviceB, hostB, B_NUM * sizeof(float), hipMemcpyHostToDevice));
	HIP_ASSERT(hipMemcpy(deviceC, hostC, C_NUM * sizeof(float), hipMemcpyHostToDevice));
	
	cout << "Host to Device Copied\n";

	hipModule_t    hModule ;
	hipFunction_t  sgemmkernel ;
	LoadSgemmKernel(hModule, sgemmkernel);
	cout << "Kernel Loaded\n";
	cout << "address " << deviceA << "," << deviceB << "," << deviceC << "\n";
	{
	
			int test_m, test_n, test_k;
			int lda, ldb, ldc;
			float alpha;
			float beta;

			alpha = 1.0;
			beta = 1.0;


			test_m = m ;
			test_n = n;
			test_k = k;
			lda = test_k + padding;
			ldb = test_k + padding;
			ldc = test_n + padding;
	
			hipStreamSynchronize(0);
			Sgemm(sgemmkernel, deviceA, deviceB, deviceC, test_m, test_n, test_k, lda, ldb, ldc, &alpha, &beta, 1, m_tile_size, n_tile_size);

			hipStreamSynchronize(0);
			HIP_ASSERT(hipMemcpy(hostC, deviceC, sizeof(float)* C_NUM, hipMemcpyDeviceToHost));
			hipStreamSynchronize(0);
			
			if (printout) {
				for (int j = 0; j < (m); j++)
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

				Sgemm(sgemmkernel, deviceA, deviceB, deviceC, test_m, test_n, test_k, lda, ldb, ldc, &alpha, &beta, 1, m_tile_size, n_tile_size);
			}


			hipEventRecord(stop, NULL);
			hipEventSynchronize(stop);
			hipEventElapsedTime(&eventMs, start, stop);

			double total_G_flops = double(m) * double(n) * (k) * 2 + 3 * double(m)* double (n);
			total_G_flops = total_G_flops / 1e9;

			float eventsecond = eventMs / 1000 / iterations;
			float perf_tflops = total_G_flops / eventsecond /1000;

			printf("M, N , K: [%6d, %6d, %6d] , total GFlops: %5.3f,  costs: %5.6f seconds performance:%2.3f TFlops/s\n", m, n, test_k, (float)total_G_flops, eventsecond, perf_tflops);
	}
	HIP_ASSERT(hipMemcpy(hostC, deviceC, sizeof(float) * C_NUM, hipMemcpyDeviceToHost));

	release_sgemm(hModule);
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
		printf("it is to demo SGEMM by SQC only:\n");
		printf("    Usaga1:   m  n  k m_tile_size n_tile_size iterations print_out\n");
		printf("                                    K must be 16x, defaultiterations=10\n");
		printf("                                    sgemm_sqc.co with kernel name sgemm_sqc\n");

		return 0;
	}

	int  m, n, k, m_tile, n_tile, printout = 0;
	int iterations = 10;

	m = atoi(argv[1]);
	n = atoi(argv[2]);
	k = atoi(argv[3]);
	m_tile = atoi(argv[4]);
	n_tile = atoi(argv[5]);
	iterations = atoi(argv[6]);
	printout = atoi(argv[7]);


	test(m, n, k, m_tile, n_tile, printout,  iterations, 16);

	return 0;
}


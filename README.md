An Alternative SGEMM(DGEMM) on VEGA (MI25, MI50, MI60)

to Verify Power by LDS, SGPR , and Data Forwarding

&nbsp;

# 1 Legacy DGEMM implementation

[https://github.com/NervanaSystems/maxas/wiki/SGEMM](https://github.com/NervanaSystems/maxas/wiki/SGEMM) has a detailed explain of SGEMM on Maxwell Architecture. Most SGEMM/DGEMM implementation on GPU are using similar algorithms. The top level idea of legacy SGEMM/DGEMM are implemented as Following:

*   Using work group Size (64,1,1)
*   Each work group computes the matrix C&rsquo;s&nbsp; region from (m,n),&nbsp; to &nbsp;[m+64, n+63],&nbsp; we calls [64x64] **macro-tile** for workgroup. &nbsp;In this example, only 64x64&nbsp; macro tile size is discussed as example.
*   Each work group will load Matrix A, 64 * K , Matrix B K * 64 ,&nbsp; do 64 * K * 64 times of &nbsp;FMA computing
*   Matrix A and Matrix B will be loaded into LDS,
*   Every Thread does Matrix computing matrix A= 8xK, Matrix B=Kx8 for SGEMMEvery thread computes matrix C&rsquo;s 8x8 **micro tile size**.
*   For Each workgroup: Matrix A will be read 8xK times from LDS
*   For Each workgroup: matrix B will be read 8xK times from LDS
*   For Each workgroup: Matrix A will be read 64xKx64 times from VGPR
*   For Each workgroup: Matrix B will be read 64xKx64 times from VGPR
*   For Each workgroup: Matrix C will be read and write&nbsp; 64xKx64 times from VGPR

&nbsp;

Memory read/write occupies very high ratio of total power energy.&nbsp; SGEMM/DGEMM computing includes following memory accesses in modern GPUs:

*   External Video memory Read from GDDR or HBM to L2 Cache
*   From L2 Cache to L1 Cache
*   From L1 Cache to LDS
*   From LDS to VGPR
*   FMA reads VGPRs only for matrix Sum

&nbsp;

In general,&nbsp; LDS/VGPR occupies almost 50% total energy for SGEMM/DGEMM.&nbsp;

&nbsp;

# 2 Very Low Power SGEMM/DGEMM Algorithms for SGEMM

## 2.1 Macro Tile per Workgroup and Micro-Tile per Thread

The VLP SGEMM uses work group size 64 for **macro tile** M=64, N=64.

The workgroup size of 128 uses macro tile size M=64, N = 128.&nbsp;

The workgroup size of 256 uses **macro tile size** M=64,&nbsp; N = 256.&nbsp;

The **micro tile size** for each thread is M=64 and N =1.&nbsp; Each thread computes Matrix A= 64xK, Matrix B = Kx64,&nbsp; result in Matrix-C&nbsp; 64 x1 .&nbsp;

For 64 threads,&nbsp; the Matrix-C&rsquo;s address is **continuous** for each M.

In this paper,&nbsp; the algorithm is based on macro tile size M=64 and N=64 if there is no special notation .

To have best use of&nbsp; Matrix A for SQC constants,&nbsp;

*   hipBlockIdx_x =&nbsp; N/64
*   hipBlockIdx_y = M/64

&nbsp;

## 2.2&nbsp; Matrix A &nbsp;Base Offset Per Wave

Every&nbsp; block has one base address for its Matrix A.&nbsp;

matrix_A_base_offset&nbsp; = hipBlockIdx_y *&nbsp; 64&nbsp; * lda;

&nbsp;

## 2.3 Matrix B Base Offset per Wave

Every&nbsp; block has one base address for its Matrix B.&nbsp;

matrix_B_base_offset&nbsp; = hipBlockIdx_x *&nbsp; 64&nbsp; * ldb;

# 2.4 Matrix A&rsquo;s Offset for Each K

matrix_A_koffset = k * sizeof (float)

The algorithm reads Matrix A&rsquo;s data by&nbsp; Assembly Instruction&nbsp; &ldquo;s_load_dwordx8&rdquo;

s_load_dwordx8 s[32:39], s[12:13], s18

AMD&nbsp; GCN architects has 96 available SGPRs . This algorithm uses SGPR s32 to SGPR s95.&nbsp; It has only 64 SGPRs to read Matrix A&rsquo;s data.&nbsp;

Each group of s_load_dwordx8 instructions reads 64 data from 8x M&nbsp; and 8xK. The algorithm has 8x groups to read 64x different M.&nbsp;

&nbsp;

AMD GCN architect does not support in-order return of s_load_dword.&nbsp; So there is no double buffer loading of Matrix A for this algorithm. &nbsp;

We postpone the performance analysis of limited SGPR number and unhiding latency &nbsp;by out of order SGPR return.

&nbsp;

## 2.5 Double Buffer Prefetch of Matrix B

Each thread uses micro-tile size M=64, N=1.&nbsp; Each thread needs 8x VGPRs to load 1x N&rsquo;s 8xK data.&nbsp;&nbsp;&nbsp; The algorithm uses global_load_dwordx4 to have best cache line hit.&nbsp; The next memory read instruction reads next 4 DWORDs of the same cache line.

global_load_dwordx4 v[68:71], v[2:3], s[20:21]

s_add_u32 s20, s20, 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

s_addc_u32 s21, s21, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

global_load_dwordx4 v[72:75], v[2:3], s[20:21]

s_add_u32 s20, s20, 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

s_addc_u32 s21, s21, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

Double buffer has better latency hiding.&nbsp; It needs 16x VGPRs to support this feature.

## 2.6 VGPRs Allocations

Every thread needs V[2:3] for Matrix B&rsquo;s per thread offset.&nbsp;

Double Buffer Loading of Matrix B needs 16x VGPRs.

&nbsp;64x M needs 64x VGPRs.&nbsp;

In addition to hipThreadIdx_x , totally 16 + 64 + 2 + 1 = 83 VGPRs.

83 VGPRs means 3 waves per SIMD or 3 workgroups per CU.&nbsp; It is good to have good performance.

&nbsp;

## 2.7 NO LDS Operation At All

## 2.8 No Barrier At All

## 2.9 FMA with SGPR source and Data Forwarding to Saving SGPR

Modern GPU usually has one constant loading cache which is independent from Texture/Buffer L1 Cache.&nbsp; SIMD FMA&nbsp; instructions allows to have one operand from Constant data.&nbsp; AMD GCN architecture even promotes the constants into Scalar GPRs.&nbsp; The constant Cache data can be stored into Scalar SGPRs.&nbsp; The FMA instruction of GCN has following syntax to support SGPR:

v_fma_f32 v4, v68, s32, v4

v_fma_f32 v4, v69, s33, v4

v_fma_f32 v4, v70, s34, v4

v_fma_f32 v4, v71, s35, v4

v_fma_f32 v4, v72, s36, v4

v_fma_f32 v4, v73, s37, v4

v_fma_f32 v4, v74, s38, v4

v_fma_f32 v4, v75, s39, v4

&nbsp;

v_fma_f64&nbsp; with SGPRs means 25% less GPR read/write access.&nbsp; In other words, it is possible to save 25% dynamic power of VGPR access.

## 2.10 Matrix C Address

Matrix C address is very similar to Matrix B since every thread has different N value.

## 2.11 Theoretical Comparison of VGPR/L1 Cache/LDS Access

Following table give the example of Macro Tile Size M=64, N =256.&nbsp; It is very clear that this new SGEMM algorithm reduces 70% VGPR reading by SQC constant Loading and Data Forwarding of Accumulator. &nbsp;

<table width="389">
<tbody>
<tr>
<td width="237">

**Costs for Matrix Multiply 64x1x256**

</td>
<td width="76">

**Legeacy**

</td>
<td width="76">

**SQC**

</td>
</tr>
<tr>
<td width="237">

Unit in FP64

</td>
<td width="76">

LDS

</td>
<td width="76">

Non-LDS

</td>
</tr>
<tr>
<td width="237">

Matrix A L2-L1

</td>
<td width="76">

64

</td>
<td width="76">

64

</td>
</tr>
<tr>
<td width="237">

Matrix A VGPR Write

</td>
<td width="76">

576

</td>
<td width="76">

64

</td>
</tr>
<tr>
<td width="237">

Matrix A VGPR Read

</td>
<td width="76">

16384

</td>
<td width="76">

64

</td>
</tr>
<tr>
<td width="237">

Matrix A LDS Write

</td>
<td width="76">

64

</td>
<td width="76">

0

</td>
</tr>
<tr>
<td width="237">

Matrix A LDS Read

</td>
<td width="76">

512

</td>
<td width="76">

0

</td>
</tr>
<tr>
<td width="237">

Matrix B L2-L1

</td>
<td width="76">

256

</td>
<td width="76">

256

</td>
</tr>
<tr>
<td width="237">

Matrix B L1 Read

</td>
<td width="76">

256

</td>
<td width="76">

256

</td>
</tr>
<tr>
<td width="237">

matrix B VGPR write

</td>
<td width="76">

2304

</td>
<td width="76">

256

</td>
</tr>
<tr>
<td width="237">

matrix B VGPR read

</td>
<td width="76">

16384

</td>
<td width="76">

16384

</td>
</tr>
<tr>
<td width="237">

Matrix B LDS write

</td>
<td width="76">

256

</td>
<td width="76">

0

</td>
</tr>
<tr>
<td width="237">

Matrix B LDS read

</td>
<td width="76">

2304

</td>
<td width="76">

0

</td>
</tr>
<tr>
<td width="237">

Matrix C VGPR read/write+

</td>
<td width="76">

32768

</td>
<td width="76">

4096

</td>
</tr>
<tr>
<td width="237">

SUM-L2-L1

</td>
<td width="76">

320

</td>
<td width="76">

320

</td>
</tr>
<tr>
<td width="237">

**SUM-L1-Read**

</td>
<td width="76">

**320**

</td>
<td width="76">

**320**

</td>
</tr>
<tr>
<td width="237">

VGPR Read/Write

</td>
<td width="76">

**68416**

</td>
<td width="76">

**20864**

</td>
</tr>
<tr>
<td width="237">

LDS&nbsp;&nbsp;&nbsp; Read/Write

</td>
<td width="76">

**3136**

</td>
<td width="76">

**0**

</td>
</tr>
<tr>
<td width="237">

Barrier

</td>
<td width="76">

**1**

</td>
<td width="76">

**0**

</td>
</tr>
</tbody>
</table>

&nbsp;

&nbsp;

However, there are several performance limits to prevent this kernel to achieve more than 78% performance on AMD GCN architect.

*   AMD GCN supports only 96 SGPRs for program. This limitation prevents SGEMM kernel to do buffer loading.
*   AMD GCN returns constants out of order. The SGEMM kernel has to use &ldquo;s_waitcnt lgkmcnt(0)&rdquo; to avoid dirty data return . &nbsp;It makes the latency hiding very hard.

# 3 Benchmark&nbsp;

## 3.1 Performance Testing of SGEMM_64x256

&nbsp;

The following result is measured on MI60 with different GPU engine frequencies with fixed memory frequency = 800mhz.

<table width="476">
<tbody>
<tr>
<td width="76">

**K=640**

</td>
<td width="100">

**GFX1700Mhz**

</td>
<td width="100">

**GFX1500Mhz**

</td>
<td width="100">

**GFX1300Mhz**

</td>
<td width="100">

**GFX1100Mhz**

</td>
</tr>
<tr>
<td width="76">

M=N=256

</td>
<td width="100">

0.423

</td>
<td width="100">

0.378

</td>
<td width="100">

0.329

</td>
<td width="100">

0.282

</td>
</tr>
<tr>
<td width="76">

M=N=512

</td>
<td width="100">

1.125

</td>
<td width="100">

1.052

</td>
<td width="100">

1.033

</td>
<td width="100">

0.896

</td>
</tr>
<tr>
<td width="76">

M=N=768

</td>
<td width="100">

2.458

</td>
<td width="100">

2.264

</td>
<td width="100">

2.092

</td>
<td width="100">

1.853

</td>
</tr>
<tr>
<td width="76">

M=N=1024

</td>
<td width="100">

4.368

</td>
<td width="100">

3.903

</td>
<td width="100">

3.622

</td>
<td width="100">

3.331

</td>
</tr>
<tr>
<td width="76">

M=N=1280

</td>
<td width="100">

5.687

</td>
<td width="100">

5.213

</td>
<td width="100">

4.753

</td>
<td width="100">

4.241

</td>
</tr>
<tr>
<td width="76">

M=N=1536

</td>
<td width="100">

7.058

</td>
<td width="100">

6.435

</td>
<td width="100">

5.739

</td>
<td width="100">

4.995

</td>
</tr>
<tr>
<td width="76">

M=N=1792

</td>
<td width="100">

6.493

</td>
<td width="100">

5.972

</td>
<td width="100">

5.463

</td>
<td width="100">

4.807

</td>
</tr>
<tr>
<td width="76">

M=N=2048

</td>
<td width="100">

8.13

</td>
<td width="100">

7.448

</td>
<td width="100">

6.797

</td>
<td width="100">

6.047

</td>
</tr>
<tr>
<td width="76">

M=N=2304

</td>
<td width="100">

8.366

</td>
<td width="100">

7.63

</td>
<td width="100">

6.828

</td>
<td width="100">

5.95

</td>
</tr>
<tr>
<td width="76">

M=N=2560

</td>
<td width="100">

8.561

</td>
<td width="100">

7.856

</td>
<td width="100">

7.11

</td>
<td width="100">

6.226

</td>
</tr>
<tr>
<td width="76">

M=N=2816

</td>
<td width="100">

9.35

</td>
<td width="100">

8.558

</td>
<td width="100">

7.711

</td>
<td width="100">

6.741

</td>
</tr>
<tr>
<td width="76">

M=N=3072

</td>
<td width="100">

9.825

</td>
<td width="100">

8.918

</td>
<td width="100">

8.048

</td>
<td width="100">

7.071

</td>
</tr>
<tr>
<td width="76">

M=N=3328

</td>
<td width="100">

9.758

</td>
<td width="100">

8.896

</td>
<td width="100">

8.026

</td>
<td width="100">

6.998

</td>
</tr>
<tr>
<td width="76">

M=N=3584

</td>
<td width="100">

9.66

</td>
<td width="100">

8.875

</td>
<td width="100">

7.966

</td>
<td width="100">

6.968

</td>
</tr>
<tr>
<td width="76">

M=N=3840

</td>
<td width="100">

9.868

</td>
<td width="100">

9.002

</td>
<td width="100">

8.139

</td>
<td width="100">

7.089

</td>
</tr>
<tr>
<td width="76">

M=N=4096

</td>
<td width="100">

9.954

</td>
<td width="100">

9.145

</td>
<td width="100">

8.226

</td>
<td width="100">

7.185

</td>
</tr>
<tr>
<td width="76">

M=N=4352

</td>
<td width="100">

9.821

</td>
<td width="100">

9.07

</td>
<td width="100">

8.192

</td>
<td width="100">

7.229

</td>
</tr>
<tr>
<td width="76">

M=N=4608

</td>
<td width="100">

9.8

</td>
<td width="100">

9.074

</td>
<td width="100">

8.203

</td>
<td width="100">

7.245

</td>
</tr>
<tr>
<td width="76">

M=N=4864

</td>
<td width="100">

9.856

</td>
<td width="100">

9.088

</td>
<td width="100">

8.252

</td>
<td width="100">

7.258

</td>
</tr>
<tr>
<td width="76">

M=N=5120

</td>
<td width="100">

9.781

</td>
<td width="100">

9.088

</td>
<td width="100">

8.228

</td>
<td width="100">

7.281

</td>
</tr>
<tr>
<td width="76">

M=N=5376

</td>
<td width="100">

9.76

</td>
<td width="100">

9.101

</td>
<td width="100">

8.285

</td>
<td width="100">

7.304

</td>
</tr>
<tr>
<td width="76">

M=N=5632

</td>
<td width="100">

9.8

</td>
<td width="100">

9.122

</td>
<td width="100">

8.285

</td>
<td width="100">

7.346

</td>
</tr>
<tr>
<td width="76">

M=N=5888

</td>
<td width="100">

9.737

</td>
<td width="100">

9.13

</td>
<td width="100">

8.37

</td>
<td width="100">

7.372

</td>
</tr>
<tr>
<td width="76">

M=N=6144

</td>
<td width="100">

9.678

</td>
<td width="100">

9.092

</td>
<td width="100">

8.302

</td>
<td width="100">

7.347

</td>
</tr>
<tr>
<td width="76">

M=N=6400

</td>
<td width="100">

9.672

</td>
<td width="100">

9.121

</td>
<td width="100">

8.328

</td>
<td width="100">

7.383

</td>
</tr>
<tr>
<td width="76">

M=N=6656

</td>
<td width="100">

9.674

</td>
<td width="100">

9.173

</td>
<td width="100">

8.343

</td>
<td width="100">

7.414

</td>
</tr>
<tr>
<td width="76">

M=N=6912

</td>
<td width="100">

9.684

</td>
<td width="100">

9.166

</td>
<td width="100">

8.375

</td>
<td width="100">

7.408

</td>
</tr>
<tr>
<td width="76">

M=N=7168

</td>
<td width="100">

9.638

</td>
<td width="100">

9.18

</td>
<td width="100">

8.359

</td>
<td width="100">

7.413

</td>
</tr>
<tr>
<td width="76">

M=N=7424

</td>
<td width="100">

9.657

</td>
<td width="100">

9.155

</td>
<td width="100">

8.377

</td>
<td width="100">

7.452

</td>
</tr>
<tr>
<td width="76">

M=N=7680

</td>
<td width="100">

9.655

</td>
<td width="100">

9.16

</td>
<td width="100">

8.4

</td>
<td width="100">

7.444

</td>
</tr>
<tr>
<td width="76">

M=N=7936

</td>
<td width="100">

9.67

</td>
<td width="100">

9.168

</td>
<td width="100">

8.398

</td>
<td width="100">

7.466

</td>
</tr>
<tr>
<td width="76">

M=N=8192

</td>
<td width="100">

9.61

</td>
<td width="100">

9.133

</td>
<td width="100">

8.414

</td>
<td width="100">

7.42

</td>
</tr>
<tr>
<td width="76">

M=N=8448

</td>
<td width="100">

9.666

</td>
<td width="100">

9.211

</td>
<td width="100">

8.413

</td>
<td width="100">

7.489

</td>
</tr>
<tr>
<td width="76">

M=N=8704

</td>
<td width="100">

9.662

</td>
<td width="100">

9.236

</td>
<td width="100">

8.417

</td>
<td width="100">

7.465

</td>
</tr>
<tr>
<td width="76">

M=N=8960

</td>
<td width="100">

9.651

</td>
<td width="100">

9.217

</td>
<td width="100">

8.471

</td>
<td width="100">

7.511

</td>
</tr>
<tr>
<td width="76">

M=N=9216

</td>
<td width="100">

9.608

</td>
<td width="100">

9.199

</td>
<td width="100">

8.459

</td>
<td width="100">

7.477

</td>
</tr>
<tr>
<td width="76">

M=N=9472

</td>
<td width="100">

9.643

</td>
<td width="100">

9.234

</td>
<td width="100">

8.454

</td>
<td width="100">

7.509

</td>
</tr>
<tr>
<td width="76">

M=N=9728

</td>
<td width="100">

9.689

</td>
<td width="100">

9.227

</td>
<td width="100">

8.449

</td>
<td width="100">

7.527

</td>
</tr>
<tr>
<td width="76">

M=N=9984

</td>
<td width="100">

9.682

</td>
<td width="100">

9.258

</td>
<td width="100">

8.484

</td>
<td width="100">

7.517

</td>
</tr>
<tr>
<td width="76">

M=N=10240

</td>
<td width="100">

9.605

</td>
<td width="100">

9.258

</td>
<td width="100">

8.453

</td>
<td width="100">

7.498

</td>
</tr>
<tr>
<td width="76">

M=N=10496

</td>
<td width="100">

9.716

</td>
<td width="100">

9.297

</td>
<td width="100">

8.493

</td>
<td width="100">

7.518

</td>
</tr>
<tr>
<td width="76">

M=N=10752

</td>
<td width="100">

9.664

</td>
<td width="100">

9.299

</td>
<td width="100">

8.523

</td>
<td width="100">

7.539

</td>
</tr>
<tr>
<td width="76">

M=N=11008

</td>
<td width="100">

9.672

</td>
<td width="100">

9.299

</td>
<td width="100">

8.521

</td>
<td width="100">

7.537

</td>
</tr>
<tr>
<td width="76">

M=N=11264

</td>
<td width="100">

9.62

</td>
<td width="100">

9.253

</td>
<td width="100">

8.517

</td>
<td width="100">

7.527

</td>
</tr>
<tr>
<td width="76">

M=N=11520

</td>
<td width="100">

9.672

</td>
<td width="100">

9.297

</td>
<td width="100">

8.5

</td>
<td width="100">

7.532

</td>
</tr>
<tr>
<td width="76">

M=N=11776

</td>
<td width="100">

9.652

</td>
<td width="100">

9.275

</td>
<td width="100">

8.497

</td>
<td width="100">

7.548

</td>
</tr>
<tr>
<td width="76">

M=N=12032

</td>
<td width="100">

9.675

</td>
<td width="100">

9.318

</td>
<td width="100">

8.515

</td>
<td width="100">

7.534

</td>
</tr>
<tr>
<td width="76">

M=N=12288

</td>
<td width="100">

9.634

</td>
<td width="100">

9.277

</td>
<td width="100">

8.493

</td>
<td width="100">

7.521

</td>
</tr>
<tr>
<td width="76">

M=N=12544

</td>
<td width="100">

9.681

</td>
<td width="100">

9.339

</td>
<td width="100">

8.531

</td>
<td width="100">

7.556

</td>
</tr>
<tr>
<td width="76">

M=N=12800

</td>
<td width="100">

9.675

</td>
<td width="100">

9.326

</td>
<td width="100">

8.524

</td>
<td width="100">

7.553

</td>
</tr>
<tr>
<td width="76">

M=N=13056

</td>
<td width="100">

9.675

</td>
<td width="100">

9.362

</td>
<td width="100">

8.54

</td>
<td width="100">

7.567

</td>
</tr>
<tr>
<td width="76">

M=N=13312

</td>
<td width="100">

9.666

</td>
<td width="100">

9.344

</td>
<td width="100">

8.57

</td>
<td width="100">

7.581

</td>
</tr>
<tr>
<td width="76">

M=N=13568

</td>
<td width="100">

9.698

</td>
<td width="100">

9.403

</td>
<td width="100">

8.552

</td>
<td width="100">

7.556

</td>
</tr>
<tr>
<td width="76">

M=N=13824

</td>
<td width="100">

9.714

</td>
<td width="100">

9.392

</td>
<td width="100">

8.565

</td>
<td width="100">

7.581

</td>
</tr>
<tr>
<td width="76">

M=N=14080

</td>
<td width="100">

9.703

</td>
<td width="100">

9.429

</td>
<td width="100">

8.57

</td>
<td width="100">

7.591

</td>
</tr>
<tr>
<td width="76">

M=N=14336

</td>
<td width="100">

9.604

</td>
<td width="100">

9.353

</td>
<td width="100">

8.559

</td>
<td width="100">

7.58

</td>
</tr>
<tr>
<td width="76">

M=N=14592

</td>
<td width="100">

9.674

</td>
<td width="100">

9.391

</td>
<td width="100">

8.558

</td>
<td width="100">

7.605

</td>
</tr>
<tr>
<td width="76">

M=N=14848

</td>
<td width="100">

9.657

</td>
<td width="100">

9.312

</td>
<td width="100">

8.545

</td>
<td width="100">

7.587

</td>
</tr>
<tr>
<td width="76">

M=N=15104

</td>
<td width="100">

9.601

</td>
<td width="100">

9.266

</td>
<td width="100">

8.495

</td>
<td width="100">

7.535

</td>
</tr>
<tr>
<td width="76">

M=N=15360

</td>
<td width="100">

9.61

</td>
<td width="100">

9.322

</td>
<td width="100">

8.499

</td>
<td width="100">

7.516

</td>
</tr>
<tr>
<td width="76">

M=N=15616

</td>
<td width="100">

9.661

</td>
<td width="100">

9.351

</td>
<td width="100">

8.541

</td>
<td width="100">

7.554

</td>
</tr>
<tr>
<td width="76">

M=N=15872

</td>
<td width="100">

9.663

</td>
<td width="100">

9.363

</td>
<td width="100">

8.562

</td>
<td width="100">

7.591

</td>
</tr>
<tr>
<td width="76">

M=N=16128

</td>
<td width="100">

9.71

</td>
<td width="100">

9.426

</td>
<td width="100">

8.575

</td>
<td width="100">

7.583

</td>
</tr>
<tr>
<td width="76">

M=N=16384

</td>
<td width="100">

9.532

</td>
<td width="100">

9.228

</td>
<td width="100">

8.508

</td>
<td width="100">

7.532

</td>
</tr>
</tbody>
</table>

&nbsp;

## 3.2 Power Testing

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non-workload&nbsp;&nbsp; == 42 watts,&nbsp; GFX1700Mhz

*   Data Forwarding:

    *   M=N=4096, K=640, Max Power = 265 watts,&nbsp; with 9.5T

*   NO-Forwarding,

    *   M=N=4096, K=640, Max Power = 284 watts,&nbsp; with 9.18T

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non-workload&nbsp;&nbsp; == 36 watts,&nbsp; GFX1500Mhz

*   Data Forwarding:

    *   M=N=4096, K=640, Max Power = 223-watts,&nbsp; with 9.132T

*   NO-Forwarding,

    *   M=N=4096, K=640, Max Power = 240 watts,&nbsp; with 8.986T

&nbsp;

# 4 Run the test

## 4.1 Run the test

Hardware:&nbsp; MI60/MI50

Software: ROCm

Command Line to Build the test:

hipcc sgemm_sqc_test.cpp -o sgemm_sqc_test.exe

Command Lien to run the test:

./ sgemm_sqc_test.exe &lt;M&gt; &lt;N&gt; &lt;K&gt; 64 256 &lt;iterations=10&gt; &lt;verify=0&gt;

For example:

./ sgemm_sqc_test.exe 16384 16384 640 64 256 10 0

## 4.2 Source Code

The GCN LLVM assembly is written in sgemm_64x256_sqc.cpp by inline assembly.&nbsp;

Compiling&nbsp; Command line of&nbsp; sgemm_64x256_sqc.cpp :

hipcc sgemm-64x256-sqc.cpp -o sgemm-64x256-sqc.out

Extract the kernel by following Command line which will generate sgemm-64x256-sqc.out-000-gfx906.isa:

extractkernel -i sgemm_64x256_sqc.out

Extract the correct kernel from sgemm-64x256-sqc.out-000-gfx906.isa and fill into sgemm_64x256_sqc.s.&nbsp;

Compile sgemm_64x256_sqc.s into LLVM&nbsp; code object :

/opt/rocm/hcc/bin/clang -x assembler -target amdgcn--amdhsa -mcpu=gfx906 -mno-code-object-v3 sgemm_64x256_sqc.s -o sgemm_sqc.co

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

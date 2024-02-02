#include<stdio.h>

void init(int* a, const int N)
{
    for (int i = 0; i < N; ++i)
    {
        a[i] = i;
    }
}

__global__
void doubleElements(int* a, const int N)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < N)
        a[idx] *= 2;
}

bool checkElements(int* a, const int N)
{
    for (int i = 0; i < N; ++i)
        if (a[i] != i * 2)
            return false;
    return true;
}

int main()
{
    int N = 1000;
    int* a;

    size_t size = N * sizeof(int);

    cudaMallocManaged(&a, size);

    init(a, N);

    size_t threads_per_block = 256;
    size_t number_of_blocks = (N + threads_per_block - 1) / threads_per_block;

    doubleElements<<<number_of_blocks, threads_per_block>>>(a, N);
    cudaDeviceSynchronize();

    printf("Is doubled? : %s\n", checkElements(a, N) ? "True" : "False");
}
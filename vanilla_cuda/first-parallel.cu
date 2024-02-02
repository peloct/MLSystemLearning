#include<stdio.h>

void cpuFunction()
{
    printf("This is called on CPU.\n");
}

__global__
void firstParallel()
{
    if (threadIdx.x == 1023 && blockIdx.x == 255)
        printf("sucess.\n");
}

__global__
void multidimGrid()
{
    printf("block:(%i,%i,%i), thread:(%i,%i,%i)\n", blockIdx.x, blockIdx.y, blockIdx.z, threadIdx.x, threadIdx.y, threadIdx.z);
}

int main()
{
    cpuFunction();
    firstParallel<<<256, 1024>>>();
    dim3 num_of_block(4, 4, 1);
    dim3 num_of_thread(2, 4, 2);
    multidimGrid<<<num_of_block, num_of_thread>>>();
    cudaDeviceSynchronize();
}
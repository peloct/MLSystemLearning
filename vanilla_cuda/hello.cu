#include<stdio.h>

void helloCPU()
{
    printf("good cpu.");
}

__global__ void helloGPU()
{
    printf("good gpu.");
}

int main()
{
    helloCPU();
    helloGPU<<<2, 1>>>();
    cudaDeviceSynchronize();
}
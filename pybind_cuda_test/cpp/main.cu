#include<pybind11/pybind11.h>

namespace py = pybind11;

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

bool run(int n)
{
    int N = n;
    int* a;

    size_t size = N * sizeof(int);

    cudaMallocManaged(&a, size);

    init(a, N);

    size_t threads_per_block = 256;
    size_t number_of_blocks = (N + threads_per_block - 1) / threads_per_block;

    doubleElements<<<number_of_blocks, threads_per_block>>>(a, N);
    cudaDeviceSynchronize();

    return checkElements(a, N);
}

// PYBIND11_MODULE 에서 앞에 인자의 이름은
// 모듈 이름과 같아야 한다.

PYBIND11_MODULE(cmake_test, m){
    m.doc() = "pybind11 example plugin";
    m.def("run", &run, "A cuda function that double all elem",
        py::arg("n")=1000);
    m.attr("int_var") = 40;
    m.attr("str_var") = py::cast("hello");
}
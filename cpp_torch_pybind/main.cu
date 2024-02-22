#include<iostream>
#include<pybind11/pybind11.h>
#include<torch/extension.h>

namespace py = pybind11;

void test2(torch::Tensor z)
{
    auto s = torch::sigmoid(z);
    std::cout << s << std::endl;
}

// PYBIND11_MODULE 에서 앞에 인자의 이름은
// 모듈 이름과 같아야 한다.

PYBIND11_MODULE(cpp_torch_pybind, m){
    m.doc() = "test open3d pybinding";
    m.def("test2", &test2, "A function that runs test");
}

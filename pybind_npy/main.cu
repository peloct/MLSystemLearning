#include<pybind11/pybind11.h>
#include<pybind11/numpy.h>
#include<iostream>

namespace py = pybind11;

void run(py::array_t<float> array)
{
    auto buf = array.request();
    std::cout << buf.shape[0];
}

// PYBIND11_MODULE 에서 앞에 인자의 이름은
// 모듈 이름과 같아야 한다.

PYBIND11_MODULE(nptest, m){
    m.doc() = "test open3d pybinding";
    m.def("run", &run, "A function that runs run_open3d");
}

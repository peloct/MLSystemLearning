#include<pybind11/pybind11.h>

namespace py = pybind11;

int add(int i, int j){
    return i + j;
}

// PYBIND11_MODULE 에서 앞에 인자의 이름은
// 모듈 이름과 같아야 한다.

PYBIND11_MODULE(cmake_test, m){
    m.doc() = "pybind11 example plugin";
    m.def("add", &add, "A function that adds two numbers");
}
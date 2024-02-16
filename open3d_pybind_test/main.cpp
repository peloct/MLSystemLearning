#include<pybind11/pybind11.h>
#include"open3d/Open3D.h"

namespace py = pybind11;

void run_open3d()
{
    auto sphere = open3d::geometry::TriangleMesh::CreateSphere(1.0);
    sphere->ComputeVertexNormals();
    sphere->PaintUniformColor({0.0, 1.0, 0.0});
    open3d::visualization::DrawGeometries({sphere});
}

// PYBIND11_MODULE 에서 앞에 인자의 이름은
// 모듈 이름과 같아야 한다.

PYBIND11_MODULE(cmake_test, m){
    m.doc() = "test open3d pybinding";
    m.def("run_open3d", &run_open3d, "A function that runs run_open3d");
}

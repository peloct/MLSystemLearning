cmake_minimum_required(VERSION 3.20.0)
project(NPTest LANGUAGES CUDA CXX)

#[[
pybind11 subdirectory 에서 빌드 관련 기능을 제공한다
pybind_test 밑의 CMakeLists.txt 를 기준으로 봤을 때, ../pybind11 은
out-of-tree 이기 때문에, tree 안에 빌드 폴더를 명시적으로 세팅할 필요가 있다.
그래서 뒤에 ./build/pybind11 을 넣어줌.

자세한 내용은 이곳 참조
https://pybind11.readthedocs.io/en/latest/compiling.html#building-with-cmake
]]

find_package(NumCpp 2.12.1 REQUIRED)

add_subdirectory(../pybind11 ./build/pybind11)
pybind11_add_module(nptest "./main.cu")

target_link_libraries(nptest PRIVATE
    NumCpp::NumCpp
)
cmake_minimum_required(VERSION 3.20.0)

#[[
프로젝트의 이름을 세팅하고, 프로젝트에서 사용하는 언어들을 세팅.
해당 언어들에 대한 compiler 를 알아서 찾는다.
]]

project(CUDAProject CUDA CXX)

set(PROJECT_SRC double-elem.cu)

add_executable(cuda_exe ${PROJECT_SRC})
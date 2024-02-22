# https://pytorch.org/tutorials/advanced/cpp_extension.html

from setuptools import setup
from torch.utils.cpp_extension import BuildExtension, CUDAExtension

setup(
    name='cpp_torch_pybind',
    ext_modules=[
        CUDAExtension(
                name='cpp_torch_pybind',
                sources=['main.cu'],
                extra_compile_args={'cxx': ['-g'],
                                    'nvcc': ['-O2']})
    ],
    cmdclass={
        'build_ext': BuildExtension
    })

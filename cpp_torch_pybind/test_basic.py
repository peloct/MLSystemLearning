import torch
import cpp_torch_pybind as m


if __name__ == "__main__":
    m.test2(torch.tensor([1, 2, 3]))
    
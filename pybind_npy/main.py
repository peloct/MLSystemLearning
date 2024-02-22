import nptest as m
import torch
import numpy as np


if __name__ == '__main__':
    m.run(np.random.random(size=(3,)).astype(np.float32))
    a = torch.tensor([1, 2, 3])
    np.arange(4)

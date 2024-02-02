import torch


class MyFunction(torch.autograd.Function):
    """
    a, b = f(c, d, e)

    a = c^2 + d^2
    b = d^2 + e^2

    da_dc = 2c
    da_dd = 2d
    db_dd = 2d
    db_de = 2e
    """

    @staticmethod
    def forward(ctx, c, d, e):
        ctx.save_for_backward(c, d, e)
        return (c * c + d * d, d * d + e * e)
    
    @staticmethod
    def backward(ctx, dl_da, dl_db):
        """
        입력은 각각 dl_da, dl_db
        즉 loss 에 대해, MyFunction 의 출력이 갖는 편미분

        본 함수의 출력은
        dl_dc, dl_dd, dl_de 여야 한다.

        계산식은 따라서

        dl_dc = dl_da * da_dc + dl_db * db_dc
        dl_dd = dl_da * da_dd + dl_db * db_dd
        dl_de = dl_da * da_de + dl_db * db_de
        """

        c, d, e = ctx.saved_tensors

        dl_dc = dl_da * 2 * c
        dl_dd = dl_da * 2 * d + dl_db * 2 * d
        dl_de = dl_db * 2 * e

        return dl_dc, dl_dd, dl_de


def main():
    input1 = torch.tensor([1.0, 2.0, 3.0], requires_grad=True)
    input2 = torch.tensor([4.0, 5.0, 6.0], requires_grad=True)
    input3 = torch.tensor([7.0, 8.0, 9.0], requires_grad=True)

    output1, output2 = MyFunction.apply(input1, input2, input3)
    z = output1.sum() + output2.sum()
    z.backward()

    print(input1.grad)
    print(input2.grad)
    print(input3.grad)


if __name__ == "__main__":
    main()
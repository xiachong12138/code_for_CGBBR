import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import fft, ifft


def hilbert_transform(signal):
    # 计算信号的FFT
    spectrum = fft(signal)

    # 构建希尔伯特滤波器
    N = len(signal)
    h = np.zeros(N)
    if N % 2 == 0:
        h[0] = h[N // 2] = 1
        h[1:N // 2] = 2
    else:
        h[0] = 1
        h[1:(N + 1) // 2] = 2

    # 将希尔伯特滤波器应用于频域信号
    spectrum_h = h * spectrum

    # 计算希尔伯特变换的实部和虚部
    hilbert = ifft(spectrum_h)
    return hilbert.real, hilbert.imag


# 生成一个测试信号
t = np.linspace(0, 1, 1000, endpoint=False)
signal = np.sin(2 * np.pi * 5 * t) + np.sin(2 * np.pi * 10 * t) + np.sin(2 * np.pi * 20 * t)

# 计算希尔伯特变换
hilbert = hilbert_transform(signal)

# 绘制原始信号和希尔伯特变换
plt.plot(t, signal, label='signal')
plt.plot(t, hilbert[1], label='hilbert')
plt.legend()
plt.show()

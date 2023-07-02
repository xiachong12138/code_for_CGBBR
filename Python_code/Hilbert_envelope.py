import numpy as np
from scipy.signal import hilbert
import matplotlib.pyplot as plt

# 生成一个测试信号
t = np.linspace(0, 1, 1000, endpoint=False)
signal = np.sin(2 * np.pi * 5 * t) + np.sin(2 * np.pi * 10 * t) + np.sin(2 * np.pi * 20 * t)

# 计算希尔伯特变换
analytic_signal = hilbert(signal)

# 计算幅度包络
amplitude_envelope = np.abs(analytic_signal)

# 绘制原始信号和包络
plt.plot(t, signal, label='signal')
plt.plot(t, amplitude_envelope, label='envelope')
plt.legend()
plt.show()

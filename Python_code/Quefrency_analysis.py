import numpy as np
import matplotlib.pyplot as plt

# 生成一个测试信号
t = np.linspace(0, 1, 1000, endpoint=False)
signal = np.sin(2 * np.pi * 5 * t) + np.sin(2 * np.pi * 10 * t) + np.sin(2 * np.pi * 20 * t)

# 绘制测试信号
plt.plot(t, signal)
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.show()

# 计算信号的自相关函数
autocorr = np.correlate(signal, signal, mode='full')

# 计算倒谱
cepstrum = np.real(np.fft.ifft(np.log(np.abs(np.fft.fft(autocorr)))))

# 绘制倒谱
plt.plot(cepstrum[:len(cepstrum)//2])
plt.xlabel('Quefrency (samples)')
plt.ylabel('Real part of Cepstrum')
plt.show()

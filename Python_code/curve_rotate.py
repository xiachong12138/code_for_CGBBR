import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt

# 定义球的半径和扫描路径
r = 1.0  # 半径
theta = np.linspace(0, 2 * np.pi, 100)  # 扫描路径在xy平面上的角度
phi = np.linspace(0, np.pi, 50)  # 扫描路径在xz平面上的角度

# 初始化坐标数组
x = np.zeros((len(theta), len(phi)))
y = np.zeros((len(theta), len(phi)))
z = np.zeros((len(theta), len(phi)))

# 通过球面参数方程计算坐标
for i in range(len(theta)):
    for j in range(len(phi)):
        x[i, j] = r * np.sin(phi[j]) * np.cos(theta[i])
        y[i, j] = r * np.sin(phi[j]) * np.sin(theta[i])
        z[i, j] = r * np.cos(phi[j])

# 绘制球面
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(x, y, z)
plt.show()

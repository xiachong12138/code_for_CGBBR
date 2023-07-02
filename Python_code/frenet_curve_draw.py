import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 生成参数 t
t = np.linspace(0, 2 * np.pi, 100)

# 计算 x, y, z
x = np.cos(t)
y = np.sin(t)
z = np.cos(2 * t)

# 绘制曲线
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot(x, y, z, color='k')

# 添加 Frenet 标架
for i in range(len(x) - 1):
    # 计算切向量 T
    T = np.array([x[i + 1] - x[i], y[i + 1] - y[i], z[i + 1] - z[i]])
    T = T / np.linalg.norm(T)

    # 计算法向量 N
    N = np.array([y[i + 1] + y[i], -x[i + 1] - x[i], 2 * (z[i + 1] - z[i])])
    N = N / np.linalg.norm(N)

    # 计算次法向量 B
    B = np.cross(T, N)

    # 绘制 T, N, B 向量
    ax.quiver(x[i], y[i], z[i], T[0], T[1], T[2], color='r', length=0.5, normalize=True)
    ax.text(x[i] + T[0], y[i] + T[1], z[i] + T[2], f'T = [{T[0]:.2f}, {T[1]:.2f}, {T[2]:.2f}]')
    ax.quiver(x[i], y[i], z[i], N[0], N[1], N[2], color='g', length=0.5, normalize=True)
    ax.text(x[i] + N[0], y[i] + N[1], z[i] + N[2], f'N = [{N[0]:.2f}, {N[1]:.2f}, {N[2]:.2f}]')
    ax.quiver(x[i], y[i], z[i], B[0], B[1], B[2], color='b', length=0.5, normalize=True)
    ax.text(x[i] + B[0], y[i] + B[1], z[i] + B[2], f'B = [{B[0]:.2f}, {B[1]:.2f}, {B[2]:.2f}]')

    # 暂停一段时间再清除画布
    plt.pause(0.1)
    ax.cla()
    ax.plot(x, y, z, color='k')

# 调整视角
ax.view_init(elev=30, azim=70)

plt.show()

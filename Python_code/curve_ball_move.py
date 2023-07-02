import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 定义常数和参数
params = {
    'R': 2,      # 球面的半径
    'w': 1,      # 曲线的参数
    'A': 1,      # 曲线高度的缩放系数
    'r': 0.4,    # 球半径
    'step_size': 0.1,  # 每步移动的距离
}

# 创建 t 的值域，步长为 0.01
t = np.arange(0, 2*np.pi + 0.01, 0.01)

# 计算 x, y, z 值
x = params['R']*np.cos(params['w']*t)
y = params['R']*np.sin(params['w']*t)
z = params['A']*np.cos(2*t)

# 创建直径为 0.1 的球
x_sphere, y_sphere, z_sphere = np.meshgrid(np.linspace(-1, 1, 10), np.linspace(-1, 1, 10), np.linspace(-1, 1, 10))
x_sphere *= params['r']
y_sphere *= params['r']
z_sphere *= params['r']

# 遍历函数并记录可以放置球的点的位置
ball_centers = []
for i in range(len(x)):
    if i == 0:
        P = np.array([x[0], y[0], z[0]])
    else:
        d = np.linalg.norm(np.array([x[i], y[i], z[i]]) - P)
        if d >= 2*params['r']:  # 放置球的间隔为 2r
            P = np.array([x[i], y[i], z[i]])
            ball_centers.append(P)

# 绘制 3D 曲面图
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot(x, y, z)

# 设置
#在可以放置球的点上放置球
ball_centers = np.array(ball_centers)
x_sphere = np.tile(x_sphere, (len(ball_centers), 1, 1))
y_sphere = np.tile(y_sphere, (len(ball_centers), 1, 1))
z_sphere = np.tile(z_sphere, (len(ball_centers), 1, 1))
ax.plot_surface(x_sphere + ball_centers[:, 0][:, None, None], y_sphere + ball_centers[:, 1][:, None, None], z_sphere + ball_centers[:, 2][:, None, None], edgecolor='none')

#设置绘图区域
ax.set_box_aspect([1.5params['R'], 1.5params['R'], 1.5params['A']])
ax.set_xlim(-1.5params['R'], 1.5params['R'])
ax.set_ylim(-1.5params['R'], 1.5params['R'])
ax.set_zlim(-1.5params['A'], 1.5*params['A'])

#移动小球并更新绘图
for k in range(2000): # 一共移动1000步
for i in range(len(ball_centers)):
# 计算小球在曲线上的位置，偏移一定距离
t_idx = np.argwhere((x == ball_positions[i][0]) & (y == ball_positions[i][1]) & (z == ball_positions[i][2]))[0][0]
new_t_idx = np.roll(t_idx, 10) % len(x)
ball_centers[i] = np.array([x[new_t_idx], y[new_t_idx], z[new_t_idx]])

# 更新小球的位置并更新绘图
ax.collections.clear()
ball_centers = ball_centers.reshape(-1, 1, 3)
ax.plot_surface(x_sphere + ball_centers[:, :, 0], y_sphere + ball_centers[:, :, 1], z_sphere + ball_centers[:, :, 2], edgecolor='none')
ball_positions = ball_centers.copy()

# 等待一段时间
plt.pause(0.01)

plt.show()
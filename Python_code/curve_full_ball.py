import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 创建 t 的值域，步长为 0.01
t = np.arange(0, 2*np.pi+0.01, 0.01)

# 计算 x, y, z 值
x = np.cos(t)
y = np.sin(t)
z = np.cos(2*t)

# 创建直径为 0.1 的球
r = 0.05  # 球半径
u, v = np.mgrid[0:2*np.pi:10j, 0:np.pi:10j]
x_sphere = r*np.cos(u)*np.sin(v)
y_sphere = r*np.sin(u)*np.sin(v)
z_sphere = r*np.cos(v)

# 找到四个极值点的位置
extrema_indices = [np.argmin(z), np.argmax(z), np.argmin(np.abs(z - 1)), np.argmin(np.abs(z + 1))]

# 遍历所有球并找到最近的极值点
num_balls = 0
ball_centers = []
ball_colors = []
for i in range(len(x)):
    if i == 0:
        P = np.array([x[0], y[0], z[0]])
    else:
        d = np.linalg.norm(np.array([x[i], y[i], z[i]]) - P)
        if d >= 0.2 - r:
            P = np.array([x[i], y[i], z[i]])
            num_balls += 1
            ball_centers.append(P)
            # 找到极值点左右两侧的点并设置球的颜色
            left_extremum = np.argmax(z[0:i])
            right_extremum = i + np.argmin(z[i:len(x)])
            if i < extrema_indices[0] or i > extrema_indices[-1]:
                color = 'b'
            elif left_extremum in extrema_indices or right_extremum in extrema_indices:
                color = 'r'
            else:
                color = 'g'
            ball_colors.append(color)

# 在可以放置球的点上放置球
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
for P, color in zip(ball_centers, ball_colors):
    ax.plot_surface(x_sphere + P[0], y_sphere + P[1], z_sphere + P[2], color=color, alpha=0.5)

# 绘制 3D 曲面图
ax.plot(x, y, z)

# 设置坐标轴标签和标题
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.set_title('Function Plot')

# 输出可以放置的小球数量
print("可以放置的小球数量为：", num_balls)

# 设置绘图区域
max_range = np.array([x.max()-x.min(), y.max()-y.min(), z.max()-z.min()]).max() / 2.0
mid_x = (x.max()+x.min()) * 0.5
mid_y = (y.max()+y.min()) * 0.5
ax.set_xlim(mid_x - max_range, mid_x + max_range)
ax.set_ylim(mid_y - max_range, mid_y + max_range)
ax.set_zlim(z.min()-0.1, z.max()+0.1)
plt.show()

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 定义曲线的参数方程
def curve(t):
    x = np.cos(t)
    y = np.sin(t)
    z = np.cos(2*t)
    return x, y, z

# 定义球的参数方程
def sphere(t, phi, r):
    x = r * np.sin(phi) * np.cos(t)
    y = r * np.sin(phi) * np.sin(t)
    z = r * np.cos(phi)
    return x, y, z

# 生成曲线上的点和切向量
t = np.linspace(0, 2*np.pi, 100)
x, y, z = curve(t)
diff_x = np.diff(x) / np.diff(t)
diff_y = np.diff(y) / np.diff(t)
diff_z = np.diff(z) / np.diff(t)
t = t[:-1]

# 生成扫描面的顶点和三角形索引
vertices = []
triangles = []
for i in range(len(t)):
    # 计算球心的位置和法向量
    center = np.array([x[i], y[i], z[i]])
    normal = np.array([diff_x[i], diff_y[i], diff_z[i]])
    normal /= np.linalg.norm(normal)
    # 生成球的顶点和法向量
    phi = np.linspace(0, np.pi, 10)
    t_sphere = np.linspace(0, 2*np.pi, 20)
    t_sphere, phi = np.meshgrid(t_sphere, phi)
    x_sphere, y_sphere, z_sphere = sphere(t_sphere, phi, 0.2)
    sphere_points = np.vstack([x_sphere.ravel(), y_sphere.ravel(), z_sphere.ravel()]).T
    sphere_normals = sphere_points - center
    sphere_normals /= np.linalg.norm(sphere_normals, axis=1)[:, np.newaxis]
    # 将顶点加入顶点列表
    vertices += (sphere_points + center).tolist()
    # 生成三角形索引
    if i > 0:
        curr_idx = 200*i
        prev_idx = 200*(i-1)
        for j in range(200):
            a = prev_idx + j
            b = prev_idx + (j+1) % 200
            c = curr_idx + j
            d = curr_idx + (j+1) % 200
            triangles += [[a, b, c], [b, d, c]]

# 将顶点列表和三角形索引转化为numpy数组
vertices = np.array(vertices)
triangles = np.array(triangles)

# 可视化扫描面
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_trisurf(vertices[:,0], vertices[:,1], vertices[:,2], triangles=triangles)
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
plt.show()

# 计算的很慢

from sympy import symbols, cos, sin, sqrt, integrate
import matplotlib.pyplot as plt
import numpy as np

# 设置matplotlib字体
plt.rcParams['font.family'] = ['SimHei']

# 提示用户输入常数R和A，如果用户没有输入值，则使用默认值
R = float(input("请输入常数R（默认值为1）：") or 1)
A = float(input("请输入常数A（默认值为1）：") or 1)

# 定义符号变量
t = symbols('t')

# 定义空间曲线r(t)
r = [R*cos(t), R*sin(t), A*cos(2*t)]

# 计算r'(t)
r_diff = [x.diff(t) for x in r]

# 计算| r'(t) |
r_diff_norm = sqrt(sum(x**2 for x in r_diff))

# 计算曲线长度
L = integrate(r_diff_norm, (t, 0, 2 * np.pi))

# 在图形窗口中显示曲线长度
fig, ax = plt.subplots()
ax.text(0.1, 0.5, '空间曲线的长度为：{}'.format(float(L)), fontsize=14)
ax.axis('off')
ax.set_title('曲线长度')

plt.show()

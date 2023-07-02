from sympy import *
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

# 设置matplotlib字体
plt.rcParams['font.family'] = ['SimHei']

# 定义符号变量
R, A, t = symbols('R A t')

# 定义空间曲线r(t)
r = Matrix([R*cos(t), R*sin(t), A*cos(2*t)])

# 计算一阶导数r'(t)
r_diff = r.diff(t)

# 计算二阶导数r''(t)
r_diff2 = r_diff.diff(t)

# 计算曲率公式
kappa = simplify((r_diff.cross(r_diff2)).norm() / r_diff.norm()**3)

# 计算t=0时的曲率
kappa_t0 = kappa.subs(t, 0)

# 输出曲率公式
print('曲率公式为：')
print(latex(kappa))

# 输出t=0时的曲率
print('曲率在t=0时的值为：')
print(latex(kappa_t0))

# 使用matplotlib创建一个新窗口
fig, ax = plt.subplots()

# 显示曲率公式
ax.text(0.5, 0.5, r'${}$'.format(latex(kappa)), fontsize=14, ha='center', va='center')

# 显示t=0时的曲率
ax.text(0.5, 0.4, r'${}$'.format(latex(kappa_t0)), fontsize=14, ha='center', va='center')

# 设置图形属性
ax.axis('off')
ax.set_title('曲率公式')

plt.show()

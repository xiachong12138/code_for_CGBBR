from sympy import *
from sympy.vector import CoordSys3D

# 定义坐标系和变量
N = CoordSys3D('N')
t = symbols('t')
u, v = symbols('u v')

# 输入曲线的参数方程
r = N.i * cos(t) + N.j * sin(t) + N.k * t

# 计算曲线的切向量，法向量和曲率矢量
T = simplify(diff(r, t))
T_norm = simplify(T / T.magnitude())
N = simplify(diff(T_norm, t))
kappa_vec = simplify(N / N.magnitude())

# 计算曲线的曲率和 Frenet 公式相关信息
kappa = simplify(N.magnitude())
tau_vec = simplify(diff(T_norm, t) / diff(r, t).magnitude())
tau = simplify(tau_vec.magnitude())
B = simplify(T_norm.cross(N))

# 打印结果
print("切向量 T = ", T)
print("单位切向量 T_norm = ", T_norm)
print("法向量 N = ", N)
print("曲率矢量 kappa_vec = ", kappa_vec)
print("曲率 kappa = ", kappa)
print("挠率矢量 tau_vec = ", tau_vec)
print("挠率 tau = ", tau)
print("副法向量 B = ", B)

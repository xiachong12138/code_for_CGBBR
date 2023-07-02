import numpy as np
import matplotlib.pyplot as plt

# 设置参数
t = np.linspace(0, 2 * np.pi, 1000)
x = t
y = np.sin(t)
r = 0.1

# 绘制sinx曲线
plt.plot(x, y, linewidth=2)
plt.grid(True)
plt.axis('equal')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Sine Curve')

plt.gca().set_prop_cycle(None)

# 绘制动圆
theta = np.linspace(0, 2 * np.pi, 100)
xcirc = r * np.cos(theta) + x[0]
ycirc = r * np.sin(theta) + y[0]
h1, = plt.plot(xcirc, ycirc, 'r', linewidth=1)

# 移动动圆
for i in range(1, len(t)):
    # 计算动圆圆心的坐标
    xc = x[i]
    yc = y[i]

    # 更新动圆的坐标
    xcirc = r * np.cos(theta) + xc
    ycirc = r * np.sin(theta) + yc

    # 清除上一个动圆
    h1.remove()

    # 绘制当前动圆
    h1, = plt.plot(xcirc, ycirc, 'r', linewidth=1)

    plt.draw()

plt.show()

% 定义变量范围和参数
t = linspace(0, 2*pi, 100);
b = linspace(0, 2*pi, 100);
R = 1;
A = 1;
w = 2;

% 构造网格
[T, B] = meshgrid(t, b);

% 计算坐标值
X = R * cos(T);
Y = R * sin(T);
Z = 2 * A * cos(w * (T - B)) + A * sin(w * B);


% 绘制图形
surf(X, Y, Z);
colormap('parula');
shading interp;
xlabel('x');
ylabel('y');
zlabel('z');
title('曲线族');

syms t A R
r = [R*cos(t), R*sin(t), A*cos(2*t)]; % 定义曲线r(t)

drdt = diff(r, t); % 计算曲线r(t)的导数
d2rdt2 = diff(r, t, 2); % 计算曲线r(t)的二阶导数

kappa = norm(cross(d2rdt2, drdt)) / norm(drdt)^3; % 计算曲线r(t)的曲率

kappa = simplify(kappa); % 简化曲率公式

% 绘制曲率关于A和R的图像
A_vec = linspace(0, 30, 500); % 定义A的取值范围
R_vec = linspace(0, 30, 500); % 定义R的取值范围
[A_mesh, R_mesh] = meshgrid(A_vec, R_vec);
kappa_func = matlabFunction(kappa); % 将符号函数转化为MATLAB函数
kappa_surf = kappa_func(A_mesh,R_mesh,0); % 计算曲率的值
surf(A_mesh, R_mesh, kappa_surf); % 绘制曲率图像
shading interp;
xlabel('A');
ylabel('R');
zlabel('曲率');
title('曲率关于A和R的图像');

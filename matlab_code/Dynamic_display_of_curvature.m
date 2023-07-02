clc,clear;
syms R A t
x = R*cos(t);
y = R*sin(t);
z = A*sqrt(4-cos(2*t)^2) + A*sin(2*t+asin(cos(2*t)/2));
r = [x; y; z];  % 定义曲线r(t)

drdt = diff(r, t); % 计算曲线r(t)的导数
d2rdt2 = diff(r, t, 2); % 计算曲线r(t)的二阶导数

kappa = norm(cross(d2rdt2, drdt)) / norm(drdt)^3; % 计算曲线r(t)的曲率
Rc = simplify(1/kappa); % 计算曲线r(t)的曲率半径

kappa_func = matlabFunction(kappa); % 将符号函数转化为MATLAB函数
Rc_func = matlabFunction(Rc); % 将符号函数转化为MATLAB函数

% 绘制曲率和曲率半径关于A和R的图像
figure;
[A_mesh, R_mesh] = meshgrid(linspace(0, 30, 50), linspace(0, 30, 50)); % 定义A和R的取值范围
kappa_surf = kappa_func(A_mesh, R_mesh, 0); % 计算曲率的值
Rc_surf = Rc_func(A_mesh,R_mesh ,0); % 计算曲率半径的值
h1 = surf(A_mesh, R_mesh, kappa_surf); % 绘制曲率关于A和R的图像
hold on;
h2 = surf(A_mesh, R_mesh, Rc_surf); % 绘制曲率半径关于A和R的图像
xlabel('A');
ylabel('R');
zlabel('曲率/曲率半径');
title('曲率和曲率半径关于A和R的图像');

% 循环绘制动画
t_range = 0:0.01:pi/2;
for t = t_range
    z = A*sqrt(4-cos(2*t)^2) + A*sin(2*t+asin(cos(2*t)/2));
    r = [x; y; z];
    kappa_surf = kappa_func(A_mesh, R_mesh, t);
    Rc_surf = Rc_func(A_mesh, R_mesh, t);
    set(h1, 'ZData', kappa_surf);
    set(h2, 'ZData', Rc_surf);
    drawnow;
end
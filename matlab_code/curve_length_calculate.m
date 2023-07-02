clc,clear;
syms R A t real
% 提示用户输入常数R和A
R = input('请输入常数R：');

A = input('请输入常数A：');

% 定义空间曲线r(t)
r = [R*cos(t), R*sin(t), A*cos(2*t)];
% 计算r'(t)
r_diff = diff(r, t);
% 计算| r'(t) |
r_diff_norm = simplify(norm(r_diff));
% 计算曲线长度
L = int(r_diff_norm, t, 0, 2*pi);

% 在图形窗口中显示曲线长度
figure('Name', '曲线长度');
text(0.1, 0.5, ['空间曲线的长度为：', num2str(double(L))], 'FontSize', 14);


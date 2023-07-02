
%% 我写的代码
% syms  t A R
% r = [R*cos(t); R*sin(t); A*cos(2*t)];  % 输入曲线的参数方程
% 
% % 计算参数曲线的一阶导数和二阶导数
% r_prime = simplify(diff(r,t));
% r_double_prime = simplify(diff(r_prime,t));
% 
% % 计算一阶导数和二阶导数的叉积的模
% r_prime_norm = norm(r_prime);
% r_prime_cross_double_prime = cross(r_prime,r_double_prime);
% norm_cross = simplify(norm(cross(r_prime,r_double_prime)));
% r_prime_norm_triple = simplify(r_prime_norm^3);
% 
% 
% % 计算曲率以及frenet标架的信息
% alpha = simplify(r_prime/r_prime_norm);
% gamma = simplify(r_prime_cross_double_prime/norm_cross);
% beta = simplify(cross(alpha,gamma));
% varkappa = simplify(norm_cross/r_prime_norm_triple);
% 
% varkappa_t0 = subs(varkappa,t,0)
% 
% 
% % 将计算结果转换为 LaTeX 公式字符串
% alpha_latex = latex(alpha);
% gamma_latex = latex(gamma);
% beta_latex = latex(beta);
% varkappa_latex = latex(varkappa);
% 
% % 显示 LaTeX 公式
% figure;
% text(0.1, 1.0, ['$\alpha = ', alpha_latex, '$'], 'Interpreter', 'latex');
% text(0.1, 0.8, ['$\beta = ', beta_latex, '$'], 'Interpreter', 'latex');
% text(0.1, 0.6, ['$\gamma = ', gamma_latex, '$'], 'Interpreter', 'latex');
% text(0.1, 0.4, ['$\kappa = ', varkappa_latex, '$'], 'Interpreter', 'latex');
% 
% axis off;
%% ChatGPT写的代码

clc,clear;
syms R A t
% 定义空间曲线r(t)
r = [R*cos(t), R*sin(t), A*cos(2*t)];
% 计算一阶导数r'(t)
r_diff = diff(r);
% 计算二阶导数r''(t)
r_diff2 = diff(r_diff);
% 计算曲率公式
kappa = simplify(norm(cross(r_diff, r_diff2)) / norm(r_diff)^3);
% 在这里改变t的值
kappa_t0 = subs(kappa, t, 1);

% 输出曲率公式
latex_kappa = latex(kappa);
figure('Name', '曲率公式');
text(0.1, 0.5, ['$$\kappa(t) = ', latex_kappa, '$$'], 'Interpreter', 'latex');

% 显示t=0时的曲率
text(0.1, 0.2, ['$$\kappa(0) = ', latex(kappa_t0), '$$'], 'Interpreter', 'latex');
axis off

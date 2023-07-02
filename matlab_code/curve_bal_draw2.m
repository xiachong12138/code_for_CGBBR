clear,clc
% 定义可变常数
R = 2.5;    % 球面的半径
w = 1;    % 曲线的参数
A = 1;    % 曲线高度的缩放系数
r = 0.35;  % 球半径

% 创建 t 的值域，步长为 0.01
t = 0:0.01:2*pi;

% 计算 x, y, z 值
x = R*cos(w*t);
y = R*sin(w*t);
z = A*cos(2*t);

% 创建直径为 r 的球
[x_sphere, y_sphere, z_sphere] = sphere(100);
x_sphere = x_sphere * r;
y_sphere = y_sphere * r;
z_sphere = z_sphere * r;

% 遍历函数并记录可以放置球的点的位置
num_balls = 0;
ball_centers = [];
first_ball_center = [];
last_ball_center = [];
for i = 1:length(x)
    if i == 1
        P = [x(1) y(1) z(1)];
        first_ball_center = P;
    else
        d = sqrt(sum(([x(i) y(i) z(i)] - P).^2, 2));
        if d >= 2*r  % 放置球的间隔为2r
            P = [x(i) y(i) z(i)];
            num_balls = num_balls + 1;
            ball_centers(num_balls, :) = P;
            if num_balls == 1
                first_ball_center = P;
            end
            last_ball_center = P;
        end
    end
end

% 绘制 3D 曲面图和放置球的直线
figure;
plot3(x, y, z);
grid on;
% 设置坐标轴标签和标题
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Function Plot');

% 在可以放置球的点上放置球
hold on;
for i = 1:size(ball_centers, 1)
    surf(x_sphere + ball_centers(i, 1), y_sphere + ball_centers(i, 2), z_sphere + ball_centers(i, 3), 'EdgeColor', 'none');
end

% 绘制相邻球心的直线
for i = 1:size(ball_centers, 1)-1
    plot3(ball_centers(i:i+1,1), ball_centers(i:i+1,2), ball_centers(i:i+1,3), 'r','LineWidth',2);
end

% 计算中心距离和平均距离
center_distance = norm(first_ball_center - last_ball_center);
average_distance = center_distance / num_balls;

% 输出中心距离和平均距离和球的数量
disp(['Center distance: ' num2str(center_distance)]);
disp(['Average distance: ' num2str(average_distance)]);
disp(['num_balls:' num2str(num_balls)])

% 设置绘图区域
axis equal;  % x, y, z 坐标轴比例相等
xlim([-1.2*R 1.2*R]); ylim([-1.2*R 1.2*R]); zlim([-1.2*A 1.2*A]); % 设置坐标轴范围

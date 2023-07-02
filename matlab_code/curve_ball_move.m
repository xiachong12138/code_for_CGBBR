% 定义可变常数
R = 2;    % 球面的半径
w = 1;    % 曲线的参数
A = 1;    % 曲线高度的缩放系数
r = 0.4;  % 球半径
step_size = 0.1; % 每步移动的距离

% 创建 t 的值域，步长为 0.01
t = 0:0.01:2*pi;

% 计算 x, y, z 值
x = R*cos(w*t);
y = R*sin(w*t);
z = A*cos(2*t);

% 创建直径为 0.1 的球
[x_sphere, y_sphere, z_sphere] = sphere(20);
x_sphere = x_sphere * r;
y_sphere = y_sphere * r;
z_sphere = z_sphere * r;

% 遍历函数并记录可以放置球的点的位置
num_balls = 0;
ball_centers = [];
ball_positions = []; % 用于存储每个小球的初始位置
for i = 1:length(x)
    if i == 1
        P = [x(1) y(1) z(1)];
    else
        d = sqrt(sum(([x(i) y(i) z(i)] - P).^2, 2));
        if d >= 2*r  % 放置球的间隔为2r
            P = [x(i) y(i) z(i)];
            num_balls = num_balls + 1;
            ball_centers(num_balls, :) = P;
            ball_positions(num_balls, :) = P;
        end
    end
end

% 绘制 3D 曲面图
figure;
plot3(x, y, z);

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

% 设置绘图区域
axis equal;  % x, y, z 坐标轴比例相等
xlim([-1.5*R 1.5*R]); ylim([-1.5*R 1.5*R]); zlim([-1.5*A 1.5*A]); % 设置坐标轴范围

% 移动小球并更新绘图
for k = 1:2000 % 一共移动1000步
    for i = 1:size(ball_centers, 1)
        % 计算小球在曲线上的位置，偏移一定距离
        t_idx = find((x == ball_positions(i,1)) & (y == ball_positions(i,2)) & (z == ball_positions(i,3)), 1);
        new_t_idx = mod(t_idx + 10, length(x));
        ball_centers(i, :) = [x(new_t_idx) y(new_t_idx) z(new_t_idx)];
    end
    % 更新小球的位置并更新绘图
    for i = 1:size(ball_centers, 1)
        % 删除旧的小球
        delete(findobj('Type', 'surface', 'XData', x_sphere + ball_positions(i,1), 'YData', y_sphere + ball_positions(i,2), 'ZData', z_sphere + ball_positions(i,3)));
        % 在新的位置上放置新的小球
        surf(x_sphere + ball_centers(i, 1), y_sphere + ball_centers(i, 2), z_sphere + ball_centers(i, 3), 'EdgeColor', 'none');
        % 更新小球的位置
        ball_positions(i, :) = ball_centers(i, :);
    end
    pause(0.01); % 等待一段时间
end


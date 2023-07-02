% 创建 t 的值域，步长为 0.01
t = 0:0.01:2*pi;

% 计算 x, y, z 值
x = cos(t);
y = sin(t);
z = cos(2*t);

% 创建直径为 0.1 的球
r = 0.05;  % 球半径
[x_sphere, y_sphere, z_sphere] = sphere(10);
x_sphere = x_sphere * r;
y_sphere = y_sphere * r;
z_sphere = z_sphere * r;

% 遍历函数并记录可以放置球的点的位置
num_balls = 0;
ball_centers = [];
for i = 1:length(x)
    if i == 1
        P = [x(1) y(1) z(1)];
    else
        d = sqrt(sum(([x(i) y(i) z(i)] - P).^2, 2));
        if d >= 0.2 - r
            P = [x(i) y(i) z(i)];
            num_balls = num_balls + 1;
            ball_centers(num_balls, :) = P;
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
xlim([-1.2 1.2]); ylim([-1.2 1.2]); zlim([-1.2 1.2]); % 设置坐标轴范围

% 定义函数
x = @(t) cos(t);
y = @(t) sin(t);
z = @(t,b) cos(2*(t-b)) + abs(2*sin(b));

% 设置时间步和 b 的范围
t = linspace(0, 2*pi, 100);
b = linspace(0, 2*pi, 50);

% 设置坐标轴范围
xmin = -1.2; xmax = 1.2;
ymin = -1.2; ymax = 1.2;
zmin = -3; zmax = 3;

% 初始化变量
curve_data = [];

% 绘制动态曲线族
figure('Position', [0, 0, 800, 600]);
for i = 1:length(b)
    % 绘制当前曲线
    h = fplot3(x, y, @(t) z(t, b(i)), [0, 2*pi]);
    set(h, 'LineWidth', 1, 'Color', 'r');
    hold on;
    
    % 绘制曲线轨迹
    curve_data = [curve_data; [x(t)', y(t)', z(t, b(i))']];
    plot3(curve_data(:,1), curve_data(:,2), curve_data(:,3), 'b');
    
    % 设置坐标轴范围和标题
    xlim([xmin, xmax]); ylim([ymin, ymax]); zlim([zmin, zmax]);
    view(30, 30);
    title(sprintf('b = %.2f', b(i)));
    drawnow;
end

% 获取最后一帧图像的帧数据
frame_data = getframe(gcf);

% 将 RGB 图像转换为灰度图像
gray_data = rgb2gray(frame_data.cdata);

% 将灰度图像转换为二值图像，并获取边缘像素的坐标点
edge_data = edge(gray_data, 'canny');
[rows, cols] = find(edge_data);

% 将边缘像素的坐标点转换为空间坐标点
boundary_data = zeros(length(rows), 3);
boundary_data(:,1) = xmin + (xmax-xmin) * cols / size(edge_data,2);
boundary_data(:,2) = ymin + (ymax-ymin) * (size(edge_data,1)-rows) / size(edge_data,1);
boundary_data(:,3) = zmax * ones(length(rows), 1);

% 将边界点坐标拼接到一起形成曲线
curve_data = [curve_data; boundary_data];

% 绘制边界点曲线
figure('Position', [0, 0, 800, 600]);
plot3(curve_data(:,1), curve_data(:,2), curve_data(:,3), 'LineWidth', 2);
xlim([xmin, xmax]); ylim([ymin, ymax]); zlim([zmin, zmax]);
view(30,30);
title('Boundary Curve');

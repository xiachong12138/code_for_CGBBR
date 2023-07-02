m = 0.6;
% 定义函数
x = @(t) cos(t);
y = @(t) sin(t);
% z = @(t,b) cos(2*(t-b)) + abs(2*sin(b));
z = @(t,b) cos(2*(t-b)) + m*cos(2*b);

% 设置时间步和 b 的范围
t = linspace(0, 2*pi, 200);
b = linspace(0, 2*pi, 100);

% 设置坐标轴范围
xmin = -1.2; xmax = 1.2;
ymin = -1.2; ymax = 1.2;
zmin = -2.0; zmax = 3.5;

% 初始化变量
curve_data = [];

% 创建视频写入对象
writerObj = VideoWriter('curve_animation.mp4', 'MPEG-4');
writerObj.FrameRate = 30;
open(writerObj);

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
    
    % 将帧写入视频
    writeVideo(writerObj, getframe(gcf));
end

% 保存最后一刻的图片和该图片在三个坐标平面投影的图片
print(gcf, '-dpng', '-r300', 'last_frame.png');
view(2); print(gcf, '-dpng', '-r300', 'last_frame_xy.png');
view(0, 0); print(gcf, '-dpng', '-r300', 'last_frame_xz.png');
view(90, 0); print(gcf, '-dpng', '-r300', 'last_frame_yz.png');

% 关闭视频写入对象
close(writerObj);

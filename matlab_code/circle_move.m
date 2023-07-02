% 设置参数
t = linspace(0, 2*pi, 1000);
x = t;
y = sin(t);
r = 0.1;

% 绘制sinx曲线
figure;
plot(x, y, 'LineWidth', 2);
grid on;
axis equal;
xlabel('x');
ylabel('y');
title('Sine Curve');

hold on;

% 绘制动圆
theta = linspace(0, 2*pi, 100);
xcirc = r*cos(theta) + x(1);
ycirc = r*sin(theta) + y(1);
h1 = plot(xcirc, ycirc, 'r', 'LineWidth', 1);

% 移动动圆
for i = 2:length(t)
    % 计算动圆圆心的坐标
    xc = x(i);
    yc = y(i);
    
    % 更新动圆的坐标
    xcirc = r*cos(theta) + xc;
    ycirc = r*sin(theta) + yc;
    
    % 清除上一个动圆
    delete(h1);
    
    % 绘制当前动圆
    h1 = plot(xcirc, ycirc, 'r', 'LineWidth', 1);
    
    drawnow;
end

hold off;

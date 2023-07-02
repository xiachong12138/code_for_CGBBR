% 设置参数
t = linspace(0, 2*pi, 1000);
x = cos(t);
y = sin(t);
z = cos(2*t);

% 绘制函数图像
figure;
plot3(x, y, z, 'LineWidth', 2);
grid on;
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');
title('3D Function Plot');

% 生成旋转动画
h = gcf;
for i = 1:360
    view(i, 30);
    drawnow;
    frame = getframe(h);
    im{i} = frame2im(frame);
end

% 播放旋转动画
figure;
axis off;
movie(im, 10);

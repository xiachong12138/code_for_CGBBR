clear all
clc
%自变量范围
t=0:0.025:2*pi;
n=size(t,2)-1;
F_x=10*cos(t);
F_y=10*sin(t);
F_z=5*cos(2*t);
%绘制中心曲线三维图
figure(1),plot3(F_x,F_y,F_z)
%显示栅格
grid on
%求中心曲线各分量差分
diff_x=diff(F_x)/0.1;
diff_y=diff(F_y)/0.1;
diff_z=diff(F_z)/0.1;
theta=0:0.05:2*pi;
%扫略面变量范围及大小
N=size(theta,2);
%扫略面半径大小
R=0.5;
p_start=[0 0 0];
x0=p_start(1)+R*cos(theta);
y0=p_start(2)+R*sin(theta);
z0=p_start(3)+zeros(1,N);
zb=[x0;y0;z0];
figure(2)
plot(x0,y0)
grid on
%%
%将扫略面图形分别赋予x,y,z第一行
x=zeros(n+1,N);
x(1,:)=x0;
y=zeros(n+1,N);
y(1,:)=y0;
z=zeros(n+1,N);
z(1,:)=z0;
figure(3)
for i=1:n
    %clf(figure(3))
    XL=[diff_x(i),diff_y(i),diff_z(i)];
    XL=XL/sqrt(XL*XL');    %矩阵归一化
    XL=acos(XL);
    zbx=[1           0             0;           0          cos(XL(1)) sin(XL(1));0            -sin(XL(1)) cos(XL(1))]*...
              [cos(XL(2))  0             sin(XL(2));  0          1          0;         -sin(XL(2))  0           cos(XL(2))]*...
              [cos(XL(3))  -sin(XL(3))   0;           sin(XL(3)) cos(XL(3)) 0;         0            0           1]*zb;
     x(i+1,:)=zbx(1,:)+F_x(i);  
     y(i+1,:)=zbx(2,:)+F_y(i);
     z(i+1,:)=zbx(3,:)+F_z(i);
     plot3(x(i+1,:),y(i+1,:),z(i+1,:))
     hold on
     grid on
end
figure(4),mesh(x(:,1:10:end),y(:,1:10:end),z(:,1:10:end))
shading interp

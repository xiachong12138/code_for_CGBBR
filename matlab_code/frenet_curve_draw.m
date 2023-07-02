% Generate 100 points of t in the range of [0, 2*pi]
t = linspace(0,2*pi,100);

% Calculate x, y, and z using given functions
x = cos(t);
y = sin(t);
z = cos(2*t);

% Plot the curve
figure
plot3(x,y,z)
xlabel('x')
ylabel('y')
zlabel('z')
view(70,30) % Fix the view

hold on

% Frenet Frame
for i=1:length(x)
    % Calculate the tangent vector T
    T = [x(i+1)-x(i), y(i+1)-y(i), z(i+1)-z(i)];
    T = T/norm(T);
    
    % Calculate the normal vector N
    N = [y(i+1)+y(i), -x(i+1)-x(i), 2*(z(i+1)-z(i))];
    N = N/norm(N);
    
    % Calculate the binormal vector B
    B = cross(T,N);
    
    % Plot T, N, and B as quiver plots
    quiver3(x(i),y(i),z(i),T(1),T(2),T(3),'r')
    text(x(i)+T(1),y(i)+T(2),z(i)+T(3),['T = [',num2str(T(1)),',',num2str(T(2)),',',num2str(T(3)),']'])
    quiver3(x(i),y(i),z(i),N(1),N(2),N(3),'g')
    text(x(i)+N(1),y(i)+N(2),z(i)+N(3),['N = [',num2str(N(1)),',',num2str(N(2)),',',num2str(N(3)),']'])
    quiver3(x(i),y(i),z(i),B(1),B(2),B(3),'b')
    text(x(i)+B(1),y(i)+B(2),z(i)+B(3),['B = [',num2str(B(1)),',',num2str(B(2)),',',num2str(B(3)),']'])
    
    % Pause for 0.1 second before replotting
    pause(0.1)
    
    % Clear the plot
    clf
    plot3(x,y,z)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    view(70,30) % Fix the view
    hold on
end

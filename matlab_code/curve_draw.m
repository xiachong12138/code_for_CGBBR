% Define the closed curve in 3D
t = linspace(0,2*pi,100);
x = cos(t);
y = sin(t);
z = cos(2*t);

% Find the minimum and maximum values of z
z_min = min(z);
z_min_index = find(z == z_min);
z_max = max(z);
z_max_index = find(z == z_max);

% Define the sphere
diameter = 0.2;
[X,Y,Z] = sphere(30);
X = X * diameter/2;
Y = Y * diameter/2;
Z = Z * diameter/2;

% Generate the sweeping surface
h = surf(X,Y,Z);
axis equal
hold on

% Move the sphere along the closed curve
for i = 1:length(t)
    % Translate the sphere to a new position
    X_new = X + x(i);
    Y_new = Y + y(i);
    Z_new = Z + z(i);
    
    % Update the surface
    set(h,'XData',X_new,'YData',Y_new,'ZData',Z_new);
    
    % Draw the closed curve
    plot3(x,y,z,'r','LineWidth',3);
    
    % Highlight the minimum and maximum points of z
    plot3(x(z_min_index),y(z_min_index),z(z_min_index),'bo','MarkerSize',10,'MarkerFaceColor','b');
    plot3(x(z_max_index),y(z_max_index),z(z_max_index),'bo','MarkerSize',10,'MarkerFaceColor','b');
    
    % Draw the sphere
    plot3(x(i),y(i),z(i),'ro','MarkerSize',10,'MarkerFaceColor','r');
    
    % Update the plot
    pause(0.1);
    drawnow;
end
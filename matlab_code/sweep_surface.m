% Define the curve parameter equation
t = linspace(0, 2*pi, 100);
x = cos(t);
y = sin(t);
z = cos(2*t);

% Generate curve points and tangent vectors
diff_x = diff(x)./diff(t);
diff_y = diff(y)./diff(t);
diff_z = diff(z)./diff(t);
t = t(1:end-1);

% Generate vertices and triangle indices for the scan surface
vertices = [];
triangles = [];
for i = 1:length(t)
    % Calculate the center position and normal vector of the sphere
    center = [x(i), y(i), z(i)];
    normal = [diff_x(i), diff_y(i), diff_z(i)];
    normal = normal/norm(normal);
    % Generate vertices and normal vectors for the sphere
    [t_sphere, phi] = meshgrid(linspace(0, 2*pi, 20), linspace(0, pi, 10));
    x_sphere = 0.2*sin(phi).*cos(t_sphere);
    y_sphere = 0.2*sin(phi).*sin(t_sphere);
    z_sphere = 0.2*cos(phi);
    sphere_points = [x_sphere(:), y_sphere(:), z_sphere(:)];
    sphere_normals = sphere_points - center;
    sphere_normals = sphere_normals./vecnorm(sphere_normals, 2, 2);
    % Add vertices to the vertex list
    vertices = [vertices; sphere_points + center];
    % Generate triangle indices
    if i > 1
        curr_idx = 200*(i-1);
        prev_idx = 200*(i-2);
        for j = 1:200
            a = prev_idx + j;
            b = prev_idx + mod(j, 200) + 1;
            c = curr_idx + j;
            d = curr_idx + mod(j, 200) + 1;
            triangles = [triangles; [a, b, c]; [b, d, c]];
        end
    end
end

% Visualize the scan surface
trisurf(triangles, vertices(:,1), vertices(:,2), vertices(:,3));
shading interp;
xlabel('X');
ylabel('Y');
zlabel('Z');
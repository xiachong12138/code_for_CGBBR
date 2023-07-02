import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Define variables
R = 2  # Sphere radius
w = 1  # Curve parameter
A = 1  # Curve height scaling factor
r = 0.2  # Ball radius

# Create t values with a step of 0.01
t = np.arange(0, 2 * np.pi + 0.01, 0.01)

# Compute x, y, z values
x = R * np.cos(w * t)
y = R * np.sin(w * t)
z = A * np.cos(2 * t)

# Create a sphere with a diameter of 0.1
u, v = np.linspace(0, 2 * np.pi, 20), np.linspace(0, np.pi, 20)
x_sphere = r * np.outer(np.cos(u), np.sin(v))
y_sphere = r * np.outer(np.sin(u), np.sin(v))
z_sphere = r * np.outer(np.ones(np.size(u)), np.cos(v))

# Record the positions of the points where balls can be placed
num_balls = 0
ball_centers = []
P = np.array([x[0], y[0], z[0]])
for i in range(1, len(x)):
    d = np.sqrt(np.sum((np.array([x[i], y[i], z[i]]) - P) ** 2))
    if d >= 2 * r:  # The interval for placing balls is 2r
        P = np.array([x[i], y[i], z[i]])
        num_balls += 1
        ball_centers.append(P)

# Plot the 3D surface
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot(x, y, z)

# Set axis labels and title
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.set_title('Function Plot')

# Place balls on points where they can be placed
for i in range(num_balls):
    ax.plot_surface(x_sphere + ball_centers[i][0], y_sphere + ball_centers[i][1], z_sphere + ball_centers[i][2],
                    rstride=1, cstride=1, color='w', edgecolor='r')

# Set plot area
ax.set_aspect('equal')  # x, y, z axes are proportional
ax.set_xlim(-1.2 * R, 1.2 * R)
ax.set_ylim(-1.2 * R, 1.2 * R)
ax.set_zlim(-1.2 * A, 1.2 * A)  # Set axis range

plt.show()

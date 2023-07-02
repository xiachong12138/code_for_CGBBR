import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Define the closed curve in 3D
t = np.linspace(0, 2 * np.pi, 100)
x = np.cos(t)
y = np.sin(t)
z = np.cos(2 * t)

# Find the minimum and maximum values of z
z_min = np.min(z)
z_min_index = np.argmin(z)
z_max = np.max(z)
z_max_index = np.argmax(z)

# Define the sphere
diameter = 0.2
u, v = np.mgrid[0:2 * np.pi:30j, 0:np.pi:15j]
X = diameter / 2 * np.cos(u) * np.sin(v)
Y = diameter / 2 * np.sin(u) * np.sin(v)
Z = diameter / 2 * np.cos(v)

# Set up the 3D plot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Move the sphere along the closed curve
trajectory = np.empty((0, 3))
for i in range(len(t)):
    # Translate the sphere to a new position
    X_new = X + x[i]
    Y_new = Y + y[i]
    Z_new = Z + z[i]

    # Update the surface
    ax.clear()
    ax.plot_surface(X_new, Y_new, Z_new, color='r', alpha=0.5, linewidth=0)

    # Draw the closed curve
    ax.plot(x, y, z, color='k', linewidth=3)

    # Highlight the minimum and maximum points of z
    ax.scatter(x[z_min_index], y[z_min_index], z[z_min_index], s=100, c='b', marker='o')
    ax.scatter(x[z_max_index], y[z_max_index], z[z_max_index], s=100, c='b', marker='o')

    # Draw the sphere
    ax.scatter(x[i], y[i], z[i], s=100, c='r', marker='o')

    # Add current position to trajectory
    trajectory = np.vstack((trajectory, [x[i], y[i], z[i]]))

    # Plot the trajectory
    ax.plot(trajectory[:, 0], trajectory[:, 1], trajectory[:, 2], 'g--')

    # Update the plot
    plt.pause(0.1)

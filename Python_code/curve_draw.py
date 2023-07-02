import numpy as np
import matplotlib.pyplot as plt

# Define the closed curve in 3D
t = np.linspace(0, 2*np.pi, 100)
x = np.cos(t)
y = np.sin(t)
z = np.cos(2*t)

# Find the highest and lowest points of the curve
z_max_index = np.argmax(z)
z_min_index = np.argmin(z)

# Define the sphere
phi, theta = np.linspace(0, np.pi, 20), np.linspace(0, 2*np.pi, 40)
phi, theta = np.meshgrid(phi, theta)
x_sphere = 0.2 * np.sin(phi) * np.cos(theta)
y_sphere = 0.2 * np.sin(phi) * np.sin(theta)
z_sphere = 0.2 * np.cos(phi)

# Generate the sweeping surface
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(x_sphere, y_sphere, z_sphere)

# Move the sphere along the closed curve
for i in range(len(t)):
    # Translate the sphere to a new position
    x_sphere_new = x_sphere + x[i]
    y_sphere_new = y_sphere + y[i]
    z_sphere_new = z_sphere + z[i]

    # Update the surface
    ax.clear()
    ax.plot_surface(x_sphere_new, y_sphere_new, z_sphere_new)

    # Draw the closed curve
    ax.plot(x, y, z, 'r', linewidth=3)

    # Draw the highest and lowest points in blue
    if i == z_max_index:
        ax.plot(x[i], y[i], z[i], 'bo', markersize=10)
    elif i == z_min_index:
        ax.plot(x[i], y[i], z[i], 'bo', markersize=10)
    else:
        ax.plot(x[i], y[i], z[i], 'ro', markersize=10)

    # Update the plot
    ax.set_xlim([-1.5, 1.5])
    ax.set_ylim([-1.5, 1.5])
    ax.set_zlim([-1.5, 1.5])
    plt.draw()
    plt.pause(0.1)

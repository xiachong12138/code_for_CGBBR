from sympy import *

# Define symbols and variables
t = symbols('t')
x, y, z = symbols('x y z', cls=Function)

# Define the curve r(t) as a vector function of t
r = Matrix([x(t), y(t), z(t)])

# Find the first and second derivatives of the curve r(t) with respect to t
drdt = r.diff(t)
d2rdt2 = r.diff(t, 2)

# Calculate the norm of the first derivative
drdt_norm = drdt.norm()

# Calculate the norm of the cross product of the first and second derivatives
cross_norm = drdt.cross(d2rdt2).norm()

# Calculate the curvature of the curve
kappa = cross_norm / drdt_norm**3

# Print the curvature of the curve
print("The curvature of the curve is:")
print(kappa)

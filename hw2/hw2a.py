import numpy as np
from mpl_toolkits.axes_grid.axislines import SubplotZero
from matplotlib import pyplot as plt
from numpy import linalg as la

#Input points
xi = np.array([-1.,1.,2.])
yi = np.array([0.,4.,3.])

#dimensions of matrix
n = len(xi)
m = 3

#plotting the input points
fig = plt.figure(1)
ax = SubplotZero(fig, 111)
fig.add_subplot(ax)

ax.plot(xi, yi, 'ro')
ax.axis([-10,10,-10,10])

for direction in ["xzero", "yzero"]:
    ax.axis[direction].set_axisline_style("-|>")
    ax.axis[direction].set_visible(True)

for direction in ["left", "right", "bottom", "top"]:
    ax.axis[direction].set_visible(False)

#Constructing A

A = np.zeros([n,m]) #takes a list as input
for i in range(n):
    A[i][0] = 1
    A[i][1] = xi[i]
    A[i][2] = xi[i]**2

#print A

c = la.solve(A,yi)

#print c

#plotting the interpolated points
xo = np.linspace(-10, 10, 21)
yo = np.zeros(21)
for i in range(21):
    yo[i] = c[0] + c[1]*(i-10) + c[2]*(i-10)**2

ax.plot(xo, yo, 'b')

plt.savefig('hw2a.png')
plt.show()

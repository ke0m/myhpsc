"""
Demonstration script for quadratic interpolation
Created by Joseph Jennings
Source(s): http://faculty.washington.edu/rjl/uwhpsc-coursera/homework2.html#homework2
"""
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
xo = np.linspace(xi.min()-1, xi.max()+1, 1000)
yo = np.zeros(1000)
for i in range(1000):
    yo[i] = c[0] + c[1]*(xo[i]) + c[2]*(xo[i])**2

ax.plot(xo, yo, 'b')
    
plt.title("Data points and interpolating polynomial")
plt.savefig('hw2a.png')
plt.show()




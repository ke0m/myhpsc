# $MYHPSC/hw3/intersections.py

from newton import solve
import numpy as np
import matplotlib.pyplot as plt

def fvals_prob4(x):
    """
    The functions and their derivatives
    of which we are trying to find their zeros
    """
    fx  = x*np.cos(np.pi*x) + 0.6*x**2 - 1.
    fpx = np.cos(np.pi*x) - x*np.pi*np.sin(np.pi*x) + 1.2*x
    return fx, fpx 

# Solving for the intersection points
# initial guess for next problem -3,-2,-1,1
num_guess = 4
xr = np.zeros(num_guess)
i = 0
for x0 in [-3., -2., -1., 1.9]:
    xr[i], iters = solve(fvals_prob4,x0, True)
    print "With initial guess x0 = %22.15e, solve returns x = %22.15e after %i iterations" %(x0, xr[i], iters)
    i = i + 1

#Plotting the functions and their intersections

g1 = np.zeros(1000)
g2 = np.zeros(1000)
x = np.linspace(-8, 8, 1000)

for i in range(1000):
    g1[i] = x[i]*np.cos(np.pi*x[i])
    g2[i] = 1. - 0.6*x[i]**2

#Finding the computed zeros
pi1 = xr[0]*np.cos(np.pi*xr[0])
pi2 = xr[1]*np.cos(np.pi*xr[1])
pi3 = xr[2]*np.cos(np.pi*xr[2])
pi4 = xr[3]*np.cos(np.pi*xr[3])

blue, = plt.plot(x,g1,'b',label='g1')
red, = plt.plot(x,g2,'r',label='g2')
plt.legend(handles=[blue,red])
plt.plot(xr[0],pi1,'ko')
plt.plot(xr[1],pi2,'ko')
plt.plot(xr[2],pi3,'ko')
plt.plot(xr[3],pi4,'ko')
plt.xlim((-5,5))
plt.ylim((-5,5))

plt.show()



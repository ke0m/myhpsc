# $MYHPSC/hw3/intersections.py

from newton import solve
import numpy as np
import matplotlib.pyplot as plt

def fvals_prob4(x):
    """
    The functions and their derivatives
    of which we are trying to find their zeros
    """
    fx  = np.sin(x) + x**2 - 1 
    fpx = np.cos(x) + 2.*x
    return fx, fpx 

#Solving for the intersection points
xr = np.zeros(2)
i = 0
for x0 in [-5, 5.]:
    xr[i], iters = solve(fvals_prob4,x0, False)
    print "With initial guess x0 = %22.15e, solve returns x = %22.15e after %i iterations" %(x0, xr[i], iters)
    i = i + 1

#Plotting the functions and their intersections

g1 = np.zeros(1000)
g2 = np.zeros(1000)
x = np.linspace(-8, 8, 1000)

for i in range(1000):
    g1[i] = np.sin(x[i])
    g2[i] = 1 - x[i]**2

#Finding the computed zeros
pi1 = np.sin(xr[0])
pi2 = np.sin(xr[1])

blue, = plt.plot(x,g1,'b',label='g1')
red, = plt.plot(x,g2,'r',label='g2')
plt.legend(handles=[blue,red])
plt.plot(xr[0],pi1,'ko')
plt.plot(xr[1],pi2,'ko')
plt.xlim((-8,8))
plt.ylim((-3,3))


plt.show()



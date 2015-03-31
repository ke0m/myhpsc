# $MYHPSC/hw3/intersections.py

from newton import solve

def fvals_prob4(x):
    from numpy import sin, cos
    fx  = sin(x) + x**2 - 1 
    fpx = cos(x) + 2.*x
    return fx, fpx 

for x0 in [-5, 5.]:
    x, iters = solve(fvals_prob4,x0, True)
    print "With initial guess x0 = %22.15e, solve returns x = %22.15e after %i iterations" %(x0, x, iters)


# $MYHPSC/hw3/newton.py

def fvals_sqrt(x):
    """
    Returns the values of f(x) = x**2 - a
    and its derivative for any input x
    """
    fx  = x**2 - 4.
    fpx = 2.*x
    return fx, fpx

def solve(fvals_sqrt, x0, debug=False):
    """
    Iteratively solves for the root of a function 
    using newton's method
    Input parameters:
        fvals_sqrt - the function fvals_sqrt defined above
        x0 - inital guess
        debug_solve - a debug flag whether to print intermediate values
    """
    maxiter = 20
    fx, fpx = fvals_sqrt(x0) 
    if(debug == True):
        print "Initial guess: x = %22.15e" %(x0)
    xk = x0 - fx/fpx #testing the initial guess
    for i in range(maxiter):
        xk = xk - fx/fpx
        if(debug == True and i>0):
            print "After %i iterations, x = %22.15e" % (i, xk)
        fx,fpx = fvals_sqrt(xk)
        if(abs(fx) < 1e-14):
            break

    if(i < maxiter-1):
        return xk, i
    elif(i == maxiter-1 and abs(fx) < 1e-14):
        return
    elif(i == maxiter-1 and abs(fx) >= 1e-14):
        print "Could not converge to the solution within 20 iterations. Please try another initial guess"
        return xk,i
    else:
        print "solve exceeded 20 iterations. This should not have happened"
    
def test1(debug_solve=False):
    """
    Test Newton iteration for the square root with different initial
    conditions.
    """
    from numpy import sqrt
    for x0 in [1., 2., 100.]:
        print " "  # blank line
        x,iters = solve(fvals_sqrt, x0, debug=debug_solve)
        print "solve returns x = %22.15e after %i iterations " % (x,iters)
        fx,fpx = fvals_sqrt(x)
        print "the value of f(x) is %22.15e" % fx
        assert abs(x-2.) < 1e-14, "*** Unexpected result: x = %22.15e"  % x




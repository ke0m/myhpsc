"""
Module for approximating square root.
The use specifies an input and the function
prints the square root of the number.

It uses Newtons Method to find the zero of 
the function f(s) = s^2 - x, where x is the input
argument and s is the final result.
$MYHPSC/w2-l4
"""

def sqrt2(x, debug=False):
    from numpy import nan
    if x==0:
        return 0.
    elif x<0:
        print "*** Error, x must be nonnegative"
        return nan
    assert x>0. and type(x) is float, "Unrecognized input" # a statement to verify that we are OK.
    s = 1
    kmax = 100
    tol = 1.e-14
    for k in range(kmax):
        if debug: 
            print "Before iteration %s, s= %s" % (k,s)
        s0 = s
        s = 0.5 * (s + x/s) #Newton's method
        delta_s = s-s0
        if abs(delta_s/x) < tol: #checking to see that the relative error lies within 
            break                #a specified tolerance
    if debug:
        print "After %s iterations, s = %s" %(k+1,s)
    return s

"""
A test function with asserts in order to compare
my sqrt with that of numpy.
This is unit testing!

Can run this with nosetests. nosetests will check all of the assertions.
Must have "test" in the function name in order for nosetests to find it.
"""
def test():
    from numpy import sqrt
    xvalues = [0., 2., 100., 10000., 1.e-4]
    for x in xvalues:
        print "Testing with x = %20.15e" % x
        s = sqrt2(x)
        s_numpy = sqrt(x)
        print "s = %20.15e, numpy.sqrt = %20.15e" %(s, s_numpy)
        assert abs(s - s_numpy) < 1e-14, "Disagree for x = %20.15e" % x


if __name__ == "__main__":

    print "Running test..."
    test()



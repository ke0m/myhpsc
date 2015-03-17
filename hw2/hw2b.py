"""
Demonstration module for quadratic interpolation.
Solves a system of equations in order to compute
the coefficients of the quadratic polynomial.
With the compute coefficients, we can plot the 
interpolating polynomial
Created by: Joseph Jennings
Date: 3/16/2015
Source(s): http://faculty.washington.edu/rjl/uwhpsc-coursera/homework2.html#homework2
"""
import numpy as np
from mpl_toolkits.axes_grid.axislines import SubplotZero
from matplotlib import pyplot as plt
from numpy import linalg as la

def quad_interp(xi, yi, debug=False):

    """
    Quadratic interpolation.  Compute the coefficients of the polynomial
    interpolating the points (xi[i],yi[i]) for i = 0,1,2.
    Returns c, an array containing the coefficients of
      p(x) = c[0] + c[1]*x + c[2]*x**2.
    """

    # check inputs and print error message if not valid:

    error_message = "xi and yi should have type numpy.ndarray"
    assert (type(xi) is np.ndarray) and (type(yi) is np.ndarray), error_message

    error_message = "xi and yi should have length 3"
    assert len(xi)==3 and len(yi)==3, error_message

    #dimensions of matrix
    n = len(xi)
    m = 3

    #plotting the input points
    fig = plt.figure(1)
    ax = SubplotZero(fig, 111)
    fig.add_subplot(ax)

    ax.plot(xi, yi, 'ro')
    #ax.axis([xi.min(),xi.max(),yi.min(),yi.max()])

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

    c = la.solve(A,yi)

    if debug==True:
        print A
        print c

    #plotting the interpolated points
    xo = np.linspace(xi.min()-1, xi.max()+1, 1000)
    yo = np.zeros(1000)
    for i in range(1000):
        yo[i] = c[0] + c[1]*(xo[i]) + c[2]*(xo[i])**2

    ax.plot(xo, yo, 'b')
    
    plt.title("Data points and interpolating polynomial")
    plt.savefig('hw2b.png')
    plt.show()

    return c

def plot_quad(c):

def cubic_interp(xi, yi, debug=False):

    return c

def plot_cubic(c):

def poly_interp(xi, yi, debug=False):

    return c

def plot_poly(c):

def test_quad1():
    """ 
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  0.,  2.])
    yi = np.array([ 1., -1.,  7.])
    c = quad_interp(xi,yi)
    c_true = np.array([-1.,  0.,  2.])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_quad2():
    """
    Test code, no return value or exception if test runs properly.
    Still working on a test here...
    An idea is to compare it with an interpolation function
    from scipy
    """
    xi = np.array([-1.,  0.,  2.])
    yi = np.array([ 1., -1.,  7.])
    c = quad_interp(xi,yi)
    c_true = np.array([-1.,  0.,  2.])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_cubic():

def test_poly():


if __name__=="__main__":
    # "main program"
    # the code below is executed only if the module is executed at the command line,
    #    $ python demo2.py
    # or run from within Python, e.g. in IPython with
    #    In[ ]:  run demo2
    # not if the module is imported.
    print "Running test..."
    test_quad1()

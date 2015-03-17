"""
Demonstration module for quadratic interpolation.
Solves a system of equations in order to compute
the coefficients of polynomials.
With the computed coefficients, we can plot the 
interpolating polynomial
Modified by: Joseph Jennings
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

    return c

def plot_quad(xi,yi):
    """
    Plots the data points (red) and interpolating 
    polynomial for the input x and y coordinates and 
    Plots on a cartesian grid
    """

    #Computing the coefficients
    c = quad_interp(xi,yi)

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

    #plotting the interpolated points
    xo = np.linspace(xi.min()-1, xi.max()+1, 1000)
    yo = np.zeros(1000)
    for i in range(1000):
        yo[i] = c[0] + c[1]*(xo[i]) + c[2]*(xo[i])**2

    ax.plot(xo, yo, 'b')
    
    plt.title("Data points and interpolating polynomial")
    plt.savefig('quadratic.png')
    plt.show()

def cubic_interp(xi, yi, debug=False):
    """
    Cubic interpolation.  Compute the coefficients of the polynomial
    interpolating the points (xi[i],yi[i]) for i = 0,1,2,3.
    Returns c, an array containing the coefficients of
      p(x) = c[0] + c[1]*x + c[2]*x**2 + c[3]*x**3
    """

    # check inputs and print error message if not valid:

    error_message = "xi and yi should have type numpy.ndarray"
    assert (type(xi) is np.ndarray) and (type(yi) is np.ndarray), error_message

    error_message = "xi and yi should have length 4"
    assert len(xi)==4 and len(yi)==4, error_message

    #dimensions of matrix
    n = len(xi)
    m = 4

    #Constructing A

    A = np.zeros([n,m]) #takes a list as input
    for i in range(n):
        A[i][0] = 1
        A[i][1] = xi[i]
        A[i][2] = xi[i]**2
        A[i][3] = xi[i]**3

    c = la.solve(A,yi)

    if debug==True:
        print A
        print c

    return c

def plot_cubic(xi,yi):
    """
    Plots the data points (red) and interpolating 
    polynomial for the input x and y coordinates
    Plots on a cartesian grid
    """
    #computing the coefficients
    c = cubic_interp(xi,yi)

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

    #plotting the interpolated points
    xo = np.linspace(xi.min()-1, xi.max()+1, 1000)
    yo = np.zeros(1000)
    for i in range(1000):
        yo[i] = c[0] + c[1]*(xo[i]) + c[2]*(xo[i])**2 + c[3]*(xo[i])**3

    ax.plot(xo, yo, 'b')
    
    plt.title("Data points and interpolating polynomial")
    plt.savefig('cubic.png')
    plt.show()

def poly_interp(xi, yi, debug=False):
    """
    nth order polynomial interpolation. Compute the coefficients of the polynomial
    interpolating the points (xi[i],yi[i]) for i = 0,1,2.
    Returns c, an array containing the coefficients of
      p(x) = c[0] + c[1]*x + c[2]*x**2 + c[3]*x**3 + c[4]*x**4 + ... + c[n]*x**n
    """

    # check inputs and print error message if not valid:

    error_message = "xi and yi should have type numpy.ndarray"
    assert (type(xi) is np.ndarray) and (type(yi) is np.ndarray), error_message

    error_message = "xi and yi should have length 4"
    assert len(xi)==len(yi), error_message

    #dimensions of matrix
    n = len(xi)
    m = n

    #Constructing A

    A = np.zeros([n,m]) #takes a list as input
    for i in range(n):
        for j in range(m):
            A[i][j] = xi[i]**j

    c = la.solve(A,yi)

    if debug==True:
        print A
        print c

    return c

def plot_poly(xi,yi):
    """
    Plots the data points (red) and interpolating 
    polynomial for the input x and y coordinates. 
    Plots on a cartesian grid.
    """
    #computing the coefficients
    c = poly_interp(xi,yi)

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

    #plotting the interpolated points
    n = len(c)
    xo = np.linspace(xi.min()-1, xi.max()+1, 1000)
    yo = np.zeros(1000)
    #horners rule in python. How does this work??
    yo = c[n-1]
    for j in range(n-1, 0, -1):
        yo = yo*xo + c[j-1]

    ax.plot(xo, yo, 'b')
    
    plt.title("Data points and interpolating polynomial")
    plt.savefig('poly.png')
    plt.show()

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
    """
    xi = np.array([-1.,  1.,  2.])
    yi = np.array([ 0., 4.,  3.])
    c = quad_interp(xi,yi)
    c_true = np.array([3.,  2., -1.])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_cubic():
    """ 
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  0.,  2., 3.])
    yi = np.array([ 1., -1.,  7., 8.])
    c = cubic_interp(xi,yi)
    c_true = np.array([-1.,  1.5,  2.75, -0.75])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_poly1():
    """ 
    Test code, no return value or exception if test runs properly.
    If it runs properly, this test should give the same results as
    the cubic interpolation test. 
    """
    xi = np.array([-1.,  0.,  2., 3.])
    yi = np.array([ 1., -1.,  7., 8.])
    c = poly_interp(xi,yi)
    c_true = np.array([-1.,  1.5,  2.75, -0.75])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_poly2():
    """ 
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  0.,  2., 3., 5.])
    yi = np.array([ 1., -1.,  7., 8., 12.])
    n = len(xi)
    c = poly_interp(xi,yi)
    c_true = np.polyfit(xi,yi,n-1)
    c_true_rev = c_true[::-1]
    print "c =      ", c
    print "c_true = ", c_true_rev
    # test that all elements have small error:
    assert np.allclose(c, c_true_rev), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

if __name__=="__main__":
    # "main program"
    # the code below is executed only if the module is executed at the command line,
    #    $ python demo2.py
    # or run from within Python, e.g. in IPython with
    #    In[ ]:  run demo2
    # not if the module is imported.
    print "Running tests..."
    test_quad1()
    test_quad2()
    test_cubic()
    test_poly1()
    test_poly2()

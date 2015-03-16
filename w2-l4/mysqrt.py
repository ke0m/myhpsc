"""
Module for approximating square root.
The use specifies an input and the function
prints the square root of the number.

It uses Newtons Method to iteratively compute
square root based on a guess of 1.0 and 
a tolerance of 1x10**-14
$MYHPSC/w1-l3
"""

def sqrt2(x):
    s = 1
    #kmax = 100
    kmax = 2
    tol = 1.e-14
    for k in range(kmax):
        print "Before iteration %s, s= %s" % (k,s)
        s0 = s
        s = 0.5 * (s + x/s) #Newton's method
        delta_s = s-s0
        if abs(delta_s/x) < tol: #checking to see that the relative error lies within 
            break                #a specified tolerance
    
    print "After %s iterations, s = %s" %(k+1,s)

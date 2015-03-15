import numpy as np

s = 1
x = 2
kmax = 100
tol = 1.e-14

for k in range(kmax):
    print "Before iteration %s, s= %s" %(k,s)
    s0 = s
    s = 0.5 * (s + x/s) #Newton's method
    delta_s = s-s0
    if abs(delta_s/x) < tol: #checking to see that the relative error lies within 
        break                #a specified tolerance

print "After %s iterations, s = %s" %(k+1,s)

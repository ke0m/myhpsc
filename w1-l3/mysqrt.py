import numpy as np

s = 500
x = 1000000
kmax = 6

for k in range(kmax):
    print "Before iteration %s, s= %s" %(k,s)
    s = 0.5 * (s + x/s)

print "After %s iterations, s = %s" %(kmax,s)



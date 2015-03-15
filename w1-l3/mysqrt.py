import numpy as np

s = 1
x = 2

for k in range(6):
    s = 0.5 * (s + x/s)
    print s 

print s



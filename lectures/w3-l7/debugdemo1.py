"""
$UWHPSC/codes/python/debugdemo1.py

Debugging demo using pdb. Original code.
"""

x = "three"
y = -22.

def f(z):
    x = z+10
    print "+++ in function f: x = %s, y = %s" %(x,y)
    return x

print "+++ before calling f: x = %s, y = %s" %(x,y)
y = f(x)
print "+++ after calling f: x = %s, y = %s" %(x,y)

print "x = ",x
print "y = ",y


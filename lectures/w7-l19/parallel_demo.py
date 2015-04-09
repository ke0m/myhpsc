import numpy as np
import matplotlib.pyplot as plt
from IPython import parallel

# Talk to the parallel client
rc = parallel.Client()

# Makes the processing synchonous.
# Generally would be set to False for 
# asynchonous processing
rc.block = True

# prints the different IDs of our processors
rc.ids

# A power function for demonstration
def power(a,b):
    return a**b

# Implements the power function on one processor
dv = rc[0]
dv.apply(power, 2, 10)

# Implementing the power function on all targetd processors
rc[:].apply(power, 2, 10)




# coding: utf-8

# In[1]:

pwd


# In[2]:

import mysqrt


# In[3]:

ls


# In[4]:

mysqrt.test()


# In[5]:

run mysqrt.py


# In[6]:

mysqrt.__name__


# time sqrt(2.)
# us means microseconds 1e-6 seconds

# In[8]:

timeit sqrt(2.)


# In[9]:

timeit sqrt(2.)


# In[10]:

timeit mysqrt.sqrt2(2.)


# In[11]:

timeit y = sqrt(linspace(0,1,100))


# In[12]:

get_ipython().run_cell_magic(u'timeit', u'', u'y = zeros(1000)\nfor i in range(1000):\n    y[i] = sqrt(i)')


# ms = millisecond = 1e-3 second

# In[ ]:




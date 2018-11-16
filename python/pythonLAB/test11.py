import sys
import math
m=sys.argv[1]
m=int(m)

n=sys.argv[2]
n=int(n)

k=sys.argv[3]
k=int(k)

if ((k%m==0) or (k%n==0)) and (k<n*m):
    print ("yes")
else:print ("no")
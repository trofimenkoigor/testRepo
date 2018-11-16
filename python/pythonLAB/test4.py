

import sys


sys.argv[2]
a=float(sys.argv[1])
b=float(sys.argv[2])
c=float(sys.argv[3])

if a<=0 or b<=0 or c<=0:
    print ("ne trukytnuk")
elif a<b+c and b<a+c and c<a+b:
    print("trukytnuk")
else:
    print ("ne trukytnuk")
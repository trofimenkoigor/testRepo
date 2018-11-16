#import sys
def super_fibonacci(n, m):
    L = []
    for i in range(m):
        L.append (1)
    d = n-m
    if d<0:
       d=0
    for j in range(d):
        S = 0
        for k in range(m):
            S += L[ len(L) - k - 1 ]
        L.append(S)
    return L[n-1]
print(super_fibonacci(9,3))
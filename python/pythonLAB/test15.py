
def f(l):
    n = []
    for i in l:
        if i not in n:
            n.append(i)
    return n
print (f([1, 1, 2, 3, 3, 4, 5, 6]))

n = input(int)

def count_holes(n):
    n = str(int(n))
    d = {'4':1, '6':1, '8':2,'9':1,'0':1}
    count = 0
    for i in n:
        if i in d:
            count += d[i]
    return count
print ("дырок:")
print (count_holes(n))

import sys
import math
s1=sys.argv[1]
s1=int(s1)

s2=sys.argv[2]
s2=int(s2)
l1=[]
l2=[]

while s1 < s2+1:
	l1.insert(-1,str(s1))
	s1+=1

for i in l1:
	if len(i) < 6:
		while len(i) < 6:
			i='0'+i;
	l2.insert(-1, i);
del l1[0:]

for i in l2:
	if (int(i[0])+int(i[1])+int(i[2])) == (int(i[3])+int(i[4])+int(i[5])):
		l1.append(i)

print (l1)
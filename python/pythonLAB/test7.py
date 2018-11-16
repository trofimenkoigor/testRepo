import sys
slovo=list(sys.argv[1:])
slovo2=''
z=0

while z < len(slovo):
	slovo2=slovo2+' '+slovo[-1-z]
	z+=1
slovo2=slovo2.strip()
print slovo2
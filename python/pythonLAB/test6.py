import sys
#sys.argv[1]
slovo=sys.argv[1]
slovo=slovo.lower()

slovo=slovo.replace(' ','')

a=slovo[::-1]
print (slovo)
if slovo == a:
  print("yes")
else:
  print("no")



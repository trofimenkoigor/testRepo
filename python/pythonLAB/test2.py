str = list (sys.argv[1:])
str.reverse()
i = 0
str2 =""
while i < (len(str)):
    str2=(str2 + (str[i]) + " ")
    i+=1
print (str2)
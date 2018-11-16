# Задание: проверить существование пользователя в системе можно выполнить несколькими методами:
# первый метод:

#a = input('Enter the user: ')
#file=open('/etc/passwd','r')
#text=file.read()
#if a in text:
#    print ("Yes")
#else: print ("no")

# второй метод:

import pwd

userid = input('Enter the user: ')
if userid in [x[0] for x in pwd.getpwall()]:
    print ("Yes")
else: print ("no")
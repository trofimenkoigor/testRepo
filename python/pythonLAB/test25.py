aon = raw_input('enter code: ')
res = ''
tel = ''
last_sym = ''
# убираю повторы и отсеиваю помехи
for sym in aon:
    if (last_sym == sym and (len(res) == 0 or res[-1] != sym)):
        res += sym
    last_sym = sym

# заменяю решётки на предшествующие им символы
for sym in res:
    if (sym != '#'):
        tel += sym
    else:
        tel += last_sym
    last_sym = sym

print (tel)
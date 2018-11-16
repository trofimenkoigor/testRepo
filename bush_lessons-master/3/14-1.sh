#!/bin/bash
# stupid-script-tricks.sh: Люди! Будьте благоразумны!
# Из "Глупые выходки", том I.


dangerous_variable=`cat /boot/vmlinuz-3.13.0-93-generic`   # Сжатое ядро Linux.

echo "длина строки \$dangerous_variable = ${#dangerous_variable}"
# длина строки $dangerous_variable = 794151
# ('wc -c /boot/vmlinuz' даст другой результат.)

# echo "$dangerous_variable"
# Даже не пробуйте раскомментарить эту строку! Это приведет к зависанию сценария.


#  Автор этого документа не знает, где можно было бы использовать
#+ запись содержимого двоичных файлов в переменные.

exit 0


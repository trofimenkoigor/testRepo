#!/bin/bash
# fileinfo.sh

FILES="/usr/sbin/e2fsck
/usr/sbin/pwck
/usr/sbin/fdisk
/usr/bin/fakefile
/sbin/mountall
/sbin/ifconfig"     # Список интересующих нас файлов.
                  # В список добавлен фиктивный файл /usr/bin/fakefile.

echo

for file in $FILES
do

  if [ ! -e "$file" ]       # Проверка наличия файла.
  then
    echo "Файл $file не найден."; echo
    continue                # Переход к следующей итерации.
  fi

  ls -l $file | awk '{ print $8 "         размер: " $5 }'  # Печать 2 полей.
  whatis `basename $file`   # Информация о файле.
  echo
done  

exit 0


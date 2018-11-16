#!/bin/bash
# userlist.sh

PASSWORD_FILE=/etc/passwd
n=1           # Число пользователей

for name in $(awk 'BEGIN{FS=":"}{print $1}' < "$PASSWORD_FILE" )
# Разделитель полей = :  ^^^^^^
# Вывод первого поля              ^^^^^^^^
# Данные берутся из файла паролей            ^^^^^^^^^^^^^^^^^
do
  echo "Пользователь #$n = $name"
  let "n += 1"
done


# Пользователь #1 = root
# Пользователь #2 = bin
# Пользователь #3 = daemon
# ...
# Пользователь #30 = bozo

exit 0


#!/bin/bash

echo
echo -n "Введите пароль "
read passwd
echo "Вы ввели пароль: $passwd"
echo -n "Если кто-нибудь в это время заглядывал Вам через плечо, "
echo "то теперь он знает Ваш пароль."

echo && echo  # Две пустых строки через "and list".

stty -echo    # Отключить эхо-вывод.

echo -n "Введите пароль еще раз "
read passwd
echo
echo "Вы ввели пароль: $passwd"
echo

stty echo     # Восстановить эхо-вывод.

exit 0



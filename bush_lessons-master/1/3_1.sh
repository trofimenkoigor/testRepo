#!/bin/bash
# Чтение строк из файла /etc/fstab.

File=/etc/fstab

{
read line1
read line2
} < $File

echo "Первая строка в $File :"
echo "$line1"
echo
echo "Вторая строка в $File :"
echo "$line2"

exit 0


#!/bin/bash

until [ "$var1" = end ] # Проверка условия производится в начале итерации.
do
  echo "Введите значение переменной #1 "
  echo "(end - выход)"
  read var1
  echo "значение переменной #1 = $var1"
done  

exit 0


#!/bin/bash
# csubloop.sh: Запись результатов выполнения цикла в переменную

variable1=`for i in 1 2 3 4 5
do
  echo -n "$i"                 #  Здесь 'echo' -- это ключевой момент
done`

echo "variable1 = $variable1"  # variable1 = 12345


i=0
variable2=`while [ "$i" -lt 10 ]
do
  echo -n "$i"                 # Опять же, команда 'echo' просто необходима.
  let "i += 1"                 # Увеличение на 1.
done`

echo "variable2 = $variable2"  # variable2 = 0123456789

exit 0


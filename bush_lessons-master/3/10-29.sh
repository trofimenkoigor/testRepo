#!/bin/bash

PS3='Выберите ваш любимый овощ: ' # строка приглашения к вводу (prompt)

echo

select vegetable in "бобы" "морковь" "картофель" "лук" "брюква"
do
  echo
  echo "Вы предпочитаете $vegetable."
  echo ";-))"
  echo
  break  # если 'break' убрать, то получится бесконечный цикл.
done

exit 0


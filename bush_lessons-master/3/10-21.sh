#!/bin/bash
# break-levels.sh: Прерывание циклов.

# "break N" прерывает исполнение цикла, стоящего на N уровней выше текущего.

for outerloop in 1 2 3 4 5
do
  echo -n "Группа $outerloop:   "

  for innerloop in 1 2 3 4 5
  do
    echo -n "$innerloop "

    if [ "$innerloop" -eq 3 ]
    then
      break  # Попробуйте "break 2",
             # тогда будут прерываться как вложенный, так и внешний циклы
    fi
  done

  echo
done  

echo

exit 0


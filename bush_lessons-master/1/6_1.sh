#!/bin/bash

echo hello
echo $?    # код возврата = 0, поскольку команда выполнилась успешно.

lskdf      # Несуществующая команда.
echo $?    # Ненулевой код возврата, поскольку команду выполнить не удалось.

echo

exit 113   # Явное указание кода возврата 113.
           # Проверить можно, если набрать в командной строке "echo $?"
           # после выполнения этого примера.

#  В соответствии с соглашениями, 'exit 0' указывает на успешное завершение,
#+ в то время как ненулевое значение означает ошибку.

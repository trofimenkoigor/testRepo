#!/bin/bash

# Демонстрация некоторых приемов работы с командой 'expr'
# =======================================

echo

# Арифметические операции
# -------------- --------

echo "Арифметические операции"
echo
a=`expr 5 + 3`
echo "5 + 3 = $a"

a=`expr $a + 1`
echo
echo "a + 1 = $a"
echo "(инкремент переменной)"

a=`expr 5 % 3`
# остаток от деления (деление по модулю)
echo
echo "5 mod 3 = $a"

echo
echo

# Логические операции
# ---------- --------

#  Возвращает 1 если выражение истинноо, 0 -- если ложно,
#+ в противоположность соглашениям, принятым в Bash.

echo "Логические операции"
echo

x=24
y=25
b=`expr $x = $y`         # Сравнение.
echo "b = $b"            # 0  ( $x -ne $y )
echo

a=3
b=`expr $a \> 10`
echo 'b=`expr $a \> 10`, поэтому...'
echo "Если a > 10, то b = 0 (ложь)"
echo "b = $b"            # 0  ( 3 ! -gt 10 )
echo

b=`expr $a \< 10`
echo "Если a < 10, то b = 1 (истина)"
echo "b = $b"            # 1  ( 3 -lt 10 )
echo
# Обратите внимание на необходимость экранирования операторов.

b=`expr $a \<= 3`
echo "Если a <= 3, то b = 1 (истина)"
echo "b = $b"            # 1  ( 3 -le 3 )
# Существует еще оператор "\>=" (больше или равно).


echo
echo

# Операции сравнения
# -------- ---------

echo "Операции сравнения"
echo
a=zipper
echo "a is $a"
if [ `expr $a = snap` ]
then
   echo "a -- это не zipper"
fi

echo
echo



# Операции со строками
# -------- -- --------

echo "Операции со строками"
echo

a=1234zipper43231
echo "Строка над которой производятся операции: \"$a\"."

# length: длина строки
b=`expr length $a`
echo "длина строки \"$a\" равна $b."

# index: позиция первого символа подстроки в строке
b=`expr index $a 23`
echo "Позиция первого символа \"2\" в строке \"$a\" : \"$b\"."

# substr: извлечение подстроки, начиная с заданной позиции, указанной длины
b=`expr substr $a 2 6`
echo "Подстрока в строке \"$a\", начиная с позиции 2,\
и длиной в 6 символов: \"$b\"."


#  При выполнении поиска по шаблону, по-умолчанию поиск
#+ начинается с ***начала*** строки.
#
#        Использование регулярных выражений
b=`expr match "$a" '[0-9]*'`               #  Подсчет количества цифр.
echo Количество цифр с начала строки \"$a\" : $b.
b=`expr match "$a" '\([0-9]*\)'`           #  Обратите внимание на экранирование круглых скобок
#                   ==      ==
echo "Цифры, стоящие в начале строки \"$a\" : \"$b\"."

echo

exit 0


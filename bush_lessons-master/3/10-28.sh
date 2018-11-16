#!/bin/bash
# isalpha.sh: Использование "case" для анализа строк.

SUCCESS=0
FAILURE=-1

isalpha ()  # Проверка - является ли первый символ строки символом алфавита.
{
if [ -z "$1" ]                # Вызов функции без входного аргумента?
then
  return $FAILURE
fi

case "$1" in
[a-zA-Z]*) return $SUCCESS;;  # Первый символ - буква?
*        ) return $FAILURE;;
esac
}             # Сравните с функцией "isalpha ()" в языке C.


isalpha2 ()   # Проверка - состоит ли вся строка только из символов алфавита.
{
  [ $# -eq 1 ] || return $FAILURE

  case $1 in
  *[!a-zA-Z]*|"") return $FAILURE;;
               *) return $SUCCESS;;
  esac
}

isdigit ()    # Проверка - состоит ли вся строка только из цифр.
{             # Другими словами - является ли строка целым числом.
  [ $# -eq 1 ] || return $FAILURE

  case $1 in
  *[!0-9]*|"") return $FAILURE;;
            *) return $SUCCESS;;
  esac
}



check_var ()  # Интерфейс к isalpha
{
if isalpha "$@"
then
  echo "\"$*\" начинается с алфавитного символа."
  if isalpha2 "$@"
  then        # Дальнейшая проверка не имеет смысла, если первй символ не буква.
    echo "\"$*\" содержит только алфавитные символы."
  else
    echo "\"$*\" содержит по меньшей мере один не алфавитный символ."
  fi
else
  echo "\"$*\" начинается с не алфавитного символа ."
              #  Если функция вызвана без входного параметра,
              #+ то считается, что строка содержит "не алфавитной" символ.
fi

echo

}

digit_check ()  # Интерфейс к isdigit ().
{
if isdigit "$@"
then
  echo "\"$*\" содержит только цифры [0 - 9]."
else
  echo "\"$*\" содержит по меньшей мере один не цифровой символ."
fi

echo

}

a=23skidoo
b=H3llo
c=-What?
d=What?
e=`echo $b`   # Подстановка команды.
f=AbcDef
g=27234
h=27a34
i=27.34

check_var $a
check_var $b
check_var $c
check_var $d
check_var $e
check_var $f
check_var     # Вызов без параметра, что произойдет?
#
digit_check $g
digit_check $h
digit_check $i


exit 0        # Сценарий дополнен S.C.

# Упражнение:
# --------
#  Напишите функцию 'isfloat ()', которая проверяла бы вещественные числа.
#  Подсказка: Эта функция подобна функции 'isdigit ()',
#+ надо лишь добавить анализ наличия десятичной точки.


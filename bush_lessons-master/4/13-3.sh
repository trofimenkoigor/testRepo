#!/bin/bash
# keypress.sh: Определение нажатых клавиш.

echo

old_tty_settings=$(stty -g)   # Сохранить прежние настройки.
stty -icanon
Keypress=$(head -c1)          # или $(dd bs=1 count=1 2> /dev/null)
                              # для других, не GNU, систем

echo
echo "Была нажата клавиша \""$Keypress"\"."
echo

stty "$old_tty_settings"      # Восстановить прежние настройки.

# Спасибо, Stephane Chazelas.

exit 0


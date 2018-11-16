#!/bin/bash
# timeout.sh

# Автор: Stephane Chazelas,
# дополнен автором документа.

INTERVAL=5                # предел времени ожидания

timedout_read() {
  timeout=$1
  varname=$2
  old_tty_settings=`stty -g`
  stty -icanon min 0 time ${timeout}0
  eval read $varname      # или просто    read $varname
  stty "$old_tty_settings"
  # См. man stty.
}

echo; echo -n "Как Вас зовут? Отвечайте быстрее! "
timedout_read $INTERVAL your_name

# Такой прием может не работать на некоторых типах терминалов.
# Максимальное время ожидания зависит от терминала.
# (чаще всего это 25.5 секунд).

echo

if [ ! -z "$your_name" ]  # Если имя было введено...
then
  echo "Вас зовут $your_name."
else
  echo "Вы не успели ответить."
fi

echo

# Алгоритм работы этого сценария отличается от "timed-input.sh".
# Каждое нажатие на клавишу вызывает сброс счетчика в начальное состояние.

exit 0


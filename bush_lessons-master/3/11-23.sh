#!/bin/bash
# self-destruct.sh

kill $$  # Сценарий завершает себя сам.
         # Надеюсь вы еще не забыли, что "$$" -- это PID сценария.

echo "Эта строка никогда не будет выведена."
# Вместо него на stdout будет выведено сообщение "Terminated".

exit 0

#  Какой код завершения вернет сценарий?
#
# sh self-destruct.sh
# echo $?
# 143
#
# 143 = 128 + 15
#             сигнал TERM

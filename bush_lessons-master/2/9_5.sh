#!/bin/bash
# am-i-root.sh:   Root я, или не root?

ROOT_UID=0   # $UID root-а всегда равен 0.

if [ "$UID" -eq "$ROOT_UID" ]  # Настоящий "root"?
then
  echo "- root!"
else
  echo "простой пользователь (но мамочка вас тоже любит)!"
fi

exit 0


# ============================================================= #
#  Код, приведенный ниже, никогда не отработает,
#+ поскольку работа сценария уже завершилась выше

# Еще один способ отличить root-а от не root-а:

ROOTUSER_NAME=root

username=`id -nu`              # Или...   username=`whoami`
if [ "$username" = "$ROOTUSER_NAME" ]
then
  echo "Рутти-тутти. - root!"
else
  echo "Вы - лишь обычный юзер."
fi


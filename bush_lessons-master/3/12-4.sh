#!/bin/bash

# Создание временного файла мониторинга в текщем каталоге,
# куда переписываются несколько последних строк из /var/log/messages.

# Обратите внимание: если сценарий запускается обычным пользователем,
# то файл /var/log/messages должен быть доступен на чтение этому пользователю.
#         #root chmod 644 /var/log/messages

LINES=5

( date; uname -a ) >>logfile
# Время и информация о системе
echo --------------------------------------------------------------------- >>logfile
tail -$LINES /var/log/syslog | xargs |  fmt -s >>logfile
echo >>logfile
echo >>logfile

exit 0


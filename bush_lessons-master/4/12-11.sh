#!/bin/bash

filename=sys.log

cat /dev/null > $filename; echo "Создание / очистка временного файла."
#  Если файл отсутствует, то он создается,
#+ и очищается, если существует.
#  : > filename   и   > filename дают тот же эффект.

tail /var/log/syslog > $filename
# Файл /var/log/messages должен быть доступен для чтения.

echo "В файл $filename записаны последние строки из /var/log/messages."

exit 0


#!/bin/bash

echo $_              # /bin/bash
                     # Для запуска сценария был вызван /bin/bash.

du >/dev/null        # Подавление вывода.
echo $_              # du

ls -al >/dev/null    # Подавление вывода.
echo $_              # -al  (последний аргумент)

:
echo $_              # :


#!/bin/bash
# t-out.sh 

TIMELIMIT=4        # 4 секунды

read -t $TIMELIMIT variable <&1

echo

if [ -z "$variable" ]
then
  echo "Время ожидания истекло."
else
  echo "variable = $variable"
fi  

exit 0



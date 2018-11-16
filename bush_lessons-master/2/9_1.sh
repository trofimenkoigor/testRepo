#!/bin/bash
# При использовании $IFS, пробельные символы обрабатываются иначе, чем все остальные.

output_args_one_per_line()
{
  for arg
  do echo "[$arg]"
  done
}

echo; echo "IFS=\" \""
echo "-------"

IFS=" "
var=" a  b c   "
output_args_one_per_line $var  # output_args_one_per_line `echo " a  b c   "`
#
# [a]
# [b]
# [c]


echo; echo "IFS=:"
echo "-----"

IFS=:
var=":a::b:c:::"               # То же самое, только пробелы зменены символом ":".
output_args_one_per_line $var
#
# []
# [a]
# []
# [b]
# [c]
# []
# []
# []

# То же самое происходит и с разделителем полей "FS" в awk.

# Спасибо Stephane Chazelas.

echo

exit 0


import sys
symbol = sys.argv[1]
counter = 0
for i in symbol:
  if i == '(':
      counter += 1
  elif i == ')':
      counter -=1
      if counter < 0:
          print ("no")
      else:print ("yes")

#      symbol = symbol.replace("(", "")
#      a = len(symbol)
#  elif i in ")":
#      symbol = symbol.replace("(", "")
#      a = len(symbol)
#  if a > 0:
#       print "NO"
#  else:
#       print "YES"
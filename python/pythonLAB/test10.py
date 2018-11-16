import sys

coded_text = sys.argv[1].replace(' ','')

KEY = 'aaaaabbbbbabbbaabbababbaaababaab'
alphabet = 'abcdefghijklmnopqrstuvwxyz'
new_letter = ''
#coded_text = coded_text.replace(' ', '')
ab = ""
for letter in coded_text:
    if letter.islower():
        ab += 'a'
    else:
        ab += 'b'

d = len(ab)
for i in range(0, d, 5):
    part = ab[i:i + 5]
    if len(part) == 5:
        new_letter += alphabet[KEY.find(part)]

print (new_letter)


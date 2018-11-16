#import sys

def clean_list(l):
	output_list=[]
	for i in l:
		if i not in output_list:
			output_list.append(i)
	return(output_list)

def counter(x, y):
	x=str(x); y=str(y); con = 0
	for i in clean_list(y):
		if i in clean_list(x):
			con+=1
	return(con)

print (counter(1234, 143567))
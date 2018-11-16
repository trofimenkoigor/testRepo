N = int(input())
sum = 0
for i in range(1, N + 1):
    sum += i
for i in range(N - 1):
   sum -= int(input())
print(sum)
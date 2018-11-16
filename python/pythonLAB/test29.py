files = {}
for _ in range(int(input())):
    name, *operations = input().split()
    files[name] = operations
access = {'read':'R','write':'W','execute':'X'}
for _ in range(int(input())):
    acc,nam = input().split()
    print('OK' if access[acc] in files[nam] else 'Access denied')
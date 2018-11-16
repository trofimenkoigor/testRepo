size = int(input())

conceivedset = set(range(1, size + 1))

for guess_str in iter(input, 'HELP'):
    guess = set(int(e) for e in guess_str.split())

    no = conceivedset - guess
    yes = conceivedset & guess

    if len(no) < len(yes):
        print('YES')
        conceivedset = yes
    else:
        print('NO')
        conceivedset = no

print(' '.join(map(str, sorted(conceivedset))))
import sys


def file_search(folder, filename, a=''):
    a = str(folder[0])
    print(a)
    try:
        a += '/' + str(folder[folder.index(filename)])
    except:
        for i in folder:
            if type(i) == list:

                r = file_search(i, filename)
                if not r == False:
                    a += '/' + r
            else:
                continue

        if filename in a:
            return a
        return False
#print(file_search('/', ['Users'], ['igor'], 'test5.py'))
#print(file_search([ '/home', ['user1'], ['user2', ['my pictures'], ['desktop', 'not this', 'and not this', ['new folder', 'hereiam.py' ] ] ], 'work.ovpn', 'prometheus.7z', ['user3', ['temp'], ], 'hey.py'], 'hereiam.py'))

#!env python3

import webbrowser

def charposition(string, char):
    pos = []
    for n in range(len(string)):
        if string[n] == char:
            pos.append(n)
    return pos

with open("../files/init.vim", "r") as file:
    links = file.readlines()

ret = []

for el in links:
    if "call plug#end()" in el:
        break
    index = charposition(el, "'")
    if index != [] and index[0] != 0:
        ret += [el[index[0] + 1:index[1]]]

for el in ret:
    webbrowser.open("https://github.com/" + el, new=2)

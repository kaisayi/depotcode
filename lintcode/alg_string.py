
#! /home/liy/anaconda/bin/python/
# -*-coding : utf8 -*-

'''
roman char to integer
'''

import matplotlib.pyplot as plt
import numpy as np 


ROMANMAP = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000
}

def roman2int(rs):
    s = ROMANMAP[rs[-1]]
    for c in range(len(rs)-2, -1, -1):
        if ROMANMAP[rs[c]] >= ROMANMAP[rs[c+1]]:
            s += ROMANMAP[rs[c]]
        else:
            s -= ROMANMAP[rs[c]]
    return s

# 4 conditions
#   v < 4
#   v = 4
#   v > 4 && v < 9
#   v = 9

def int2roman(nm):
    charlist = ['M', 'D', 'C', 'L', 'X', 'V', 'I']
    result = ''
    for i in range(0, len(charlist), 2):
        dg = nm // ROMANMAP[charlist[i]]
        if dg < 4:
            result += dg * charlist[i]
        elif dg == 4:
            result = result + charlist[i] + charlist[i-1]
        elif (dg > 4) and (dg < 9):
            result = (dg-4) * charlist[i-1]
        else:
            result = result + charlist[i] + charlist[i-2]
        nm = nm % ROMANMAP[charlist[i]]
    return result


# length of last word 422
# Given s string of upper/lower-case alphabets and empty space characters ''
# return length of last word in the string

# input "hello world" return 5

def lastword_length(sent):
    flag = True
    i = 0
    c = len(sent)-1
    for c in range(len(sent)-1, -1, -1):
        if sent[c] is not ' ':
            flag = False
            i += 1
        if sent[c] is ' ' and not flag:
            break
    return i 



# space replacement
# replace all space in string with %20 , return new lenght after replacement

# input "Mr John Smith" length 13 

def space_replace(text):
    pass


# write a method to decide if two strings are anagrams or not
# strings are anagram if they can be the saem after change the order

# input s='abcd' t='cadb' return True

# sort method
def anagrams1(s, t):
    if len(s) != len(t):
        retunr False
    s.sort()
    t.sort()
    for i in range(len(s)):
        if s[i] != t[i]:
            return False
    return True

# map method
def anagrams2(s, t):
    letter_map = {}
    for e in s:
        letter_map[e] = letter_map.get(e, 0) + 1

    for e in t:
        if e not in letter_map:
            return False
        letter_map[e] -= 1

    return all([v == 0 for _, v in letter_map.items()])

        



tests = ['IV', 'XII', 'XXI', 'XCIX']
nums = [213, 44, 52, 31]
results = [int2roman(s) for s in nums]
    # plt.scatter(np.arange(4), results, c='r')
    # plt.show()
print(results)

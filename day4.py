# http://adventofcode.com/2016/day/4

from collections import Counter

lookup = {
    "a" : 0,
    "b" : 1,
    "c" : 2,
    "d" : 3,
    "e" : 4,
    "f" : 5,
    "g" : 6,
    "h" : 7,
    "i" : 8,
    "j" : 9,
    "k" : 10,
    "l" : 11,
    "m" : 12,
    "n" : 13,
    "o" : 14,
    "p" : 15,
    "q" : 16,
    "r" : 17,
    "s" : 18,
    "t" : 19,
    "u" : 20,
    "v" : 21,
    "w" : 22,
    "x" : 23,
    "y" : 24,
    "z" : 25
}

revlookup = {
    0 : "a",
    1 : "b",
    2 : "c",
    3 : "d",
    4 : "e",
    5 : "f",
    6 : "g",
    7 : "h",
    8 : "i",
    9 : "j",
    10 : "k",
    11 : "l",
    12 : "m",
    13 : "n",
    14 : "o",
    15 : "p",
    16 : "q",
    17 : "r",
    18 : "s",
    19 : "t",
    20 : "u",
    21 : "v",
    22 : "w",
    23 : "x",
    24 : "y",
    25 : "z"
}

def isletter(c):
    return True if c in ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z') else False 

def room(x):
    sectorid = x.split("-")[-1]
    letters = {k:v for k,v in Counter(sorted(x)).most_common() if isletter(k)}
    checksum = "".join(letters)[:5]
    return checksum, int(sectorid)

def roomAndChecksum(x):
    x = x.strip()
    i = x.find("[")
    return x[:i],x[i+1:-1]

def calculateTotal(f):
    total = 0
    for line in open(f):
        (roomstring,checksum) = roomAndChecksum(line)
        (roomchecksum,sectorid) = room(roomstring)
        if roomchecksum == checksum : total += sectorid
    return total

def decrypt(f):
    for line in open(f):
        (roomstring,checksum) = roomAndChecksum(line)
        (roomchecksum,sectorid) = room(roomstring)
        if roomchecksum == checksum : print(decryptRoom(roomstring))

def decryptRoom(x):
    rot = int(x.split("-")[-1])
    sentence = ""
    for word in x.split("-")[:-1]:
        w = "".join([rotate(c,rot) for c in word])
        sentence += " " + w
    return sentence.strip(), rot

def rotate(c,r):
    key = lookup[c]
    key += r
    key = key % 26
    return revlookup[key]
    



assert room("aaaaa-bbb-z-y-x-123") == ("abxyz", 123)
assert room("aaaaa-bbb-y-z-x-123") == ("abxyz", 123)
assert room("a-b-c-d-e-f-g-h-987") == ("abcde", 987)
assert room("not-a-real-room-404") == ("oarel", 404)

assert roomAndChecksum("aaaaa-bbb-z-y-x-123[abxyz]") == ("aaaaa-bbb-z-y-x-123","abxyz")

assert calculateTotal("day4-test") == 1514
print (calculateTotal("day4-input"))

assert rotate("q",343) == "v"
assert decryptRoom("qzmt-zixmtkozy-ivhz-343") == ("very encrypted name",343)

decrypt("day4-input")

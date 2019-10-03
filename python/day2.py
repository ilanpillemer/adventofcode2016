# http://adventofcode.com/2016/day/2
# 1 2 3
# 4 5 6
# 7 8 9

#     1
#   2 3 4
# 5 6 7 8 9
#   A B C
#     D

# ULL
# RRDDD
# LURDL
# UUUUD

class Keypad():

    lookup = {
            1 : "1",
            2 : "2",
            3 : "3",
            4 : "4",
            5 : "5",
            6 : "6",
            7 : "7",
            8 : "8",
            9 : "9",
            10 : "A",
            11 : "B",
            12 : "C",
            13 : "D"
        }

    code = ""
    
    def __init__(self,curr):
        self.curr = curr


    def move(self,d):
        if d == "U":
            if self.curr > 3 : self.curr = self.curr - 3
        elif d == "D":
            if self.curr < 7 : self.curr = self.curr + 3
        elif d == "L":
            if self.curr not in (1,4,7): self.curr = self.curr - 1
        elif d == "R":
            if self.curr not in (3,6,9): self.curr = self.curr + 1

    def move2(self,d):
        if d == "U":
            if self.curr in (6,7,8,10,11,12): self.curr = self.curr - 4
            elif self.curr in (3,13): self.curr = self.curr = self.curr - 2
        if d == "D":
            if self.curr in (2,3,4,6,7,8): self.curr = self.curr + 4
            elif self.curr in (11,1): self.curr = self.curr = self.curr + 2
        if d == "L":
            if self.curr in (3,4,6,7,8,9,11,12): self.curr = self.curr - 1
        if d == "R":
            if self.curr in (2,3,5,6,7,8,10,11): self.curr = self.curr + 1
        

    def incCode(self): self.code = self.code + self.lookup[self.curr]

    def determineLine(self,line,f):
        for c in line: f(c)
        self.incCode()

    def determineCode(self,f,func):
        for line in open(f): self.determineLine(line.strip(),func)
                
            
keypad = Keypad(5)
keypad.determineCode("day2-test",keypad.move)
print(keypad.code)

keypad2 = Keypad(5)
keypad2.determineCode("day2-input",keypad2.move)
print(keypad2.code)

keypad3 = Keypad(5)
keypad3.determineCode("day2-test",keypad3.move2)
print(keypad3.code)

keypad4 = Keypad(5)
keypad4.determineCode("day2-input",keypad4.move2)
print(keypad4.code)

    

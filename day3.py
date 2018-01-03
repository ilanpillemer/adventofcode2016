# http://adventofcode.com/2016/day/3

def valid(a,b,c):
    [a,b,c] = sorted([a,b,c])
    return True if (a + b) > c else False

def howManyValid(f):
    count = 0
    for line in open(f):
        numbers = line.split()
        a,b,c = int(numbers[0]),int(numbers[1]),int(numbers[2])
        if valid(a,b,c) : count = count + 1
    print("valid row wise triangles:{}".format(count))

def howManyValidColumnWise(f):
    count = 0
    line_no = 1
    for line in open(f):
        numbers = line.split()
        a,b,c = int(numbers[0]),int(numbers[1]),int(numbers[2])
        if line_no == 1 : a1,b1,c1 = a,b,c
        elif line_no == 2: a2,b2,c2 = a,b,c
        elif line_no == 3: a3,b3,c3 = a,b,c

        if line_no == 3:
            line_no = 0
            if valid(a1,a2,a3): count += 1
            if valid(b1,b2,b3): count += 1
            if valid(c1,c2,c3): count += 1
        line_no += 1
    print("valid column wise triangles:{}".format(count))


howManyValid("day3-input")
howManyValidColumnWise("day3-input")



class Taxi():
    locations = dict()
    def __init__(self,d,x,y):
        self.d = "N"
        self.x = x
        self.y = y
        self.locations[x,y]=True

    def update_direction(self,change):
        if change == "R":
            if self.d == "N":
                self.d = "E"
            elif self.d == "E":
                self.d = "S"
            elif self.d == "S":
                self.d = "W"
            elif self.d == "W":
                self.d = "N"
        elif change == "L":
            if self.d == "N":
                self.d = "W"
            elif self.d == "W":
                self.d = "S"
            elif self.d == "S":
                self.d = "E"
            elif self.d == "E":
                self.d = "N"

    def update_coord(self,z):
        if self.d == "N":
            for i in range(self.y+1,self.y+z):
                if (self.x,i) in self.locations : print ("second time at ({},{}) at distance {}".format(self.x,i,abs(self.x) + abs(i)))
                self.locations[self.x,i] = True
            self.y = self.y + z
        elif self.d == "E":
            for i in range(self.x+1,self.x+z):
                if (i,self.y) in self.locations : print ("second time at ({},{}) at distance {}".format(i,self.y,abs(i) + abs(self.y)))
                self.locations[i,self.y] = True
            self.x = self.x + z
        elif self.d == "S":
            for i in range(self.y-z+1,self.y):
                if (self.x,i) in self.locations : print ("second time at ({},{}) at distance {}".format(self.x,i,abs(self.x) + abs(i)))
                self.locations[self.x,i] = True
            self.y = self.y - z
        elif self.d == "W":
            for i in range(self.x-z+1,self.x):
                if (i,self.y) in self.locations : print ("second time at ({},{}) at distance {}".format(i,self.y,abs(i) + abs(self.y)))
                self.locations[i,self.y] = True
            self.x = self.x - z

    def distance(self): return abs(self.x) + abs(self.y)

    def apply(self,instr):
        direction = instr[0]
        self.update_direction(direction)
        steps = int(instr[1:])
        self.update_coord(steps)

    def receive_instructions(self, f):
        t1 = open(f)
        for line in t1.readlines():
            for instr in line.split(","):
                self.apply(instr.strip())

        

# Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
# R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
# R5, L5, R5, R3 leaves you 12 blocks away.
        
# taxi = Taxi("N",0,0)
# taxi.receive_instructions("test1")
# print("distance is {} for test 1".format(taxi.distance()))

# taxi2 = Taxi("N",0,0)
# taxi2.receive_instructions("test2")
# print("distance is {} for test 2".format(taxi2.distance()))

# taxi3 = Taxi("N",0,0)
# taxi3.receive_instructions("test3")
# print("distance is {} for test 3".format(taxi3.distance()))

# taxi4 = Taxi("N",0,0)
# taxi4.receive_instructions("test4")
# # taxi4.receive_instructions("test4")
# print("distance is {} for test 4".format(taxi4.distance()))


input1 = Taxi("N",0,0)
input1.receive_instructions("day1-input-1")
print("distance is {} for input part 1".format(input1.distance()))

        





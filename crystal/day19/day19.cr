puts "day 19"

module Party
  class Elf
    property presents : Int32
    property prev : Elf
    property next : Elf
    property id : Int32

    def initialize(@id, @presents, @prev = self, @next = self)
    end

    def hop(count)
      opp = self.dup
      1.upto(count) do
        opp = opp.next
      end
      opp
    end
  end

  def self.setup(num)
    elves = {} of Int32 => Elf
    1.upto(num) do |i|
      elves[i] = Elf.new(i, 1)
    end
    1.upto(num) do |i|
      if i == 1
        elves[i].prev = elves[num]
        elves[i].next = elves[i + 1]
        next
      end
      if i == num
        elves[i].prev = elves[i - 1]
        elves[i].next = elves[1]
        next
      end
      elves[i].prev = elves[i - 1]
      elves[i].next = elves[i + 1]
    end
    elves[1]
  end

  def self.play(elf : Elf)
    until elf.next.id == elf.id
      elf.next = elf.next.next
      elf = elf.next
    end
    elf
  end

  def self.play2(elf : Elf, total : Int32)
    until elf.next.id == elf.id
      opp = elf.hop(total//2)
      total -= 1
      opp.prev.next = opp.next
      opp.next.prev = opp.prev
      elf = elf.next
      exit if total == 0
    end
    elf
  end
end

puts "part 1"
# pp Party.play(Party.setup(5)).id
# pp Party.play(Party.setup(3005290)).id

puts "part 2"

2.upto(100) do |i|
  printf("%d \t->\t %d\n", i, Party.play2(Party.setup(i), i).id)
end
# pp Party.play2(Party.setup(3005290), 3005290).id
# cycle repeats 3^a + 1

pp 3005290 - 1594323

puts "day 19"

module Party
  class Elf
    property presents : Int32
    property prev : Elf
    property next : Elf
    property id : Int32

    def initialize(@id, @presents, @prev = self, @next = self)
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

  def self.play(e : Elf)
    elf = e
    until elf.next.id == elf.id
      elf.next = elf.next.next
      elf = elf.next
    end
    elf
  end
end

pp Party.play(Party.setup(5)).id
puts "part 1"
pp Party.play(Party.setup(3005290)).id

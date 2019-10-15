def real(l)
  room, id, checksum = l.partition(/\d\d\d/)
  checksum.delete("[]") == room.delete('-')
    .each_char
    .tally
    .to_a
    .sort_by { |x| [-x[1], x[0]] }
    .map(&.first).join[0...5] ? id.to_i : 0
end

struct Char
  def <=>(other : Int32)
    self.to_i <=> other
  end
end

struct Int32
  def >(other : Char)
    self > other.to_i
  end

  def <(other : Char)
    self < other.to_i
  end
end

count = STDIN
  .each_line
  .sum(&->real(String))

puts "Advent of Code 2016, Day 4"

puts "part 1 => #{count} is the sum of sector IDs of the real rooms"

class Disc
  property total, offset

  def initialize(@total : Int32, @offset : Int32)
  end

  def open?(t)
    current = offset + t
    (current % total).zero?
  end
end

discs = [] of Disc
# discs << Disc.new(5, 4)
# discs << Disc.new(2, 1)

discs << Disc.new(13, 10) # Disc #1 has  positions; at time=0, it is at position .
discs << Disc.new(17, 15) # Disc #2 has  positions; at time=0, it is at position .
discs << Disc.new(19, 17) # Disc #3 has  positions; at time=0, it is at position .
discs << Disc.new(7, 1)   # Disc #4 has  positions; at time=0, it is at position .
discs << Disc.new(5, 0)   # Disc #5 has  positions; at time=0, it is at position .
discs << Disc.new(3, 1)   # Disc #6 has  positions; at time=0, it is at position .

pp discs
t = 0
solved = false
until solved
  solved = true
  s = t
  discs.each do |d|
    s += 1
    solved = false if !d.open?(s)
  end
  t += 1 if !solved
end

pp t

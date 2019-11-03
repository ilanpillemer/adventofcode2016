module G
  def self.next(g)
    n = Array(Symbol).new(g.size, :safe)
    0.upto(g.size - 1) do |i|
      n[i] = trap?(g, i)
    end
    n
  end

  def self.trap?(g, i)
    l = :trap if i != 0 && g[i - 1] == :trap
    c = :trap if g[i] == :trap
    r = :trap if i != g.size - 1 && g[i + 1] == :trap

    return :trap if l == :trap && c == :trap && r != :trap
    return :trap if c == :trap && r == :trap && l != :trap
    return :trap if l == :trap && c != :trap && r != :trap
    return :trap if r == :trap && c != :trap && l != :trap
    :safe
  end

  def self.to_s(g : Array(Symbol))
    s = ""
    g.each do |c|
      if c == :trap
        s += "^"
      else
        s += "."
      end
    end
    s
  end
end

class String
  def to_g
    g = [] of Symbol
    self.each_char do |c|
      if c == '^'
        g << :trap
      else
        g << :safe
      end
    end
    g
  end
end

current = "..^^.".to_g
pp G.to_s(current)
1.upto(2) do
  current = G.next(current)
  pp G.to_s(current)
end

total = 0
current = ".^^.^.^^^^".to_g
total += current.count(&.==(:safe))
pp G.to_s(current)
1.upto(9) do
  current = G.next(current)
  pp G.to_s(current)
  total += current.count(&.==(:safe))
end
pp total

puts "part1"

total = 0
current = ".^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^.......^..^^...^.^.^^..^^^^^...^.".to_g
total += current.count(&.==(:safe))
pp G.to_s(current)
1.upto(39) do
  current = G.next(current)
  pp G.to_s(current)
  total += current.count(&.==(:safe))
end
pp total

puts "part2"
total = 0
current = ".^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^.......^..^^...^.^.^^..^^^^^...^.".to_g
total += current.count(&.==(:safe))
# pp G.to_s(current)
1.upto(400000 - 1) do
  current = G.next(current)
  #  pp G.to_s(current)
  total += current.count(&.==(:safe))
end
pp total

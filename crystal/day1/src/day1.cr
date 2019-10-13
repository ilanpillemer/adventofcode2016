# TODO: Write documentation for `Day1`
module Day1
  @@seen = {} of {Int32, Int32} => Int32
  @@solved = false

  def self.output(str)
    if !@@solved
      puts(str)
    end
    @@solved = true
  end

  def self.order(i, j)
    if i < j
      return i, j
    else
      return j, i
    end
  end

  def self.go(d, a : Int32, x, y)
    olx, oly = x, y

    case d
    when "N"
      y += a
      ly, uy = order(oly, y)
      (ly + 1...uy).each do |ay|
        output("part2 :: #{x},#{ay} => #{x.abs + ay.abs}") if @@seen.has_key?({x, ay})
        @@seen[{x, ay}] = x.abs + ay.abs
      end
    when "S"
      y -= a
      ly, uy = order(oly, y)
      (ly + 1...uy).each do |ay|
        output("part2 :: #{x},#{ay} => #{x.abs + ay.abs}") if @@seen.has_key?({x, ay})
        @@seen[{x, ay}] = x.abs + ay.abs
      end
    when "W"
      x -= a
      lx, ux = order(olx, x)
      (lx + 1...ux).each do |ax|
        output("part2 :: #{ax},#{y} => #{ax.abs + y.abs}") if @@seen.has_key?({ax, y})
        @@seen[{ax, y}] = ax.abs + y.abs
      end
    when "E"
      x += a
      lx, ux = order(olx, x)
      (lx + 1...ux).each do |ax|
        output("part2 :: #{ax},#{y} => #{ax.abs + y.abs}") if @@seen.has_key?({ax, y})
        @@seen[{ax, y}] = ax.abs + y.abs
      end
    end

    return x, y
  end

  n = gets(",", chomp = true).strip
  x, y = 0, 0
  d = "N"
  while n != nil
    turn, amt = n[0].to_s.not_nil!, n[1..].to_i.not_nil!
    d = d.turn(turn).not_nil!
    x, y = go(d, amt, x, y)
    n = gets(",", chomp = true).strip
  end
  result = "part1 :: #{x.abs},#{y.abs} => #{x.abs + y.abs}"
  puts(result)
end

class String
  def turn(d)
    case d
    when "R"
      case self
      when "N"
        "E"
      when "E"
        "S"
      when "S"
        "W"
      when "W"
        "N"
      end
    when "L"
      case self
      when "N"
        "W"
      when "W"
        "S"
      when "S"
        "E"
      when "E"
        "N"
      end
    end
  end
end

struct Nil
  def strip
    self
  end

  def [](n)
    self
  end

  def to_i
    self
  end
end

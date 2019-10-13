# TODO: Write documentation for `Day1`
module Day1
  def self.go(d, a : Int32, x, y)
    case d
    when "N"
      y += a
    when "S"
      y -= a
    when "W"
      x -= a
    when "E"
      x += a
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

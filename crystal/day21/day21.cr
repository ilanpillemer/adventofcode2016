puts "Day 21"

class Scrambler
  property input : Array(Char)

  def initialize(@input)
  end

  def swap(x, y)
    case {x, y}
    when {Int32, Int32}
      self.input.swap(x, y)
    when {Char, Char}
      input.each_with_index do |c, i|
        input[i] = x if c == y
        input[i] = y if c == x
      end
    else raise Exception.new("oh no")
    end
  end

  def rotate(x)
    i = input.index(x).not_nil!
    r = i + 1
    r += 1 if i >= 4
    input.rotate!(-r)
  end

  def rotate(d, i)
    i = -i if d == :right
    input.rotate!(i)
  end

  def reverse(x, y)
    temp = input[x..y]
    temp.reverse!
    input[x..y] = temp
  end

  def move(x, y)
    c = input.delete_at(x)
    input.insert(y, c)
  end
end

s = Scrambler.new(['a', 'b', 'c', 'd', 'e'])
s.swap(4, 0)
pp s.input
s.swap('d', 'b')
pp s.input
s.reverse(0, 4)
pp s.input

s.rotate(:left, 1)
pp s.input

s.move(1, 4)
pp s.input

s.move(3, 0)
pp s.input

s.rotate('b')
pp s.input

s.rotate('d')
pp s.input

part1 = Scrambler.new(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
STDIN.each_line do |l|
  case
  when /^rotate (left|right) (\d+) steps/ =~ l
    part1.rotate(:left, $2.to_i) if $1 == "left"
    part1.rotate(:right, $2.to_i) if $1 == "right"
  when /swap letter (.) with letter (.)/ =~ l
    part1.swap($1.char_at(0), $2.char_at(0))
  when /move position (\d+) to position (\d+)/ =~ l
    part1.move($1.to_i, $2.to_i)
  when /swap position (\d+) with position (\d+)/ =~ l
    part1.swap($1.to_i, $2.to_i)
  when /reverse positions (\d+) through (\d+)/ =~ l
    part1.reverse($1.to_i, $2.to_i)
  when /rotate based on position of letter (.)/ =~ l
    part1.rotate($1.char_at(0))
  when /rotate right (\d+) step/ =~ l
    part1.rotate(:right, $1.to_i)
  else
    pp l
  end
end

pp part1.input.join

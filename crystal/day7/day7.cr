module G
  class_property mode = Mode::A
  class_property a = [] of Char
  class_property b = [] of Char
end

enum Mode
  A
  B
end

def valid(l)
  G.mode = Mode::A

  l.each_char do |c|
    case c
    when '['
      G.mode = Mode::B
      G.b << ' '
      next
    when ']'
      G.mode = Mode::A
      G.a << ' '
      next
    end

    if G.mode == Mode::A
      G.a << c
    else
      G.b << c
    end
  end
  abba(G.a) && !abba(G.b)
end

def abba(s)
  first = s.join.match(/(.)(.)\2\1/)
  first && $1 != $2
end

count = STDIN.each_line.count do |l|
  G.a.clear
  G.b.clear
  valid(l)
end

puts "part 1: #{count} IPs support TLS"

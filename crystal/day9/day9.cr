output = [] of Char
input = STDIN.gets_to_end

def parse(input, output, i)
  e = input.index(')', i).not_nil!
  instr = input[(i + 1)...e]
  puts instr
  l, _, r = instr.partition 'x'
  str = input[(e + 1)...(e + 1 + l.to_i)]
  str *= r.to_i
  puts "#{l} #{str} #{r}"
  output.concat str.chars
  e + 1 + l.to_i
end

i = 0
until i >= (input.size) - 1
  case input[i]
  when '('
    e = parse(input, output, i)
    puts e
    i = e
    next
  else
    output << input[i]
  end
  i += 1
end
puts output.join
puts output.join.chomp.size

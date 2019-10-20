# influenced by https://github.com/asterite/adventofcode2016/blob/master/crystal/9/
require "string_scanner"

def decom(in)
  s = StringScanner.new(in)
  size : UInt64 = 0
  while !s.eos?
    case s
    when .scan(/\((\d+)x(\d+)\)/)
      num_letters = s[1].to_i
      multiple = s[2].to_i
      chunk = in[s.offset, num_letters]
      size += decom(chunk) * multiple
      s.offset += num_letters
    else
      s.offset += 1
      size += 1
    end
  end
  size
end

input = STDIN.gets_to_end.chomp
size = decom(input)
puts "the size decompressed is #{size}"

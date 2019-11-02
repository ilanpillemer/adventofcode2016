require "bit_array"

struct D
  def extend(a : String, l)
    #    ba = BitArray.new(a.size)
    #    a.chars.each_with_index { |d, i| ba[i] = (d == '1') }
    ba = a.to_ba
    until ba.size >= l
      ba = self.extend(ba)
    end
    ba[0, l]
  end

  def extend(ba : BitArray)
    ab = ba.dup
    ba.each_with_index { |d, i| ab[i] = d }
    e = BitArray.new(ab.size + ba.size + 1)
    i = 0
    ab.each do |d|
      e[i] = d
      i += 1
    end
    e[i] = false
    i += 1
    ba.reverse_each do |d|
      e[i] = !d
      i += 1
    end
    e
  end

  def csum(ba : BitArray)
    cs = BitArray.new(ba.size//2)
    i = 0
    good = false
    until good
      ba.in_groups_of(2) do |g|
        #        pp g
        cs[i] = (g[0] == g[1])
        i += 1
      end

      good = (cs.size.odd?)
      if !good
        ba = cs
        cs = BitArray.new(ba.size//2)
        i = 0
      end
    end
    cs
  end
end

class String
  def to_ba
    ba = BitArray.new(size)
    chars.each_with_index { |d, i| ba[i] = (d == '1') }
    ba
  end
end

# 1 becomes 100.
# 0 becomes 001.
# 11111 becomes 11111000000.
# 111100001010 becomes 1111000010100101011110000

d = D.new

puts "extend tests"
pp d.extend("1", 20)
pp d.extend("0", 20)
pp d.extend("11111", 20)
pp d.extend("111100001010", 20)
puts "checksum tests"
pp d.csum("110010110100".to_ba)
puts "complete test"

# Because 10000 is too short, we first use the modified dragon curve to make it longer.
# After one round, it becomes 10000011110 (11 characters), still too short.
# After two rounds, it becomes 10000011110010000111110 (23 characters), which is enough.
# Since we only need 20, but we have 23, we get rid of all but the first 20 characters:.
# Next, we start calculating the checksum; after one round, we have 0111110101, which 10 characters long (even), so we continue.
# After two rounds, we have 01100, which is 5 characters long (odd), so we are done.
# In this example, the correct checksum would therefore be 01100

pp d.csum(d.extend("10000", 20))

pp "part 1"
pp d.csum(d.extend("10011111011011001", 272))

pp "part 2"
pp d.csum(d.extend("10011111011011001", 35651584))

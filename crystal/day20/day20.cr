# pp "day20"

max = 0_u32
count = 0_u32
STDIN.each_line do |l|
  ends = l.split("-")
  next if ends[1].to_u32 < max
  ends[0].to_u32.upto(ends[1].to_u32) do |i|
    if i > max
      max = i
      count += 1
    end
  end
end

puts "one pass!"
puts UInt32::MAX
puts count
puts max
puts UInt32::MAX - count

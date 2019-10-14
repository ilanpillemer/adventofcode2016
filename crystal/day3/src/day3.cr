def valid(arr : Array(Int32))
  arr.each_permutation do |i|
    return false if i[0] + i[1] <= i[2]
  end
  true
end

puts "Advent of Code 2016, Day 3"
count = STDIN.each_line.count do |line|
  valid(line.split.map(&.to_i))
end

puts("part1 => #{count} valid triangles")

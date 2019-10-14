def valid(arr : Array(Int32))
  arr.each_permutation do |i|
    return false if i[0] + i[1] <= i[2]
  end
  true
end

count = STDIN.gets_to_end
  .split
  .map(&.to_i)
  .in_groups_of(3, 0)
  .transpose
  .sum(&.in_groups_of(3, 0)
    .count(&->valid(Array(Int32))))

puts("part2 => #{count} valid triangles")

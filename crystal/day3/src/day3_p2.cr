def valid(arr : Array(Int32))
  arr.each_permutation do |i|
    return false if i[0] + i[1] <= i[2]
  end
  true
end

count = 0

tr = STDIN.gets_to_end.split.map(&.to_i).in_groups_of(3, 0).transpose
tr.each do |a|
  count += a.in_groups_of(3, 0).count do |t|
    valid(t)
  end
end
# puts(tr)

puts("part2 => #{count} valid triangles")

def valid(arr : Array(Int32))
  arr.each_permutation do |i|
    return false if i[0] + i[1] <= i[2]
  end
  true
end

count = 0
t1 = [] of Int32
t2 = [] of Int32
t3 = [] of Int32

STDIN.each_line do |l|
  arr = l.split.map(&.to_i)
  t1 << arr[0]
  t2 << arr[1]
  t3 << arr[2]
end

count += t1.in_groups_of(3, 0).count do |a|
  valid(a)
end

count += t2.in_groups_of(3, 0).count do |a|
  valid(a)
end

count += t3.in_groups_of(3, 0).count do |a|
  valid(a)
end

puts("part2 => #{count} valid triangles")

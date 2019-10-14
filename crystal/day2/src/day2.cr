# TODO: Write documentation for `Day2`

puts "advent of code 2016, day 2 - bathroom troubles"

num = 5

print("bathroom code : ")
STDIN.each_line do |l|
  l.each_char do |c|
    num = num.go(c)
  end
  print(num)
end
puts()

class String
  def go(s)
    return MOVES2["#{self}#{s}"]
  end
end

struct Int
  def go(s)
    return MOVES2["#{self}#{s}"]
  end
end

# use MOVES for part 1 and MOVES2 for part 2

# part 1
# 1 2 3
# 4 5 6
# 7 8 9
MOVES = {
  "3L" => 2, "6L" => 5, "9L" => 8,
  "2L" => 1, "5L" => 4, "8L" => 7,
  "1L" => 1, "4L" => 4, "7L" => 7,

  "3R" => 3, "6R" => 6, "9R" => 9,
  "2R" => 3, "5R" => 6, "8R" => 9,
  "1R" => 2, "4R" => 5, "7R" => 8,

  "3U" => 3, "6U" => 3, "9U" => 6,
  "2U" => 2, "5U" => 2, "8U" => 5,
  "1U" => 1, "4U" => 1, "7U" => 4,

  "3D" => 6, "6D" => 9, "9D" => 9,
  "2D" => 5, "5D" => 8, "8D" => 8,
  "1D" => 4, "4D" => 7, "7D" => 7,
}

# part 2
#     1
#   2 3 4
# 5 6 7 8 9
#   A B C
#     D

MOVES2 = {
  "3L" => 2, "6L" => 5, "9L" => 8,
  "2L" => 2, "5L" => 5, "8L" => 7,
  "1L" => 1, "4L" => 3, "7L" => 6,
  "AL" => "A", "BL" => "A", "CL" => "B",
  "DL" => "D",

  "3R" => 4, "6R" => 7, "9R" => 9,
  "2R" => 3, "5R" => 6, "8R" => 9,
  "1R" => 1, "4R" => 4, "7R" => 8,
  "AR" => "B", "BR" => "C", "CR" => "C",
  "DR" => "D",

  "3U" => 1, "6U" => 2, "9U" => 9,
  "2U" => 2, "5U" => 5, "8U" => 4,
  "1U" => 1, "4U" => 4, "7U" => 3,
  "AU" => 6, "BU" => 7, "CU" => 8,
  "DU" => "B",

  "3D" => 7, "6D" => "A", "9D" => 9,
  "2D" => 6, "5D" => 5, "8D" => "C",
  "1D" => 3, "4D" => 8, "7D" => "B",
  "AD" => "A", "BD" => "D", "CD" => "C",
  "DD" => "D",
}

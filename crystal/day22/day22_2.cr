puts "day 22"

class Node
  property id, x, y, used, avail

  def initialize(@id : String, @x : Int32, @y : Int32, @used : Int32, @avail : Int32)
  end
end

nodes = Set(Node).new

STDIN.each_line do |l|
  if /.*node-x(\d+)-y(\d+) *(\d+)T *(\d+)T *(\d+)T/ =~ l
    nodes.add(Node.new($1 + $2, $1.to_i, $2.to_i, $4.to_i, $5.to_i))
  else
    pp l
  end
end

record Point, x : Int32, y : Int32
grid = {} of Point => Symbol
nodes.each do |n|
  if n.used == 0
    grid[Point.new(n.x, n.y)] = :empty
    next
  end
  if n.used < 75
    grid[Point.new(n.x, n.y)] = :space
  else
    grid[Point.new(n.x, n.y)] = :blocked
  end
end
grid[Point.new(33, 0)] = :goal
0.upto(30) do |y|
  0.upto(33) do |x|
    print("-") if grid[Point.new(x, y)] == :space
    print("#") if grid[Point.new(x, y)] == :blocked
    print("G") if grid[Point.new(x, y)] == :goal
    print("X") if grid[Point.new(x, y)] == :empty
  end
  puts
end

pp 70 + (32 * 5) #  hand solved from grid

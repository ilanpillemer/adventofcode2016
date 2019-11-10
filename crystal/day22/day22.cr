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

count = 0
nodes.to_a.each_permutation(2) do |c|
  a = c.first
  b = c.last
  if a.used != 0 && a.id != b.id && a.used <= b.avail
    #    puts "#{a} <> #{b}"
    count += 1
  end
end

pp count

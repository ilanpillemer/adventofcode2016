puts "day24"

record Point, x : Int32, y : Int32

map = Hash(Point, Char).new
starts = Hash(Char, Point).new
y = 0
STDIN.each_line do |l|
  l.each_char_with_index do |c, x|
    map[Point.new(x, y)] = c
    starts[c] = Point.new(x, y)
  end
  y += 1
end

routes = Array(Array(Char)).new
['1', '2', '3', '4', '5', '6', '7'].permutations.each do |p|
  routes << p.unshift('0')
end

class Tree
  property p : Point
  property parent : Tree?

  def initialize(@p, @parent = nil)
  end
end

def steps(p : Point, map)
  legal = [] of Point
  legal << Point.new(p.x, p.y - 1) if map[Point.new(p.x, p.y - 1)] != '#'
  legal << Point.new(p.x, p.y + 1) if map[Point.new(p.x, p.y + 1)] != '#'
  legal << Point.new(p.x - 1, p.y) if map[Point.new(p.x - 1, p.y)] != '#'
  legal << Point.new(p.x + 1, p.y) if map[Point.new(p.x + 1, p.y)] != '#'
  legal
end

def height(t : Tree)
  h = 0
  until !t
    t = t.parent
    h += 1 if t
  end
  h
end

def search(p1 : Point, p2 : Point, map)
  seen = Set(Point).new
  q = Deque(Tree).new
  seen << p1
  q << Tree.new(p1)
  while q.size != 0
    n = q.shift
    if n.p == p2
      return height(n)
    end

    edges = steps(n.p, map)
    edges.each do |e|
      if !seen.includes?(e)
        seen << e
        q << Tree.new(e, n)
      end
    end
  end
end

puts "searching"
pp starts

# pp starts['4']
# pp starts['1']
# pp search(starts['4'], starts['1'], map)

def cost(r : Array(Char), map, starts)
  total = 0
  n = r[1..-1]
  paths = r.zip? n
  paths.each do |p|
    if p.last
      #      printf("%d -> %d \n", p.first, p.last)
      total += search(starts[p.first], starts[p.last.not_nil!], map).not_nil!
    end
  end
  return total
end

bestr = routes[0]
bestn = 2147483647
routes.each do |r|
  c = cost(r, map, starts)
  if c < bestn
    bestn = c
    bestr = r
  end
  #  printf("%s -> %s \n", r, cost(r, map, starts))
end
pp bestr
pp bestn

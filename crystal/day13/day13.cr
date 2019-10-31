puts "hello"

# 1  procedure BFS(G,start_v):
# 2      let Q be a queue
# 3      label start_v as discovered
# 4      Q.enqueue(start_v)
# 5      while Q is not empty
# 6          v = Q.dequeue()
# 7          if v is the goal:
# 8              return v
# 9          for all edges from v to w in G.adjacentEdges(v) do
# 10             if w is not labeled as discovered:
# 11                 label w as discovered
# 12                 w.parent = v
# 13                 Q.enqueue(w)

class Maze
  class Route
    property point : Point
    property parent : Route | Nil = nil

    def initialize(@point, @parent = nil)
    end
  end

  record Point, x : Int32, y : Int32
  @grid = {} of Point => Symbol

  def initialize(@fav : Int32)
  end

  def value(p : Point)
    @grid[p] = d(p.x, p.y) if !@grid.has_key?(p)
    @grid[p]
  end

  def d(x, y)
    f = x*x + 3*x + 2*x*y + y + y*y
    f += @fav
    i = f.popcount

    if (i % 2).zero?
      return :open
    else
      return :wall
    end
  end

  def to_s(io)
    0.upto(10) do |y|
      0.upto(10) do |x|
        print value(Point.new(x, y)) == :open ? "." : "#"
      end
      puts
    end
  end

  def edges(p : Point)
    ps = [] of Route
    ps << Route.new(Point.new p.x + 1, p.y) if value(Point.new p.x + 1, p.y) == :open
    ps << Route.new(Point.new p.x - 1, p.y) if value(Point.new p.x - 1, p.y) == :open && p.x - 1 > -1
    ps << Route.new(Point.new p.x, p.y + 1) if value(Point.new p.x, p.y + 1) == :open
    ps << Route.new(Point.new p.x, p.y - 1) if value(Point.new p.x, p.y - 1) == :open && p.y - 1 > -1

    ps
  end

  def search(target : Point)
    puts "starting search"
    counter = 0
    q = Deque(Route).new
    start = Route.new (Point.new 1, 1)
    seen = Set{start.point}
    q.push start
    while q.size > 0
      n = q.shift
      counter += 1 if Maze.height(n) <= 50
      if n.point.x == target.x && n.point.y == target.y
        puts "points <= 50 #{counter}"
        return n
      end
      edges(n.point).each do |e|
        e.parent = n
        if seen.includes? e.point
          next
        end
        q.push e
        seen.add e.point
      end
    end
    return start
  end

  def self.height(r : Route)
    height = 0
    current = r.parent
    until !current
      #      pp current.point
      height += 1
      current = current.parent
    end

    height
  end
end

m = Maze.new(10)
n = m.search (Maze::Point.new 7, 4)
print m; puts
pp Maze.height n

m2 = Maze.new(1362)
n2 = m2.search (Maze::Point.new 31, 39)
# print m; puts
pp Maze.height n2

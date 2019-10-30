puts "hello"

class Maze
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
end

m = Maze.new(10)
print m; puts

MAXX         = 50
MAXY         =  6
PAUSE_MILLIS = 20

# https://en.wikipedia.org/wiki/ANSI_escape_code

struct ANSI
  def initialize(@io : IO)
  end

  def clear
    @io << "\e[2J" # clears the screen
  end

  def pos(x, y)
    @io << "\e[" << x << ';' << y << 'H' # move cursor
  end
end

class IO
  def ansi
    ANSI.new(self)
  end
end

class Rect
  property x : Int32, y : Int32

  def initialize(@x, @y)
  end

  def apply
  end
end

class Rotate
  property i : Int32, d : Int32

  def initialize(@i, @d)
  end
end

class Row < Rotate
  def apply
  end
end

class Column < Rotate
  def apply
  end
end

class Point
  property x, y

  def initialize(@x, @y)
  end
end

def display(grid)
  count = 0
  grid.each do |y|
    y.each do |x|
      x == 1 ? print '⚪' : print '⚫'
      count += 1 if x == 1
    end
    puts
  end
  puts
  puts "count is #{count}"
end

instr = [] of Rect | Rotate
grid = Array.new(6) { Array.new(50, 0) }
STDIN.each_line do |l|
  rect = l.lchop?("rect")
  if rect
    x, _, y = rect.partition("x")
    instr << Rect.new(x.strip.to_i, y.strip.to_i)
    next
  end

  rotate = l.lchop?("rotate")
  if rotate
    row = rotate.strip.lchop?("row y=")
    if row
      i, _, d = row.partition("by")
      instr << Row.new(i.strip.to_i, d.strip.to_i)
      next
    end
    col = rotate.strip.lchop?("column x=")
    if col
      i, _, d = col.partition("by")
      instr << Column.new(i.strip.to_i, d.strip.to_i)
      next
    end
  end
  raise Exception.new("oh dear: " + l)
end

instr.each do |i|
  oldgrid = grid.clone
  pp i
  case {i}
  when {Row}
    0.upto(MAXX - 1) do |x|
      grid[i.i][(x + i.d) % MAXX] = oldgrid[i.i][x]
      sleep PAUSE_MILLIS * 0.001
    end
  when {Column}
    0.upto(MAXY - 1) do |y|
      grid[(y + i.d) % MAXY][i.i] = oldgrid[y][i.i]
      sleep PAUSE_MILLIS * 0.001
    end
  when {Rect}
    0.upto(i.y - 1) do |y|
      0.upto(i.x - 1) do |x|
        grid[y % MAXY][x % MAXX] = 1
      end
    end
  end
  STDOUT.ansi.clear
  STDOUT.ansi.pos 2, 1
  display(grid)
  sleep PAUSE_MILLIS * 0.001
end

require "digest/md5"

puts "day 17"
record Point, y : Int32, x : Int32

module M
  class R
    property u : Bool = false
    property d : Bool = false
    property l : Bool = false
    property r : Bool = false
    property h : String
    property p : Point
    property parent : R?
    @@memo = Hash(String, Array(Bool)).new

    def initialize(@h, @p, @parent = nil)
      a = get
      @u = a[0] && p.y > 0
      @d = a[1] && p.y < 4
      @l = a[2] && p.x > 0
      @r = a[3] && p.x < 4
    end

    def get
      if !@@memo.has_key?(self.h)
        @@memo[self.h] = Digest::MD5.hexdigest(self.h)[0, 4].chars.map { |i| M.open?(i) }
      end
      @@memo[self.h].not_nil!
    end
  end

  def self.open?(c)
    case c
    when 'b', 'c', 'd', 'e', 'f'
      return true
    end
    return false
  end

  def self.height(r : R)
    hgt = 0
    current = r.parent
    until current.nil?
      hgt += 1
      current = current.parent
    end
    hgt
  end

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

  def self.bfs(start)
    max = 0
    q = Deque(R).new
    q << M::R.new(start, Point.new(0, 0))
    while !q.empty?
      r = q.shift
      if r.p.x == 3 && r.p.y == 3
        if M.height(r) > max
          max = M.height(r)
        end
        # return r this solves part 1
        next
      end
      q << M::R.new(r.h + "U", Point.new(r.p.y - 1, r.p.x), r) if r.u
      q << M::R.new(r.h + "D", Point.new(r.p.y + 1, r.p.x), r) if r.d && r.p.y < 3
      q << M::R.new(r.h + "L", Point.new(r.p.y, r.p.x - 1), r) if r.l
      q << M::R.new(r.h + "R", Point.new(r.p.y, r.p.x + 1), r) if r.r && r.p.x < 3
    end
    return max
  end
end

# pp M::R.new("hijkl", Point.new(0, 0))
# pp M::R.new("hijklD", Point.new(0, 1))
# pp M::R.new("hijklDR", Point.new(1, 1))
# If your passcode were ihgpwlah, the shortest path would be DDRRRD.
# With kglvqrro, the shortest path would be DDUDRLRRUDRD.
# With ulqzkmiv, the shortest would be DRURDRUDDLLDLUURRDULRLDUUDDDRR.

# pp M.bfs("hijkl").not_nil!.h

pp M.bfs("ihgpwlah")
pp M.bfs("kglvqrro")
pp M.bfs("ulqzkmiv")

puts "part 2"
pp M.bfs("edjrjqaa")
# pp M.height(M.bfs("edjrjqaa").not_nil!)

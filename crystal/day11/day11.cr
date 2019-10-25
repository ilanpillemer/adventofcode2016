# The first floor contains a strontium generator, a strontium-compatible
# microchip, a plutonium generator, and a plutonium-compatible
# microchip. The second floor contains a thulium generator, a ruthenium
# generator, a ruthenium-compatible microchip, a curium generator, and a
# curium-compatible microchip. The third floor contains a
# thulium-compatible microchip. The fourth floor contains nothing
# relevant.

# F4
# F3  TM
# F2  TG RG RM CG CM
# F1  SG SM PG PM

# https://en.wikipedia.org/wiki/Breadth-first_search

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

# also !any? == none?
# none? &.index("G")

module Solver
  @@discovered = Hash(UInt64, Bool).new { |h, k| h[k] = false }

  class State
    property floors = Hash(Int32, Array(String)).new { |h, k| h[k] = [] of String }
    property parent : State?

    def initialize
    end

    def valid
      floors.each do |k, v|
        if v.any? { |s| s.includes?("SM") }
          if v.includes?("SG") || (!v.any? { |s| s.index("G") })
          else
            return false
          end
        end
        if v.any? { |s| s.includes?("CM") }
          if v.includes?("CG") || !v.any? { |s| s.index("G") }
          else
            return false
          end
        end
        if v.any? { |s| s.includes?("RM") }
          if v.includes?("RG") || !v.any? { |s| s.index("G") }
          else
            return false
          end
        end
        if v.any? { |s| s.includes?("TM") }
          if v.includes?("TG") || !v.any? { |s| s.index("G") }
          else
            return false
          end
        end
      end

      true
    end

    def with_elevator
      floors.find { |k, v| v.includes? "E" }.try &.first
    end

    def edges
      options = [] of State
      floors[with_elevator].reject("E").each_combination(2) do |c|
        if with_elevator.not_nil! > 1
          n = State.new
          n.floors = self.floors.clone
          n.floors[with_elevator].reject!("E").reject! { |i| c.includes? i }
          n.floors[with_elevator.not_nil! - 1] += c.to_a
          n.floors[with_elevator.not_nil! - 1] << "E"
          n.floors[with_elevator.not_nil! - 1].sort!
          n.floors[with_elevator].sort!
          n.try { |n| options << n if n.valid }
        end
        if with_elevator.not_nil! < 4
          n = State.new
          n.floors = self.floors.clone
          n.floors[with_elevator].reject!("E").reject! { |i| c.includes? i }
          n.floors[with_elevator.not_nil! + 1] += c.to_a
          n.floors[with_elevator.not_nil! + 1] << "E"
          n.floors[with_elevator.not_nil! + 1].sort!
          n.floors[with_elevator].sort!
          n.try { |n| options << n if n.valid }
        end
      end
      floors[with_elevator].reject("E").each_combination(1) do |c|
        if with_elevator.not_nil! > 1
          n = State.new
          n.floors = self.floors.clone
          n.floors[with_elevator].reject!("E").reject! { |i| c.includes? i }
          n.floors[with_elevator.not_nil! - 1] += c.to_a
          n.floors[with_elevator.not_nil! - 1] << "E"
          n.floors[with_elevator.not_nil! - 1].sort!
          n.floors[with_elevator].sort!
          n.try { |n| options << n if n.valid }
        end
        if with_elevator.not_nil! < 4
          n = State.new
          n.floors = self.floors.clone
          n.floors[with_elevator].reject!("E").reject! { |i| c.includes? i }
          n.floors[with_elevator.not_nil! + 1] += c.to_a
          n.floors[with_elevator.not_nil! + 1] << "E"
          n.floors[with_elevator.not_nil! + 1].sort!
          n.floors[with_elevator].sort!
          n.try { |n| options << n if n.valid }
        end
      end
      options
    end
  end

  def self.solved?(state)
    state.floors[4].sort == ["CG", "CM", "E", "PG", "PM", "RG", "RM", "SG", "SM", "TG", "TM"]
  end

  def self.solve(initial)
    q = Deque(State).new
    q.push initial

    while q.size > 0
      n = q.shift
      if solved? n
        return n
      else
        n.edges.each do |e|
          if !@@discovered[e.floors.hash]
            @@discovered[e.floors.hash] = true
            e.parent = n
            q.push e
          end
        end
      end
    end
  end

  def self.initial
    s = State.new
    s.floors[1] = ["SG", "SM", "PG", "PM", "E"].sort
    s.floors[2] = ["TG", "RG", "RM", "CG", "CM"].sort
    s.floors[3] = ["TM"].sort
    s.floors[4] = [] of String
    s
  end
end

pp ["CG", "CM", "E", "PG", "PM", "RG", "RM", "SG", "SM", "TG", "TM"].sort
pp ["CG", "CM", "PG", "PM", "RG", "RM", "SG", "SM", "TG", "TM", "E"].sort
solution = Solver.solve Solver.initial

pp solution

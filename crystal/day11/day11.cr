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

module Solver
  class State
    property f1 = [] of String
    property f2 = [] of String
    property f3 = [] of String
    property f4 = [] of String

    def initialize(@f1, @f2, @f3, @f4)
    end
  end

  def self.initial
    f4 = [] of String
    f3 = ["TM"]
    f2 = ["TG", "RG", "RM", "CG", "CM"]
    f1 = ["SG", "SM", "PG", "PM", "E"]
    State.new(f1, f2, f3, f4)
  end

  def self.solved?(state)
    state.f4.sort == ["CG", "CM", "PG", "PM", "RG", "RM", "SG", "SM", "TG", "TM", "E"]
  end
end

puts "Day 11"
pp Solver.initial

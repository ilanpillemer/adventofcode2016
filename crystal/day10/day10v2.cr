# influenced by https://github.com/asterite/adventofcode2016/blob/master/crystal/10/10.1.cr

enum Component
  Output
  Splitter
end

alias SplitterID = Int32
alias OutputID = Int32

splitters = Hash(SplitterID, Array(Int32)).new { |h, k| h[k] = [] of Int32 }
output = {} of OutputID => Int32

record Flow, to : Component, value : Int32
statements = {} of SplitterID => {Flow, Flow}

STDIN.each_line do |line|
  case line
  when /value (\d+) goes to bot (\d+)/
    splitters[$2.to_i] << $1.to_i
  when /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/
    statements[$1.to_i] = {
      Flow.new($2 == "output" ? Component::Output : Component::Splitter, $3.to_i),
      Flow.new($4 == "output" ? Component::Output : Component::Splitter, $5.to_i),
    }
  end
end

answer = nil

loop do
  fixed_point = true
  splitters.each do |splitterID, splitter|
    if splitter.size == 2 && (flows = statements[splitterID]?)
      fixed_point = false # something to do
      values = splitter.sort
      splitters[splitterID].clear

      # part 1
      answer ||= splitterID if values == [17, 61]

      # low
      if flows.first.to == Component::Output
        output[flows.first.value] = values.first
      else
        splitters[flows.first.value] << values.first
      end
      # high
      if flows.last.to == Component::Output
        output[flows.last.value] = values.last
      else
        splitters[flows.last.value] << values.last
      end
    end
  end

  break if fixed_point
end

puts "part1: found you  #{answer}"
puts "part2: #{output[0] * output[1] * output[2]}"

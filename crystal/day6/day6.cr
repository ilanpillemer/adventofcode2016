answer = [] of Char | Nil
STDIN.each_char.select(&.!=('\n')).to_a.in_groups_of(8).transpose.each do |l|
  answer << l.tally.max_by { |k, v| v }.first
end
puts answer.join

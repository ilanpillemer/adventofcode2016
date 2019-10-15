require "digest/md5"

puts "advent of code 2016, day 5, part 2"
input = "reyedfim"
output = Array.new(8, ' ')

counter = 0
while !output.all?(&.alphanumeric?)
  n = input + counter.to_s
  hash = Digest::MD5.hexdigest(n)
  if hash.starts_with? "00000"
    output[hash[5].to_i] = hash[6] if hash[5].number? && hash[5].to_i < 8 && !output[hash[5].to_i].alphanumeric?
    puts "after #{hash} #{output} #{output.join}" # not necessary, but interesting when debugging
  end
  counter += 1
end

puts "password: #{output.join}"

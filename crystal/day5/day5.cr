require "digest/md5"

puts "advent of code 2016, day 5"
input = "reyedfim"
output = ""
counter = 0
while output.size < 8
  n = input + counter.to_s
  hash = Digest::MD5.hexdigest(n)
  if hash.starts_with? "00000"
    output = output + hash[5]
  end
  counter += 1
end

puts output

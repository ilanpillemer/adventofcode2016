def decrypt(l)
  room, id, checksum = l.partition(/\d\d\d/)
  id.to_i.times do
    room = room.tr("abcdefghijklmnopqrstuvwxyz" + "-", "bcdefghijklmnopqrstuvwxyza" + " ")
  end
  puts "#{room} #{id}"
end

STDIN.each_line do |l|
  decrypt(l)
end

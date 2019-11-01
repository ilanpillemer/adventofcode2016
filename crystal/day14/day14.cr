require "digest/md5"

class KeyPad
  property sevens : Set(String)
  property hs : Hash(String, String)

  def initialize
    @sevens = Set(String).new
    @hs = {} of String => String
  end

  def key(h)
    return true if valid(h)
  end

  def stretch(h)
    return @hs[h] if @hs.has_key?(h)

    0.upto(2016) do
      h = Digest::MD5.hexdigest(h)
    end
    @hs[h] = h
    return h
  end

  def valid(prefix, i)
    #    h = Digest::MD5.hexdigest("#{prefix}#{i}")
    h = stretch("#{prefix}#{i}")

    #    puts "#{prefix}#{i}"
    if /(.)\1{2}/ =~ h
      c = $1.to_s
      return true if @sevens.includes?(c + ":" + h)
      1.upto(1000) do |j|
        #        h2 = Digest::MD5.hexdigest("#{prefix}#{i + j}")

        h2 = stretch("#{prefix}#{i + j}")
        if /#{c}{5}/ =~ h2
          puts "#{i} #{h2}"
          @sevens << (c + ":" + h)
          return true
        end
      end
    end
  end
end

k = KeyPad.new
count = 0
i = -1
until count == 64
  i += 1
  count += 1 if k.valid("jlmsuwbz", i)
end

puts i

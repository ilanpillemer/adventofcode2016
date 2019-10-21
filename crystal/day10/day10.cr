require "string_scanner"

class Bot
  property a : Int32?
  property b : Int32?

  def initialize(@a = nil, @b = nil)
  end

  def low
    return a if a.not_nil! < b.not_nil!
    b
  end

  def clear_low
    if a.nil?
      @b = nil
      return
    end
    if b.nil?
      @a = nil
      return
    end

    if a.not_nil! < b.not_nil!
      @a = nil
      return
    end
    @b = nil
  end

  def clear_high
    if a.nil?
      @b = nil
      return
    end
    if b.nil?
      @a = nil
      return
    end

    if a.not_nil! > b.not_nil!
      @a = nil
      return
    end
    @b = nil
  end

  def high
    return a if a.not_nil! > b.not_nil!
    b
  end

  def can_receive?
    a.nil? || b.nil?
  end

  def ready?
    !can_receive?
  end

  def receive(it)
    if @a.nil?
      @a = it
      return
    end
    if @b.nil?
      @b = it
      return
    end
  end

  def gives(lower : Bot, higher : Bot)
    l = low
    h = high
    if lower.can_receive?
      lower.receive l
      clear_low
    end

    if higher.can_receive?
      higher.receive h
      clear_high
    end
  end
end

bots = {} of Int32 => Bot

instructions = STDIN.gets_to_end
scanner = StringScanner.new(instructions)

while !scanner.eos?
  case scanner
  # value 61 goes to bot 119
  when .scan(/value (\d+) goes to bot (\d+)/)
    v = scanner[1].to_i
    b = scanner[2].to_i
    bots[b] = Bot.new if !bots.has_key?(b)
    bots[b].receive v if bots[b].can_receive?
  else
    scanner.offset += 1
    next
  end
  puts "bot #{b} got #{v}"
end
pp bots

while scanner.reset
  while !scanner.eos?
    case scanner
    when .scan(/bot (\d+) gives low to bot (\d+) and high to bot (\d+)/)
      giver = scanner[1].to_i
      bots[giver] = Bot.new if !bots.has_key?(giver)
      lower = scanner[2].to_i
      higher = scanner[3].to_i
    when .scan(/bot (\d+) gives high to bot (\d+) and low to bot (\d+)/)
      giver = scanner[1].to_i
      bots[giver] = Bot.new if !bots.has_key?(giver)
      higher = scanner[2].to_i
      lower = scanner[3].to_i
    else
      scanner.offset += 1
      next
    end
    next if !bots[giver].ready?
    puts "bot #{giver} is comparing #{bots[giver].low} and #{bots[giver].high}"
    exit if bots[giver].low == 17 && bots[giver].high == 61
    bots[lower.not_nil!] = Bot.new if !bots.has_key?(lower)
    bots[higher.not_nil!] = Bot.new if !bots.has_key?(higher)
    bots[giver].gives(bots[lower], bots[higher])
  end
end
# pp bots

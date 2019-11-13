# cpy x y copies x (either an integer or the value of a register) into register y.
# inc x increases the value of register x by one.
# dec x decreases the value of register x by one.
# jnz x y jumps to an instruction y away (positive means forward; negative means backward), but only if x is not zero.

class Computer
  @@register = {"a" => 7, "b" => 0, "c" => 0, "d" => 0}
  property program = [] of String
  property pc = 0

  property commands : Hash(String, Proc(Array(String), Int32))

  def initialize
    @commands = {
      "cpy" => ->cpy(Array(String)),
      "inc" => ->inc(Array(String)),
      "dec" => ->dec(Array(String)),
      "jnz" => ->jnz(Array(String)),
      "tgl" => ->tgl(Array(String)),
    }
  end

  def cpy(x)
    if x[1].to_i?
      @pc += 1
      return @pc
    end
    @@register[x[1]] = x[0].to_i? || @@register[x[0]]
    @pc += 1
  end

  def inc(x)
    @@register[x[0]] += 1
    @pc += 1
  end

  def dec(x)
    @@register[x[0]] -= 1
    @pc += 1
  end

  # tgl x toggles the instruction x away (pointing at instructions like jnz does: positive means forward; negative means backward):
  #
  #   For one-argument instructions, inc becomes dec, and all other one-argument instructions become inc.
  #   For two-argument instructions, jnz becomes cpy, and all other two-instructions become jnz.
  #    The arguments of a toggled instruction are not affected.
  #    If an attempt is made to toggle an instruction outside the program, nothing happens.
  #    If toggling produces an invalid instruction (like cpy 1 2) and an attempt is later made to execute that instruction, skip it instead.
  #    If tgl toggles itself (for example, if a is 0, tgl a would target itself and become inc a), the resulting instruction is not executed until the next time it is reached.

  def tgl(x)
    other = @pc + @@register[x[0]]
    if other >= @program.size
      @pc += 1
      return @pc
    end
    instr = @program[other].split
    case instr[0]
    when "inc"
      instr[0] = "dec"
    when "dec"
      instr[0] = "inc"
    when "tgl"
      instr[0] = "inc"
    when "cpy"
      instr[0] = "jnz"
    when "jnz"
      instr[0] = "cpy"
    end
    @program[other] = instr.join(" ")
    @pc += 1
  end

  def display
    pp @@register
  end

  def jnz(x)
    jump = x[0].to_i? || @@register[x[0]]
    if jump.zero?
      @pc += 1
    else
      @pc += x[1].to_i? || @@register[x[1]]
    end
  end
end

computer = Computer.new

STDIN.each_line do |l|
  computer.program << l
end
pp computer.program

puts "starting"

until computer.pc >= computer.program.size
  instr = computer.program[computer.pc].split
  computer.commands[instr.first].try &.call(instr[1..])
  #  print computer.pc, " ", instr, " "
  #  computer.display
end
puts "terminated"
pp computer.pc
computer.display

["cpy 1 a",
 "cpy 1 b",
 "cpy 26 d",
 "jnz c 2",
 "jnz 1 5",
 "cpy 7 c",
 "inc d",
 "dec c",
 "jnz c -2",
 "cpy a c",
 "inc a",
 "dec b",
 "jnz b -2",
 "cpy c b",
 "dec d",
 "jnz d -6",
 "cpy 19 c",
 "cpy 14 d",
 "inc a",
 "dec d",
 "jnz d -2",
 "dec c",
 "jnz c -5"]

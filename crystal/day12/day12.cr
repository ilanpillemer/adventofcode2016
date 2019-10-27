# cpy x y copies x (either an integer or the value of a register) into register y.
# inc x increases the value of register x by one.
# dec x decreases the value of register x by one.
# jnz x y jumps to an instruction y away (positive means forward; negative means backward), but only if x is not zero.

module Computer
  @@register = {"a" => 0, "b" => 0, "c" => 1, "d" => 0}
  commands = {
    "cpy" => ->cpy(Array(String)),
    "inc" => ->inc(Array(String)),
    "dec" => ->dec(Array(String)),
    "jnz" => ->jnz(Array(String)),
  }
  program = [] of String

  def self.cpy(x)
    @@register[x[1]] = x[0].to_i? || @@register[x[0]]
    1
  end

  def self.inc(x)
    @@register[x[0]] += 1
    1
  end

  def self.dec(x)
    @@register[x[0]] -= 1
    1
  end

  def self.display
    pp @@register
  end

  def self.jnz(x)
    jump = x[0].to_i? || @@register[x[0]]
    if jump.zero?
      return 1
    else
      return x[1].to_i
    end
  end
end

STDIN.each_line do |l|
  program << l
end
pp program

puts "starting"
pc = 0
until pc >= program.size
  instr = program[pc].split
  pc += commands[instr.first].try &.call(instr[1..])
  #  print pc, " ", instr, " "; Computer.display
  #  Computer.display
end
puts "terminated"
pp pc
Computer.display

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

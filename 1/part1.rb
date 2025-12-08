zeros_count = 0
pointer = 50

File.open('rotations.txt', 'r').each_line do |line|
  dir = line[0]
  x = line[1..].strip.to_i
  case dir
  when 'L'
    pointer -= x
  when 'R'
    pointer += x
  else
    raise 'shit happens'
  end
  pointer %= 100
  zeros_count += 1 if pointer == 0
end

p zeros_count

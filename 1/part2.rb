zeros_count = 0
pointer = 50

File.open('rotations.txt', 'r').each_line do |line|
  dir = line[0]
  x = line[1..].strip.to_i

  next if x == 0

  # Count full turn
  zeros_count += x / 100
  x %= 100

  case dir
  when 'L'
    zeros_count += 1 if pointer - x <= 0 && pointer != 0
    pointer -= x
  when 'R'
    zeros_count += 1 if pointer + x >= 100 && pointer != 0
    pointer += x
  else
    raise 'shit happens'
  end

  pointer %= 100
end

p zeros_count

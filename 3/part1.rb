def get_joltage(line)
  i = 0
  v = 0

  line = line.to_i.to_s.split('').map(&:to_i)
  line.each_with_index do |x, index|
    if x > v
      v = x
      i = index
    end
  end

  left_max = line[..i - 1].max
  right_max = line[i + 1..].max
  left_val = "#{left_max}#{v}".to_i
  right_val = "#{v}#{right_max}".to_i

  return right_val if i - 1 < 0
  return left_val if i + 1 >= line.size

  [left_val, right_val].max
end

pp get_joltage('987654321111111')
pp get_joltage('8119')
pp get_joltage('234234234234278')
pp get_joltage('818181911112111')

sum = 0
File.open('input.txt', 'r').each_line do |line|
  jolt = get_joltage(line)
  sum += jolt
end

pp sum

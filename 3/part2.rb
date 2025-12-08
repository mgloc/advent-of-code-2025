def rec_joltage(line_slice, n, offset)
  return [] if n == 0

  max_index = line_slice[..-n].each_with_index.max_by { |e| e[0] }[1]
  real_max_index = max_index + offset

  joltage_n_1 = rec_joltage(line_slice[max_index + 1..], n - 1, real_max_index + 1)

  joltage_n_1.prepend(real_max_index)
end

def get_joltage(line)
  line = line.to_i.to_s.split('').map(&:to_i)
  indexes = rec_joltage(line, 12, 0)
  pp indexes
  indexes.map { |i| line[i] }.join('').to_i
end

pp get_joltage('818181911112111')
pp get_joltage('987654321111111')
pp get_joltage('811111111111119')
pp get_joltage('234234234234278')

sum = 0
File.open('input.txt', 'r').each_line do |line|
  jolt = get_joltage(line)
  sum += jolt
end

pp sum

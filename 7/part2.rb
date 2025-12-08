file = File.open('input.txt', 'r')
line = file.gets
b_indexes = Array.new(line.size, 0)
b_indexes[line.index('S')] = 1

mem = b_indexes.clone

loop do
  line = file.gets
  break if line.nil?

  mem = b_indexes.clone
  mem.each_with_index do |value, index|
    next if value == 0
    next if line[index] != '^'

    b_indexes[index - 1] += b_indexes[index]
    b_indexes[index + 1] += b_indexes[index]
    b_indexes[index] = 0
  end
end

pp b_indexes.sum

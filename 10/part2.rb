require 'matrix'

def indexes_to_vector(arr_indexes, dim)
  v = Vector.zero(dim)
  arr_indexes.each do |index|
    v[index] = 1
  end
  v
end

machines = []
File.open('input.txt', 'r').each_line do |line|
  splitted = line.split(' ')

  # Joltage {3,5,4,7} -> [3,5,4,7]
  j = Vector.elements(splitted[-1][1...-1].split(',').map(&:to_i))
  dim = j.size

  # Buttons (0,2) -> [0, 2]
  b = splitted[1...-1].map { |button| indexes_to_vector(button[1...-1].split(',').map(&:to_i), dim) }

  machines << [j, b]
end

def fewest_presses(joltage, buttons, queue = Queue.new)
  start = Vector.zero(joltage.size)
  queue << [start, 0]
  visited = Set.new
  visited << start

  until queue.empty?
    q_joltage, q_count = queue.pop

    return q_count if q_joltage == joltage

    buttons.each do |button|
      new_joltage = q_joltage + button
      next if joltage.zip(new_joltage).any? { |j, nj| nj > j }
      next if visited.include?(new_joltage)

      visited << new_joltage

      queue << [new_joltage, q_count + 1]
    end
  end
end

# well that's hard

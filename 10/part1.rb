# Converts a list of indexes to a binary string
def b_from_indexes(size, indexes)
  b_arr = Array.new(size, 0)
  indexes.each do |index|
    b_arr[index] = 1
  end
  b_arr.join('').to_i(2)
end

machines = []
File.open('input.txt', 'r').each_line do |line|
  splitted = line.split(' ')

  # Switche patterns [.###.#] -> 11101
  s = splitted[0][1...-1].tr('.#', '01')
  padding = s.size
  s = s.to_i(2)

  # Buttons (0,2) -> 101000
  b = splitted[1...-1].map { |button| b_from_indexes(padding, button[1...-1].split(',').map(&:to_i)) }

  machines << [s, b]
end

def fewest_presses(pattern, buttons, queue = Queue.new)
  queue << [0, 0]
  until queue.empty?
    q_pattern, q_count = queue.pop
    return q_count if q_pattern == pattern

    buttons.each do |button|
      queue << [q_pattern ^ button, q_count + 1]
    end
  end
end

pp machines.map { |s, b| fewest_presses(s, b) }.sum

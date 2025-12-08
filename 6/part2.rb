lines = File.open('input.txt', 'r').readlines
# lines = File.open('example.txt', 'r').readlines

n = lines.map(&:size).max
nn = lines.size
sum = 0
mem = 0

op = '+'

index = 0
number = 0
loop do
  if index >= n
    sum += mem
    break
  end

  # Parse potentially new operator
  new_op = lines[-1][index]
  if ['*', '+'].include?(new_op)
    sum += mem
    mem = new_op == '*' ? 1 : 0
    op = new_op
  end

  number = (0...nn - 1).map { |line_index| lines[line_index][index] }.join.strip
  if number == ''
    index += 1
    next
  end

  number = number.to_i

  case op
  when '+'
    mem += number
  when '*'
    mem *= number
  end

  index += 1
end

pp sum

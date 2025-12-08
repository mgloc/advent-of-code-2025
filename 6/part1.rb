def parse_input
  numbers = []
  File.open('input.txt', 'r').each_line do |line|
    row = []
    line.split(' ').each do |char|
      next if char.strip == ''

      row << char.strip
    end
    numbers << row
  end
  numbers
end

def compute(input)
  sum = 0
  n = input[0].size
  (0...n).each do |i|
    op = input[4][i]
    numbers = (0..3).map { |j| input[j][i].to_i }
    sum += case op
           when '*'
             numbers.inject(1) { |m, x| m * x }
           when '+'
             numbers.sum
           end
  end
  sum
end

input = parse_input
pp compute(input)

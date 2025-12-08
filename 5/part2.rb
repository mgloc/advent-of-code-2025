def parse_input
  ranges = []
  ingredients = []
  file = File.open('input.txt', 'r')

  loop do
    line = file.readline
    break if line&.strip&.empty?

    ranges << line.split('-').map(&:to_i)
  end

  loop do
    line = file.gets
    break if line.nil?

    ingredients << line.to_i
  end

  [ranges, ingredients]
end

ranges, = parse_input

# ranges = [
#   [3, 5],
#   [10, 14],
#   [16, 20],
#   [12, 18]
# ]

n = ranges.size
s_range = ranges.sort_by { |r| r[0] }

index = 0
count = 0
loop do
  break if index >= n

  range = s_range[index]
  l = range[0]
  r = range[1]
  count += r - l + 1

  loop do
    index += 1
    break if index >= n

    next_range = s_range[index]
    ll = next_range[0]
    rr = next_range[1]
    # if is excluded
    break if r < ll

    # if is included
    next if rr < r

    count -= (r - ll + 1)
    break
  end
end
pp count

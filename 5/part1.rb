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

def is_in_range?(x, range)
  range[0] <= x && x <= range[1]
end

def count_in_ranges(ranges, elements)
  count = 0
  elements.each do |e|
    ranges.each do |r|
      if is_in_range?(e, r)
        count += 1
        break
      end
    end
  end
  count
end

ranges, ingredients = parse_input
pp count_in_ranges(ranges, ingredients)

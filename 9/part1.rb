coordinates = []
File.open('input.txt', 'r').each_line do |line|
  coordinates << line.strip.split(',').map(&:to_i)
end

# Area in 2D space
def area(a, b)
  ((a[0] - b[0]).abs + 1) * ((a[1] - b[1]).abs + 1)
end

# areas: Array<Array<(index1,index2,d)>>
areas = []
n = coordinates.size
(0...n).each do |a|
  (a + 1...n).each do |b|
    areas << [a, b, area(coordinates[a], coordinates[b])]
  end
end
areas = areas.sort_by { |d| -d[2] }

pp areas.first

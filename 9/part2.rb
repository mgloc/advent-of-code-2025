coordinates = []
File.open('input.txt', 'r').each_line do |line|
  coordinates << line.strip.split(',').map(&:to_i)
end
n = coordinates.size

# Area in 2D space
def area(a, b)
  ((a[0] - b[0]).abs + 1) * ((a[1] - b[1]).abs + 1)
end

# Store horizonal and vertical lines to check if a square is green, sort them on the other axis
# lines: Array<Array<(x1,x2,y)>>
x_lines = []
y_lines = []
(0...n).each do |i|
  next_i = (i + 1) % n
  if coordinates[i][0] == coordinates[next_i][0]
    y1, y2 = [coordinates[i][1], coordinates[next_i][1]].minmax
    y_lines << [y1, y2, coordinates[i][0]]
  else
    x1, x2 = [coordinates[i][0], coordinates[next_i][0]].minmax
    x_lines << [x1, x2, coordinates[i][1]]
  end
end
x_lines = x_lines.sort_by { |l| l[2] }
y_lines = y_lines.sort_by { |l| l[2] }

# areas: Array<Array<(index1,index2,d)>>
areas = []
n = coordinates.size
(0...n).each do |a|
  (a + 1...n).each do |b|
    areas << [a, b, area(coordinates[a], coordinates[b])]
  end
end
areas = areas.sort_by { |d| -d[2] }

def line_cross_rectangle(a, b, lines_x, lines_y)
  x1, x2 = [a[0], b[0]].minmax
  y1, y2 = [a[1], b[1]].minmax
  lines_x.each do |lx1, lx2, y|
    next if y <= y1
    break if y >= y2

    lx1, lx2 = [lx1, lx2].minmax
    return true unless lx2 <= x1 || x2 <= lx1
  end

  lines_y.each do |ly1, ly2, x|
    next if x <= x1
    break if x >= x2

    ly1, ly2 = [ly1, ly2].minmax
    return true unless ly2 <= y1 || y2 <= ly1
  end
  false
end

def in_polygon?(x, y, x_lines, y_lines)
  count = 0

  y_lines.each do |y1, y2, xx|
    break if xx > x
    next if y < y1 || y2 < y # skip if no lines crossed
    return true if xx == x

    count += 1
  end
  return true if count.odd?

  count = 0
  x_lines.each do |x1, x2, yy|
    break if yy > y
    next if x < x1 || x2 < x # skip if no lines crossed
    return true if yy == y

    count += 1
  end
  count.odd?
end

# We can draw a rectangle:
# - if no vertical lines are crossing the inside exlcuding left and right and
# - if no horizontal lines are crossing the inside excluding top and bottom
areas.each do |i, j, d|
  next if line_cross_rectangle(coordinates[i], coordinates[j], x_lines, y_lines)

  pp coordinates[i]
  pp coordinates[j]
  pp d
  break
end

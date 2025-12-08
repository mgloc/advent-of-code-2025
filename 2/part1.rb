def rr(x, y)
  results = []
  (x..y).each do |n|
    string = n.to_s
    l_string = string.size
    next if string.size.odd?

    results << n if string[..l_string / 2 - 1] == string[l_string / 2..]
  end
  results
end

File.open('input.txt', 'r').each_line do |line|
  sum = 0
  ranges = line.split(',').map { |r| r.split('-') }
  ranges.each do |range|
    sum += rr(range[0].to_i, range[1].to_i).sum
  end
  pp sum
end

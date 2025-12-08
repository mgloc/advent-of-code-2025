def is_sequence?(string, i)
  return false if string.size % i != 0

  n = string.size
  nb_intervals = n / i
  (0..(nb_intervals - 2)).each do |k|
    return false if string[(k * i)..(k + 1) * i - 1] != string[((k + 1) * i)..(k + 2) * i - 1]
  end
  true
end

def is_repeating?(string)
  n = string.size
  (1..n / 2).map { |i| is_sequence?(string, i) }.any?
end

def rr(x, y)
  results = []
  (x..y).each do |n|
    string = n.to_s
    results << n if is_repeating?(string)
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

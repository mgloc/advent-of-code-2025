$devices = {}
File.open('input.txt', 'r').each_line do |line|
  splitted = line.strip.split(':')
  $devices[splitted[0]] = splitted[1].strip.split(' ')
end

$memoize = {}
def browse(from, to)
  key = from + to

  return $memoize[key] unless $memoize[key].nil?

  children = $devices[from]

  if children.nil?
    $memoize[key] = 0
    return 0
  end

  result = children.map do |child|
    if child == to
      1
    else
      browse(child, to)
    end
  end.sum
  $memoize[key] = result
  result
end

pp browse('svr', 'fft') * browse('fft', 'dac') * browse('dac', 'out')

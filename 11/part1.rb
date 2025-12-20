devices = {}
File.open('input.txt', 'r').each_line do |line|
  splitted = line.strip.split(':')
  devices[splitted[0]] = splitted[1].strip.split(' ')
end

def rec_count_pathes(count, current_device, devices)
  return 1 if current_device == 'out'

  devices[current_device].map do |d|
    rec_count_pathes(count, d, devices)
  end.sum
end

pp rec_count_pathes(0, 'you', devices)

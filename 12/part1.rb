file = File.open('input.txt', 'r')

# Array of regions {size: [38, 48], n_gifts: [18, 40, 41, 41, 30, 21]}
regions = []

# Array of matrices representing gifts
gifts = []
loop do
  line = file.gets&.strip
  break if line.nil?

  splitted = line.split(':')
  case splitted[0]
  when /^\d$/
    gift = []
    loop do
      line = file.gets&.strip
      break if line == ''

      gift << line.tr('#.', '10').split('').map(&:to_i)
    end
    gifts << gift
  when /^\d+x\d+$/
    region = {}
    region[:size] = splitted[0].split('x').map(&:to_i)
    region[:n_gifts] = splitted[1].strip.split(' ').map(&:to_i)
    regions << region
  end
end

# Compute max area for each gift
areas = gifts.map { |g| g[0].length * g.length }

result = regions.map do |region|
  area_needed = region[:n_gifts].each_with_index.map { |n, i| areas[i] * n }.sum
  area_available = region[:size][0] * region[:size][1]
  area_available >= area_needed ? 1 : 0
end.sum

pp result # the fact that this worked as a valid answer disgusts me

coordinates = []
File.open('input.txt', 'r').each_line do |line|
  coordinates << line.strip.split(',').map(&:to_i)
end

# Euclidean distance between two points in a 3D space
def distance(a, b)
  Math.sqrt((0..2).map { |i| (a[i] - b[i]).pow(2) }.sum)
end

# distances: Array<Array<(index1,index2,d)>>
distances = []
n = coordinates.size
(0...n).each do |a|
  (a + 1...n).each do |b|
    distances << [a, b, distance(coordinates[a], coordinates[b])]
  end
end

# Removes the shortest connexion in the distance array, very slow
# @return Array<(index1,index2,d)>
def pop_shortest(distances_list)
  minimum_index = distances_list.each_with_index.min_by { |d, _| d[2] }[1]
  distances_list.delete_at(minimum_index) # very bad
end

# A bad way of representing circuits
# circuits: Array<Array<index>>, only representing size of at least 2 circuits
circuits = []
def get_circuit_index_for(element_index, circuits_list)
  circuits_list.each_with_index do |c, index|
    return index if c.include?(element_index)
  end
  -1
end

# Put a and b in the same circuits
def link_circuits(a_index, b_index, circuits_list)
  a_circuit_index = get_circuit_index_for(a_index, circuits_list)
  b_circuit_index = get_circuit_index_for(b_index, circuits_list)

  if a_circuit_index == -1 && b_circuit_index == -1
    circuits_list << [a_index, b_index]
  elsif a_circuit_index == -1
    circuits_list[b_circuit_index] << a_index
  elsif b_circuit_index == -1
    circuits_list[a_circuit_index] << b_index
  elsif a_circuit_index != b_circuit_index
    circuits_list[a_circuit_index] += circuits_list[b_circuit_index]
    circuits_list.delete_at(b_circuit_index)
  end
end

1000.times do |i|
  pp i # because its slooow, bad circuit impl
  break if distances.size == 0

  a, b, = pop_shortest(distances)

  link_circuits(a, b, circuits)
end

pp circuits.map(&:size).sort.reverse.slice(0...3).inject(1) { |m, r| m * r }

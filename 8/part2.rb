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
distances = distances.sort_by { |d| d[2] }
m = distances.size

# circuits: Array<(circuit_n)>, element at coordinates[i] is in circuit circuits[i]
circuits = Array.new(n, nil)
last_circuit_number = 0
shortest_index = 0

last_indexes = [0, 0]

def all_equal(list)
  element = list[0]
  list.each do |e|
    return false if e != element || e.nil?
  end
  true
end

loop do
  break if shortest_index >= m
  break if all_equal(circuits)

  a_index, b_index, = distances[shortest_index]
  last_indexes = [a_index, b_index]

  shortest_index += 1

  # Put a and b in the same circuits
  a_circuit_number = circuits[a_index]
  b_circuit_number = circuits[b_index]

  if a_circuit_number.nil? && b_circuit_number.nil?
    circuits[a_index] = last_circuit_number
    circuits[b_index] = last_circuit_number
    last_circuit_number += 1
  elsif a_circuit_number.nil?
    circuits[a_index] = circuits[b_circuit_number]
  elsif b_circuit_number.nil?
    circuits[b_index] = circuits[a_circuit_number]
  elsif a_circuit_number != b_circuit_number
    circuits.each_with_index do |circuit_number, index|
      circuits[index] = a_circuit_number if circuit_number == b_circuit_number
    end
  end
end

coord1 = coordinates[last_indexes[0]]
coord2 = coordinates[last_indexes[1]]
pp coord1[0] * coord2[0]

def parse_input
  matrice = []
  File.open('input.txt', 'r').each_line do |line|
    matrice_line = []
    line.strip.split('').each do |char|
      case char
      when '.'
        matrice_line << 0
      when '@'
        matrice_line << 1
      end
    end
    matrice << matrice_line
  end
  matrice
end

def remove_rolls(matrice)
  m = matrice.size
  n = matrice[0].size
  result_matrice = Marshal.load(Marshal.dump(matrice))
  count = 0

  (0...m).each do |j|
    (0...n).each do |i|
      next if matrice[i][j] == 0

      around = 0
      (j - 1..j + 1).each do |jj|
        (i - 1..i + 1).each do |ii|
          next if (ii == i && jj == j) || jj < 0 || ii < 0 || ii >= n || jj >= m

          around += 1 if matrice[ii][jj] == 1
        end
      end
      if around < 4
        count += 1
        result_matrice[i][j] = 0
      end
    end
  end
  [count, result_matrice]
end

matrice = parse_input
sum = 0
loop do
  count, matrice = remove_rolls(matrice)
  sum += count
  break if count == 0
end
pp sum

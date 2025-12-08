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

def brute_force(matrice)
  m = matrice.size
  n = matrice[0].size
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
      count += 1 if around < 4
    end
  end
  count
end

pp brute_force(parse_input)

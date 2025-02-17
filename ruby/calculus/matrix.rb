
def multiply(a, b)
  result = Array.new(a.size) { Array.new(b[0].size, 0) }

  a.each_with_index do |a_row, i|
    b[0].size.times do |j|
      a_row.size.times do |k|
        result[i][j] += a[i][k] * b[k][j]
      end
    end
  end

  result
end
# matrix here
result = multiply(matrix, matrix)
result.each do |row|
  formatted_row = row.map { |elem| sprintf("%.2f", elem) }
  puts formatted_row.join(', ')
end

def multiply(a, b)
    n = a.size
    result = Array.new(n) { Array.new(n, 0) }
  
    n.times do |i|
      n.times do |j|
        n.times do |k|
          result[i][j] += a[i][k] * b[k][j]
        end
      end
    end
  
    result
  end
  
  a = Array.new(500) { Array.new(500) { rand } } # Example initialization
  b = Array.new(500) { Array.new(500) { rand } }
  result = multiply(a, b)
  
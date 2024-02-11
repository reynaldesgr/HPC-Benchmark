def fibonacci(n)
    return n if n <= 1
    fibonacci(n - 1) + fibonacci(n - 2)
end

n = 45
res = fibonacci(n)
puts  "Ruby result : " + res.to_s
  
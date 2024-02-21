def benchmark_float_operations(iterations)
    f1 = 1.234567
    f2 = 7.890123
    result = 0.0
    
    start_time = Time.now
    iterations.times do
      result = f1 * f2
    end
    end_time = Time.now
    puts "Float multiplication: Result = #{result}, Time = #{end_time - start_time} seconds"
  
    start_time = Time.now
    iterations.times do
      result = f1 + f2
    end
    end_time = Time.now
    puts "Float addition: Result = #{result}, Time = #{end_time - start_time} seconds"
  
    start_time = Time.now
    iterations.times do
      result = f1 / f2
    end
    end_time = Time.now
    puts "Float division: Result = #{result}, Time = #{end_time - start_time} seconds"
  end
  
  def benchmark_double_operations(iterations)
    d1 = 1.234567890123456
    d2 = 7.890123456789012
    result = 0.0
    
    start_time = Time.now
    iterations.times do
      result = d1 * d2
    end
    end_time = Time.now
    puts "Double multiplication: Result = #{result}, Time = #{end_time - start_time} seconds"
  
    start_time = Time.now
    iterations.times do
      result = d1 + d2
    end
    end_time = Time.now
    puts "Double addition: Result = #{result}, Time = #{end_time - start_time} seconds"
  
    start_time = Time.now
    iterations.times do
      result = d1 / d2
    end
    end_time = Time.now
    puts "Double division: Result = #{result}, Time = #{end_time - start_time} seconds"
  end
  
  iterations = 100000000
  puts "Benchmarking float (32-bit) operations:"
  benchmark_float_operations(iterations)
  puts "\nBenchmarking double (64-bit) operations:"
  benchmark_double_operations(iterations)  


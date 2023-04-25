def fibonacci(n)
  if n <= 0
    0
  elsif n == 1
    1
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

puts fibonacci(0)
puts fibonacci(1)
puts fibonacci(2)
puts fibonacci(3)
puts fibonacci(4)
puts fibonacci(7)
puts fibonacci(30)

  # 0 = 0
  # 1 = 1
  # 2 = 1
  
  # 3 = 2
  # 4 = 3
  # 5 = 5
  # 6 = 8
  # 7 = 13
  # 8 = 21
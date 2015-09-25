# Fibonacci sequence generated iteratively and recursively

# Iteration
def fibs(number)
  seq = [1, 2]

  (number-2).times do |nb|
    seq << seq[-1] + seq[-2]
  end
  
  seq
end

# Recursion
def fibs_rec(number)
  return [1] if number == 1
  return [1, 2] if number == 2
  fibs_rec(number - 1) << fibs_rec(number - 1)[-1] + fibs_rec(number - 1)[-2]
end

puts fibs(10).inspect
puts fibs_rec(10).inspect
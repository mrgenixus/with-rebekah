nums = [1,2,3,4,5]
exps = nums.map do |n|
  n ** n
end

puts nums
puts nums.join(':-|-:')
puts exps.join('[::]|[::]')

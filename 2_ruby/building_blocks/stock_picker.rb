def stock_picker(days)
  profit = 0
  picker = []
  days[0..-1].each_with_index do |price1,day1|
    days[day1..-1].each_with_index do |price2,day2|
      if price2-price1 > profit
	profit = price2-price1
	picker = [day1,day2+day1]
      end
    end
  end
  puts "You should buy on day #{picker[0]} and sell on day #{picker[1]}"
end

stock_picker([17,3,6,9,15,8,6,1,10])
stock_picker((1..18).to_a)

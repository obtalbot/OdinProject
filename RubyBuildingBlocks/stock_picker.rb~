def stock_picker(price_list)
  prices = price_list.clone
  max, min = 0, 0

  loop do
  	break if prices.empty?
  	
    prices.untaint

  	if prices[0] == prices.max 
  	  prices.shift
      prices.taint
    end

    if prices[prices.size] == prices.min
  	  prices.pop
  	  prices.taint
  	end

  	break unless prices.tainted?
  end

  unless prices.empty?
    max = prices.max
    min = prices[0..prices.find_index(prices.max)].min
  end
  
  buy = price_list.find_index(min)
  sell = price_list.find_index(max)

  [buy, sell]
end

p stock_picker([17,3,6,9,15,8,6,1,10])
#=> [1,4]
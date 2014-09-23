module Enumerable

  def my_each
    return self.to_enum if !block_given?
    result = []
    for index in 0..(self.size - 1) do
      result << self[index]
      yield(self[index])
    end
    result
  end #my_each

  def my_each_with_index
    return self.to_enum if !block_given?
    result = []
    for index in 0..(self.size - 1) do
      result << self[index]
      yield self[index], index
    end 
    result
  end #my_each_with_index

  def my_select
    return self.to_enum if !block_given?
    result = []
    self.my_each do |index|
      if yield self[index]
        result << self[index]
      end
    end     
    result
  end #my_select

  def my_all? 
    return self.to_enum if !block_given?
    counter = 0
    self.my_each do |index|
      if yield self[index]
        counter += 1
      end
    end     
    counter == self.size ? true : false
  end #my_all?

  def my_any?
    return self.to_enum if !block_given?
    counter = 0
    self.my_each do |index|
      if yield self[index]
        counter += 1
      end
    end     
    counter > 0 ? true : false
  end #my_any?

  def my_none?
    return self.to_enum if !block_given?
    counter = 0
    self.my_each do |index|
      if yield self[index]
        counter += 1
      end
    end     
    counter == 0 ? true : false
  end #my_none?

  def my_count
    return self.to_enum if !block_given?
    counter = 0
    self.my_each do |index|
      if yield self[index]
        counter += 1
      end
    end     
    counter
  end #my_count

  def my_map
    return self.to_enum if !block_given?
    result = []
    self.my_each_with_index do |item, index|
      result << yield(self[index])
    end  
    result
  end #my_map1

  def my_map(&proc) # takes a proc instead
    return self.to_enum if !block_given?
    result = []
    self.my_each_with_index do |item, index|
      result << proc.call(self[index])
    end     
    result    
  end #my_map2

  def my_inject(arg1=nil, arg2=nil)
    if block_given? then
      unless arg1.nil? 
        memo = arg1
      else
        memo = self[0]
      end
      for x in 1..(self.size-1) do
        memo = yield(memo, self[x] )
      end
    else
      unless arg2.nil?
        sym = arg2
        memo = arg1
      else
        sym = arg1
        memo = self[0]
      end
      for x in 1..(self.size-1) do
        memo = memo.send(sym, self[x])
      end
    end
    memo
  end #my_inject
end 

def multiply_els(array)
  array.my_inject { |memo, item| memo * item }
end

p multiply_els([2,4,5])
#=> 40


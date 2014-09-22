def bubble_sort(array)
  new_array = array.clone
  loop do
    x, switcheroos = 0, 0
    while x < (new_array.size - 1) do
      if new_array[x] > new_array[x+1]
        new_array[x], new_array[x+1] = new_array[x+1], new_array[x]
          switcheroos += 1
      end
      x += 1
    end
    break if switcheroos == 0
  end
  new_array
end

array = [6,4,1,3,5,2].sort
p bubble_sort(array)
#=> [1, 2, 3, 4, 5, 6]


def bubble_sort_by(array, &proc)
  new_array = array.clone
  loop do
    x, switcheroos = 0, 0
    while x < (new_array.size - 1) do
      if proc.call(new_array[x], new_array[x+1]) < 0
        new_array[x], new_array[x+1] = new_array[x+1], new_array[x]
        switcheroos += 1
      end
      x += 1
    end
    break if switcheroos == 0 	
  end
  new_array
end

array = ["hi","hello","hey"]
p bubble_sort_by(array) { |left, right| right.length - left.length }
#=> ["hi", "hey", "hello"]

def substrings(string, dictionary)
  words = string.downcase.split(' ')
  words_found = Hash.new{0}
  
  dictionary.each do |x|
    words.each do |y|
    	words_found[x] += 1 if y.include?(x.downcase)
    end
  end

  words_found
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
#=> {"below"=>1, "low"=>1}
#=> {"down"=>1, "go"=>1, "going"=>1, "how"=>2, "howdy"=>1, "it"=>2, "i"=>3, "own"=>1, "part"=>1, "partner"=>1, "sit"=>1}

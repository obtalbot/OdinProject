def substrings(string, dictionary)
  words = string.downcase.split(' ')
  words_found = Hash.new{0}
  dictionary.each do |x|
    words.each do |y|
    	words_found[x] += 1 if y.include?(x.downcase)
    end
  end
  p words_found
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("below", dictionary)

substrings("Howdy partner, sit down! How's it going?", dictionary)

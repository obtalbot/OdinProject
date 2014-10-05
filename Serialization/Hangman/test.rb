

file = File.open('5desk.txt','r')

file = file.read
words = file.split(/\r\n/)

newwords = words.select { |w| w.length.between? 5, 12 }

secret = newwords[rand(newwords.length)].upcase
mistakes = 0
stat = ""
used = ""
#puts secret
guess = ""
secret.length.times do
  guess << "_"
end
puts "#{guess} [#{stat.ljust(7,' ')}]\n"

while mistakes < 7 do

  letter = gets.chomp.upcase
  indexes = []
  if secret.include?(letter)
    secret.each_char.with_index do |c, i|
      if c == letter 
        indexes << i
      end
    end
    indexes.each do |i|
      guess[i] = letter
    end
  else
    mistakes += 1
    used << letter
    stat << "X"
  end

  print "#{guess} [#{stat.ljust(7,' ')}] #{used}\n"

  break if !guess.include?("_")
end

puts secret
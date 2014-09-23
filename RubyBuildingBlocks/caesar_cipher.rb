def caesar_cipher(message, shift_factor)
  alphabet = [*("a".."z")]
  cipher = ""

  message.each_char do |char|
    if /[a-zA-Z]/.match(char)
      new_char = alphabet[alphabet.find_index(char.downcase) + shift_factor - alphabet.length]
      new_char.upcase! if char == char.upcase
      cipher << new_char
    else 
      cipher << char
    end
  end
	
  cipher
end	

p caesar_cipher("What a string!", 5)
# => Bmfy f xywnsl!


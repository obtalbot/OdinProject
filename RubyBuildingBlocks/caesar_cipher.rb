def caesar_cipher(message, shift_factor)
  alphabet = [*("a".."z")]
  new_message = ""

  message.each_char do |char|
    if /[a-zA-Z]/.match(char)
      new_char = alphabet[alphabet.find_index(char.downcase) + shift_factor - alphabet.length]
      new_char.upcase! if char == char.upcase
      new_message << new_char
    else 
      new_message << char
    end
  end
	
  new_message
end	

p caesar_cipher("What a string!", 5)
# => Bmfy f xywnsl!


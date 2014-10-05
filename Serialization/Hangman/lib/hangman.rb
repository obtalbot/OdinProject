require "yaml"

class Player
  attr_accessor :name, :guess
  attr_accessor :mistakes, :used, :stat

  def initialize
    get_name

    @guess = ""
    @stat = ""
    @used = ""
    @mistakes = 0
  end

  def get_name
    print "What's your name? "
    @name = gets.chomp
  end
end

class Secret
  attr_reader :word

  def initialize
    file = File.open('5desk.txt','r')
    words = file.read.split(/\r\n/)
    words = words.select { |w| w.length.between? 5, 12 }
    @word = words[rand(words.length)].upcase
  end
end

class Game
  def initialize(player)
    @player = player
    @secret = Secret.new

    @secret.word.length.times do
      @player.guess << "_"
    end
  end

  def play
    while @player.mistakes < 7 do
      display_guess
      user_input = get_input
      if user_input == "SAVE"
        save
        exit
      else
        rate_guess(user_input)
      end

      break if !@player.guess.include?("_")
    end

    puts @secret.word
  end

  def get_input
    input = ""
    until input.match(/[A-Z]/) do
      print "> "
      input = gets.chomp.strip.upcase
    end    
    return input if input == "SAVE"
    input[0]
  end

  def rate_guess(letter)
    indexes = []

    if @secret.word.include?(letter)
      @secret.word.each_char.with_index do |c, i|
        if c == letter 
          indexes << i
        end
      end
      indexes.each do |i|
        @player.guess[i] = letter
      end
    else
      @player.mistakes += 1
      @player.used << letter
      @player.stat << "X"
    end
  end

  def display_guess
    puts "#{@player.guess} [#{@player.stat.ljust(7,' ')}] #{@player.used}"
  end

  def check_for_saved_games
  end

  def save
    puts "..saving"
    filename = "#{@player.name}.json"
    File.open(filename,'w') do |file|
      file.puts YAML::dump(self)
    end
  end

  def load
  end
end


=begin
player = Player.new
game = Game.new(player)
game.play

=end

file = File.open("oj.json")
game = YAML::load(file)
game.play
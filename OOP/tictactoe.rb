class Board
  attr_reader :occupied_cells

	def initialize
		@grid = [["-","-","-"],["-","-","-"],["-","-","-"]]
    @occupied_cells = []
	end

	def display_board
		@grid.each do |row|
			row.each { |cell| print "|#{cell}" }
			puts "|\n"
		end
    puts "\n"
	end

	def set_cell(number, symbol)
    unless @occupied_cells.include? number
      cell = get_cell_mapping(number)
      @grid[cell[0]][cell[1]] = symbol
      @occupied_cells << number
    else
      return false
    end
	end

	def get_cell_mapping(number)
		case number
  		when 1 then [0,0]
  		when 2 then [0,1]
  		when 3 then [0,2]
  		when 4 then [1,0]
  		when 5 then [1,1]
  		when 6 then [1,2]
  		when 7 then [2,0]
  		when 8 then [2,1]
  		when 9 then [2,2]			
		end
	end
end


class Game
  require 'set'

  VALID_SYMBOLS = ["X","O"]
  WINNING_MOVES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    setup(@player1)
    setup(@player2)
    @winner_found = false
    @board = Board.new
    return nil
  end


  def play
    @board.display_board

    current_player = @player1
    next_player = @player2

    while !@winner_found do
      get_move(current_player)
      @board.display_board
      check_for_win(current_player)

      if @winner_found then
        puts "#{current_player} Wins!"
      end

      next_player, current_player = current_player, next_player
    end
  end

  def setup(player)
    print "Player name: "
    player.name = gets.chomp
    print "Player symbol: "
    player.symbol = gets.chomp
  end

  def get_move(player)
    print "Your move #{player.name} => "
    move = gets.chomp.to_i
    player.moves << move
    @board.set_cell(move,player.symbol)
  end

  def check_for_win(player)
    WINNING_MOVES.each do |winning_combo|
      if winning_combo.to_set.subset? player.moves.to_set then
        @winner_found = true
        break
      end
    end
  end
end

class Player
  attr_accessor :name, :symbol, :moves

  def initialize
    @name = ""
    @symbol = ""
    @moves = []
  end

  def to_s
    @name
  end
end
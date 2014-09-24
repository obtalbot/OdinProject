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
    if Game::VALID_MOVES.include?(number) && !@occupied_cells.include?(number) && 
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


class Player
  attr_accessor :name, :symbol, :moves

  def initialize(name=nil, symbol=nil)
    @name = name
    @symbol = symbol
    @moves = []
  end

  def to_s
    @name
  end

  def make_move(board)
    valid_move_made = false
    until valid_move_made do
      print "#{self.name}'s move => "
      move = gets.chomp.to_i

      if board.set_cell(move,@symbol)
        @moves << move
        valid_move_made = true
      else
        return false
      end
    end
    valid_move_made
  end

  def win?
    win = false
    Game::WINNING_MOVES.each do |combo|
      if combo.to_set.subset? @moves.to_set then
        win = true
      end
    end
    win
  end
end


class Game
  require 'set'

  VALID_MOVES = [*(1..9)]
  WINNING_MOVES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize
    @player1 = Player.new("Bob","x")
    @player2 = Player.new("Frank","o")
    @board = Board.new
  end


  def play
    @board.display_board

    current_player = @player1
    next_player = @player2
    winner_found = false

    9.times do
      until current_player.make_move(@board) do
        puts "Invalid move. Try again."
      end

      @board.display_board

      if current_player.win? then
        puts "#{current_player} Wins!"
        return
      end

      next_player, current_player = current_player, next_player
    end

    puts "No winner."
  end
end

game = Game.new
game.play
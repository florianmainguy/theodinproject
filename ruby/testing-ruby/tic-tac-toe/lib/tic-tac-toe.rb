# This Rspec excercise made me changed my Tic Tac Toe program.

# I improved the fact that each method should have its own purpose. It is much easier
# to test this way. And it's easier to read throught.

class Player
  attr_reader :name
  attr_reader :turn
  attr_reader :symbol

  def initialize(name, turn, symbol)
    @name = name
    @turn = turn
    @symbol = symbol
  end
end

class TicTacToe
  def initialize
    @table = { :a1 => " ", :a2 => " ", :a3 => " ",
               :b1 => " ", :b2 => " ", :b3 => " ",
               :c1 => " ", :c2 => " ", :c3 => " " }
  end

  # Displays Tic Tac Toe board
  def display
    puts "     A   B   C"
    puts "   -------------"
    puts " 1 | " + board(:a1) + " | " + board(:b1) + " | " + board(:c1) + " |"
    puts "   -------------"
    puts " 2 | " + board(:a2) + " | " + board(:b2) + " | " + board(:c2) + " |"
    puts "   -------------"
    puts " 3 | " + board(:a3) + " | " + board(:b3) + " | " + board(:c3) + " |"
    puts "   -------------"
  end  

  # Asks the player to select a case and returns it
  def case_chosen(player)
    puts"You turn, " + player.name.capitalize + ". Select a case:"
    loop do
      case_selected = gets.chomp.downcase
      return case_selected.to_sym if handle_selection(case_selected)
    end
  end

  # Checks that the selected case is correct and can be played
  def handle_selection(input)
    cases = ['a1','a2','a3','b1','b2','b3','c1','c2','c3']

    if !cases.include?(input)
      puts "Sorry I didn't understand. Which case ? (ex: a2, c3, b1)"
    elsif board(input.to_sym) != " "
      puts "Case already played ! Select another one:"
    else
      return true
    end
    return false
  end

  # Fills or displays only a board case
  def board(case_board, player_symbol = nil)
    if player_symbol
      @table[case_board] = player_symbol
    else
      @table[case_board]
    end
  end

  # Checks if a player won
  def victory?(sign)
    result = false
    win = [[:a1,:a2,:a3],[:b1,:b2,:b3],[:c1,:c2,:c3],[:a1,:b1,:c1],
           [:a2,:b2,:c2],[:a3,:b3,:c3],[:a1,:b2,:c3],[:a3,:b2,:c1]]
    win.each do |a,b,c|
      if board(a) == sign && board(b) == sign && board(c) == sign
        result = true
      end
    end
    result
  end

  # Launches the game
  def start
    puts "What's the name of Player 1 ?"
    player1 = Player.new(gets.chomp.downcase,1,"X")
    puts "What's the name of Player 2 ?"
    player2 = Player.new(gets.chomp.downcase,2,"O")
    puts "Let's start the game !"

    player = player1
    winner = nil
    stage = 1
    victory = false
    until stage == 10 || winner
      display
      board(case_chosen(player),player.symbol)
      winner = player.name if victory?(player.symbol)
      player == player1 ? player = player2 : player = player1
      stage += 1
    end
    display
    if winner
      puts "Well done " + winner.capitalize + " you won the game !"
    else
      puts "No winner."
    end
  end
end

#game = TicTacToe.new
#game.start

# Tic Tac Toe

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

  def display
  	puts "     A   B   C"
    puts "   -------------"
    puts " 1 | " + @table[:a1] + " | " + @table[:b1] + " | " + @table[:c1] + " |"
  	puts "   -------------"
  	puts " 2 | " + @table[:a2] + " | " + @table[:b2] + " | " + @table[:c2] + " |"
  	puts "   -------------"
  	puts " 3 | " + @table[:a3] + " | " + @table[:b3] + " | " + @table[:c3] + " |"
  	puts "   -------------"
  end  

  def case_chosen(player)
  	cases = ["a1","a2","a3","b1","b2","b3","c1","c2","c3"]
  	case_ok = false

    puts"You turn, " + player.name.capitalize + ". Select a case:"
    while(case_ok == false)
      case_selected = gets.chomp.downcase
      if !cases.include?(case_selected)
        puts "Sorry I didn't understand. Which case ? (ex: a2, c3, b1)"
        next
      elsif @table[case_selected.to_sym] != " "
      	puts case_selected.to_s.inspect
        puts "Case already played ! Select another one:"
        next
      else
      	case_ok = true
      end
    end
    case_selected
  end

  def fill_case(case_to_fill, player_symbol)
  	 @table[case_to_fill.to_sym] = player_symbol
  end

  def victory?(sign)
  	result = false
    win = [[:a1,:a2,:a3],[:b1,:b2,:b3],[:c1,:c2,:c3],[:a1,:b1,:c1],
           [:a2,:b2,:c2],[:a3,:b3,:c3],[:a1,:b2,:c3],[:a3,:b2,:c1]]
    win.each do |a,b,c|
      if @table[a] == sign && @table[b] == sign && @table[c] == sign
        result = true
      end
    end
    result
  end

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
      fill_case(case_chosen(player),player.symbol)
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

game = TicTacToe.new
game.start
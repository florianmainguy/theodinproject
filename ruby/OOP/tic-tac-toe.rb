# Tic Tac Toe


class Player
  attr_accessor :name
  attr_accessor :turn

  def initialize(name, turn)
    @name = name
    @turn = turn
  end
end

class Board
  attr_accessor :table

  def initialize
  	@table = { :a1 => "  ", :a2 => "  ", :a3 => "  ",
  		       :b1 => "  ", :b2 => "  ", :b3 => "  ",
  		       :c1 => "  ", :c2 => "  ", :c3 => "  " }
  end

  def display
  	puts "      A    B    C"
    puts "    --------------"
    puts " 1 | " + @table[:a1] + " | " + @table[:b1] + " | " + @table[:c1] + " |"
  	puts "    --------------"
  	puts " 2 | " + @table[:a2] + " | " + @table[:b2] + " | " + @table[:c2] + " |"
  	puts "    --------------"
  	puts " 3 | " + @table[:a3] + " | " + @table[:b3] + " | " + @table[:c3] + " |"
  	puts "    --------------"
  end  

  def choice_case(player)
  	cases = ["a1","a2","a3","b1","b2","b3","c1","c2","c3"]
  	case_ok = false

    puts"You turn, " + player.capitalize + ". Select a case:"
    while(case_ok == false)
      case_selected = gets.chomp.downcase
      if !cases.include?(case_selected)
        puts "Sorry I didn't understand. Which case ? (ex: a2, c3, b1)"
        next
      elsif @table[case_selected.to_sym] != "  "
      	puts case_selected.to_s.inspect
        puts "Case already played ! Select another one:"
        next
      else
      	case_ok = true
      end
    end
    case_selected
  end

  def fill_case(player_turn, case_to_fill)
  	if player_turn == 1
  	  @table[case_to_fill.to_sym] = "X"
  	else
  	  @table[case_to_fill.to_sym] = "O"
  	end
  end

  def victory
  	result = false
    if (@table[:a1] == "X" && @table[:a2] =="X" && @table[:a3] == "X") || (@table[:b1] == "X" && @table[:b2] == "X" && @table[:b3] == "X") || (@table[:c1] == "X" && @table[:c2] == "X" && @table[:c3] == "X") || (@table[:a1] == "X" && @table[:b1] == "X" && @table[:c1] == "X") || (@table[:a2] == "X" && @table[:b2] == "X" && @table[:c2] == "X") || (@table[:a3] == "X" && @table[:b3] == "X" && @table[:c3] == "X") || (@table[:a1] == "X" && @table[:b2] == "X" && @table[:c3] == "X") || (@table[:a3] == "X" && @table[:b2] == "X" && @table[:c1] == "X")
      result = true
    elsif (@table[:a1] == "O" && @table[:a2] == "O" && @table[:a3] == "O") || (@table[:b1] == "O" && @table[:b2] == "O" && @table[:b3] == "O") || (@table[:c1] == "O" && @table[:c2] == "O" && @table[:c3] == "O") || (@table[:a1] == "O" && @table[:b1] == "O" && @table[:c1] == "O") || (@table[:a2] == "O" && @table[:b2] == "O" && @table[:c2] == "O") || (@table[:a3] == "O" && @table[:b3] == "O" && @table[:c3] == "O") || (@table[:a1] == "O" && @table[:b2] == "O" && @table[:c3] == "O") || (@table[:a3] == "O" && @table[:b2] == "O" && @table[:c1] == "O")
      result = true
    end
    result
  end
end

game = Board.new
victory = false

puts "What's the name of Player 1 ?"
player1 = Player.new(gets.chomp.downcase,1)
puts "What's the name of Player 2 ?"
player2 = Player.new(gets.chomp.downcase,2)

puts "Let's start the game !"
player = player1
winner = nil
turn = 1
stage = 1
until stage == 10 || winner
  game.display
  game.fill_case(player.turn,game.choice_case(player.name))
  if game.victory
    winner = player.name
  end
  if player == player1
  	player = player2
  else
  	player = player1
  end
  stage += 1
end

game.display
if winner
  puts "Well done " + winner.capitalize + " you won the game !"
else
  puts "No winner."
end
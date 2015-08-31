# Mastermind

class Player
  attr_reader :name

  def initialize(name)
  	@name = name
  end
end

class Mastermind
  def initialize
  	@creator = nil
  	@secret_code = []
  	@guess = []
  	@memo_peg = []
  end
 
  # selects who creates the secret code: the human or the computer
  def select_creator
  	puts
  	puts "Hello and welcome to Mastermind !"
    puts "What's your name ?"
    player = Player.new(gets.chomp.downcase)

    puts
    puts "Ok " + player.name.capitalize + ", who is the creator of the secret code ?"
    puts "You (1) ? Or the computer (2) ?"
    @creator = gets.chomp.to_i
    until @creator == 1 || @creator == 2
      "Sorry I didn't understand. Type '1' for you or '2' for the computer."
      @creator = gets.chomp.to_i
    end
  end

  # generates the secret code for human or computer
  def generate_secret_code
  	if @creator == 1  # creator = human
  	  puts
  	  puts "Have a look at the color code below:"
  	  puts "Yellow = 1, Green = 2, Blue = 3, Red = 4, Orange = 5, Purple = 6"
  	  puts "Select your secret code (ex: 2-2-1-5):"
  	  @secret_code = get_code
  	else  # creator = computer
  	  4.times { |index| @secret_code[index] = rand(1..6).to_s }
    end
  end

  # gets a 4 digits code from the human
  def get_code
    code = gets.chomp.gsub(/\D/, '').split(//)
  	until code.length == 4
  	  puts "Sorry I need four numbers for the code. Select again:"
  	  code = gets.chomp.gsub(/\D/, '').split(//)
  	end
  	code
  end

  # takes a guess from the human or the computer
  def ask_a_guess
    if @creator == 2  # guesser = human
      @guess = get_code
    else  # guesser = computer
      4.times do |index|
      	if @memo_peg[index]
      	  @guess[index] = @memo_peg[index]
        else
          @guess[index] = rand(1..6).to_s
        end
      end
    end
    puts
    puts "Guess: " + @guess.join('-')
  end

  # compares guess with secret code and gives feedback
  def check_guess
  	correct_pegs = 0
  	close_pegs = 0
  	victory = false
  	@secret_code.each_with_index do |value, index|  # check if correct pegs
  	  @memo_peg[index] = value
      if value == @guess[index]
  	  	correct_pegs += 1 
  	  	@guess[index] = nil
  	  else
  	  	@memo_peg[index] = nil
  	  end
  	end
  	@secret_code.each_with_index do |value, index|  # check if close pegs
  	  if @guess.index(value) && @guess[index]
   	  	close_pegs += 1
  	  	@guess[@guess.index(value)] = 0
  	  end
  	end
    puts correct_pegs.to_s + " correct pegs"
  	puts close_pegs.to_s + " pegs not at the right place"
  	victory = true if correct_pegs == 4
  	victory
  end

  # game algorithm
  def start
    select_creator
    generate_secret_code
    puts
    puts "Allright, time to play ! 12 turns to find the secret code."
    puts "Have a look at the color code below if needed:"
  	puts "Yellow = 1, Green = 2, Blue = 3, Red = 4, Orange = 5, Purple = 6"
    12.times do |turn|
      puts
      puts "Turn " + (turn+1).to_s
      ask_a_guess
      if check_guess
      	puts
      	puts "Well done you found the secret code !"
      	break
      elsif turn == 11
      	puts
      	puts "End of game ! Sorry you lost."
      end
    end
    puts
    puts "The secret code was: " + @secret_code.join("-")
  end
end

game = Mastermind.new
game.start

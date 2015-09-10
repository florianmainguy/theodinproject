# Hangman
require 'yaml'

class Hangman
  def initialize
    @word_to_guess = []
    @word_uncomplete = []
  	@letters_played = []
  	@turn = 0
  end

  # Select the word we will try to guess
  def select_word_to_guess
    file = File.readlines "5desk.txt"
    @word_to_guess = file[rand(0..file.length)].chomp.split(//)
  end

  # Display the found letters surrounded by dashes
  def display_word
    if @turn == 0
  	  @word_to_guess.length.times { @word_uncomplete << '-'}
    end
    print @word_uncomplete.join('')
    puts "   Letters already played: " + @letters_played.join(',') if @turn != 0
  end

  # Ask the player for the next letter
  def select_letter
    puts
    puts "Please select a letter. Or 'S' to save"
    letter = gets.chomp
    if letter == 'S'
      save_game
    else
      letter.downcase!
    end
    until (letter.length == 1) && (('a'..'z').include? letter)
   	  puts "Sorry I need you to give me one letter, try again."
  	  letter = gets.chomp.downcase
    end
    letter
  end

  # Check if the letter selected is in the word to guess
  def check_letter(letter_selected)
    @word_to_guess.each_with_index do |letter,index|
  	  @word_uncomplete[index] = letter if letter.downcase == letter_selected
    end
    @letters_played << letter_selected
  end

  # Check if player found the word
  def check_victory
    @word_uncomplete == @word_to_guess
  end

  # Save the game in an external file
  def save_game
    Dir.mkdir('saved_games') unless Dir.exists? "saved_games"
    file = "saved_games/saved.yaml"
    File.open(file, "w+"){|f| f.puts YAML.dump(self) }
    puts "Game saved."
  end

  # Load the game from an external file
  def load_game
    game_file = File.open("saved_games/saved.yaml")
    yaml = game_file.read
    game_loaded = YAML::load(yaml)
    game_loaded.start
  end

  # Launches the game and ask if we want to carry on a loaded game
  def intro
  	puts "Welcome to Hangman! You have 15 turns."
    puts "Do you want to load a game? (y/n)"
    input = gets.chomp.downcase
    if input == "y"
      load_game
    else 
      select_word_to_guess
      start
    end
  end

  # Tells the player if he won or lost
  def result
    puts
    if @turn == 15
      puts "Sorry you lost. The word was '#{@word_to_guess.join('')}'"
    else
      puts "Well done you found the word! '#{@word_to_guess.join('')}'"
    end
  end

  # Actual gameplay of the hangman
  def start
    display_word
    win = false
    until win || @turn == 15
      @turn += 1
      check_letter(select_letter)
      display_word
      win = check_victory
    end
    result
  end
end

game = Hangman.new
game.intro
# Main algorithm

class Game
  attr_accessor :current_player, :other_player, :board

  def initialize
    board = Board.new
  end

  # Launch chess game
  def start
    welcome_players
    board.display
    until victory || draw
      next_turn
    end
  end

  private

  # Ask players names and which color they want to play
  def welcome_players
    puts "Welcome to this chess game!"
    puts "Give me the name of the player who wants to be White:"
    current_player = Player.new(gets.chomp.downcase, 'white')
    puts "Give me the name of the player who wants to be Black:"
    other_player = Player.new(gets.chomp.downcase, 'black')
    puts "Ok let's start!"
  end

  # Play next player's turn
  def next_turn
    puts "#{current_player.name}, your turn. Select a piece:"
    case_from = select_case
    piece = board.piece_of(case_from)
    if !piece
      puts "There is no piece on this case. Start again."
      break
    end
    if piece.color != current_player.color
      puts "This is not your piece! Start again."
      break
    end
    
    puts "Where do you want to move it? 'C' to select another piece."
    case_to = select_case
    break if case_to == 'C'
    if piece.possible_moves.include?(case_to)
      board.set_case(case_to, piece)
    else
      puts "You can't move your piece here. Start again."
      break
    end
    
    board.display

    temp = current_player
    current_player = other_player
    other_player = temp
  end

  # Select a case from the player
  def select_case
    selection = mapping(gets.chomp.downcase)
    unless selection
      puts "Sorry wrong input. Try again: (ex: e4)"
      selection = select_case
    end
    return selection
  end

  # Map the selected case to the actual board case
  def mapping(input)
    mapping = {
      'a1'=>[0,0], 'a2'=>[0,1], 'a3'=>[0,2], 'a4'=>[0,3], 'a5'=>[0,4], 'a6'=>[0,5],
      'a7'=>[0,6], 'a8'=>[0,7],
      'b1'=>[1,0], 'b2'=>[1,1], 'b3'=>[1,2], 'b4'=>[1,3], 'b5'=>[1,4], 'b6'=>[1,5],
      'b7'=>[1,6], 'b8'=>[1,7],
      'c1'=>[2,0], 'c2'=>[2,1], 'c3'=>[2,2], 'c4'=>[2,3], 'c5'=>[2,4], 'c6'=>[2,5],
      'c7'=>[2,6], 'c8'=>[2,7],
      'd1'=>[3,0], 'd2'=>[3,1], 'd3'=>[3,2], 'd4'=>[3,3], 'd5'=>[3,4], 'd6'=>[3,5],
      'd7'=>[3,6], 'd8'=>[3,7],
      'e1'=>[4,0], 'e2'=>[4,1], 'e3'=>[4,2], 'e4'=>[4,3], 'e5'=>[4,4], 'e6'=>[4,5],
      'e7'=>[4,6], 'e8'=>[4,7],
      'f1'=>[5,0], 'f2'=>[5,1], 'f3'=>[5,2], 'f4'=>[5,3], 'f5'=>[5,4], 'f6'=>[5,5],
      'f7'=>[5,6], 'f8'=>[5,7],
      'g1'=>[6,0], 'g2'=>[6,1], 'g3'=>[6,2], 'g4'=>[6,3], 'g5'=>[6,4], 'g6'=>[6,5],
      'g7'=>[6,6], 'g8'=>[6,7],
      'h1'=>[7,0], 'h2'=>[7,1], 'h3'=>[7,2], 'h4'=>[7,3], 'h5'=>[7,4], 'h6'=>[7,5],
      'h7'=>[7,6], 'h8'=>[7,7],
      'C' => 'C'
    }
    mapping[input]
  end

  # Return true if one player won
  def victory
  end

  # Return true if there is a draw
  def draw
  end
end
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'player.rb'

class Game
  attr_accessor :current_player, :other_player, :board

  def initialize
    @board = Board.new
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
    puts
    puts "Welcome to this chess game!"
    puts "Give me the name of the player who wants to be White:"
    @current_player = Player.new(gets.chomp.downcase, 'white')
    puts "Give me the name of the player who wants to be Black:"
    @other_player = Player.new(gets.chomp.downcase, 'black')
    puts "Ok let's start!"
  end

  # Play next player's turn:
  # The player has to select the case from which he wants to move the piece. Then, he
  # has to select the case where he wants to move the piece. If the move is authorized,
  # the piece is moved, the board displayed and the other player becomes the current one.
  def next_turn
    puts "#{current_player.name}, your turn. Select a piece:"
    case_from = select_case
    return if case_not_valid?(case_from, 'from')

    puts "Where do you want to move it? 'C' to select another piece."
    case_to = select_case
    return if case_to == 'C' || case_not_valid?(case_to, 'to')

    return if !move_possible?(case_from, case_to)
    move_piece(board, case_from, case_to) 

    board.display
    change_players
  end

  # Return the selected case by the current player in an array
  # ex: e4 => [4,3]
  def select_case
    selection = mapping(gets.chomp.downcase)
    unless selection
      puts "Sorry wrong input. Try again: (ex: e4)"
      selection = select_case
    end
    return selection
  end

  # Return true if the player is not allowed to play the selected case
  def case_not_valid?(case_selected, input)
    piece = board.get_case(case_selected)

    # case_from
    if input == 'from'
      if piece.nil?
        puts "There is no piece on this case. Start again."
        return true
      elsif piece.color != current_player.color
        puts "This is not your piece! Start again."
        return true
      end
    # case_to
    elsif input == 'to'
      if piece.nil?
        return false
      elsif piece.color == current_player.color
        puts "This is not your piece! Start again."
        return true
      end
    end
    return false
  end

  # Return true if the piece can move from and to the selected case
  def move_possible? (case_from, case_to)
    piece = board.get_case(case_from)
    move = [case_to[0] - case_from[0], case_to[1] - case_from[1]]

    # Check if move is coherent with piece's way of displacement
    if piece.possible_moves.exclude?(move)
      puts "This piece can't move like that! Start again."
      return false 
    end

    # Check if obstruction on path for sliding pieces
    if piece.type == 'slide' && no_obstruction?(piece, case_from, case_to)
      puts "Obstruction in the path. Start again"
      return false 
    end

    # Check if a pawn can go in diag
    if piece.is_a?(Pawn) && move[1] != 0
      return false if pawn_cant_diag(piece, case_to)
    end

    # Create a copy of 'board' for following tests
    board_temp = board
    move_piece(board_temp, case_from, case_to)

    # Check if kings stand one case apart
    if kings_too_close?(board_temp)
      puts "Kings can't be that close. Start again."
      return false 
    end

    # Check if king of current's player would be in check
    if king_check?(board_temp, current_player)
      "If you do that, your king will be in check! Start again."
      return false 
    end

    return true
  end

  # Return true if there is no obstacles on the path of a sliding piece
  def no_obstruction?(piece, case_from, case_to)
    piece.possible_moves.each do |coord|
      next_case = case_from
      loop do
        next_case = [[next_case[0] + coord[0]], [next_case[1] + coord[1]]]
        return true if next_case == case_to
        break if offboard(next_case) || !empty?(next_case)
      end
    end
  end
      
  # Move the piece to the selected case
  def move_piece (board_used , case_from, case_to)
    piece = board.get_case(case_from)

    board_used.set_case(case_to, piece)
    board_used.set_case(case_from, nil)
  end

  # Change order of players
  def change_players
    temp = current_player
    current_player = other_player
    other_player = temp
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
      'c' =>['C']
    }
    mapping[input]
  end

  # Return true if the case selected is free
  def empty?(case_selected)
    if case_selected == nil
      return true
    end
    return false
  end

  # Return true if the case selected is offboard
  def offboard(coord)
    return true if coord[0] < 0 || coord[0] > 7 ||
                   coord[1] < 0 || coord[1] > 7
  end

  # Return king of given player
  def find_king(player)
    board.grid.each do |col|
      col.each do |cell|
        if cell
          return cell if cell.is_a?(King) && cell.color == player.color
        end
      end
    end
  end

  # Return true if one player won
  def victory
    if king_check?(board, current_player)
      puts "Check!"
      if king_checkmate?
        puts "Well done #{other_player} you won!"
        return true
      end
    end
    return false
  end

  # Return true if kings are one case apart
  def kings_too_close?(board_used)
    king1 = find_king(current_player)
    return true if king1.possible_moves.include?(find_king(other_player))
  end

  # Return true if the given king is in check
  def king_check?(board_used, player)
    x = find_king(player).location[0]
    y = find_king(player).location[1]
    return true if check_diag?(board_used, x, y) || check_line?(board_used, x, y) ||
                   check_knight?(board_used, x, y) || check_pawn?(board_used, x, y)
  end

  # Return true if king is in check by a diag piece
  def check_diag?(board_used, x, y)
    diag = [[x-1, y+1], [x+1, y+1], [x+1, y-1], [x-1, y-1]]

    diag.each do |coord|
      next_case = [x, y]
      loop do
        next_case = [next_case[0] + coord[0], next_case[1] + coord[1]]
        break if offboard(next_case)
        next if empty?(next_case)
        piece = board_used.get_case(next_case)
        if piece.color == current_player.color
          return true if piece.is_a?(Queen) || piece.is_a?(Bishop)
        end
      end
    end
  end

  # Return true if king is in check by a line piece
  def check_line?(board_used, x, y)
    line = [[x, y+1], [x+1, y], [x, y-1], [x-1, y]]

    line.each do |coord|
      next_case = [x, y]
      loop do
        next_case = [next_case[0] + coord[0], next_case[1] + coord[1]]
        break if offboard(next_case)
        next if empty?(next_case)
        piece = board_used.get_case(next_case)
        if piece.color == current_player.color
          return true if piece.is_a?(Queen) || piece.is_a?(Rook)
        end
      end
    end
  end

  # Return true if king is in check by a knight
  def check_knight?(board_used, x, y)
    knight = [[x-2, y-1], [x-2, y+1], [x-1, y+2], [x+1, y+2],
              [x+2, y+1], [x+2, y-1], [x+1, y-2], [x-1, y-2]]

    knight.each do |coord|
      next_case = [coord[0], coord[1]]
      break if offboard(next_case)
      next if empty?(next_case)
      piece = board_used.get_case(next_case)
      if piece.color == current_player.color
        return true if piece.is_a?(Knight)
      end
    end
  end

  # Return true if king is in check by a pawn
  def check_pawn?(board_used, x, y)
    pawn = [[x-1, y+1], [x+1, y+1]]

    pawn.each do |coord|
      next_case = [coord[0], coord[1]]
      break if offboard(next_case)
      next if empty?(next_case)
      piece = board_used.get_case(next_case)
      if piece.color == current_player.color
        return true if piece.is_a?(Pawn)
      end
    end
  end

  # Return true if the given king is checkmate
  def king_checkmate?
    puts "Is there checkmate? Y/N"
    answer = gets.chomp.upcase
    return true if answer == 'Y'
    return false
  end

  # Return true if there is a draw
  def draw
    counter = 0
    board.grid.each do |col|
      col.each do |cell|
        counter +=1 if cell
      end
    end
    return true if counter < 3
    return false
  end

  # Return true if pawn can't move in diag
  def pawn_cant_diag (piece, case_to)
    case_selected = get_case(case_to)
    return true if case_selected.empty?
    return true if case_selected.color == piece.color
    return false
  end
end
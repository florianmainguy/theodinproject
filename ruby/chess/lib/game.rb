# Small and big castling to implement
# Pat

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
  # 'C' allows the player to start again his turn.
  def next_turn
    puts
    puts "#{current_player.name.capitalize}, your turn. Select a piece:"
    case_from = select_case
    return if case_from == 'C' || case_not_valid?(case_from, 'from')

    puts "Where do you want to move it? 'C' to select another piece."
    case_to = select_case
    return if case_to == 'C' || case_not_valid?(case_to, 'to')

    answer = move_possible(case_from, case_to)
    if !answer[0]
      puts answer[1]
      return
    end
    move_piece(case_from, case_to) 

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
      'c' => 'C'
    }
    mapping[input]
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
        puts "This is your piece! Start again."
        return true
      end
    end
    return false
  end

  # Return an array of 2 elements:
  # - a boolean, true if the piece can move from and to the selected case
  # - a string describing the error if piece can't move
  def move_possible(case_from, case_to)
    piece = board.get_case(case_from)
    move = [case_to[0] - case_from[0], case_to[1] - case_from[1]]

    # Check if castling 
    if piece.is_a?(King)
      if move == [-2, 0] || move == [2, 0]
        can_castle?(piece, move) ? answer = [true] : answer = [false, "Can't castle sorry."]
        return answer
      end 
    end

    # Check if move is coherent with piece's way of displacement
    if piece.type == 'step' && !piece.possible_moves.include?(move)
      answer = [false, "This piece can't move like that! Start again."]
      return answer
    end

    # Check if obstruction on path for sliding pieces
    if piece.type == 'slide' && obstruction?(piece, case_from, case_to)
      answer = [false, "Obstruction in the path. Start again."]
      return answer
    end

    # Check if a pawn can go in diag and can move up to 2 cases
    if piece.is_a?(Pawn)
      answer = [false, "Pawn can't move like that."]
      if move[0] != 0
        return answer if pawn_cant_diag(piece, case_to)
      elsif move[1] == 2 || move[1] == -2
        return answer if pawn_cant_double(piece, case_from)
      end
    end

    # Temporary move for the next tests
    board.set_case(case_from, nil)
    temp_piece = board.get_case(case_to)
    board.set_case(case_to, piece)
    answer = [true]

    # Check if kings stand one case apart
    if kings_too_close?
      answer = [false, "Kings can't be that close. Start again."]
    end

    # Check if king of current's player would be in check
    if king_check?(find_king(current_player))
      answer = [false, "If you do that, your king will be in check! Start again."]
    end

    # Come back to previous state before temporary move
    board.set_case(case_from, piece)
    board.set_case(case_to, temp_piece)
    return answer
  end

  # Return true if there are obstacles on the path of a sliding piece
  def obstruction?(piece, case_from, case_to)
    piece.possible_moves.each do |coord|
      next_case = case_from
      loop do
        next_case = [next_case[0] + coord[0], next_case[1] + coord[1]]
        return false if next_case == case_to
        break if offboard(next_case) || !empty?(next_case)
      end
    end
  end
      
  # Move the piece to the selected case
  def move_piece(case_from, case_to)
    piece = board.get_case(case_from)

    # Case when pawn reaches last line
    piece = change_pawn(piece) if pawn_reached_end?(piece, case_to)

    board.set_case(case_to, piece)
    board.set_case(case_from, nil)

    piece.counter += 1
  end

  # Return true if pawn reached the last line
  def pawn_reached_end?(piece, case_to)
    if piece.is_a?(Pawn)
      return true if case_to[1] == 0 || case_to[1] == 7
    end
    return false
  end

  # Ask the player if he wants to change the pawn in another piece and return it
  def change_pawn(piece)
    puts "Do you want to change the piece in another piece?"
    puts "'Q' for Queen, 'R' for Rook, 'B' for Bishop, 'K' for knight"
    puts "or 'P' if you want to keep a Pawn"
    loop do
      input = gets.chomp.upcase
      case input
      when 'Q'
        new_piece = Queen.new(piece.color, piece.location, 'slide')
      when 'R'
        new_piece = Rook.new(piece.color, piece.location, 'slide')
      when 'B'
        new_piece = Bishop.new(piece.color, piece.location, 'slide')
      when 'K'
        new_piece = Knight.new(piece.color, piece.location, 'slide')
      when 'P'
        new_piece = piece
      else
        puts "Wrong input. Try again"
        next
      end
      return new_piece
    end 
  end

  # Change order of players
  def change_players
    temp = self.current_player
    self.current_player = self.other_player
    self.other_player = temp
  end

  # Return true if the case selected is free of pieces
  def empty?(case_selected)
    if board.get_case(case_selected) == nil
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
    king = find_king(current_player)
    the_bad = king_check?(king)
    if the_bad
      if king_checkmate?(king, the_bad)
        puts "Checkmate!"
        puts "Well done #{other_player.name} you won!"
        return true
      else
        puts "Check!"
      end
    end
    return false
  end

  # Return true if the given king is in check
  def king_check?(king)
    x = king.location[0]
    y = king.location[1]
    return check_slide?(x, y, 'diag') || check_slide?(x, y, 'line') ||
           check_step?(x, y, 'knight') || check_step?(x, y, 'pawn')
  end

  # Return true if king is in check by a sliding piece
  def check_slide?(x, y, input)
    diag = [[-1, 1], [1, 1], [1,-1], [-1,-1]]
    line = [[ 0, 1], [ 1, 0], [ 0,-1], [-1, 0]]

    input == 'diag' ? direction = diag : direction = line

    direction.each do |coord|
      next_case = [x, y]
      path = []
      loop do
        next_case = [next_case[0] + coord[0], next_case[1] + coord[1]]
        break if offboard(next_case)
        if empty?(next_case)
          path.push(next_case)
          next 
        end
        piece = board.get_case(next_case)
        if piece.color == other_player.color
          if direction == diag
            if piece.is_a?(Queen) || piece.is_a?(Bishop)
              piece.path = path
              return piece 
            end
          elsif direction == line
            if piece.is_a?(Queen) || piece.is_a?(Rook)
            piece.path = path
            return piece 
          end
          end
        else
          break
        end
      end
    end
    return false
  end

  # Return true if king is in check by a stepping piece
  def check_step?(x, y, input)
    knight = [[-2,-1], [-2, 1], [-1, 2], [ 1, 2],
              [ 2, 1], [ 2,-1], [ 1,-2], [-1,-2]]
    pawn = [[-1, 1], [ 1, 1]]

    input == 'knight' ? direction = knight : direction = pawn

    direction.each do |coord|
      next_case = [coord[0] + x, coord[1] + y]
      next if offboard(next_case)
      next if empty?(next_case)
      piece = board.get_case(next_case)
      if piece.color == other_player.color
        return piece if piece.is_a?(Knight) && direction == knight
        return piece if piece.is_a?(Pawn) && direction == pawn
      else
        break
      end
    end
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
  def pawn_cant_diag(piece, case_to)
    return true if empty?(case_to)
    case_selected = board.get_case(case_to)
    return true if case_selected.color == piece.color
    return false
  end

  # Return true if pawn can move up to 2 cases
  def pawn_cant_double(piece, case_from)
    if piece.color == 'white'
      return true if case_from[1] != 1
    elsif piece.color == 'black'
      return true if case_from[1] != 6
    end
    return false
  end

  # Return true if the given king is checkmate
  def king_checkmate?(king, the_bad)
    # Not checkmate if king can move
    return false if king_can_move?(king)

    # Not checkmate if adverse piece can be taken or path obstructed
    if the_bad.type == 'step'
      return false if can_be_taken?(the_bad)
    elsif the_bad.type == 'slide'
      return false if can_be_taken?(the_bad) || can_be_obstructed?(the_bad)
    end

    return true
  end

  # Return true if there is at least one empty case around the king
  def king_can_move?(king)
    current_case = king.location
    king.possible_moves.each do |coord|
      next_case = [current_case[0] + coord[0], current_case[1] + coord[1]]
      next if offboard(next_case)
      if empty?(next_case)
        move_piece(current_case, next_case)
        if king_check?(king)
          move_piece(next_case, current_case)
          next
        else
          move_piece(next_case, current_case)
          return true
        end
      end
    end
    return false
  end

  # Return true if piece can be taken by adverse piece
  def can_be_taken?(the_bad)
    the_bad.color == 'white' ? color = 'black' : color = 'white'
    case_to = the_bad.location
    pieces = find_pieces(color)
    pieces.each do |piece|
      case_from = piece.location
      answer = move_possible(case_from, case_to)
      return true if answer[0]
    end
    return false
  end

  # Return true if piece can be obstructed by adverse piece
  def can_be_obstructed?(the_bad)
    the_bad.color == 'white' ? color = 'black' : color = 'white'
    pieces = find_pieces(color)
    the_bad.path.each do |case_to|
      pieces.each do |piece|
        case_from = piece.location
        answer = move_possible(case_from, case_to)
        return true if answer[0]
      end
    end
    return false
  end

  # Return true if kings are one case apart
  def kings_too_close?
    king1 = find_king(current_player)
    king2 = find_king(other_player)
    king1.possible_moves.each do |coord|
      next_case = [king1.location[0] + coord[0], king1.location[1] + coord[1]]
      return true if next_case == king2.location
    end
    return false
  end

  # Return an array with all the pieces of the given color
  def find_pieces(color)
    array = []
    board.grid.each do |column|
      column.each do |piece|
        next if !piece
        array.push(piece) if piece.color == color
      end
    end 
    array
  end

  # Return an array with the first element as an array indicating if king can
  # castle or not
  def can_castle?(king, move)
    if move == [-2, 0]
      path = [[0,3], [0,2], [0,1], [0,0]] if king.color == 'white'
      path = [[7,3], [7,2], [7,1], [7,0]] if king.color == 'black'
    elsif move == [ 2, 0]
      path = [[0,5], [0,6], [0,7]] if king.color == 'white'
      path = [[7,5], [7,6], [7,7]] if king.color == 'black'
    end



    king & rook never moved

    squares in between empty

    king not in check on path

  end
end
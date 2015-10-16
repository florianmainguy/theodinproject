# Parent class of all pieces
class Pieces
  attr_reader :unicode, :color, :type
  attr_accessor :location

  def initialize (color, location, type)
    @color = color
    @location = location
    @type = type
  end
end

class King < Pieces
  def initialize (color, location, type)
    super
    @color == 'white' ? @unicode = "\u2654" : @unicode = "\u265A"
  end

  def possible_moves
    x = location[0]
    y = location[1]
    moves = [[-1, 0], [-1, 1], [ 0, 1], [ 1, 1],
             [ 1, 0], [ 1,-1], [ 0,-1], [-1,-1]]
    moves
  end
end

class Queen < Pieces
  def initialize (color, location, type)
    super
    @color == 'white' ? @unicode = "\u2655" : @unicode = "\u265B"
  end

  def possible_moves
    x = location[0]
    y = location[1]
    moves = [[-1, 0], [ 1, 1], [ 0, 1], [ 1, 1],
             [ 1, 0], [ 1,-1], [ 0,-1], [-1,-1]]
    moves
  end
end

class Rook < Pieces
  def initialize (color, location, type)
    super
    @color == 'white' ? @unicode = "\u2656" : @unicode = "\u265C"
  end

  def possible_moves
    x = location[0]
    y = location[1]
    moves = [[-1, 0], [ 0, 1], [ 1, 0], [ 0,-1]]
    moves
  end
end

class Bishop < Pieces
  def initialize (color, location, type)
    super
    @color == 'white' ? @unicode = "\u2657" : @unicode = "\u265D"
  end

  def possible_moves
    x = location[0]
    y = location[1]
    moves = [[ 1, 1], [ 1, 1], [ 1,-1], [-1,-1]]
    moves
  end
end

class Knight < Pieces
  def initialize (color, location, type)
    super
    @color == 'white' ? @unicode = "\u2658" : @unicode = "\u265E"
  end

  def possible_moves
    x = location[0]
    y = location[1]
    moves = [[-2,-1], [-2, 1], [-1, 2], [ 1, 2],
             [ 2, 1], [ 2,-1], [-1,-2], [ 1,-2]]
    moves
  end
end

class Pawn < Pieces
  def initialize (color, location, type)
    super
    @color == 'white' ? @unicode = "\u2659" : @unicode = "\u265F"
  end

  def possible_moves
    if color == 'white'
      moves = [[-1, 1], [ 0, 1], [ 1, 1]]
    else
      moves = [[ 1,-1], [ 0,-1], [-1,-1]]
    end
    moves
  end
end
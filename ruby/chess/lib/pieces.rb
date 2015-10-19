# Parent class of all pieces.
class Pieces
  attr_reader :unicode, :color, :type
  attr_accessor :location, :path, :counter

  def initialize (color, location, type, counter = 0)
    @color = color
    @location = location
    @type = type
    @counter = counter
  end
end

class King < Pieces
  def initialize (color, location, type, counter = 0)
    super
    @color == 'white' ? @unicode = "\u2654" : @unicode = "\u265A"
  end

  def possible_moves
    moves = [[-1, 0], [-1, 1], [ 0, 1], [ 1, 1],
             [ 1, 0], [ 1,-1], [ 0,-1], [-1,-1],
             [-2, 0], [ 2, 0]]
    moves
  end
end

class Queen < Pieces
  def initialize (color, location, type, counter = 0)
    super
    @color == 'white' ? @unicode = "\u2655" : @unicode = "\u265B"
    @path = []
  end

  def possible_moves
    moves = [[-1, 0], [-1, 1], [ 0, 1], [ 1, 1],
             [ 1, 0], [ 1,-1], [ 0,-1], [-1,-1]]
    moves
  end
end

class Rook < Pieces
  def initialize (color, location, type, counter = 0)
    super
    @color == 'white' ? @unicode = "\u2656" : @unicode = "\u265C"
    @path = []
  end

  def possible_moves
    moves = [[-1, 0], [ 0, 1], [ 1, 0], [ 0,-1]]
    moves
  end
end

class Bishop < Pieces
  def initialize (color, location, type, counter = 0)
    super
    @color == 'white' ? @unicode = "\u2657" : @unicode = "\u265D"
    @path = []
  end

  def possible_moves
    moves = [[-1, 1], [ 1, 1], [ 1,-1], [-1,-1]]
    moves
  end
end

class Knight < Pieces
  def initialize (color, location, type, counter = 0)
    super
    @color == 'white' ? @unicode = "\u2658" : @unicode = "\u265E"
  end

  def possible_moves
    moves = [[-2,-1], [-2, 1], [-1, 2], [ 1, 2],
             [ 2, 1], [ 2,-1], [-1,-2], [ 1,-2]]
    moves
  end
end

class Pawn < Pieces
  def initialize (color, location, type, counter = 0)
    super
    @color == 'white' ? @unicode = "\u2659" : @unicode = "\u265F"
  end

  def possible_moves
    if color == 'white'
      moves = [[-1, 1], [ 0, 1], [ 1, 1], [ 0, 2]]
    else
      moves = [[ 1,-1], [ 0,-1], [-1,-1], [ 0,-2]]
    end
    moves
  end
end
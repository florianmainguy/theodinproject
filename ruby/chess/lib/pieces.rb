# -*- coding: utf-8 -*-

class Pieces
  attr_reader :unicode, :color
  attr_accessor :location

  def initialize

  end
end

class King < Pieces
  def initialize (color, location)
    @color = color
    @location = location
    @color == 'white' ? @unicode = "\u2654" : @unicode = "\u265A"
  end

  def possible_moves
    x = location[0]
    y = location[1]
    moves = [[x-1, y], [x-1, y+1]...]
    # fill all possible moves
    # each
    # si dans le tableau, ajouter a array

    moves
  end
end

class Queen < Pieces
  def initialize (color, location)
    @color = color
    @location = location
    @color == 'white' ? @unicode = "\u2655" : @unicode = "\u265B"
  end
end

class Rook < Pieces
  def initialize (color, location)
    @color = color
    @location = location
    @color == 'white' ? @unicode = "\u2656" : @unicode = "\u265C"
  end
end

class Bishop < Pieces
  def initialize (color, location)
    @color = color
    @location = location
    @color == 'white' ? @unicode = "\u2657" : @unicode = "\u265D"
  end
end

class Knight < Pieces
  def initialize (color, location)
    @color = color
    @location = location
    @color == 'white' ? @unicode = "\u2658" : @unicode = "\u265E"
  end
end

class Pawn < Pieces
  def initialize (color, location)
    @color = color
    @location = location
    @color == 'white' ? @unicode = "\u2659" : @unicode = "\u265F"
  end
end
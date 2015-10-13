# -*- coding: utf-8 -*-

class Pieces

  def initialize()
  
  end
end

class King < Pieces
  attr_reader :unicode

  def initialize (color)
    color == 'white' ? @unicode = "\u2654" : @unicode = "\u265A"
  end
end

class Queen < Pieces
  attr_reader :unicode

  def initialize (color)
    color == 'white' ? @unicode = "\u2655" : @unicode = "\u265B"
  end
end

class Rook < Pieces
  attr_reader :unicode

  def initialize (color)
    color == 'white' ? @unicode = "\u2656" : @unicode = "\u265C"
  end
end

class Bishop < Pieces
  attr_reader :unicode

  def initialize (color)
    color == 'white' ? @unicode = "\u2657" : @unicode = "\u265D"
  end
end

class Knight < Pieces
  attr_reader :unicode

  def initialize (color)
    color == 'white' ? @unicode = "\u2658" : @unicode = "\u265E"
  end
end

class Pawn < Pieces
  attr_reader :unicode

  def initialize (color)
    color == 'white' ? @unicode = "\u2659" : @unicode = "\u265F"
  end
end
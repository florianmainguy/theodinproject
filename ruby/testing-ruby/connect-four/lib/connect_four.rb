# Connect Four
#
# The objective of the game is to connect four of one's own discs of the same color
# next to each other vertically, horizontally, or diagonally.

class Player
  attr_reader :name, :color

  def initialize(input)
    @name = input.fetch(:name)
    @color = input.fetch(:color)
  end
end

class CellNode
  attr_accessor :color, :left, :up, :right, :down, :diag_lu, :diag_ld, :diag_ru, :diag_rd

  def initialize(color = "")
    @color = color
  end
end

class Board
  attr_reader :grid

  def initialize
    @grid = default_grid
  end

  def default_grid
  end

end

class ConnectFour

end
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

class Cell

end

class ConnectFour

end
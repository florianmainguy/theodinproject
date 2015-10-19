# Class for the players. Their name and which color they play.
class Player
  attr_reader :name, :color

  def initialize (name, color)
    @name = name
    @color = color
  end
end
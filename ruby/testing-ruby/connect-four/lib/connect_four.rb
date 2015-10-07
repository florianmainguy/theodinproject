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
  attr_accessor :color, :left, :up, :right, :down, :lu, :ld, :ru, :rd

  def initialize(color = "")
    @color = color
  end
end



class Board
  attr_reader :grid
  attr_accessor :last_cell_played

  def initialize(grid = nil)
    @grid = grid || default_grid
    connect_cells if @grid.is_a?(Array)
  end

  # Returns cell at coordinate (x, y)
  def get_cell(x, y)
    grid[x][y]
  end

  # Sets color of cell (x, y)
  def set_cell(x, y, color)
    get_cell(x, y).color = color
    last_cell_played = get_cell(x, y)
  end

  # Returns :winner if there is a winner, :draw if there is a draw,
  # or false if the game is still being played
  def game_over
    return :winner if winner?
    return :draw if draw?
    false
  end

  private

  # Sets a default grid of 7 columns and 7 rows
  def default_grid
    Array.new(7) { Array.new(6) { CellNode.new }}
  end

  # Links cells between them
  def connect_cells
    @grid.each_with_index do |columns, col_i|
      columns.each_with_index do |cell, cell_i|
        cell.left  = @grid[col_i-1][cell_i]   if col_i != 0 
        cell.up    = @grid[col_i][cell_i+1]   if cell_i + 1 < columns.length
        cell.right = @grid[col_i+1][cell_i]   if col_i + 1 < @grid.length
        cell.down  = @grid[col_i][cell_i-1]   if cell_i != 0
        cell.lu    = @grid[col_i-1][cell_i+1] if col_i != 0 && cell_i + 1 < columns.length
        cell.ld    = @grid[col_i-1][cell_i-1] if col_i != 0 && cell_i != 0
        cell.ru    = @grid[col_i+1][cell_i+1] if col_i + 1 < @grid.length && cell_i + 1 < columns.length
        cell.rd    = @grid[col_i+1][cell_i-1] if col_i + 1 < @grid.length && cell_i != 0
      end
    end
  end

  # Returns true if there is a draw
  def draw?
    @grid.each { |columns| columns.each { |cell| return false if cell.color == ''}}
    return true
  end

  # Returns true if there is a winner
  def winner?
    return true if check_horizontal
    return true if check_vertical
    return true if check_diagonal1
    return true if check_diagonal2
    false
  end

  # Returns true if 4 same cells horizontally
  def check_horizontal
    cell = last_cell_played
    count = 1
    while cell.left && cell.left.color == cell.color
      cell = cell.left
    end
    while cell.right && cell.right.color == cell.color
      cell = cell.right
      count += 1
    end
    return true if count >= 4
    false
  end

  # Returns true if 4 same cells vertically
  def check_vertical
    cell = last_cell_played
    count = 1
    while cell.down && cell.down.color == cell.color
      cell = cell.down
    end
    while cell.up && cell.up.color == cell.color
      cell = cell.up
      count += 1
    end
    return true if count >= 4
    false
  end

  # Returns true if 4 same cells on one diagonal
  def check_diagonal1
    cell = last_cell_played
    count = 1
    while cell.ld && cell.ld.color == cell.color
      cell = cell.ld
    end
    while cell.ru && cell.ru.color == cell.color
      cell = cell.ru
      count += 1
    end
    return true if count >= 4
    false
  end

  # Returns true if 4 same cells on the other diagonal
  def check_diagonal2
    cell = last_cell_played
    count = 1
    while cell.rd && cell.rd.color == cell.color
      cell = cell.rd
    end
    while cell.lu && cell.lu.color == cell.color
      cell = cell.lu
      count += 1
    end
    return true if count >= 4
    false
  end
end

class ConnectFour
  def initialize
  end
  def game
  end

end
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
  attr_accessor :last_cell_played

  def initialize(grid = nil)
    @grid = grid || default_grid
    connect_cells #if grid.nil?
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
    @grid.each_with_index do |columns, columns_index|
      columns.each_with_index do |cell, cell_index|
        cell.left    = @grid[columns_index - 1][cell_index]     || nil if @grid[columns_index - 1]
        cell.up      = @grid[columns_index][cell_index + 1]     || nil if @grid[columns_index]
        cell.right   = @grid[columns_index + 1][cell_index]     || nil if @grid[columns_index + 1]
        cell.down    = @grid[columns_index][cell_index - 1]     || nil if @grid[columns_index]
        cell.diag_lu = @grid[columns_index - 1][cell_index + 1] || nil if @grid[columns_index - 1]
        cell.diag_ld = @grid[columns_index - 1][cell_index - 1] || nil if @grid[columns_index - 1]
        cell.diag_ru = @grid[columns_index + 1][cell_index + 1] || nil if @grid[columns_index + 1]
        cell.diag_rd = @grid[columns_index + 1][cell_index - 1] || nil if @grid[columns_index + 1]
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
      ###BUGBUGBUGBUG puts "youhou"
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
    while cell.diag_ld && cell.diag_ld.color == cell.color
      cell = cell.diag_ld
    end
    while cell.diag_ru && cell.diag_ru.color == cell.color
      cell = cell.diag_ru
      count += 1
    end
    return true if count >= 4
    false
  end

  # Returns true if 4 same cells on the other diagonal
  def check_diagonal2
    cell = last_cell_played
    count = 1
    while cell.diag_rd && cell.diag_rd.color == cell.color
      cell = cell.diag_rd
    end
    while cell.diag_lu && cell.diag_lu.color == cell.color
      cell = cell.diag_lu
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
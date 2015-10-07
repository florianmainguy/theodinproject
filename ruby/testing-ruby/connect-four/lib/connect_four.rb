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

  def initialize(color = " ")
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

  # Displays the board
  def display
    puts
    puts "   -----------------------------"
    puts " 6 | "+grid[0][5].color+" | "+grid[1][5].color+" | "+grid[2][5].color+" | "+grid[3][5].color+" | "+grid[4][5].color+" | "+grid[5][5].color+" | "+grid[6][5].color+" | "
    puts "   -----------------------------"
    puts " 5 | "+grid[0][4].color+" | "+grid[1][4].color+" | "+grid[2][4].color+" | "+grid[3][4].color+" | "+grid[4][4].color+" | "+grid[5][4].color+" | "+grid[6][4].color+" | "
    puts "   -----------------------------"
    puts " 4 | "+grid[0][3].color+" | "+grid[1][3].color+" | "+grid[2][3].color+" | "+grid[3][3].color+" | "+grid[4][3].color+" | "+grid[5][3].color+" | "+grid[6][3].color+" | "
    puts "   -----------------------------"
    puts " 3 | "+grid[0][2].color+" | "+grid[1][2].color+" | "+grid[2][2].color+" | "+grid[3][2].color+" | "+grid[4][2].color+" | "+grid[5][2].color+" | "+grid[6][2].color+" | "
    puts "   -----------------------------"
    puts " 2 | "+grid[0][1].color+" | "+grid[1][1].color+" | "+grid[2][1].color+" | "+grid[3][1].color+" | "+grid[4][1].color+" | "+grid[5][1].color+" | "+grid[6][1].color+" | "
    puts "   -----------------------------"
    puts " 1 | "+grid[0][0].color+" | "+grid[1][0].color+" | "+grid[2][0].color+" | "+grid[3][0].color+" | "+grid[4][0].color+" | "+grid[5][0].color+" | "+grid[6][0].color+" | "
    puts "   -----------------------------"
    puts "     A   B   C   D   E   F   G"
  end

  # Returns cell at coordinate (x, y)
  def get_cell(x, y)
    grid[x][y]
  end

  # Sets color of cell (x, y)
  def set_cell(x, y, color)
    get_cell(x, y).color = color
    @last_cell_played = get_cell(x, y)
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
    @grid.each { |columns| columns.each { |cell| return false if cell.color == ' '}}
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
    cell = @last_cell_played
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
    cell = @last_cell_played
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
    cell = @last_cell_played
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
    cell = @last_cell_played
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

class Game
  attr_reader :players, :board, :current_player, :other_player

  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  # Asks the player to select a case and returns it
  def select_case
    puts"You turn, " + @current_player.name + ". Select a case:"
    loop do
      case_selected = gets.chomp.upcase
      return case_selected if handle_selection(case_selected)
    end
  end

  # Checks that the selected case is correct and can be played
  def handle_selection(input)
    cases = ['A1','A2','A3','A4','A5','A6',
             'B1','B2','B3','B4','B5','B6',
             'C1','C2','C3','C4','C5','C6',
             'D1','D2','D3','D4','D5','D6',
             'E1','E2','E3','E4','E5','E6',
             'F1','F2','F3','F4','F5','F6',
             'G1','G2','G3','G4','G5','G6']

    if !cases.include?(input)
      puts "Sorry I didn't understand. Which case ? (ex: a2, c3, b1)"
    elsif board.get_cell(to_coordinate(input)[0], to_coordinate(input)[1]).color != ' '
      puts "Case already played ! Select another one:"
    else
      return true
    end
    return false
  end

  # Launches the real game!
  def play
    puts "#{current_player.name} has randomly been selected as the first player"
    while true
      board.display
      puts ""
      array = to_coordinate(select_case)
      x, y = array[0], array[1]
      board.set_cell(x, y, current_player.color)
      result = board.game_over
      if result == :winner
        puts "Congratulation #{current_player.name} you won!"
        board.display
        return
      elsif result == :draw
        puts "No winners. Draw."
        return
      else
        switch_players
      end
    end
  end

  private

  # Maps the human response to the coordinate of the chosen cell
  def to_coordinate(human_move)
    mapping = {
      "A1"=>[0,0], "A2"=>[0,1], "A3"=>[0,2], "A4"=>[0,3], "A5"=>[0,4], "A6"=>[0,5],
      "B1"=>[1,0], "B2"=>[1,1], "B3"=>[1,2], "B4"=>[1,3], "B5"=>[1,4], "B6"=>[1,5],
      "C1"=>[2,0], "C2"=>[2,1], "C3"=>[2,2], "C4"=>[2,3], "C5"=>[2,4], "C6"=>[2,5],
      "D1"=>[3,0], "D2"=>[3,1], "D3"=>[3,2], "D4"=>[3,3], "D5"=>[3,4], "D6"=>[3,5],
      "E1"=>[4,0], "E2"=>[4,1], "E3"=>[4,2], "E4"=>[4,3], "E5"=>[4,4], "E6"=>[4,5],
      "F1"=>[5,0], "F2"=>[5,1], "F3"=>[5,2], "F4"=>[5,3], "F5"=>[5,4], "F6"=>[5,5],
      "G1"=>[6,0], "G2"=>[6,1], "G3"=>[6,2], "G4"=>[6,3], "G5"=>[6,4], "G6"=>[6,5]
    }
    mapping[human_move]
  end
end

flo = Player.new({color: "X", name: "flo"})
ginny = Player.new({color: "Y", name: "ginny"})
game = Game.new([flo, ginny])
game.play
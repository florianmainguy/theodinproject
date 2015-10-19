# Board

class Board
  attr_reader :grid

  def initialize(grid = nil)
    @grid = grid || default_grid
  end

  # Fill the board with all the pieces in their intitial location
  def default_grid
    array = Array.new(8) { Array.new(8) }

    array[0][0] = Rook.new('white', [0,0], 'slide')
    array[1][0] = Knight.new('white', [1,0], 'step')
    array[2][0] = Bishop.new('white', [2,0], 'slide')
    array[3][0] = Queen.new('white', [3,0], 'slide')
    array[4][0] = King.new('white', [4,0], 'step')
    array[5][0] = Bishop.new('white', [5,0], 'slide')
    array[6][0] = Knight.new('white', [6,0], 'step')
    array[7][0] = Rook.new('white', [7,0], 'slide')
    array[0..7].each_with_index { |column, index| 
                                   column[1] = Pawn.new('white', [index,1], 'step') }

    array[0][7] = Rook.new('black', [0,7], 'slide')
    array[1][7] = Knight.new('black', [1,7], 'step')
    array[2][7] = Bishop.new('black', [2,7], 'slide')
    array[3][7] = Queen.new('black', [3,7], 'slide')
    array[4][7] = King.new('black', [4,7], 'step')
    array[5][7] = Bishop.new('black', [5,7], 'slide')
    array[6][7] = Knight.new('black', [6,7], 'step')
    array[7][7] = Rook.new('black', [7,7], 'slide')
    array[0..7].each_with_index { |column, index| 
                                   column[6] = Pawn.new('black', [index,6], 'step') }

    array
  end

  # Display the board
  def display
    puts
    puts "   |---------------------------------------|"
    8.downto(1) do |row|
      print " #{row} | "
      8.times do |col|
        print grid[col][row-1] ? grid[col][row-1].unicode.encode('utf-8') : ' '
        print '  | '
      end
      puts
      puts "   |----|----|----|----|----|----|----|----|"
    end
    puts "     A    B    C    D    E    F    G    H"
    puts
  end

  # Return the piece selected
  def get_case(case_selected)
    grid[case_selected[0]][case_selected[1]]
  end

  # Fill the case given by the piece given
  def set_case(case_selected, piece)
    grid[case_selected[0]][case_selected[1]] = piece
    unless piece.nil?
      piece.location = case_selected
    end
  end
end
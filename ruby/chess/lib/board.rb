# -*- coding: utf-8 -*-
#
# Board

require_relative 'pieces.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = default_grid
  end

  # Fill the board with all the pieces in their intitial location
  def default_grid
    array = Array.new(8) { Array.new(8) }

    array[0][0] = Rook.new('white')
    array[1][0] = Knight.new('white')
    array[2][0] = Bishop.new('white')
    array[3][0] = Queen.new('white')
    array[4][0] = King.new('white')
    array[5][0] = Bishop.new('white')
    array[6][0] = Knight.new('white')
    array[7][0] = Rook.new('white')
    array[0..7].each { |column| column[1] = Pawn.new('white') }

    array[0][7] = Rook.new('black')
    array[1][7] = Knight.new('black')
    array[2][7] = Bishop.new('black')
    array[3][7] = Queen.new('black')
    array[4][7] = King.new('black')
    array[5][7] = Bishop.new('black')
    array[6][7] = Knight.new('black')
    array[7][7] = Rook.new('black')
    array[0..7].each { |column| column[6] = Pawn.new('black') }

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
  end
end
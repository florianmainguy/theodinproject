# Builds a function knight_moves that shows the simplest possible way for a chess board
# knight to get from one square to another. Outputs all squares the knight will stop on
# along the way.

class Node
  attr_accessor :current_case, :parent, :children

  def initialize(current_case, parent = nil)
    @current_case = current_case
    @parent = parent
    @children = []
  end
end

class Knight
  # Probabilities of displacement for the knight's next move
  def next_move(start)
    move = [[start[0] + 2, start[1] - 1], [start[0] + 2, start[1] + 1],
            [start[0] - 2, start[1] - 1], [start[0] - 2, start[1] + 1],
            [start[0] + 1, start[1] - 2], [start[0] + 1, start[1] + 2],
            [start[0] - 1, start[1] - 2], [start[0] - 1, start[1] + 2]]
  end
end

class Board
  def initialize
    @max_depth = 5
  end
  
  # Build a tree corresponding of all the next possible moves of a unit
  # Creates a child node if inside the chess board and not already visited
  # Stops at a depth of @max_depth
  def build_tree(unit, node, level = 0)
    return nil if level > @max_depth
  	
    unit.next_move(node.current_case).each do |next_case|
      next if next_case[0] < 0 || next_case[0] > 7 ||
              next_case[1] < 0 || next_case[1] > 7 
      
      next_node = Node.new(next_case, node)
      node.children << next_node

      build_tree(unit, next_node, level + 1)
    end      
  end

  # Estimates the easiest path for a unit to get to the target case
  # Uses breadth-first-search algorithm
  def moves(unit, start_case, target_case)
    root = Node.new(start_case)
    build_tree(unit, root)

    queue = [root]
    visited = [root.current_case]

    until queue[0].current_case == target_case
      queue[0].children.each do |child|
        queue << child unless visited.include?(child.current_case)
      end
      queue.shift
      visited << queue[0].current_case
    end

    get_path(queue[0], root)
  end

  # Prints the path taken to get to the target case
  def get_path(node, root)
    path = []
    until path.last == root.current_case
      path << node.current_case
      node = node.parent
    end

    puts "You made it in #{path.size - 1} moves! Here's your path:"
    path.reverse.each { |c| puts c.inspect }
  end
end

# Launches Board.moves specifically for the knight unit
def knight_moves(start_case, target_case)
  knight = Knight.new
  board = Board.new

  board.moves(knight, start_case, target_case)
end

knight_moves([3,3],[4,3])
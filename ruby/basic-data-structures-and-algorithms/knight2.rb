class Node
  attr_accessor :current_case, :parent, :children

  def initialize(current_case)
    @current_case = current_case
    @parent = []
    @children = []
  end
end

class Knight
	# Probabilities of displacement
	def next_move(start)
  	move = [[start[0] + 2, start[1] - 1], [start[0] + 2, start[1] + 1],
  					[start[0] - 2, start[1] - 1], [start[0] - 2, start[1] + 1],
  					[start[0] + 1, start[1] - 2], [start[0] + 1, start[1] + 2],
  				  [start[0] - 1, start[1] - 2], [start[0] - 1, start[1] + 2]]
	end
end

class Board
	def initialize
		@max_turns = 5
    @cases_visited = []
	end
  
  # Build a tree corresponding of all the next possible moves of a unit
  def build_tree(unit, node, level = 0)
  	return nil if level > @max_turns
  	
		unit.next_move(node.current_case).each do |next_case|
			next if next_case[0] < 0 || next_case[0] > 7 ||
              next_case[1] < 0 || next_case[1] > 7 ||
              @cases_visited.include?(next_case)
			
      @cases_visited << next_case

			next_node = Node.new(next_case)
			node.children << next_node
      next_node.parent << node

			build_tree(unit, next_node, level + 1)
    end      
  end

  # Estimates the easiest path for a unit to get to the target case
  def moves(unit, start_case, target_case)
    root = Node.new(start_case)
		build_tree(unit, root)

    queue = [root]
    visited = []
    path = []
    level = 0

    current_case = queue[0].current_case
    visited << current_case

    until current_case == target_case
      queue[0].children.each do |child|
        queue << child unless visited.include?(child)
      end
      queue.shift

      current_case = queue[0].current_case
      visited << current_case
    end

    tem = []
    while true
      tem << queue[0].current_case 
      break if queue[0].current_case == start_case
      queue[0] = queue[0].parent[0]
    end

    puts "You made it in #{tem.size} moves! Here's your path:"
    tem.each { |n| puts n }
	end
end

def knight_moves(start_case, target_case)
	knight = Knight.new
	board = Board.new

	node_target = board.moves(knight, start_case, target_case)
end

knight_moves([3,3],[4,3])
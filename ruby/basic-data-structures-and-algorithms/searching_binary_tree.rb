class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end
end

class Tree
  def initialize(data)
    @root = Node.new(data.shift)
    @node = Node.new(data.shift)
    build_tree(data, @root)
  end

  # Recursive way to build the binary tree
  # I decided to send an equal value of the current node on the left child
  def build_tree(data, par_node)
    return nil if data.empty?
  
    if @node.value <= par_node.value
      if par_node.left == nil
        par_node.left = @node
      else
        build_tree(data, par_node.left)
      end
    else
      if par_node.right == nil
        par_node.right = @node
      else
        build_tree(data, par_node.right)
      end
    end

    @node = Node.new(data.shift)
    build_tree(data, @root)
  end
  
  # Beginning the search by the root and the left leaves
  def breadth_first_search(target)
    queue = [@root]
    visited = []

    until queue.empty?
      node = queue[0]
      visited << node
      return "Found target: #{target} at node #{node}" if node.value == target
      if node.left && !visited.include?(node.left)
        queue << node.left
      end
      if node.right && !visited.include?(node.right)
        queue << node.right
      end
      queue.shift
    end
  end

  # Beginning the search by the root and the left leaves
  def depth_first_search(target)
    stack = [@root]
    visited = []

    until stack.empty?
      node = stack[-1]
      visited << node
      return "Found target: #{target} at node #{node}" if node.value == target
      if node.left && !visited.include?(node.left)
        stack << node.left
      elsif node.right && !visited.include?(node.right)
        stack << node.right
      else
        stack.pop
      end
    end
  end

  # Recursive way to do depth-first-search
  def dfs_rec(target, node = @root)
    return "Found target: #{target} at node #{node}" if node.value == target  # base case

    left_check = dfs_rec(target, node.left) if node.left
    right_check = dfs_rec(target, node.right) if node.right

    return left_check if left_check
    return right_check if right_check
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)

puts tree.inspect
puts tree.depth_first_search(67)
puts tree.breadth_first_search(67)
puts tree.dfs_rec(67)
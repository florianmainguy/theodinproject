class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value)
    @value = value
  end
end

class Tree
  def build_tree(data)
    data.each do |value| 
      node = Node.new(value)
    end
  end
end
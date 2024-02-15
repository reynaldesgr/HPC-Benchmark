class TreeNode
    attr_accessor :left, :right
  
    def initialize
      @left = nil
      @right = nil
    end
  end
  
  def make_tree(depth)
    return nil if depth <= 0
    node = TreeNode.new
    depth -= 1
    node.left = make_tree(depth)
    node.right = make_tree(depth)
    node
  end
  
  def check_tree(node)
    return 0 unless node
    1 + check_tree(node.left) + check_tree(node.right)
  end
  
  (0..45).each do |i|
    depth = 45
    tree = make_tree(depth)
    total_nodes = check_tree(tree)
    puts "Tree of depth #{depth} has #{total_nodes} nodes."
  end
  
# A path is made up of an array of Points.
class Path
  attr_accessor :nodes
  
  def initialize(array = nil)
    if array
      @nodes = array
    else
      @nodes = Array.new
    end
    
    @current_index = 0
  end
  
  def ==(other_path)
    if other_path == nil
      return false
    end
    
    if self.length != other_path.length
      return false
    end
    
    self.nodes.each_with_index do |x, i|
      if x != other_path.nodes[i]
        return false
      end
    end
    true
  end
  
  def copy
    p = Path.new
    @nodes.each do |n| p.add_node(n) end
    p
  end
  
  def add_node (node)
    @nodes.push(node)
    self
  end
  
  def << (node)
    self.add_node node
  end
  
  def <=> (other_path)
    self.cost_function <=> other_path.cost_function
  end
  
  def length
    if @nodes
      @nodes.length
    else
      0
    end
  end
  
  def to_s
    if @nodes
      @nodes.to_s
    end
  end
  
  def cost_function
    if @nodes 
      @nodes.length
    else
      0
    end
  end
  
  
  # helper method that returns a path from a single Point
  def self.path_from_point(p)
    path = Path.new
    path.add_node(p)
    path
  end
  
  # Returns the next node (Point) on the Path, and increments the counter
  def next!
    next_node = @nodes[@current_index]
    @current_index += 1
    next_node
  end
  
  def last_node
    @nodes.last
  end
  
  # Returns true if the point is present somewhere on the path
  def contains(point)
    @nodes.each do |n|
      if n == point
        return true
      end
    end
    false
  end
  
  # Returns the equivalent of <=> when given a Goal point, and another Path
  # If the distances are equal, we break ties by:
  # * choosing the right-most point
  # * then the up-most point (least y value)
  def distance_compare_function(goal, other_path)
    # puts "DEBUG: self=#{self}; distance_compare_function(goal=#{goal}, other_path#{other_path})"
    if self.last_node.distance_squared(goal) == other_path.last_node.distance_squared(goal)
      # puts "stop1"
      if self.last_node.x == other_path.last_node.x
        # puts "stop2"
        self.last_node.y <=> other_path.last_node.y 
      else
        # puts "stop3"
        other_path.last_node.x <=> self.last_node.x # order reversed, because we want the right-side first
      end
    else
      # puts "stop4"
      self.last_node.distance_squared(goal) <=> other_path.last_node.distance_squared(goal)
    end
  end
  
end

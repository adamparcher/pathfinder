require_relative 'point'
require_relative 'path'
require 'algorithms'

class PathFinder
  attr_reader :explored_nodes
  
  def initialize map
    @map = map
  end
  
  def find_path(p1, p2)
    goal = p2
    paths = [] # will be an array of Path objects
    p = Path.new
    p.add_node p1# The first path we start with is the current Agent position
    @explored_nodes = [p1]
    while p && p.last_node != goal do
      # puts "P: #{p}"
      # puts "P Last Node: #{p.last_node}"
      # puts "Paths: #{paths}"
      adjacent_nodes = @map.get_adjacent_nodes(p.last_node)
      # puts "adjacent_nodes: #{adjacent_nodes}"
      adjacent_nodes.each do |n| #     for each adjacent node N to P
        if !@explored_nodes.index n # if N is not already "visited" # TODO: Make this faster??
          p1 = p.copy #         new path P' = P << N
          p1.add_node(Point.new(n.x, n.y))
          paths << p1 #         add P' to PATHS
        end
      end
      # We're going to pop the LAST element off the paths array, so we want to sort in 
      # ascending order, using as our comparison the distance from the last point on the path 
      # to the goal node
      # Since we are just comparing relative values, don't need to calculate the real distance
      # Just calculate the distance squared as a proxy (because it's much faster to calculate)
      paths.sort! { |a, b| b.distance_compare_function(goal, a)}
      p = paths.pop  #   P = member of PATHS with least f(p)
      if p 
        @explored_nodes << p.last_node
      end
      # puts "Pop P: #{p}"
    end
    p
  end
  
  
  
end

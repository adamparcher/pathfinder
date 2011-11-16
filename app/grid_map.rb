require_relative 'point'

# Represents a map of squares that a path will be found on
class GridMap
  attr_reader :w, :h
  
  AGENT  = 'A'
  TARGET = 'T'
  WALL   = '#'
  BLANK  = ' ' 
  
  def initialize(map_as_string)
    @internal_map = []
    if !map_as_string || map_as_string.length < 1
      @w = 0
      @h = 0
    else
      lines = map_as_string.lines("\n")
      @w = lines.next.to_i
      line_num = 0
      begin
        while line = lines.next
            line.chars.each_with_index do |c, i|
            case c
            when AGENT
              @internal_map[line_num*@w + i] = AGENT
            when TARGET
              @internal_map[line_num*@w + i] = TARGET
            when WALL
              @internal_map[line_num*@w + i] = WALL
            else
              @internal_map[line_num*@w + i] = BLANK
            end
          end
          line_num += 1
        end
      rescue StopIteration
        ; # we cool
      end
      
      @h = line_num
    end
  end
  
  def add_object(grid_map_object)
    objects.push grid_map_object
  end
  
  
  # Returns an array of Points that are on the GridMap, adjacent to the Point provided
  def get_adjacent_nodes(point)
    adj = Array.new
    # puts "1"
    if on_grid_map?(point)
      points = [Point.new(point.x-1, point.y), 
        Point.new(point.x+1, point.y), 
        Point.new(point.x, point.y-1), 
        Point.new(point.x, point.y+1)]
      # puts "Points: #{points}"
      points.each do |p|
        # puts "Point: on map? #{on_grid_map? p}, contents - #{contents_at p}"
        if on_grid_map?(p) && contents_at(p) != WALL
          adj.push p
        end
      end
    end
    # puts "ADJ: #{adj}"
    adj
  end
  
  # Returns true if the Point provided is on the grid_map (and not out of bounds)
  def on_grid_map?(point)
    if !point || point.x < 0 || point.x >= @w || point.y < 0 || point.y >= @h
      return nil
    end
    true
  end
  
  # Returns the contents of the map (WALL, TARGET, etc.) at a given point
  def contents_at(point)
    # puts "MAP:\n#{@internal_map}\n\n\n"
    @internal_map[point.y*@w + point.x]
  end
  
  # Returns the coordinates as a Point, of the AGENT or Start node
  # If no start is found, returns nil
  def start
    @internal_map.each_with_index do |x, i|
      if x == AGENT then 
        return Point.new i % @w, (i/@w).to_i
      end
    end
    nil
  end
  
  # Returns the coordinates as a Point, of the TARGET or Goal node
  # If no goal is found, returns nil
  def goal
    @internal_map.each_with_index do |x, i|
      if x == TARGET then 
        return Point.new i % @w, (i/@w).to_i
      end
    end
    nil
  end
  
  # a String representation of the Map, including an optional path to overlay
  # The path will be displayed as PATH characters, but will not overlay AGENT or TARGET or WALL squares
  EXPLORED_NODE_CHAR = '.'
  PATH_CHAR = 'o'
  def to_s_with_path(path = nil, explored_nodes = nil)
    s = ""
    @internal_map.each_with_index do |x, i|
      if i > 0 && i % @w == 0
        s << "\n"
      end
      if x == BLANK
        if path && path.contains(Point.new(i % @w, (i/@w).to_i))
          s << PATH_CHAR
        elsif explored_nodes && explored_nodes.index(Point.new(i % @w, (i/@w).to_i))
          s << EXPLORED_NODE_CHAR
        else
          s << BLANK
        end
      else
        s << x
      end
    end
    s
  end
  
  # to_s is basically an alias for to_s_with_path but with no path
  def to_s
    to_s_with_path
  end
  
end
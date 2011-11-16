class Point
  attr_accessor :x, :y
  
  def initialize(x, y)
    @x = x
    @y = y
  end
  
  def to_s
    "{#{x}/#{y}}"
  end
  
  # compares equals
  def ==(other_point)
    sort_key == other_point.sort_key
  end
  
  # for sorting
  def <=>(other_point)
    sort_key <=> other_point.sort_key
  end
 
  
  # Defines an arbitrary value for sorting and comparison between two points
  def sort_key
    (1000000*@x) + @y
  end
  
  def distance_squared(p)
    (@x - p.x)*(@x - p.x) + (@y - p.y)*(@y - p.y)
  end
end
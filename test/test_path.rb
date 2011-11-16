require 'test/unit'
require 'path'
require 'point'

class TestPath < Test::Unit::TestCase
 
  def test_create_from_array
    path = Path.new [Point.new(1, 4), Point.new(5, 2), Point.new(8, 7)]
    assert_equal [Point.new(1, 4), Point.new(5, 2), Point.new(8, 7)], path.nodes
    assert_equal 3, path.length
    assert_equal Point.new(8, 7), path.last_node
  end
 
  def test_add_node
    path = Path.new
    assert_equal 0, path.length
    path.add_node Point.new(1, 4)
    assert_equal 1, path.length
    assert_equal Point.new(1, 4), path.last_node
    
    path.add_node Point.new(5, 2)
    assert_equal 2, path.length
    assert_equal Point.new(5, 2), path.last_node
    
    path.add_node Point.new(8, 7)
    assert_equal 3, path.length
    assert_equal Point.new(8, 7), path.last_node
  end
 
  def test_append
    path = Path.new
    assert_equal 0, path.length
    path << Point.new(1, 4) << Point.new(5, 2) << Point.new(8, 7)
    assert_equal [Point.new(1, 4), Point.new(5, 2), Point.new(8, 7)], path.nodes
    assert_equal 3, path.length
    assert_equal Point.new(8, 7), path.last_node
  end
 
  def test_contains
    path = Path.new
    path << Point.new(1, 4) << Point.new(5, 2) << Point.new(8, 7)
    assert path.contains(Point.new(1, 4))
    assert path.contains(Point.new(5, 2))
    assert path.contains(Point.new(8, 7))
    
    assert !path.contains(Point.new(3, 4))
    assert !path.contains(Point.new(10, 9))
  end

  # The expected behavior when finding a path is that, distance to goal point being equal, the path that 
  # moves to the side first will be chosen over a path moving up or down  
  def test_compare_function
    path_right = Path.new << Point.new(2, 2) << Point.new(3, 2)
    path_down = Path.new << Point.new(2, 2) << Point.new(2, 3)
    path_left = Path.new << Point.new(2, 2) << Point.new(1, 2)
    path_up = Path.new << Point.new(2, 2) << Point.new(2, 1)
    goal_lower_right = Point.new(5, 5)
    goal_upper_left = Point.new(0, 0)
    
    assert_equal 1, path_left.distance_compare_function(goal_lower_right, path_right) # path_right is closer to goal
    assert_equal 1, path_down.distance_compare_function(goal_lower_right, path_right) # equal distance, so prefer path_right
    assert_equal -1, path_right.distance_compare_function(goal_lower_right, path_down) # reverse of above
    
    assert_equal -1, path_up.distance_compare_function(goal_upper_left, path_down) # path_up is closer to goal
    # equal distance, so prefer path_up, since it is to the right of path_left
    assert_equal -1, path_up.distance_compare_function(goal_upper_left, path_left) 
    assert_equal 1, path_left.distance_compare_function(goal_upper_left, path_up) # reverse of above
    
    assert_equal -1, path_right.distance_compare_function(Point.new(2, 6), path_left) # equal distance between right/left, so prefer right
  end
end
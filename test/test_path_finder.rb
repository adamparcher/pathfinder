require 'test/unit'
require 'path_finder'
require 'point'

class TestPathFinder < Test::Unit::TestCase
  PRINT_RESULT_MAPS = false # for debugging

  def test_at_goal
    assert_correct_path(
      "4\n    ",
      Point.new(1, 1), 
      Point.new(1, 1),
      Path.new([Point.new(1, 1)]),
      [Point.new(1, 1)])
  end  
  
  def test_no_path
    # map looks like:   #####
    #                   #A#T#
    #                   #####
    assert_correct_path(
      "4\n#####\n#A#T#\n#####",
      Point.new(1, 1),
      Point.new(4, 1),
      nil,
      [Point.new(1, 1)])
  end
  
  
  def test_single_path
    # map looks like:   ####
    #                   #A##
    #                   # T#
    #                   ####
    assert_correct_path(
      "4\n####\n#A##\n# T#\n####", 
      Point.new(1, 1), 
      Point.new(2, 2), 
      Path.new([Point.new(1, 1), Point.new(1, 2), Point.new(2, 2)]),
      [Point.new(1, 1), Point.new(1, 2), Point.new(2, 2)])
  end
  
  
  def test_path_flat_map
    # map looks like:   #A   T#
    assert_correct_path(
      "7\n#A   T#", 
      Point.new(1, 0), 
      Point.new(5, 0), 
      Path.new([Point.new(1, 0), Point.new(2, 0), Point.new(3, 0), Point.new(4, 0), Point.new(5, 0)]),
      [Point.new(1, 0), Point.new(2, 0), Point.new(3, 0), Point.new(4, 0), Point.new(5, 0)])
  end
  
  
  def test_optimal_path1
    # map looks like:   #   #
    #                   #A# T
    #                   # # #
    #                   #   #
    assert_correct_path(
      "5\n#   #\n#A# T\n# # #\n#   #",
      Point.new(1, 1),
      Point.new(4, 1),
      Path.new([Point.new(1, 1), Point.new(1, 0), Point.new(2, 0), Point.new(3, 0),
        Point.new(3, 1), Point.new(4, 1)]),
      [Point.new(1, 1), Point.new(1, 0), Point.new(2, 0), Point.new(3, 0),
        Point.new(3, 1), Point.new(4, 1)])
  end
  
  def test_optimal_path2
    # map looks like:   #########
    #                   #       #
    #                   # A.... #
    #                   #     ..#
    #                   #      T#
    #                   #########
    assert_correct_path(
      "9\n#########\n#       #\n# A.... #\n#    #..#\n#      T#\n#########",
      Point.new(2, 2),
      Point.new(7, 4),
      Path.new([Point.new(2, 2), Point.new(3, 2), Point.new(4, 2), Point.new(5, 2), Point.new(6, 2),
        Point.new(6, 3), Point.new(7, 3), Point.new(7, 4)]),
      [Point.new(2, 2), Point.new(3, 2), Point.new(4, 2), Point.new(5, 2), Point.new(6, 2),
        Point.new(6, 3), Point.new(7, 3), Point.new(7, 4)])
  end
  
  # The expected behavior when finding a path is that, distance to goal point being equal, the path that 
  # moves to the side first will be chosen over a path moving up or down
  def test_move_right_first
    # map looks like:   #######
    #                   #     #
    #                   # A.  #
    #                   #  .. #
    #                   #   T #
    #                   #     #
    #                   #######
    assert_correct_path(
      "7\n#######\n#     #\n# A.  #\n#  .. #\n#   T #\n#     #\n#######",
      Point.new(2, 2),
      Point.new(4, 4),
      Path.new([Point.new(2, 2), Point.new(3, 2), Point.new(3, 3), Point.new(4, 3), Point.new(4, 4)]),
      [Point.new(2, 2), Point.new(3, 2), Point.new(3, 3), Point.new(4, 3), Point.new(4, 4)])
  end
  
  # helper method to test paths on maps
  def assert_correct_path(map_string, start, goal, expected, visited_nodes=nil)
    map = GridMap.new map_string
    pf = PathFinder.new map
    result = pf.find_path start, goal
    if PRINT_RESULT_MAPS then puts "result:\n#{map.to_s_with_path(result)}\n\n" end
    assert_equal expected, (pf.find_path start, goal)
    assert_equal visited_nodes, pf.explored_nodes
  end
end
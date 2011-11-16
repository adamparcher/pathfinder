require 'test/unit'
require 'grid_map'

class TestGridMap < Test::Unit::TestCase
 
  def test_blank_map
    map = GridMap.new ""
    assert_equal 0, map.h
    assert_equal 0, map.w
  end
  
  def test_single_cell
    map = GridMap.new "1\n#"
    assert_equal 1, map.h
    assert_equal 1, map.w
  end
  
  def test_small_map
    # map is just 4 walls: ##
    #                      ##
    map = GridMap.new "2\n##\n##"
    assert_equal 2, map.h
    assert_equal 2, map.w
    assert_equal GridMap::WALL, map.contents_at(Point.new(0, 0))
    assert_equal GridMap::WALL, map.contents_at(Point.new(1, 0))
    assert_equal GridMap::WALL, map.contents_at(Point.new(1, 1))
    assert map.on_grid_map?(Point.new(0, 0))
    assert map.on_grid_map?(Point.new(1, 1))
    assert !map.on_grid_map?(Point.new(1, 2))
    assert !map.on_grid_map?(Point.new(2, 1))
    assert !map.on_grid_map?(Point.new(-1, 1))
  end
  
  def test_map_with_stuff
    # map with some things: ####
    #                       #A##
    #                       # T#
    #                       ####
    map = GridMap.new "4\n####\n#A##\n# T#\n####"
    assert_equal 4, map.h
    assert_equal 4, map.w
    assert_equal GridMap::WALL, map.contents_at(Point.new(2, 1))
    assert_equal GridMap::AGENT, map.contents_at(Point.new(1, 1))
    assert_equal GridMap::TARGET, map.contents_at(Point.new(2, 2))
    assert_equal GridMap::BLANK, map.contents_at(Point.new(1, 2))
    assert map.on_grid_map?(Point.new(0, 0))
    assert map.on_grid_map?(Point.new(2, 3))
    assert !map.on_grid_map?(Point.new(4, 2))
    assert !map.on_grid_map?(Point.new(1, 6))
    assert !map.on_grid_map?(Point.new(7, 3))
    assert !map.on_grid_map?(Point.new(-1, 1))
  end
  
  
  def test_adjacent_nodes
    # map with some things:   ##
    #                       #A#
    #                       # T#
    #                       #  #
    map = GridMap.new "4\n  ##\n#A# \n# T#\n#  #"
    assert_equal [Point.new(1, 0)], map.get_adjacent_nodes(Point.new(0, 0))
    assert_equal 4, map.w
  end
  
  
  def test_find_start
    # map with some things: ####
    #                       #A##
    #                       # T#
    #                       ####
    map = GridMap.new "4\n####\n#A##\n# T#\n####"
    assert_equal Point.new(1, 1), map.start
    
    # map with some things: ####
    #                       # ##
    #                       # T#
    #                       ###A
    map = GridMap.new "4\n####\n# ##\n# T#\n###A"
    assert_equal Point.new(3, 3), map.start
    
    # map with some things: ####
    #                       # ##
    #                       # T#
    #                       ####
    map = GridMap.new "4\n####\n# ##\n# T#\n####"
    assert_equal nil, map.start
  end
  
  def test_find_goal
    # map with some things: ####
    #                       #A##
    #                       # T#
    #                       ####
    map = GridMap.new "4\n####\n#A##\n# T#\n####"
    assert_equal Point.new(2, 2), map.goal
    
    # map with some things: ####
    #                       # ##
    #                       # A#
    #                       ###T
    map = GridMap.new "4\n####\n# ##\n# A#\n###T"
    assert_equal Point.new(3, 3), map.goal
    
    # map with some things: ####
    #                       # ##
    #                       #  #
    #                       ####
    map = GridMap.new "4\n####\n# ##\n#  #\n####"
    assert_equal nil, map.goal
  end
  
  def test_to_s_with_path
    # Test with blank path, return should be just the map
    # map looks like:   #   #
    #                   #A# T
    #                   # # #
    #                   #   #
    map = GridMap.new "5\n#   #\n#A# T\n# # #\n#   #"
    assert_equal "#   #\n#A# T\n# # #\n#   #", map.to_s_with_path
    assert_equal map.to_s_with_path, map.to_s
  
    # Test with a path, A and T should be left, but dots should signify the path
    # map looks like:   #   #
    #                   #A# T
    #                   # # #
    #                   #   #
    map = GridMap.new "5\n#   #\n#A# T\n# # #\n#   #"
    pf = PathFinder.new map
    path = pf.find_path map.start, map.goal
    assert_equal "#ooo#\n#A#oT\n# # #\n#   #", map.to_s_with_path(path)
  end
  
  def test_to_s_with_path_and_explored_nodes
    # Test with a path, A and T should be left, but dots should signify the path
    # map looks like:   #   #
    #                   #A# T
    #                   # # #
    #                   #   #
    map = GridMap.new "5\n#   #\n#A# T\n# # #\n#   #"
    pf = PathFinder.new map
    path = pf.find_path map.start, map.goal
    explored_nodes = pf.explored_nodes
    puts "explored_nodes=#{explored_nodes}"
    assert_equal "#ooo#\n#A#oT\n# # #\n#   #", map.to_s_with_path(path, explored_nodes)
  end
 
end
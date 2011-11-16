require 'test/unit'
require 'point'

class TestPoint < Test::Unit::TestCase
 
  def test_basic_point
    p = Point.new 1, 4
    assert_equal 1, p.x
    assert_equal 4, p.y
  end
  
  def test_to_s
    p = Point.new 1, 4
    assert_equal "{1/4}", p.to_s
  end
  
  def test_equals
    assert_equal Point.new(1, 4), Point.new(1, 4)
    assert_not_equal Point.new(1, 4), Point.new(2, 3)
  end
  
  def test_compare
    assert_equal 0, (Point.new(1, 4) <=> Point.new(1, 4))
    assert_equal -1, (Point.new(1, 4) <=> Point.new(1, 8))
    assert_equal -1, (Point.new(1, 4) <=> Point.new(4, 0))
    assert_equal 1, (Point.new(2, 3) <=> Point.new(1, 4))
  end
  
  def distance_squared
    p1 = Point.new(1, 2)
    assert_equal 5, p1.distance_squared(Point.new(2, 4))
    assert_equal 25, p1.distance_squared(Point.new(5, 5))
    assert_equal 1, p1.distance_squared(Point.new(1, 1))
    assert_equal 5, p1.distance_squared(Point.new(0, 0))
  end
end
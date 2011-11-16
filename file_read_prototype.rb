AGENT = 'A'
TARGET = 'T'
WALL = '#'
BLANK = '.'

f = File.new('test_map.txt','r')
f.seek 0 # Go back to beginning, just for debugging

# Read width of map from first line
size_as_string = f.readline
width = size_as_string.to_i # it's assumed this width is accurate. If it's not, no guarantees...


map = Array.new  # screw 2d arrays
line_num = 0

while !f.eof? && line = f.readline
  line.chars.each_with_index do |c, i|
    case c
    when AGENT
      map[line_num*width + i] = AGENT
    when TARGET
      map[line_num*width + i] = TARGET
    when WALL
      map[line_num*width + i] = WALL
    else
      map[line_num*width + i] = BLANK
    end
  end
  line_num += 1
end

height = line_num

map
width
height

map.length
width*height
map.length == width*height


# Basic file to execute a thingy
class PathFinderGo
  def self.go(filename)
    f = File.new(filename,'r')
    f.seek 0 # Go back to beginning, just for the heck of it

    # read in the map
    map_string = f.read

    map = GridMap.new map_string
    pf = PathFinder.new map
    result = pf.find_path map.start, map.goal
    puts map.to_s_with_path(result, pf.explored_nodes)
  end
end



    

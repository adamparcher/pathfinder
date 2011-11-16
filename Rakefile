require 'rubygems'
require 'rake/testtask'
require_relative 'pf'

task :default => [:test]

$LOAD_PATH << File.dirname(__FILE__)
require 'app/point'
require 'app/path_finder'
require 'app/grid_map'
require 'app/path'


Rake::TestTask.new do |t|
  t.libs << "test" << "app"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :pf, :filename do |t, args|
  # puts "Args were: #{args}"
  filename = args['filename']
  # puts "Filename: #{filename}"
  PathFinderGo.go filename
end

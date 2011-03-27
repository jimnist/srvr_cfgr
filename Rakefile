#
# tasks for keeping server configs in synch
#

SERVER_TYPE = ENV['SERVER_CONFIG_SERVER_TYPE']

REPO_FILES_ROOT = File.join(Dir.pwd, 'servers', SERVER_TYPE, 'files')

require "./servers/#{SERVER_TYPE}/configuration.rb"
include Configuration

desc "gather config files into repo"
task :reap do
  puts "reaping #{SERVER_TYPE}"
  puts REPO_FILES_ROOT
  reap
end

desc "update config files and reset services"
task :sow do
  puts "sowing #{SERVER_TYPE}"
  sow
end

desc "update config files and reset services"
task :reload do
  puts "sowing #{SERVER_TYPE}"
  reload
end

desc "TODO:"
task :diff do
  puts "diffing #{SERVER_TYPE}"
  diff
end
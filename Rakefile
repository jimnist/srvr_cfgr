#
# tasks for keeping server configs in synch
#

SERVER_TYPE = ENV['SRVR_TYP']

raise "SRVR_TYP environment variable is not defined" 
  unless !SERVER_TYPE.nil?

REPO_FILES_ROOT = File.join(Dir.pwd, 'servers', SERVER_TYPE, 'files')

raise "SRVR_TYP is set but does not correspond to a propperly set up directory under 'servers'" 
  unless File.directory? REPO_FILES_ROOT

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

desc "reset services"
task :reload do
  puts "reloading #{SERVER_TYPE}"
  reload
end

desc "TODO:"
task :diff do
  puts "diffing #{SERVER_TYPE}"
  diff
end
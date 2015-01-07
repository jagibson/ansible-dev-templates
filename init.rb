#!/usr/bin/env ruby 
require 'fileutils'

def init_types 
  return  {
    "playbook" => [ 'playbook', 'localenv' ],
    "role" => [ 'role', 'localenv' ]
  }
end

def usage msg=""
  $stderr.puts msg if msg.length > 0
  $stderr.puts "Usage: #{File.basename $0} destination-path {#{init_types.keys.join('|')}}"
  exit 1
end

usage if ARGV.count != 2 

destination=File.expand_path(ARGV[0])
type=ARGV[1]

unless(init_types.keys.include? type)
  usage "Please choose a valid type " + 
        "(options are #{init_types.keys.join(', ')}; you provided #{type})" 
end

unless File.exists?(destination) and File.directory?(destination)
  usage "destination must exist and be a directory"
end

$stderr.puts "Initializing destination #{destination} for #{type} development"

Dir.chdir(File.dirname($0)) do
  init_types[type].each do |dir|
    Dir.chdir(dir) do 
      `find . -not -name '.' -and -not -name '..' -and -not -name '.keep'`.lines.map {|l| 
        l.strip
      }.each do |file|
        $stderr.puts "Syncing file #{file} to #{destination}"
        unless File.exists? File.join(destination,file)
          if File.directory?(file)
            $stderr.puts "\tCreating directory #{File.join(destination, file)}"
            FileUtils.mkdir_p File.join(destination, file ) 
          else 
            $stderr.puts "\tCreating directory #{File.join(destination, File.dirname(file))}"
            FileUtils.mkdir_p File.join(destination, File.dirname(file) ) 
            $stderr.puts "\tCopying file #{File.join(destination, file )}"
            FileUtils.cp file, File.join(destination, file ) 
          end
        end
      end
    end
  end
end

require_relative "file"
require_relative "watch"
require_relative "compiler"

module Whip end

# Watches files for changes in themselves or their dependencies, then parses
# and compiles it and fixes dependencies
class Whip::Watcher
    def initialize (files)
        @watches = Array.new
        files.each do |file|
            @watches.push(Whip::Watch.new(file))
        end
    end
    def watch
        puts "Watching, Press 'Ctrl-C' to stop..."
        while true
            @watches.each do |watch|
                if watch.check
                    watch.changeDeps(Whip::Compiler.new.compile(watch.file))
                    watch.modified
                    puts ">>> Modified! " + watch.file.path
                end
            end
        end
    end
end
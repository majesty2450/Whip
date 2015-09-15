require_relative "file"

module Whip end

# Indexes a directory to create a list of compilable files
class Whip::Indexer
    def initialize
        
    end
    # TODO: see parsing with errors and non-whip files for greater indexer
    # support
    def index (path = ".")
        files = Array.new
        # search path and fill with files
        Dir.foreach(path) do |entry|
            if File.file?(path + "/" + entry)
                if entry.length > 5 && entry[-5..-1] == ".whip"
                    files.push(Whip::File.new(path + "/" + entry, path + "/" + entry[0...entry.rindex(".")] + ".html"))
                end    
            end
        end
        return files
    end
end
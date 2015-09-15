require_relative "file"

module Whip end

# A bundle for watching whip files
class Whip::Watch
    def initialize (file)
        @file = file
        @deps = Array.new
        @file_mod = File::mtime(file.path)
        @deps_mod = Array.new
    end
    def changeDeps (deps)
        @deps = deps
        @deps_mod = Array.new
        @deps.each do |dep|
            @deps_mod.push(File::mtime(file.dir + dep))
        end
    end
    def modified
        @file_mod = File::mtime(@file.path)
    end
    def check
        change = false
        if @file_mod != File::mtime(@file.path)
            change = true
        end
        for i in 0...@deps.length
            mod = File::mtime(file.dir + @deps[i])
            if @deps_mod[i] != mod
                @deps_mod[i] = mod
                change = true
            end
        end
        return change
    end
    def file
        @file
    end
end

module Whip end

# A file has a path, an output path for compile, and a list of dependencies
class Whip::File
    def initialize (path, output_path = "")
        @path = path
        if output_path == ""
            if path.rindex(".")
                @output_path = path[0..path.rindex(".")] + "html"
            else
                @output_path = path + ".html"
            end
        else
            @output_path = output_path
        end
        @dependencies = Array.new
    end
    def path
        @path
    end
    def output_path
        @output_path
    end
    def setOutputPath (output_path, destroy)
        if destroy
            File.delete(@output_path)
        end
        @output_path = output_path
    end
    def dir
        directory = ""
        loop do
            directory = @path[0..@path.rindex("/")]
            break if File.directory?(directory)
        end
        return directory
    end
end
require_relative "cli/option"
require_relative "cli/flag"
require_relative "cli/argument"
require_relative "cli/parser"
require_relative "file"

module Whip end
module Whip::CLI end

# Option...
class Whip::CLI::OutputOption < Whip::CLI::Option
    def initialize
        super([
            Whip::CLI::Flag.new("-o"),
            Whip::CLI::Flag.new("--output")],
            "defines the compiled output paths",
            false)
    end
    def action (matches, parser)
        if @args.length == 0
            print "Error: Missing args ("
            @flags.each do |flag|
                print flag.name + " "
            end
            puts ")"
        end
    end
end

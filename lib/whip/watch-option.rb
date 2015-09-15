require_relative "cli/option"
require_relative "cli/flag"
require_relative "cli/argument"
require_relative "cli/parser"
require_relative "file"
require_relative "watcher"

module Whip end
module Whip::CLI end

# Option...
class Whip::CLI::WatchOption < Whip::CLI::Option
    def initialize
        super([
            Whip::CLI::Flag.new("-w"),
            Whip::CLI::Flag.new("--watch")],
            "recompiles files on dependency or file modification",
            true)
    end
    def action (matches, parser)
        if @args.length == 0
            print "Error: Missing args ("
            @flags.each do |flag|
                print flag.name + " "
            end
            puts ")"
        else
            output = nil
            matches.each do |match|
                if match.match(Whip::CLI::Flag.new("-o"))
                    output = match
                end
            end
            files = Array.new
            @args.each_with_index do |arg, index|
                if output && output.args.length > index
                    files.push(Whip::File.new(arg.value, output.args[index].value))
                else
                    files.push(Whip::File.new(arg.value))
                end
            end
            watcher = Whip::Watcher.new(files)
            watcher.watch
        end
    end
end

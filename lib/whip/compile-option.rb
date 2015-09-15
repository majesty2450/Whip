require_relative "cli/option"
require_relative "cli/flag"
require_relative "cli/argument"
require_relative "cli/parser"
require_relative "file"
require_relative "compiler"

module Whip end
module Whip::CLI end

# Option...
class Whip::CLI::CompileOption < Whip::CLI::Option
    def initialize
        super([
            Whip::CLI::Flag.new("-c"),
            Whip::CLI::Flag.new("--compile")],
            "compiles input as whip and outputs as html",
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
            compiler = Whip::Compiler.new
            if output
                @args.each_with_index do |arg, index|
                    if output.args.length > index
                        compiler.compile(Whip::File.new(arg.value, output.args[index].value))
                    else
                        compiler.compile(Whip::File.new(arg.value))
                    end
                end
            else
                @args.each do |arg|
                    compiler.compile(Whip::File.new(arg.value))
                end
            end
        end
    end
end

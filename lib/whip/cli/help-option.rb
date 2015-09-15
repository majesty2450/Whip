require_relative "option"
require_relative "flag"
require_relative "argument"
require_relative "parser"

module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################
class Whip::CLI::HelpOption < Whip::CLI::Option
    def initialize
        super([
            Whip::CLI::Flag.new("-h"),
            Whip::CLI::Flag.new("--help")],
            "displays useage information",
            true)
    end
    def action (matches, parser)
        if @args.length > 0             # TODO: fix spacing on args
            puts "Useage: "
            args.each do |arg|
                parser.options.each do |option|
                    print "\t"
                    use_option = false
                    option.flags.each do |flag|
                        if arg.value == flag.name[1..-1] || arg.value == flag.name[2..-1]
                            print flag.name + " "
                            use_option = true
                        end
                    end
                    if use_option
                        puts "\t" + option.description
                    end
                end
            end
        else
            puts "Useage:"
            parser.options.each do |option|
                print "\t"
                option.flags.each do |flag|
                    print flag.name + " "
                end
                puts "\t" + option.description
            end
        end
    end
end
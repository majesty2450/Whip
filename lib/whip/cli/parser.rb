require_relative "option"
require_relative "flag"
require_relative "argument"

module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################
class Whip::CLI::Parser
    def initialize (options)
        @options = options
    end
    def tokenize (args = ARGV)
        tokens = Array.new
        args.each do |arg|
            if arg[0] == "-" && arg[1] == "-"
                #tokens.push(Whip::CLI::Flag.new(arg[2..-1]))
                tokens.push(Whip::CLI::Flag.new(arg))
            elsif arg[0] == "-"
                #tokens.push(Whip::CLI::Flag.new(arg[1..-1]))
                tokens.push(Whip::CLI::Flag.new(arg))
            else
                tokens.push(Whip::CLI::Argument.new(arg))
            end
        end
        return tokens
    end
    def parse (tokens = tokenize)
        matches = Array.new
        tokens.each_with_index do |token, index|
            @options.each do |option|
                if option.match(token)
                    option.fill(tokens, index)
                    matches.push(option)
                end
            end
        end
        blocked = nil
        matches.each do |match|
            if blocked && match.blocking
                match.blockedAction(matches, self)
            else
                match.action(matches, self)
                if match.blocking
                    blocked = match
                end
            end
        end
    end
    def options
        return @options
    end
end
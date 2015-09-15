require_relative "flag"
require_relative "argument"

module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################
class Whip::CLI::Option
    def initialize (flags, description, blocking = false)
        @flags = flags
        @args = Array.new
        @used_flag = nil
        @description = description
        @blocking = blocking
    end
    def match (token)
        @flags.each do |flag|
            if flag == token
                return true
            end
        end
        return false
    end
    def fill (tokens, index)
        @used_flag = tokens[index]
        tokens = tokens[(index + 1)..-1]
        tokens.each do |token|
            if Whip::CLI::Flag == token.class
                break
            else
                @args.push(token)
            end
        end
    end
    def flags
        return @flags
    end
    def args
        return @args
    end
    def description
        return @description
    end
    def blocking
        return @blocking
    end
    def action (matches, parser)
        raise NotImplementedError
    end
    def blockedAction (matches, parser)
        puts "ERROR: Blocked Option (" + @used_flag.name + ")"
    end
end
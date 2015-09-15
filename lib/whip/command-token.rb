require_relative "token"

module Whip end

# All commands appear in the same way
class Whip::CommandToken < Whip::Token
    def initialize (pos)
        super(pos)
        @name = ""
        @argument = ""
        @indent = 0
    end
    def name= (name)
        @name = name
    end
    def argument= (arg)
        @argument = arg
    end
    def name
        @name
    end
    def argument
        @argument
    end
    def indent= (indent)
        @indent = indent
    end
    def indent
        @indent
    end
end
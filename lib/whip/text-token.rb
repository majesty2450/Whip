require_relative "token"

module Whip end

# Text that is not part of a command
class Whip::TextToken < Whip::Token
    def initialize (pos)
        super(pos)
    end
end
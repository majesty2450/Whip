
module Whip end

# Base token class
class Whip::Token
    def initialize (pos)
        @starts = pos
        @ends = pos
    end
    def ends= (pos)
        @ends = pos
    end
    def ends
        @ends
    end
    def starts
        @starts
    end
end
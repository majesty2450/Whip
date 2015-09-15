
module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################
class Whip::CLI::Argument
    def initialize (value)
        @value = value
    end
    def value
        @value
    end
    def == (other)
        if other.class.method_defined?("value") && other.value == @value
            return true
        else
            return false
        end
    end
end
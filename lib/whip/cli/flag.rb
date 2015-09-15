
module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################
class Whip::CLI::Flag
    def initialize (name)
        @name = name
    end
    def name
        @name
    end
    def == (other)
        if other.class.method_defined?("name") && other.name == @name
            return true
        else
            return false
        end
    end
end
require_relative "option"
require_relative "flag"
require_relative "argument"
require_relative "parser"

module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################
class Whip::CLI::VersionOption < Whip::CLI::Option
    def initialize (version)
        super([
            Whip::CLI::Flag.new("-v"), 
            Whip::CLI::Flag.new("--version")],
            "displays version number",
            true)
        @version = version
    end
    def action (matches, parser)
        puts "Version: " + @version
    end
end
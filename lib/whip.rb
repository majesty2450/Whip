require_relative "whip/cli/parser"
require_relative "whip/cli/version-option"
require_relative "whip/cli/help-option"
require_relative "whip/output-option"
require_relative "whip/compile-option"
require_relative "whip/watch-option"

module Whip end
module Whip::CLI end

###############################################################################
# 
###############################################################################

trap("INT") do
    interrupted = true
    puts "Exiting..."
    exit
end

Whip::CLI::Parser.new([
    Whip::CLI::VersionOption.new("0.1.0"),
    Whip::CLI::HelpOption.new,
    Whip::CLI::OutputOption.new,
    Whip::CLI::CompileOption.new,
    Whip::CLI::WatchOption.new
    ])
.parse















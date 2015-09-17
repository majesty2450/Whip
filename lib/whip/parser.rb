require_relative "file"
require_relative "token"
require_relative "text-token"
require_relative "command-token"

module Whip end

# Parses a given file by first tokenizing the string, then parsing and
# executing the command
class Whip::Parser
    module TokenStates
        TEXT_STATE = 0
        COMMAND_OPEN_STATE = 1
        COMMAND_NAME_STATE = 2
        COMMAND_ARGUMENT_STATE = 3
        COMMAND_ARGUMENT_START_STATE = 4
        COMMAND_CLOSE_STATE = 5
    end
    def initialize

    end
    # TODO: fix parse so as to work with errors properly
    def parse (file)
        File.open(file.path, "r") do |file|
            # read each char and use state
            tokens = Array.new
            state = TokenStates::TEXT_STATE
            input = ""
            last_newline = 0
            while file.eof? == false
                case state
                when TokenStates::TEXT_STATE
                    #puts "TEXT_STATE"
                    input = file.getc
                    if input == "<"
                        state = TokenStates::COMMAND_OPEN_STATE
                    elsif input == "\n"
                        last_newline = file.pos
                    else
                        if tokens.length == 0 || tokens.last.class != Whip::TextToken
                            tokens.push(Whip::TextToken.new(file.pos))
                        end
                    end
                when TokenStates::COMMAND_OPEN_STATE
                    #puts "COMMAND_OPEN_STATE"
                    pos = file.pos
                    input += file.getc
                    input += file.getc
                    input += file.getc
                    input += file.getc
                    if input == "<!--$"
                        state = TokenStates::COMMAND_NAME_STATE
                        if tokens.last.class != Whip::CommandToken
                            tokens.last.ends = pos
                        end
                        tokens.push(Whip::CommandToken.new(pos))
                        tokens.last.indent = pos - last_newline - 1
                        input = ""
                    else
                        state = TokenStates::TEXT_STATE
                        if tokens.length == 0
                            tokens.push(Whip::TextToken.new(pos))
                        end
                    end
                when TokenStates::COMMAND_NAME_STATE
                    #puts "COMMAND_NAME_STATE"
                    input += file.getc
                    if input[-1] == " "
                        state = TokenStates::COMMAND_ARGUMENT_START_STATE
                        tokens.last.name = input[0...-1]
                        input = ""
                    end
                when TokenStates::COMMAND_ARGUMENT_START_STATE
                    #puts "COMMAND_ARGUMENT_START_STATE"
                    input = file.getc
                    if input == '"'
                        state = TokenStates::COMMAND_ARGUMENT_STATE
                        input = ""
                    end
                when TokenStates::COMMAND_ARGUMENT_STATE
                    #puts "COMMAND_ARGUMENT_STATE"
                    input += file.getc
                    if input[-1] == '"'
                        state = TokenStates::COMMAND_CLOSE_STATE
                        tokens.last.argument = input[0...-1]
                        input = ""
                    end
                when TokenStates::COMMAND_CLOSE_STATE
                    #puts "COMMAND_CLOSE_STATE"
                    input += file.getc
                    if input.strip == "-->"
                        state = TokenStates::TEXT_STATE
                        tokens.last.ends = file.pos
                        input = ""
                    end
                else
                end
            end
            tokens.last.ends = file.pos + 1
            return tokens
        end
    end
end

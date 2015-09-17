require_relative "file"
require_relative "parser"
require_relative "token"
require_relative "text-token"
require_relative "command-token"

module Whip end

# Compiles a given file to an output
class Whip::Compiler
    def initialize
    end
    def compile (file, tokens = Whip::Parser.new.parse(file))
        deps = Array.new
        File.open(file.output_path, "w") do |fout|
            tokens.each do |token|
                case token
                when Whip::TextToken
                    # copy
                    File.open(file.path, "r") do |fin|
                        fin.seek(token.starts - 1, IO::SEEK_SET)
                        while fin.pos < token.ends - 1
                            fout.syswrite(fin.getc)
                        end
                    end
                when Whip::CommandToken
                    case token.name
                    when "include"
                        deps.push(token.argument)
                        File.open(file.dir + token.argument, "r") do |fin|
                            while fin.eof? == false
                                c = fin.getc
                                if c == "\n"
                                    fout.syswrite("\n" + " " * token.indent)
                                else
                                    fout.syswrite(c)
                                end
                            end
                            fout.syswrite("\n")
                        end
                    end
                end
            end
        end
        return deps
    end
end

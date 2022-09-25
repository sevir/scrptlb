require "lua"

class ShellLua
    include LuaCallable

    def initialize
        
    end

    # Executes the code in the shell
    # cancels with the first error returned
    def run (commands : String) : Bool
        last_result = true

        commands.each_line do |command|
            last_result = system "#{command}"
            return last_result unless last_result
        end

        return last_result
    end

    # Executes the code in the shell and gets the output
    def exec (commands : String) : String
        last_result = true
        total_output = IO::Memory.new
        
        commands.each_line do |command|
            begin
                output_io = IO::Memory.new
                error_io = IO::Memory.new
                
                status = Process.run(command, shell: true, output: output_io, error: error_io)

                total_output << error_io.to_s
                total_output << output_io.to_s

                puts total_output.to_s

                return total_output.to_s unless status.exit_code == 0
            rescue
                return total_output.to_s
            end            
        end

        total_output.to_s
    end
end
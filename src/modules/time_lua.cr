require "lua"
require "http/client"

class TimeLua
    include LuaCallable

    def initialize
        @format = "%Y-%m-%d %H:%M:%S %z"
    end

    # Waits seconds in the execution of the code
    def sleep (seconds : UInt32) : Nil
        system "sleep #{seconds}"
    end

    # Sets format string for getting current date time
    def set_format( format_string : String ) : Nil
        @format = format_string
    end

    # Outputs the current datetime using the format specified in the
    # System local time Zone
    def now() : String
        current_time = Time.local
        
        return current_time.to_s(@format)
    end
end
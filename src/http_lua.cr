require "lua"
require "http/client"

alias ReturnValue = Hash(String, Int32 | String)

class HttpLua
    include LuaCallable

    def initialize
        #@client = 
    end

    def get(url : String) :  ReturnValue
        response = HTTP::Client.get url
        return {
            "status" => response.status_code,
            "body" => response.body
        }
    end
end
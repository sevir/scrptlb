require "lua"
require "http/client"

alias ReturnValue = Hash(String, Int32 | String)

class HttpLua
    include LuaCallable

    def initialize
        @headers = {} of String => String
        @raw_data = ""
    end

    def clean
        @headers = {} of String => String
        @raw_data = ""
    end

    def get(url : String) :  ReturnValue
        response = HTTP::Client.get url
        return {
            "status" => response.status_code,
            "body" => response.body
        }
    end
    
    def add_header(key : String, value : String) : Nil
        @headers[key] = value
        return nil
    end

    def set_body(raw_data : String) : Nil
        @raw_data = raw_data
        return nil
    end

    def post(url : String) : ReturnValue
        body : HTTP::Client::BodyType = if @raw_data.empty?
            nil
        else
            @raw_data
        end

        if @headers.empty?
            response = HTTP::Client.post url, body: body
        else
            http_headers = HTTP::Headers.new
            @headers.each do |k, v|
                http_headers[k] = v
            end

            response = HTTP::Client.post url, headers: http_headers, body: body
        end
        
        return {
            "status" => response.status_code,
            "body" => response.body
        }
    end


end
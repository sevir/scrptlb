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

    # Request a url using GET method
    # ```
    # local request = http.get("http://www.google.com")
    # print(request["status"])
    # print(request["body"])
    #```
    def get(url : String) :  ReturnValue
        response = HTTP::Client.get url
        return {
            "status" => response.status_code,
            "body" => response.body
        }
    end
    
    # Add headers for POST requests
    # ```
    # http.add_header("Authorization", "Bearer mt0dgHmLJMVQhvjpNXDyA83vA_PxH23Y")
    # http.add_header("Content-Type", "application/json")
    # ```
    def add_header(key : String, value : String) : Nil
        @headers[key] = value
        return nil
    end

    # Set body of the request for POST requests
    # ```
    # http.set_body("Hello World")
    # ```
    def set_body(raw_data : String) : Nil
        @raw_data = raw_data
        return nil
    end

    # Set body of the request for POST requests
    # ```
    # local request = http.post("https://reqbin.com/echo/post/json") 
    # ```
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
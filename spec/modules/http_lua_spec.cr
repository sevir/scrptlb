require "../spec_helper"
require "../../src/modules/http_lua.cr"

describe HttpLua do
  stack = Lua.load
  stack.set_global "http", HttpLua.new

  it "http.get" do
    return_value = stack.run %q{
      local request = http.get("https://digio.es")
      return request["status"]
    }

    return_value.should eq(200)
  end

  it "http.post" do
    return_value = stack.run %q{
      http.add_header("Authorization", "Bearer mt0dgHmLJMVQhvjpNXDyA83vA_PxH23Y")
      http.add_header("Content-Type", "application/json")

      http.set_body("Hello World")
      local request = http.post("https://reqbin.com/echo/post/json")

      return request["status"]
    }

    return_value.should eq(200)
  end
end

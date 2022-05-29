require "lua"
require "./http_lua.cr"

# TODO: Write documentation for `Scrptlb`
module Scrptlb
  VERSION = "0.1.0"

  stack = Lua.load
  stack.set_global "http", HttpLua.new

  code = ENV["CODE"]?;

  if code
    stack.run code
  end

  # stack.run %q{
  #   local hello_message = table.concat({ 'Hello', 'from', 'Lua!' }, ' ')
  #   print(hello_message)

  #   local request = http.get("https://www.digio.es")
  #   print(request["status"])
  #   print(request["body"])
  # }
end

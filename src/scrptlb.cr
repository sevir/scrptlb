require "option_parser"
require "lua"
require "./modules/*"

# `Scrptlb` is "Scriptable" executor using lua 
module Scrptlb
  VERSION = "0.1.0"

  env_code_name = "CODE"

  OptionParser.parse do |parser|
    parser.banner = "Usage: scrptlb [arguments]"
    parser.on("-n NAME", "--name=NAME", "Change the CODE variable") { |name| env_code_name = name }
    parser.on("-h", "--help", "Show this help") do
      puts parser
      exit
    end
    parser.invalid_option do |flag|
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
  end

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

require "option_parser"
require "lua"
require "./modules/*"

# `Scrptlb` is "Scriptable" executor using lua 
module Scrptlb
  VERSION = "1.0.0"

  env_code_name = "CODE"
  file_code = "scrptlb.code.lua"

  OptionParser.parse do |parser|
    parser.banner = "Usage: scrptlb [arguments]"
    parser.on("-n NAME", "--name=NAME", "Change the CODE variable") { |name| env_code_name = name }
    parser.on("-f FILE", "--file=FILE", "Reads an specific lua code file") { |file| file_code = file }
    parser.on("-v", "--version", "Display version") do
      puts "scrptlb #{VERSION}"
      exit
    end
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
  # Loads modules
  stack.set_global "http", HttpLua.new
  stack.set_global "time", TimeLua.new
  stack.set_global "regex", RegexLua.new
  stack.set_global "shell", ShellLua.new

  code = ENV["CODE"]?;

  # If we have code in env variable, execute it 
  if code
    stack.run code
  end

  # IF file passed as parameter of scrptlb.code.lua by default, then execute it
  if !code && File.exists? "./#{file_code}"
    code = File.read "./#{file_code}"

    stack.run code
  end
end

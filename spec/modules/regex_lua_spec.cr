require "../spec_helper"
require "../../src/modules/regex_lua.cr"

describe RegexLua do
  stack = Lua.load
  stack.set_global "regex", RegexLua.new

  it "regex.match" do
    return_value = stack.run %q{
        return true
    }
    
    return_value.should eq(true)
  end

  it "regex.exec" do
    return_value = stack.run %q{
        return true
    }
    
    return_value.should eq(true)
  end
end
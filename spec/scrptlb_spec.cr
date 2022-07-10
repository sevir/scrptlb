require "./spec_helper"

describe Scrptlb do
  stack = Lua.load
  stack.set_global "http", HttpLua.new

  it "string" do
    return_value = stack.run %q{
      print("test")
      return "test"
    }

    return_value.should eq("test")
  end
end
